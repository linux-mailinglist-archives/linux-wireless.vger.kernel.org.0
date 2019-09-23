Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E37BAF80
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438621AbfIWI1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 04:27:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438612AbfIWI1s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 04:27:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F777614DC; Mon, 23 Sep 2019 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569227267;
        bh=mhS2G1AyLYaE6VeS+sQ3EeUrgEn1W/JYE/0x6MosluQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MFkUGX7hBIXGtgORz1V4Eplf9H1ofwqqAypKWlg5sUv5pRNnnf96Hxl5UIzqlWvpy
         usHaRTGu7o1L5kHCQ6ZiUKoFOqQMEnBj3jNBxN7RJEX+0BE+OCm2N0xFjwvUgstdmL
         5CbNMklmS/AJumYNtcJTXiCW2kKGAu0zg68FzJqY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D31046074F;
        Mon, 23 Sep 2019 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569227266;
        bh=mhS2G1AyLYaE6VeS+sQ3EeUrgEn1W/JYE/0x6MosluQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=RPI8wiYVyXDmKKZULb5OEOUbxwm7ut3W+Ykam2qjnYP/1Weus7Wo8XBdQgL+DlBTg
         s3IvZj/QzxCmFw0XmwG+G3AcNCfx7eKLJX+Vmyd93m4L28bR+D0w75WlDflUkktk5z
         14oB12kG6vTLgelYQcU2GlswIS6Z7kJGmDyj9TnA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D31046074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: remove the warning of sdio not full support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1567767301-22940-1-git-send-email-wgong@codeaurora.org>
References: <1567767301-22940-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190923082747.1F777614DC@smtp.codeaurora.org>
Date:   Mon, 23 Sep 2019 08:27:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> Recently, it has the basic feature of sdio tested success, so remove
> it.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

35cc054d944e ath10k: remove the warning of sdio not full support

-- 
https://patchwork.kernel.org/patch/11135025/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

