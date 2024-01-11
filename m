Return-Path: <linux-wireless+bounces-1755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498BB82B633
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 21:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30951F2518C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1D58112;
	Thu, 11 Jan 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNCmk8OT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECF5810A;
	Thu, 11 Jan 2024 20:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8635C433F1;
	Thu, 11 Jan 2024 20:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705006077;
	bh=M/+nO8sJ+V5s6gV1QS2HNCfEa4Pe0Ufyowvz6d/9x+c=;
	h=From:To:Cc:Subject:Date:From;
	b=iNCmk8OTvawS5zCELb+HRcB+l9P56yWGAwdrDVlV2G7Qfu9WvaCNjkb6N8QieOoAI
	 zWxC5OvZdfE8AAefd/Z5PTzItDUF1dY0fz48p/bIgXHRLlnA2/tups1VLImugKRKmU
	 HlHLiLYK+3Mkfy2rnLuVZyResfbwOb5mh9pqBakwSIHo9mF1iiKKlHJYeqSw8TKlp5
	 AcruYZSKHyOD1yFSR/rluufwKV2HO9HwVpu0toL9yaFwUC76GeidLXAc/FLjwus0d9
	 RlSvPYHTkpxNuKiV7xMsugFvrTiPIi2M1t2gWK7gTb73tba3dIWRwhIfxnpb7m+Lb3
	 hdubl1AKXJBEA==
From: Kalle Valo <kvalo@kernel.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: [regression] ath11k broken in v6.7
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 11 Jan 2024 22:47:54 +0200
Message-ID: <874jfjiolh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Just trying to make everyone aware because I suspect this will affect
quite a few people: ath11k is crashing during suspend on v6.7 due to a
mac80211 patch, more info:

https://bugzilla.kernel.org/show_bug.cgi?id=218364

Proposed fix:

https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/

Kalle

