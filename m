Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80991304344
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 17:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404749AbhAZQAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 11:00:34 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:21939 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391644AbhAZQAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 11:00:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611676803; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=D2dYwY0j8YQkxzRXkt/Ed3HBmjzeivBITd/gB7C37GE=;
 b=qokRkrpOwxjZuhOJWl0vaLkvZmkcR53nhEBO7bS0vFjY6wysOjLeTP7KEvI8m4+pg4404i5n
 E7UXM1uDMHmb7vlihgFaoAvEYCWzwuSmni2elUXBpEtk+kAY16Bgd0duUZaG9bVCcPws1tl1
 XdPx/50fACK0akTXjfdHHrOruZw=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60103c5c5677aca7bdb1c658 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 15:59:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3D78C433CA; Tue, 26 Jan 2021 15:59:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41898C433C6;
        Tue, 26 Jan 2021 15:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41898C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Update tx descriptor search index properly
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
References: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210126155923.A3D78C433CA@smtp.codeaurora.org>
Date:   Tue, 26 Jan 2021 15:59:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> Tx descriptor search index field should be updated with hw peer id
> and not by AST Hash. Incorrect search index causes throughput degradation
> in all the platforms. so updated the search index field with hw peer id,
> which is a common change applicable for all the platforms.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Please reply to Peter's questions.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1608305041-21946-1-git-send-email-periyasa@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

