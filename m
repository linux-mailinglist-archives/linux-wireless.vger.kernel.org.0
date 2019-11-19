Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94610182C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 07:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfKSGG1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 01:06:27 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:41671 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfKSGG0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 01:06:26 -0500
Received: by mail-yw1-f73.google.com with SMTP id b184so10298062ywc.8
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 22:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=egaWC7CsrqhnLtYCliWrLag50KGwX7qP2BMqFzdlV88=;
        b=BElRiZRAiiZcjHabvedXjtH184syCdVbDai/tHHn8NKgcTqV3+cuMBeMEiP7QGMQIr
         znlcj3NpvKx1kQQDyuZORMBveruTUlQoL/XcnqXvGxRO0uRFrlXiFIpPPrlUyEheoU6p
         LJBVPxqaHOpHEtMfr1VZDPLoT1OS+drWNTSUrUtQTvPGgHi7N92GSfSMci+iNEDwFnqQ
         gAELxDmG0GH/IspKUVA16QzhGE83LBnJLxq4oOwYtS8qU0C9eAw2eStDg7WVTjRsHX5T
         23xGirzluXjRw0GdWtCW2uW5wAztP69Zoatmz5tjqFp8M5T9vzsHNCJ1HccGTQu51ydY
         ePog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=egaWC7CsrqhnLtYCliWrLag50KGwX7qP2BMqFzdlV88=;
        b=oJCfa0M6FhrvsEEq4cagYan6NrGYqUunSEV3BKvhSds4LPYQqEHsj4EHt+tW43a53p
         WGx7/Mcvb27SSzZLETKvO6WLhDDxXlhNXCAqxuMGkxeTE5SGikzlauv5WW24bh94bfWY
         JiyRnhq1h8GM2vKwweRUSLziT7TrbsZBKTTMwNhE1ZxfbrbvNoR/LDthg+FtPEEBawhU
         Mb4yVqrNkYZykEqyfaak4op2zCHeDh3GpeJNRHAHmHh7pe003aNLBKDkyzYKt4ZhY6/0
         W/WBE5SKBdOiYE3Z441c/PXbo4SOPzCDSarRiJrLSKb0dbxALoIVX1dtDsvl918wPWUZ
         vPQw==
X-Gm-Message-State: APjAAAXgM47c+XsHBpKcma3ymL7AIAx1N5W368bB1JKGMjQUOW9HvfeT
        wS5AGITlOK7IvJ6laOhQc6Sn3njy
X-Google-Smtp-Source: APXvYqzgZwgdem5W3CdybQiaF4b9Cwua5lwpW6z+EHcDBIB9lbZsQjEtli2DbPJZmYOrTjqv39esNQlH
X-Received: by 2002:a81:c254:: with SMTP id t20mr22112162ywg.157.1574143583290;
 Mon, 18 Nov 2019 22:06:23 -0800 (PST)
Date:   Mon, 18 Nov 2019 22:06:08 -0800
In-Reply-To: <20191119060610.76681-1-kyan@google.com>
Message-Id: <20191119060610.76681-3-kyan@google.com>
Mime-Version: 1.0
References: <20191119060610.76681-1-kyan@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v11 2/4] mac80211: Import airtime calculation code from mt76
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, john@phrozen.org,
        lorenzo@kernel.org, rmanohar@codeaurora.org, kevinhayes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Felix recently added code to calculate airtime of packets to the mt76
driver. Import this into mac80211 so we can use it for airtime queue limit
calculations.

The airtime.c file is copied verbatim from the mt76 driver, and adjusted to
be usable in mac80211. This involves:

- Switching to mac80211 data structures.
- Adding support for 160 MHz channels and HE mode.
- Moving the symbol and duration calculations around a bit to avoid
  rounding with the higher rates and longer symbol times used for HE rates.

The per-rate TX rate calculation is also split out to its own function so
it can be used directly for the AQL calculations later.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/mac80211.h     |  29 ++
 net/mac80211/Makefile      |   3 +-
 net/mac80211/airtime.c     | 597 +++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |   4 +
 4 files changed, 632 insertions(+), 1 deletion(-)
 create mode 100644 net/mac80211/airtime.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c643a19dce96..6fc26a051ba0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6424,4 +6424,33 @@ void ieee80211_nan_func_match(struct ieee80211_vif *=
vif,
 			      struct cfg80211_nan_match_params *match,
 			      gfp_t gfp);
=20
+/**
+ * ieee80211_calc_rx_airtime - calculate estimated transmission airtime fo=
r RX.
+ *
+ * This function calculates the estimated airtime usage of a frame based o=
n the
+ * rate information in the RX status struct and the frame length.
+ *
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @status: &struct ieee80211_rx_status containing the transmission rate
+ *          information.
+ * @len: frame length in bytes
+ */
+u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
+			      struct ieee80211_rx_status *status,
+			      int len);
+
+/**
+ * ieee80211_calc_tx_airtime - calculate estimated transmission airtime fo=
r TX.
+ *
+ * This function calculates the estimated airtime usage of a frame based o=
n the
+ * rate information in the TX info struct and the frame length.
+ *
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @info: &struct ieee80211_tx_info of the frame.
+ * @len: frame length in bytes
+ */
+u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
+			      struct ieee80211_tx_info *info,
+			      int len);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index 4f03ebe732fa..6cbb1286d6c0 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -32,7 +32,8 @@ mac80211-y :=3D \
 	chan.o \
 	trace.o mlme.o \
 	tdls.o \
-	ocb.o
+	ocb.o \
+	airtime.o
=20
 mac80211-$(CONFIG_MAC80211_LEDS) +=3D led.o
 mac80211-$(CONFIG_MAC80211_DEBUGFS) +=3D \
diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
new file mode 100644
index 000000000000..0c2a0bb94727
--- /dev/null
+++ b/net/mac80211/airtime.c
@@ -0,0 +1,597 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2019 Felix Fietkau <nbd@nbd.name>
+ */
+
+#include <net/mac80211.h>
+#include "ieee80211_i.h"
+#include "sta_info.h"
+
+#define AVG_PKT_SIZE	1024
+
+/* Number of bits for an average sized packet */
+#define MCS_NBITS (AVG_PKT_SIZE << 3)
+
+/* Number of kilo-symbols (symbols * 1024) for a packet with (bps) bits pe=
r
+ * symbol. We use k-symbols to avoid rounding in the _TIME macros below.
+ */
+#define MCS_N_KSYMS(bps) DIV_ROUND_UP(MCS_NBITS << 10, (bps))
+
+/* Transmission time (in 1024 * usec) for a packet containing (ksyms) * 10=
24
+ * symbols.
+ */
+#define MCS_SYMBOL_TIME(sgi, ksyms)					\
+	(sgi ?								\
+	  ((ksyms) * 4 * 18) / 20 :		/* 3.6 us per sym */	\
+	  ((ksyms) * 4)			/* 4.0 us per sym */	\
+	)
+
+/* Transmit duration for the raw data part of an average sized packet */
+#define MCS_DURATION(streams, sgi, bps) \
+	((u32)MCS_SYMBOL_TIME(sgi, MCS_N_KSYMS((streams) * (bps))))
+
+#define MCS_DURATION_S(shift, streams, sgi, bps)		\
+	((u16)((MCS_DURATION(streams, sgi, bps) >> shift)))
+
+/* These should match the values in enum nl80211_he_gi */
+#define HE_GI_08 0
+#define HE_GI_16 1
+#define HE_GI_32 2
+
+/* Transmission time (1024 usec) for a packet containing (ksyms) * k-symbo=
ls */
+#define HE_SYMBOL_TIME(gi, ksyms)					\
+	(gi =3D=3D HE_GI_08 ?						\
+	 ((ksyms) * 16 * 17) / 20 :		/* 13.6 us per sym */	\
+	 (gi =3D=3D HE_GI_16 ?						\
+	  ((ksyms) * 16 * 18) / 20 :		/* 14.4 us per sym */	\
+	  ((ksyms) * 16)			/* 16.0 us per sym */	\
+	 ))
+
+/* Transmit duration for the raw data part of an average sized packet */
+#define HE_DURATION(streams, gi, bps) \
+	((u32)HE_SYMBOL_TIME(gi, MCS_N_KSYMS((streams) * (bps))))
+
+#define HE_DURATION_S(shift, streams, gi, bps)		\
+	(HE_DURATION(streams, gi, bps) >> shift)
+
+#define BW_20			0
+#define BW_40			1
+#define BW_80			2
+#define BW_160			3
+
+/*
+ * Define group sort order: HT40 -> SGI -> #streams
+ */
+#define IEEE80211_MAX_STREAMS		4
+#define IEEE80211_HT_STREAM_GROUPS	4 /* BW(=3D2) * SGI(=3D2) */
+#define IEEE80211_VHT_STREAM_GROUPS	8 /* BW(=3D4) * SGI(=3D2) */
+
+#define IEEE80211_HE_MAX_STREAMS	8
+#define IEEE80211_HE_STREAM_GROUPS	12 /* BW(=3D4) * GI(=3D3) */
+
+#define IEEE80211_HT_GROUPS_NB	(IEEE80211_MAX_STREAMS *	\
+				 IEEE80211_HT_STREAM_GROUPS)
+#define IEEE80211_VHT_GROUPS_NB	(IEEE80211_MAX_STREAMS *	\
+					 IEEE80211_VHT_STREAM_GROUPS)
+#define IEEE80211_HE_GROUPS_NB	(IEEE80211_HE_MAX_STREAMS *	\
+				 IEEE80211_HE_STREAM_GROUPS)
+#define IEEE80211_GROUPS_NB	(IEEE80211_HT_GROUPS_NB +	\
+				 IEEE80211_VHT_GROUPS_NB +	\
+				 IEEE80211_HE_GROUPS_NB)
+
+#define IEEE80211_HT_GROUP_0	0
+#define IEEE80211_VHT_GROUP_0	(IEEE80211_HT_GROUP_0 + IEEE80211_HT_GROUPS_=
NB)
+#define IEEE80211_HE_GROUP_0	(IEEE80211_VHT_GROUP_0 + IEEE80211_VHT_GROUPS=
_NB)
+
+#define MCS_GROUP_RATES		12
+
+#define HT_GROUP_IDX(_streams, _sgi, _ht40)	\
+	IEEE80211_HT_GROUP_0 +			\
+	IEEE80211_MAX_STREAMS * 2 * _ht40 +	\
+	IEEE80211_MAX_STREAMS * _sgi +		\
+	_streams - 1
+
+#define _MAX(a, b) (((a)>(b))?(a):(b))
+
+#define GROUP_SHIFT(duration)						\
+	_MAX(0, 16 - __builtin_clz(duration))
+
+/* MCS rate information for an MCS group */
+#define __MCS_GROUP(_streams, _sgi, _ht40, _s)				\
+	[HT_GROUP_IDX(_streams, _sgi, _ht40)] =3D {			\
+	.shift =3D _s,							\
+	.duration =3D {							\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 54 : 26),	\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 108 : 52),	\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 162 : 78),	\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 216 : 104),	\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 324 : 156),	\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 432 : 208),	\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 486 : 234),	\
+		MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 540 : 260)	\
+	}								\
+}
+
+#define MCS_GROUP_SHIFT(_streams, _sgi, _ht40)				\
+	GROUP_SHIFT(MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26))
+
+#define MCS_GROUP(_streams, _sgi, _ht40)				\
+	__MCS_GROUP(_streams, _sgi, _ht40,				\
+		    MCS_GROUP_SHIFT(_streams, _sgi, _ht40))
+
+#define VHT_GROUP_IDX(_streams, _sgi, _bw)				\
+	(IEEE80211_VHT_GROUP_0 +					\
+	 IEEE80211_MAX_STREAMS * 2 * (_bw) +				\
+	 IEEE80211_MAX_STREAMS * (_sgi) +				\
+	 (_streams) - 1)
+
+#define BW2VBPS(_bw, r4, r3, r2, r1)					\
+	(_bw =3D=3D BW_160 ? r4 : _bw =3D=3D BW_80 ? r3 : _bw =3D=3D BW_40 ? r2 :=
 r1)
+
+#define __VHT_GROUP(_streams, _sgi, _bw, _s)				\
+	[VHT_GROUP_IDX(_streams, _sgi, _bw)] =3D {			\
+	.shift =3D _s,							\
+	.duration =3D {							\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw,  234,  117,  54,  26)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw,  468,  234, 108,  52)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw,  702,  351, 162,  78)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw,  936,  468, 216, 104)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw, 1404,  702, 324, 156)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw, 1872,  936, 432, 208)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw, 2106, 1053, 486, 234)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw, 2340, 1170, 540, 260)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw, 2808, 1404, 648, 312)),	\
+		MCS_DURATION_S(_s, _streams, _sgi,			\
+			       BW2VBPS(_bw, 3120, 1560, 720, 346))	\
+        }								\
+}
+
+#define VHT_GROUP_SHIFT(_streams, _sgi, _bw)				\
+	GROUP_SHIFT(MCS_DURATION(_streams, _sgi,			\
+				 BW2VBPS(_bw, 243, 117,  54,  26)))
+
+#define VHT_GROUP(_streams, _sgi, _bw)					\
+	__VHT_GROUP(_streams, _sgi, _bw,				\
+		    VHT_GROUP_SHIFT(_streams, _sgi, _bw))
+
+
+#define HE_GROUP_IDX(_streams, _gi, _bw)				\
+	(IEEE80211_HE_GROUP_0 +					\
+	 IEEE80211_HE_MAX_STREAMS * 2 * (_bw) +			\
+	 IEEE80211_HE_MAX_STREAMS * (_gi) +				\
+	 (_streams) - 1)
+
+#define __HE_GROUP(_streams, _gi, _bw, _s)				\
+	[HE_GROUP_IDX(_streams, _gi, _bw)] =3D {			\
+	.shift =3D _s,							\
+	.duration =3D {							\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,   979,  489,  230,  115)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,  1958,  979,  475,  230)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,  2937, 1468,  705,  345)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,  3916, 1958,  936,  475)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,  5875, 2937, 1411,  705)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,  7833, 3916, 1872,  936)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,  8827, 4406, 2102, 1051)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw,  9806, 4896, 2347, 1166)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw, 11764, 5875, 2808, 1411)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw, 13060, 6523, 3124, 1555)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw, 14702, 7344, 3513, 1756)),	\
+		HE_DURATION_S(_s, _streams, _gi,			\
+			      BW2VBPS(_bw, 16329, 8164, 3902, 1944))	\
+        }								\
+}
+
+#define HE_GROUP_SHIFT(_streams, _gi, _bw)				\
+	GROUP_SHIFT(HE_DURATION(_streams, _gi,			\
+				BW2VBPS(_bw,   979,  489,  230,  115)))
+
+#define HE_GROUP(_streams, _gi, _bw)					\
+	__HE_GROUP(_streams, _gi, _bw,				\
+		   HE_GROUP_SHIFT(_streams, _gi, _bw))
+struct mcs_group {
+	u8 shift;
+	u16 duration[MCS_GROUP_RATES];
+};
+
+static const struct mcs_group airtime_mcs_groups[] =3D {
+	MCS_GROUP(1, 0, BW_20),
+	MCS_GROUP(2, 0, BW_20),
+	MCS_GROUP(3, 0, BW_20),
+	MCS_GROUP(4, 0, BW_20),
+
+	MCS_GROUP(1, 1, BW_20),
+	MCS_GROUP(2, 1, BW_20),
+	MCS_GROUP(3, 1, BW_20),
+	MCS_GROUP(4, 1, BW_20),
+
+	MCS_GROUP(1, 0, BW_40),
+	MCS_GROUP(2, 0, BW_40),
+	MCS_GROUP(3, 0, BW_40),
+	MCS_GROUP(4, 0, BW_40),
+
+	MCS_GROUP(1, 1, BW_40),
+	MCS_GROUP(2, 1, BW_40),
+	MCS_GROUP(3, 1, BW_40),
+	MCS_GROUP(4, 1, BW_40),
+
+	VHT_GROUP(1, 0, BW_20),
+	VHT_GROUP(2, 0, BW_20),
+	VHT_GROUP(3, 0, BW_20),
+	VHT_GROUP(4, 0, BW_20),
+
+	VHT_GROUP(1, 1, BW_20),
+	VHT_GROUP(2, 1, BW_20),
+	VHT_GROUP(3, 1, BW_20),
+	VHT_GROUP(4, 1, BW_20),
+
+	VHT_GROUP(1, 0, BW_40),
+	VHT_GROUP(2, 0, BW_40),
+	VHT_GROUP(3, 0, BW_40),
+	VHT_GROUP(4, 0, BW_40),
+
+	VHT_GROUP(1, 1, BW_40),
+	VHT_GROUP(2, 1, BW_40),
+	VHT_GROUP(3, 1, BW_40),
+	VHT_GROUP(4, 1, BW_40),
+
+	VHT_GROUP(1, 0, BW_80),
+	VHT_GROUP(2, 0, BW_80),
+	VHT_GROUP(3, 0, BW_80),
+	VHT_GROUP(4, 0, BW_80),
+
+	VHT_GROUP(1, 1, BW_80),
+	VHT_GROUP(2, 1, BW_80),
+	VHT_GROUP(3, 1, BW_80),
+	VHT_GROUP(4, 1, BW_80),
+
+	VHT_GROUP(1, 0, BW_160),
+	VHT_GROUP(2, 0, BW_160),
+	VHT_GROUP(3, 0, BW_160),
+	VHT_GROUP(4, 0, BW_160),
+
+	VHT_GROUP(1, 1, BW_160),
+	VHT_GROUP(2, 1, BW_160),
+	VHT_GROUP(3, 1, BW_160),
+	VHT_GROUP(4, 1, BW_160),
+
+	HE_GROUP(1, HE_GI_08, BW_20),
+	HE_GROUP(2, HE_GI_08, BW_20),
+	HE_GROUP(3, HE_GI_08, BW_20),
+	HE_GROUP(4, HE_GI_08, BW_20),
+	HE_GROUP(5, HE_GI_08, BW_20),
+	HE_GROUP(6, HE_GI_08, BW_20),
+	HE_GROUP(7, HE_GI_08, BW_20),
+	HE_GROUP(8, HE_GI_08, BW_20),
+
+	HE_GROUP(1, HE_GI_16, BW_20),
+	HE_GROUP(2, HE_GI_16, BW_20),
+	HE_GROUP(3, HE_GI_16, BW_20),
+	HE_GROUP(4, HE_GI_16, BW_20),
+	HE_GROUP(5, HE_GI_16, BW_20),
+	HE_GROUP(6, HE_GI_16, BW_20),
+	HE_GROUP(7, HE_GI_16, BW_20),
+	HE_GROUP(8, HE_GI_16, BW_20),
+
+	HE_GROUP(1, HE_GI_32, BW_20),
+	HE_GROUP(2, HE_GI_32, BW_20),
+	HE_GROUP(3, HE_GI_32, BW_20),
+	HE_GROUP(4, HE_GI_32, BW_20),
+	HE_GROUP(5, HE_GI_32, BW_20),
+	HE_GROUP(6, HE_GI_32, BW_20),
+	HE_GROUP(7, HE_GI_32, BW_20),
+	HE_GROUP(8, HE_GI_32, BW_20),
+
+	HE_GROUP(1, HE_GI_08, BW_40),
+	HE_GROUP(2, HE_GI_08, BW_40),
+	HE_GROUP(3, HE_GI_08, BW_40),
+	HE_GROUP(4, HE_GI_08, BW_40),
+	HE_GROUP(5, HE_GI_08, BW_40),
+	HE_GROUP(6, HE_GI_08, BW_40),
+	HE_GROUP(7, HE_GI_08, BW_40),
+	HE_GROUP(8, HE_GI_08, BW_40),
+
+	HE_GROUP(1, HE_GI_16, BW_40),
+	HE_GROUP(2, HE_GI_16, BW_40),
+	HE_GROUP(3, HE_GI_16, BW_40),
+	HE_GROUP(4, HE_GI_16, BW_40),
+	HE_GROUP(5, HE_GI_16, BW_40),
+	HE_GROUP(6, HE_GI_16, BW_40),
+	HE_GROUP(7, HE_GI_16, BW_40),
+	HE_GROUP(8, HE_GI_16, BW_40),
+
+	HE_GROUP(1, HE_GI_32, BW_40),
+	HE_GROUP(2, HE_GI_32, BW_40),
+	HE_GROUP(3, HE_GI_32, BW_40),
+	HE_GROUP(4, HE_GI_32, BW_40),
+	HE_GROUP(5, HE_GI_32, BW_40),
+	HE_GROUP(6, HE_GI_32, BW_40),
+	HE_GROUP(7, HE_GI_32, BW_40),
+	HE_GROUP(8, HE_GI_32, BW_40),
+
+	HE_GROUP(1, HE_GI_08, BW_80),
+	HE_GROUP(2, HE_GI_08, BW_80),
+	HE_GROUP(3, HE_GI_08, BW_80),
+	HE_GROUP(4, HE_GI_08, BW_80),
+	HE_GROUP(5, HE_GI_08, BW_80),
+	HE_GROUP(6, HE_GI_08, BW_80),
+	HE_GROUP(7, HE_GI_08, BW_80),
+	HE_GROUP(8, HE_GI_08, BW_80),
+
+	HE_GROUP(1, HE_GI_16, BW_80),
+	HE_GROUP(2, HE_GI_16, BW_80),
+	HE_GROUP(3, HE_GI_16, BW_80),
+	HE_GROUP(4, HE_GI_16, BW_80),
+	HE_GROUP(5, HE_GI_16, BW_80),
+	HE_GROUP(6, HE_GI_16, BW_80),
+	HE_GROUP(7, HE_GI_16, BW_80),
+	HE_GROUP(8, HE_GI_16, BW_80),
+
+	HE_GROUP(1, HE_GI_32, BW_80),
+	HE_GROUP(2, HE_GI_32, BW_80),
+	HE_GROUP(3, HE_GI_32, BW_80),
+	HE_GROUP(4, HE_GI_32, BW_80),
+	HE_GROUP(5, HE_GI_32, BW_80),
+	HE_GROUP(6, HE_GI_32, BW_80),
+	HE_GROUP(7, HE_GI_32, BW_80),
+	HE_GROUP(8, HE_GI_32, BW_80),
+
+	HE_GROUP(1, HE_GI_08, BW_160),
+	HE_GROUP(2, HE_GI_08, BW_160),
+	HE_GROUP(3, HE_GI_08, BW_160),
+	HE_GROUP(4, HE_GI_08, BW_160),
+	HE_GROUP(5, HE_GI_08, BW_160),
+	HE_GROUP(6, HE_GI_08, BW_160),
+	HE_GROUP(7, HE_GI_08, BW_160),
+	HE_GROUP(8, HE_GI_08, BW_160),
+
+	HE_GROUP(1, HE_GI_16, BW_160),
+	HE_GROUP(2, HE_GI_16, BW_160),
+	HE_GROUP(3, HE_GI_16, BW_160),
+	HE_GROUP(4, HE_GI_16, BW_160),
+	HE_GROUP(5, HE_GI_16, BW_160),
+	HE_GROUP(6, HE_GI_16, BW_160),
+	HE_GROUP(7, HE_GI_16, BW_160),
+	HE_GROUP(8, HE_GI_16, BW_160),
+
+	HE_GROUP(1, HE_GI_32, BW_160),
+	HE_GROUP(2, HE_GI_32, BW_160),
+	HE_GROUP(3, HE_GI_32, BW_160),
+	HE_GROUP(4, HE_GI_32, BW_160),
+	HE_GROUP(5, HE_GI_32, BW_160),
+	HE_GROUP(6, HE_GI_32, BW_160),
+	HE_GROUP(7, HE_GI_32, BW_160),
+	HE_GROUP(8, HE_GI_32, BW_160),
+};
+
+static u32
+ieee80211_calc_legacy_rate_duration(u16 bitrate, bool short_pre,
+				    bool cck, int len)
+{
+	u32 duration;
+
+	if (cck) {
+		duration =3D 144 + 48; /* preamble + PLCP */
+		if (short_pre)
+			duration >>=3D 1;
+
+		duration +=3D 10; /* SIFS */
+	} else {
+		duration =3D 20 + 16; /* premable + SIFS */
+	}
+
+	len <<=3D 3;
+	duration +=3D (len * 10) / bitrate;
+
+	return duration;
+}
+
+u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
+			      struct ieee80211_rx_status *status,
+			      int len)
+{
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_rate *rate;
+	bool sgi =3D status->enc_flags & RX_ENC_FLAG_SHORT_GI;
+	bool sp =3D status->enc_flags & RX_ENC_FLAG_SHORTPRE;
+	int bw, streams;
+	int group, idx;
+	u32 duration;
+	bool cck;
+
+	switch (status->bw) {
+	case RATE_INFO_BW_20:
+		bw =3D BW_20;
+		break;
+	case RATE_INFO_BW_40:
+		bw =3D BW_40;
+		break;
+	case RATE_INFO_BW_80:
+		bw =3D BW_80;
+		break;
+	case RATE_INFO_BW_160:
+		bw =3D BW_160;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	switch (status->encoding) {
+	case RX_ENC_LEGACY:
+		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
+			return 0;
+
+		sband =3D hw->wiphy->bands[status->band];
+		if (!sband || status->rate_idx > sband->n_bitrates)
+			return 0;
+
+		rate =3D &sband->bitrates[status->rate_idx];
+		cck =3D rate->flags & IEEE80211_RATE_MANDATORY_B;
+
+		return ieee80211_calc_legacy_rate_duration(rate->bitrate, sp,
+							   cck, len);
+
+	case RX_ENC_VHT:
+		streams =3D status->nss;
+		idx =3D status->rate_idx;
+		group =3D VHT_GROUP_IDX(streams, sgi, bw);
+		break;
+	case RX_ENC_HT:
+		streams =3D ((status->rate_idx >> 3) & 3) + 1;
+		idx =3D status->rate_idx & 7;
+		group =3D HT_GROUP_IDX(streams, sgi, bw);
+		break;
+	case RX_ENC_HE:
+		streams =3D status->nss;
+		idx =3D status->rate_idx;
+		group =3D HE_GROUP_IDX(streams, status->he_gi, bw);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	if (WARN_ON_ONCE((status->encoding !=3D RX_ENC_HE && streams > 4) ||
+			 (status->encoding =3D=3D RX_ENC_HE && streams > 8)))
+		return 0;
+
+	duration =3D airtime_mcs_groups[group].duration[idx];
+	duration <<=3D airtime_mcs_groups[group].shift;
+	duration *=3D len;
+	duration /=3D AVG_PKT_SIZE;
+	duration /=3D 1024;
+
+	duration +=3D 36 + (streams << 2);
+
+	return duration;
+}
+EXPORT_SYMBOL_GPL(ieee80211_calc_rx_airtime);
+
+static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
+					  struct ieee80211_tx_rate *rate,
+					  u8 band, int len)
+{
+	struct ieee80211_rx_status stat =3D {
+		.band =3D band,
+	};
+
+	if (rate->idx < 0 || !rate->count)
+		return 0;
+
+	if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+		stat.bw =3D RATE_INFO_BW_80;
+	else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+		stat.bw =3D RATE_INFO_BW_40;
+	else
+		stat.bw =3D RATE_INFO_BW_20;
+
+	stat.enc_flags =3D 0;
+	if (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
+		stat.enc_flags |=3D RX_ENC_FLAG_SHORTPRE;
+	if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
+		stat.enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
+
+	stat.rate_idx =3D rate->idx;
+	if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
+		stat.encoding =3D RX_ENC_VHT;
+		stat.rate_idx =3D ieee80211_rate_get_vht_mcs(rate);
+		stat.nss =3D ieee80211_rate_get_vht_nss(rate);
+	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
+		stat.encoding =3D RX_ENC_HT;
+	} else {
+		stat.encoding =3D RX_ENC_LEGACY;
+	}
+
+	return ieee80211_calc_rx_airtime(hw, &stat, len);
+}
+
+u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
+			      struct ieee80211_tx_info *info,
+			      int len)
+{
+	u32 duration =3D 0;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(info->status.rates); i++) {
+		struct ieee80211_tx_rate *rate =3D &info->status.rates[i];
+		u32 cur_duration;
+
+		cur_duration =3D ieee80211_calc_tx_airtime_rate(hw, rate,
+							      info->band, len);
+		if (!cur_duration)
+			break;
+
+		duration +=3D cur_duration * rate->count;
+	}
+
+	return duration;
+}
+EXPORT_SYMBOL_GPL(ieee80211_calc_tx_airtime);
+
+u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *pubsta,
+				       int len)
+{
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_chanctx_conf *conf;
+	int rateidx, shift =3D 0;
+	bool cck, short_pream;
+	u32 basic_rates;
+	u8 band =3D 0;
+	u16 rate;
+
+	len +=3D 38; /* Ethernet header length */
+
+	conf =3D rcu_dereference(vif->chanctx_conf);
+	if (conf) {
+		band =3D conf->def.chan->band;
+		shift =3D ieee80211_chandef_get_shift(&conf->def);
+	}
+
+	if (pubsta) {
+		struct sta_info *sta =3D container_of(pubsta, struct sta_info,
+						    sta);
+
+		return ieee80211_calc_tx_airtime_rate(hw,
+						      &sta->tx_stats.last_rate,
+						      band, len);
+	}
+
+	if (!conf)
+		return 0;
+
+	/* No station to get latest rate from, so calculate the worst-case
+	 * duration using the lowest configured basic rate.
+	 */
+	sband =3D hw->wiphy->bands[band];
+
+	basic_rates =3D vif->bss_conf.basic_rates;
+	short_pream =3D vif->bss_conf.use_short_preamble;
+
+	rateidx =3D basic_rates ? ffs(basic_rates) - 1 : 0;
+	rate =3D sband->bitrates[rateidx].bitrate << shift;
+	cck =3D sband->bitrates[rateidx].flags & IEEE80211_RATE_MANDATORY_B;
+
+	return ieee80211_calc_legacy_rate_duration(rate, short_pream, cck, len);
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 05406e9c05b3..225ea4e3cd76 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2249,6 +2249,10 @@ const char *ieee80211_get_reason_code_string(u16 rea=
son_code);
=20
 extern const struct ethtool_ops ieee80211_ethtool_ops;
=20
+u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *pubsta,
+				       int len);
 #ifdef CONFIG_MAC80211_NOINLINE
 #define debug_noinline noinline
 #else
--=20
2.24.0.432.g9d3f5f5b63-goog

