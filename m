Return-Path: <linux-wireless+bounces-15545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520559D4B23
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F6AB2280A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F371CB51C;
	Thu, 21 Nov 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCoCUzer"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE627447
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186784; cv=none; b=UxwBlESC8ipgGDrDXu/aGWFHfc/ay3+TCYWdIEXnbiRslTLLdnEvdekJvAInrtK6BE+Sn00moR3FGwYzwH9Q2HeZaAXORXRnYdW7mIbm5bBv011wEaPUsMPNGCKs/fzecH9ZivaHs/jc13pq4tcYWer0EL5b3ibFcuWukXPeby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186784; c=relaxed/simple;
	bh=FNlUqpX3h8ygH4ry09EHX7f6Mff7DHs2rKLiP8rZXAI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YsH+WLSfbwrPKSry+A1xHRz2iopF9nleoDQofZIYCKwCmdYi00Lk6/ubP1YXdUjKkuFy6XByPy0jpx4VWPJsAIuQezD7QHx44lfjMZKnwqLBZsQnoUYOM+ocfyQp+apiHV4T38kpKSDlMnwfkfqx+aw8zAyv1KrG91TecLlILpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCoCUzer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2F9C4CECC;
	Thu, 21 Nov 2024 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732186784;
	bh=FNlUqpX3h8ygH4ry09EHX7f6Mff7DHs2rKLiP8rZXAI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VCoCUzer2i4zyQ2nErD1io/AkQmH5fM5P8vLVsUB7Ocoa8TicDyl9/oMYBhPZqCC0
	 mU2p58whH5j/8PBIwS87Ec3oAI7NPm/qcF7klsIia+t4b6hw88oP4NXj0rHJ7/WVzc
	 jwDg8MBq2kMcj8VKPQumAcf68dak/SCxitmffXpAmsrv9cH9VV33ovDMh2rVdx8TjT
	 J43GiqgBADFwtkJufod1Y4aZcU5CzJ8zXF8YomxpPsK2dWEMtDCM0Q40obolXeZApa
	 TTymKUw/zcu/XS4QYKeE1VzNtuzJK7e3fG8Nc9sEB6+T3fQZAM9ukPaAUz5TDEa15j
	 a8R3ANdZ64Ccg==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <jjohnson@kernel.org>,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/4] wifi: ath11k: cleanup struct
 ath11k_reg_tpc_power_info
References: <20241111070152.85140-1-dmantipov@yandex.ru>
	<20241111070152.85140-2-dmantipov@yandex.ru>
Date: Thu, 21 Nov 2024 12:59:41 +0200
In-Reply-To: <20241111070152.85140-2-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 11 Nov 2024 10:01:50 +0300")
Message-ID: <87jzcwyhr6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Remove unused 'ap_constraint_power' field of 'struct
> ath11k_reg_tpc_power_info' and adjust related comment.
> Compile tested only.
>
> Fixes: 6f4e235be655 ("wifi: ath11k: add parse of transmit power envelope element")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

