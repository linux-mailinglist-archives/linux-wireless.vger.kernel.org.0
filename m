Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A78246842
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgHQOTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 10:19:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:36714 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728765AbgHQOTp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 10:19:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597673984; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/7zymGBTZtzqMzjA3SFcVGNGjCCtPck3dXUGyjdrbeg=;
 b=RrjMjLwBSc6Ou8ZlOgfECFFttYbWJoWarCLgCg0IBP545BQxpA8KlVhmtFzR00qE1kcV65Qx
 FIXOGpEYmRfR21n+uWUmGiBjXtxvQIYHTHj1dEDm/4cM00an8sG637tYkowjkGPm7xEdsJuQ
 n71Wm3BF+JpKXCI0RGMQgJ8pRoM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f3a91f7d96d28d61ec81777 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 14:19:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A251FC43387; Mon, 17 Aug 2020 14:19:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15647C433CA;
        Mon, 17 Aug 2020 14:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15647C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 3/4] ath10k: Add new api to support TID specific
 configuration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1593875614-5683-4-git-send-email-tamizhr@codeaurora.org>
References: <1593875614-5683-4-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200817141934.A251FC43387@smtp.codeaurora.org>
Date:   Mon, 17 Aug 2020 14:19:34 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam <tamizhr@codeaurora.org> wrote:

> This patch add ops for set_tid_config to support TID
> specific configuration. Station specific TID configuration
> will have more priority than vif specific TID configuration.
> WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT service flag introduced
> to notify host for TID config support. And RTS_CTS extended tid
> configuration support advertised through the service flag
> WMI_10_4_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT.
> 
> TID specific noack configuration requires
> aggregation should be disabled and rate for the data TID packets
> should be basic rates. So, if the TID already configured
> with noack policy then driver will ignore the aggregation
> or TX rate related configuration for the same data TID.
> 
> In TX rate configuration should be applied with highest
> preamble configuration(HT rates should not be applied
> for the station which supports vht rates).
> 
> Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00021
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

There few checkpatch warnings which I fixed and also I did some whitespace
changes to improve readability. Others were trivial but please check carefully
this change and let me know if it's ok:

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7089,6 +7089,7 @@ static void ath10k_sta_tid_cfg_wk(struct work_struct *wk)
        bool config_apply;
        int ret, i;
        u32 changed;
+       u8 nss;
 
        arsta = container_of(wk, struct ath10k_sta, tid_config_wk);
        sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
@@ -7138,9 +7139,12 @@ static void ath10k_sta_tid_cfg_wk(struct work_struct *wk)
 
                if (changed & (BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
                    BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE))) {
-                       if (arvif->rate_ctrl[i] > WMI_TID_CONFIG_RATE_CONTROL_AUTO &&
-                           ath10k_mac_validate_rate_mask(ar, sta, arvif->rate_code[i],
-                                                         ATH10K_HW_NSS(arvif->rate_code[i]))) {
+                       nss = ATH10K_HW_NSS(arvif->rate_code[i]);
+                       ret = ath10k_mac_validate_rate_mask(ar, sta,
+                                                           arvif->rate_code[i],
+                                                           nss);
+                       if (ret &&
+                           arvif->rate_ctrl[i] > WMI_TID_CONFIG_RATE_CONTROL_AUTO) {
                                arg.rate_ctrl = 0;
                                arg.rcode_flags = 0;
                        }

-- 
https://patchwork.kernel.org/patch/11643787/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

