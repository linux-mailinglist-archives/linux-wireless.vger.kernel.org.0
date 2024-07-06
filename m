Return-Path: <linux-wireless+bounces-10053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA49291F2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848991C216B5
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E64D8B1;
	Sat,  6 Jul 2024 08:29:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803D81AC4
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254562; cv=none; b=Zxb0wQPi5q2nMBY7vcsW5YUVfxMl4dxAxVtRpO2sRDud1kG+b9WcsM6P3IrzlOYpc/9oL7JXfo9gf+wwIMv6YKZ2b9d6dB/puBionOoFd59Qa+gA7R+hQ5z1Lhwk4XVxqhIOo8rJED573Znitb/E9+iYBYERNXQk+Spwe7cc0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254562; c=relaxed/simple;
	bh=2xFI9rKAEAKUTWPGFBNIZI9n9/auiFKoMKmik6PGJDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwB25/tVRkTFqw61wc/2o/fjRp+ssr01pcO5BQPTpKQYTpKZ0a4NjRdOB+lt7WcN/Ce9Lc8MhcPNvcoTdYbQXUOnZ614vsEmCGg+mOTOi4PhJsNKyozbggSNA3TeQSgzxJ9fjKbyNEW6Y77+27bf4oUzmj0609k7syYk/GlFrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25e19ad0050so386979fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254560; x=1720859360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSgiCYdbTZhBzsFtfZ0J5zrY/KOMVKy0kzRs5gp6JHE=;
        b=iXgaB2XjsqjCHPDKqHQN66TKL9rxPCxvnrEgz8flvjTsXkN+QbrLzBWQ9ioj6fOYdK
         w4PPpTJtuYIDS+1FUCmsDJ2PpQTMGgwSLNW063oGcWN/2MSpaXAzu1e9p7R8oW/tmSE9
         hPUa0YCWLRk6pnJz3GvRQHYo5PAgO9UCwYFLo/kzktwuEYnDctLPVMl5SqdIotMeTER8
         A0ZBseVBPP/dSCs/meqHnCg+4Q6fZDlVXzETxWo7nZC2a3cGxOJFfGA9Xuqb5RxPvnbX
         LEDd59T6X0i9OhQb/pzm4u6oJj1lGNHM0hfKEgBqobXeaD3FoNrWNZaeAQIloFtkIaTD
         ZwWg==
X-Forwarded-Encrypted: i=1; AJvYcCWYwF++bzN9/OQpGrj0wD4LVL/ENBKox0wO6wII6iflOnb5ihT5eovDTgQwUP1DsAIO+YG59zKN+q2JNOP/toKWjKUvDA2diRQuVEZ6V18=
X-Gm-Message-State: AOJu0YwwYw6XxjApiB6V/d+u1w265imTVIRiF30BVm7OysPvKgdSAjcz
	7Ae7yvZX5v2LqSS7GaN4B24eFl149luoIRqDoCvP2UxiqJkpeN9j
X-Google-Smtp-Source: AGHT+IHhGg3iFxDo2Cp9FwlE6n+jfjMQJenn5uw1AfT1Dg/o0uAMM2XzXcgaZ5pmTtYm/eBBuFNP7Q==
X-Received: by 2002:a05:6871:54a:b0:25d:f237:e108 with SMTP id 586e51a60fabf-25e2b5a1bfcmr6904431fac.0.1720254560270;
        Sat, 06 Jul 2024 01:29:20 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:19 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 34/37] wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
Date: Sat,  6 Jul 2024 01:28:14 -0700
Message-Id: <583a3ac10583cfef0028f9a0b5a4802fc4070b99.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

update mt7925_mcu_bss_basic_tlv for the MLO-enabled firmware.

The change remains compatible with the non-MLO mode and the
older firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 908aed2eec11..5f2f866e3ce7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2385,6 +2385,7 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	basic_req->bcn_interval = cpu_to_le16(link_conf->beacon_int);
 	basic_req->dtim_period = link_conf->dtim_period;
 	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
+	basic_req->link_idx = mconf->mt76.idx;
 
 	if (link_sta) {
 		struct mt792x_sta *msta;
-- 
2.25.1


