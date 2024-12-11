Return-Path: <linux-wireless+bounces-16225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF279EC178
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DA8281E64
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3F1422A8;
	Wed, 11 Dec 2024 01:20:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C313D53B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880039; cv=none; b=FGU5wn5/TiePfiCQ9tURxBS/5Tu51rd/a9RtlQRHBxcHvRC9BSLyx+8eBkxiXCDfGUPGhLjDohcrOPomlTsNoXmUA5s+cQn5AO47w/4E0/w2KooG7hMaY3mQz3g0aj+TpYbXhdifxYMcveHm0Ph7IAYQIb2h5OmxKYmc7tnCYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880039; c=relaxed/simple;
	bh=i/7YKEfhnqsx7EnbYuqda2QMLpaARjtrHChfo81YCQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IromVtsly+P4thvpX1pp9PtkvALKl5WxGLLm+wS1PWNc+Qg1qJKNl6BRqjvoHtNcsJ9Z1Fwho/JyQhrs/TVIyvuM+gchaenPUduzc1hHU2hExWGLfMD7wrrF9zmi8B4emH0fVxMuJ0m2QdsTm9ruBa/pYdnWlJAqeC3RD9XROdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29f87f1152cso2097144fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880037; x=1734484837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFt/APP9Kpg1SvU/nP3fnBmzPrWhuM3L++1qvEulSaE=;
        b=qfVWY22RR35tS9umzmI3NVyQk0JIfWvOf9ztdMkx07I1wM8R5P4cudjmE9nD8mD8/+
         OVV/zM9P/Uf36aFHvav0RWfn7nJPqsThjLoPcy+W2819PhalwYoqouBMPe8ZTwgiXEfl
         wC6+XJpQN46Y50XEvPM3VcVmFaYHYrbEDim8y7pDvyeU8YZQaladu7fUueiBorsXa34D
         3ipneKo6FL51e3JWcaNGGE46dZJGImagWAUdwpGf3PrSQY9LSh0gimm9Fwl69Sbia2vz
         pt+YwYxGMSPPJt0j2gK60ydfBE+i6NS1U9524v7ilU04sTbv75KU8r4XUHVxtRXVbD0y
         4Owg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3DcWvFNbkY+E4+nq1UdJwB0lKbfd3b2oWCH1Wg99sCwlijQY90TKFoS9qMRKI5FgVMwuPTe0PCg7RD8sxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzJ1XiOlDIrH6DUIK3JyBODOrzi4QS7VCaEDKGIuIlefiMBOo
	yN/9VSL2SZe3hVnrhqsP3fZWZeaUUKvalO+ceXp9si0emlY2JfJg
X-Gm-Gg: ASbGncsgaLhiRIGN6ft2KphDufl7nvs213xq895sRI6SOJN/rqqe6exZ7NxB9vvHmHJ
	mAea7LqyxiWiXC6LkgxFUiTFw3YGqBBCYgi/7T7eW1/1K5Epy51ftHdmEpD/XjHbfZ33ONgpRwX
	kftPM46Dt16qhEXEeGmLugUkPSXLucQyQAlL8x0SgNAdM4yH7/cGlU72x8t0rhfo6ucx1sNxWi8
	TG/sjFuG+6poCLyfoUyGev94v9b42V5kqFWhuUneRWUWUJ6V5BtMmR2jzCYYgLXL1HkJ3M=
X-Google-Smtp-Source: AGHT+IFoBvPxPXAn74OsI+gka8y3QPRiQn0R7SewMW5QIeQR3Ss8iag4UdWTxYEHJxMiuodqUSfPsQ==
X-Received: by 2002:a05:6870:a105:b0:29e:65b3:27f5 with SMTP id 586e51a60fabf-2a012c5a94cmr735905fac.19.1733880037150;
        Tue, 10 Dec 2024 17:20:37 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:36 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 17/17] wifi: mt76: mt7925: Properly handle responses for commands with events
Date: Tue, 10 Dec 2024 17:19:26 -0800
Message-Id: <20241211011926.5002-17-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Properly retrieve the response for commands with events. Ensure accurate
handling of event-driven commands.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  1 -
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 9c43437ad9d0..13e07cecca41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1244,7 +1244,6 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
 		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
 				  &dev_req, sizeof(dev_req), true);
-
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 6675492ec9a8..0068ec6d92c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1254,7 +1254,7 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 	}
 
 	return mt76_mcu_send_msg(&mvif->phy->dev->mt76, MCU_UNI_CMD(ROC),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
@@ -1303,7 +1303,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 	}
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
@@ -1333,7 +1333,7 @@ int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 int mt7925_mcu_set_eeprom(struct mt792x_dev *dev)
@@ -1486,12 +1486,12 @@ mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
 	int err;
 
 	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
-				&req1, sizeof(req1), false);
+				&req1, sizeof(req1), true);
 	if (err < 0 || !enable)
 		return err;
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 
 static void
-- 
2.25.1


