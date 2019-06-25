Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFFA55011
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfFYNRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:17:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFYNRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:17:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6913260E5F; Tue, 25 Jun 2019 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468669;
        bh=KEJdrdhw6An0ZkLpTtNp8OmOcc9f2AmcB1N4w/cLrBM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QZzBlTOBeLujjyYTBkF2oS58pm0fSE1zwexWMFfSzSvFi9U2SCFsDaFcsQOQEi7EB
         LdRGFBtfoaqMmV4gZcvO6tuE1TpwojgWIsGDkxU1FNxEbyKCcWyDcK9XmLBD9G8Kuc
         TZbrHztdGd7LQ8RFCcVBe7anHXmKF6o/gTodF6KQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 108EF60DAD;
        Tue, 25 Jun 2019 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468667;
        bh=KEJdrdhw6An0ZkLpTtNp8OmOcc9f2AmcB1N4w/cLrBM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=BEU6vT+iQfNY84qci03bMADcGb0RrNMXWsxOlp3cLb4IO9oGhOhuLj+WSZO1vu42V
         JVtlQd/lkIrYGQh26s96kt8hKfzMIw2ZrnFgcysjG0VO8AbHIzsV+D59d8E9U9iGeK
         Irl6uVMrJQnqlKUlgpD91pyTfut2R5eC2ndY8w2Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 108EF60DAD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Add WMI diag fw logging support for WCN3990
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190401132202.29626-1-govinds@codeaurora.org>
References: <20190401132202.29626-1-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625131748.6913260E5F@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:17:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> Integrated WiFi chipset ex:WCN399x supports fw logging
> using WMI copy engine and shared mem DIAG based fw logging.
> By default shared mem DIAG based fw logging is enabled.
> To support WMI copy engine based fw logging add QMI
> control message to enable WMI copy engine based fw logging.
> 
> Enable WMI based fw logging using fw_diag_log module parameter.
> 
> insmod ath10k_core.ko fw_diag_log=1
> 
> DIAG utility(https://github.com/andersson/diag) implements extraction
> of diagnostics related messages between application processor and
> various subsystems while shared mem DIAG based fw logging is enabled.
> 
> Testing: Tested on WCN3990/QCA6174 HW
> Tested FW: WLAN.HL.3.1-00959-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d9e47698965d ath10k: Add WMI diag fw logging support for WCN3990

-- 
https://patchwork.kernel.org/patch/10879943/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

