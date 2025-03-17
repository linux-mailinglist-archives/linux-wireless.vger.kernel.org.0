Return-Path: <linux-wireless+bounces-20426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE5A643B5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 08:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C9C3A92D3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ED221ABB2;
	Mon, 17 Mar 2025 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQMorf/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6142F30
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196662; cv=none; b=WSPBWAy4bgk6uqWf0lT1XABFwsp3r8oZ7ZoONFjzlLhVWkQWVK4GIG7U9/pOlLfFedvqy2JJmo8H1rxuzz9TSDkA56OysHHrXXzV+l4Qh8iFw0g4vs4STk3IlCdldwMNLVABlyEFOA+DbfNC6JLJ1JHNRrJuHzKBmSfxE/cTS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196662; c=relaxed/simple;
	bh=87dnmlat0UHGJvZCcU7igdz4gbqAFB63IWGL7YGL0Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h9yq2T0fVXDyp5vGht5ZB7+e8hh9w4vWbPz+wmzJgTL0EVnsT04PODmWyCLyfpsoJBSdjmOzHzz8ry+oKpWtvk5G0A2J8FwbzM0+3Au1EV6h9HkgGvSBL1vhNeLplPi7mgRgHb/T4p2KBAMLenjtcAA/WT2q/mDKx4e1SOrmAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQMorf/v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso2733287a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742196656; x=1742801456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t29HzaKRSqHIYvX0OJiY1Qg30Z8JxfxKsZVt8Nfytqw=;
        b=FQMorf/vCYPfR+4Y5+qurA/eN1/fCSEdZ4iaVNYPDLPI1Ge6pfaEzit+ZF2Ux4ZVQj
         naL2f/We8i6x09FjxGgIqPTBQalQVdy0UdBYgYDd7qKDi2znK1GsOLyz0J9xFxXW2KId
         d/oBtoiRW49IKWPFKOvZbfUavDEI5ihk/absigVE9GZZU+1tMsCumBz+OjJHwY1UG1TQ
         NHCH3hSj8pSV34GHskDF5/lW5UQgxmRyq3fXMEEGS043GBInd88g5lr6W5HbmlPGmcKK
         9C1BjLrunWPU95EU43xcsiBRMsPsGw68L979kiE1DRUND1G2faR3w5XH3Psyvu0FsESN
         3AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742196656; x=1742801456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t29HzaKRSqHIYvX0OJiY1Qg30Z8JxfxKsZVt8Nfytqw=;
        b=KY3hj/xtuEqe1jAxwcqYELkMumzwp97Skw/DjoodfsQxENJJj8hzFj7g5m09ApWUMX
         vq2GmQjPYoV77gGoVNm+1bOBFZ4Gdj7LK2Vwta9u7hzQQK2yXgnkJhhPai+iabbefD5m
         9QYeTIBfqZQCj7JOvib9QwztFOQoQ+GqLn1VZsNXh6e8CTc0l0dFavAf9quZ7VB0Bhsk
         cSrVewNVgI6yvBXmSckiVI8LBHUda5NSrBu1E1EzDCPwf8RP801XcnOzkshPaZdWSALh
         wkOJf0+0QrxG9ZxezrT4FiVBX3qdfLYj9lK5eihCfVS41hUVXKd30Z6vZWGjXz6Z1tmI
         TlRA==
X-Gm-Message-State: AOJu0Yxy30uyBypJsH2EWubfoghEtDKK1lVLxQWD6bq3MzJq8mDJ7K6w
	elsXGVweps47Gw5qibMkJgAohW8r51pjFbaDfUiTRiiq5PvAGqrQN8yB1g==
X-Gm-Gg: ASbGnctmn0fKiRJY8u0LOUX+4ta84fZkBh5l8BZiIPrDKmk4RE+3CZQqgjorJyrIXfp
	vOprbi02oU3j8ZntBdG5pV8AQI6+EDZDSWOcpKcF0zmzub429sOTTrtH8vKCmIZeQ0jcjLtmOE1
	iSKznZDnz/0lxJMQ39SAC8/KlsWoGTZ9YR65K0PolyVhBwhfJqQONg+SQ7g/IyaOom/qwM+LjH3
	Bv5ghv1BindbwV2fG8NE+RO2eFW3egulF58jVxT/3qyhB/UT1jWMSR46bSIxCx5qnQAr4iLca5u
	A1snNA+r6TzdwXp8ojUbRSIFHDbYfhWkhbmbc3JdQwJKCwgouBSjJMvTJtvf7Hwiu0ZjysQ4fjT
	rYLmMe+kM3Z4=
X-Google-Smtp-Source: AGHT+IHbY5LOdF3RdUrhqKXGjw4w1qBGqYmHSNLGHK44fc9TZihR7Z+Rd5d4LVyZ5qx47/UHmQuLWw==
X-Received: by 2002:a17:90b:134d:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-30151c798d5mr14245736a91.8.1742196655741;
        Mon, 17 Mar 2025 00:30:55 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301539ed03fsm5338372a91.16.2025.03.17.00.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 00:30:55 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Indonesia (ID) for 2025
Date: Mon, 17 Mar 2025 15:30:40 +0800
Message-Id: <20250317073040.8726-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Indonesia. Ministry of Communication and Information released Regulation
of the Minister of Communication and Digital Number 2 of 2025 concerning
Amendments to the Regulation of the Minister of Communication and
Informatics Number 2 of 2023 concerning the Use of Radio Frequency
Spectrum Based on Class Permits.

According to type 1 access (using RLAN for end user needs) of Radio Local
Area Network (RLAN) section:

* 2400 - 2483.5 MHz
  - 500 mW (27 dBm)
  - 40 MHz bandwidth
  - Indoor only
* 5150 - 5250 MHz
  - 200 mW (23 dBm)
  - 80 MHz bandwidth
  - Indoor only; prohibited to be placed outdoors
* 5250 - 5350 MHz
  - 200 mW (23 dBm)
  - 80 MHz bandwidth
  - Indoor only; prohibited to be placed outdoors
* 5150 - 5350 MHz
  - 200 mW (23 dBm)
  - 160 MHz bandwidth
  - Indoor only; prohibited to be placed outdoors
  (Since 5150 - 5250 and 5250 - 5350 MHz are the same, use this entry with
   160 MHz bandwidth)
* 5725 - 5825 MHz
  - 200 mW (23 dBm)
  - 80 MHz bandwidth
  - Indoor only
* 5925 - 6425 MHz
  - LPI
    * 200 mW (23 dBm)
    * 320 MHz bandwidth
    * Indoor only; prohibited to be placed outdoors
    (adopted)
  - VLP
    * 25 mW (14 dBm)
    * 320 MHz bandwidth
    * Indoor and outdoor
* 57 - 64 GHz
  - 10 Watt (40 dBm)
  - 2.16 GHz bandwidth
  - Indoor only

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 803f1bc5405f..e331d4f763e3 100644
--- a/db.txt
+++ b/db.txt
@@ -882,11 +882,15 @@ country HU: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-country ID: DFS-JP
-	# ref: https://jdih.kominfo.go.id/produk_hukum/view/id/676/t/peraturan+menteri+komunikasi+dan+informatika+nomor+1+tahun+2019+tanggal+24+april+2019
+# Source:
+# https://jdih.kominfo.go.id/produk_hukum/view/id/676/t/peraturan+menteri+komunikasi+dan+informatika+nomor+1+tahun+2019+tanggal+24+april+2019
+# https://jdih.komdigi.go.id/produk_hukum/view/id/949/t/peraturan+menteri+komunikasi+dan+digital+nomor+2+tahun+2025
+country ID:
 	(2400 - 2483.5 @ 40), (500 mW), NO-OUTDOOR
-	(5150 - 5350 @ 80), (200 mW), NO-OUTDOOR
+	(5150 - 5350 @ 160), (200 mW), NO-OUTDOOR
 	(5725 - 5825 @ 80), (200 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
+	(57000 - 64000 @ 2160), (10000 mW), NO-OUTDOOR
 
 # IE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1


