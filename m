Return-Path: <linux-wireless+bounces-4198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A19186B14C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E906F28706C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322B150994;
	Wed, 28 Feb 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huGrkhB+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24614DFEC
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129388; cv=none; b=HLF8Y+77MV0V6zK936igFZYi+KYUioAdgsi7Y98XBH34GMlBTUSNmH6iOjTWSSMmIQtoHqQl52zc93o1Esse88SO1qfPyWKGnUmW/OLiX6wXfC4E9twLMVGqZLxDB8i6yzHlVYRfkbGWjR9XYsw32lBNWoSW7166QJ+24AkJqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129388; c=relaxed/simple;
	bh=dCa4U+4r7FbGn8egRvdE7REui+y0GV6gu3/2GfgJAEU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Be5yVXeu/TUz3E5mYiJ8n6i/XLs1G/yeQ1pfhrVFjdEboqoE2sGd3aWwb8q3HyaqO6OBmR9v2x8dQuTdQh3+Gs5TkMtYRoiyy1eLkmXQhyJerfo4nPi2nxJ9Zrt5RLvx1SxJUR6trwZ5UODjoJ4RK/z7JfiJPfLJrZOQvB4lLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huGrkhB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AD8C433F1;
	Wed, 28 Feb 2024 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709129387;
	bh=dCa4U+4r7FbGn8egRvdE7REui+y0GV6gu3/2GfgJAEU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=huGrkhB+3LQ9wHva/1dWXutAhhGwTxG7JUa1xHS6tEvJsGdJb4hfTqchg3DjBWHpR
	 iirvVzsxcYxiHSyA6ZYbr2yGf5DNzmWmEZDAXJdpg7TvVa0yLu6eF9cl5Hgr+oKObP
	 zE6FF7XCke93cAUtLbqBSmpo/72Q0gusZumJJAJXQImTVvMbPlkOBoyQdnkZ6VqgLE
	 RttRGGd0k7ewH1lVykYwLFunZx7s71XBdNXzJL/iB8/4BnkfIElqX6bPw4HI0ZPD9c
	 ZWayevMZPgdlMb7a83ws6aQEylwknQJfP585bE7x6yq4lnBElEfxFfbKDCZa0qR7QB
	 16tkg1K+NV/kQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix license in p2p.c and p2p.h
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240226180745.3195805-1-kvalo@kernel.org>
References: <20240226180745.3195805-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170912938485.3989537.8347507442547306401.kvalo@kernel.org>
Date: Wed, 28 Feb 2024 14:09:46 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> ath12k uses BSD-3-Clause-Clear, not ISC.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

776c9c93bb05 wifi: ath12k: fix license in p2p.c and p2p.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240226180745.3195805-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


