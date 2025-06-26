Return-Path: <linux-wireless+bounces-24536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D1AE9A75
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF521790EE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738F29614F;
	Thu, 26 Jun 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hukQDG+u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A15214A94
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931614; cv=none; b=IraEYjQW9vyasHUjQ30meG5GnpQnosGxU0bDF2rBth1GqbXwpFbEOL+juP7rStNXu5x8RoKy1DYa02tlUoO3vOzv3FrZGoPDr4eqskqnSb/uoDHRS4SQe9tcW8Lf2sS0Anf+4GMDBops4fLGPFhpNoQPe9KDGYx94MdaGTrF8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931614; c=relaxed/simple;
	bh=fZzYTAEGbYwpignKXTl3sickf+7f5NZQoSDvJ+zCv7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rchFUTbHOSIVBGX+dDDPnza1dVU+VQumDMnjrVzgJ4PnIr9XeDSL+mF/6pZHwPOWvwP4cpzTTl47BtnVEbSVvn8nI05EHV2rpSzMjNJXRN1FZYRv2qpMPkI4JHVLjJ+rwMIZc89CGW6BrSs48NhSgkluIxlJavyU+iG2b9xS2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hukQDG+u; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313f68bc519so623219a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750931612; x=1751536412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umoGUYQe48OfV5fwGyylK64REtd9n1DfkxW5EqG+gec=;
        b=hukQDG+u6hXzXHHda8pYhifuDzWQeML+LUiY0NOAheLMl2Haf/G2qzkS8Mp/XDyXsB
         qTWEdc0OvM79fUh8m+ON2UhRTXgf3R0LqBkdbFJZmHstbhO9ty5dk6TSFHdPA6FW7f2/
         wWpDunddDLtw4D7HLvqKdqMAEbWfRbK/OH88gHyNz91WSXga4RbCyqY4Vnr4oyZHIKj3
         BTyl4kpSTWrXACzebf1owAo3KZjIV/IqCWp52QMjhsof7K8c8uM4x4kh6BvrRaIIejof
         yEwPzcF1fSEQRKTuvnVg5zkjYPJBrV4bDFRqKwe5v2aIrRqh9S2i/Ac9Ioe7R4K/IvWw
         kFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750931612; x=1751536412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umoGUYQe48OfV5fwGyylK64REtd9n1DfkxW5EqG+gec=;
        b=FKNGxJ4e9v8drvGdK09OYE9ybA0187F/SLRBEsHDcvuzJguKY0OY2hl2PNg0Zhhfci
         9UTVi54Lvl8pZuj8FmWI7AxyXc873U+0iTNiixTFlbyNyve9ubQYnS8aToIQ9L/qAhPI
         Wl7ZVpxm5AnkJUXg7A9rgPuWAmBkwMrY9Z9y93Wwn98AsPciAVD/uveUEgsM6/vw1TBA
         STE8g7LxMnt1hI+dgQefnnzSM5l+gklrBANFoxEG6cf1lZ9xHiuzrMRwsvOu3gnpg0ds
         w+3jj1xki01lTEIxAfiNoOdt5miQr0bEuWFLSadSPQka3m7lQ+SynQ87tLe52ua1VThF
         ZX1A==
X-Gm-Message-State: AOJu0YxC/amzEupB0n0LFoHHVzsCUeWdK4WYW02qCi2wMSwYNRp/8y+P
	HUY4TB4oBjXW9NV9tc1lrmO2/JR02W506fkO/wqru7GhRXVqwFZVX1ysNQwkZFAg
X-Gm-Gg: ASbGncsr5u0egRQquAeKW2yLpuLkF+y6+3+dDpe/qY5fHiYbjC9jQTNt/qfpzlVTYIn
	JpIih4tIXBJkkqaNlJimbh0kT3V0mLAPJCo1YBfqrIzi+cGtTssPMPfVl3Zntxnb5tHKinviQI2
	rSk6BVXPcPkAnlyynoMnscGK9PoWoOczwmgnD7REsmID+yaaZNLy4wLYOHxrwQng91JwwD9bFcF
	E0kfk221HZUWAmL/UMPfPjqA31x8gUKYRlAcsb+FmBWdJgUoRhPcsJqGTM+9Wy1NEvqi2phH8De
	9Q1ZEVKk5lNcf6kegIDZfLizdOa59o2DL64w6MwhKqjtk3rRsDlVkOz8FZGMFIB3BIc=
X-Google-Smtp-Source: AGHT+IE4u1wjlqpnZwCtzwCzN8lsdLc5uxDFnvFhKRwltl0hwS2kIseIBzeGS/5ZNVgtkOZovl3FBA==
X-Received: by 2002:a17:90b:3a48:b0:311:e8cc:424e with SMTP id 98e67ed59e1d1-315f269d1ffmr9858405a91.24.1750931611952;
        Thu, 26 Jun 2025 02:53:31 -0700 (PDT)
Received: from glados.lan ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5428ae2sm4073980a91.28.2025.06.26.02.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 02:53:31 -0700 (PDT)
From: Marcos Alano <marcoshalano@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wens@kernel.org,
	wireless-regdb@lists.infradead.org,
	Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH v3] wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Date: Thu, 26 Jun 2025 06:53:20 -0300
Message-ID: <20250626095320.2948805-1-marcoshalano@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602121434.3011282-1-marcoshalano@gmail.com>
References: <20250602121434.3011282-1-marcoshalano@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change rules for 6GHz on Brazil removing `NO-IR` and adjust
the maximum power according the normative.

Change the comment to point to the newer normative.

Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
---
 db.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 803f1bc..eda4eca 100644
--- a/db.txt
+++ b/db.txt
@@ -322,7 +322,7 @@ country BO: DFS-JP
 # Source:
 # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
 # https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
-# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
+# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2021/1510-ato-1306
 country BR: DFS-FCC
 	(2400 - 2483.5 @ 40), (30)
 	# The next three ranges have been reduced by 3dB, could be increased
@@ -331,7 +331,7 @@ country BR: DFS-FCC
 	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS, AUTO-BW
 	(5725 - 5850 @ 80), (30), AUTO-BW
-	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	(5925 - 7125 @ 320), (27), NO-OUTDOOR
 	# EIRP=40dBm (43dBm peak)
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.49.0


