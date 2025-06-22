Return-Path: <linux-wireless+bounces-24317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E06DAE311D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B21188725F
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E31F4180;
	Sun, 22 Jun 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jF5Ebl3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAA372;
	Sun, 22 Jun 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613298; cv=none; b=R01J6zZnDu032D4wvNYevPusLFJJnidkJa3pbgupsbAZihnuEnTeiK5d2hAiqdJjX3cLPE8xoXIzTDsR0680wa040Zi/nWofzmuZT72S/a3G8PAW4awUDdZabmLgnkWkK3/MjDEvFqPnomx2+FpafbvNNcCcah+qB/8L5WY8/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613298; c=relaxed/simple;
	bh=3Q15pGnF9/xkAVJe8Yn7GZWak7Rg4FNSnfsz/WA7CoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXsKqWKs/7K6kSQFSWv4BZhE/YmA5zkD1mgE44mY3+rqaNN9b/FeF9ZW5pY6wPBwcxdo2cIngyrO4U9P9Wt16m9CIS1d6rezMC1wqLB0gOn8+rtRXRkWOSjh3uKwTzbALpB9JJeglgfoGDbBxWo5u/ej+JMd9maQVaW80h0pzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jF5Ebl3D; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=mZkPlrrtOByPGH4PmujXU6Mq8UIXNhwXyOOe3mrHK5k=; b=jF5Ebl3DWi5Ds52T
	xnAutO2qC60Qgnj5uc0IlLr043HwYNgYfrS+Ym5HvFCtXF65aSLwPL6SBCa1eW8YkKvQ/hMo77x/C
	oSV+QC7V61FjVditZCzFLOP2rVBrVVFhjxVYsYjFpIZNzHkqfhkDy0+T0A109FuDyH/luJYqBB7Be
	rvgJxcOJMovLbIePeAoQNwaw+CZhLAByQaguwJzdsBhPZwwPeSg60u2w978BjadGU6A9bFe/fRl5/
	bItDly6pOcLid09eKquXXk2Sg30NNrzI2qHIUltzLcpqHCl5Hhs94g8rFueiHk/M8/nOKSnes2gaW
	fjn1Q1qOHiX0CSdxTg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uTOUB-00B7p5-0n;
	Sun, 22 Jun 2025 17:28:07 +0000
From: linux@treblig.org
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] wl1251: Remove unused wl1251_cmd_*
Date: Sun, 22 Jun 2025 18:28:04 +0100
Message-ID: <20250622172804.116396-3-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622172804.116396-1-linux@treblig.org>
References: <20250622172804.116396-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

wl1251_cmd_read_memory() and wl1251_cmd_test() last use was removed in
2009 by
commit f298c282a523 ("wl1251: remove accidentally added wl1251_netlink.c")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/ti/wl1251/cmd.c | 79 ----------------------------
 drivers/net/wireless/ti/wl1251/cmd.h |  3 --
 2 files changed, 82 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/cmd.c b/drivers/net/wireless/ti/wl1251/cmd.c
index c3be81dc7970..c33ee0d4d323 100644
--- a/drivers/net/wireless/ti/wl1251/cmd.c
+++ b/drivers/net/wireless/ti/wl1251/cmd.c
@@ -58,47 +58,6 @@ int wl1251_cmd_send(struct wl1251 *wl, u16 id, void *buf, size_t len)
 	return ret;
 }
 
-/**
- * wl1251_cmd_test - Send test command to firmware
- *
- * @wl: wl struct
- * @buf: buffer containing the command, with all headers, must work with dma
- * @buf_len: length of the buffer
- * @answer: is answer needed
- */
-int wl1251_cmd_test(struct wl1251 *wl, void *buf, size_t buf_len, u8 answer)
-{
-	int ret;
-
-	wl1251_debug(DEBUG_CMD, "cmd test");
-
-	ret = wl1251_cmd_send(wl, CMD_TEST, buf, buf_len);
-
-	if (ret < 0) {
-		wl1251_warning("TEST command failed");
-		return ret;
-	}
-
-	if (answer) {
-		struct wl1251_command *cmd_answer;
-
-		/*
-		 * The test command got in, we can read the answer.
-		 * The answer would be a wl1251_command, where the
-		 * parameter array contains the actual answer.
-		 */
-		wl1251_mem_read(wl, wl->cmd_box_addr, buf, buf_len);
-
-		cmd_answer = buf;
-
-		if (cmd_answer->header.status != CMD_STATUS_SUCCESS)
-			wl1251_error("TEST command answer error: %d",
-				     cmd_answer->header.status);
-	}
-
-	return 0;
-}
-
 /**
  * wl1251_cmd_interrogate - Read acx from firmware
  *
@@ -339,44 +298,6 @@ int wl1251_cmd_ps_mode(struct wl1251 *wl, u8 ps_mode)
 	return ret;
 }
 
-int wl1251_cmd_read_memory(struct wl1251 *wl, u32 addr, void *answer,
-			   size_t len)
-{
-	struct cmd_read_write_memory *cmd;
-	int ret = 0;
-
-	wl1251_debug(DEBUG_CMD, "cmd read memory");
-
-	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
-	if (!cmd)
-		return -ENOMEM;
-
-	WARN_ON(len > MAX_READ_SIZE);
-	len = min_t(size_t, len, MAX_READ_SIZE);
-
-	cmd->addr = addr;
-	cmd->size = len;
-
-	ret = wl1251_cmd_send(wl, CMD_READ_MEMORY, cmd, sizeof(*cmd));
-	if (ret < 0) {
-		wl1251_error("read memory command failed: %d", ret);
-		goto out;
-	}
-
-	/* the read command got in, we can now read the answer */
-	wl1251_mem_read(wl, wl->cmd_box_addr, cmd, sizeof(*cmd));
-
-	if (cmd->header.status != CMD_STATUS_SUCCESS)
-		wl1251_error("error in read command result: %d",
-			     cmd->header.status);
-
-	memcpy(answer, cmd->value, len);
-
-out:
-	kfree(cmd);
-	return ret;
-}
-
 int wl1251_cmd_template_set(struct wl1251 *wl, u16 cmd_id,
 			    void *buf, size_t buf_len)
 {
diff --git a/drivers/net/wireless/ti/wl1251/cmd.h b/drivers/net/wireless/ti/wl1251/cmd.h
index 39159201b97e..3474b45af3b1 100644
--- a/drivers/net/wireless/ti/wl1251/cmd.h
+++ b/drivers/net/wireless/ti/wl1251/cmd.h
@@ -16,7 +16,6 @@
 struct acx_header;
 
 int wl1251_cmd_send(struct wl1251 *wl, u16 type, void *buf, size_t buf_len);
-int wl1251_cmd_test(struct wl1251 *wl, void *buf, size_t buf_len, u8 answer);
 int wl1251_cmd_interrogate(struct wl1251 *wl, u16 id, void *buf, size_t len);
 int wl1251_cmd_configure(struct wl1251 *wl, u16 id, void *buf, size_t len);
 int wl1251_cmd_vbm(struct wl1251 *wl, u8 identity,
@@ -26,8 +25,6 @@ int wl1251_cmd_data_path_tx(struct wl1251 *wl, u8 channel, bool enable);
 int wl1251_cmd_join(struct wl1251 *wl, u8 bss_type, u8 channel,
 		    u16 beacon_interval, u8 dtim_interval);
 int wl1251_cmd_ps_mode(struct wl1251 *wl, u8 ps_mode);
-int wl1251_cmd_read_memory(struct wl1251 *wl, u32 addr, void *answer,
-			   size_t len);
 int wl1251_cmd_template_set(struct wl1251 *wl, u16 cmd_id,
 			    void *buf, size_t buf_len);
 int wl1251_cmd_scan(struct wl1251 *wl, u8 *ssid, size_t ssid_len,
-- 
2.49.0


