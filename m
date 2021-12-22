Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5815547D601
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 18:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbhLVRtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 12:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhLVRtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 12:49:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A65C061574
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 09:49:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F8FB81D65
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 17:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260E4C36AE5;
        Wed, 22 Dec 2021 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640195344;
        bh=IdiyFtZp5dpmPN0e3xgmQIROwfji5HDlI43ZohBHWiA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mIk+1GVjptgUIm/NRP02dwKZaKGIZbTWJgVtnImZFXLNKDEwVa5RKOAPK3NvF0OE9
         dNKq4LcKF2WxxBY6WEUrExEV7yptV75LJbCysWO5YYipRkCkyFxzKjytseweByf5is
         rKQfLfLpKUMYnYdJanj6yoeUM3gIaP0fGzkYDwDlXpEjtC8ATELd9NwaTuvgh2tC09
         FhxAF298JXxZqVifN7m7d6j4t5X4d63NabASYEpTITg8JkRO2ibif7asqucQ1U8+wx
         gZBqzMuQnRZzbvdh0uD6lP3tj3THrfZTmxYi5HmHiX6FmUEjg9JrTO1QwKICm43Es9
         1qMQKiukaHfUw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: don't consider deep PS mode when transmitting
 packet
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211221020230.20764-1-pkshih@realtek.com>
References: <20211221020230.20764-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164019534149.12144.14671570576275907686.kvalo@kernel.org>
Date:   Wed, 22 Dec 2021 17:49:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> In original flow, driver needs to ensure chip leave deep ps mode
> before transmitting any packet, and don't enter deep ps mode beofre
> PCIE DMA is finished. Now with the support of 8822ce's hardware
> setting and firmware after v9.9.11, these limits are removed.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

5d5d68bcff1f rtw88: don't consider deep PS mode when transmitting packet

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211221020230.20764-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

