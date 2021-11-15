Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF2D450133
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhKOJ0z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:26:55 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:58692 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237420AbhKOJ0O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:26:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636968196; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=s6J+gg4yoOyaJ5pPnJXVPKyqEH49tEu59umKQrzFlxc=;
 b=S8tY7hROIf1Fn1KHD7xsrSS9Jgt3wTkqHaTX3vokTYs52UN3CSxk0UhYbTlENbLC3y2GsLH8
 I/yu/8rQm+T7o753IBQ/H5IDHfI2zVl0Uk9BOsz9QtIhq9PSHT5pzxGQvoTi4aCl4yakpipA
 ByeataScuTPn23ky07eY9PL/ikA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61922703e10f164c25e383ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 09:23:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38FE1C4360C; Mon, 15 Nov 2021 09:23:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C277CC4338F;
        Mon, 15 Nov 2021 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C277CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath11k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE if NSS
 ratio enabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211013073704.15888-1-wgong@codeaurora.org>
References: <20211013073704.15888-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163696819170.13305.1691462288223846501.kvalo@codeaurora.org>
Date:   Mon, 15 Nov 2021 09:23:15 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When NSS ratio enabled reported by firmware, SUPPORTS_VHT_EXT_NSS_BW
> is set in ath11k, meanwhile IEEE80211_VHT_EXT_NSS_BW_CAPABLE also
> need to be set, otherwise it is invalid because spec in IEEE Std
> 802.11™‐2020 as below.
> 
> Table 9-273-Supported VHT-MCS and NSS Set subfields, it has subfield
> VHT Extended NSS BW Capable, its definition is:
> Indicates whether the STA is capable of interpreting the Extended NSS
> BW Support subfield of the VHT Capabilities Information field.
> 
> dmesg have a message without this patch:
> 
> ieee80211 phy0: copying sband (band 1) due to VHT EXT NSS BW flag
> 
> It means mac80211 will set IEEE80211_VHT_EXT_NSS_BW_CAPABLE if ath11k not
> set it in ieee80211_register_hw(). So it is better to set it in ath11k.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

78406044bdd0 ath11k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE if NSS ratio enabled

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211013073704.15888-1-wgong@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

