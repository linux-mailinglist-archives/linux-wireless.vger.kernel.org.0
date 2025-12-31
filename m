Return-Path: <linux-wireless+bounces-30204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED65CEB362
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 04:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3613011A6A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 03:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB130C348;
	Wed, 31 Dec 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2wMiTuN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CEB30BBB9
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767153412; cv=none; b=MOkBwZTZ9j1blN4FHTKD47w75GO42aP862xOeS5aDvnttQiYobszZKGmaRyLrjggdQUGvMNg78l25AGg86QK8ZfuFibyN3vFkJo3UY/WrQUzpzRhzhMFe58FsO9+QDsOMy6ZHJaz42DBVQTj8+PMe+yaKpTShsUziHJC/AzZHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767153412; c=relaxed/simple;
	bh=7IRQGniC8RV35kb3vf8on4sHktiyQS6VyfUPpC0weeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ku8tDDBzOHh5EwUVSS1ZnRKVkVY7mv9U9ATcRmPTxkn8DyePbDydBtvgB8waCocZrEoNy8otD6Bz9i64z5mvTWDybeOF9W/S2DWu+LP2FUivzSvnncGaaDil0SmoEJfyTKb0jhJUsxi6CprlZ0nLZKmLhemO6XArhagaOyepMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2wMiTuN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c75178c05fso3694337a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 19:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767153408; x=1767758208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ml+CWfuCyt8xPYOA/5JpaBit+P1+CQ1YTe7Xd3yRLk=;
        b=K2wMiTuNJUwiuMmL1mdfjIZ932gD/ChC5yPm2GlY0M3qoyeVwb90T+lIkGrvxiw7ff
         FUzmfdxS3dl9rerC/XSSd8aqhBQDL4cliCNDjI6YdegjVpurPlfV4QQ4yJ3fTvQkUkfF
         +PIgeUzB+GNyQtt8W2As22Tt9zDmYaCjyrWLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767153408; x=1767758208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ml+CWfuCyt8xPYOA/5JpaBit+P1+CQ1YTe7Xd3yRLk=;
        b=PfUKo0cz2XPyGBTi2p+4VP9CTWq2/vjzh0Zg42VvWRlDbGpsYH6WFbgjDcBDk00F2r
         LxSF7+SHNa8+nVsr0BMq55AuzHZ32mWVLR00THTVCUxTGYUzIxNWgutQ5oqDtKaLXxJf
         OtXRsEKjwPyZak+Zu5uTPC4L3oRygXndg3p65MOFrjp88ZSv4OJol4jSxlLni6BFizyV
         INpsUdGQ709zQdHeyW0+GLZ4F+/mMFs/mlsKCOTg5wqQZowFfRkITvWiD71VWdsASfI3
         jFBiIF8b+AJjH+AE6j0RNSL8ssXAu68Xb4P9+cnDt+sjAJgWDyOZjk4jhlBaV+FlgLBI
         UBOg==
X-Forwarded-Encrypted: i=1; AJvYcCUI5qN8WmfcO2q7D8JiJxCPwfmPHb3mgFORCKgQ/DN2LW/r6l3GORiFEugv8ufbM4HnFqDJaZ4cHnd3GaYbqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIaX2tdQdKn+OG5Ggpt7Jt4wjOMtOlsDGTiQ+Kf8cOX574kHxF
	VYsunsrAMjMaVISZQmxq2bCmyARVuudEiQxW66xgwwtG7lqMUsUo8Zgc7mvw3dLjCeM=
X-Gm-Gg: AY/fxX7TvSnMRG+sUZSInvlq/cLb4XfeDNB1AJYeuuvh7wwqu3IHhzZ1H0ogocNLRkg
	GMo2MLCO5C8qOSLpYxbOGDuK3rQkW0Nxqdrj4VZz9gm63wyl4uy5pzFfRu3GyoI+kgwkSv/Uop+
	83uMOlSHVMsZPdWXJfc8GSMH4A6DB1a9egHFyL0LDXwd7zH/qggMJuXf/P7b4FYinM+v1pMIKVv
	+Kfi059YJvz0+ut7hWt87/Y8Gvs9Kde3jYi4prJXg/nj0SO6QBGd10+4LDLfjfdmAe+AYvoN8vi
	wXZzo3gBv2aCQW+j3QysozR9rLK5e5WKjkX6Y1k7qjDjXQycArGhVIji7g6M8kdHzL30Ex8+Cce
	ttCAp4+/EjAPiV5bfLfwijrjaBnpYbZIOHWENUKdK/DBShzYM5gD2HzYV4SfVg6KIECasWMA9Ho
	2OqwKlj4xhZPLQbF1po3st4If6GVWn+X7tpu+2
X-Google-Smtp-Source: AGHT+IERNvC/8Px0V8IUK3zXSD3cLtvI8CWOvblwcgNUVpnq5u8i6LLyM/rg8Ub+tY/WiPli4ic1Sg==
X-Received: by 2002:a05:6830:8385:b0:7c6:d0b4:c973 with SMTP id 46e09a7af769-7cc66a843c9mr16033899a34.28.1767153407908;
        Tue, 30 Dec 2025 19:56:47 -0800 (PST)
Received: from shuah-framework.internal ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d7f1dsm23582518a34.15.2025.12.30.19.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 19:56:47 -0800 (PST)
From: Shuah Khan <skhan@linuxfoundation.org>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	torvalds@linux-foundation.org,
	ebiggers@kernel.org,
	johannes@sipsolutions.net
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Revert "wifi: mt76: Strip whitespace from build ddate"
Date: Tue, 30 Dec 2025 20:56:42 -0700
Message-ID: <20251231035645.5545-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f804a5895ebad2b2d4fb8a3688d2115926e993d5.

This change introduced the following panic, and mt792x_load_firmware()
fails. wifi is dead on systems with mt792x wireless.

kern  :crit  : kernel BUG at lib/string_helpers.c:1043!
kern  :warn  : Oops: invalid opcode: 0000 [#1] SMP NOPTI
kern  :warn  : CPU: 14 UID: 0 PID: 61 Comm: kworker/14:0 Tainted: G        W
        6.19.0-rc1 #1 PREEMPT(voluntary)
kern  :warn  : Tainted: [W]=WARN
kern  :warn  : Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, BIOS 03.16 07/25/2025
kern  :warn  : Workqueue: events mt7921_init_work [mt7921_common]
kern  :warn  : RIP: 0010:__fortify_panic+0xd/0xf
kern  :warn  : Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 c3 55 71 00 <0f> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e9 48 c7 c7 00 a2 d5 a0
kern  :warn  : RSP: 0018:ffffa7a5c03a3d10 EFLAGS: 00010246
kern  :warn  : RAX: ffffffffa0d7aaf2 RBX: 0000000000000000 RCX: ffffffffa0d7aaf2
kern  :warn  : RDX: 0000000000000011 RSI: ffffffffa0d5a170 RDI: ffffffffa128db10
kern  :warn  : RBP: ffff91650ae52060 R08: 0000000000000010 R09: ffffa7a5c31b2000
kern  :warn  : R10: ffffa7a5c03a3bf0 R11: 00000000ffffffff R12: 0000000000000000
kern  :warn  : R13: ffffa7a5c31b2000 R14: 0000000000001000 R15: 0000000000000000
kern  :warn  : FS:  0000000000000000(0000) GS:ffff91743e664000(0000) knlGS:0000000000000000
kern  :warn  : CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : CR2: 00007f10786c241c CR3: 00000003eca24000 CR4: 0000000000f50ef0
kern  :warn  : PKRU: 55555554
kern  :warn  : Call Trace:
kern  :warn  :  <TASK>
kern  :warn  :  mt76_connac2_load_patch.cold+0x2b/0xa41 [mt76_connac_lib]
kern  :warn  :  ? srso_alias_return_thunk+0x5/0xfbef5
kern  :warn  :  mt792x_load_firmware+0x36/0x150 [mt792x_lib]
kern  :warn  :  mt7921_run_firmware+0x2c/0x4a0 [mt7921_common]
kern  :warn  :  ? srso_alias_return_thunk+0x5/0xfbef5
kern  :warn  :  ? mt7921_rr+0x12/0x30 [mt7921e]
kern  :warn  :  ? srso_alias_return_thunk+0x5/0xfbef5
kern  :warn  :  ? ____mt76_poll_msec+0x75/0xb0 [mt76]
kern  :warn  :  mt7921e_mcu_init+0x4c/0x7a [mt7921e]
kern  :warn  :  mt7921_init_work+0x51/0x190 [mt7921_common]
kern  :warn  :  process_one_work+0x18b/0x340
kern  :warn  :  worker_thread+0x256/0x3a0
kern  :warn  :  ? __pfx_worker_thread+0x10/0x10
kern  :warn  :  kthread+0xfc/0x240
kern  :warn  :  ? __pfx_kthread+0x10/0x10
kern  :warn  :  ? __pfx_kthread+0x10/0x10
kern  :warn  :  ret_from_fork+0x254/0x290
kern  :warn  :  ? __pfx_kthread+0x10/0x10
kern  :warn  :  ret_from_fork_asm+0x1a/0x30
kern  :warn  :  </TASK>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ea99167765b0..fba7025ffd3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3101,7 +3101,6 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	int i, ret, sem, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
 	const struct mt76_connac2_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
-	char build_date[17];
 
 	sem = mt76_connac_mcu_patch_sem_ctrl(dev, true);
 	switch (sem) {
@@ -3125,11 +3124,8 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	}
 
 	hdr = (const void *)fw->data;
-	strscpy(build_date, hdr->build_date, sizeof(build_date));
-	build_date[16] = '\0';
-	strim(build_date);
 	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
-		 be32_to_cpu(hdr->hw_sw_ver), build_date);
+		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
 
 	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
 		struct mt76_connac2_patch_sec *sec;
-- 
2.51.0


