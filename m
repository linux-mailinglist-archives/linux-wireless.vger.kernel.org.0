Return-Path: <linux-wireless+bounces-11074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B5B94A298
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA4D1C20D60
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3FD1C8243;
	Wed,  7 Aug 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezh/Cygf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901211B4C53;
	Wed,  7 Aug 2024 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018953; cv=none; b=rNOoBBo9AZprnkKKvFBl1cs/rgJZLsdY9TYH2AddcVOQw6s3rRYp343e6OzaQohwXEWHadnLRqSOQO+xZC8aUw3/k6UxLNE3yLAKvZ4ZjH+Y4AR8+7OXldCC3lMr9hW4NpzcdpWvrblMlo6v5YiCNFOeEiiAbe6eeqdObm6tSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018953; c=relaxed/simple;
	bh=JJqbdizmVcDm0J0CZ+kzknxS4PV2Ix4wp1sOK95CXTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+1RPS5vv9ahilo5sSAAx7362gu3o9asdo8pU9Ap1O02aUuvlG37NIeiRB+kINZcwLvz8IadxW5bhJzp91+E3qIvDQQiitgymLgTiawh7WdYVsDf7xWZuq7Aeo0bkhATxnHnMZtl7RVOEbFIS7jNujFVMxtvW+tuY6vzhyQtXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezh/Cygf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so1195497b3a.3;
        Wed, 07 Aug 2024 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723018952; x=1723623752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN+ZFWFpopazqDFBLc+sZfMSaFtv3e+QTIYu0Wtch8Q=;
        b=ezh/CygfpTeWcujnGgHPYfGtJ8UJ5bxowjUNgO22hnKgQDY+rMmMY59ipAFiCB97vs
         /R+thPheGO5MIirjyxeaguGTyhm3yqae6EMRtbzyGV91aP2NAVwPIdqix5cDgo5Xxwxh
         1NemxrfR4EunaZiAAjigWkEaRGDBNXcKMQ6bOqVoUkU+FaHomn7kEYwyu6fX1rT2DRxc
         ydve5WoExJBxBHOwCwqjPLuCIUTmhva4qtDVmFQhTTVFGOCbVJO1hiJvuLIEP6Ji9O+u
         Am2vuC2kg7gGaEL9WE8DfKt7DR2ep1kDDXIAjLaZvMpLP6W//S2NCfkmM8d6MleQUPWu
         9xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723018952; x=1723623752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN+ZFWFpopazqDFBLc+sZfMSaFtv3e+QTIYu0Wtch8Q=;
        b=i2/7Rq06eZBe03tj8iJaSmQDAN/drb1WvXaEahQZvpTqan+3Fz+A+pePLNoJy/Y8QN
         rcfSdOAYrlVKhYAq1oipR8DxVwTDpwX6xNLiFkuOnM4YcsW55Y0NEgQOt17v6JGqUNph
         vTdzLqOF1JjWcVw48PgggIOO/9d8qbpnkbfSvv8JxvH46iZgl1xqaXMW22EDMTjJEr0Q
         Ss8E9s4cP0d/PgWabTFX/U3TLgS1NUaL/vlSf5uWuHi5+l14qlLTlrAAzvVp+85LIQYI
         TeUwuWdAIHbr4PqLUvXE7IpUotpIOGQbtq/MoPb3gvM/lTg7eFzIc1O88W/UsHf1vqsX
         Ds1g==
X-Forwarded-Encrypted: i=1; AJvYcCW8fkI8YRNu5WLTtIeIYKSpCc77cmLXAu5tq6d/5xhm9LcKMdQZ5dO/Mmaj1hIYhQzYROwFhb/GaypVP0p4A1TmL7LDkxtkoezbZuSsqWWCXElOBB4d/41TokK1U0Tnj/BykDTnfcVygfSJXf+12ulTgg0j3nxTp+4+CVvbToTsXYgqh0Q=
X-Gm-Message-State: AOJu0Yx5A4nk3Z/ISDPkhxn+2CeWc3IrZUjn8gKR3yebEM5wRAhmWPGq
	DoyCnurxbC9FojlD/tPVOwrNcdx58lXem5OIx0I6kFQYt3nkU1Hh
X-Google-Smtp-Source: AGHT+IHL88krJvGfLfkWm5wh0nG3Zip/FgszODUmeof2pjR4V8t4VTnvtlBT8d6EXqRKXsC0//AhGA==
X-Received: by 2002:a05:6a20:2445:b0:1c2:8b26:1bb6 with SMTP id adf61e73a8af0-1c69956d38cmr20140442637.17.1723018951547;
        Wed, 07 Aug 2024 01:22:31 -0700 (PDT)
Received: from 904-569.realtek.com.tw (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20077401e79sm28725005ad.100.2024.08.07.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:22:31 -0700 (PDT)
From: hhorace <hhoracehsu@gmail.com>
To: gnault@redhat.com
Cc: johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	hhorace <hhoracehsu@gmail.com>
Subject: [PATCH wireless-next v2] wifi: cfg80211: fix bug of mapping AF3x to  incorrect User Priority
Date: Wed,  7 Aug 2024 16:22:05 +0800
Message-ID: <20240807082205.1369-1-hhoracehsu@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20240805071743.2112-1-hhoracehsu@gmail.com>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26),
AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4
and AC_VI (Video).

However, the original code remain the default three Most Significant
Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
and AC_BE (Best Effort).

Fixes: 6fdb8b8781d5 ("wifi: cfg80211: Update the default DSCP-to-UP mapping")
Signed-off-by: hhorace <hhoracehsu@gmail.com>
---
Changes in v2:
- Remove the useless entry for CS5 (case 40) since the value of the 3
 high order bits is already 5.

 net/wireless/util.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 082c6f9..c6d0397 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -998,10 +998,10 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 	 * Diffserv Service Classes no update is needed:
 	 * - Standard: DF
 	 * - Low Priority Data: CS1
-	 * - Multimedia Streaming: AF31, AF32, AF33
 	 * - Multimedia Conferencing: AF41, AF42, AF43
 	 * - Network Control Traffic: CS7
 	 * - Real-Time Interactive: CS4
+	 * - Signaling: CS5
 	 */
 	switch (dscp >> 2) {
 	case 10:
@@ -1026,9 +1026,11 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 		/* Broadcasting video: CS3 */
 		ret = 4;
 		break;
-	case 40:
-		/* Signaling: CS5 */
-		ret = 5;
+	case 26:
+	case 28:
+	case 30:
+		/* Multimedia Streaming: AF31, AF32, AF33 */
+		ret = 4;
 		break;
 	case 44:
 		/* Voice Admit: VA */
-- 
2.42.0.windows.2


