Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8A6E583
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfGSMRp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 08:17:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44721 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfGSMRp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 08:17:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so15524281plr.11;
        Fri, 19 Jul 2019 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdW91kGbtMx1/wFOgVLAAmhmR53/Mmovc2B4qKSLVoM=;
        b=tPV17GxCfw5GOn9Z0SM0asoH6tv9DsX2Mclc+LSSVLakBXKMFML2Nz1RqCm69dXf+4
         MdNq5/hych7y5E5zSSQn3QbuoCIZJ+yFtf6KM6jbGBLY8qxp7sk9isvGd4mS7j0ecQ3q
         RShEFu0wZ2yyQkTD2bmGjPnelmS9Cz4K8GIYnjzmYbtfhtej4sZ+ELlk9/v+QNtspy+i
         k1/ffZR6ZiJD4stuV0bDxMIzzDhgYDg1BAynZHpK1M9YTvsLNswDyxb6MfP5ZG2E2JU8
         U/2nswAdXaMprd/cETjMj26I3jnB+dOuO9mjr172uRQeZ+F4Nwob4C5fhUO+k8/AsA67
         hfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdW91kGbtMx1/wFOgVLAAmhmR53/Mmovc2B4qKSLVoM=;
        b=DnTdnsviBuH+g7gNv109I6zSUMb1OFhXzHJ8G75Bm0c4q++c1vkKea/5LfgbNd/3G6
         rU5LEB5ra6kMbkw3IJaDRDjy4AQhTDNeV1aAyfRHgLm0X/dKdGADCRpTfwljrEP2dsu0
         vOlO9MsxgTPT6NhCiEcUT8CpK2XVii28zPO5eW23fbKXyfxnuSA0JEPfszR9iV44uVlx
         01AQ/UitCp4BxAnaYdWjOhqGSIDs3CKOSiGAn8vmACx1dCW5GT9uYn3U7wnir9mkt7Me
         B5ZZdB1t7Zad2b9NpvR5QM8a3jb9yQqr9BhMCYrIHQrdYSHnZY0eZAuagSxve2abzUJk
         PZCg==
X-Gm-Message-State: APjAAAWhHkXqJ5Dr/Csw+Cfqp2NqXyMpk2lggAehiA91gWkZhGN08UnR
        /sasFi6BiXPi2wz3661EUT0=
X-Google-Smtp-Source: APXvYqwN+QPUUYQwwFwo9H5EL3ZGPZ+sUtXsif9yiR1QJxdwfi6TZS0sbm/Job3/qEJ0qpOejVDGeQ==
X-Received: by 2002:a17:902:4501:: with SMTP id m1mr56949207pld.111.1563538665054;
        Fri, 19 Jul 2019 05:17:45 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id z2sm27019181pgg.58.2019.07.19.05.17.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 05:17:44 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] staging: wilc1000: Merge memcpy + le32_to_cpus to get_unaligned_le32
Date:   Fri, 19 Jul 2019 20:16:07 +0800
Message-Id: <20190719121605.22640-1-hslester96@gmail.com>
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
Changes in v2:
 - Merge the two patches with the same
   subject line.

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

