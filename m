Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E204500FF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhKOJTY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:19:24 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:57100 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhKOJTX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:19:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636967785; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bpZL+q7ylYqfWYa50owNWfgHuEbTwHQmE4pl0+BxEpM=;
 b=oiP4jRCyeqXVXvIuRGpSNH8e5WP0APyu90HT9CBywhJwHY222r6vLzQDDBzk3Yr4d1oHbjCT
 D/OXMmyagApE7p8d8Dp0+AJclNmoV+FtKzhooxDamQOusc5ZToFTt0n5U98Tz93B1GrUaoX6
 QUBsfYudFC9IMBxLwi0mE+Z4/jg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 619225684db4233966929377 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 09:16:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8FB0C43617; Mon, 15 Nov 2021 09:16:24 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42456C4338F;
        Mon, 15 Nov 2021 09:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 42456C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: avoid unnecessary BH disable lock in STA kickout
 event
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1636560388-24955-1-git-send-email-quic_periyasa@quicinc.com>
References: <1636560388-24955-1-git-send-email-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163696778139.20888.10875511119499508444.kvalo@codeaurora.org>
Date:   Mon, 15 Nov 2021 09:16:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> In STA kickout event processing, the peer object is protected
> under spin lock BH. Release this lock after picking up the vdev_id
> from the peer object instead after ieee80211_report_low_ack().
> This will minimize the lock hold period which will improve
> performance since base_lock is used across the data path.
> This was found in code review.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3 v2
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4c375743c5fe ath11k: avoid unnecessary BH disable lock in STA kickout event

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1636560388-24955-1-git-send-email-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

