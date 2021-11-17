Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD924541D7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 08:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhKQHcs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 02:32:48 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:32284 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhKQHcr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 02:32:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637134189; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ZTB3DGghBHlj4adoWTnW1txeicALz4uMJz/+2sc1k1E=;
 b=caRfz3zFIU7u4nWwZNO8+jlwat30PqTcUrZgXtePYFoyL9yWART9uSNb5DNo1ORAOC+X//ka
 brMyaBoGnldczSuOgiSV7ivAyb01A5xLw99v5Ffo0ViYFCoRLyUlv6ueILm4GxDk935WFkt8
 KmKWK1cEqX+Fc3eLJEWt7ytnZSk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6194af6cb920912d57243bbc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 07:29:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C190C43460; Wed, 17 Nov 2021 07:29:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D8B5C4338F;
        Wed, 17 Nov 2021 07:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0D8B5C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add trace log support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1636439755-30419-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1636439755-30419-1-git-send-email-quic_vnaralas@quicinc.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713417889.31320.8189579342269015463.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 07:29:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <quic_vnaralas@quicinc.com> wrote:

> This change is to add trace log support for,
>         * WMI events
>         * WMI commands
>         * ath11k_dbg messages
>         * ath11k_dbg_dump messages
>         * ath11k_log_info messages
>         * ath11k_log_warn messages
>         * ath11k_log_err messages
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00652-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fb12305aff12 ath11k: add trace log support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1636439755-30419-1-git-send-email-quic_vnaralas@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

