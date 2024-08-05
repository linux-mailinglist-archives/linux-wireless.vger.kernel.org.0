Return-Path: <linux-wireless+bounces-10957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C55AF947A30
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 13:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAEA1F21295
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531A14E2FA;
	Mon,  5 Aug 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="jcpDq/6u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148913AD11
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855770; cv=none; b=Cdx5RC7rXGV7mTKg20YyBUGEXHJEstd8mZuJ4EXf5bpYWXTtL+8NHqF+UUvkVHagL3f3iXk8jAWvkMj4OCQyi2iWGvXX9OnJUHAs4uuYXJJPQ7ogED9rJNUMPz5Sz6of7Hpnq0xQPYWQiH4C1Ko3OFTOPsNbUmafc4GwswAj4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855770; c=relaxed/simple;
	bh=lTdWPeczTo3SWczuPjNZqpBN6E7vSRF94/kpeZ3mtUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UttNhuF7WHTLDye6r9kFwyfNaWOCulMbzys8h57l7RH/LuyDLLlI3js5ww8y3SSyqa/TRG5XEUBRc+xrISULId0GZY9UNf94l06ReVscTonqTX/e1noBC5DNIZ3ndg1MtPs65gINiuJO8FA+YNJ4nl+SeYMUyDJtzcuaCJmEa58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=jcpDq/6u; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722855752; bh=lTdWPeczTo3SWczuPjNZqpBN6E7vSRF94/kpeZ3mtUI=;
	h=From:To:Cc:Subject:Date:From;
	b=jcpDq/6udxLGxOGYJJOTgwPlE5ZlxJcMabLJHYLFgPCrCf2kGb1d6am9SPQ2xvLvR
	 JTmLaf/V2RtpHN20GHKMG0bIXDZy4sPAE4HfTONaMk8havZmNKFNW5eWS4XTIZLKyo
	 hmoAxcwl+/oTDJ5CU+BO/HstcH5F5IdHMt12JSZMWZt6BNF7QR5Qoc1s7gSXyKqVbD
	 PRapk6szRc2w1+I27FtE/i87fbHj/LxhlTH9QSdNWu8B0yQE3soVJhRCyQaDKjY/Xu
	 EcLDbMWXYsXjMhXX1nwiq86wInRewPreULX5UbP9MpzN9incqcJY6AVOTyU8Y8+gZc
	 njIV++C54LZhg==
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Wang Ming <machel@vivo.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Minjie Du <duminjie@vivo.com>
Cc: linux-wireless@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	dan.g.tob@gmail.com
Subject: [PATCH] wifi: ath9k: Remove error checks when creating debugfs entries
Date: Mon,  5 Aug 2024 13:02:22 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20240805110225.19690-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

We should not be checking the return values from debugfs creation at all: the
debugfs functions are designed to handle errors of previously called functions
and just transparently abort the creation of debugfs entries when debugfs is
disabled. If we check the return value and abort driver initialisation, we break
the driver if debugfs is disabled (such as when booting with debugfs=off).

Earlier versions of ath9k accidentally did the right thing by checking the
return value, but only for NULL, not for IS_ERR(). This was "fixed" by the two
commits referenced below, breaking ath9k with debugfs=off starting from the 6.6
kernel (as reported in the Bugzilla linked below).

Restore functionality by just getting rid of the return value check entirely.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219122
Fixes: 1e4134610d93 ("wifi: ath9k: use IS_ERR() with debugfs_create_dir()")
Fixes: 6edb4ba6fb5b ("wifi: ath9k: fix parameter check in ath9k_init_debug()")
Reported-by: dan.g.tob@gmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath9k/debug.c         | 2 --
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index d84e3ee7b5d9..bf3da631c69f 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1380,8 +1380,6 @@ int ath9k_init_debug(struct ath_hw *ah)
 
 	sc->debug.debugfs_phy = debugfs_create_dir("ath9k",
 						   sc->hw->wiphy->debugfsdir);
-	if (IS_ERR(sc->debug.debugfs_phy))
-		return -ENOMEM;
 
 #ifdef CONFIG_ATH_DEBUG
 	debugfs_create_file("debug", 0600, sc->debug.debugfs_phy,
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index f7c6d9bc9311..9437d69877cc 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -486,8 +486,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (IS_ERR(priv->debug.debugfs_phy))
-		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
 
-- 
2.45.2


