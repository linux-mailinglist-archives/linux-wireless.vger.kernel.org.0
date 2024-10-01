Return-Path: <linux-wireless+bounces-13368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3698B875
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57231F2255D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403143BB50;
	Tue,  1 Oct 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDQ9HCYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F072B9B0
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775561; cv=none; b=j2MtY3K0raG25lZiq0ng6qtg3UYi2q8bvSjtdeTUJ9OMkCmlSIut43amHgov3R4oDfe5T4RV1Xu86loKcldrXicqejj7xpLlBUumRQJrvOKkaxugivlkGyZlfYNoIepp8SBUa8yHOFnhKu9d7flXvlC3AzJ1afCYlNod/rCNZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775561; c=relaxed/simple;
	bh=Cj/RW9c2zN+NbMx/NAfIQ/CmXdZBdFbsxCHsQJCCdPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7KsQV8kJ6FmmSPt27eNHRLizNy/rMtnQJ6xZips1pCfCJ8sKDNEzCbSkIDsWzEwhqPuoZDYVLk71uQ865La0ciduz0GcebtNqLsRE9JUGHP1DDLBgnPrCGuZE6Lj4mKL/COG7mp+C8xcJHWYwN7kAfG/mTQ40Qbok5768wNKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDQ9HCYE; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a99fdf2e1aso691406885a.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2024 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727775557; x=1728380357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GhECsh9SXPJbb2DBAQsETsqoslX5T2N7DNUpqx5aA0U=;
        b=QDQ9HCYEIqDKsRn5AOYYPapj3Be6LdUEZzFMEjxfa787kQYvoYteUYlZ2zpJXQMZZF
         I2uMJw5RtZsN3n3a4D0259IHzZ3+DQ6dH5dZKFT/fwF3RqjWDUGzzv6jkSdsDae6nbUB
         OUSTMsc2LPP7qtaIaft/vNjGoJDKNweNycFDGb/UEAqpcWaE1di1m/pSKJLyDKWh1XRe
         LIWhSk588kjTpxkFJoDKN7Z609XeDwp8wrMx6MGQzEbw3la/II+IHERTaswXqVF9qMiQ
         PW+YVVLEttQdSq9aaI2I3jO9GCtBbbcg3SgV8I5uiBusGFnNVWPv3lPwKH9buStctqND
         nCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775557; x=1728380357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhECsh9SXPJbb2DBAQsETsqoslX5T2N7DNUpqx5aA0U=;
        b=JQGe2toZ0uz/nhrRiBbN12OX1SfwIqzCLjG9aSgbHLjI7eRlW4JZX3PfV3YxVy99q1
         1Na68k2ehpG44xaH6uJPWv6G4gXGWjvktebqn+OjA7o4ob3HwzNANxt8+wZfi//6YQGi
         wPOYXXNGBJXRsFhpwOumNkGAiDJ/IlXy6fXFj6BXV4fijVRqwB4sEeVuKSSEHQmqblAs
         GD4StI6qi16bhHqooQPV4QFpk1MzQFduEuc0bnvHWZTm5qz2t9fLyw406QUVuqjoluG6
         G/VeujxTPHq/QqPXe/Eomlb2YkzMRhjc0wMVYkqwrJn6KXWyVphwRUieMuLXhhSBgV/P
         c0FA==
X-Gm-Message-State: AOJu0Yy0Tndp2HkHySIw//dzwSf53gENDljNWiIiJEIyuCgjJwlG6FEE
	f5hCkfzg6C1ntBnhT5DcGveBMVrxhdKbEoCU8W6oMJjvuR2X4kZLR7jzYsJ/
X-Google-Smtp-Source: AGHT+IFmuHzLYLpeKWWe8wJDYszHycY+4m2zBeWjQ3iZyVDCjr4EIFMT0TZf5XxD2UPt5cSXtbj0Ng==
X-Received: by 2002:a17:902:e5cf:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-20b37b91636mr197262625ad.46.1727775091547;
        Tue, 01 Oct 2024 02:31:31 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37d68906sm66102625ad.38.2024.10.01.02.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:31:31 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 1/2] Revert "wireless-regdb: Update regulatory info for Serbia (SR) for 2024"
Date: Tue,  1 Oct 2024 17:30:48 +0800
Message-Id: <20241001093049.37515-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The country alpha2 of Serbia is RS instead SR, so revert it.

This reverts commit 388c80ccba39d4ff4957a5d153c461aaac53e22e.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
sorry for the mistakes.
---
 db.txt | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/db.txt b/db.txt
index adda839f4cf4..54310fb5736d 100644
--- a/db.txt
+++ b/db.txt
@@ -1765,14 +1765,11 @@ country SN: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
-# Source:
-# https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvrdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
 country SR: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
-	(5470 - 5725 @ 160), (27), DFS
-	(5925 - 6425 @ 320), (23), NO-OUTDOOR
+	(2402 - 2482 @ 40), (20)
+	(5170 - 5250 @ 80), (20), AUTO-BW
+	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
+	(5490 - 5710 @ 160), (27), DFS
 
 # Source:
 # https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucion-de-frecuencias-t-0408-2023/
-- 
2.25.1


