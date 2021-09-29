Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96841BD4D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 05:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhI2DVr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 23:21:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64016 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243917AbhI2DVq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 23:21:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632885606; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sY7hQoJt2ylgvIk5pkR7uTnciIBjd6B0lWCPJ68j/GE=;
 b=CB/3UjGUvc7S2N49o168bzP9c9+cVR6VlJVPsY3BPpkK1JFtfHkCMP3hig3fabHGtl30XMP6
 cxeF00IkSjVUPwYc6T1jdXnYKi6X9mkKeC3mM/+LSILcKRnD36CMRefsBjrRvoLBuVJKVhAh
 fwglJv2K3X56+kfuuMulykrj6FY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6153db62605ecf100bdfaf81 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Sep 2021 03:20:02
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6F26C43635; Wed, 29 Sep 2021 03:20:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 182C6C43460;
        Wed, 29 Sep 2021 03:20:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Sep 2021 11:20:01 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mac80211: do intersection with he mcs and nss set
 of peer and own
In-Reply-To: <b6c96c4ecdf9ec175d7f89e8600fb53768287cc2.camel@sipsolutions.net>
References: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
 <1609816120-9411-3-git-send-email-wgong@codeaurora.org>
 (sfid-20210105_041051_256789_4F276B28)
 <b6c96c4ecdf9ec175d7f89e8600fb53768287cc2.camel@sipsolutions.net>
Message-ID: <facd18458a7ecfc0afbfd06c8a57d849@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-28 21:02, Johannes Berg wrote:
> Hi,
> 
> 
> I had done a bunch of fixups to this patch, but the zero-day build 
> robot
> correctly reports that:
> 
>> +	ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80,
>> +				      &he_cap->he_mcs_nss_supp.rx_mcs_80,
>> +				      &own_he_cap.he_mcs_nss_supp.tx_mcs_80,
>> +				      &he_cap->he_mcs_nss_supp.tx_mcs_80);
> 
> the &own_he_cap... parts here will take an __le16 pointer to a possibly
> unaligned variable - any thoughts how we could fix that?
> 
Hi Johannes,

Add "__packed" before the "__le16 *" should solve this warning by my 
understand like this:

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index c05af7018f79..960fea9646b0 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -52,7 +52,7 @@ ieee80211_update_from_he_6ghz_capa(const struct 
ieee80211_he_6ghz_capa *he_6ghz_
         sta->sta.he_6ghz_capa = *he_6ghz_capa;
  }

-static void ieee80211_he_mcs_disable(__le16 *he_mcs)
+static void ieee80211_he_mcs_disable(__packed __le16 *he_mcs)
  {
         u32 i;

@@ -60,8 +60,8 @@ static void ieee80211_he_mcs_disable(__le16 *he_mcs)
                 *he_mcs |= cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 
i * 2);
  }

-static void ieee80211_he_mcs_intersection(__le16 *he_own_rx, __le16 
*he_peer_rx,
-                                         __le16 *he_own_tx, __le16 
*he_peer_tx)
+static void ieee80211_he_mcs_intersection(__packed __le16 *he_own_rx, 
__packed __le16 *he_peer_rx,
+                                         __packed __le16 *he_own_tx, 
__packed __le16 *he_peer_tx)
  {
         u32 i;
         u16 own_rx, own_tx, peer_rx, peer_tx;



net/mac80211/he.c:158:33: warning: taking address of packed member 
'rx_mcs_80' of class or structure 'ieee80211_he_mcs_nss_supp' may result 
in an unaligned pointer value [-Waddress-of-packed-member]

> johannes
