Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82FD46D739
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhLHPqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 10:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhLHPqm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 10:46:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2246C061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 07:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02030CE0DB2
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 15:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD197C00446;
        Wed,  8 Dec 2021 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638978187;
        bh=usELxSoclQFiIbGRgPMrNIlE84VvZ9zfgJx6uERqWiY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=J1XCoAYk+CH8U240OlRBxy9L4fIRl2IyDfIvTiSB/Lr8YzmTG5UTUwqE5mR+2nytd
         kts4iRrNPY95JDPZDuVsbk0+y/JaRPbFRb8YP/9gKXKVCumG6vFLhRCljyO5X8iteB
         HSl+tBKE5ZCUuRA+PiyTLXzgD3qPLgUgnYoKkYU3RGKlBajCSDv+c0iZplPgfWtiZa
         6Cz/jE83tPPyVkRWEPK4V1qr51VcE1p1eCMrrvavmshnzyiwMc1WvKL+dPpd3UTTvO
         fqJ+fEuREXqi0/PMblsLI+V2bKPKfzKc22XGuixtzpAhf/aWdHvxdcJMUkaD+S2eJG
         lqrg92aBqucxQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V6 1/2] ath11k: add WMI calls to manually
 add/del/pause/resume
 TWT dialogs
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20210408011225.1989-2-alokad@codeaurora.org>
References: <20210408011225.1989-2-alokad@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163897818415.29276.10960298071615382240.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 15:43:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> wrote:

> From: John Crispin <john@phrozen.org>
> 
> These calls are used for debugging and will be required for WFA
> certification tests.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00680-QCAHKSWPL_SILICONZ-1
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>

Doesn't apply anymore, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/core.h:566
error: drivers/net/wireless/ath/ath11k/core.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/wmi.c:128
error: drivers/net/wireless/ath/ath11k/wmi.c: patch does not apply
stg import: Diff does not apply cleanly

2 patches set to Changes Requested.

12189609 [V6,1/2] ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
12189611 [V6,2/2] ath11k: add debugfs for TWT debug calls

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210408011225.1989-2-alokad@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

