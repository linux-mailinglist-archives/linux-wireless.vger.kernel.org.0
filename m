Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F875510F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 16:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfFYOGq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 10:06:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYOGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 10:06:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8387C6029B; Tue, 25 Jun 2019 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561471605;
        bh=cXRc0B/OOGCbX6QM2Qm2hXR9TSxjZMnQrVVkT9t0maY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YuCR9WfwOUb0KiWdIwLjteAx6nEhDnpikWFh0DTW38/qI/nXC/zxKKP2hRmQha2Rn
         jzK7zAJFY8o2kyky/RQ3tb/IIF8/If3N4kP7/VMorBrikxAg9ccYiKpeNXt/flvzaM
         r/GfAaqTeTwDUwt0iqznEuvJ19FwAYm7jWa85Lw8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30EB56016D;
        Tue, 25 Jun 2019 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561471605;
        bh=cXRc0B/OOGCbX6QM2Qm2hXR9TSxjZMnQrVVkT9t0maY=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ZtGvEBBcxSgVUDZJK3rMsvf+hFd1KL5hMUOnGnDqENAfW5UDM02iVvNebij6vbjll
         ouL7PtzpVIAIhdJAOTMbLv4TzGf3b/CldQ+1ovxms5EcxhdxQfJ0AEPnrRuFXYM//o
         Aab8+pDQk3G12YfLMJNoOtsdCtRCo79FwzwLxmuM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30EB56016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath10k: Enable MSA region dump support for WCN3990
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190610091759.29508-1-govinds@codeaurora.org>
References: <20190610091759.29508-1-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625140645.8387C6029B@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 14:06:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> MSA memory region caries the hw descriptors information.
> Dump MSA region in core dump as this is very helpful in debugging
> hw issues.
> 
> Testing: Tested on WCN3990 HW
> Tested FW: WLAN.HL.3.1-00959-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>

New warning:

drivers/net/wireless/ath/ath10k/snoc.c: In function 'ath10k_msa_dump_memory':
drivers/net/wireless/ath/ath10k/snoc.c:1662:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  hdr->start = cpu_to_le32(ar_snoc->qmi->msa_va);
                         ^

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10984519/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

