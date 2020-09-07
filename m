Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93A625F763
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgIGKK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 06:10:58 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:53252
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728317AbgIGKK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 06:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599473456;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=WoTMr5acT07nI7nECsQsjC7kUvg85kkThR4IqFesBZ0=;
        b=gkQ/3tGOp18sKA1HOmzNUjecJubGRFNe3hOwBgIEPsa4Zp2UpPVvNNVb4pcQKkIH
        LzoL5Jj559mocUtyBncd11vSaMCl8v9F8XFHXgeDmkZ+SZBKqvs62MUlfPiasKyBaMU
        bDV6C8rTijBrjMWv7mfBJ1tvPdFSN1OIOtOdpMrY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599473456;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=WoTMr5acT07nI7nECsQsjC7kUvg85kkThR4IqFesBZ0=;
        b=aesiZs7YJn+Fv2P49MkMiSjGA2lyxmvR//2Dxpc3/f0sJE7gWH05hTmWwvzTJaoW
        kBdZvhQWY8QWUG+8d2P1JxpM6IWrV9ZZZs1AqxbHsf4sPbr5Flqn73fSk7A4j4ewyWd
        ckI9WVWGt6fqhfuxWuEBifDbXaTjuMkkj2BLhDhE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB382C358E2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath11k: cold boot calibration support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1594372049-31480-1-git-send-email-ssreeela@codeaurora.org>
References: <1594372049-31480-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <01010174680c1532-acfa8fcc-8444-45c2-bfff-9efe1dca2e2f-000000@us-west-2.amazonses.com>
Date:   Mon, 7 Sep 2020 10:10:56 +0000
X-SES-Outgoing: 2020.09.07-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> From: Govindaraj Saminathan <gsamin@codeaurora.org>
> 
> cold boot calibration is the process to calibrate all the channels
> during the boot-up to avoid the calibration delay during the
> channel change.
> During the boot-up, firmware started with mode “cold_boot_calibration”
> Firmware calibrate all channels and generate CalDb(DDR).
> Subsequent WIFI ON will reuse the same CalDb.
> Firmware restarted with Mission mode to continue the normal operation.
> 
> caldb memory address send to firmware through the QMI message.Firmware
> use this address to store the caldb data and use it until next reboot.
> 
> This will give the improvement during the channel change. But it is
> increasing the boot-up time(up to 15sec depend on number of radios).
> So if the user want to reduce the boot-up time and accepting for channel
> change delay, user can disable this feature using the module param
> cold_boot_cal =0.
> 
> Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Co-developed-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>

Fails to apply, please rebase:

error: patch failed: drivers/net/wireless/ath/ath11k/core.h:98
error: drivers/net/wireless/ath/ath11k/core.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/qmi.c:9
error: drivers/net/wireless/ath/ath11k/qmi.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/qmi.h:110
error: drivers/net/wireless/ath/ath11k/qmi.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11656087/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

