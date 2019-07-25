Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C392174372
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 04:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfGYCwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 22:52:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40898 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388165AbfGYCwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 22:52:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so22732107pla.7;
        Wed, 24 Jul 2019 19:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7uFTn+wdUyY6FftVjNKnXfk6vSQHgFo0Xy22iR7DoA=;
        b=my3er5fJAwtBvMUkVZV+AWlRF3hSSlzyMPmRDPSBe4xkSXH28IHLlhXMwODJAWVKqd
         A9u3ZVhULFzLu7Q+7Vi1TI/AlWes2deS6zaTOPf+A+YQQegUddfE8RbvmXzA3tiO7bLS
         Zv+J8ea9u7pbGVOi8oqHvSpwWzRTsL2eByOqxxbhRPn5UwnBJqP98eBrg496MRa3DNTr
         gni8hyzZmLmZBoygCAdlPZKSeWgUEHmnpaNYye/4oou5enGlHh1Ko84piaS+1gBIp5R8
         q/Lxx26+4ihmrt6w4De3X7dw42ek++Htl5KCuEksCzS0lM2RGGm1eLLZYRbDmPkpt5xy
         QKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7uFTn+wdUyY6FftVjNKnXfk6vSQHgFo0Xy22iR7DoA=;
        b=K+8+K9XUuhr4yPds2xkHZO5wKu1SyUjYPGWlroz3+C3vazcrfqbOZNX1LPTFlmMZU1
         ncLaji4hwcodzAYnbjXhy5HHpHjVdWGjGsXGNvBYVnUA3cc6TSvoaHBZtDXjhKc5/wX+
         nVbvZE8VyhHFyP/nFrvnQEclCn4gILavDfN7nogCP0rlGnsZffRW5GEBqBypzY9l4lhL
         1KL5bTFfMwb1rE19K9+5Dvv6jTZy2GFhOYMdcLZ7tAFZMhYnbMTLM1eAqYqIH8y3gMF+
         kXtLHj+R6lgu3kQBuOYTUAzbRVo3ofpm8gasXZCVydc79sko5AAmLqripDrvHM+0XayA
         uKUw==
X-Gm-Message-State: APjAAAV+104sAqRO2bGyKIpSF0FzJB/fVQfqaZtOBicpezF6gIEyVQDj
        M9heEvC1eEIku++yMe8i368=
X-Google-Smtp-Source: APXvYqyrUO7NZ2PJ3hkWF7aJ8vDZzi9nuamErbVVvaw17u++wG3U88xnYdPJeVfQ+mpCWuJn0aSu0Q==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr88439874plf.86.1564023129477;
        Wed, 24 Jul 2019 19:52:09 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id k64sm29362195pge.65.2019.07.24.19.52.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 19:52:08 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] staging: wilc1000: Merge memcpy + le32_to_cpus to get_unaligned_le32
Date:   Thu, 25 Jul 2019 10:52:03 +0800
Message-Id: <20190725025203.8772-1-hslester96@gmail.com>
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
  - Merge the previous two patches which
    have the same subject line.

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

