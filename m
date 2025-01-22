Return-Path: <linux-wireless+bounces-17837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421DCA195FA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 17:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37833A206E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD712B71;
	Wed, 22 Jan 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMrzyj0L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6021423C
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561679; cv=none; b=MnqTVNqIzLt3bSx32K2o71A8rWRFaHetxylrnhp/YNn57Un1GfWpujo6HNdPvGZVK4UakaaR5UnDW0mItxFVAypdTmqk+nOuePuVWB+ROgmwwwaarbfscIW7tN7c8zvghyM52HoGa3eLjF5G8ghVSfimtBrmd66hFRmc/trxHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561679; c=relaxed/simple;
	bh=JX8vkrNcXWq5IMdZAXziKoGFQLJCaqTWbk7bFlt4psw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjNBm4wFJ3MSRACaXyUFTwfQKp7j4fjMZOIo2kpqE1hU22lqQiFWzBQ7Ap1Sn3UV6zFYfuQ85WywFOEVBQrKASAIYQzMUYM+Vg7ZfU/flNlNO9C0rTVE53gPRXSDE1P1HGIUO1WnanU7RpcxgFw2E5n2WsFxlYBN53BoCCoEH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMrzyj0L; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43624b2d453so78350805e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737561676; x=1738166476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vj4z5hIcthgqzFNg6aAKs2pjX2BuDD07i62xt4di/0=;
        b=kMrzyj0LwLoL7uQAnrPbUqkgjngGFb4IjNPSVQ+YlWz3E7wRKAwkdSeBQ0+5UwgikY
         OzzGkKrxmGswWFmxNFIq3eKatOVznfD2KyNXL4xnIMWm+kHKqpWxdL9AtAWgefN0Zuhf
         /fEMxfJRwM7G3GnMiB5XmZ+NX7kAEcT94S71Lk1RV9AK5RxULJZtqgEG2GdyS0+RfSa6
         +dwa9ku1jphpdKcUUOw2r1MYFSLkfRDyiyCQuNzjDs2BkKl+bMyxyK+XKOeGE8FbLLre
         hnEfLlIjjZoFZrhtP3AFjCBvUNiS9Zhoe3JxWelrKT41NU+Ayv2fxNUqaBKlgiiAj2bo
         lsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737561676; x=1738166476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Vj4z5hIcthgqzFNg6aAKs2pjX2BuDD07i62xt4di/0=;
        b=m7imKdSJeVNRcRbPVLTcAILEibzdb713ImfKjje67uzPf7L5LlpCnqAyo/nMo6ZoQ9
         cfWZyGA+cCst/wp4FHWCCCBYnrjQHkpgstP5wxrSrAgVkriakk2+Sh/wha1c01xU4f4f
         EcILd88dDyAzUk+h9j45qbkOKowH9tDAAJWRCSJ+QtmkJvPWLs4VNe11ZqhyjMC1Hecd
         er27uM9bvTe6UrAEkTG1Scb9jG0S5Rf28jBDXKvUOJHVja0rl+UiR0AtHqCM1iaLtE9g
         jCjxvzX8AN+7mWAw2QTRhhNxvwpJhoQ7ntiyS/1VdiGZi1SDl3iKfqt+l/HRqIutom8x
         AkhA==
X-Gm-Message-State: AOJu0YzOIZk8ooy6uTsv9JVNrDYBRaAk3gCEGMH62R+SQuuimVSCJGDY
	xX9LmzXlgBDsg+PaK0DyVOSAq3qXHsNW+E2z1gBlyGEny9d00lmu
X-Gm-Gg: ASbGncu64IWN3KJn5ZBEFMBtMKG3C3t5LzRmwErgwshPHIb7LP7Kx8pjGmHWd10Djya
	7eLwcZJin2UTQf6VOKC6xPmlKY9R+vAqBuCdycEWCkstuGumfkiIDkVIuhRA93h5hHC1fUYJo6X
	ejoFbznlegOJe7SjDbdDj+gr7zrgKHPiCcvF42x8F0kUnnZ4VfWPFGCSMV8CU7bmdk/NrZhNbrf
	9f81VWrBdsGN7BIFwGs2BoFQQAxOV7URuLvti5w1bKaNseVEtbWt0cHvJMm1BTQUI2xrDThdblY
	GsYZa76rmiXt+vDV4X9CwZcWk7w=
X-Google-Smtp-Source: AGHT+IHR1F/vjBNVVnX/Dc2R8NACoeWRJsUoen52U1QiPRFc8U4V4j+S4DvmWRgU0x/floRQn8kMiw==
X-Received: by 2002:a05:600c:1987:b0:434:f753:6012 with SMTP id 5b1f17b1804b1-438913f2f4emr224515775e9.17.1737561674232;
        Wed, 22 Jan 2025 08:01:14 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31afb70sm30010095e9.19.2025.01.22.08.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:01:13 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx error path
Date: Wed, 22 Jan 2025 17:01:12 +0100
Message-ID: <20250122160112.3234558-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vlan support was added, we missed that when
ath12k_dp_prepare_htt_metadata returns an error we also need to free the
skb holding the metadata before going on with the cleanup process.
Compile tested only.

Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a8d341a6df01e..e0b85f959cd4a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -398,6 +398,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 			if (ret < 0) {
 				ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 					   "Failed to add HTT meta data, dropping packet\n");
+				kfree_skb(skb_ext_desc);
 				goto fail_unmap_dma;
 			}
 		}
-- 
2.48.1


