Return-Path: <linux-wireless+bounces-24328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69909AE32FB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 01:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B33AF398
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834501946AA;
	Sun, 22 Jun 2025 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gY9R4tMA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17717736;
	Sun, 22 Jun 2025 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750634804; cv=none; b=ZxOMiKVEo5eMvxYgEweYRHCeMUge4PvpuMDdiIPHg0oYb6DXv3XuEnnZwJL0DSqoqoZZZrVydcwxiV7QGV2hUaFKvQc9QBRO6Sdpn3cMPCmI+HI8hncmH4G/6hPObNzDDaFbs6AJY5k/hyZaIB7OpW8Bgl1UQ9XR3LBV9kW+VMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750634804; c=relaxed/simple;
	bh=+C/1OoUdQovXCcu8YHTk5NOO89dN6H6ZssVeodNdwiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7x36V3SF537O/2HfGGM+ALl832aOPy9kietJtr+5eim44b4vOMnNPnzOLhT1Qcq/yLdnfia+Pf66CTUqvl+LAOdwnM0MY0O5oDLk3eho3qcbnp/kwPYaVqKfuBuFs6z8IOwHqRhy7olHpbouqojPkzvL0Nwk4LEvOEUqePZ2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gY9R4tMA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=+MYU5dVQMEQs21wqqs0XDYcIHqDOwARR3XjJDngflls=; b=gY9R4tMAbn8hkEhV
	rMhWxgumn9YTt3fK1DBsTq4mCS2x+yrY8f3DQIYdPd9YqSlk2iytI+sQmSn+PtbhCHwGJZzAkbixS
	64FFtNSoTCYl0TodyfJe6Wi4DcmcHp77JuEWGrBTvUOd77KM+/85mdTj/xRlTmaZbl4n5h8SywIAr
	OMQWb+/DOKkNYgHh6J+rir78puzHSZhASVW4r6ALGoj8KURBwwWZpDHgBMkAPT82L2j9OXtJ7pFQo
	xiYt6bEbVJCfdiw92xFBDHU3sVlH4D1K14Pn3dLSUjbv84G0LStejXXy6CrRhSP0z/vjkAEcoQ8TD
	leCTf2vvKLL8cCRkhg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uTU59-00B9N6-04;
	Sun, 22 Jun 2025 23:26:39 +0000
From: linux@treblig.org
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] wifi: wlcore: Remove unused wl12xx_cmd_start_fwlog
Date: Mon, 23 Jun 2025 00:26:38 +0100
Message-ID: <20250622232638.166283-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

wl12xx_cmd_start_fwlog() was added in 2011 by
commit 95dac04f8813 ("wl12xx: Support routing FW logs to the host")
but has remained unused.

Remove it.

(I can see the 'stop' is used, and the 'config' is used, so I assume
the 'start' isn't normally needed).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/ti/wlcore/cmd.c | 26 --------------------------
 drivers/net/wireless/ti/wlcore/cmd.h |  1 -
 2 files changed, 27 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index cd8ad0fe59cc..fa3a3f71dd15 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -1804,32 +1804,6 @@ int wl12xx_cmd_config_fwlog(struct wl1271 *wl)
 	return ret;
 }
 
-int wl12xx_cmd_start_fwlog(struct wl1271 *wl)
-{
-	struct wl12xx_cmd_start_fwlog *cmd;
-	int ret = 0;
-
-	wl1271_debug(DEBUG_CMD, "cmd start firmware logger");
-
-	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
-	if (!cmd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = wl1271_cmd_send(wl, CMD_START_FWLOGGER, cmd, sizeof(*cmd), 0);
-	if (ret < 0) {
-		wl1271_error("failed to send start firmware logger command");
-		goto out_free;
-	}
-
-out_free:
-	kfree(cmd);
-
-out:
-	return ret;
-}
-
 int wl12xx_cmd_stop_fwlog(struct wl1271 *wl)
 {
 	struct wl12xx_cmd_stop_fwlog *cmd;
diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index 4c2f2608ef3b..d16afb35f9ee 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -81,7 +81,6 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl);
 int wlcore_cmd_generic_cfg(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			   u8 feature, u8 enable, u8 value);
 int wl12xx_cmd_config_fwlog(struct wl1271 *wl);
-int wl12xx_cmd_start_fwlog(struct wl1271 *wl);
 int wl12xx_cmd_stop_fwlog(struct wl1271 *wl);
 int wl12xx_cmd_channel_switch(struct wl1271 *wl,
 			      struct wl12xx_vif *wlvif,
-- 
2.49.0


