Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937A496556
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfHTPuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbfHTPuR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9EB3A61BC5; Tue, 20 Aug 2019 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316216;
        bh=2F1F9boWJOGbQw14N9vfQeQAjB1xr1m9HcMjzk/B67I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlBPaxedzo73CMQnN7RD1qPUE972bbQf8dFSxZav7FIhKGOCN3DIAMk7W9fK2nLDy
         6Emhq155COp8lShwxqRnMrkbUGs7gOHh1JIPCmzGB3SnmxJWXo/5XDElQTNBDSva1T
         wZsiv1LHb8MPOKcxGqQUedswUnSR20sJwAUY3GJY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E90C61B76;
        Tue, 20 Aug 2019 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316194;
        bh=2F1F9boWJOGbQw14N9vfQeQAjB1xr1m9HcMjzk/B67I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9KVFCmSO+s+KYk5XRDbZne4hTiTWoPiZo07+3UjELthrimdxWib/UWcLXgVdRb2D
         zeqfEwL/WJAALFH15dStyEIb1ufmaKpuOm9RNcR7Xgx3dUdFUyoroR/ld5O8tS641u
         0KI75MXvAgkcIl0Eoa1B5jsRm6N8Y/9zVCLwDMTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E90C61B76
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 34/49] ath11k: add peer.h
Date:   Tue, 20 Aug 2019 18:48:00 +0300
Message-Id: <1566316095-27507-35-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/peer.h | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
new file mode 100644
index 000000000000..99e54f11cbc9
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_PEER_H
+#define ATH11K_PEER_H
+
+struct ath11k_peer {
+	struct list_head list;
+	struct ieee80211_sta *sta;
+	int vdev_id;
+	u8 addr[ETH_ALEN];
+	int peer_id;
+	u16 ast_hash;
+
+	/* protected by ab->data_lock */
+	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
+	struct dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
+};
+
+void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
+void ath11k_peer_map_event(struct ath11k_base *ab, u8 vdev_id, u16 peer_id,
+			   u8 *mac_addr, u16 ast_hash);
+struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
+				     const u8 *addr);
+struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
+					     const u8 *addr);
+struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab, int peer_id);
+void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id);
+int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr);
+int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
+		       struct ieee80211_sta *sta, struct peer_create_params *param);
+
+#endif /* _PEER_H_ */

