Return-Path: <linux-wireless+bounces-10992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5E948944
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC91F245F9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43D15D1;
	Tue,  6 Aug 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=up.edu.ph header.i=@up.edu.ph header.b="KYvWndbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6851BA87B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924810; cv=none; b=Pe04V7J4GUyx8C6KdZ5ewHXZXMQAkktR+118BjHeTYsllHhRB3bUY+l0peaqcCq0bM6TK48kUk4fEXfl5T3db619HLp25aObWjcJJqV/Pgb/jFp6E26dvJCv9iboe5E72I5B3OjVa0dKiaAWYXn72btKaspqXQDvtwAufsPWRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924810; c=relaxed/simple;
	bh=vv23e0zRW3DrNuqHVZnsF7RrgohQsrzp1+m4BcT4tHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rg3zg6iKYS70zCUW1ygqDvWWvmZIdfNTr32j9Yw/4+E52YBwp3wRyVnXTd9vu1N9yTD6I63clpTXGflUDoUypA/soPOlFSTuD9Bk0WFPby1IEjEnsyccedAcMEEFltr3CxuWLwcSRfKwO9D5pM6eDBfEKd7u9Yv3PJVmsfEyh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=up.edu.ph; spf=pass smtp.mailfrom=up.edu.ph; dkim=pass (2048-bit key) header.d=up.edu.ph header.i=@up.edu.ph header.b=KYvWndbK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=up.edu.ph
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=up.edu.ph
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-656d8b346d2so166166a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2024 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=up.edu.ph; s=up.edu.ph; t=1722924808; x=1723529608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rw0cb/AVJ9ODFJKgdVpVEjuCrgmPiRicSfWb/UJCFo=;
        b=KYvWndbKVqQmliIADckQQxDcCxKYw9fKzBPpFVPoiiiQoArqF4v46gIHASZRpJB0Qh
         4BVmUiC5ROpUiQR3RChvZiQxaDXBBheELcIDa51I2Q9KLR0PVLToVsuMH1kc74vRcR7u
         AGqCARePCgK3Ifm/aFPl5cXXcM1C5qgmNZbJYn/il7aFNECOhBiH1BCyDKhWwBQ8OaFH
         F39ncUZ5AGb+s6XrLahDt8qHMFhP0aET4B4Qn8iXJaqJbTFpruIw8k9SFK3AwMha69W7
         u8HQF4JIiFBZHWrwzL9vsbfQrt6ORwYDE2RTT3AYDYOroTUA7sfbBRC8c3Q9MoHlTywg
         3COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722924808; x=1723529608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Rw0cb/AVJ9ODFJKgdVpVEjuCrgmPiRicSfWb/UJCFo=;
        b=Uzg0YAagZv7gXnMy0CyCUtIFIpNaybQ/7zBXGtw2zWQRjqyIbihaXM2YGyYt8mlOik
         rgxhWJfoMpqyFf5jkM4qgp2bD3EasWuj05xxnzgTAyDAkf+1w6M0l1GW3/sPmtIjOOle
         1pvSikQ0jFGVFb03hWtzbgZgJ+qTrNtwH3UYjSYhp3zE43e1rVfxUaLJJEU79uiyF7oc
         2RJeNL+2MGdQ1NvuB0rVPOiRYTIg6OVq1+hZ4QTtJ3UHvn5RrvlOz236sOvo4HiTdLH0
         64HOVUmj80BJvTTSml7vN4g43RAIm9ZOeg+pmY/j/0zfUFitJwn3PLQkVY8LfNZJZXae
         VZ5A==
X-Gm-Message-State: AOJu0YxRRU5wmkZr7XBuC5wp3rHeR2MnFA1fYimJQrFV1BAIvXcpC4sR
	YjdvazEheNm14iasMOQCK1ZL3LmvfCx8FVo3c7ZMu4a6EL9b87aItLLMHKCy6o8JsDvKtB3eiiS
	WKphTMRgbAVOesGXhP7FhMUiffSQGiTKVi42QNTCk5GUmmtDMUQEX3+QOCCqNnORh9JNMuJe93l
	Z6qJQsNI1rVp6EgzP//8xdMgDinWveIuhw2oSeoyx9yq/lFhIVBBci0g==
X-Google-Smtp-Source: AGHT+IHzgOh2FfMY5Gh40M2lftDUH68sVM+80VRLM6BU6WDXylH2kq8hM8OFCy5zOsVbOvMLhnnOgA==
X-Received: by 2002:a17:902:d492:b0:1fb:8419:8384 with SMTP id d9443c01a7336-1ff5722d6e9mr139341615ad.13.1722924808076;
        Mon, 05 Aug 2024 23:13:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:4453:56f:9200:24b9:c068:6af7:1f42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905e6b6sm78782285ad.140.2024.08.05.23.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 23:13:27 -0700 (PDT)
From: Gacel Perfinian <gcperfinian@up.edu.ph>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Gacel Perfinian <gcperfinian@up.edu.ph>
Subject: [PATCH] wireless-regdb: Update regulatory info for Philippines (PH) on 6GHz
Date: Tue,  6 Aug 2024 14:12:05 +0800
Message-ID: <20240806061203.1839-3-gcperfinian@up.edu.ph>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Philippine National Telecommunications Commission has issued
Memorandum Circular 002-07-2024 [1] on 05 July 2024, amending
the allowed frequencies for HIPERLANs and RLANs specified in Section 2
of Memorandum Circular No. 03-05-2007 [2]. The amendment has been in
force since 22 July, 15 days after publication in The Philippine Star
and copies furnished to the UP Law Center as mandated by law.

The amended frequency table allows HIPERLAN and RLAN devices to operate
on 5925 - 6425 MHz band for up to 25 mW (14 dBm) eirp for indoor and
outdoor use (excluding UAV/drone use) and 250 mW (24 dBm) eirp for
indoor use only.

[1] https://ntc.gov.ph/wp-content/uploads/2024/MEMORANDUM%20CIRCULAR/NTC%20MC%20No.%20002-07-2024.pdf
[2] https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2007/MC-03-05-2007.pdf

Signed-off-by: Gacel Perfinian <gcperfinian@up.edu.ph>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 4eaeaae..27f1e43 100644
--- a/db.txt
+++ b/db.txt
@@ -1481,9 +1481,11 @@ country PG: DFS-FCC
 # NTC MC 03-05-2007 https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2007/MC-03-05-2007.pdf
 # NTC MC 03-08-2013 https://region7.ntc.gov.ph/images/LawsRulesAndRegulations/MC/WDN/MC_03-08-2013.pdf
 # NTC MC 01-01-2016 https://ntc.gov.ph/wp-content/uploads/2016/MC/Explanatory-MC-No-01-01-2016.pdf
+# NTC MC 002-07-2024 https://ntc.gov.ph/wp-content/uploads/2024/MEMORANDUM%20CIRCULAR/NTC%20MC%20No.%20002-07-2024.pdf
 # 2400 - 2483.5 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Section 3.1; NTC MC 03-05-2007, Section 2
 # 5150 - 5350 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Section 3.1; NTC MC 03-05-2007, Section 2
 # 5470 - 5850 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Section 3.1 NTC MC 03-05-2007, Section 2
+# 5925 - 6425 MHz: NTC MC 002-07-2024, Section 1; NTC MC 03-05-2007, Section 2
 # 57000 - 66000 MHz: NTC MC 01-01-2016, Section 1
 
 country PH: DFS-FCC
@@ -1492,6 +1494,7 @@ country PH: DFS-FCC
 	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
 	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5850 @ 80), (24)
+	(5925 - 6425 @ 320), (24), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (24)
 
 country PK: DFS-JP
-- 
2.45.2.windows.1


