Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35BE454314
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 09:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhKQI7H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 03:59:07 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:29717 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234712AbhKQI66 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 03:58:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637139360; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=aBn45QqAhQiM5PL3L6GAjgX7r0wnurx4OAUSnZ0zK+c=;
 b=ougJnIxoz67NDIUY1PPNG0+KYLd2z+XIvmear5tC7FLf3rQD201ktBYyRq+nkk+QnxtlW3ds
 oETws4orXrqs66ho+7n/yB5u0eEhSq3S5i+XHW48Jr+yojVStLFmkHM+S7b/2GDn2CTcLs5F
 kc49lNA2d8Z2XpzlODErdhOd7RU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6194c3591e1d2f5233e77543 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 08:54:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C57C3C43460; Wed, 17 Nov 2021 08:54:49 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25230C4338F;
        Wed, 17 Nov 2021 08:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 25230C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add read variant from SMBIOS for download board
 data
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211011082433.30415-1-wgong@codeaurora.org>
References: <20211011082433.30415-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713928364.10263.15372409026240983506.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 08:54:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> This is to read variant from SMBIOS such as read from DT, the variant
> string will be used to one part of string which used to search board
> data from board-2.bin.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

I'm dropping all patches listed below in one go. I didn't manage to
apply any of these without conflicts, please remember to always use
ath.git master branch as the baseline to avoid conflicts.

9 patches set to Changes Requested.

12549401 ath11k: add read variant from SMBIOS for download board data
12549415 ath11k: add wait operation for tx management packets for flush from mac80211
12549419 ath11k: change to treat alpha code na as world wide regdomain
12549431 ath11k: report rssi of each chain to mac80211
12549433 ath11k: Add signal report to mac80211 for QCA6390 and WCN6855
12549449 ath11k: report tx bitrate for iw wlan station dump
12554953 ath11k: add support for hardware rfkill for QCA6390
12583807 ath11k: add 11d scan offload support
12583809 ath11k: calculate the correct NSS of peer for HE capabilities

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211011082433.30415-1-wgong@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

