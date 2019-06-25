Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5075854F61
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfFYMyg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:54:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59098 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYMyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:54:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C0E466070D; Tue, 25 Jun 2019 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467274;
        bh=dsJbZ4vezWjBrvQo8nbQEM9bBb+TA4WNjY2o/eWWC6E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=d8G8dg+Hq6BVfdXEF+aznQpcS+QWjCeDBjZkiS42Mry/qIsuwNnSHH3v+zpW8lW30
         Duk4SomKhrnqWU6QfIDxkLaxcrDe6M71pHTzWcaKKcodxxCdolfw9gW8OJu0pdjBss
         FVhnlbitEefmprkL33kkE+fIQNPkZ6xbdEb4++z0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EA77601B4;
        Tue, 25 Jun 2019 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467273;
        bh=dsJbZ4vezWjBrvQo8nbQEM9bBb+TA4WNjY2o/eWWC6E=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=hrjatzPNWfi+A8gHtkLAO2J1lRvOuLnSnUitT9EQyvYIZ+muTyPPTUGz96rbmAiUq
         rP8utmMMdg2hvaSenHUMML/NU5gZMN9P6VVpcSXxHH1pGO/05qWoTb88iG/Uiv1RGE
         LwwgTddpPfBF+FHI8rS9hWvfdngLd8gbzT0k18as=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EA77601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: change firmware file name for UTF mode of SDIO/USB
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1557891047-16606-1-git-send-email-wgong@codeaurora.org>
References: <1557891047-16606-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625125434.C0E466070D@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 12:54:34 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Firmware name for UTF mode of SDIO has changed from utf-2.bin to
> utf-sdio-2.bin, so it need to change in ath10k, otherwise it will
> fail for UTF mode.
> 
> After change the name in ath10k, it will success for UTF mode of
> SDIO/USB.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

54f6643bf19e ath10k: change firmware file name for UTF mode of SDIO/USB

-- 
https://patchwork.kernel.org/patch/10944213/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

