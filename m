Return-Path: <linux-wireless+bounces-10006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413939281B0
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 08:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725E81C227DF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 06:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FB1411E6;
	Fri,  5 Jul 2024 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdsNHwhD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC3143866
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159599; cv=none; b=EgvFPfjIEpPTVxQo8rRzJ9MHD4dqk110fBUqSIOJFFh0ehlYMVkgqJRqRiweAPM2valABwz2S0VB+3C5QrFFB9SIL7e/4XGF8VZ38gWDmmV+Sa8Up4e6e0lRPE7IYnecL8GTB+29E/BrPOa1aDohpIbnRfei3VLkSHO4GcMfVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159599; c=relaxed/simple;
	bh=bCQNsE3onIGQuFg01EXx14fhJIBIjMSsAskZ3WRsaAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LO6zwIm9nJkp5JuyXgwMIwu5IaQoPlExOkJkPBrIP8ayfQyLYajTaMyzOQI5YvAKkAsPNA/KnwOLZENxlUdNxVG7V3nsgwEwu0ZPnal1YftcCWwKaD4tfa2visVuuCbeD2hg6seZimkBPjjd6JFOMy5B/629mEtGYurMm9s1wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdsNHwhD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb4a807708so3415295ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jul 2024 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720159597; x=1720764397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy/rw0xbBkXGdkKZNRIg/o01R0ItXWKlu3eu0T7X/44=;
        b=AdsNHwhDNA0lYoB6853oxnxeGy9IK/uXfHRFi55TwyhTZTxymZW/EK49vwMafciNwg
         e54bnEC9VzUekPbEsC4dSlvZqCRFfCvxosHpb6+pIvSsiHbNnaFbpgAWm/DH0zBPRUbv
         2z1glA4xQipIQeO+CxelgvH6Zw+5YYKw5rvwuV/2tDBGCCQAupXHU31kYwbhGLL9SiRw
         xlLr2rvYtNzQB/sUvOzMam9gDK0hkjk+aQIrKhBCbXtUO277AXvHVVkLJkeA50BhS3oB
         tm/FaqjJIrihV2FjGgVHa1eLo8rp0WS3gN/Q0e4XtjZPl/hOrr6moRVbCWKeoWJpBJwi
         QCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159597; x=1720764397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy/rw0xbBkXGdkKZNRIg/o01R0ItXWKlu3eu0T7X/44=;
        b=h1j4gsXGIF9ceSi270rln4jXPY5ikOuWO4+MxdfT9YIW7Wa1C2Y/flFzc+ruD3udIp
         nOAYZ8WPJ5xzkde9BIh3+No6HjNKoKVMyD7+0Y7zW/Rrse5dM33x9lzOLI/x0OIlybkf
         ktOf/C/gbLKKW9as9cR74Fud8bRRUjcj9G55ZZk9BXGJ60Chk4mkAB/59PokjHY9EWn/
         xXMosDbw3SWTkFbTQ7cn3Z+mTn7vwLkhUULaGzCGd9FcbAO4BYt1GInBfSnOELeeRBtr
         4Fluwhw20IqVZifXFrcKAcXwnEw7R38yq9LfbikvVY5FEkVqQJRploKDWu+5MTAvEaAB
         oQQg==
X-Gm-Message-State: AOJu0YxrQjvm3QSMSQ/u9JCNM8RzyZYIoX3fBBKmajioUpS3ogq9IK4j
	yceG7KxSemAWBhtRrPb2o2Sw2uuLiFs2EQ/9voXTToFRUVR+2+A9dhmVpbId
X-Google-Smtp-Source: AGHT+IHTINdqNzsYyM6RwaaZAeW0rdxMB14HHylDoDotk477Cw7SWaBQFpHGbc2pGtShxK7IesF7qg==
X-Received: by 2002:a17:902:b783:b0:1fa:2dcc:7d94 with SMTP id d9443c01a7336-1fb33e749f7mr23908355ad.33.1720159597031;
        Thu, 04 Jul 2024 23:06:37 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb4e7c31afsm4644645ad.2.2024.07.04.23.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:06:36 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 4/5] wireless-regdb: Update regulatory info for El Salvador (SV) on 6GHz
Date: Fri,  5 Jul 2024 14:06:12 +0800
Message-Id: <20240705060613.28909-4-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705060613.28909-1-pkshih@gmail.com>
References: <20240705060613.28909-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The General Superintendency of Electricity and Telecommunications Makes
Knowledge to the General issued resolution No. T-0408-2023.

Free use within the entire band for WLAN (WiFi) application, from
5925 MHz to 7125 MHz, must have following technical and operation
conditions:
 - access point
   * P.I.R.E 30 dBm
   * spectral density of P.I.R.E. 5 dBm/Mhz
 - client
   * P.I.R.E 24 dBm
   * spectral density of P.I.R.E. -1 dBm/Mhz
 - Indoor use only permitted

[1] https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucion-de-frecuencias-t-0408-2023/

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index d6b14c055afb..2a4f1ed524c1 100644
--- a/db.txt
+++ b/db.txt
@@ -1736,11 +1736,14 @@ country SR: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucion-de-frecuencias-t-0408-2023/
 country SV: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 20), (17)
 	(5250 - 5330 @ 20), (23), DFS
 	(5735 - 5835 @ 20), (30)
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
 country SY:
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


