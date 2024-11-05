Return-Path: <linux-wireless+bounces-14918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4109BCAD3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 11:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F86B2815FD
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 10:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C761D2B10;
	Tue,  5 Nov 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC7hW1eD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916851D27A9
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803753; cv=none; b=NtfqyaMM/RFseJx9W2mw0YANqjv7v7FqUCXBefNC4ABf9B655jL7w0Ybo19lEnJJXdB3RWT8phDESpuU4XPb2mxoTCN/04JPoZtY7WjzL++ukpsZTdWoniTwWxY2FCSNFCNNED5IHu/GloOVvgjrarnMZ+8fcwWsKUXc9B1k1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803753; c=relaxed/simple;
	bh=HptBZvgAjzFEWz3SROTnn5+BJ5H72QKTi3F5NBW3eZA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=K34UA68jG4NKKv+Ou9vLpOeZi6It0glNElnLF4M0If9BDwqgyqwu6taQmP/hB7Fc/psTRednAhZCnNlJWmH7jYYjzZ+cS8JgvUB+BxbjbMUxBesy10gbEPu75n4HICag1NrwDPwQr7dsN1W7eCLNI904wK/D0S8BAU1wNK8zGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC7hW1eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF87C4CECF;
	Tue,  5 Nov 2024 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730803753;
	bh=HptBZvgAjzFEWz3SROTnn5+BJ5H72QKTi3F5NBW3eZA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FC7hW1eDzZNFAbe3BEQGmeMDH8uxfNa8BavD9wBrdv4OkRhS7ZJlyeWAC1P2aIWf3
	 6nAXpv4zWrC9oPnK3TTnMO1BJqoxksiKHu/qvQt+gnkMvCYU192GPGhVDEgE+L1jgZ
	 s7yeSfk9aUM5y+MO5YNOukvjjfYsfBPSmSG+fBAsx3xz53t/HgK2rira3nMm/PeWgS
	 tVYLLmB4uPf8iHxiNkX3FXhyI5SxOaYnxvitoc0maie3siK6+nlX5Z4Z4v8YqMqJ7e
	 gXa7Kx76oRhV3mfoDUqGfY946AdaeHVM8jmP5bjAy4175r6lix9onM7lzFTDQP5H55
	 dHZdAh/8C0CHg==
From: Kalle Valo <kvalo@kernel.org>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,
  mathias.kretschmer@fit.fraunhofer.de,  Simon Wunderlich
 <simon.wunderlich@open-mesh.com>,  Simon Wunderlich
 <sw@simonwunderlich.de>,  Sven Eckelmann <se@simonwunderlich.de>
Subject: Re: [PATCH 1/2] wifi: ath9k: work around AR_CFG 0xdeadbeef chip hang
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
Date: Tue, 05 Nov 2024 12:49:09 +0200
In-Reply-To: <20241104171627.3789199-1-ih@simonwunderlich.de> (Issam Hamdi's
	message of "Mon, 4 Nov 2024 18:16:26 +0100")
Message-ID: <87o72ux8ey.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Issam Hamdi <ih@simonwunderlich.de> writes:

> From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
>
> QCA 802.11n chips (especially AR9330/AR9340) sometimes end up in a state in
> which a read of AR_CFG always returns 0xdeadbeef. This should not happen
> when when the power_mode of the device is ATH9K_PM_AWAKE.
>
> This problem is not yet detected by any other workaround in ath9k. No way
> is known to reproduce the problem easily.
>
> This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
> and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"
>
> Co-developed-by: Simon Wunderlich <sw@simonwunderlich.de>
> Co-developed-by: Sven Eckelmann <se@simonwunderlich.de>
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>

s-o-b missing from Simon and Sven, more info:

https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

