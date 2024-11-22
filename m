Return-Path: <linux-wireless+bounces-15587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DBB9D5867
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 03:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB0D282952
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 02:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9165078685;
	Fri, 22 Nov 2024 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVzthO9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152A7603F
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732243373; cv=none; b=KTon/nFedzaRjkn6aeLZvOEB1I4QskNAtBLEfwJW+jGFOk9174Q9IXzrgKcDptx5qtq7a1IWZ37OPJwDOZ3TYdzJWq/vOHqOoKp181MYVASphQckhR0Q078u38ycRmzSj0PHuVhJXFaNZWv4tLeuHlT21YY8h4y8M96Wy/CGP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732243373; c=relaxed/simple;
	bh=0gkQFy9jgtV9dJ/wfeN5/vC6yk9A/+O4d086ohbk/R0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=abFwXyY2hCRIJpsoXl7NZ7wpg30U8x7X+KUJW7q55lsGeQjPcnzQQGsiPiF3drNkhp/BnW6jCXfc/oEvig4imJWTxQ8EqH2oyV7WHJAici32qKPnCfX2fW/OHWGLy8j+/LDZPTLDMOhOMxkqYNGgJK9dNIbfTKR5ElXAYZ9xvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVzthO9k; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5f533e1c2so790779b6e.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 18:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732243371; x=1732848171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cVe/+wqiGKjm1Oap39KObz1CHDyXgx2KimEm3G9qyg=;
        b=XVzthO9kVW0bxK6z4gObqMUn2/KrYmZnfE3ZwGLwegfWKrk3xs7y/e21wzDDsQQ6HN
         ipTktMrT/85ZAEUYa9J4LIyeL495ULHeNSM2Ti7nlbX91c9dp9s6idrEByKdsvZN//V3
         mQq4AHZRe7iYgehIMZHTkTOmrsUIdd6VYwVFgHnLuuA60iXvH2alZMABVFg//rF+MyCi
         jkzxS9pvSTyrvZ91CK6BbhTkOAnMmp5vId6HtgFCYlWFnvbWSxMv2HuEFhVef6BTpd/A
         AE3hWUFTsau3CyABimHqi8giiSMWaquTH+RQLiInUmKz/INbjEAtbouflLCQlxEjYQnt
         6gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732243371; x=1732848171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cVe/+wqiGKjm1Oap39KObz1CHDyXgx2KimEm3G9qyg=;
        b=VYH0hPXzDTLt5UeD5YKzhJQJLZvgXufwRz9+kS4Pc2SF+l4pnoxKSvEVCos/vux5PX
         o7MmOzS2schlpssmO0nvRDbDL4bLnciTsg+FoqUMGZWtoiREk+uL2td7bsMUhHG3WoAc
         GsSFVikweWUyEffy94fne83k3HXdR1nKBahc9/e9anKxLF3LR24UXjL5LYnBWJfPofl4
         c+AIXl5/w2cUN58nUmjn8+aBs1icAVsXXZKQP5VjU1u4mZt5pyyW1MjyriZ9SZWBI8qz
         BJJooZGW4Jfgzzm5WPuOzhecdWoz0JOqvob4XMioKTbFct2k5VxjF/0HzhJ5j1Lg5pqL
         3OJA==
X-Gm-Message-State: AOJu0YxMHpaaf4DvxXd3FwF5c3w7c/UXHM/iFXCqN1P8+/QDpVJXXhqV
	rpedV6lvs7+KFEQJ7pVqj6gFOwyvEabfXJvHOIGcsgM7BaNd3g987NjrXzAX
X-Gm-Gg: ASbGncuhUXRDBvLCcymyf7+E6ZMCw4mbzsmgV63PRiJWQ5LLTcaP7cy3gDmzFSQ5EHT
	unih7ufqzoV7ptCH60pIdKwrLl7UOdxs2wrgq9/1dAtA774h/gRFwWvV3grl5/6GPcaeJfSTZDZ
	xPPwmyd8ttPSCT/3dAo5F5LRt/CZF+vrJk6WJT8utaM5s3Zp7F3+0R3HHnDMDRRLBJKvaAxothG
	aPuM2ll8T4lI2MgjvL/2UOKssXo6gpYBTxSkK3gj5Go8QSgurPQbxE8LS23qDUS/iyx+GUZ0pCx
	/DmBQTRrbqQuhFNK
X-Google-Smtp-Source: AGHT+IEx8K4WJ8otuKn9D8sUj1vhbgVHrhJtBgYXgOAjANMqXGM6/sr3oznn2+gh52Ect5OP7AkEYQ==
X-Received: by 2002:a05:6808:30aa:b0:3e5:d5c3:e88b with SMTP id 5614622812f47-3e91586a01amr1432848b6e.20.1732243370878;
        Thu, 21 Nov 2024 18:42:50 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-724de55ae00sm481960b3a.163.2024.11.21.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 18:42:50 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Moldova (MD) on 6GHz for 2022
Date: Fri, 22 Nov 2024 10:42:07 +0800
Message-Id: <20241122024207.5535-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Republic of Moldova released STATE COMMISSION FOR RADIO FREQUENCIES
DECISION No. HCSFR1/2022 on 23.12.2022. [1]

I says, by translation, for wireless access systems, including local radio
networks (WAS/RLAN) operating in the frequency band 5945-6425 MHz, the
provisions of Decision ECC/DEC(20)01 apply.

ECC/DEC(20)01 defines:

* 5945-6425 MHz
  - LPI, 23 dBm, indoor use only (adopted)
  - VLP, 14 dBm, indoor/outdoor

[1] https://www.legis.md/cautare/downloadpdf/134846

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/db.txt b/db.txt
index fc70e625e81a..5710545da0b6 100644
--- a/db.txt
+++ b/db.txt
@@ -1222,6 +1222,7 @@ country MC: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# https://www.legis.md/cautare/downloadpdf/134846
 country MD: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1229,6 +1230,7 @@ country MD: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # http://www.cept.org/files/1050/Tools%20and%20Services/EFIS%20-%20ECO%20Frequency%20Information%20System/National%20frequency%20tables/Montenegro%20NAFT%20-%202010.pdf
-- 
2.25.1


