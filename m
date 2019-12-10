Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10CE118F1E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfLJRfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 12:35:12 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:47706
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbfLJRfL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 12:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575999311;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=oycRlNWmJnPdKVyTXm9AfUk/t8Y7MIC2KSkQIAG0qh4=;
        b=kOQvA5wyys6QVTT2G73af5+WAOKFSDkkaFF/d2VSjwvj7BOGMBj6PwpFTjYDKbBd
        O3qDWExUsVOe+n/zuyGBJ1meeoeTnEZZWbGKciVrATKFWk7Z5mOx5iDEow0K1Xxq9YK
        5h5IJ9MhuBie//JNP/mVSdkSasLJVZ1FLp912Faw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575999311;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=oycRlNWmJnPdKVyTXm9AfUk/t8Y7MIC2KSkQIAG0qh4=;
        b=ANO0ysNBMuuWjFmSBhxl2wpOWC1izftLLGNdmhI/d4BRrAVAR9PjC7527yjHyKZz
        U4VHU3ALTUxZskwtwSmVae24ggQwpI6Q3/7OPVWZkQbbIAeTrMnYmL8r9Adp4jSPbYt
        jCUlrtWkSRvUvww8TKNg6tT7FK8RNhrapSR0vbcY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D32CFC447A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND 1/9] ath11k: add wmi helper for turning STA PS on/off
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191204053713.3064-2-john@phrozen.org>
References: <20191204053713.3064-2-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ef0e10c73-a684c43b-a9f3-4115-a3c2-142e74aa25ea-000000@us-west-2.amazonses.com>
Date:   Tue, 10 Dec 2019 17:35:11 +0000
X-SES-Outgoing: 2019.12.10-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> Add a WMI call helper to set the powersave mode of a STA interface.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

There were few new warnings:

drivers/net/wireless/ath/ath11k/debugfs_sta.c: In function 'ath11k_update_per_peer_stats_from_txcompl':
drivers/net/wireless/ath/ath11k/debugfs_sta.c:138:6: warning: variable 'num_tones_in_ru' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath11k/debug.c:122: line over 90 characters
drivers/net/wireless/ath/ath11k/dp_tx.c:472: line over 90 characters
drivers/net/wireless/ath/ath11k/wmi.c:5669: char * array declaration might be better as static const

-- 
https://patchwork.kernel.org/patch/11272115/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

