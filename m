Return-Path: <linux-wireless+bounces-12325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC796819E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CE91C21F12
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB2185E7A;
	Mon,  2 Sep 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7/35cec"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877C185B52
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265407; cv=none; b=EtNfR6FEiFRUtY3PV5KOBrorxUjVkFqbqsvNSdHpFDs1knx6AQzCOVbcu8LL0CF4dR+iY8br2feI2QFA0oM4pYg0vZ4lAdrtNiGN2Viik/x+vfoGjM9lVitjeXMjIDO+7QmZ7g/35nsjhumqpffpiB+KFd3ZiwNEnWNyOQ0OJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265407; c=relaxed/simple;
	bh=Vm7aIZAdKCa6KZVdK0QmdnHr6SY5teeAaLEIczGzr9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoCzjwvJvRvuFVFqTOS/00IXVeelQVKwgu0pa6/fUibTBJ2aHKcd7QmMW/bMWTzfYy+u8iTUGsaBb2gJxdwQLUjgF84UxgeZruBoyAq4EsaDlU7sBt4alcXs2Yx0/QvIUNwdpWIoQT0hSuqo1rLoR3X6HtyPA4vVE4riLzL8To8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7/35cec; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7176645e4daso12675b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2024 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725265404; x=1725870204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8bTGvEs3Q5r6pWXaNSZ4u2S0bpZw9YNQLa6Yn4tjO4=;
        b=V7/35cec91sgKbhdurHu0yVvyjVR5XO4+KgJwjXOtBSknDYifM8iF5QK9Zs/Nz2lsw
         a+vSToFZNHeTDMTjjcmfct77lZoKJI28pfa1ywe+eoZtp3hows25zq7taNvlXdA+M2QI
         QLLMpz+iUcR5dVzFyYLgwv1x9Fghup/3cdEDU4DG4HV5tAf2eMhf0OC8wSFiuvMYMPX1
         OBldSRTpKHKqiY41rHIfm4V/zUf37IqI58LBreoqoijPLkRVK9tjQT7IRqurno/9C6MC
         lUL4hdYfIZBmFThiJAicGEGy+C2JAQDcfhD6FTctGNQPHQ4ubmJq623Wa/1IAZzyVvPP
         xfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265404; x=1725870204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8bTGvEs3Q5r6pWXaNSZ4u2S0bpZw9YNQLa6Yn4tjO4=;
        b=FIrnwTBZSRVNqwd5fJc5nVG3aTyZfJ4nfLAHTSd20dj8tmx7U1eg8ch0EH4FWY3pKm
         O627iXnsF7u5sSwfMYdhaAidiIA8q+uopf9aBy2MnDi1pWJOAfS+8HMj4hHdOFx74jzd
         ehm6Yk3rVJSB4o9P6HrheRouifG3/AppZHpqiWG5CclR35dP9yDtEurjfyPTovO7VGkO
         mNi/VBkXBSCcKvVrJv9MuADkGukoQKYELx6hTAXnDkTfz9TmR55iAPjZZ+mA1Rj3WVh4
         12xoKT14Ob3jty5AfBh1kFs8TRwLKGJ+kFIQdiOm0xnQYY0giKYXWuiec/Z4S3xGTp5y
         Hlcw==
X-Gm-Message-State: AOJu0YxQr2Hht95sOKBc+xTUbltwsk011/beP50dr+vdnPJwHVLKlT4h
	PMl0DA3g0P+mLNX9+md49EBPMfS4ZRFulrEWZGBp97tr/OG5MRYi
X-Google-Smtp-Source: AGHT+IECDGOe12y+X0pcU97X0ygl9+qJdwuIhgxtbNuVX3Mkkyb2VtLY0pIV31Ha8/KSrYfTkGchLA==
X-Received: by 2002:a05:6a00:b81:b0:714:20a8:d79f with SMTP id d2e1a72fcca58-7173fa846ebmr4873304b3a.14.1725265404332;
        Mon, 02 Sep 2024 01:23:24 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e56d8827sm6376370b3a.161.2024.09.02.01.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:23:23 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 3/4] wireless-regdb: Update regulatory info for Israel (IL) for 2021
Date: Mon,  2 Sep 2024 16:23:03 +0800
Message-Id: <20240902082304.52326-3-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902082304.52326-1-pkshih@gmail.com>
References: <20240902082304.52326-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Israel released the wireless telegraph regulations (certificates of
conformity) on 2021 [1]. Update regulation of Radio Local Area Network
(RLAN) below.

 * 2400 - 2483.5 MHz
   - reference [1] row 49
   - 100mW
   - EN 300 328
 * 5150 - 5250 MHz
   - reference [1] row 55
   - 200 mW; 10 dBm/MHz (adopt 200 mW)
   - EN 301 893
   - inside a building only
 * 5250 - 5350 MHz
   - reference [1] row 61
   - without TPC: 100 mW; 7 dBm/MHz (adopt 100 mW)
   - EN 301 893, DFS
   - inside a building only
 * 5470 - 5725 MHz
   - reference [1] row 63
   - without TPC: 500 mW; 14 dBm/MHz (adopt 500 mW)
   - EN 301 893, DFS
   - inside a building only
 * 5725 - 5875 MHz
   - reference [1] row 68a
   - 25 mW
 * 5945 - 6425 MHz
   - reference [1] row 71a
   - 200 mW; 10 dBm/MHz (adopt 200 mW)
   - EN 303 687
   - inside a building only

[1] https://www.nevo.co.il/law_html/law01/502_483.htm#Seif9
[2] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[3] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/01.01.01_60/en_303687v010101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - update ranges of 2400 - 2483.5 MHz, and 5725 - 5875 MHz.
---
 db.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index b1dca98f11cf..0be933c86c8a 100644
--- a/db.txt
+++ b/db.txt
@@ -905,14 +905,16 @@ country IE: DFS-ETSI
 # IL: https://www.gov.il/he/departments/legalInfo/telegraph_law
 # IL: official document (pdf): https://rfa.justice.gov.il/SearchPredefinedApi/Documents/IdngyMn~ojdQSrkxuAqfZqiM8c1foi3TSZQhp7OMszo=
 # IL: also available as unofficial word doc: https://www.nevo.co.il/Handlers/LawOpenDoc.ashx?id=199708
+# https://www.nevo.co.il/law_html/law01/502_483.htm#Seif9
 country IL: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
+	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
-	(5250 - 5350 @ 80), (200 mW), NO-OUTDOOR, DFS, AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
 	# Table B List of conditions, row 63, indoor short range device without TPC (ETSI EN 301 893)
 	(5470 - 5725 @ 160), (500 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	# Table B List of conditions, row 68, wireless device using 802.11a/n/ac protocol
-	(5725 - 5875 @ 80), (200 mW), AUTO-BW
+	# Table B List of conditions, row 68a
+	(5725 - 5875 @ 80), (25 mW), AUTO-BW
+	(5945 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 # Source:
 # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
-- 
2.25.1


