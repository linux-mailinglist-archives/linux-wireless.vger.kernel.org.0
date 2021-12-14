Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AEF474B06
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 19:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhLNSgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 13:36:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42102 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhLNSgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 13:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D1F3CE19B6
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 18:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9E9C34600;
        Tue, 14 Dec 2021 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639507000;
        bh=t71wTHemX4hxcBdVIXsuipy4Hb/du5Gs1X3z89yoWAM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PWXC64cpnLETq/N8NDP6kfnOnssmoPYcNOgBNa1geKC/Y2NOCQS2CoNmMuQIXCeX4
         lTGKFS1Zix3s8rtd4lZ0RQY/igFZdMn1UIFTy8NntEmJex4/9hN2Q0rfFNVgFupvLA
         c7gRPR9C8JhMPJEcAwe0rDZ3VMhuQgWjtw7eC4208PnzbuaDDjSSJzCTLFdK0vsHHk
         oVnHgF1I7ZNkdRxtESl8t337tjOFvVyGcQ/b/gRPHL/3p5XZWTRO3nB6Oxt3LRed0B
         guu7RR0RivoAb4B/J8DXMWU0f8pXR7GCk7efdkru7VkP+vxIfnX84NtlJ858YN4C1u
         6s50hNH1qS/Zg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] rtw89: coex: correct C2H header length
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211209083229.10815-2-pkshih@realtek.com>
References: <20211209083229.10815-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <ku920601@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163950699570.16030.6759547344807917270.kvalo@kernel.org>
Date:   Tue, 14 Dec 2021 18:36:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> To resolve C2H handle length mismatch, or it will parse the c2h content
> out of array.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-drivers-next.git, thanks.

b3131a41ac6f rtw89: coex: correct C2H header length
f8028a9a92f2 rtw89: coex: Not to send H2C when WL not ready and count H2C
8c7e9ceb5bac rtw89: coex: Add MAC API to get BT polluted counter
2200ff3f0d1d rtw89: coex: Define LPS state for BTC using
eb87d79911c6 rtw89: coex: Update BT counters while receiving report
bd309c8b4965 rtw89: coex: Cancel PS leaving while C2H comes
4c02043c5a52 rtw89: coex: Update COEX to 5.5.8

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211209083229.10815-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

