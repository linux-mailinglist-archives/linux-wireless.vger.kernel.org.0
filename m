Return-Path: <linux-wireless+bounces-22830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA00AB25FD
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 02:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF5D7A2713
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 00:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF4A934;
	Sun, 11 May 2025 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCoKD7UO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4445645;
	Sun, 11 May 2025 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924836; cv=none; b=ig0vf0pEwZKLkn/fuPLyWrymGyGgRRGTNlvw+dXpwL/QM154sUEjxIvYNz0YxkoNdCzQxNN8OPjbSxpp1wyGhTsFmR3uoUgV0dx8T0/JNm6LSUSBsvuu+5rKd2RDz9rj6AS/kYHS9V4Wo4KI2ghIfrU+3/N7fylkmdVzzclfK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924836; c=relaxed/simple;
	bh=t+H/V9wkY685oJpZQkJYDdMxlGIJq+ukqscR/FvCH9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2bIfyfWtYguNAhlXvZ1+6WvCK/6RKyGs6xK72legHKLrhC/Yt5MfhiBYPsODj7CAC0/dC8SM9zZIsQ4f9S17jX+4Q6S9hiUrEI03jf9B/WSfVGI2T/DTz71d7ix5KYhYpP7xB/GXqw2ncEuT0LDV+5kqfx2MLUPpGkW9EBNOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCoKD7UO; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d965c64d53so15258895ab.1;
        Sat, 10 May 2025 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746924834; x=1747529634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa7DMuZzl2EIMYYyYKxq35O7uGK+xt8eCno9bPDFjZs=;
        b=XCoKD7UO1A2Qw1OFuvu9+8z9XZKC7nO+TtpHx+5xqemNEgTBCcrKZQZi6398ie5p9p
         CjVS/t2T4dmeZTqFCczMSaxeYUVfLd1ncLmDEa0H7lxhvMGY9dD2iJ5tLfZbPHCg/sUU
         ptbz3DWCEjM9EeFOTGeJWu6pZAvkHXADzr0LSdjOn5u+qqVoeR6yB4/TyBa9EjSk9/sg
         3EjM2xXX8z7ch+mvLqjz7XEK2EbCAO1LAs7q0wlu6qojnAf64ycrcAt9bbAP9Y2ckbWh
         4jHOZn6MySJU2RzARLw+6F/RAHJkKhepE2/EZnuDC9sIn52nf6XAKPMxWbDbz81/HK0q
         XrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746924834; x=1747529634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pa7DMuZzl2EIMYYyYKxq35O7uGK+xt8eCno9bPDFjZs=;
        b=TgzE6gowL1Zx+UMGseyCLZLLOhVDKlwRXBuuEnCbyuqy3gvJORrDtbmPlY6Wg41f6g
         7gOS0CCmBXrj6SFkB+0nFFpJ7febxM35Pf2c5Bv9ZhU7tmS1l58q2asgVHYqfKrOsZWh
         YDf/v7V3uUP7nUtzH9Vjd9AKu07mSf+zzbzNsgf/BzPQ5gm5vCogATgCE/RHnx/iWNGm
         9fAt+FpK0RWnaInQnT+VhdZz1BC3AxKepq5Sbb2Cm7cwXR6eab2fMa1YVHvJ1C856jiv
         0IRYnRsbvaGCB/v20Z+M2nCANI8pz5pCasj8iJb3sUMypa0/pxmg9WZtWAjssITCo3If
         vl4A==
X-Forwarded-Encrypted: i=1; AJvYcCUgJbhDVM44Od6X7Hv0DNq0e9Ge8kXW3zSCUfYjatCkUb8YnChMGrqbXQW6al+5mZImZ80y3KQgA+Juir0=@vger.kernel.org, AJvYcCX6ngRxUHtMNsdWRNE1wCkdaGCNuX8qOnObma0uduqv1uqFYwIJaxPw0VuSaHZ3ZKZLh81qFzSL81CGkHtI1lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdCzXptCgVOXbdH6gqU197f0R4qBmEMkDgLhOQ1+FSv7uMR3I
	/MvSTA9SQEFYmv9uJKF5+e2mmBBKyGEloXYmH2lscDSCj7m2/u0ZHS//V5yc
X-Gm-Gg: ASbGnctrRZCw6nOXEgU7AT0wqCw+HhG+evmRJEh7AqwHuhNovcSTkJ7aMvyS8urTkSg
	zypq8mQIweX6jTYNQr/zahvohuHQe2HVmC3qME/+Z0vdu18OBJ1/nU16/ypLcRostlf1c8NknWw
	7nJuU7kr03JLw1hljqhQuHHipsMLRfazzWUG1dil5gbT8KoPlv4jmhMgiCPBRwRt5M2OGIYyrJ3
	uPt/be7inbnfpiPpkBwnpvSkFcG7tSjdEI9LmfIJDqprkuMrRCf3RrTkDJ9j6lnAzqRyeHptVJy
	aM5FDgErBhzouunlLA5JkmOsToUkTDjau1Egu4OesNBUHBfwppFV9L55NE3Rp+oUllBlX4vwaVz
	eXKiy7AL6yHI1BI+LzKTLwTDtWkomHJOD12jdwWeSOqEJvvw=
X-Google-Smtp-Source: AGHT+IGEQzPqFW2zBqw6OV63v5ytbUdgLh5lo5yyZnTnsFyes2HBpCZ9g5H+1HLo0WORfxLp+t9xCw==
X-Received: by 2002:a05:6e02:3c81:b0:3cf:bc71:94f5 with SMTP id e9e14a558f8ab-3da7e2174a8mr113697555ab.22.1746924833664;
        Sat, 10 May 2025 17:53:53 -0700 (PDT)
Received: from localhost.localdomain (2605-4A80-B00B-5AD0-0-FF-FE00-0-dynamic.midco.net. [2605:4a80:b00b:5ad0:0:ff:fe00:0])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa224de1c4sm1001724173.37.2025.05.10.17.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 17:53:52 -0700 (PDT)
From: Samuel Williams <sam8641@gmail.com>
To: 
Cc: sam8641@gmail.com,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	David Ruth <druth@chromium.org>,
	Allan Wang <allan.wang@mediatek.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Leon Yen <leon.yen@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7921: add 160 MHz AP for mt7922 device
Date: Sat, 10 May 2025 19:53:09 -0500
Message-ID: <20250511005316.1118961-1-sam8641@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows mt7922 in hostapd mode to transmit up to 1.4 Gbps.

Signed-off-by: Samuel Williams <sam8641@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 826c48a2ee69..1fffa43379b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -83,6 +83,11 @@ mt7921_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
 				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+
+			if (is_mt7922(phy->mt76->dev)) {
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+			}
 			break;
 		case NL80211_IFTYPE_STATION:
 			he_cap_elem->mac_cap_info[1] |=
-- 
2.47.2


