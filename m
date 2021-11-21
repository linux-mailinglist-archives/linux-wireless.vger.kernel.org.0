Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6745862E
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 20:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhKUTtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 14:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhKUTta (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 14:49:30 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F18C061574
        for <linux-wireless@vger.kernel.org>; Sun, 21 Nov 2021 11:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XegvGs2I3E25lv2LCvKxdVGRYF4fcnjvhT6dooagDkc=; b=dPBH3OAIF/dpnOCpnt71Frj8/V
        K5CNbfB9RlSQdDuvC543WVKzls87FuWki/iLn43hJu7h2/Fq7imlvyLmX6hBrqJpZsYkb+YRjWrsC
        fXttm7PTpPqsMab5bZEiU30Z+zfqbMMVSuAqWFYyEUmf8IuLg0J3JCXmze0ToBTAcWoI=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mosn7-0007qn-FU; Sun, 21 Nov 2021 20:46:21 +0100
Message-ID: <5251bf43-a980-3398-80d6-9689f0efc926@nbd.name>
Date:   Sun, 21 Nov 2021 20:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: Bug/Regression - Ralink RT2800 kernel deference issue since
 kernel 5.14
Content-Language: en-US
To:     Robert W <rwbugreport@lost-in-the-void.net>, xl@wp.pl
Cc:     linux-wireless@vger.kernel.org
References: <c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-12 22:21, Robert W wrote:
> Hi,
> 
> I have recently tried to upgrade a system to run the 5.14 kernel and
> noticed that I was getting hangs on the system which seem to relate to
> this wireless dongle which I am running hostapd against to provide a
> small AP. Since that time kernel 5.15 was released and I have tested
> that kernel as well and the problem persists.  The issue sometimes
> occurs within an hour and other times it takes a few hours. I have tried
> to narrow down what is causing the issue.  I thought it might be a
> change elsewhere outside the mac80211/driver area so I tried to run the
> wireless backports 5.15-rc6 on top of the last stable kernel of 5.13 so
> as to have the smallest number of changes on the system. The backports
> crashes with the same error.  I have included below the netconsole
> output and the gdb of the kernel module in question. The capture was
> from when I was using the backports, but the error  is the same.  I hope
> the pastebins are okay to use on the list.  I did try to get some
> assistance on linux-wireless IRC and some one asked for the outputs I
> had for the information so I am reusing them here.
> 
> The following pastebin is the data sent to a netconsole instance.
> 
> https://pastebin.com/UxRrTtUh
> 
> The gdb debug of the kernel module suggests this section of code.
> 
> https://pastebin.com/iMzxWEVU
> 
> I am able to run further tests if required.  I am not a programmer, but
> I can usually apply code patches and build the resulting code. Please
> let me know if require any further information.

Please try this patch:

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 278945e3e08a..e19f6e246642 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1822,15 +1822,15 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
  	ieee80211_tx_result res = TX_CONTINUE;
  
+	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
+		CALL_TXH(ieee80211_tx_h_rate_ctrl);
+
  	if (unlikely(info->flags & IEEE80211_TX_INTFL_RETRANSMISSION)) {
  		__skb_queue_tail(&tx->skbs, tx->skb);
  		tx->skb = NULL;
  		goto txh_done;
  	}
  
-	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
-		CALL_TXH(ieee80211_tx_h_rate_ctrl);
-
  	CALL_TXH(ieee80211_tx_h_michael_mic_add);
  	CALL_TXH(ieee80211_tx_h_sequence);
  	CALL_TXH(ieee80211_tx_h_fragment);

