Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96D13A81B9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhFOOGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 10:06:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34601 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhFOOGX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 10:06:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623765859; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IPC2L7Dcc2OzC+XpRNtoSBVEfo9Ysnw0qZQTrRJWwQ0=;
 b=pRve6A68WwFw62UnNla8ku8OVdhNNlFhBSmzEVyUMrc/AGPOQhZf+y+g/i0g3fh+cdfZmq7m
 ukOvMoP9G1ez7x/dhXQfd4FEF0h3nzh+8NqheNbPcZDcAjAeLsMvLwfdjRpTmCdP6aG3QxVV
 XzqXu4l4wAUwQS2FvIsyrxW/h1s=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60c8b3508491191eb3116dd1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 14:04:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32631C4338A; Tue, 15 Jun 2021 14:04:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8D49C433F1;
        Tue, 15 Jun 2021 14:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8D49C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: remove the repeated declaration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1622448459-50805-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1622448459-50805-1-git-send-email-zhangshaokun@hisilicon.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615140400.32631C4338A@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 14:04:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> Functions 'ath10k_pci_free_pipes' and 'ath10k_wmi_alloc_skb'
> are declared twice in their header file, so remove the repeated
> declaration.
> 
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a8b1de7f4f68 ath10k: remove the repeated declaration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1622448459-50805-1-git-send-email-zhangshaokun@hisilicon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

