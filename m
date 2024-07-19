Return-Path: <linux-wireless+bounces-10373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960269372BD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 05:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DEC282759
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA322282ED;
	Fri, 19 Jul 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf/UbeNb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8518C36
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359445; cv=none; b=Q0DjkngEU1DiK8S1aEWpYuR+3j0YPHBNPkiGN5d8WvsYWBNTl5q6KD6DsACY5e7FoGMiMFXRf1yONZNcSIjGnNSJb3vds/JLNHKb2eGi8xiKu5JpdgH2zIGIzNDoth/dYGajKetk9MZYon7FHYNbdi+bo2MSWnmBDNePS56/WNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359445; c=relaxed/simple;
	bh=t3+WK/PkjUK/tbsE4Gj3uT0bQMcqSCgBqN0wGzeRmzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JniS6NO7qEkPq0YA+2wpB76f0XOan+BrK/F1sgFtaPFiCYikzR+/0ChqWzanb9ox6f9Mc3hv0jDJs1DDXgfEByCx9YLWW10WrUFFwrPrflaYyc9gG/zb1jOnQPqZKz2MU1ApMor4JCSK1MoDs1lYcWm6PoKgU5z9xftjHgsN1yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf/UbeNb; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d9e13ef8edso908824b6e.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721359443; x=1721964243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8Ek5UHiySv/ZikAPTG6HoQfahyzn35bBCuiqUBISkM=;
        b=Nf/UbeNbwgR1OfpZBRSTW6kmBsxwrZaFa436EOAPsqm77BWq9BbYMvLMX8jft2GZDq
         deMQ803aKj83387aLySj1iAfEAbq4q5kpCTxfQOPE0F/al8ppYX+LIu+VszByDNfjLqu
         Sb+UejOsExtVrGJRU0OoOcoHiKVKaqTo/PBlDvplf+rcP5/hNAlSexLb1z+U3VTJRYrf
         +DGXXjr5hOjtyuGrflSwFJzUz3zpknv5OxH5e7XrFyz2HZ+GfOjoBQKbhtGaNBhuS+If
         VjGWGSUNAh4P+zDY4IimoJvMpFb1CJEHuMmnPSiWYfcLTO8C+V1QQ2t0hefjGx1QxXbS
         hw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721359443; x=1721964243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8Ek5UHiySv/ZikAPTG6HoQfahyzn35bBCuiqUBISkM=;
        b=vZflQRwE3NL6PQuJeS71nonubX/ZaeBu10lZieqpt0wQnpup4evIlRcTNQm0oGauTw
         Q+A8ywwFOamMjw1oSYxc1vXDpTx0bMyYhZCYOzw9pHxYajXkhffLDx5EHVK9Q9MNqtcl
         tkhmaWqcg262QK5hK/D6xHsdbcTrXKiLzE32nm2z7IlCUQZ5fp4QXMAU64HPWiGjPv87
         X48hZTZ+pyncKLYLUfpFJQMn1z/8SrQEpGrq5CoCSzc3Y50PJMjlG0SPgNvIxd2Uuv6Y
         wCYWsCSu2J86Qpjzba8e0oAYUMROK4epCX5OttRrx0+BPR6SS48qF2Lw4+I7MefejY6x
         AKPg==
X-Gm-Message-State: AOJu0Yy75B42FBUe7R+bExjZZ7pVEzlUtZ45hm6OpcnWyprsuZY+LJyR
	Jgr8oich8Shh3NRa5vOswR5eK6YqPACxzGz8YltDDrjRW1F537JI
X-Google-Smtp-Source: AGHT+IF2ZZqGNPieXSKfz9ZikKCJfaWa+px68rTgyyBHI7zz6hWZRiNc/zSLpEEsmXqXQESxsDEyAQ==
X-Received: by 2002:a05:6870:f216:b0:260:f827:243c with SMTP id 586e51a60fabf-260f827439emr3102002fac.12.1721359443424;
        Thu, 18 Jul 2024 20:24:03 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff59fd9csm279160b3a.173.2024.07.18.20.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 20:24:03 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 5/5] wireless-regdb: Add regulatory info for Namibia (NA) for 2023
Date: Fri, 19 Jul 2024 11:23:26 +0800
Message-Id: <20240719032326.7353-5-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719032326.7353-1-pkshih@gmail.com>
References: <20240719032326.7353-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

COMMUNICATIONS REGULATORY AUTHORITY OF NAMIBIA released NOTICE IN TERMS OF
THE REGULATIONS REGARDING THE SUBMISSIONS OF INTERCONNECTION AGREEMENTS
AND TARIFFS on 3 April 2023 [1].

* 2400-2483.5 MHz
  100 mW e.i.r.p.

* 5150-5350 MHz
  200 mW mean e.i.r.p.
  Restricted to indoor use
  The maximum mean e.i.r.p. density shall be limited to 10 mW/MHz
  (ETSI [2]: 200mW (23dBm) -3 dBm to be 20 dBm; DFS 5250-5350)

* 5470-5725 MHz
  250 mW e.i.r.p.
  Indoor as well as outdoor use allowed.
  The maximum mean e.i.r.p. density shall be limited to 50 mW/MHz
  (ETSI [2]: 250mW (24dBm) -3 dBm to be 21 dBm; DFS)

* 5725-5875 MHz
  PTP/PTMP: max mean e.i.r.p = 4 W
  Mesh/AP-MP: max mean e.i.r.p = 2 W
  (ETSI [3]: The FWA device shall have the capability to reduce the
   operating mean EIRP level to a level not exceeding 24 dBm for
   ChS = 20 MHz and 21 dBm for ChS = 10 MHz. 24 dBm is adopted; DFS)

* 5925-6425 MHz
  - 23 dBm (200mW) mean e.i.r.p
    Restricted to indoor use only.
    Mean e.i.r.p density for in-band emissions = 10 dBm/MHz
  - 14 dBm (25) e.i.r.p mW
    Very Low Power (VLP) indoor outdoor use.
    Maximum mean e.i.r.p. for inband emissions = 1 dBm/MHz

* 57-66 GHz
  40 dBm (10W) mean e.i.r.p
  23 dBm/MHz e.i.r.p. density
  Indoor use only

The EN 301 893 [2] specifies reduced power limit of 23 and 27 dBm for
5150-5350 MHz and 5470-5725 MHz respectively for devices that don't
implement TPC. Also reduced TPC requires being able to reduce TX power by
up to 3 dB. The DFS applicable frequency range are 5250-5350 MHz and
5470-5725 MHz.

[1] https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
[2] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[3] EN 302 502 https://www.etsi.org/deliver/etsi_en/302500_302599/302502/02.01.01_60/en_302502v020101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - join to the same patchset
  - 5150-5350 and 5470-5725 only reduce 3dB due to TPC
  - 5725-5875 requires DFS
  - fix wording in commit message:
    * '5725-5 875 MHz' --> '5725-5875 MHz'
    * '10 dBM/MHz' --> '10 dBm/MHz'
    * 'Maximum meand e.i.r.p.' --> 'Maximum mean e.i.r.p' (drop extra 'd')
---
 db.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/db.txt b/db.txt
index b5e40e038d77..4eaeaae616d8 100644
--- a/db.txt
+++ b/db.txt
@@ -1355,6 +1355,17 @@ country MY: DFS-FCC
 	(5735 - 5835 @ 80), (1000 mW)
 	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
+# Source:
+# https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
+country NA: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (20), AUTO-BW, NO-OUTDOOR
+	(5250 - 5350 @ 80), (20), DFS, AUTO-BW, NO-OUTDOOR
+	(5470 - 5725 @ 160), (21), DFS
+	(5725 - 5875 @ 80), (24), DFS
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
+
 country NG: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5250 - 5330 @ 80), (30), DFS
-- 
2.25.1


