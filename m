Return-Path: <linux-wireless+bounces-12958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA9D97BD18
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A91F22CAB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990C18A6DD;
	Wed, 18 Sep 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0v1fK9C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839018950C
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666458; cv=none; b=W9yZlO1Eq4FeGCU66UER8Lvi+aENF6JnJW9sjTKtC0YYwQohlkI2PmNDdk8bYF1De63O1UUtF+JsnfAmrtRBS8HV5PduwjJvlsdG1p3filq/2+U9wE8hvKdL7LQuJLb9Xviq+OTXn8764nDte5lLiNJ+KRFsnz36F9xqKPN1V/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666458; c=relaxed/simple;
	bh=9CX/2tRxtITqgd5m8+6GhZ+Z7yLHIm89Gf/IVH9Ta0M=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=hOXZkqa9AG3R51Wyy/Vn5GrO+mTQJkDaEPkL9xMhP9GDvDXqSJccrrlY4ysSBX2DqpMLjO+Bq4fH8exo82ic3x/DWt2BG+/wqsLxh9t549KnzzY26FXTLz+SObCaVwZIm0NQNxJeYoGrQpG/PXuMT/N7QTK0i2+72qzLh24vTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0v1fK9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720FEC4CECE;
	Wed, 18 Sep 2024 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726666458;
	bh=9CX/2tRxtITqgd5m8+6GhZ+Z7yLHIm89Gf/IVH9Ta0M=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=T0v1fK9CwKkX2pb+IP8VPY5ZMF8cOPfdXgAnUbNvKh33qXzVQ8StKRR9IJndSzdrX
	 353x44DOSVK1vm+1Uru1IbAiEifFI8vCPuBzgbagrA+ZTfPecJvTDjHElCXh9B83Xw
	 aBeBIjyjONDBN4XnQvDIzI+MD2Yp+dyJRO5Gx16UQxcJ35knSKgPkrWdPupXVSVZVr
	 iLkTFx4FPkreMgJZzU/9lyTm9WXSqlJib+QcGcEXfBgvavghiVntMY8rIGm2A3nsBa
	 rmp1sg7h0SAaqrPPcgnEQFEzmcAweBRj8LRqnaG19ZXUyGJj9CaEpLC+5hfRAOJFIo
	 cZbddNGbPWqcw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: mt76: do not increase mcu skb refcount if retry is not
 supported
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240917110942.22077-1-nbd@nbd.name>
References: <20240917110942.22077-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org,
 =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172666645539.3918518.3196249898117752770.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 13:34:17 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> If mcu_skb_prepare_msg is not implemented, incrementing skb refcount does not
> work for mcu message retry. In some cases (e.g. on SDIO), shared skbs can trigger
> a BUG_ON, crashing the system.
> Fix this by only incrementing refcount if retry is actually supported.
> 
> Fixes: 3688c18b65ae ("wifi: mt76: mt7915: retry mcu messages")
> Closes: https://lore.kernel.org/r/d907b13a-f8be-4cb8-a0bb-560a21278041@notapiano/
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

34b695481084 wifi: mt76: do not increase mcu skb refcount if retry is not supported

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240917110942.22077-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


