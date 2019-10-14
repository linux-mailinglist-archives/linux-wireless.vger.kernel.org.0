Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0CBD5E53
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfJNJLO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:11:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfJNJLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:11:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F60F606CF; Mon, 14 Oct 2019 09:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044273;
        bh=4kKsyyifC/sEM32Uwpe/AMqnEm+d5I2UM/A3IseFB+s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mIAwnvga24B9CaswvQ3mrEVCdkmOPOWeB7qg2ep1EHGSzBuj8o+S2XRBT92N0aDha
         1OHkFAQ3veCfZCT8yDiiC+dZGHBwgY5k8EN/Ybrxso+Ji8OGNuaMlBXlgeE0jGw9UH
         4ZzDadKWhIG3zD9/2eQizEE/3FjdDpYxVReuHuzA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6687C6039C;
        Mon, 14 Oct 2019 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044273;
        bh=4kKsyyifC/sEM32Uwpe/AMqnEm+d5I2UM/A3IseFB+s=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=WkQbd1gQUGvcCeBdDJVKMYJu8sa3HcU/BSni2s7Y0HaQOjQzSdGqC0LpEQCWAs/5Z
         iC1p0lVHyz6gb/xnRBOdyZ2GBwqDrcwnc4YbUH2GDobNBk4qO02XuT34VGRU1Y1SS4
         ZuFKPWJo8wNkM0TLCL+Z9dExw8ZwRJ1f5rMyYeWc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6687C6039C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/10] rtw88: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0
 support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191008082101.2494-7-yhchuang@realtek.com>
References: <20191008082101.2494-7-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191014091113.7F60F606CF@smtp.codeaurora.org>
Date:   Mon, 14 Oct 2019 09:11:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> Add support for NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 feature.
> According to the "Hardware crypto acceleration" documentation section,
> when set_key() is called with %DISABLE_KEY command, for outgoing frames,
> we flush out frames in the queues with the old key; for incoming frames,
> no frames will be passed to mac80211 decrypted with the old key due to
> rtw_sec_clear_cam().
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

4 patches applied to wireless-drivers-next.git, thanks.

5dc32b8ace37 rtw88: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
a4835410995e rtw88: Use rtw_write8_set to set SYS_FUNC
474264d5a6b7 rtw88: pci: config phy after chip info is setup
12078aae4535 rtw88: coex: Set 4 slot mode for A2DP

-- 
https://patchwork.kernel.org/patch/11179155/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

