Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9616747B099
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhLTPss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43320 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhLTPss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F060E60F50
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC04C36AE7;
        Mon, 20 Dec 2021 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015327;
        bh=tCARAka90HJCeVm09RoWjjsBlzSaABtksK5H4ZlTfP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHt8mEru4rY1b7SxmcrQwvz18LEXSTyVT6328LjmKjcTWcoMFlY+cDHSsnAmSvs2Z
         iOENzVF3ZONdDKgz5QQANiNm8UZomxpl7zEk1sZnuo4MzXhMt2Yn1kNVuXjKZRWVc9
         nBs2eU6P3EFs5Rp9J20Ppn4tSaHNJqbcLru8IS61D3iL40XMRurLSJ3zrcVx0Poy1z
         Lbbe0uRdy2bdJbPG7tM9/FiJHb5jy7+cPUZEV0avRAcn8wPRPtQqvLI9KQ4WYIBqB3
         /t46hmYNkXNZIp0kT7GKhM4vYazai4yQ2+Al5Vd6XPOSrVdEql/+pnxX2Rr7LaKdk7
         b4/kXCFD2rJZA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 4/9] nl80211: report background radar/cac detection capability
Date:   Mon, 20 Dec 2021 16:48:19 +0100
Message-Id: <7580c321d3c6f8ebbcb1ac0951564526b8037540.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report background radar/cac detection capability if supported
by the underlying hw.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/drivers/driver.h              | 2 ++
 src/drivers/driver_nl80211_capa.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/src/drivers/driver.h b/src/drivers/driver.h
index d3312a34d..fa28b03db 100644
--- a/src/drivers/driver.h
+++ b/src/drivers/driver.h
@@ -2027,6 +2027,8 @@ struct wpa_driver_capa {
 #define WPA_DRIVER_FLAGS2_OCV			0x0000000000000080ULL
 /** Driver expects user space implementation of SME in AP mode */
 #define WPA_DRIVER_FLAGS2_AP_SME		0x0000000000000100ULL
+/** Driver supports background radar/CAC detection */
+#define WPA_DRIVER_RADAR_BACKGROUND		0x0000000000000200ULL
 	u64 flags2;
 
 #define FULL_AP_CLIENT_STATE_SUPP(drv_flags) \
diff --git a/src/drivers/driver_nl80211_capa.c b/src/drivers/driver_nl80211_capa.c
index 83868b78e..05703ec64 100644
--- a/src/drivers/driver_nl80211_capa.c
+++ b/src/drivers/driver_nl80211_capa.c
@@ -665,6 +665,10 @@ static void wiphy_info_ext_feature_flags(struct wiphy_info_data *info,
 	if (ext_feature_isset(ext_features, len,
 			      NL80211_EXT_FEATURE_OPERATING_CHANNEL_VALIDATION))
 		capa->flags2 |= WPA_DRIVER_FLAGS2_OCV;
+
+	if (ext_feature_isset(ext_features, len,
+			      NL80211_EXT_FEATURE_RADAR_BACKGROUND))
+		capa->flags2 |= WPA_DRIVER_RADAR_BACKGROUND;
 }
 
 
-- 
2.33.1

