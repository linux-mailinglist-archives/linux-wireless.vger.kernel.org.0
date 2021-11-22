Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9C459749
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 23:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhKVWZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 17:25:03 -0500
Received: from lave.lost-in-the-void.net ([213.229.87.129]:40826 "EHLO
        lave.lost-in-the-void.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhKVWZC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 17:25:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by lave.lost-in-the-void.net (Postfix) with ESMTP id 09FC88025847
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 22:21:50 +0000 (GMT)
Authentication-Results: lave.lost-in-the-void.net (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=lost-in-the-void.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        lost-in-the-void.net; h=user-agent:message-id:references
        :in-reply-to:subject:subject:to:from:from:date:date
        :content-transfer-encoding:content-type:content-type
        :mime-version; s=dkim; t=1637619702; x=1638483703; bh=XoL56BWhDL
        hsaeO/k8nMfMYyaH4a/cD27KACaAZT7og=; b=PUzTFpK0hXUr6x8NpJBpC5vHGt
        oXGUNavmQ1pD/7zme4rZgdsiMAr5PKU/2Zq5hnAPjUN4cKSxfRK0oRr9wMhOyCIc
        G8PkBVHJ337zHefCrYo13J5GJwI6FZ7A1PqaRgktzzLW7t8fPbYrKbm4VeiBaxN0
        D4pk6BP4tlFrG5vu4=
X-Virus-Scanned: amavisd-new at lave.lost-in-the-void.net
Received: from lave.lost-in-the-void.net ([127.0.0.1])
        by localhost (lave.lost-in-the-void.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7zeE9kv36Zuz for <linux-wireless@vger.kernel.org>;
        Mon, 22 Nov 2021 22:21:42 +0000 (GMT)
Received: from lave.lost-in-the-void.net (localhost [127.0.0.1])
        by lave.lost-in-the-void.net (Postfix) with ESMTPSA id CF5F88025842;
        Mon, 22 Nov 2021 22:21:41 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 22 Nov 2021 22:21:41 +0000
From:   Robert W <rwbugreport@lost-in-the-void.net>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     stf_xl@wp.pl, linux-wireless@vger.kernel.org
Subject: Re: Bug/Regression - Ralink RT2800 kernel deference issue since
 kernel 5.14
In-Reply-To: <5251bf43-a980-3398-80d6-9689f0efc926@nbd.name>
References: <c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net>
 <5251bf43-a980-3398-80d6-9689f0efc926@nbd.name>
Message-ID: <14a6cc0af2b352fc7add49ad01184868@lost-in-the-void.net>
X-Sender: rwbugreport@lost-in-the-void.net
User-Agent: Roundcube Webmail
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

The patch did not want to apply without rejects. I manually edited the 
file in the patch and has been running for a couple of hours yesterday 
and for 8 hours so far today without issue. Yesterdays run was against 
the backports wireless code running on 5.13 and today's due to extra 
time was built and is running on 5.15.

Thanks for your assistance and I will report back should I notice any 
further issue(s) following the change.

---
Robert

  On 2021-11-21 19:46, Felix Fietkau wrote:

> On 2021-⁠11-⁠12 22:21, Robert W wrote:
> 
>> Hi,
>> 
>> I have recently tried to upgrade a system to run the 5.14 kernel and
>> noticed that I was getting hangs on the system which seem to relate to
>> this wireless dongle which I am running hostapd against to provide a
>> small AP. Since that time kernel 5.15 was released and I have tested
>> that kernel as well and the problem persists. The issue sometimes
>> occurs within an hour and other times it takes a few hours. I have 
>> tried
>> to narrow down what is causing the issue. I thought it might be a
>> change elsewhere outside the mac80211/⁠driver area so I tried to run 
>> the
>> wireless backports 5.15-⁠rc6 on top of the last stable kernel of 5.13 
>> so
>> as to have the smallest number of changes on the system. The backports
>> crashes with the same error. I have included below the netconsole
>> output and the gdb of the kernel module in question. The capture was
>> from when I was using the backports, but the error is the same. I hope
>> the pastebins are okay to use on the list. I did try to get some
>> assistance on linux-⁠wireless IRC and some one asked for the outputs I
>> had for the information so I am reusing them here.
>> 
>> The following pastebin is the data sent to a netconsole instance.
>> 
>> https://pastebin.com/UxRrTtUh [1] [1 [1]]
>> 
>> The gdb debug of the kernel module suggests this section of code.
>> 
>> https://pastebin.com/iMzxWEVU [2] [2 [2]]
>> 
>> I am able to run further tests if required. I am not a programmer, but
>> I can usually apply code patches and build the resulting code. Please
>> let me know if require any further information.
> 
> Please try this patch:
> 
> diff -⁠-⁠git a/⁠net/⁠mac80211/⁠tx.c b/⁠net/⁠mac80211/⁠tx.c
> index 278945e3e08a..e19f6e246642 100644
> -⁠-⁠-⁠ a/⁠net/⁠mac80211/⁠tx.c
> +++ b/⁠net/⁠mac80211/⁠tx.c
> @@ -⁠1822,15 +1822,15 @@ static int invoke_tx_handlers_late(struct 
> ieee80211_tx_data *tx)
> struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx-⁠>skb);
> ieee80211_tx_result res = TX_CONTINUE;
> + if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
> + CALL_TXH(ieee80211_tx_h_rate_ctrl);
> +
> if (unlikely(info-⁠>flags & IEEE80211_TX_INTFL_RETRANSMISSION)) {
> __skb_queue_tail(&tx-⁠>skbs, tx-⁠>skb);
> tx-⁠>skb = NULL;
> goto txh_done;
> }
> - if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
> -⁠ CALL_TXH(ieee80211_tx_h_rate_ctrl);
> -⁠
> CALL_TXH(ieee80211_tx_h_michael_mic_add);
> CALL_TXH(ieee80211_tx_h_sequence);
> CALL_TXH(ieee80211_tx_h_fragment);

  Links:
  ------
  [1] https://pastebin.com/UxRrTtUh [1]
  [2] https://pastebin.com/iMzxWEVU [2]

Links:
------
[1] https://pastebin.com/UxRrTtUh
[2] https://pastebin.com/iMzxWEVU
