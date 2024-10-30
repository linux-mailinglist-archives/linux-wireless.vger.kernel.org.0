Return-Path: <linux-wireless+bounces-14713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B49B6052
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65A91C2179E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59B1E0081;
	Wed, 30 Oct 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKYohJb7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283191DFE1D
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284660; cv=none; b=WXoc7X9abS2SB9VifjN43wDM6uG6P0P60WnUHvFAK+/dm6nxnM1/FhmKJ7qziQGvGWFfzGIPHPd2zFA28Aq3yuNOgYigeX0CDt25IzC+u0wZL93a/1q1KPbcLjuE0rgMcsHahZKHx/+KBQssi0AQhLNoLJbHMKlOSHz0xEzjkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284660; c=relaxed/simple;
	bh=GF1YsP5YKMb4q8IeLolI/RQR8ZKxYmA6vlBxLh6Pq6g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ltpY23WvGZhUCLyFn208F4WSMYYf21YAzUL/VvQOIRIq3cZqm5nOOr/onAQS6xFxrWWM8HAIc7gGQGlBh0lEvg9jY4eiDmp+s1ifyWycQCrw8k2yrCxLH4FMW3RcayiPYao37hzt+KwaXaby/f56fJDsW7PCF6I2LpPSSusHolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKYohJb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4A3C4CEE3;
	Wed, 30 Oct 2024 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730284659;
	bh=GF1YsP5YKMb4q8IeLolI/RQR8ZKxYmA6vlBxLh6Pq6g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OKYohJb7YgkHnXha7YUU1UssoqmT1ExjiV6O5RNuKsP8m1end1tXj0idXs+M4r0cf
	 jQN3KAzCCdOCsS7RLspBvlNeo+bLJKFBgEYtUIQm+cy6qgtRJzAqaReE6z5jKs66ZV
	 fnqGN/KmoFt2E3JdkMcc3Feqv9kzEk2RaEOvYEjBWH2WAKdTfycLpYj+oxHSpRAwCV
	 OX8YI44G9ZZ5TNMvyKw33ZtowZutajBKY6zKlxVY9mb5a9XmkWklbYpdw4ekgwANmt
	 iVrZ4io+Dh6+nJNuIvBUVzvMJZMGrm1s1MQjNS80HZv7gQaI6bZbc9TCdvicNZVFTa
	 m1PIE4aRKFVMg==
From: Kalle Valo <kvalo@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-wireless@vger.kernel.org,  pkshih@realtek.com,
  xiaopeitux@foxmail.com
Subject: Re: [PATCH V2] wifi: rtw89: coex: check NULL return of kmalloc in
 btc_fw_set_monreg()
References: <516a91f3997534f708af43c7592cbafdd53dd599.1730253508.git.xiaopei01@kylinos.cn>
Date: Wed, 30 Oct 2024 12:37:36 +0200
In-Reply-To: <516a91f3997534f708af43c7592cbafdd53dd599.1730253508.git.xiaopei01@kylinos.cn>
	(Pei Xiao's message of "Wed, 30 Oct 2024 11:20:58 +0800")
Message-ID: <87wmhpzxjj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pei Xiao <xiaopei01@kylinos.cn> writes:

> kmalloc may fail, return value might be NULL and will cause
> NULL pointer dereference. Add check NULL return of kmalloc in
> btc_fw_set_monreg().
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> Fixes: b952cb0a6e2d ("wifi: rtw89: coex: Add register monitor report v7 format")

When you submit v2 please include a list of changes from v1. No need to
resend because of this but please read the documentation below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

