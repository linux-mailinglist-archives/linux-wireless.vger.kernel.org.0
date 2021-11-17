Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1B45420A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 08:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhKQHtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 02:49:24 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:22425 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhKQHtW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 02:49:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637135184; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=I5OOw4SM9yWpCwvl2NtPuiLV0r2JfBhwPewGvFBEsxk=;
 b=l6UQMnTjoDSjL7ZVvHw1bvx9hY/7HgLoKGjzqCI7/R/EsudqFx+N68BJo7Q1kcTMp5wXcDA1
 /ipPbo7eq+mOin48JNxngiWRqCpuUYgQAllhYuXq5v8ekJ1clcVl2aKPRDq5aCgZrsvYzJUw
 8rvHbcw5WKxMfLMqFt1qKt/t7wg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6194b350b920912d572a505e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 07:46:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D926C4360C; Wed, 17 Nov 2021 07:46:23 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D613EC4338F;
        Wed, 17 Nov 2021 07:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D613EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: fix destination monitor ring out of sync
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1637061007-28663-1-git-send-email-quic_kathirve@quicinc.com>
References: <1637061007-28663-1-git-send-email-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713517984.10263.11890947454711763377.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 07:46:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> More than 20000 PPDU id jumping causing status ring and destination
> ring processing not sync. The status ring is processed and the
> destination ring is not processed. Since destination is not reaped for
> so long, backpressure occurs at the destination ring.
> 
> To address this issue update the PPDU id with the latest PPDU, this
> will allow the destination ring to be reaped and will prevent the
> rings from getting out of sync.
> 
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Tested-on tag missing, please reply to this message and I can add it to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637061007-28663-1-git-send-email-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

