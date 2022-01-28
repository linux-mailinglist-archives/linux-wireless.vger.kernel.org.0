Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04AC49FA54
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiA1NHJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:07:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46476 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbiA1NHH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:07:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEF61B825A7
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B2CC340E0;
        Fri, 28 Jan 2022 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643375225;
        bh=pxWu6qGV4gPnmvtpbxKwT+R4/3dtwDdsnq6gyj8JVeA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aIQdxCp0tTVwfsAxFSL4puD8RwkqOZeU+SolJzQofux2NuXOSDO2BFOP9qpdRfsOH
         Li/6S04GdcDdxx7Afzh6xAy5f081xFXRXsGRpFYPBAlBM+Lu0T5cg+OxHEFz4Egn1q
         wu3SQScX72OvlgIPKzxM9O+/hQimbmCk7M2nDbBob2Enhh7smi7x3iyxapfh6U6R8t
         hrG04lMFOMiB0v8XRt+TtBk+ax4E985Wg63BKaKjetIF07C2uSVYOk/5byeyEkImzj
         Vy64AlyYhcCaAG+QW3tjG/cv8McmHenCk4vX1CZM9CuzC10BOmCZUMfV7zz5vb61oK
         eRn5YjBca8Daw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [V7 1/2] ath11k: add WMI calls to manually add/del/pause/resume
 TWT
 dialogs
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220112180026.5554-1-alokad@codeaurora.org>
References: <20220112180026.5554-1-alokad@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164337522291.4850.3161282562927795317.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 13:07:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> wrote:

> From: John Crispin <john@phrozen.org>
> 
> These calls are used for debugging and will be required for WFA
> certification tests.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01179-QCAHKSWPL_SILICONZ-1
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>

Fails to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/core.h:603
error: drivers/net/wireless/ath/ath11k/core.h: patch does not apply
stg import: Diff does not apply cleanly

2 patches set to Changes Requested.

12711826 [V7,1/2] ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
12711825 [V7,2/2] ath11k: add debugfs for TWT debug calls

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220112180026.5554-1-alokad@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

