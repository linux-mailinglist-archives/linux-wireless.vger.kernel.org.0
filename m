Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9480461084
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 09:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbhK2Ixa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 03:53:30 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:62038 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbhK2Iv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 03:51:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638175691; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=BVkdizxMGUzPX0vzCoaUsTUyB1Nf13v6HhEZxZH+k0k=; b=fzSldWC7JdOmuaC53lqJByui8dvvckCIR4XaU4Z9iRSIjUbyGHE2s+mmFo72IsLCE1/S4uin
 J6KTTUZt9auh0vz90DlaPemAAdV0DLP3uoZxCgK6jFdJSDOGe8S2BB13Ki8KkPuCx5WRMNxG
 6C/ZAjPRDc7FUI2pceSQPx16aBI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61a493cb1abc6f02d048ed54 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 08:48:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06990C4361A; Mon, 29 Nov 2021 08:48:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 557C1C4338F;
        Mon, 29 Nov 2021 08:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 557C1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     max chee <maxchee@outlook.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "amitkarwar\@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017\@gmail.com" <ganapathi017@gmail.com>,
        "sharvari.harisangam\@nxp.com" <sharvari.harisangam@nxp.com>,
        "huxinming820\@gmail.com" <huxinming820@gmail.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "kuba\@kernel.org" <kuba@kernel.org>
Subject: Re: Heap based overflow in Marvell Wifi mwifiex_cfg80211_start_ap function
References: <SI2PR06MB4060AE27017D9205ADBC7140A3659@SI2PR06MB4060.apcprd06.prod.outlook.com>
Date:   Mon, 29 Nov 2021 10:48:05 +0200
In-Reply-To: <SI2PR06MB4060AE27017D9205ADBC7140A3659@SI2PR06MB4060.apcprd06.prod.outlook.com>
        (max chee's message of "Sun, 28 Nov 2021 19:28:19 +0000")
Message-ID: <87czmjgxfe.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

max chee <maxchee@outlook.com> writes:

> I found a possible heap-based overflow through code review in marvell wifi chip driver in Linux
> Kernel, allowing local users to cause a denial of service or possibly execute arbitrary code. Similar
> to CVE-2019-14814, I think that the bug can be triggered by sending crafted packet via netlink.
>
> I believe this belongs to the Linux Wireless mailing list
> (https://patchwork.kernel.org/project/linux-wireless/)

Please don't send HTML emails, our mailing lists drop them. I found this
from my spam folder just by accident.

> Description
>
>  
>
> ==========
>
>  
>
> [1]Heap Overflow in mwifiex_cfg80211_start_ap() function of Marvell Wifi Driver in Linux kernel
>
>  
>
>  
>
> The problem is inside mwifiex_cfg80211_start_ap() in
> drivers/net/wireless/marvell/mwifiex/cfg80211.c
>
>  
>
> There is a memcpy calls in this function to copy params->ssid without checking length. This
> would result in a heap overflow because params->ssid_len is from cfg80211_ap_settings which is
> from user space.
>
>  
>
>  
>
> Recommended Patch in drivers/net/wireless/marvell/mwifiex/cfg80211.c
>
>  
>
> =====
>
>  
>
> +                             if (ssid_len > IEEE80211_MAX_SSID_LEN) {
>
> +                             mwifiex_dbg(priv->adapter, ERROR, "invalid SSID - aborting\n");
>
> +                             return -EINVAL;
>
> +             }
>
>                 if (params->ssid && params->ssid_len) {
>
>                                 memcpy(bss_cfg->ssid.ssid, params->ssid, params->ssid_len);
>
>                                 bss_cfg->ssid.ssid_len = params->ssid_len;
>
>  
>
>  
>
>  
>
> Credit
>
>  
>
> ==========
>
>  
>
> This issue was discovered by Max Chee

Are you saying that cfg80211 does not check the SSID length from user
space? I would be very surprised about that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
