Return-Path: <linux-wireless+bounces-15702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12559D9069
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 03:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702A428AC04
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 02:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72594CA64;
	Tue, 26 Nov 2024 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g09V5xVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3832B9A5;
	Tue, 26 Nov 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588462; cv=none; b=OXO0e8HLRm8RKCIig47lPPjal7yxlOIu+KPU82JFvSYUoKiCytO9Bana3itt9yesj4/SbdlGxEfbEqsvnRjbCW+tGg4c4cNqIFQny3ubz9hIBcOI6G4m4MKg926cwEwul41qBKiwg9H+J0h+OaeqcbmHGRHyQLzA9oDY6iTEs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588462; c=relaxed/simple;
	bh=87SuTX8gBS/t6czAJaTXBQXhASjsJl9adDc6venCJ6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZOcFHfOclET8kielRw7GHVg0fA2FiCQyrBQs4GYEjfhRxHJRNGXT/wqVrvjYqR3bzt2PLdUxITVmoWslWG+6NoU1qmNLWfLDbPiwwDQCTncW3i1+4m+doWBVlxyXLC6tVbLVS7LIOgwt8BaU2T62zeZxkSx23vqun88zWfYWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g09V5xVg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2126408cf31so37198935ad.0;
        Mon, 25 Nov 2024 18:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732588460; x=1733193260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEMoY4+mJ+RgR/LDgWz+p7hM5OG52CaLPVyxQ21UnLA=;
        b=g09V5xVgSWB7/BbXttPctVbpTe39Bv5rgpN2Wtm0S/EdWE5sK0cqFTM7CLjW0TOoLa
         jnTJg3aYF9PEm9VI31lh3HQ6RBunM0MWTxoMjRaes5Ucmaeawx1ubtLoDgt8vAtfa9cO
         P+WN/iilGEGq7V0oCeVpN+2aezm9bpetS18+3i/VsHcgww1seIApPxDvCKbSKlrMu2Tp
         kUIGMHs6Mz64+w32qc5jBkcN5JRLKSkEp0WIkMjRiDIvK6n2raTRUYPPJ7NFKG7uLleP
         eUW0gByo6wBHHIMzN+R8FvK8Cx7swzYdg59h1O8uzR3itRNcIMGkrBxiDBEgqqXv1Tu0
         63nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732588460; x=1733193260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEMoY4+mJ+RgR/LDgWz+p7hM5OG52CaLPVyxQ21UnLA=;
        b=MgAEW2ORfY1uIRhnil9RW0Scpa8De9woVtqE+XB6S7Yt5O+aFJtrocUz1n1dYEMUSP
         i+zF7eQqfCrI6+5Jj8EnFhnbw+UjWYcHj/2WLsbquNqo/Ak6/yP52x90FmD7DEjP8jSA
         tl3KnftlEDBDYSaUnNkUuznsWDofU/2tDENLdMWV7ZsrXUJPlxAme50BGk1B2f/gG940
         cjra0HLVxf9N0F/aM/PTN18SsSZAUeSAoHWdXWagA3xrgGIS8PX5yivr9JRJupxvwFDk
         whwNw4paHC/MXlAIhrq12jO6/FltH2ewsb94Ptv3I+r1zH+gSw/RxnIP9DVlZRtXjeYG
         uHOg==
X-Forwarded-Encrypted: i=1; AJvYcCWUXR5menHrLOVs2trgVWFX9O4pGhSq7Am4eSxHEByAPHAaf3B2tOvu1WUPD4yjTGinLFi5R40ri4MzhAd0oaI=@vger.kernel.org, AJvYcCWfg4qKqMIjharHP2DRc60hTjXFy5csGug6PfHssk5131Sok01VpY9WxhyGOfsmeT5ipbF2XGNsCFb4gn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXFJkWPINEgLnnr3OJvsftbzp2cG9YAtWb02MSrQYk8sEupWr
	gasVmDQ2rwK5ujvViTZqx0jk91gn46cDEuIPOhlSN8+UiMQyfw39
X-Gm-Gg: ASbGncvlOUvixo86z7Akdk3fiULlHKM7y4EN1uLs6rRRFFgjWRJTzxThIVqiVIvgzXe
	/wINi79HANxTTsQLuxCIM5fr5cMWWY1YqW56+/tzUL9xFXxCWAYGrHwLqtY26nrJG2YwE7ey5cI
	mb2Ed7AazQnJElee0tW4Z2N3jNZNDwHHBcnJFxrE67/nGj2R2U81Tr8/emEa3Tl2iYozi6YL9xD
	mS+1uuiEOhxNv9ptvAAy3Qd1rX+FMfYTHxMFU+sA6D4YDI+YGFdeKgHGnk=
X-Google-Smtp-Source: AGHT+IHnhYzQEtLUX9PuW3hVYMmYuZu+RDAaSNzMpmlQPuVvauOY4ym3QbjsAhq+/UFo6H6GV67MhQ==
X-Received: by 2002:a17:903:1c5:b0:211:d00a:1974 with SMTP id d9443c01a7336-2129f52d42cmr185147575ad.13.1732588459683;
        Mon, 25 Nov 2024 18:34:19 -0800 (PST)
Received: from LAPTOP-SQ5KB8RN.lan ([222.249.179.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc06adcsm73030115ad.166.2024.11.25.18.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 18:34:19 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: markus.elfring@web.de
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zghbqbc@gmail.com
Subject: [PATCH] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Tue, 26 Nov 2024 10:33:49 +0800
Message-Id: <20241126023349.46421-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4b1b5c12-3f81-4004-8eb4-44a9fbcc7223@web.de>
References: <4b1b5c12-3f81-4004-8eb4-44a9fbcc7223@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the OR to AND.
The previous code used OR within parentheses to check for
NON-NULL pointer on one of pipe->dest_ring and pipe->status_ring.
The previous code can not guarantee the pipe->dest_ring pointer
is NON-NULL. When certain errors occur, causing pipe->dest_ring
to be NULL while pipe->status_ring remains NON-NULL ,
the subsequent call to ath11k_ce_rx_buf_enqueue_pipe() will
access the NULL pointer, resulting in a driver crash.
If it is assumed that these two pointers will not become NULL
for any reason , then only need to check pipe->dest_ring is or
not a NULL pointer, and no need to check NULL pointer
on pipe->status_ring.

Signed-off-by: Baichuan Qi <zghbqbc@gmail.com>
---
 drivers/net/wireless/ath/ath11k/ce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..cc9ad014d800 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -324,7 +324,7 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pipe *pipe)
 	dma_addr_t paddr;
 	int ret = 0;
 
-	if (!(pipe->dest_ring || pipe->status_ring))
+	if (!(pipe->dest_ring && pipe->status_ring))
 		return 0;
 
 	spin_lock_bh(&ab->ce.ce_lock);
-- 
2.34.1


