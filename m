Return-Path: <linux-wireless+bounces-9814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B90591EF73
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 08:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED15B288C08
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537D12F596;
	Tue,  2 Jul 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ACXEqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F512E1FE
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903082; cv=none; b=vAXnFkmx+qaauYLJo1CexrUlyhXCpxUaC70EnasIHn0F2bnJz5CAyMUbrxVZv1x2akI/hiU/+TYDb0qM98FqJY1eRX4s1Vze9KP+pS9IeaZvfXpLGTSG316pNIkg3vUgi03+0qNdFcM5RnYY1sSSSp/BqQEUKRLfOD7/kU52Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903082; c=relaxed/simple;
	bh=9e4zrjC9e/nodLbNRysRd7Rrv0DNligGO/UQfERYv1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqvU8zRi7d5EDqEAg2EEeab7XriCbX93LuQBywNpmKUFkt98UBvc1+KbmRE/nddYx9SDmSFGTxZMxAlB0kxzHN7ztc6Ra4WnckAN1ejyTWFh+DedqQnnDVp+5an+iZk8XmWsv5pk81M6f+uhg/aZV4FbDXwrc9+XDIignjMvW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8ACXEqV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c93627e773so2060904a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719903080; x=1720507880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=480ctViQme20qAYraCKo7nXXY0eaZ2h7Z5p0WmHiNT8=;
        b=W8ACXEqVawMeDSKS8q8GavFSFkEbN+VOlhZsBBMJylpJVQrtQ3ymr5Y2eviuQOcRzU
         YnCCndLGGzv4+qQ/VRJgZ1GDPJd3hH6r7TgFU27EChQAOrVQCdwqUwmuQTNR3cNbg4Hg
         +1PvOnNOC+1j/2hgHLr1n9y1BZvCxOxqoF6LRSYo4/0d2GR52igm9CWebTuCnpCobizs
         9QK8JB3yRdfgpqDsK9RUU0KWcsDpL8LEKFyiuiT87tOP0Y2s86WQGYrt3jPSoqgfTYRS
         V1cghYxXsDcuA24s59PuiPrMXLaQvDZVed+9B1o1TnWfiHTi+pqyuwSAZ3qUgqamAXGy
         kEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903080; x=1720507880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=480ctViQme20qAYraCKo7nXXY0eaZ2h7Z5p0WmHiNT8=;
        b=bsTzmvEx+wQePOq5cO5xd1wvUzCgnGyY79UFH8uAot2fuzWvJx2PRYPzcqEEe3/qGt
         hRZ1q/pHO0d+9VZVmCMbVZbdiuI5IN3U/U7hTkygCjBfnys7H821npWMKrUqt7sbG20W
         ktiDxhx0SgB1jj4SMEhHAol9k5AL+KuMKszYDUC15ZPBCntC94tZla4Wkkxnn262FwJ+
         uSoRqwNeUxw+a8bTSjx46+3wXocUFdRn9aKBsTFbCBfX99OSRD+2TEpd2PdcaXNAsfhI
         4DJRaFI92M4uzPnY+3kzPdb+qKkIjA5XrYyxfSbVj4J2qQXBKAaCb63al4bLmwarGP23
         a5vw==
X-Gm-Message-State: AOJu0Yyn/FwMCDZOX3FjKJDJQRTFZvObjtVVSEB66wSG57G6S+Dypx2a
	R1CLPcDDnunuAUm4mDMqxr9TZUFDQ+qelhjaCpPFSxSWYnONXJtq
X-Google-Smtp-Source: AGHT+IGUSoep6Km/t6cvq2Owmre4HntBHTWC6wC0vLAhOWD4UbfNjmvoA/Zq/nb3/Ncj8+9qZZg9qg==
X-Received: by 2002:a17:90a:17eb:b0:2c2:f8dd:e15c with SMTP id 98e67ed59e1d1-2c93d75e7d7mr4373753a91.37.1719903079646;
        Mon, 01 Jul 2024 23:51:19 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc5e7sm7976490a91.36.2024.07.01.23.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:51:19 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v3 3/3] wireless-regdb: Update regulatory info for Macao (MO) for 2024
Date: Tue,  2 Jul 2024 14:51:00 +0800
Message-Id: <20240702065100.13644-3-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702065100.13644-1-pkshih@gmail.com>
References: <20240702065100.13644-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

MACAU SPECIAL ADMINISTRATIVE REGION OFFICE OF THE CHIEF EXECUTIVE released
Order from the Chief Executive No. 64/2024, which wireless data
communications equipment defined as

 - 2400-2483.5 MHz 200mW
 - 5150-5350 MHz   200mW
 - 5470-5725 MHz   1W
 - 5725-5850 MHz   1W
 - 5925-6425 MHz   250 mW (for indoor use)
                   25 mW (for use in outdoor spaces)
 - 57-66 GHz       10 W

[1] https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
  - add 57-66 GHz
v2:
  - 5470-5725MHz to 5470-5730MHz to have 160Mhz bandwidth
  - keep DFS flag for original ranges since it defined DFS-FCC
---
 db.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index c046e0269e67..d7592c299c62 100644
--- a/db.txt
+++ b/db.txt
@@ -1259,12 +1259,16 @@ country MN: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 	(5925 - 6425 @ 320), (100mW)
 
+# Source:
+# https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64
 country MO: DFS-FCC
-	(2402 - 2482 @ 40), (23)
-	(5170 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (30), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (200 mW)
+	(5150 - 5250 @ 80), (200 mW), AUTO-BW
+	(5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW
+	(5470 - 5730 @ 160), (1000 mW), DFS
+	(5725 - 5850 @ 80), (1000 mW)
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (10000 mW)
 
 country MP: DFS-FCC
 	(2402 - 2472 @ 40), (30)
-- 
2.25.1


