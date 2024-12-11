Return-Path: <linux-wireless+bounces-16212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D470E9EC168
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0037168FAD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D5F9EC;
	Wed, 11 Dec 2024 01:19:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE042451D0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879993; cv=none; b=mh2rusWdxMiXKYo7vkKNYPlu+HM2RtiHxlqKk63hJfHSovFWHqHsLY7MtEglhPo2bHOY2O8Ue6jiKaM9F109EcPxsSGY73AWj+4aOhmCdJTVX6/F6Z8YB+qsHpVzWg46BRJLkt5d5SCfB1++pWkFk4W9JoS7933GOKOjzBA7ydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879993; c=relaxed/simple;
	bh=veCj8jswodCHOWoK/0Hw2g6RuJ5G96o8XzB7nZpGOFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiIfWzHeC5t4v1MBMjTTn31ZjeKnaW8oKMU4WwdrbcbvEodell/zHvgzTiFzUowV1BRlARekHDnG5MTaPSx6DOAm7lcs53n/O2T5MA8Euon/mkA8C5yRkCZQAHPwFQDiLrMMhNWcRHAXun7gpJtF7O2v7vgQdtutbLVcicwXHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e02eda71dso903910a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879991; x=1734484791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpVhxS7jqXsBo8scTDy0x+y6eI+LhzVWJoven7CoWuY=;
        b=KK+Wx8v9mUeTKUvph6+GJeASMHc5a+Ll7G0FcTyK6JpyPIop/7k2EKozK8/z4j1fSq
         raFEL3yAf0Wvrls1hbOR8YxB1B5rX7fCLrOHdNGGAu9EfeRmZNhozkmC/YshiRxtjNmV
         8njKfk9QHx73qTsjCU8RenesLQjL8A780VjieHrWUcdG/HI73gstETJZ+q1eGUk+w1fX
         wI4ez99PPhsUkXvhYj7fcOJaj2AIpOB2Rc33NrA9/V5KC3gIrIp2iNisQpEonbb+2ykd
         Bh5SNGfQS7ac+JwrFSbPT/H4H1TAxViG2YxBTT9ILFJ+HBqapKOp3NVYGi9w0LDc8ThQ
         Kifw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Y5+0tYSh89NthWF3FmCB2j+akiWsWSoFKWpDw9Ry3Z8dtUPKPl3T9DVfBVZm+6kmLUE3UbsZe+tq8pz1Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTYD05ms1/Mr3C8yKKjiY4wVhmN31pyaD/Cp/fu0pv2HMqpCf
	Rl6wuywQg0VUWtfVmbzqznNLl38JUq4s1kFfBoauJtmp2MSgDzpgwh1pzCrwqwA=
X-Gm-Gg: ASbGncun/jiuuDI4rfmsSNaD72XW+4ijpU3su/xLzODaRJ6H0K6lCgFOnu4d8hIgs23
	0hQhGcCXOCEkYZ32Lnf0YPx28w+vp8Ue7l3GdCJJRH/p9bNajsWWg8eGgnnRDOzETMAp6RcXOAo
	xOIEWPnvlZEqt3z+yexhw1d3bWXJ29rKr96MxDvePzsLa48Bhl9FT9RrnCCzdDR/LdMNix3+oPc
	vNDm/f7gfugHvoalaNeLa88JRqxKlq+xuBQrzJiCqUSIIMeAyVtJxJMRtYpufYPZKquwew=
X-Google-Smtp-Source: AGHT+IF5I9BChu/+PnBYCjP290N4JLBxE7ykFbbUyl855H1vZYnMKRE0FkIgujm7qjIVOEwqqEU5Sw==
X-Received: by 2002:a05:6870:a104:b0:29e:255e:9540 with SMTP id 586e51a60fabf-2a012f9fd92mr745313fac.35.1733879991082;
        Tue, 10 Dec 2024 17:19:51 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:19:49 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric-SY Chang <eric-sy.chang@mediatek.com>
Subject: [PATCH 04/17] wifi: mt76: mt7925: Fix incorrect band_idx setting when enabling sniffer mode
Date: Tue, 10 Dec 2024 17:19:13 -0800
Message-Id: <20241211011926.5002-4-sean.wang@kernel.org>
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

From: Eric-SY Chang <eric-sy.chang@mediatek.com>

In the current sniffer mode, the band_idx must be set to 0.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Eric-SY Chang <eric-sy.chang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 7189d4f6dd4c..83f237d49c26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1976,8 +1976,6 @@ int mt7925_get_txpwr_info(struct mt792x_dev *dev, u8 band_idx, struct mt7925_txp
 int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			   bool enable)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-
 	struct {
 		struct {
 			u8 band_idx;
@@ -1991,7 +1989,7 @@ int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed enable;
 	} __packed req = {
 		.hdr = {
-			.band_idx = mvif->bss_conf.mt76.band_idx,
+			.band_idx = 0,
 		},
 		.enable = {
 			.tag = cpu_to_le16(UNI_SNIFFER_ENABLE),
-- 
2.25.1


