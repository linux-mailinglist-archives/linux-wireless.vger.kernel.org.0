Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2167176878
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 00:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCBXuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 18:50:08 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37989 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 18:50:08 -0500
Received: by mail-pl1-f202.google.com with SMTP id r16so749931pls.5
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2020 15:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qkHpPN7XbNDKm27YorIIR9c6eJ2NB+3lFpi/2cpvZIg=;
        b=tHADq9oOprlWZEs91Bjo6UT4sqKlhfADhv6v9/ZdPREwmO9vXEWww3NdnbVjc5oxON
         6Z53i9AQqiYFuRvpizdxw+Xnwjct13gFRgFH8hWIudcozQSBzExNVDBkhoJRpnIuE3Xl
         52PIyg7eu1J6NR+mVtNjw491HGYzhnfJTB/HQ3gLO0KFWC2oqvoTbthe1KQv/JkmeYDk
         X+Q7ME2T85CnRcL7bi3cxlNYBLTUPtWfXYbJYA6swveJCZbky25peWc4qmwstycwyRHL
         VDOqIaVwXpOpwDymjMWo1RMUSDhhWBcNZtm+fk/wZpIgS/tjRZuig3RBvmJ/KNbuoI86
         oLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qkHpPN7XbNDKm27YorIIR9c6eJ2NB+3lFpi/2cpvZIg=;
        b=rf1v4DApDSNYlBRWOpyDHFtIvltrIzPr9nAmgjdYk8xUPRLASuOp9b0GiBwTh4XFIb
         Jydw6hOfc1I2XePOSKHcFqWFTrnX9zgvrE86HeImx/R8/DWQEbTda3zYSLLyCjNcxziu
         6c+/UsqBg06B/cyI0SJ18v5MCal9f1LRh4bVTY/Aq6QHQCial6Si/6xTF3M4eHvC0Gpc
         q5r16iF3IRdcC6ZlzzuZ2V8fvfKG53p57UqUSoT9oFpQFQ+VhyJptzZoxJNbgeEtMX4g
         FDryP38t5BaurgLrk3FIl+B6JRMqls2dXfTGZIwLBl/hZwMrf50U19C7XOvxHm8GrSfe
         c3Pg==
X-Gm-Message-State: ANhLgQ1j8nCcjtuIK+VwkTsnCl+eVyBfXH+oTQe1szSbQfCZkehax0c3
        Ztdnmtw+IEc8GesJPOSMD3gxNiAk
X-Google-Smtp-Source: ADFU+vvyPLAr6bONag95T7U0mLPZOv9tmU+qTNKNyt/N4KL7RLJVPVIY4KC8LkhWzt/HDLMedNh6pvNX
X-Received: by 2002:a63:d245:: with SMTP id t5mr1308586pgi.84.1583193003770;
 Mon, 02 Mar 2020 15:50:03 -0800 (PST)
Date:   Mon,  2 Mar 2020 15:49:46 -0800
Message-Id: <20200302234946.75425-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] net: wireless: Add module_param(mac_prefix) to mac80211_hwsim
From:   rkir@google.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lfy@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

By default mac80211_hwsim creates N radios with
MAC addresses like '02:00:00:nn:nn:00' where nnnn
is incremented.

We (Android Studio Emulator) need a way to have unique
MAC addresses. Currently in mac80211_hwsim this can
be done by sending HWSIM_CMD_DEL_RADIO and
HWSIM_CMD_NEW_RADIO commands.

The 'mac_prefix' parameter provides an easier way to
make MAC address unique by specifying two octets in
MAC address, i.e. '02:pp:pp:nn:nn:00'.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 03738107fd10..1519435ecc76 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -62,6 +62,10 @@ static bool support_p2p_device = true;
 module_param(support_p2p_device, bool, 0444);
 MODULE_PARM_DESC(support_p2p_device, "Support P2P-Device interface type");
 
+static ushort mac_prefix;
+module_param(mac_prefix, ushort, 0444);
+MODULE_PARM_DESC(mac_prefix, "Second and third most significant octets in MAC");
+
 /**
  * enum hwsim_regtest - the type of regulatory tests we offer
  *
@@ -2811,6 +2815,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	if (!param->perm_addr) {
 		eth_zero_addr(addr);
 		addr[0] = 0x02;
+		addr[1] = (mac_prefix >> 8) & 0xFF;
+		addr[2] = mac_prefix & 0xFF;
 		addr[3] = idx >> 8;
 		addr[4] = idx;
 		memcpy(data->addresses[0].addr, addr, ETH_ALEN);
-- 
2.25.0.265.gbab2e86ba0-goog

