Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2DC2FC1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfJAJNA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:13:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35180 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfJAJM7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:12:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B62A6081C; Tue,  1 Oct 2019 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921179;
        bh=o2fBJQf7T0Bw0NHEvTxAMIt1LKEn+JZwJRPhCKbsncg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EEDmvcGWst+F5cBWYAP+WxHbcVQ3t/1Bb1ybg1k5OOpoI8rZ6XbboVIkEDzEhgVCF
         9If0oR/xTQwm47AeeQSIvLx3EHskgPrQN1SAgDsGaUI1nlZPtwIrej4P80Sc9I6E6G
         FL7DjQ0i9GMa4X1X+LHjO0D3Ax3gqSnagvP/cMIk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34EAD6076C;
        Tue,  1 Oct 2019 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921178;
        bh=o2fBJQf7T0Bw0NHEvTxAMIt1LKEn+JZwJRPhCKbsncg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=HN5Dsf5Boe2KQadwe6QT8063vP0H3UUUtuy61w533tW8VmiVW4QmYMdF/rIytPxoF
         T0/2xYaY25QA9gqRv/xbmq7oJTk5CLrh1aC6Y/3LlVnETzzQ97bqlCcA5LdIJjoJud
         zjvKljjHrwYyQgAEFOce0+elO/F6oaA2UP0tMTV0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34EAD6076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 3/3] brcmfmac: add support for SAE authentication
 offload
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1557395332-41426-4-git-send-email-chi-hsien.lin@cypress.com>
References: <1557395332-41426-4-git-send-email-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001091259.0B62A6081C@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 09:12:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com> wrote:

> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> The firmware may have SAE authentication code built-in. This is
> detected by the driver and indicated in the wiphy features flags.
> User-space can use this flag to determine whether or not to provide
> the password material for SAE authentication in the nl80211 CONNECT
> command.
> 
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

Failed to apply, please rebase and resend.

Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c'
Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h'
error: Failed to merge in the changes.
Applying: brcmfmac: add support for SAE authentication offload
Using index info to reconstruct a base tree...
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
M	drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
Patch failed at 0001 brcmfmac: add support for SAE authentication offload
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10936953/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

