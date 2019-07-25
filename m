Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BABD74366
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 04:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbfGYCqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 22:46:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33042 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388165AbfGYCqT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 22:46:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so21919312pfq.0;
        Wed, 24 Jul 2019 19:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGb+53W3+gVi5IhRG8bYdezC8LvWPACMjaeRX6JLss8=;
        b=TL/rqBtftf+PW2Gv4BMOCqIn5e5e8A/pFGqG6XXkzVseQ7n84Qn732l0EXBGS+pk2L
         w0ijV3UB45+bYRzkNYlpyCv78lszpntKYjHidT7MvL2VwoeGoSXFFSm4gV819TsGTncD
         Cx4brIDiumMiZLqDBo7eaZNBpDxRhj3DloMKkarUiIFMaoU2C1u62/GU+kQtOxtrBYCU
         JqxJ7qMhLkAGEgQu6YmJWUzV0GIIUQH2a3V+VLZxcclf696iyxS0V+MLB3q0lSWNyFAi
         RNiw1oEgCRM43EgZXqabZc8HqC8h6GuSulc2FMJlp2UvDBu7eODeejbo2Wn6Rtiv/+00
         IJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGb+53W3+gVi5IhRG8bYdezC8LvWPACMjaeRX6JLss8=;
        b=LJbLOarXYOoE9qcRJ9cAPLAruLKC/Xb7U/J7OjCN0nfRoplWnMfpzEA/wrMj4PcklS
         FNGRBFKKj9x5z5+GyMWytPcFOBjRk4kRDsoThJIiHWHYE1wKTb2jNn2sb0oaVgscYNlQ
         LOZp+4Oqr40k4ZV3xu5uPJPcBBOd+YAwcYLbgyGodN+/PEZbZypZ+9PEbmGECTqAuDr9
         vKeRU886tP8rbODrWPGSkf2AK/h0l3vmP3cKDOKQKal7oLdoJ1fVsmEU7OBn1IiEwrPO
         0OMS5phk5JzTGqh8MTVgzks5jQUYNaHleaGVYdb9NN+4X8/HTyfmBeA9X7Q+jvAwjt05
         Z1LA==
X-Gm-Message-State: APjAAAVt1KM0khgE8SHJo08yYkC0oNVXRjmIq7blwlvgDL3zYLvAXzpa
        jh/+pfM1crBxUsapT2qIXMU=
X-Google-Smtp-Source: APXvYqzCUCQN8nnmTYZHETQ9ZiqagR86HgVQISOEyQ0ACAhdNbK1st9YpRwV3J7qsO8BnlaI78/v+A==
X-Received: by 2002:a62:e806:: with SMTP id c6mr14504052pfi.158.1564022778701;
        Wed, 24 Jul 2019 19:46:18 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id e17sm38910176pgm.21.2019.07.24.19.46.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 19:46:17 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] staging: wilc1000: Merge memcpy + le32_to_cpus to get_unaligned_le32
Date:   Thu, 25 Jul 2019 10:46:12 +0800
Message-Id: <20190725024612.8604-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Merge the combo use of memcpy and le32_to_cpus.
Use get_unaligned_le32 instead.
This simplifies the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/staging/wilc1000/wilc_mon.c               | 3 +--
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
 drivers/staging/wilc1000/wilc_wlan.c              | 9 +++------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_mon.c b/drivers/staging/wilc1000/wilc_mon.c
index 7d7933d40924..d6f14f69ad64 100644
--- a/drivers/staging/wilc1000/wilc_mon.c
+++ b/drivers/staging/wilc1000/wilc_mon.c
@@ -35,8 +35,7 @@ void wilc_wfi_monitor_rx(struct net_device *mon_dev, u8 *buff, u32 size)
 		return;
 
 	/* Get WILC header */
-	memcpy(&header, (buff - HOST_HDR_OFFSET), HOST_HDR_OFFSET);
-	le32_to_cpus(&header);
+	header = get_unaligned_le32(buff - HOST_HDR_OFFSET);
 	/*
 	 * The packet offset field contain info about what type of management
 	 * the frame we are dealing with and ack status
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index d72fdd333050..12fb4add05ec 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1038,8 +1038,7 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
 	s32 freq;
 	__le16 fc;
 
-	memcpy(&header, (buff - HOST_HDR_OFFSET), HOST_HDR_OFFSET);
-	le32_to_cpus(&header);
+	header = get_unaligned_le32(buff - HOST_HDR_OFFSET);
 	pkt_offset = GET_PKT_OFFSET(header);
 
 	if (pkt_offset & IS_MANAGMEMENT_CALLBACK) {
diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc1000/wilc_wlan.c
index d46876edcfeb..7d438ae90c3e 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -703,8 +703,7 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 
 	do {
 		buff_ptr = buffer + offset;
-		memcpy(&header, buff_ptr, 4);
-		le32_to_cpus(&header);
+		header = get_unaligned_le32(buff_ptr);
 
 		is_cfg_packet = (header >> 31) & 0x1;
 		pkt_offset = (header >> 22) & 0x1ff;
@@ -874,10 +873,8 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 	offset = 0;
 	do {
-		memcpy(&addr, &buffer[offset], 4);
-		memcpy(&size, &buffer[offset + 4], 4);
-		le32_to_cpus(&addr);
-		le32_to_cpus(&size);
+		addr = get_unaligned_le32(&buffer[offset]);
+		size = get_unaligned_le32(&buffer[offset + 4]);
 		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
 		offset += 8;
 		while (((int)size) && (offset < buffer_size)) {
-- 
2.20.1

