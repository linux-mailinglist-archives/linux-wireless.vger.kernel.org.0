Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF599477949
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 17:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhLPQgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 11:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhLPQgH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 11:36:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B5C061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 08:36:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EB31B8249E
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 16:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95176C36AE4;
        Thu, 16 Dec 2021 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639672564;
        bh=7d992ORaxrkAOc/y1VyGbJc7x1y3M1BbCoqPtnd/NaY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aXRn7d3iV3ODodkbKkja6HB1N2V8EhBBk1eSzSimrymBtYZEr/grKRDcYtJ8w4r1+
         QccwPHXwjZN+xpB8/jCLvCAOBzXImPAG5FhiD4c8QXaP8fWuYjoFGm4pY8or9RpFG5
         cyqctg93f7FRII2m2RSsPc2PNpPJBf7rfPSWdx4/JoM/7sp+vCcLNleJ9hpMmCazrb
         HOl62Gaj1Erpu8zKfBJUU1l2hRgBuM+YqddecwXDNvvqaZhuu9jnxYUKNnZjO6bid7
         lxPQBz7UKXaAJyf6jDuvbdLmTj7RMBKpGj2qsEh6igQcZvMmCAI+c+smE7x8YZ4/ed
         2ryqK80I7OB3Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] ath11k: fix destination monitor ring out of sync
References: <1639584090-13751-1-git-send-email-quic_kathirve@quicinc.com>
Date:   Thu, 16 Dec 2021 18:35:59 +0200
In-Reply-To: <1639584090-13751-1-git-send-email-quic_kathirve@quicinc.com>
        (Karthikeyan Kathirvel's message of "Wed, 15 Dec 2021 21:31:30 +0530")
Message-ID: <87o85gbj80.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> More than 20000 PPDU id jumping causing status ring and destination
> ring processing not sync. The status ring is processed and the
> destination ring is not processed. Since destination is not reaped for
> so long, backpressure occurs at the destination ring.
>
> To address this issue update the PPDU id with the latest PPDU, this
> will allow the destination ring to be reaped and will prevent the
> rings from getting out of sync.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2
>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>

Failed to apply:

Applying: ath11k: fix destination monitor ring out of sync
error: sha1 information is lacking or useless (drivers/net/wireless/ath/ath11k/dp.h).
error: could not build fake ancestor

Please rebase on top ath.git master branch. And remember to use --base,
then it's easier for me to fix conflicts.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
