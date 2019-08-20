Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E630961C4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 15:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfHTN6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 09:58:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfHTN6u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 09:58:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10CD060A44; Tue, 20 Aug 2019 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566309529;
        bh=paEuLKO8SfoIM8lHWikIbkL6+K3ppRgHsZdyDZmGo2Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RtxuIhVabbks67aMlhwE1Z8WCNeS8r5GpjrLFDpqwqza4rDyaJjC8LriYc7Nb7MXp
         /b1Ce3H8CwmEceRCXcZn/ISB3MjwMiH4nuTxbThOQATtxinpZqclBRsS2EHtxksBnG
         8cppE7XmLpORjLkPkrTip402GdSi7a/gro0cqR5A=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DC0060E41;
        Tue, 20 Aug 2019 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566309526;
        bh=paEuLKO8SfoIM8lHWikIbkL6+K3ppRgHsZdyDZmGo2Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=HKoIUZaToQ35hUoHIqaaYMDWmuAkuT6dRGceYwJtHq229yqXt/gbCuy7lUanJh39y
         U/XEP7+4Kts74yNARuxDWGOO7ImNxu9UllQ0vg7mTkMxyAVEpvn0f/x2yFuUNGFRRl
         bNHZik1M/UVGmnc7Jyq1qWFLpqUHx/YuOGBzp4lM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DC0060E41
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.3] mt76: mt76x0u: do not reset radio on resume
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1563446290-2813-1-git-send-email-sgruszka@redhat.com>
References: <1563446290-2813-1-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190820135849.10CD060A44@smtp.codeaurora.org>
Date:   Tue, 20 Aug 2019 13:58:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> On some machines mt76x0u firmware can hung during resume,
> what result on messages like below:
> 
> [  475.480062] mt76x0 1-8:1.0: Error: MCU response pre-completed!
> [  475.990066] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
> [  475.990075] mt76x0 1-8:1.0: Error: MCU response pre-completed!
> [  476.500003] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
> [  476.500012] mt76x0 1-8:1.0: Error: MCU response pre-completed!
> [  477.010046] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
> [  477.010055] mt76x0 1-8:1.0: Error: MCU response pre-completed!
> [  477.529997] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
> [  477.530006] mt76x0 1-8:1.0: Error: MCU response pre-completed!
> [  477.824907] mt76x0 1-8:1.0: Error: send MCU cmd failed:-71
> [  477.824916] mt76x0 1-8:1.0: Error: MCU response pre-completed!
> [  477.825029] usb 1-8: USB disconnect, device number 6
> 
> and possible whole system freeze.
> 
> This can be avoided, if we do not perform mt76x0_chip_onoff() reset.
> 
> Cc: stable@vger.kernel.org
> Fixes: 134b2d0d1fcf ("mt76x0: init files")
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers.git, thanks.

8f2d163cb26d mt76: mt76x0u: do not reset radio on resume

-- 
https://patchwork.kernel.org/patch/11048769/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

