Return-Path: <linux-wireless+bounces-16215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B689EC16B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C822B188A7BF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C6F9EC;
	Wed, 11 Dec 2024 01:20:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD12451D0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880004; cv=none; b=cL+UnHhG22uq3tOf9/3YBbxd9ACQPx3jBbSscX3wK33jhIaraj9Xe+7h1aqPiH2Xxi6eGWoTKRtxBCLslIdDnUnSugcj27lJp0ZV2OcDGUkWQLKwoHQmkFCyJKjS5umpWGp0G3yWunAFgutO/OyZsQeoyw5n51js3dJjboXPPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880004; c=relaxed/simple;
	bh=xKcZQqVpL2fgXVDX4USSJ2CVB4s4KJJmbdj+YHgZRQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZye/RjCqmFGHCiIYggrOpuOZSO/m/BXLuL9kg6nr+1lubIJW9kCxCuH7I0FvnmDn4KDjhvijEQBXD14qYARS3KB5FJWcNweC05dClOobLiYzFSM+IKZgZPxpvBi2bhtddHmp6LS0o2kv1qrjxQ53hfPKXoB94eO5Eh90HM0DEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29e61fcc3d2so5323911fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880002; x=1734484802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl5+M/3Wjfu1WokgjzEWNvkbZlxOvtZ069F9urs3Uak=;
        b=APTJ8Xy4bVjFcbwLHhhnrr3PFveqjbESiYRblZ4PPNX69RVSdSpIz4P7dsUy0JmN2v
         LLfjG+VlhJnGVtXn1sY/ngvwAjhBHnuw+SAe2DJ7A4hTxO+NHgQs7Qqdn6N+KEz12Uke
         p010MdlKZrLqMR3p6D8i+U13xupQT/BsboMiGuXYlUbxj7qeo+jQZg8yzGEOw2chka6E
         vI+gCb7ebtAdzZM3rocI+Zyrny31BrYJrA7scGvWQRMeOHhi2JDtfcaWUM64vFZUH+UN
         ZznCHJ1iRYr1VMrzh1ly3p1CvkWUavf5Z3F6gVJM/XoyEeUIgTiLdJ9CE1rz+HRX4xyA
         0ArA==
X-Forwarded-Encrypted: i=1; AJvYcCXU5TZFkyjMfhRJZ69V2FhrwQjma2WiQOMC4HApfVBhY2qI+kpRLaBzLyIVjg50+pi3JImPJBxc3cbcGWsSEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZ2ZgUh7kzh/UaKi2izNBu8JAjJIEKQxaqcFxnaaImZc3AxP5
	kYfdQl2sAMVIKgEo2NPQ4zIwbnWdpwHFcxcRSC2IW9bxoD3IpppjY1PGVOXMuK8=
X-Gm-Gg: ASbGncvjQdmEg9r5ei20NIgxIDBGgOHs01qX804lC9+SqEC8W64syadPoRw7yVlwX4m
	3GWx0fN92kwVSQNZmB8CgSX7e05Blaz4ssgFmRZ0cfup45ayIwY7US8Kx4CMUS0Q5LaAbRo3bzr
	+JGKQXc5tx3moyX0mZcXmCc9TsbpY+JsEUnXE1WHw67Tlqk8Aw/aUvQdEpx1pk/gZo/N1R6AdaW
	p5QNM0V3tQaPv63Wd11KausOTcTle14PkaIThXxztxBOU9FYi4q33EMKlzqejj1ggsE7iw=
X-Google-Smtp-Source: AGHT+IFGjk93XHCKgWPxTkUaom6Dr1++sOdagiuWtt7nKIOG70Vy6CmIPsr1hmkgXTjKZwbXe2st+Q==
X-Received: by 2002:a05:6871:820f:b0:29e:4b63:d7 with SMTP id 586e51a60fabf-2a012bb3bd5mr562846fac.1.1733880002127;
        Tue, 10 Dec 2024 17:20:02 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:00 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Leon Yen <leon.yen@mediatek.com>
Subject: [PATCH 07/17] wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO
Date: Tue, 10 Dec 2024 17:19:16 -0800
Message-Id: <20241211011926.5002-7-sean.wang@kernel.org>
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

From: Leon Yen <leon.yen@mediatek.com>

Fix CNM command timeout issue when only a single active link is available
during MLO connection to fix the following kernel log error.

[  741.931030] wlan0: [link 1] local address be:90:e0:22:c4:22, AP link address 08:0c:43:7a:19:2a
[  741.931042] wlan0: [link 1] determined AP 08:0c:43:7a:19:2a to be EHT
[  741.931052] wlan0: [link 1] connecting with EHT mode, max bandwidth 160 MHz
[  741.931071] wlan0: WMM AC=0 acm=0 aifs=2 cWmin=3 cWmax=7 txop=47 uapsd=0, downgraded=0
[  741.931076] wlan0: WMM AC=1 acm=0 aifs=2 cWmin=7 cWmax=15 txop=94 uapsd=0, downgraded=0
[  741.931080] wlan0: WMM AC=2 acm=0 aifs=3 cWmin=15 cWmax=1023 txop=0 uapsd=0, downgraded=0
[  741.931085] wlan0: WMM AC=3 acm=0 aifs=7 cWmin=15 cWmax=1023 txop=0 uapsd=0, downgraded=0
[  741.931095] wlan0: moving STA 22:0c:43:7a:19:2a to state 3
[  749.090928] mt7925e 0000:2b:00.0: Message 00020002 (seq 15) timeout
[  752.162972] mt7925e 0000:2b:00.0: Message 00020003 (seq 1) timeout
[  755.234975] mt7925e 0000:2b:00.0: Message 00020002 (seq 2) timeout
[  758.306971] mt7925e 0000:2b:00.0: Message 00020004 (seq 3) timeout

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index f6aa052ca802..d0bfc7711a80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1153,7 +1153,12 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 			u8 rsv[4];
 		} __packed hdr;
 		struct roc_acquire_tlv roc[2];
-	} __packed req;
+	} __packed req = {
+			.roc[0].tag = cpu_to_le16(UNI_ROC_NUM),
+			.roc[0].len = cpu_to_le16(sizeof(struct roc_acquire_tlv)),
+			.roc[1].tag = cpu_to_le16(UNI_ROC_NUM),
+			.roc[1].len = cpu_to_le16(sizeof(struct roc_acquire_tlv))
+	};
 
 	if (!mconf || hweight16(vif->valid_links) < 2 ||
 	    hweight16(sel_links) != 2)
-- 
2.25.1


