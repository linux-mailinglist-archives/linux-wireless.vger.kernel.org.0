Return-Path: <linux-wireless+bounces-38119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YnrqNNkcPmrd/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:31:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 757486CAA60
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=UDetZWhm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38119-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38119-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49E78301584A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62D3DB623;
	Fri, 26 Jun 2026 06:31:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AEF3DB62F
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:31:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455486; cv=none; b=H0JWrz5IiMx6OFWjRZOil0yBN9rZ8VZGgHtdNyJEYy+LciJVDeXUijdLPWGPtN9RoLV3PaNoYvgGsLO4ZpBsUKHFJPRK+ZI7jELaEeHOnc8hxkOyOz/KsJ5xN95IyW8P0vwWSxy/fsHpAocOgkcg+msHzcqyNI6rjgC0rvKvDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455486; c=relaxed/simple;
	bh=6qAdk/7/VxfPwDry213tg5Ms5LaR+t3Ya7GL6Lolp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy8IV6PwM3Ie1TcTL/tXG5MNcOJWtPm8YbLxoi9IDMa7X+cH/UtmXoYxmhkTYONuSWz3GJp9y+HOB1ta0ZccjLZaaf+llXFQx3alyj3dx0owwHoJV5p1Bob2ra8OAFcNmRDFwTR0Dtxqx8CJuQZNvppBoUlpeGvtuKDoymXUuqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=UDetZWhm; arc=none smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139b914bab6so963337c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455480; x=1783060280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7hh0e+jXK7arRjqvLKr4+jB+ECn6BIly0yWnMPfD4o=;
        b=UDetZWhmERGreTfHAfwDCT+CzB8oynw0MQpwobJn+Dz9f9BH3lnrZzFPST8KKmXupb
         qxAfUgEKWDvh7F/NjSACDJk9gxbt8CVnLWyFB27HPRpCljLsFU7p8ZPY6hBMhuJUs1LB
         a50A5yycDyEHxR3SY7q9Gf+ykYAgnB6UucjrdKYYCV6kp5I18VfrO+FSvZR3QiAWgdGg
         1MYnAMWUIrCEjFdSN6p+QXCyQ7SKIgySkNNm4xu1Z+o1gDniuFFnR9BLmhvxF3cSWR5N
         4kZI2rbLcR9Q8f6QqEOtlz3pBIhc5I+zXDsb6u+u7nrii0TKRf6X2CUsDx7fz+9JxKIx
         uTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455480; x=1783060280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7hh0e+jXK7arRjqvLKr4+jB+ECn6BIly0yWnMPfD4o=;
        b=gPa7ulH3veTvpGFwe+qIGNb3jrOQWFf5hpF3Z+aEyufen4qJIPjGLbDm/t+7DHeOkp
         EHtmy9wtBH8aIXeff7AUNs7kjuaxt+eJimdffV2WDswgGoc7CMp5O/QkXLWF532z8AKU
         RgJR1opV1s0/LPMMMczRGFnCO6Pa6j0Pt3I9G8h9xyhim5UzJI/7MOT/0ffUxw6YeXED
         ltmTP345k8XObFJDOgJ520dBBv2uJTwfZsx/mg4FQptALXhtDYVkEwJMNiAcxJwz5CRg
         hLAjnKYWG9PcSkqkns7Vndo7ipTSNreekDVkj9mLDUV73LiyXWUnVqA7TGID/YkSBFkq
         hg6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/pvLRoDKOMzvbi/fwtigGRz3T4MBshJ6MTDb1bZwEUK+fhoQwXLu3FkfDBkNL6BDNt6KKbTjr3jrl+xijc2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/C/oRHYZnJiEvWYgq+kS+Hn4gN1CuwVK27r9JDJXt1TlHGOL
	cY7ivAsfdVlxr+lwr3dSV5Rw1hJLjZ8HggJ4xLxqJQB7YJT2SlCUyGLiIzQyI4YNUKs=
X-Gm-Gg: AfdE7cmAeobljfw3qtiXNeY5M0gkOYG1buAtFJCxYGjtjc9FAywelLOziEa0L0zRk96
	zzJQXpTsS377kJihdQMc578VTbQ+Q2XqVbSGpca8KDVsNfVVWohFSzntb5nqpRBitljFAuFimW+
	QL2f7wyoBrKX0IRnINp5iu3SODOy9sYLUzeq9IZULQDoZG6GAQ/NCXlyITt4G0oH7a1B4E7ejwx
	HLAAyoFwUzNV9+wTG5CkC7cWX/AzWy5ekkTvaT5oByukN7ATiWLIeS6YtpSRSDiTrYrlTrUrEA0
	UxpcfMLGmBkGHc8pRGKbEPoAzD8FsylaYwfrqmXOaYB5YjTG/d0MXnr+TiWsvn8Jf16PCrMgpOc
	5qpFnkIREJWHPPucpScU/s1aCcPYRkvoaPUL9cBP74PlYpXP4hn4RmmwCuX+QhdJW++iy2TBG4v
	/9OaF0sUSLyQ7UFAZniKCxPpEdj9v7DwjJAAjhkSkGJdoZ6iiEjnelg0Q90J1j9H2MCha3dZPt9
	Bn/Nv/dMQB/fnabnZ9L
X-Received: by 2002:a05:7022:490:b0:136:b370:64de with SMTP id a92af1059eb24-139dbbaef8amr4819100c88.32.1782455479723;
        Thu, 25 Jun 2026 23:31:19 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:31:19 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 08/33] wifi: mm81x: add core.h
Date: Fri, 26 Jun 2026 16:29:04 +1000
Message-ID: <20260626063014.1275235-9-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38119-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 757486CAA60

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/core.h | 464 +++++++++++++++++++
 1 file changed, 464 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/core.h b/drivers/net/wireless/morsemicro/mm81x/core.h
new file mode 100644
index 000000000000..d5b6dae59bcf
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/core.h
@@ -0,0 +1,464 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_CORE_H_
+#define _MM81X_CORE_H_
+
+#include <net/mac80211.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/kfifo.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/crc32.h>
+#include <linux/notifier.h>
+#include <linux/nospec.h>
+#include <linux/wait.h>
+#include "yaps.h"
+#include "yaps_hw.h"
+#include "hw.h"
+#include "fw.h"
+#include "rc.h"
+
+#define MM81X_DRIVER_SEMVER_MAJOR 56
+#define MM81X_DRIVER_SEMVER_MINOR 3
+#define MM81X_DRIVER_SEMVER_PATCH 0
+
+#define MM81X_SEMVER_GET_MAJOR(x) (((x) >> 22) & 0x3FF)
+#define MM81X_SEMVER_GET_MINOR(x) (((x) >> 10) & 0xFFF)
+#define MM81X_SEMVER_GET_PATCH(x) ((x) & 0x3FF)
+
+#define DRV_VERSION __stringify(MM81X_VERSION)
+
+#define MM8108_FW_BASE "mm8108"
+
+#define BCF_SIZE_MAX 48
+
+/* Generate a device ID from chip ID, revision, and chip type */
+#define MM81X_DEVICE_ID(chip_id, chip_rev, chip_type) \
+	((chip_id) | ((chip_rev) << 8) | ((chip_type) << 12))
+
+/* Get constituents of the device ID */
+#define MM81X_DEVICE_GET_CHIP_ID(device_id) ((device_id) & 0xff)
+#define MM81X_DEVICE_GET_CHIP_REV(device_id) ((((device_id) >> 8) & 0xf))
+#define MM81X_DEVICE_GET_CHIP_TYPE(device_id) ((((device_id) >> 12) & 0xf))
+
+#define KHZ100_TO_MHZ(x) ((x) / 10)
+#define KHZ100_TO_KHZ(freq) ((freq) * 100)
+#define KHZ100_TO_HZ(freq) ((freq) * 100000)
+
+#define QDBM_TO_MBM(gain) (((gain) * 100) >> 2)
+#define MBM_TO_QDBM(gain) (((gain) << 2) / 100)
+#define QDBM_TO_DBM(gain) ((gain) / 4)
+
+#define BPS_TO_KBPS(x) ((x) / 1000)
+
+#define NSS_IDX_TO_NSS(x) ((x) + 1)
+#define NSS_TO_NSS_IDX(x) ((x) - 1)
+
+#define ROUND_BYTES_TO_WORD(_nbytes) \
+	(((_nbytes) + 3) & ~((typeof(_nbytes))0x03))
+
+struct mm81x_bus_ops;
+struct mm81x_hif_ops;
+
+#define MM81X_CAPS_MAX_FW_VAL (128)
+
+/* Max number of interfaces */
+#define MM81X_MAX_IF (2)
+
+enum mm81x_caps_flags {
+	MM81X_CAPS_FW_START = 0,
+	MM81X_CAPS_2MHZ = MM81X_CAPS_FW_START,
+	MM81X_CAPS_4MHZ,
+	MM81X_CAPS_8MHZ,
+	MM81X_CAPS_16MHZ,
+	MM81X_CAPS_SGI,
+	MM81X_CAPS_S1G_LONG,
+	MM81X_CAPS_TRAVELING_PILOT_ONE_STREAM,
+	MM81X_CAPS_TRAVELING_PILOT_TWO_STREAM,
+	MM81X_CAPS_MU_BEAMFORMEE,
+	MM81X_CAPS_MU_BEAMFORMER,
+	MM81X_CAPS_RD_RESPONDER,
+	MM81X_CAPS_STA_TYPE_SENSOR,
+	MM81X_CAPS_STA_TYPE_NON_SENSOR,
+	MM81X_CAPS_GROUP_AID,
+	MM81X_CAPS_NON_TIM,
+	MM81X_CAPS_TIM_ADE,
+	MM81X_CAPS_BAT,
+	MM81X_CAPS_DYNAMIC_AID,
+	MM81X_CAPS_UPLINK_SYNC,
+	MM81X_CAPS_FLOW_CONTROL,
+	MM81X_CAPS_AMPDU,
+	MM81X_CAPS_AMSDU,
+	MM81X_CAPS_1MHZ_CONTROL_RESPONSE_PREAMBLE,
+	MM81X_CAPS_PAGE_SLICING,
+	MM81X_CAPS_RAW,
+	MM81X_CAPS_MCS8,
+	MM81X_CAPS_MCS9,
+	MM81X_CAPS_ASYMMETRIC_BA_SUPPORT,
+	MM81X_CAPS_DAC,
+	MM81X_CAPS_CAC,
+	MM81X_CAPS_TXOP_SHARING_IMPLICIT_ACK,
+	MM81X_CAPS_NDP_PSPOLL,
+	MM81X_CAPS_FRAGMENT_BA,
+	MM81X_CAPS_OBSS_MITIGATION,
+	MM81X_CAPS_TMP_PS_MODE_SWITCH,
+	MM81X_CAPS_SECTOR_TRAINING,
+	MM81X_CAPS_UNSOLICIT_DYNAMIC_AID,
+	MM81X_CAPS_NDP_BEAMFORMING_REPORT,
+	MM81X_CAPS_MCS_NEGOTIATION,
+	MM81X_CAPS_DUPLICATE_1MHZ,
+	MM81X_CAPS_TACK_AS_PSPOLL,
+	MM81X_CAPS_PV1,
+	MM81X_CAPS_TWT_RESPONDER,
+	MM81X_CAPS_TWT_REQUESTER,
+	MM81X_CAPS_BDT,
+	MM81X_CAPS_TWT_GROUPING,
+	MM81X_CAPS_LINK_ADAPTATION_WO_NDP_CMAC,
+	MM81X_CAPS_LONG_MPDU,
+	MM81X_CAPS_TXOP_SECTORIZATION,
+	MM81X_CAPS_GROUP_SECTORIZATION,
+	MM81X_CAPS_HTC_VHT,
+	MM81X_CAPS_HTC_VHT_MFB,
+	MM81X_CAPS_HTC_VHT_MRQ,
+	MM81X_CAPS_2SS,
+	MM81X_CAPS_3SS,
+	MM81X_CAPS_4SS,
+	MM81X_CAPS_SU_BEAMFORMEE,
+	MM81X_CAPS_SU_BEAMFORMER,
+	MM81X_CAPS_RX_STBC,
+	MM81X_CAPS_TX_STBC,
+	MM81X_CAPS_RX_LDPC,
+	MM81X_CAPS_HW_FRAGMENT,
+
+	MM81X_CAPS_FW_END = MM81X_CAPS_MAX_FW_VAL,
+	MM81X_CAPS_LAST = MM81X_CAPS_FW_END,
+};
+
+struct mm81x_fw_caps {
+	u32 flags[FW_CAPABILITIES_FLAGS_WIDTH];
+	u8 ampdu_mss;
+	u8 beamformee_sts_capability;
+	u8 number_sounding_dimensions;
+	u8 maximum_ampdu_length_exponent;
+	u8 mm81x_mmss_offset;
+};
+
+#define MM81X_FW_SUPP(MM81X_CAPS, CAPABILITY) \
+	mm81x_caps_supported(MM81X_CAPS, MM81X_CAPS_##CAPABILITY)
+
+static inline bool mm81x_caps_supported(struct mm81x_fw_caps *caps,
+					enum mm81x_caps_flags flag)
+{
+	const unsigned long *flags_ptr = (unsigned long *)caps->flags;
+
+	return test_bit(flag, flags_ptr);
+}
+
+struct mm81x_ps {
+	u32 wakers;
+	bool enable;
+	bool suspended;
+	/* PS state lock */
+	struct mutex lock;
+	struct delayed_work delayed_eval_work;
+};
+
+enum mm81x_page_aci {
+	MM81X_ACI_BE = 0,
+	MM81X_ACI_BK = 1,
+	MM81X_ACI_VI = 2,
+	MM81X_ACI_VO = 3,
+};
+
+enum mm81x_qos_tid_up_index {
+	MM81X_QOS_TID_UP_BK = 1,
+	MM81X_QOS_TID_UP_XX = 2,
+	MM81X_QOS_TID_UP_BE = 0,
+	MM81X_QOS_TID_UP_EE = 3,
+	MM81X_QOS_TID_UP_CL = 4,
+	MM81X_QOS_TID_UP_VI = 5,
+	MM81X_QOS_TID_UP_VO = 6,
+	MM81X_QOS_TID_UP_NC = 7,
+
+	MM81X_QOS_TID_UP_LOWEST = MM81X_QOS_TID_UP_BK,
+	MM81X_QOS_TID_UP_HIGHEST = MM81X_QOS_TID_UP_NC
+};
+
+struct mm81x_sw_version {
+	u8 major;
+	u8 minor;
+	u8 patch;
+};
+
+struct mm81x_sta {
+	const struct ieee80211_vif *vif;
+	u8 addr[ETH_ALEN];
+	enum ieee80211_sta_state state;
+	bool tid_tx[IEEE80211_NUM_TIDS];
+	bool tid_start_tx[IEEE80211_NUM_TIDS];
+	u8 tid_params[IEEE80211_NUM_TIDS];
+	int max_bw_mhz;
+	struct mm81x_rc_sta rc;
+	struct mmrc_rate last_sta_tx_rate;
+	s16 avg_rssi;
+	bool tx_ps_filter_en;
+};
+
+struct mm81x_vif {
+	struct mm81x *mors;
+	u16 id;
+
+	union {
+		struct {
+			bool is_assoc;
+		} sta;
+		struct {
+			u32 num_stas;
+			struct work_struct beacon_work;
+		} ap;
+	} u;
+};
+
+struct mm81x_stale_tx_status {
+	/* Stale Tx lock */
+	spinlock_t lock;
+	struct timer_list timer;
+};
+
+struct mcast_filter {
+	u8 count;
+	/*
+	 * Integer representation of the last four bytes of a multicast MAC
+	 * address. The first two bytes are always 0x0100 (IPv4) or 0x3333
+	 * (IPv6).
+	 */
+	__le32 addr_list[];
+};
+
+enum mm81x_hw_scan_op {
+	MM81X_HW_SCAN_OP_START,
+	MM81X_HW_SCAN_OP_STOP,
+};
+
+struct mm81x_hw_scan_params {
+	struct ieee80211_hw *hw;
+
+	/* vif which initiated the scan */
+	struct ieee80211_vif *vif;
+	bool has_directed_ssid;
+	u32 dwell_time_ms;
+	u32 dwell_on_home_ms;
+	enum mm81x_hw_scan_op operation;
+	bool store;
+	struct sk_buff *probe_req;
+	u16 num_chans;
+	u16 allocated_chans;
+
+	struct {
+		struct ieee80211_channel *channel;
+		/* Index into @ref powers_qdbm for the power of this channel */
+		u8 power_idx;
+	} *channels;
+
+	s32 *powers_qdbm;
+	u8 n_powers;
+};
+
+enum mm81x_hw_scan_state {
+	HW_SCAN_STATE_IDLE,
+	HW_SCAN_STATE_RUNNING,
+	HW_SCAN_STATE_ABORTING,
+};
+
+struct mm81x_hw_scan {
+	enum mm81x_hw_scan_state state;
+	struct completion scan_done;
+	struct mm81x_hw_scan_params *params;
+	struct delayed_work timeout;
+	u32 home_dwell_ms;
+};
+
+enum mm81x_hif_event_flags {
+	MM81X_HIF_EVT_RX_PEND,
+	MM81X_HIF_EVT_PAGE_RETURN_PEND,
+	MM81X_HIF_EVT_TX_COMMAND_PEND,
+	MM81X_HIF_EVT_TX_BEACON_PEND,
+	MM81X_HIF_EVT_TX_MGMT_PEND,
+	MM81X_HIF_EVT_TX_DATA_PEND,
+	MM81X_HIF_EVT_TX_PACKET_FREED_UP_PEND,
+	MM81X_HIF_EVT_DATA_TRAFFIC_PAUSE_PEND,
+	MM81X_HIF_EVT_DATA_TRAFFIC_RESUME_PEND,
+	MM81X_HIF_EVT_UPDATE_HW_CLOCK_REFERENCE,
+};
+
+enum mm81x_state_flags {
+	MM81X_STATE_CHIP_UNRESPONSIVE,
+	MM81X_STATE_DATA_QS_STOPPED,
+	MM81X_STATE_DATA_TX_STOPPED,
+	MM81X_STATE_REGDOM_SET_BY_USER,
+	MM81X_STATE_REGDOM_SET_BY_OTP,
+	MM81X_STATE_RELOAD_FW_AFTER_START,
+	MM81X_STATE_HOST_TO_CHIP_TX_BLOCKED,
+	MM81X_STATE_HOST_TO_CHIP_CMD_BLOCKED,
+};
+
+#define MM81X_COUNTRY_LEN (3)
+#define INVALID_VIF_INDEX 0xFF
+
+struct mm81x {
+	u32 chip_id;
+	u32 host_table_ptr;
+
+	/* Refer to @enum mm81x_bus_type */
+	u32 bus_type;
+	u32 bcf_address;
+
+	/*
+	 * Parsed from the release tag, which should be in the format
+	 * 'rel_<major>_<minor>_<patch>'. If the tag is not in this format
+	 * then corresponding version field will be 0.
+	 */
+	struct mm81x_sw_version sw_ver;
+	u8 macaddr[ETH_ALEN];
+	u8 country[MM81X_COUNTRY_LEN];
+
+	/* Mask of type @enum host_table_firmware_flags */
+	u32 firmware_flags;
+	struct mm81x_fw_caps fw_caps;
+	bool started;
+	bool chip_was_reset;
+	struct wiphy *wiphy;
+	struct mm81x_hw_scan hw_scan;
+	struct ieee80211_hw *hw;
+	struct device *dev;
+
+	struct ieee80211_vif __rcu *vifs[MM81X_MAX_IF];
+
+	/* @mm81x_state_flags */
+	unsigned long state_flags;
+
+	u16 cmd_seq;
+	struct completion *cmd_comp;
+	/* Serialises commands */
+	struct mutex cmd_lock;
+
+	/* Serialises command completion */
+	struct mutex cmd_wait;
+
+	const struct mm81x_regs *regs;
+
+	struct {
+		union {
+			struct mm81x_yaps yaps;
+		} u;
+		const struct mm81x_hif_ops *ops;
+		/* See @enum mm81x_hif_event_flags for values */
+		unsigned long event_flags;
+		bool validate_skb_checksum;
+	} hif;
+
+	struct workqueue_struct *chip_wq;
+	struct work_struct hif_work;
+	struct work_struct usb_irq_work;
+	struct mm81x_stale_tx_status stale_status;
+	bool config_ps;
+	struct mm81x_ps ps;
+
+	/* Tx power in mBm received from the FW before association */
+	s32 tx_power_mbm;
+	s32 tx_max_power_mbm;
+
+	const struct mm81x_bus_ops *bus_ops;
+	struct mm81x_rc mrc;
+	int rts_threshold;
+	struct workqueue_struct *net_wq;
+	struct work_struct tx_stale_work;
+	wait_queue_head_t tx_empty_waitq;
+
+	struct cfg80211_chan_def chandef;
+	struct mcast_filter *mcast_filter;
+	atomic_t num_bcn_vifs;
+	unsigned long beacon_irqs_enabled;
+	u8 drv_priv[] __aligned(sizeof(void *));
+};
+
+/* Map from mac80211 queue to Morse ACI value for page metadata */
+static inline u8 map_mac80211q_2_mm81x_aci(u16 mac80211queue)
+{
+	switch (mac80211queue) {
+	case IEEE80211_AC_VO:
+		return MM81X_ACI_VO;
+	case IEEE80211_AC_VI:
+		return MM81X_ACI_VI;
+	case IEEE80211_AC_BK:
+		return MM81X_ACI_BK;
+	default:
+		return MM81X_ACI_BE;
+	}
+}
+
+static inline enum mm81x_page_aci
+dot11_tid_to_ac(enum mm81x_qos_tid_up_index tid)
+{
+	switch (tid) {
+	case MM81X_QOS_TID_UP_BK:
+	case MM81X_QOS_TID_UP_XX:
+		return MM81X_ACI_BK;
+	case MM81X_QOS_TID_UP_CL:
+	case MM81X_QOS_TID_UP_VI:
+		return MM81X_ACI_VI;
+	case MM81X_QOS_TID_UP_VO:
+	case MM81X_QOS_TID_UP_NC:
+		return MM81X_ACI_VO;
+	case MM81X_QOS_TID_UP_BE:
+	case MM81X_QOS_TID_UP_EE:
+	default:
+		return MM81X_ACI_BE;
+	}
+}
+
+static inline bool mm81x_is_data_tx_allowed(struct mm81x *mors)
+{
+	return !test_bit(MM81X_STATE_DATA_TX_STOPPED, &mors->state_flags) &&
+	       !test_bit(MM81X_HIF_EVT_DATA_TRAFFIC_PAUSE_PEND,
+			 &mors->hif.event_flags);
+}
+
+static inline struct ieee80211_vif *
+mm81x_vif_to_ieee80211_vif(struct mm81x_vif *mors_vif)
+{
+	return container_of((void *)mors_vif, struct ieee80211_vif, drv_priv);
+}
+
+static inline struct mm81x_vif *
+ieee80211_vif_to_mors_vif(struct ieee80211_vif *vif)
+{
+	return (struct mm81x_vif *)vif->drv_priv;
+}
+
+static inline struct mm81x *mm81x_vif_to_mors(struct mm81x_vif *mors_vif)
+{
+	return mors_vif->mors;
+}
+
+static inline u32 mm81x_generate_cssid(const u8 *ssid, u8 len)
+{
+	return ~crc32(~0, ssid, len);
+}
+
+int mm81x_beacon_init(struct mm81x_vif *mors_vif);
+void mm81x_beacon_finish(struct mm81x_vif *mors_vif);
+void mm81x_beacon_irq_handle(struct mm81x *mors, u32 status);
+char *mm81x_core_get_fw_path(u32 chip_id);
+struct mm81x *mm81x_core_alloc(size_t priv_size, struct device *dev);
+int mm81x_core_init(struct mm81x *mors);
+int mm81x_core_register(struct mm81x *mors);
+void mm81x_core_unregister(struct mm81x *mors);
+void mm81x_core_deinit(struct mm81x *mors);
+void mm81x_core_free(struct mm81x *mors);
+
+#endif /* !_MM81X_MM81X_H_ */
-- 
2.43.0


