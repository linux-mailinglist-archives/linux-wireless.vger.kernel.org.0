Return-Path: <linux-wireless+bounces-24862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A88CAFA9DC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 04:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EE53AEEF7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56F1C5D5A;
	Mon,  7 Jul 2025 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtOqGWy4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC51B425C
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856389; cv=none; b=tRKbGW5d+dTZsuK6kTVsMRKdkcEBX8atLifbCuRSswAAaaROtpg1bKEox2f2y66JbXjsWvCYCpffjzS/RSi94vigr4xw0pbdPWH/lbnx4F5W+3ADp2OVSKcX0QwfTdeK5Qm72Dj3xlAZoKqk9xcc+i4PSh6aOMZ+t46wmUKJN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856389; c=relaxed/simple;
	bh=003YQfanfIu9VqJrBzj3HE9Sio2Zxb10yPG5z/NNOGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cfLS4J9a5zCHE+zYbfnn2gE/y6NswpMtlj6LhKJTT7XNBB5kdHLhfXt3SvscW1NnDvkZHJQYEsUxf7ckNE8qYOL38Ezg+PXLj8w8G0mElBZC5ogZ+4pG/zCt1SmDT1KY1QxwZyap7fkmB5YBb9RsNZy9bt8DSj5pgH1fcwQx7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtOqGWy4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74ce477af25so1430382b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 19:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751856387; x=1752461187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLFT9YUi2kgk4IHIMXEm1tnwQfNF6uLUtXcFAl9ufZ4=;
        b=RtOqGWy4qnmwyA+/aYjNM1D41U/GiB+tD7SwMjhD8f27YAeS6WtVyPvZPITN/jvtwk
         GObyuGDYH2PJasmhKZQl2ha/PlKeZJBQ5gQiK+/175FlYRAlxNf/6pmKz+HZjkp6DPhO
         8yAoKGnmDHZco8gesC6670/m2VX56T0nzkLTC46vgliAKEN7dKHfyF2DTt+59/Qx0XWE
         /VvIjqbe3XDBMjUkWBRwoQiBTUn0CLf/fJAHOMh7hrSzHEKzzXR6wi2oRulxdvZjyXeC
         mi+IPE8kSEMv90SwHRqsseVC66CbfeQ8Vfo4Yq/ez7BovnfuX+S7kvvtgeD0AQ5NtKjb
         ddUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751856387; x=1752461187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLFT9YUi2kgk4IHIMXEm1tnwQfNF6uLUtXcFAl9ufZ4=;
        b=MZsw7aX7DQuQdSbhhGRi6vrHfmfgYHtfS9uLIcq0RSDmySZZTIcrOnkXDYpgz+EFSF
         ueesRj/dAMonIPzGcRdRQiclqRxKfaAnkqqRae07YbIvHO1uNbVNWdwoBVs+9Qg5nUDE
         gl5c+QRieLLGgVYq6oRDb13lpsAs/BVlRTO4QF7C+NI9k0MtSTwhhxZ/SToLoK8uCKPj
         t2y94HJQ9GtdxBmE5G9qWXoQTy0j9nwWbKkq951wxX/3mqOTWxeUW30gnBKbV2YQvqNn
         igLCxPDIBbbt19LMUH+5pSlQ3zqlnbzqrcQaGzttWDP4jp+OHLvjCqD7JK6JANcsH4Jk
         S+lQ==
X-Gm-Message-State: AOJu0YxbzX+lNRimMLSjlfjq7V1FW/oQaPrH4MnM1d2S1NH3E28tKFDi
	6Gr+4rDA5Ot/5TutUsqZDzxpfASr7b5YKcwOGYFQpb3UY4kYsoaKReWyUyU8iQ==
X-Gm-Gg: ASbGnctNFKrAsPWUQwm8/oguioevZ0zzQ+/SDQBiTchpGuWI3btBdijei9roSgKpruj
	HmB0NcxRi4AXPcdaHzE/jbh4VnpRg38/ACjJQzLZwjQAT9KXfycWjfMdLPziZGF1cQUURKYNJLA
	1iMEFFlXyDKjn9BSEs0WTXW0UvaiDrn2kFuPTgRYKYnJbqmvP4Sx8JUCVnIRwMKsuX6qAClUc7V
	CfoBpxShByw4AQIzKto0Db7XI3E0j853AsKYmMxI6rkczOpv4BAghRVgS8VhNlR6HLdXaXLoxK1
	A8S0fr1CQbGP+exk3z4i4J+a51XoNoY5XFFuzDcXU82tWAcaZNtRaoG/UFfLauoqdCdPhpU0CRc
	EB2qNfllZ3GdRADkOwCuIlc4zAlfV0ygnNpP2
X-Google-Smtp-Source: AGHT+IGZ6t+i+0pA1w4HjlrKayguT9lc3j1A3wPeXlmDAPtkqs9+ohFZq6n50UzOxDd+2xwoBhEIWQ==
X-Received: by 2002:a05:6a00:3c8b:b0:748:3485:b99d with SMTP id d2e1a72fcca58-74ce65c53bamr16375568b3a.18.1751856386905;
        Sun, 06 Jul 2025 19:46:26 -0700 (PDT)
Received: from localhost.localdomain (125-231-129-141.dynamic-ip.hinet.net. [125.231.129.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce35cd066sm8205274b3a.53.2025.07.06.19.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 19:46:26 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 1/3] wireless-regdb: Update regulatory info for CEPT countries for 6GHz listed by WiFi Alliance
Date: Mon,  7 Jul 2025 10:46:13 +0800
Message-Id: <20250707024615.38507-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
countries including
 - Albania (AL)
 - Andorra (AD)
 - Austria (AT)
 - Belarus (BY)
 - Belgium (BE)
 - Georgia (GE)
 - Iceland (IS)
 - Liechtenstein (LI)
 - Macedonia, The Former Yugoslav Republic of (MK)
 - Moldova, Republic of (MD)
 - Monaco (MC)
 - Montenegro (ME)
 - Norway (NO)
 - Russian Federation (RU)
 - Switzerland (CH)
 - Türky (TR)
 - Ukraine (UA)
Add 6 GHz frequency entry if not being added yet.

But being pending to add rules to below entires because countries are not
existing yet:
 - Faroe Islands (FO)
 - Gibraltar (GI)
 - Isle of Man (IM)
 - San Marino (SM)
 - Holy See (Vatican City State) (VA)

Links of all these countries are to point to ECC/DEC/(20)01 [2] [3], which
decision enters into force on 8 November 2024; preferred date for
implementation of this Decision shall be 8 May 2025.

 * LPI devices
   - 5945-6425 MHz
   - Restricted to indoor use only
   - Maximum mean e.i.r.p.: 23 dBm
   - Maximum mean e.i.r.p. density: 10 dBm/MHz
 * VLP devices
   - 5945-6425 MHz
   - Indoors and outdoors
   - Maximum mean e.i.r.p.: 14 dBm
   - Maximum mean e.i.r.p. density: 1 dBm/MHz

[1] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
[2] https://docdb.cept.org/implementation/16737
[3] https://docdb.cept.org/download/4685

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/db.txt b/db.txt
index acfbcbf29887..b5b1308460cc 100644
--- a/db.txt
+++ b/db.txt
@@ -41,6 +41,7 @@ country AD: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
@@ -80,6 +81,7 @@ country AL: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # 2.4 GHz https://www.psrc.am/contents/document/4749
@@ -355,6 +357,7 @@ country BY: DFS-ETSI
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 country BZ: DFS-JP
 	(2402 - 2482 @ 40), (30)
@@ -742,6 +745,7 @@ country GE: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (18), AUTO-BW
 	(5250 - 5330 @ 80), (18), DFS, AUTO-BW
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
@@ -1234,6 +1238,7 @@ country MC: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # http://www.cnfr.md/index.php?pag=sec&id=117&l=en
@@ -1266,6 +1271,7 @@ country ME: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 country MF: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
@@ -1292,6 +1298,7 @@ country MK: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
@@ -1924,6 +1931,7 @@ country UA: DFS-ETSI
 	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5470 - 5725 @ 160), (100 mW), DFS, NO-OUTDOOR, wmmrule=ETSI
 	(5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40 mW), NO-OUTDOOR
 
-- 
2.25.1


