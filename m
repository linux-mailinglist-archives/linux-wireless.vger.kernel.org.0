Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6813D3DE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406033AbfFKRVm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 13:21:42 -0400
Received: from durin.narfation.org ([79.140.41.39]:35228 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405941AbfFKRVm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 13:21:42 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970379EE000000000000070D.dip0.t-ipconnect.de [IPv6:2003:c5:9703:79ee::70d])
        by durin.narfation.org (Postfix) with ESMTPSA id B08C91100D3;
        Tue, 11 Jun 2019 19:21:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560273699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kU6Cx+QF+HQWdzS3+lqeW/QVTmgBgz0nlQEWJ9d/Ui4=;
        b=e/idni2P7NZPeJ7h1SMVMaOygRyC/05noP/Okp79fyexNGPf/cwvf4UcEPUHbgrMqaeqLE
        KrdOuHpRReVVXoc3mTqitBwBEytxL3d+aH95ab+sd6qJ05VgS6l5Dyo8DusPNHVxayae65
        aI2oDCkwLX3h+6nEbqcGFyc4wkfecKc=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: [PATCH v2] ath10k: fix max antenna gain unit
Date:   Tue, 11 Jun 2019 19:21:31 +0200
Message-Id: <20190611172131.6064-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560273699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kU6Cx+QF+HQWdzS3+lqeW/QVTmgBgz0nlQEWJ9d/Ui4=;
        b=qu8Ikce6yG1ZllXg2EsGciac52YsjeWquAEgfug5J2Y78Ru2aLLIr2uq9TQfqoVTiF5nKw
        zCXvpjt75qzOWfS8+YroS9Itw5MtuDy2azWYRI2zSVoLIVRdpS6CS3Jjl8Z/xVoOqPV8LG
        a/TYciDb6+xYIrTwkYQwABn0kYwwBc8=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560273699; a=rsa-sha256;
        cv=none;
        b=J9V2rRUGctqaamacYnyA3X5Qqj3mY9xSr88g7F6Ae6eRHPbeVxG+U2pygFI8r9XLbVj8rv
        aGwi0peCJE1Ar4iG7aE5aQ6PHSw1KpO8ciHlaIvm9cOs4aKqeT5X9Z1CVNRSqU1MNs05VK
        9NuV40vuKCL8IC9nIlnPPpFU6I83p6Y=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

Most of the txpower for the ath10k firmware is stored as twicepower (0.5 dB
steps). This isn't the case for max_antenna_gain - which is still expected
by the firmware as dB.

The firmware is converting it from dB to the internal (twicepower)
representation when it calculates the limits of a channel. This can be seen
in tpc_stats when configuring "12" as max_antenna_gain. Instead of the
expected 12 (6 dB), the tpc_stats shows 24 (12 dB).

Tested on QCA9888 and IPQ4019 with firmware 10.4-3.5.3-00057.

Fixes: 02256930d9b8 ("ath10k: use proper tx power unit")
Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
---
v2:
* Add comments to wmi.h regarding the power unit

 drivers/net/wireless/ath/ath10k/mac.c | 6 +++---
 drivers/net/wireless/ath/ath10k/wmi.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 9c703d287333..35d026a2772a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1008,7 +1008,7 @@ static int ath10k_monitor_vdev_start(struct ath10k *ar, int vdev_id)
 	arg.channel.min_power = 0;
 	arg.channel.max_power = channel->max_power * 2;
 	arg.channel.max_reg_power = channel->max_reg_power * 2;
-	arg.channel.max_antenna_gain = channel->max_antenna_gain * 2;
+	arg.channel.max_antenna_gain = channel->max_antenna_gain;
 
 	reinit_completion(&ar->vdev_setup_done);
 
@@ -1450,7 +1450,7 @@ static int ath10k_vdev_start_restart(struct ath10k_vif *arvif,
 	arg.channel.min_power = 0;
 	arg.channel.max_power = chandef->chan->max_power * 2;
 	arg.channel.max_reg_power = chandef->chan->max_reg_power * 2;
-	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
+	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain;
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		arg.ssid = arvif->u.ap.ssid;
@@ -3105,7 +3105,7 @@ static int ath10k_update_channel_list(struct ath10k *ar)
 			ch->min_power = 0;
 			ch->max_power = channel->max_power * 2;
 			ch->max_reg_power = channel->max_reg_power * 2;
-			ch->max_antenna_gain = channel->max_antenna_gain * 2;
+			ch->max_antenna_gain = channel->max_antenna_gain;
 			ch->reg_class_id = 0; /* FIXME */
 
 			/* FIXME: why use only legacy modes, why not any
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index e1c40bb69932..9cc0ef47deb7 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -2038,7 +2038,9 @@ struct wmi_channel {
 	union {
 		__le32 reginfo1;
 		struct {
+			/* note: power unit is 1 dBm */
 			u8 antenna_max;
+			/* note: power unit is 0.5 dBm */
 			u8 max_tx_power;
 		} __packed;
 	} __packed;
@@ -2058,6 +2060,7 @@ struct wmi_channel_arg {
 	u32 min_power;
 	u32 max_power;
 	u32 max_reg_power;
+	/* note: power unit is 1 dBm */
 	u32 max_antenna_gain;
 	u32 reg_class_id;
 	enum wmi_phy_mode mode;
-- 
2.20.1

