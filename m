Return-Path: <linux-wireless+bounces-6527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF48A9E25
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2722F1C218D2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6616C689;
	Thu, 18 Apr 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0sWNa9B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566056FC3;
	Thu, 18 Apr 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453567; cv=none; b=TWUGxvqDLW9rIJ0YS5r4b9/BIwt9yCjUR50OPMJtJ9vRWVIO+4S/eFz9nbFjsuYTNU2shXfIk/hTsFS6r6ACnfYdblZSNj/qFwrEc1Kwj3O83x0cHw0bkYirQQmmlXk+ZPR+U5vilQInX3cY4/rQ1RHin5Y5WhId5Gg4iTjE3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453567; c=relaxed/simple;
	bh=/m88cFY+sszGDVxvUiNXiACTSqHBNqQZiJLjJ0y5k2k=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=NnQPbBkpsVtZxn01pOjXtMksmd0/M9ZrBEpf8mCteR+5Gf3HElMywekFlCQ+NXS6p7R/4RN+webEfE0AG9VZ5PT3a5cm2rx/hftMxnbkXQsXxwXhhZ3GVKZP4mzYLvZySgnrsqzuB2cqbLYoJ/+5IMNwBDRuUyRC9R2bWe1bOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0sWNa9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FB0C113CC;
	Thu, 18 Apr 2024 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453566;
	bh=/m88cFY+sszGDVxvUiNXiACTSqHBNqQZiJLjJ0y5k2k=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=K0sWNa9Bk2ceR6Kb7RYjPXgvqXWm0UkYxC8L7sOtDEIbREpV2Gp7RLlGsRV5k9RaC
	 ++QOO3xj4aXywwtMx5mu7wQy+JBG15VC5r7/EXeiEHrt7YobDffBtkJN6FZ6pxI4Ii
	 p6U2GJEDTw2v1KsCuKiAjsaUlOiNV8IjO/zEIvtyZWlLGfV/yogBQT6MhEF3TEUp0d
	 mps7gpAj5gEH48Iyxn0L2X4JhapoSrCgIvIzVR1Ru6UPJlmkKb6F4Ek+q9qEUQLNhg
	 kSa6E5nF43ErGOzN3aeO6AWP+XWD4bo83piXoITvH81RH/irMx6oDB09brtu2UjTok
	 vnsFZGjfSXfWQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] dt-bindings: net: wireless: ath11k: add
 ieee80211-freq-limit property
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com>
References: 
 <fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171345356303.934743.10571401233268486603.kvalo@kernel.org>
Date: Thu, 18 Apr 2024 15:19:24 +0000 (UTC)

Christian Lamparter <chunkeey@gmail.com> wrote:

> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

30ba0022b30a dt-bindings: net: wireless: ath11k: add ieee80211-freq-limit property
43528ae9d9bf wifi: ath11k: add support DT ieee80211-freq-limit

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


