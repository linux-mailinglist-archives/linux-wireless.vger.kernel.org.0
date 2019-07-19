Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AD6E2F8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfGSIzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 04:55:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45612 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfGSIzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 04:55:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so15299051plr.12;
        Fri, 19 Jul 2019 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV5j+XUqWBJfA9H3lN3dIsabShwNTCRmUvxvYq2uiYc=;
        b=Cwjj8OImi4J89USf/o0U1of0m4rjg+Hknu7KKXFkUNWnz2oxGkCPZq7Jh9CMeu/1C/
         WLqzfQ5JfOXJ2feKjfBxKtT8yS/Y+LBr4w+Uq9WcVeslwrHcD6hq2q8WbHXGNWKhKFOp
         etpCPYp+4oYoeqPBxWji7S++4UV9EGiECuYn6jPlv2xXt8g3zrP3SzxiQMBPQX9YXOkF
         vv/skUelxjuOD4SS6yuY67DjiU7H2Lx/d/FUvh6VYSPIFt4aj2ek29qyopemDYPgqrKY
         vPECVO209d4c9ExSulOD0OYsIsvKgGcNOl8Xdd3o/o1Iwd/bqEBB+FAoikOBxI1Fkp2L
         g4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV5j+XUqWBJfA9H3lN3dIsabShwNTCRmUvxvYq2uiYc=;
        b=g3R5wyNblRG91BgW3EiuXWz6dNJ7PX+oD18vvSW+AKGVAoRCU251/Kfc29iUb5R5YG
         BvIGYMhH/EiBtH31a0XiYrR/qoY4zlXIGxIM1JUig0f8DGsxgS3HzN0lTZQCoExAIumy
         Oz/GfXSP3M2bx+Z4bugmjyQyXVFBpAVp6cSca78hy1hyi3rv4KJfXNenv39KSS1us0l/
         nu94VDr0OpXpmZMuafjEbbAk6oyR4+z0T/DOX53bS2UNyovnuoQX//d2URBDSWVt3FWy
         kTcfGx5fnCJAnCAstAFxM47WtJ+4pLRXvBnejiEEkmGiDXFINjYnfRohL7kHwTXfwzzv
         Mpog==
X-Gm-Message-State: APjAAAWWVLmy9UXcx/etLiLoSN9x7fhqJC1rm1nPETESSgWG8zCWBz6J
        28swaoPlkINSuy3pjnhbcFB4W1tAgL8=
X-Google-Smtp-Source: APXvYqzr5/czZtUj4SwnWAsLsaUxE/e+JZt+xlsEffEtC2SwVU/HV6d1ADK3EWZLW2PIV9wO/RyP8g==
X-Received: by 2002:a17:902:2a68:: with SMTP id i95mr56582918plb.167.1563526540523;
        Fri, 19 Jul 2019 01:55:40 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id k3sm18202640pgq.92.2019.07.19.01.55.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 01:55:39 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to get_unaligned_le32
Date:   Fri, 19 Jul 2019 16:55:08 +0800
Message-Id: <20190719085507.10925-1-hslester96@gmail.com>
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
 drivers/staging/wilc1000/wilc_mon.c  | 3 +--
 drivers/staging/wilc1000/wilc_wlan.c | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

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

