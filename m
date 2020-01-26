Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88B149B85
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAZPmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:42:18 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:10656 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgAZPmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:42:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053337; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=gMMWLj58u1EAUSxTPId3J+nPj43FUKWKNOoB+kY1XLk=;
 b=UWq2rgJO5JIopgvAaT/K3JyrLw71LgLB8wkoqVnLKRzV4BOm6Wj9/5Os8SPxeYRhYW41X/K8
 zIkaup1cK82DFitQIc7Az4D5EUWTuE8mnuklLG2gjqHKKukxmqO5GvfU/j0wcAywQyC4TS48
 oVAh8TWwG9rQnmjcdjdaqYgadXU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db358.7faf08ec1458-smtp-out-n03;
 Sun, 26 Jan 2020 15:42:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7CBDFC433A2; Sun, 26 Jan 2020 15:42:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FCBAC43383;
        Sun, 26 Jan 2020 15:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FCBAC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] brcmfmac: simplify building interface combinations
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191226133050.16838-1-zajec5@gmail.com>
References: <20191226133050.16838-1-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126154216.7CBDFC433A2@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:42:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Move similar/duplicated code out of combination specific code blocks.
> This simplifies code a bit and allows adding more combinations later.
> A list of combinations remains unchanged.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

2 patches applied to wireless-drivers-next.git, thanks.

24332f8068ff brcmfmac: simplify building interface combinations
20f2c5fa3af0 brcmfmac: add initial support for monitor mode

-- 
https://patchwork.kernel.org/patch/11310507/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
