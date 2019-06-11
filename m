Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243E63CAFC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfFKMTY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 08:19:24 -0400
Received: from durin.narfation.org ([79.140.41.39]:56866 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfFKMTX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 08:19:23 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970379EE000000000000070D.dip0.t-ipconnect.de [IPv6:2003:c5:9703:79ee::70d])
        by durin.narfation.org (Postfix) with ESMTPSA id EF9A91100D3;
        Tue, 11 Jun 2019 14:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560255561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qqBTwquj+/+qeCna/vowQ9lULWZujDdkUGiUnhQczqk=;
        b=SW5T63ugWxYa8bRMH+6NvKyd47cX4jxj3osw7l041oJq55zx2msFBJfcIMtSk5cYBbme9f
        G0HlrvXvcmWCZndT8u69RZNlYi7kGiH60wULZb/ts18Ka+j+/SHKmr5CyjHqZPG3wLCtiR
        K2Cc8npAErMbD76sSAXhOrU4/SKoSTk=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>,
        Michal Kazior <michal@plume.com>
Subject: [PATCH] ath10k: fix max antenna gain unit
Date:   Tue, 11 Jun 2019 14:19:10 +0200
Message-Id: <20190611121910.27643-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560255561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qqBTwquj+/+qeCna/vowQ9lULWZujDdkUGiUnhQczqk=;
        b=ORJyWRIRUK81kZ1FIv2c3gQ0vtA1VibKzesh8rXD8aW9izu/WWTfdSc3/7RYdt8hslf1CX
        dPfkCcU7wJFLdm8JZIGR9lP3nVRSWLHJ3cNGmVPuB4nLi9sVsuCCstwD166xlpPjuwmClv
        tnMFAI1qyFN5ulDh8OeoSE6D1+o+6BA=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560255561; a=rsa-sha256;
        cv=none;
        b=hGOvKs1Whed3Q6xW+fPohBK/t/J9iKPkLUkpADy81S4tD634mf3vWxaFE9t77GTQANw2eH
        EmAKADiXjrUlDDFNl5raHFKo7J9zx3GFh0OfcBO6Q4C/2hH7TQu3SCNfiXBpF0YYEwFMqx
        lf4h+IoFTdixsYA+CBhN5Qvq/HYOnZY=
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
Cc: Michal Kazior <michal@plume.com>

 drivers/net/wireless/ath/ath10k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.20.1

