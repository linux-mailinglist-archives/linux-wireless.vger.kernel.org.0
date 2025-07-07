Return-Path: <linux-wireless+bounces-24864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBEDAFA9DB
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 04:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E9D1898C76
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4B1CD1E1;
	Mon,  7 Jul 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZjPpxBO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D11C6FFD
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856392; cv=none; b=L4ST9KoWT0GHnLgdOkKmA2gZvMd9TxlmFxMqg8v4hmLzYHouA39rvQ7tCz6sJcsSPYc4lkecAnjynZYhPVtMCndpXW1YCrMcp+kZK27D3P+nUNmapbK2aUdl9dP6Z+0KnMO2mCHAj08LKmzCVY1xNtT+77THarsEfkUKTlSWZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856392; c=relaxed/simple;
	bh=F3O7psaOd5BBYjs1n8szPJjiCXSR1nis/aats9YWaiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/KtlEbHVz4xmrBLB/L/KQdjYgAnCPKSOMGoupxYAMStPZGQNUzzqr18lSeFc7LA04MwoSM7QfdODigMaq5W/PCW12WN/Q7GM7H/JWhYP1MuAYOzQkAoM+Hpdsm67qG5mWZzD27XOl4d2l8nxOci8jVq/6v8HQ73ygIoph/GL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZjPpxBO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-749068b9b63so1445399b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 19:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751856390; x=1752461190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx8X3o9APoPQgn0WIpEcwf5Z4PWAuPlq8VwPxSyh4wo=;
        b=ZZjPpxBOISIJbP1YHoQ0iOCGsB7Qgw4ZanYuZNspnr9CgFs+dU/c+sPXkA4qE6fEwa
         lsrgwHTegcDa3KWu/9LtPIxDot/21wXu3hlJW8J0Z+sZssa7JEb9NyygtCCp2GKemFKP
         i2ma/2MBdYPBj1ojMM6eREngCouBTg4DkVvkXXsMzIjPkDCHn9FwcYnCZooSLE1yh8fh
         vjc7wmiQE3xsN2dn4OkzgGe55BknKWhksnIFuqjt3TZm8rV7Zy38rswtiUv4hlN7h0Dw
         t3mabJv9SvsqHUeA52EMwieHFrG4bpqgh1cR//0Zac1RhUJPJ7y8DbPIwXi4mgXA3fyD
         lBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751856390; x=1752461190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx8X3o9APoPQgn0WIpEcwf5Z4PWAuPlq8VwPxSyh4wo=;
        b=Rv9B51inRv+8q75UGh1kmvnPYH+6Ced0ZTdsZTEpKtvCsjfA8UP24AmwZAOVXm8owG
         AWiGY9zhz8KQ04mGuAVnlTStu8TIjQtSzg6S/HtQO1kis77I2d9gSmzhycG6OWV0yhk1
         Vs7kiSSXBFKlGOAgpQOyOO6CLyWYbah+JkG9JNx1icwdiUpVSPMLwukLlnqGcNR1wL4K
         2fEhUunzpY4f9hATjgs+g5/B1wAYaIGQUIU8EejKWx7bnZcvMAkU2tiXq6/WtTKCBaFl
         blJ4w3vFC88Yita6ecedA4T26GuE9A7i6Ym0oEhKgfTjHwJlxi2UWT/PHliFOWnv8IuD
         /wAw==
X-Gm-Message-State: AOJu0Ywuz2ufHYENSFiBHEWHHOdesInp6x2gH8rjM80dafqHFH9b8DNg
	ii/rBGt1oXMnrZmVwaDyjVOQPUoHhRkihJioXm4sw5YsVoOFyePjSinr1P7ZP2IH
X-Gm-Gg: ASbGnctcpqJQ3E92h5fnUdn8haGKPusbrM6qsJx6Z5u6Wqy2xFep9GFiPHVyXs7EFhf
	20VZ2tK+Rz2LbkiqilhDwpDpWZH4xqXNspbgbrwXTtOoIKq27pE8C9lCMMJ6fIBR2Ew1RIKW3p8
	TMFa9pz+wGx+tRVsXVEcMxnxXA/CVYQ+M+f3PylnVacKb5KWBbjrSjKey5tOnXW9EOQCQGc5K9C
	xq4jN3vpomREzaoB5wgGf0V1ztIF6hxUGsXTyKkenXmfvuOuMOnn721jxZ5YJuFwjepoiegPDJ6
	aqjoK6QYygZSKKXa+zPT2pmjfxpONztgW5c/moNQket3IOXlgGBpiFiB5WFYcKmR33OUgmP7TTS
	NKpWh6sEkSrS+1P9zu4h79MDAwp6315Ot2IN2
X-Google-Smtp-Source: AGHT+IGB//0dIHmRUqv7GGFRgwfb9zOE0RNFn3qjwDP61v2rY3kcwt+uv3zZV0ED3+F3uGYj9Qdyjw==
X-Received: by 2002:a05:6a00:4b13:b0:748:ff39:a0f7 with SMTP id d2e1a72fcca58-74cf6f2f331mr7968176b3a.9.1751856389931;
        Sun, 06 Jul 2025 19:46:29 -0700 (PDT)
Received: from localhost.localdomain (125-231-129-141.dynamic-ip.hinet.net. [125.231.129.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce35cd066sm8205274b3a.53.2025.07.06.19.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 19:46:29 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 3/3] wireless-regdb: update regulatory rules for Paraguay (PY) on 6 GHz for 2025
Date: Mon,  7 Jul 2025 10:46:15 +0800
Message-Id: <20250707024615.38507-3-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250707024615.38507-1-pkshih@gmail.com>
References: <20250707024615.38507-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Government of Paraguay, National Telecommunication Commission released
BOARD RESOLUTION No. 1035/2025 (by translation).

The operation parameters are listed on page 6-7.

 * LPI
   - indoor only
   - 5925 - 6425 MHz
   - Max. e.i.r.p: AP: 30 dBm, Client: 24 dBm
   - Max. PSD e.i.r.p: AP: 5 dBm/MHz, Client: -1 dBm/MHz
     (Since minimum bandwidth is 20 MHz for WiFi, e.i.r.p limit is 12 dBm
      for client)
 * VLP
   - indoor/outdoor
   - 5925 - 6425 MHz
   - Max. e.i.r.p: 17 dBm
   - Max. PSD e.i.r.p: -5 dBm

[1] https://www.conatel.gov.py/conatel/wp-content/uploads/2025/05/2025-rd-1035-sistema-acceso-inalambrico-baja-potencia-6ghz-norma-tecnica.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 224edfcd90a9..ba1d7f8f8580 100644
--- a/db.txt
+++ b/db.txt
@@ -1621,12 +1621,15 @@ country PW: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.conatel.gov.py/conatel/wp-content/uploads/2025/05/2025-rd-1035-sistema-acceso-inalambrico-baja-potencia-6ghz-norma-tecnica.pdf
 country PY: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (24), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (12), NO-OUTDOOR
 
 # Source:
 # https://www.cra.gov.qa/-/media/System/D/2/5/8/D258CF18B83A5613B0D590193CB799CB/Class-License-WIFI-6E-Final-English-032022--V3.ashx
-- 
2.25.1


