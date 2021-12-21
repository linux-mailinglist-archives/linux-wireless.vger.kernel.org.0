Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3F47C64D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbhLUSTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 13:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbhLUSTi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 13:19:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A25C06175B
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 10:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7A20CE19C2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 18:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2791BC36AE8;
        Tue, 21 Dec 2021 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640110771;
        bh=BsYhhkwAvzDNK42Q4YGNtuYMDnT87y95xrNDg76jOB0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GxCa57roPg4q0uoihYHa8piHbtotyYFcn1+RR9MsgO8QbOLX296J8msP45+xVV8IB
         UJsByGp8dz0SSjHQKxa+WY+RH02qQP/Ok5n7QNhWH//Wl00hPKHWPR2OgHbW9buXoW
         eCt99QwVjFb38fUs5kYn/hBQ1wBRjlxETV95W8nBDmlesE5LmmPjjsQjT7IVq4c+MZ
         wcjvZfVN49q73m3Jox9lV/0QE2O876o5cpsm3mEX//+vGKIQNuFTaqEdcDpFzwJA8r
         9fnTuCo9ILz202Yl9eUx3LFd4w04wbzI4KtuvxG7kWUFjLdODKS1BiabHNZ96dsCMw
         1wveYunxesjDw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] rtw88: 8822c: add ieee80211_ops::hw_scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211221085010.39421-1-pkshih@realtek.com>
References: <20211221085010.39421-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164011076594.31508.16370428097829988960.kvalo@kernel.org>
Date:   Tue, 21 Dec 2021 18:19:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Declare this function allows us to use customized scanning policy.
> By doing so we can be more time efficient on each scan. In order to
> make existing coex mechanism work as usual, firmware notifies driver
> on each channel switch event, then decide antenna ownership based on
> the current channel/band. Do note that this new mechanism affects
> throughput more than the sw_scan we used to have, but the overall
> average throughput is not affected since each scan take less time.
> Since the firmware size is limited, we only support probe requests
> with custom IEs length under 128 bytes for now, if any user space
> tools requires more than that, we'll introduce related changes
> afterwards. For backward compatibility, we fallback to sw_scan when
> using older firmware that does not support this feature.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

10d162b2ed39 rtw88: 8822c: add ieee80211_ops::hw_scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211221085010.39421-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

