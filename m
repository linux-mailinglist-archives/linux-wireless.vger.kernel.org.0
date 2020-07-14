Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DF21ED2E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGNJuD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:50:03 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51875 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725952AbgGNJuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:50:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594720201; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NECF2HiM1OMpfcmbRJK6kxO11p9C4dJkZxRXbiCJxlI=;
 b=f+eLWkMA0d+Ro0K+q0O9W4x8JtXgEAlhAL4ybQBESsB2POS1s1bf01oFhQ53jlS4SiPasBdY
 ivSkqZpzw5f0i8nx9fZ8xsUOFdpsPxq1eQKZAmgT3wqEcoJfW1xze0sq+dxjERW/7TzO+5KX
 Mqe+3slUDnuj4ffhre/8FJDEZgo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f0d7fbdee6926bb4f0708bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:49:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E00BDC43387; Tue, 14 Jul 2020 09:49:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99DA0C433C8;
        Tue, 14 Jul 2020 09:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99DA0C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: reset SDIO bus on a firmware crash
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200622144851.165248-1-chi-hsien.lin@cypress.com>
References: <20200622144851.165248-1-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714094948.E00BDC43387@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 09:49:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> commit 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
> adds a reset function to recover firmware trap for PCIe bus. This commit
> adds an implementation for SDIO bus.
> 
> Upon SDIO firmware trap, do below:
>  - Remove the device
>  - Reset hardware
>  - Probe the device again
> 
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

Patch applied to wireless-drivers-next.git, thanks.

7836102a750a brcmfmac: reset SDIO bus on a firmware crash

-- 
https://patchwork.kernel.org/patch/11618057/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

