Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC1B9CC0
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 08:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437035AbfIUGsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 02:48:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436964AbfIUGsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 02:48:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 34C1760863; Sat, 21 Sep 2019 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569048525;
        bh=aHeEaDJt/JsylAkdqSShbYOzs3ga1rwWccKp+1RXgsE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mQxeUMI9iiegkU1zLT9uVSNzonIMYEu9Jp86FoT+4MuYDha/4zVA/GaUzJwQn1hW+
         wbp/Qg87gjlUmv8u4ihQm0frH/JFKREhNPwUAkgJ7ErVvKT/xMJ9OeZzYJ5xU1doev
         n0RByqE19w72v/W6gMW+GqLNMilZ7dwRRbQtWn7s=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D630A60736;
        Sat, 21 Sep 2019 06:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569048524;
        bh=aHeEaDJt/JsylAkdqSShbYOzs3ga1rwWccKp+1RXgsE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=kr6bOU3OACUbG0wDQ0EiwMXHz6bClansUTkD5cYQldV8L/pOaw2kDGLs+zZNxatVI
         9XhqgUKw7kIIwyxh3lCsjgEYwXFLx1O2r8phS1VhKd0Jf39PoNJHLoyMKcP/BzyjbF
         zV1KRd+Y4K2NMrwBiP+2eXVP0sSO9/Jrm+8tvy7E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D630A60736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] ath10k: Enable MSA region dump support for WCN3990
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190709053617.32042-1-govinds@codeaurora.org>
References: <20190709053617.32042-1-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190921064845.34C1760863@smtp.codeaurora.org>
Date:   Sat, 21 Sep 2019 06:48:45 +0000 (UTC)
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
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3f14b73c3843 ath10k: Enable MSA region dump support for WCN3990

-- 
https://patchwork.kernel.org/patch/11036163/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

