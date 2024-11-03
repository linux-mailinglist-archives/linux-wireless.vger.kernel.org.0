Return-Path: <linux-wireless+bounces-14848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4EF9BA66A
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2B81C20D3D
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B5175D39;
	Sun,  3 Nov 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HZeia+Oz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7B15D5C1;
	Sun,  3 Nov 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730648347; cv=none; b=RzE76IluEgza+PRsefUM0PuZlmma61MReaDksGrwntgWLmoszq2e/sUEqmR9oYQmn+gtWQalUsSrgaNSIwGGUoFuVq3qlZLaUBLNVy1lIkBBbd66jFl8Xl6iwFd6rGldpU9VBlxaG4eT2yRNSfdQx4v1IF5UT2obr9nY65ITylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730648347; c=relaxed/simple;
	bh=/JhnV5TnR5mf9r4USEDaINFGa88PDHOV7R/4923mRt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utrkEIG9pqJz/XAiOEyPNH9ERu2nMjJuN4s1DTLyLsQYn3rvaz2EW1RaVaYAO6NP3MgDDYZWW3yl+Jli18lqm+uIGuIuPmbQmuNblNlTnNtF12CjSIitEkeUNI2b2JQOis5CKuQPgi8OHEMeLnjFzat4Vop/kF2r2raSAE6G9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HZeia+Oz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=OOZ5eVSjFlNUjtO2O93/lBUiBivCtll0TCegO2d8i8M=; b=HZeia+OzF1aCuiVH
	WV7JhLlfIWxWaJ5vG6Xdt1nhSe4LaqPTPDGfHC6MSm9Z09tMPWSXbLH8hTmPJErck35c6J84cwZqj
	YdXbNuNM0+QvL8MflEWzFTInjzNSOjcAv4vAf3t8DgWKIChEddVSeSrUiZUPkXvz/lTHtb61sVrgG
	crlJSq/ZOGYLVt+06QfsLLfnqIW00mydFIOiB8+gbFEUgPyvbglrFAuOlh2nN0lj+/P/mT1KG2AOd
	PSkWv/Zgl2Egh5AZIxGrPDFQEptqt7XaVQXVFNm3znJm116oSTc57dj7/8NV8vO0LMECFMJz4E0xa
	rGLlGFLjIT72uUf3Ng==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7cgs-00FBKZ-1p;
	Sun, 03 Nov 2024 15:38:58 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] Realtek wifi deadcoding
Date: Sun,  3 Nov 2024 15:38:55 +0000
Message-ID: <20241103153857.255450-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This cleans up a bunch of unused functions.
I've split it, I think based on where they were added.

I'm also suspicious that exhalbtc_pre_load_firmware and
ex_btc8821a2ant_pre_load_firmware are unused, but commit 6fbbc82adfb2
makes a promising sounding reason why it's there - but I can't see
a use.  Anyone know why?  Anyway, I've left that for now.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dave

Dr. David Alan Gilbert (2):
  rtlwifi: Remove unused functions
  rtlwifi: Remove more unused functions

 .../rtlwifi/btcoexist/halbtc8723b1ant.c       | 11 ---
 .../rtlwifi/btcoexist/halbtc8723b1ant.h       |  1 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  | 79 -------------------
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h  | 10 ---
 4 files changed, 101 deletions(-)

-- 
2.47.0


