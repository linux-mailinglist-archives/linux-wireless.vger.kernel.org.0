Return-Path: <linux-wireless+bounces-19139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F02CA3C6C0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1AA179D32
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EBD2144D7;
	Wed, 19 Feb 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="biEUQeAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E0211710
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987557; cv=none; b=V1JEaqwy5105U7QfCs3GP8Ch04m7fVCdr0/dM/EzGW+YdL4/EiOBYoq51kgvt7bCkQNqNrYdcVEiLHrp9iq42vQxWUmdxvBmws1RWAQs7q/q3XcRG//JH99CDJSfz7tCvk4a+/dBIDx4+kfqs8TCOCfeH/aHA1+YtFccVVdEGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987557; c=relaxed/simple;
	bh=8qGFuFio7l8v13Ta0jMDRd6cxQsLpGb2k9QIoKlKuiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek+Lkmp0e1Y3DfyThK2OHAJHLz7m/tLFi+HkNqYLzjbpWE0QLkdeIo+eWjyT/AiJ5/NHjanLtVmytLzE4aUGNQpR9zO5FBsji7+txYnJv9ZAXQKJmJ+EcC7XJyinT61XDouJBp3BQ9pAqphxWsD6MCcfPePmQbNjxsTSgWYse8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=biEUQeAK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so30116f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739987553; x=1740592353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHVE96KLX78DAXjrskuXfsR7w+mAU4Aaw0RqwGEgCi0=;
        b=biEUQeAKcRD5lrfnngQRwc/LGvta/p0V8+5LSamh3UYyfmRQjmIn/TLlnXomTRodlX
         kxdv8kuQyl2y53tiytGjHcPF97MPTDAzmVC/lwx1Ylt7fALvzF5jvo9hCGWMuduvRJcf
         m2kQGwKLhZK101ZyQMZe9YXeFkokwHUy3dcpeXcMCenhKSV5hj7b/MZqX4i8+6IGfz3k
         PiFZ9w/ZzxP4qMhGvc8sEFqBPJtPiMPWZ+K6MuXMvHYEynPYnQhPBRCrTT50bPPfZWGH
         uA3pyppnlHicbmlPUKzzGVilc4MStDHljUcsg3/mWqIJB8U3jYYRcu4HZy29swVoLolg
         gNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987553; x=1740592353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHVE96KLX78DAXjrskuXfsR7w+mAU4Aaw0RqwGEgCi0=;
        b=i6mQ7MlqBorG9+DBErnKhA8xQvd6Ywl6yVh9xx2mWIetLQNSk+t/fxVb+i//rudCSM
         Sl7y801wYRW20KKQmczUuMwffxhqjjncZKdAFCbMGPv5hFAKJ7fsavDnazjW4OZ3SqzW
         wE5Vi0FzrHV5/FdwbNeLOsZlK1SVt2CxHpLesUiOIs9xeOUWyLEcEXTixjoYZFZQY3mA
         YzOb3AKdEC7nj37zQ+qRQrLfHwO9Wyp58dKGkM8TvYTnlpigzkzglbcKdfNe5YAe59dq
         DwT6dB8sC0XBKTSaKq30ob7IjbwdN036FABA+MfjQcDu3jKW4yGAZrdyF0wjHgBz5C6E
         /bnw==
X-Gm-Message-State: AOJu0YwpTtGg9np70DSactwIY9FOZikvqsta4oWgbYHnoUz01kysrs0L
	7O5guXDU8KdYzeKQw9GDXpJrOQl+pB4xyiCYcQCBI5r7GOyVK8lAoDJG5ehhy3rCjdThOTIdSBL
	aUIQ=
X-Gm-Gg: ASbGncsolA6OxVwufhxSi/gjRCYbbpHorM4/g15LMQhCOfDwV05R97elXGVwyWuwkxG
	GtYQN1ceDw3rHtiujdrLZxw5GevZ7zW+0Z/rrWkJK1ReQv/sYmWgrWUtkxQxgD/gl4RvRUh34EO
	C6UyPeRe8JQ0Je15FJb/onrD/5g3IMzPD0zjfYTrWlh0K4C91yxidbEVJ6jw5ummN9FxUAZzNm6
	KP1lOC3pyW9attxcv2sgleNDAGNUi+7z8kn13S8BuNH69fOIHYJ8hQo6wfIAUmS15jgbbR1ttvO
	bXTI5TdMzbpO
X-Google-Smtp-Source: AGHT+IHYzEAVZ5TYBQJ7blXzKEME+tGvXKWL7txGlCnv2Z/gOuu5GbNuybba/CmJ4HGiO01XUxKoWA==
X-Received: by 2002:a5d:64cd:0:b0:38f:295e:6331 with SMTP id ffacd0b85a97d-38f33f3d70dmr16958711f8f.19.1739987552891;
        Wed, 19 Feb 2025 09:52:32 -0800 (PST)
Received: from fraxinus.easyland ([2001:1620:4675:0:25b:f7ee:9a39:7e51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43983264ef8sm99269695e9.4.2025.02.19.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:52:32 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Reto Schneider <reto.schneider@husqvarnagroup.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Subject: [PATCH v1 2/3] wifi: rtl8xxxu: Use macid in rtl8xxxu_fill_txdesc_v1()
Date: Wed, 19 Feb 2025 18:52:27 +0100
Message-ID: <20250219175228.850583-3-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219175228.850583-1-ezra@easyb.ch>
References: <20250219175228.850583-1-ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

This is needed in order for AP mode to work correctly on gen1 devices
like the RTL8192CU.

For more information, see the corresponding change for gen2 devices,
commit 9aa45598d054 ("wifi: rtl8xxxu: Put the macid in txdesc").

Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c     | 2 ++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index cbd9efd22e3f..2fa22d3145a4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5302,6 +5302,8 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
 			 __func__, rate, le16_to_cpu(tx_desc->pkt_size));
 
+	tx_desc->txdw1 |= cpu_to_le32(macid & TXDESC32_MACID_MASK);
+
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
 	tx_desc->txdw5 = cpu_to_le32(rate);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index f42463e595cc..dde578f65d69 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -489,6 +489,7 @@ struct rtl8xxxu_txdesc40 {
 #define TXDESC_PKT_OFFSET_SZ		0
 #define TXDESC32_AGG_ENABLE		BIT(5)
 #define TXDESC32_AGG_BREAK		BIT(6)
+#define TXDESC32_MACID_MASK		GENMASK(4, 0)
 #define TXDESC40_MACID_SHIFT		0
 #define TXDESC40_MACID_MASK		0x00f0
 #define TXDESC_QUEUE_SHIFT		8
-- 
2.43.0


