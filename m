Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3285F1D19DA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbgEMPs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 11:48:29 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59183 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389178AbgEMPs2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 11:48:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589384908; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=erXaHco75fJTxrMeOsFqv16ZcSBhLgGjXVCw9EInTJo=;
 b=cTyFS/9rZMH+PKRzpFl2xvQiZ2DfCE0e8C8+uJiuODHUnm85oxIyqFhFMCAcaF+s9MBdpbaU
 8EQsmu7iNv3+R4VkoMN95+LdzFfxgMTHuuMhxalHV86uAhi641Mmr0pErKHZgZ+wHul6cJNt
 EP/ora3kW2+Za3eXurhvdohi5hU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc16bc.7fb563215a40-smtp-out-n02;
 Wed, 13 May 2020 15:48:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25A04C433D2; Wed, 13 May 2020 15:48:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1A0EC433F2;
        Wed, 13 May 2020 15:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1A0EC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: fix WPA/WPA2-PSK 4-way handshake offload and
 SAE
 offload failures
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1589277788-119966-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1589277788-119966-1-git-send-email-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200513154812.25A04C433D2@smtp.codeaurora.org>
Date:   Wed, 13 May 2020 15:48:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> An incorrect value of use_fwsup is set for 4-way handshake offload for
> WPA//WPA2-PSK, caused by commit 3b1e0a7bdfee ("brcmfmac: add support for
> SAE authentication offload"). It results in missing bit
> BRCMF_VIF_STATUS_EAP_SUCCESS set in brcmf_is_linkup() and causes the
> failure. This patch correct the value for the case.
> 
> Also setting bit BRCMF_VIF_STATUS_EAP_SUCCESS for SAE offload case in
> brcmf_is_linkup() to fix SAE offload failure.
> 
> Fixes: 3b1e0a7bdfee ("brcmfmac: add support for SAE authentication offload")
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

Patch applied to wireless-drivers-next.git, thanks.

b2fe11f07773 brcmfmac: fix WPA/WPA2-PSK 4-way handshake offload and SAE offload failures

-- 
https://patchwork.kernel.org/patch/11542809/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
