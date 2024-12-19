Return-Path: <linux-wireless+bounces-16611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD89F7C59
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F8718957E6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658C225788;
	Thu, 19 Dec 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN30Sgdk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962122577F;
	Thu, 19 Dec 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614829; cv=none; b=tW522Dtizdlx0dDsRsoVCZDIYAu2L3ZtX7ad/v96gElbGAs4xwXWU2JqYp1B9Y8U93mYyLQX6+9isn7j0g4qKWxSv8ix4FLcdKppJpwuAUE5fjOxjwrShZCY4dMRL2s442SnvtDnVDahlGER06XuoR913fjpRra9hgObwn/6w4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614829; c=relaxed/simple;
	bh=4U1rX2P9SnZIdU620uSlt8MpD5nd6cSqYravvEQbTDw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pKy4jdYjwzFAYciX3LZC/JyWXhFwHE8k+HRWjTIIgzm7ME+b4OF/DMsgkXA0LinPIJW9FGE3IR1XDKbP1cxnm8ljC75bdD91teDYLz7osc1m9fAgGNGHGzvHbzEpji9NEwqkbgus0s1Wq1WFZDqXVyfgp63NF+zWWfZsM9aA1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN30Sgdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF174C4CECE;
	Thu, 19 Dec 2024 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734614829;
	bh=4U1rX2P9SnZIdU620uSlt8MpD5nd6cSqYravvEQbTDw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GN30SgdkvmOgMEnxZcNJQoSEVhiU9CBERI/byc/+Zn9wLMRVWaP4oDuoTmCVpIood
	 FGskKBEJFBR7s+CN4aEkLnpHs5di7qC6uJP7yZhnonC6zg/iGxstZLhvLMq5RE7D68
	 LLws/hx1YIsV288MndmjnirV/6RkN5aG8Y7yGkdFqPfEkEToyqKUwSOieMp9lohQvs
	 XAD9Q4D63ThkDdVlJUCW9IxbbQNWU6ETV3bdH1YepZu69nU3rbXsmHAZBPuZtFpXtr
	 BOcmdfvK8tbXBozYVeqYDmPqJKq3X+uuP4piL1d5xLdrHUnPvulgyRIGqnBY4cO6Ef
	 Uabyhp1n/GYwg==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath12k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] wifi: ath12k: rename CAC_RUNNING flag
References: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
	<20241218-ath12k_mlo_dfs-v1-1-058e783bcfc7@quicinc.com>
Date: Thu, 19 Dec 2024 15:27:06 +0200
In-Reply-To: <20241218-ath12k_mlo_dfs-v1-1-058e783bcfc7@quicinc.com> (Aditya
	Kumar Singh's message of "Wed, 18 Dec 2024 09:11:32 +0530")
Message-ID: <87ed23hkgl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> Rename the flag ATH12K_CAC_RUNNING to ATH12K_FLAG_CAC_RUNNING to correct
> the naming inconsistency in the enum ath12k_dev_flags.
>
> No functionality changes.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

