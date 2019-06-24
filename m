Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0050BD7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 15:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfFXNV5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 09:21:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfFXNV5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 09:21:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 984FD6137D; Mon, 24 Jun 2019 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382516;
        bh=tIZXXP5sDCIzVFCe0dNBZg8+6/Ude0OTdJIP3wehvkg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TZbTfULy5yVcBwoOsjn2lOAIcteO+06bvuSwGEhM1k/VK/1MifN5uCui9X/GsJo8J
         3JAwb+iWIJ9UHQG1ML9T5B/p1bw77xIO4qk6MSwEkrkTmkmRiacLqAeCHSvX59JNZM
         r8yPgMU/Y3RuyvndoTcg4kOBe8zQwuatXrqeLCAA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89C8560EA5;
        Mon, 24 Jun 2019 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382515;
        bh=tIZXXP5sDCIzVFCe0dNBZg8+6/Ude0OTdJIP3wehvkg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=TvtTB8X4fb4fEIzAd0zX3XcgkRNKzKHUkNEV9fgKOAP7QnLI+4s4BvopP/LrLP9Nz
         SlQ8YtF9XT/qS9IPHdn3VzMXH/prYcJgViUOlic5pop8+NllkuHTlJJjjh1PBN4FjQ
         QVkrOZ1Dufea6PQOCb2ZQNL25Zpe8uiUx4h4t3xQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89C8560EA5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] iwlwifi: change 0x02F0 fw from qu to quz
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190614084852.386-4-luca@coelho.fi>
References: <20190614084852.386-4-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190624132156.984FD6137D@smtp.codeaurora.org>
Date:   Mon, 24 Jun 2019 13:21:56 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Ihab Zhaika <ihab.zhaika@intel.com>
> 
> change the fw of 0x02F0 platform from qu to quz
> 
> Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

658521fc1bf1 iwlwifi: change 0x02F0 fw from qu to quz

-- 
https://patchwork.kernel.org/patch/10994727/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

