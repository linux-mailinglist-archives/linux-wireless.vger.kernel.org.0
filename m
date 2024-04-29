Return-Path: <linux-wireless+bounces-6968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546938B526D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 09:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A75E1F219A7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 07:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B114273;
	Mon, 29 Apr 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqJoR5QT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D1134BF
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376153; cv=none; b=sVy9zmMqetvwt5tsnlK3vOtP/MPLR6DoytFvtp9mQ0KQ7AxO/9B/xzoCpQMiQcnsfs19OZDJwrR8ti+r0FyD0jqwzOPMbQMxLb04uJQLb+Fo0zuiAaflgXMgRFitIoT9eCLbMz7rOmCSnSrXSA+V7lcZRHjlTSzDw3G147cUWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376153; c=relaxed/simple;
	bh=AT28jAxeKMLr+S30R7py8Pa+K+hP1qri16uSK2Ye/0Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LUg1YRKh5F2SMmGXJA7rn3j8svBvtw8H24WaP8bBBF/J+GYsBJAYE5IepJ5CpmBL3R8ZdnFoDNnKAj+vLZGHKtXCrO3TSR4f92lrYZ/LwkL0ZyzSbCl4KD32CXpkgtacQNrPbT+oFxlOwFl3DFgzf8SU13lqMdpmwR5Dyr+Oj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqJoR5QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF4CC113CD;
	Mon, 29 Apr 2024 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714376153;
	bh=AT28jAxeKMLr+S30R7py8Pa+K+hP1qri16uSK2Ye/0Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dqJoR5QTgRNNA7SGYVy9KVfLqBdiiTmciMXqJi3i+I5PzttfIU9UiLG+ySZvkFd5v
	 RCoK+FABPFqRESkUZm0NzQp4eZvC+ajvfDqUDL06k4/tD7p7PQxMfstfoBqsQCu3Oy
	 5noGWsJL3O8X/FLMisJUP0+vrTq5HLlwPye9ecE9gDe65M1AOn07GlBTMFeMePqqt6
	 BJk5jmk47YciB8tjuTzMqCpDWpTqA7EFumKN/gsXuHHuCO12pEEGp/sTMA36HH0XCE
	 zRKhM8JcAQqP1UFh1xPgkgr7cI8nsxlWAUobndfDGR/gMieg6zCiOpHYL5nDhW0Xjr
	 T0dME1uG7hzFw==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Allow pre-CAC for self-managed wiphy
References: <20240429042723.2847389-1-quic_hprem@quicinc.com>
Date: Mon, 29 Apr 2024 10:35:50 +0300
In-Reply-To: <20240429042723.2847389-1-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Mon, 29 Apr 2024 09:57:23 +0530")
Message-ID: <87mspcr57t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

> Currently, to allow pre-CAC it requires both driver's regulatory domain
> in wiphy and cfg80211 local regulatory domain to be same, along with the
> region to be in ETSI.
>
> But, for self-managed driver, some countries have mismatch between these
> two regulatory domains and it would not allow for a pre-CAC. For example,
> in ath12k driver (self-managed), country Sri Lanka (LK) is classified as
> FCC domain as per cfg80211 local regulatory database but as per ath12k
> driver it falls under ETSI domain then because of this mismatch, the
> driver might not be able to do a pre-CAC.
>
> Hence, add changes to allow pre-CAC based on wiphy's regulatory setting
> if it is a self-managed wiphy.
>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

"wifi:" missing from from title but I suspect no need to resend just
because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

