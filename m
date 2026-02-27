Return-Path: <linux-wireless+bounces-32245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFdKBHkaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:15:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7D1B290A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C840307A3CF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C6343D7F;
	Fri, 27 Feb 2026 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="rlCOXF9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D6341AB1
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165543; cv=none; b=dL41Beeq7wjuXFNDIO7cnuqS7cqBHj+L1ZLSjIVRcLyXzcVhqv5czLczqZNzVdu0eehrqzgSQFf730YLixVFd1CTuKMtRw2wukpFsazcHAkwhXirskqQotCwFG4VPTHuoTqR8AJCR42XnMJrdxH3uXB8zyQ7lEFU5Dsawah/WUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165543; c=relaxed/simple;
	bh=XmtGpfRwWQeY+xM54LYEGdzihN6RlIFz4Jnvbrth4P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlFcJZQmxWiUltT2CD0C1DOhViNUfjl7BzQpaLyYOutB6JcZ5qVsOTsbT4mEsN5quoMDHqpjLAMOJaNc7YZafvXSKzwinXbL5q2+lBK5cYn0KIdrDXgGiNrsV6Kb0CAGVP8Dq5X/U9g2mLLiOY6yTK6FqTE8p4ysW//Tb9SruCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=rlCOXF9N; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a962230847so15236315ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165541; x=1772770341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiTUTZA1CBgTnK0CCcKNj89ThDeRi0MoOakhad0ay1s=;
        b=rlCOXF9Nes+sCtyTEozRRQi/QaJsfYOHcIQkezGAA680k3+dF7aP5njDajHLS29MlV
         S3Tma4IKhIEfb2h/xTuNGhJ/S2Mk62ZRSNSDcdt/aAt38HRF8K6Kt4YIw0PXhLU5O/12
         Y+gixByffhXTjQHZ2Xjz1o4GSlZSOYyqiHHHiFnS6urc488+kvsx5wbilfSsQhw8+opo
         VbRf2aG93NcDRGnqKYorgXJ7TvVQ05AUDRWyL+wtE7/thoW6ianYcxwFwiPAO4JVD+l2
         TIsqZYu8HAwq12kMc7aHaNd8X2PYaEAiFSuXQNhHQ270iow/wVv6WcYYQoo2qFkb5WW5
         Cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165541; x=1772770341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiTUTZA1CBgTnK0CCcKNj89ThDeRi0MoOakhad0ay1s=;
        b=aNTOFVpObQh6MdjxE9iuo7fj7t0dvvgmu+fucK5979VgZobdln6T//qF2PpU0Unf89
         XDBDpwiClLrM4sgv7baImGPQsR533E3Hkstf+bhoxGV9gu9CucFVJ//rpo888rsLrOCv
         2BriqCOPp9CxUuWy/RtwN9A7G8Bz53RvPSOB4j06N5aWrkV1te1WQIgaGM4NdV5//Xft
         cBijzXywKbPgF6l0WtKsizQkAueO+YZZ6uEyWwO+U5wUV/hzcexkw+2CvTS+0CuYxwlh
         GYJRkpGo5HIE7MkIG70xM8uIuuTgFFkWrsIJFbiOTHivK7a5QfrvvJWPtbOu8cJFrgM3
         2gUg==
X-Forwarded-Encrypted: i=1; AJvYcCX10nGk/Qtz2xBrDzkAQOzMlcy+Z4PO5od6ZqkLDYVCmN7PNYir3iTg0TeHfxPiYOauqzab2gGxbgsKptOm9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zECWC5lzI+ENBfTPGP2MYTwX/nnl2bhn9WDWQRI7AJgpd3d6
	62JaiAASRgC4Rc3S/uN5IEgcLAaaQyeqAcaxb7X38sphYBwYoSBPDLMWbPsYJq3lU64=
X-Gm-Gg: ATEYQzxdU4lJUERyLvPN4Zkp+w77dRG1b68h4RgV4JQXNPgYtpVhcYroXodqF2/BI2Z
	6DR+QgNXZHaSlz6XaBzWMqTA15fyvwpNEZQctIadC9gtbiruigNwJ29Z7jUjVUduqtbpQHhEmFt
	3Svy2RGTqAPUZB5vxJsFUkVFivVkmDq4dV+G6IWc+IPYrQ860rOviohNpOyO+lHWL8SNYl4xszW
	JQLQHC1G/J70ncIpdJKeQTggQmW8Q/R+FEiFdNu7XBF/9ND+AFYeK9ByWkZR0Jwg6pBC6myXzsF
	ec+VqWovr+rTBjDfepkBT1RyXj6Tn5enHYXCQNLTi7xgwIcbgQN4E6/mnifGg0dyQ/hsO6qQu/2
	ZKn/8A2RjywTTRfOH7frn55/ELMEk3nrW4XvIw/jrZJei9YKBfXnTzhKA8+a8qJWxfNJ/zRf5vs
	bJmKy54PeVXxcpfk7FuV0++fjZj7TwgbXuGtdSl/DvORueoGlNa3ZKNew7kMOOeB8ra2kH7mr8K
	6QKarv4ufCIHr5F+lwTLQixiOUaRi4=
X-Received: by 2002:a17:902:d488:b0:2a9:62ce:1c0f with SMTP id d9443c01a7336-2ae2e4f3d26mr15618535ad.55.1772165541318;
        Thu, 26 Feb 2026 20:12:21 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:21 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 06/35] wifi: mm81x: add core.h
Date: Fri, 27 Feb 2026 15:10:16 +1100
Message-ID: <20260227041108.66508-7-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32245-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 64B7D1B290A
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/core.h | 499 +++++++++++++++++++
 1 file changed, 499 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/core.h b/drivers/net/wireless/morsemicro/mm81x/core.h
new file mode 100644
index 000000000000..1cd079985ed7
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/core.h
@@ -0,0 +1,499 @@
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
+#define KHZ_TO_HZ(x) ((x) * 1000)
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
+#define UNUSED(x) ((void)x)
+
+#define NSS_IDX_TO_NSS(x) ((x) + 1)
+#define NSS_TO_NSS_IDX(x) ((x) - 1)
+
+#define ROUND_BYTES_TO_WORD(_nbytes) \
+	(((_nbytes) + 3) & ~((typeof(_nbytes))0x03))
+
+static inline u32 mm81x_fle32_to_cpu(u32 v)
+{
+	return le32_to_cpu((__force __le32)v);
+}
+
+static inline u16 mm81x_fle16_to_cpu(u16 v)
+{
+	return le16_to_cpu((__force __le16)v);
+}
+
+struct mm81x_bus_ops;
+struct mm81x_hif_ops;
+
+/* modparam variables */
+extern char board_config_file[];
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
+	struct work_struct async_wake_work;
+	struct delayed_work delayed_eval_work;
+	struct completion *awake;
+	/* hardware config supports powersave through hardware GPIOs */
+	bool gpios_supported;
+	struct gpio_desc *wake_gpio;
+	struct gpio_desc *busy_gpio;
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
+	struct mm81x *mm;
+	u16 id;
+
+	union {
+		struct {
+			bool is_assoc;
+		} sta;
+		struct {
+			u32 num_stas;
+			struct tasklet_struct beacon_tasklet;
+			bool beaconing_enabled;
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
+	bool use_1mhz_probes;
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
+	/* Serialise high-level operations to the mm81x structure */
+	struct mutex lock;
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
+#ifdef CONFIG_MM81X_USB
+int __init mm81x_usb_init(void);
+void __exit mm81x_usb_exit(void);
+#endif
+
+#ifdef CONFIG_MM81X_SDIO
+int __init mm81x_sdio_init(void);
+void __exit mm81x_sdio_exit(void);
+#endif
+
+static inline bool mm81x_is_data_tx_allowed(struct mm81x *mm)
+{
+	return !test_bit(MM81X_STATE_DATA_TX_STOPPED, &mm->state_flags) &&
+	       !test_bit(MM81X_HIF_EVT_DATA_TRAFFIC_PAUSE_PEND,
+			 &mm->hif.event_flags);
+}
+
+static inline struct ieee80211_vif *
+mm81x_vif_to_ieee80211_vif(struct mm81x_vif *mm_vif)
+{
+	return container_of((void *)mm_vif, struct ieee80211_vif, drv_priv);
+}
+
+static inline struct mm81x_vif *
+ieee80211_vif_to_mm_vif(struct ieee80211_vif *vif)
+{
+	return (struct mm81x_vif *)vif->drv_priv;
+}
+
+static inline struct mm81x *mm81x_vif_to_mm(struct mm81x_vif *mm_vif)
+{
+	return mm_vif->mm;
+}
+
+static inline u32 mm81x_generate_cssid(const u8 *ssid, u8 len)
+{
+	return ~crc32(~0, ssid, len);
+}
+
+int mm81x_beacon_init(struct mm81x_vif *mm_vif);
+void mm81x_beacon_finish(struct mm81x_vif *mm_vif);
+void mm81x_beacon_irq_handle(struct mm81x *mm, u32 status);
+int mm81x_usb_ndr_reset(struct mm81x *mm);
+
+int mm81x_core_attach_regs(struct mm81x *mm);
+void mm81x_core_init_mac_addr(struct mm81x *mm);
+char *mm81x_core_get_fw_path(u32 chip_id);
+int mm81x_core_create(struct mm81x *mm);
+void mm81x_core_destroy(struct mm81x *mm);
+
+#endif /* !_MM81X_MM81X_H_ */
-- 
2.43.0


