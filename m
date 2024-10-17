Return-Path: <linux-wireless+bounces-14148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BC69A24EC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAB4282F02
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09101DDA24;
	Thu, 17 Oct 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGUYqOti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66F199944;
	Thu, 17 Oct 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175033; cv=none; b=SRLg7nxbDTCeOWikq4XcbdUqm9KiR/AJ5ny/Edavfh7D+FSQMFKvpqUDApimyXk5VpUPdIBCcpu3NzCzbRPHd8ajS70WZPlpr8uoQ5onhUYqFDIbJ1rxMR9bg7l7zgrShBNrxmYjJPbYRQ1gjayV5TRKe1c/102k3JKB7LQR/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175033; c=relaxed/simple;
	bh=giWuu8NoBaeV5r0Bde297AKTxT1aCfiVktksXm/BDC4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RMZqgEPoNMQtGl8nhlwhDEV4t0iZJlkCx084hUJiv4zWlBXIxwUL34EVEFs88IdcD2+3ZAxaAMz1H4C3aneLXnAwtIS6Cqnkrgzrpo2Z7aM6iNhKeQ2NKOgvtB1Tg2XY8EndA8SyIwuDw9rfI16cTahc3e2PHaHdLM1JBsyHHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGUYqOti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F0C4CEC3;
	Thu, 17 Oct 2024 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175033;
	bh=giWuu8NoBaeV5r0Bde297AKTxT1aCfiVktksXm/BDC4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AGUYqOti/fTL4jGnq837awM54bgcIXns6WrZ53c6qvP6th6O3+xykPeKBkc8TZSAU
	 KlIzTCeYrghH8w3SJbQLpKUWeCNBdk08LrZplXnZQlJC1HGkck8e0spO7HNSZhc/lN
	 iHB8DP+UdXRUD6zRlUKy+VSHgs0PxhkFivZ+AbovUoD8WS/JoFIecuxNnoc8V30OuU
	 p6h/fsG/XRAm/ijGoRVK13SBSGPjaTbtI/Y8ETNPnLG6B1ybhQy02WYGAj75x69xRu
	 JLaltjuFkTKqH2iTZF/PjMDREEhxjEckLYiX99wL9tz6i1SVAUqSm8XkP741JIbKTb
	 DLMw4PhfTJBmA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcm80211: BRCM_TRACING should depend on TRACING
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org>
References: 
 <81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 "John W . Linville" <linville@tuxdriver.com>,
 Seth Forshee <sforshee@kernel.org>,
 Pieter-Paul Giesberts <pieterpg@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172917502886.799221.15184578640211936877.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 14:23:50 +0000 (UTC)

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> When tracing is disabled, there is no point in asking the user about
> enabling Broadcom wireless device tracing.
> 
> Fixes: f5c4f10852d42012 ("brcm80211: Allow trace support to be enabled separately from debug")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless.git, thanks.

b73b2069528f wifi: brcm80211: BRCM_TRACING should depend on TRACING

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


