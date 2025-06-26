Return-Path: <linux-wireless+bounces-24531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DDAE994A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B454A5646
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EC71E25FA;
	Thu, 26 Jun 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alTJPQ8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870125E448
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928306; cv=none; b=MTn3dZt8zdSVZrAaQB4GvoNaWshsE5Z8VOIH0ClyJfnO771oULXgovsBsjyyaJsNn+kByLXqwULZHtWUn6/kKs/jG1gkMh/lO2KgZEPqpbgEzbVB8vCCzZEufn6LiApjQVWEqV8nJceexOn5c0FiqHA+gxcCH0tBzHOD+1T+njA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928306; c=relaxed/simple;
	bh=yJPFFRrEtfLrU/IrZwIP86F5vsPeQCg7lcvpJ/N8gfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWYtJvMr2ZThYVUff9Zlqt2bXIVzKvvejtc6yHJcmKchggbs8qF7EAuVf7aDyVBcwMdfFGjyHz2TDvvYayqFVMy5LM8QM1C9NdU6R+Dm8C6/hxiTTOXx0/UrD4HP0AZ6mdoUEDakKLBzgZDyE3hbGrXCoWlCxeCGgT/pjNCk7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alTJPQ8s; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7494999de5cso554653b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750928304; x=1751533104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEnTNGf+JVSlAmdexfBtW1ws7OdnxAZZ4hs1eOrDZk4=;
        b=alTJPQ8sW8e1FaHBO6a/EYXn9zJL9IDJrlWiv4kwCzvnEITZ3YxuKMpG9Xgz04c+x3
         su4sIQHimtk9IH1N3tm5aF1xb9QaqORZ+m3c7qPVJSmCLTOK5SSTpZbllaaw0f9sRt5z
         1z08zHbFbUe3M4CfMca8GDFZw0TuVQzM2FkXk9vYJCjp6KiPaHo8hEBIyFep13L5jwQr
         hi/P45t9RivZqtwHH/9kNu4Z3px4DfaTqDlSJBnObCWVRuMF6UTKfA6f755g6vJp4tYz
         iqiixyG+M3Va1yGzGcp2GztObc5RxHPQ/xQ6vk+hJ9ACxWw5Gv/vbILfIxSDVTWeoZYJ
         YZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750928304; x=1751533104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEnTNGf+JVSlAmdexfBtW1ws7OdnxAZZ4hs1eOrDZk4=;
        b=sAWnyEh50z+GA0BTfdJbG04ldKKV2Fk+6FDFg+ILZWiRVQ8bxj/n4b4SvQDdiKgWr7
         WcvSKdQ79pQyy8IArFz8gj/D62qIFwMK9EjF4Dma8j8Btjly4PWSkI6XkHEBSUZzUAR+
         lO9v35nZoJoHZab0pBDaIHboFUa/Q4AmfG//hiuTiS0Y01cpnnyBl6La+5cusAXvEIFk
         LtBHZEWymTpuyzmLi1fvAB5irtscSxIW+8p6ht1dYXDURQJ2mRtHrvYc6AqWtk06WtLx
         6vu/c8CIpscewLW0gOFEV3UXf5bcC9/T0SYiA1Su1wUZS/VHuM/53CElrniAFl9QK8u/
         S4HA==
X-Gm-Message-State: AOJu0YyecXTY7APL4CTxLvwlxNseF3y1p1yH4T3oSH0fsrdLSP0XRe+D
	YazKl8H1JSoPryeRTZNFJdarmPs4jR6zVUkWz49xo4f0my2S4J+1ysV8ujjoZapJ
X-Gm-Gg: ASbGncvDgpGnvWkjfXSWIwXQPl0f+kap2OnqnBk6WeLTnaBb8u1m/dvZLRz9x/3UikB
	eDADNuQA7HE509UkVxHxYACblrZcVzrt7Red3F9lpODN1Af3rxU5hzFkIUXfGPD2lgoNuFJhO5K
	gGGAK+z6k7n+PVWOHiJWirXNumN6ETAQCfXRoUK/L/ODJ8Y22G/AaSSa0aFEaZJy7+d/+5oacfb
	2UC6GtLS72HbrP+TGCtgEBI2Y1JVLDLzuPAYpcCK7sLWZKmd3bmEZxSCzJXVMP48ARYAZLRUWYI
	Ix3JhUNNsNCZRD490o7jkJq8/fqIi4Ex9rA1uci6eg1DlVTsH4gOCThf7QOYX/fldPNdkFecX0t
	3+A==
X-Google-Smtp-Source: AGHT+IE6ac2uZCeSMFr5WZDfhXKG4/J7I0o5Gag5XrIgjI8K8EtPh7uiyf49FmHv5rEf1Yng1jir5g==
X-Received: by 2002:a05:6a00:1953:b0:748:de24:1ad4 with SMTP id d2e1a72fcca58-74ad44d1782mr8729452b3a.17.1750928303563;
        Thu, 26 Jun 2025 01:58:23 -0700 (PDT)
Received: from glados.lan ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88723e9sm6408130b3a.153.2025.06.26.01.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:58:22 -0700 (PDT)
From: Marcos Alano <marcoshalano@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wens@kernel.org,
	wireless-regdb@lists.infradead.org,
	Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Date: Thu, 26 Jun 2025 05:58:03 -0300
Message-ID: <20250626085803.2392872-1-marcoshalano@gmail.com>
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

Change rules for 6GHz on Brazil removing `NO-IR` and adding
`AUTO-BW` so the 6GHz band can be used.

Add the relevant normatives in comments.

Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
---
 db.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 803f1bc..f74819c 100644
--- a/db.txt
+++ b/db.txt
@@ -321,8 +321,8 @@ country BO: DFS-JP
 
 # Source:
 # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
-# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
-# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
+# https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772
+# https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915
 country BR: DFS-FCC
 	(2400 - 2483.5 @ 40), (30)
 	# The next three ranges have been reduced by 3dB, could be increased
@@ -331,7 +331,7 @@ country BR: DFS-FCC
 	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS, AUTO-BW
 	(5725 - 5850 @ 80), (30), AUTO-BW
-	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 	# EIRP=40dBm (43dBm peak)
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.49.0


