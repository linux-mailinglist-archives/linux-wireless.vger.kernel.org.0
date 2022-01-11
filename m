Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5466548AFB0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 15:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiAKOim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 09:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbiAKOil (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 09:38:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF6AC06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 06:38:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5CF6168A
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 14:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4018C36AE3;
        Tue, 11 Jan 2022 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641911920;
        bh=BzfEzZiGgzx0tSuP84HARdUdUuAEdyL2H9x7G3VY19s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OoiHGODEO0VELV7/2HpZM/cc+jlfUxM7UHhErYDlQPKJiyV9ZozvDZk1R14J2qJHe
         YJk8gZ395CeLu7/1eMxCFcqpsqfyFpti4KaXZFvHJoQ957ksHcg5hbtz4uYDbbutN3
         N5SBTUXE4C4YD3Gt0/kRgYt52fTdWgYmfUKJ2kPl9KneRkDS0cTv6yiEYkGjU8Eqwx
         jTMzPioeQ7vA0lYx4KTUbJko0iRVmMqmONZ2k6ywhnd4qpWuEeI87xp+mtD8zVR9+9
         YEYJtKV0eVVG5UBZ5nVGpF5eSiCgVQMghP6FBXZOgTI9agBMcgv91TdGTfQBdo8YM4
         R+yeOG96cvXTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix workqueue not getting destroyed after rmmod
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1640231787-17408-1-git-send-email-quic_adisi@quicinc.com>
References: <1640231787-17408-1-git-send-email-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164191191704.24158.8323554268454002040.kvalo@kernel.org>
Date:   Tue, 11 Jan 2022 14:38:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Currently, ath11k_core_alloc() creates a single thread workqueue.
> This workqueue is not detroyed during clean up when ath11k modules
> are unloaded from the kernel and is left as it is.
> If workqueue is not destroyed, it could lead to kernel
> memory scarcity in a longer run. This could affect self and
> other drivers workability as well.
> 
> Add destroy workqueue in ath11k_core_free().
> 
> Tested on: IPQ8074 WLAN.HK.2.4.0.1-01746-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9f4ecacf2fa4 ath11k: fix workqueue not getting destroyed after rmmod

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1640231787-17408-1-git-send-email-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

