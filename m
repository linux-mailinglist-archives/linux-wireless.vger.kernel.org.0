Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2047D602
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbhLVRtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 12:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhLVRtj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 12:49:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F8C061574
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 09:49:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B95E61B33
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 17:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE1BC36AE5;
        Wed, 22 Dec 2021 17:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640195375;
        bh=nSyQQ9qraQIrWUfxuEB7LOn1+dqX/t9vunC4slkX1Xs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qNAPYu/2jZ4LzIhqlhT9HZuTruL46OYWF0fySKv3iJJICMTDvcQdmZVs7zWbm2UHm
         ZjiGnFEghuBgnLzqAxLFb5X9laxrmyI57ev8jpGYYo53B0uJXgszoCU3gjQHJIhV9A
         V0j53FtspDblmMxbtguxFJhr2O5lvnfObMDlT7LEQfqIF3LwfjoDQyj+hMiExfFafj
         y6r6y0rt8totTiyv7FtMPJgtWLP7A9GZpGo+o5M0jmf7gCURMc/dUr127e9KojyQpB
         XjmRdi9FmWSF8F9Tutm6nCzhrTefs5ho7jE+Vl0il7dMEGYsWXGM4Vx1KyBj52EkqL
         vdu/fsWIrwsxw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: 8852a: correct bit definition of dfs_en
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211221024800.23814-1-pkshih@realtek.com>
References: <20211221024800.23814-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <hsuan8331@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164019537199.12144.2697392748847389548.kvalo@kernel.org>
Date:   Wed, 22 Dec 2021 17:49:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chung-Hsuan Hung <hsuan8331@realtek.com>
> 
> Since there are other protections in the set channel flow, fortunately old
> wrong setting won't affect the performance.
> 
> Signed-off-by: Chung-Hsuan Hung <hsuan8331@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

5f48d7bbec37 rtw89: 8852a: correct bit definition of dfs_en

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211221024800.23814-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

