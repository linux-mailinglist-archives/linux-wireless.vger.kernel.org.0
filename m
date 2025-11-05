Return-Path: <linux-wireless+bounces-28612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95EC36229
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661D9622529
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E833033D;
	Wed,  5 Nov 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BUpxXQPy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EE32E14E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353542; cv=none; b=Nxd2KSVZjSjnUWB+otrYWXzeRvBy7n35QLHo0xTfPqP132CXNLy/M05CUrZX1G7N+EoqTIykolW34RAuoZs7rt4kiIHO/WfZ3oV02+JJLLJ82YZtmfyCSNM8PNxrpe5dYPNkk+WGMWBDIKYnUJizvqRa2ps2lquXdZHnZEgEZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353542; c=relaxed/simple;
	bh=sGQqL5LUdEc7MfHN7J+gHy0+GKQWIMaUrfahJzlrrHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebtvI2iw5DLHjINFDzoQu/Z6ATavr11Bi/qtL77bfo2yU0nIEke/DK/IY4tiwKEi0zJbHAIEh3Ttm7e4ZMTprKzHOINqzR1Sd+zmj8/w1BtOmF2begYDBHjVFp/H6gRGksN1Dz5WKneKHD2MWVg3b7egWNLA6Cv9dZYsayygInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BUpxXQPy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RsWA4gSVLiDeakimpVvm+s4FzA/O83zRUOFiD2qqnDs=;
	t=1762353541; x=1763563141; b=BUpxXQPy8eZMKhCsqVpr9fHRswAEwiEYGwq+hJIOcqorIvq
	xEugSbaOzcVq5E1Iew54FRW2YNvJ4IWqUzEr2Es+TEOd7wufMYHlDYoZyvudSFrqFFPR2LpFfL5BS
	R8/i2wgx1s9WJmaL6fDt3HQSjD0j1JqfpSSZQpzI8BJ7uIqkkHNM/ah02eRMCBpur5lrSGfsy5ugY
	iZqfsLiMi4w/krAARhPwHsNOpOuxGApq88YAAanYqWeNzNNklT8M5dthOn3LoQd/MuzfVlzignc8F
	LOX30c/0tvVywFnoP7VrqvwFhdaTAjnZU4i2pxNMz5AB8NQj1qLZMKNwHV/Yk2AA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGef3-0000000FDcs-1YSe;
	Wed, 05 Nov 2025 15:38:57 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 8/8] wifi: ieee80211: split NAN definitions out
Date: Wed,  5 Nov 2025 15:36:56 +0100
Message-ID: <20251105153843.8da0e796dda2.I7b2ce11220b70e8794019501eabbf8afbaf431a6@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105143843.46279-10-johannes@sipsolutions.net>
References: <20251105143843.46279-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The ieee80211.h file has gotten very long, continue splitting
it by putting NAN definitions into a separate file. Note that
NAN isn't really even IEEE 802.11 but WFA.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-nan.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     | 18 +-----------------
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/ieee80211-nan.h

diff --git a/include/linux/ieee80211-nan.h b/include/linux/ieee80211-nan.h
new file mode 100644
index 000000000000..d07959bf8a90
--- /dev/null
+++ b/include/linux/ieee80211-nan.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * WFA NAN definitions
+ *
+ * Copyright (c) 2001-2002, SSH Communications Security Corp and Jouni Malinen
+ * <jkmaline@cc.hut.fi>
+ * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
+ * Copyright (c) 2005, Devicescape Software, Inc.
+ * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
+ * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
+ * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright (c) 2018 - 2025 Intel Corporation
+ */
+
+#ifndef LINUX_IEEE80211_NAN_H
+#define LINUX_IEEE80211_NAN_H
+
+/* NAN operation mode, as defined in Wi-Fi Aware (TM) specification Table 81 */
+#define NAN_OP_MODE_PHY_MODE_VHT	0x01
+#define NAN_OP_MODE_PHY_MODE_HE		0x10
+#define NAN_OP_MODE_PHY_MODE_MASK	0x11
+#define NAN_OP_MODE_80P80MHZ		0x02
+#define NAN_OP_MODE_160MHZ		0x04
+#define NAN_OP_MODE_PNDL_SUPPRTED	0x08
+
+/* NAN Device capabilities, as defined in Wi-Fi Aware (TM) specification
+ * Table 79
+ */
+#define NAN_DEV_CAPA_DFS_OWNER			0x01
+#define NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED	0x02
+#define NAN_DEV_CAPA_SIM_NDP_RX_SUPPORTED	0x04
+#define NAN_DEV_CAPA_NDPE_SUPPORTED		0x08
+#define NAN_DEV_CAPA_S3_SUPPORTED		0x10
+
+#endif /* LINUX_IEEE80211_NAN_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index fa0f7f917ce7..48ce05e1d203 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2803,23 +2803,6 @@ struct ieee80211_tbtt_info_ge_11 {
 	struct ieee80211_rnr_mld_params mld_params;
 } __packed;
 
-/* NAN operation mode, as defined in Wi-Fi Aware (TM) specification Table 81 */
-#define NAN_OP_MODE_PHY_MODE_VHT	0x01
-#define NAN_OP_MODE_PHY_MODE_HE		0x10
-#define NAN_OP_MODE_PHY_MODE_MASK	0x11
-#define NAN_OP_MODE_80P80MHZ		0x02
-#define NAN_OP_MODE_160MHZ		0x04
-#define NAN_OP_MODE_PNDL_SUPPRTED	0x08
-
-/* NAN Device capabilities, as defined in Wi-Fi Aware (TM) specification
- * Table 79
- */
-#define NAN_DEV_CAPA_DFS_OWNER			0x01
-#define NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED	0x02
-#define NAN_DEV_CAPA_SIM_NDP_RX_SUPPORTED	0x04
-#define NAN_DEV_CAPA_NDPE_SUPPORTED		0x08
-#define NAN_DEV_CAPA_S3_SUPPORTED		0x10
-
 #include "ieee80211-ht.h"
 #include "ieee80211-vht.h"
 #include "ieee80211-he.h"
@@ -2827,6 +2810,7 @@ struct ieee80211_tbtt_info_ge_11 {
 #include "ieee80211-mesh.h"
 #include "ieee80211-s1g.h"
 #include "ieee80211-p2p.h"
+#include "ieee80211-nan.h"
 
 /**
  * ieee80211_check_tim - check if AID bit is set in TIM
-- 
2.51.1


