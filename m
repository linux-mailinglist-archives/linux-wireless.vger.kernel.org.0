Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56F108D4E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKYLy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 06:54:29 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:46280
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfKYLy3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 06:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574682868;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=RPWz9nO9IZFXf6ojtnISMP4vkbdmgCzEn0pao2zsMrc=;
        b=C5LJEJPLqPapmOffDLHTlzi/isqgWcTuwNu8aP34dry9HQ1Rd0i7Gn9hc1vGG7b6
        rE3zF62Ruz5taWoAst/bHZ7vlVEVi6yxEIOOUViCbkC9jlYdVojKDqkSVmODUG+RhtJ
        1DJIr329ZRzi6CN2/CV3k73Y/fFIzlKuYsCB5RL4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574682868;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=RPWz9nO9IZFXf6ojtnISMP4vkbdmgCzEn0pao2zsMrc=;
        b=AInkClFXJaiXgtdTnMfhvWq9Z369bIcWE6k3X/W1YL8+lsUojfnFN+zi92XB4H12
        94qFCQEHOR4CadzQEbG+JHe5BOldpAUszk2ZpDXIN9nXRjeTdZTVYho0Zn0s4ysjEb3
        qbxOtOsvu7wArySYk3WYEXM8sRdcTDq2wt9ulkDY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC002C447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add large size for BMI download data for SDIO
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191107100809.17982-1-wgong@codeaurora.org>
References: <20191107100809.17982-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ea269ba16-13158d2d-501c-4ac8-af8e-a2bd28333606-000000@us-west-2.amazonses.com>
Date:   Mon, 25 Nov 2019 11:54:28 +0000
X-SES-Outgoing: 2019.11.25-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Download firmware time cost of SDIO is too long, it is about 480ms,
> add large size 2048 bytes for BMI download for SDIO chip, its time
> cost will reduced to 240ms.
> 
> This will optimize the download firmware time cost.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d58f466a5dee ath10k: add large size for BMI download data for SDIO

-- 
https://patchwork.kernel.org/patch/11232449/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

