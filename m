Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A10745EB92
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 11:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377069AbhKZKcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 05:32:08 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:42919 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377336AbhKZKaH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 05:30:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637922415; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=D36i+TEzYvAfF+8CwLgTruoyqqi5b/grJJSwC8YVulc=;
 b=vlvG2/+uQTJ1H7aKtcGVs4EDyhMaaMCzwGpdwVCKcC13XRFXUlBWBQ/JxShUyNYC+EjZSiWP
 FVYgwamAJ4ColJzhKTCSWJN3drRD29i9CF8wkiEUePySOI6/fCfygWK3NbjzJDepSYaLidTy
 1OhXo6pR0P/3xnzHrQEYFsCqJyc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61a0b66e465c4a723bef9616 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 10:26:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24338C4363B; Fri, 26 Nov 2021 10:26:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7042C4363B;
        Fri, 26 Nov 2021 10:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C7042C4363B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 1/2] dt: bindings: add new DT entry for ath11k PCI
 device
 support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1637839211-1503-1-git-send-email-akolli@codeaurora.org>
References: <1637839211-1503-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163792240626.28516.5997258436480035214.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 10:26:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
> Ath11k firmware uses host DDR memory, DT entry is used to
> reserve host DDR memory regions, send these memory base
> addresses using DT entries.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

Failed to apply, remember to use ath.git master branch as the baseline.

error: patch failed: drivers/net/wireless/ath/ath11k/core.h:194
error: drivers/net/wireless/ath/ath11k/core.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/mhi.c:339
error: drivers/net/wireless/ath/ath11k/mhi.c: patch does not apply
stg import: Diff does not apply cleanly

2 patches set to Changes Requested.

12638957 [v6,1/2] dt: bindings: add new DT entry for ath11k PCI device support
12638955 [v6,2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1637839211-1503-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

