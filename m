Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF661FDECD
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKONUt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 08:20:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727472AbfKONUt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 08:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E08Pzr06+O9+PjFVSOA/Z5hlhOsPIVZRicJ2i5dDlII=;
        b=XU/4VJiAcve56NZ7FlFBT3Fdml/1qwvOquKc+PEQZz2IlTnYzUNNC/r/H4z9nFwPFeHXZ1
        Op2jXvmBagTk5nYUO3DGfgTx6zSiRkMl1xisJGIAag86FAGdbXmZXz8qDTDluMXttEi+fW
        YAU5mJJqkKqrnkETzBxmc9gF0OOm/gs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-aufQ_1UnOcegLtp3T2ozgQ-1; Fri, 15 Nov 2019 08:20:43 -0500
Received: by mail-lj1-f200.google.com with SMTP id n11so1542816lji.9
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 05:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XJQMGi2eL7eeEKDLM4OxagL9zjB02JHuHwD89CEpIyg=;
        b=T6H4p3aIcU/xiScFX7U7cZDgKBLbURjsxNMoOEHQj7wa8YQ9ElX7V1VsJzFzHcHOjQ
         A/EJyAgoRAgi8m28ydQ3cGqlyWlj5qHcOTxcVam/ocb1xlfNtWGqGurG/9xT2ROoGCt/
         GSiH3v/o7ZxrkK1SNibs9CjGIk9LO+fAjN2aFpQwtYW30AMmUbzDkcEcChsB1KFPss9j
         NsgHEH8J+oYGa2wq7WeKmPvQRJm8HVE1FuKei+qqi2GIs8cJdlC8lOquqLwiPQt6q8bm
         cq8KMbVYzKyI65snX/I5OXR09co/fdsJCqx2WFEz/os4Xw8ro/PyScP9wUYjfaByxHNM
         CJdw==
X-Gm-Message-State: APjAAAW3xQt8xga+Nk400IfgCdBxzpDB0vf4MOQVb3xqPSgJnS5cBBHj
        IA9JjWdOXfPzKpSWA+ALQPiANAcmXTz5xczv39NKnIr+SzITPYN/msMdTc8qbG3HQ4l/4lN3Jmd
        XL9Kw5HpB7VonvqesaTSoL85y+B0=
X-Received: by 2002:ac2:5598:: with SMTP id v24mr11234907lfg.30.1573824041758;
        Fri, 15 Nov 2019 05:20:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9ZOhZmHeJdT+ii17d8uiB5r1NUXE+tqvmpcVvYCIMtLlp85FFsArJur/WJqPS+/Ci96kgyQ==
X-Received: by 2002:ac2:5598:: with SMTP id v24mr11234862lfg.30.1573824041145;
        Fri, 15 Nov 2019 05:20:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id s11sm3862166ljo.42.2019.11.15.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:20:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1420A1818C5; Fri, 15 Nov 2019 14:20:39 +0100 (CET)
Subject: [PATCH v9 2/4] mac80211: Import airtime calculation code from mt76
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 15 Nov 2019 14:20:39 +0100
Message-ID: <157382403899.580235.13678327417572732513.stgit@toke.dk>
In-Reply-To: <157382403672.580235.12525941420808058808.stgit@toke.dk>
References: <157382403672.580235.12525941420808058808.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: aufQ_1UnOcegLtp3T2ozgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
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
 include/net/mac80211.h     |   29 ++
 net/mac80211/Makefile      |    3=20
 net/mac80211/airtime.c     |  597 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/ieee80211_i.h |    4=20
 4 files changed, 632 insertions(+), 1 deletion(-)
 create mode 100644 net/mac80211/airtime.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c643a19dce96..6fc26a051ba0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6424,4 +6424,33 @@ void ieee80211_nan_func_match(struct ieee80211_vif *=
vif,
 =09=09=09      struct cfg80211_nan_match_params *match,
 =09=09=09      gfp_t gfp);
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
+=09=09=09      struct ieee80211_rx_status *status,
+=09=09=09      int len);
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
+=09=09=09      struct ieee80211_tx_info *info,
+=09=09=09      int len);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index 4f03ebe732fa..6cbb1286d6c0 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -32,7 +32,8 @@ mac80211-y :=3D \
 =09chan.o \
 =09trace.o mlme.o \
 =09tdls.o \
-=09ocb.o
+=09ocb.o \
+=09airtime.o
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
+#define AVG_PKT_SIZE=091024
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
+#define MCS_SYMBOL_TIME(sgi, ksyms)=09=09=09=09=09\
+=09(sgi ?=09=09=09=09=09=09=09=09\
+=09  ((ksyms) * 4 * 18) / 20 :=09=09/* 3.6 us per sym */=09\
+=09  ((ksyms) * 4)=09=09=09/* 4.0 us per sym */=09\
+=09)
+
+/* Transmit duration for the raw data part of an average sized packet */
+#define MCS_DURATION(streams, sgi, bps) \
+=09((u32)MCS_SYMBOL_TIME(sgi, MCS_N_KSYMS((streams) * (bps))))
+
+#define MCS_DURATION_S(shift, streams, sgi, bps)=09=09\
+=09((u16)((MCS_DURATION(streams, sgi, bps) >> shift)))
+
+/* These should match the values in enum nl80211_he_gi */
+#define HE_GI_08 0
+#define HE_GI_16 1
+#define HE_GI_32 2
+
+/* Transmission time (1024 usec) for a packet containing (ksyms) * k-symbo=
ls */
+#define HE_SYMBOL_TIME(gi, ksyms)=09=09=09=09=09\
+=09(gi =3D=3D HE_GI_08 ?=09=09=09=09=09=09\
+=09 ((ksyms) * 16 * 17) / 20 :=09=09/* 13.6 us per sym */=09\
+=09 (gi =3D=3D HE_GI_16 ?=09=09=09=09=09=09\
+=09  ((ksyms) * 16 * 18) / 20 :=09=09/* 14.4 us per sym */=09\
+=09  ((ksyms) * 16)=09=09=09/* 16.0 us per sym */=09\
+=09 ))
+
+/* Transmit duration for the raw data part of an average sized packet */
+#define HE_DURATION(streams, gi, bps) \
+=09((u32)HE_SYMBOL_TIME(gi, MCS_N_KSYMS((streams) * (bps))))
+
+#define HE_DURATION_S(shift, streams, gi, bps)=09=09\
+=09(HE_DURATION(streams, gi, bps) >> shift)
+
+#define BW_20=09=09=090
+#define BW_40=09=09=091
+#define BW_80=09=09=092
+#define BW_160=09=09=093
+
+/*
+ * Define group sort order: HT40 -> SGI -> #streams
+ */
+#define IEEE80211_MAX_STREAMS=09=094
+#define IEEE80211_HT_STREAM_GROUPS=094 /* BW(=3D2) * SGI(=3D2) */
+#define IEEE80211_VHT_STREAM_GROUPS=098 /* BW(=3D4) * SGI(=3D2) */
+
+#define IEEE80211_HE_MAX_STREAMS=098
+#define IEEE80211_HE_STREAM_GROUPS=0912 /* BW(=3D4) * GI(=3D3) */
+
+#define IEEE80211_HT_GROUPS_NB=09(IEEE80211_MAX_STREAMS *=09\
+=09=09=09=09 IEEE80211_HT_STREAM_GROUPS)
+#define IEEE80211_VHT_GROUPS_NB=09(IEEE80211_MAX_STREAMS *=09\
+=09=09=09=09=09 IEEE80211_VHT_STREAM_GROUPS)
+#define IEEE80211_HE_GROUPS_NB=09(IEEE80211_HE_MAX_STREAMS *=09\
+=09=09=09=09 IEEE80211_HE_STREAM_GROUPS)
+#define IEEE80211_GROUPS_NB=09(IEEE80211_HT_GROUPS_NB +=09\
+=09=09=09=09 IEEE80211_VHT_GROUPS_NB +=09\
+=09=09=09=09 IEEE80211_HE_GROUPS_NB)
+
+#define IEEE80211_HT_GROUP_0=090
+#define IEEE80211_VHT_GROUP_0=09(IEEE80211_HT_GROUP_0 + IEEE80211_HT_GROUP=
S_NB)
+#define IEEE80211_HE_GROUP_0=09(IEEE80211_VHT_GROUP_0 + IEEE80211_VHT_GROU=
PS_NB)
+
+#define MCS_GROUP_RATES=09=0912
+
+#define HT_GROUP_IDX(_streams, _sgi, _ht40)=09\
+=09IEEE80211_HT_GROUP_0 +=09=09=09\
+=09IEEE80211_MAX_STREAMS * 2 * _ht40 +=09\
+=09IEEE80211_MAX_STREAMS * _sgi +=09=09\
+=09_streams - 1
+
+#define _MAX(a, b) (((a)>(b))?(a):(b))
+
+#define GROUP_SHIFT(duration)=09=09=09=09=09=09\
+=09_MAX(0, 16 - __builtin_clz(duration))
+
+/* MCS rate information for an MCS group */
+#define __MCS_GROUP(_streams, _sgi, _ht40, _s)=09=09=09=09\
+=09[HT_GROUP_IDX(_streams, _sgi, _ht40)] =3D {=09=09=09\
+=09.shift =3D _s,=09=09=09=09=09=09=09\
+=09.duration =3D {=09=09=09=09=09=09=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 54 : 26),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 108 : 52),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 162 : 78),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 216 : 104),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 324 : 156),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 432 : 208),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 486 : 234),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi, _ht40 ? 540 : 260)=09\
+=09}=09=09=09=09=09=09=09=09\
+}
+
+#define MCS_GROUP_SHIFT(_streams, _sgi, _ht40)=09=09=09=09\
+=09GROUP_SHIFT(MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26))
+
+#define MCS_GROUP(_streams, _sgi, _ht40)=09=09=09=09\
+=09__MCS_GROUP(_streams, _sgi, _ht40,=09=09=09=09\
+=09=09    MCS_GROUP_SHIFT(_streams, _sgi, _ht40))
+
+#define VHT_GROUP_IDX(_streams, _sgi, _bw)=09=09=09=09\
+=09(IEEE80211_VHT_GROUP_0 +=09=09=09=09=09\
+=09 IEEE80211_MAX_STREAMS * 2 * (_bw) +=09=09=09=09\
+=09 IEEE80211_MAX_STREAMS * (_sgi) +=09=09=09=09\
+=09 (_streams) - 1)
+
+#define BW2VBPS(_bw, r4, r3, r2, r1)=09=09=09=09=09\
+=09(_bw =3D=3D BW_160 ? r4 : _bw =3D=3D BW_80 ? r3 : _bw =3D=3D BW_40 ? r2=
 : r1)
+
+#define __VHT_GROUP(_streams, _sgi, _bw, _s)=09=09=09=09\
+=09[VHT_GROUP_IDX(_streams, _sgi, _bw)] =3D {=09=09=09\
+=09.shift =3D _s,=09=09=09=09=09=09=09\
+=09.duration =3D {=09=09=09=09=09=09=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw,  234,  117,  54,  26)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw,  468,  234, 108,  52)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw,  702,  351, 162,  78)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw,  936,  468, 216, 104)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw, 1404,  702, 324, 156)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw, 1872,  936, 432, 208)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw, 2106, 1053, 486, 234)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw, 2340, 1170, 540, 260)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw, 2808, 1404, 648, 312)),=09\
+=09=09MCS_DURATION_S(_s, _streams, _sgi,=09=09=09\
+=09=09=09       BW2VBPS(_bw, 3120, 1560, 720, 346))=09\
+        }=09=09=09=09=09=09=09=09\
+}
+
+#define VHT_GROUP_SHIFT(_streams, _sgi, _bw)=09=09=09=09\
+=09GROUP_SHIFT(MCS_DURATION(_streams, _sgi,=09=09=09\
+=09=09=09=09 BW2VBPS(_bw, 243, 117,  54,  26)))
+
+#define VHT_GROUP(_streams, _sgi, _bw)=09=09=09=09=09\
+=09__VHT_GROUP(_streams, _sgi, _bw,=09=09=09=09\
+=09=09    VHT_GROUP_SHIFT(_streams, _sgi, _bw))
+
+
+#define HE_GROUP_IDX(_streams, _gi, _bw)=09=09=09=09\
+=09(IEEE80211_HE_GROUP_0 +=09=09=09=09=09\
+=09 IEEE80211_HE_MAX_STREAMS * 2 * (_bw) +=09=09=09\
+=09 IEEE80211_HE_MAX_STREAMS * (_gi) +=09=09=09=09\
+=09 (_streams) - 1)
+
+#define __HE_GROUP(_streams, _gi, _bw, _s)=09=09=09=09\
+=09[HE_GROUP_IDX(_streams, _gi, _bw)] =3D {=09=09=09\
+=09.shift =3D _s,=09=09=09=09=09=09=09\
+=09.duration =3D {=09=09=09=09=09=09=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,   979,  489,  230,  115)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,  1958,  979,  475,  230)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,  2937, 1468,  705,  345)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,  3916, 1958,  936,  475)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,  5875, 2937, 1411,  705)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,  7833, 3916, 1872,  936)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,  8827, 4406, 2102, 1051)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw,  9806, 4896, 2347, 1166)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw, 11764, 5875, 2808, 1411)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw, 13060, 6523, 3124, 1555)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw, 14702, 7344, 3513, 1756)),=09\
+=09=09HE_DURATION_S(_s, _streams, _gi,=09=09=09\
+=09=09=09      BW2VBPS(_bw, 16329, 8164, 3902, 1944))=09\
+        }=09=09=09=09=09=09=09=09\
+}
+
+#define HE_GROUP_SHIFT(_streams, _gi, _bw)=09=09=09=09\
+=09GROUP_SHIFT(HE_DURATION(_streams, _gi,=09=09=09\
+=09=09=09=09BW2VBPS(_bw,   979,  489,  230,  115)))
+
+#define HE_GROUP(_streams, _gi, _bw)=09=09=09=09=09\
+=09__HE_GROUP(_streams, _gi, _bw,=09=09=09=09\
+=09=09   HE_GROUP_SHIFT(_streams, _gi, _bw))
+struct mcs_group {
+=09u8 shift;
+=09u16 duration[MCS_GROUP_RATES];
+};
+
+static const struct mcs_group airtime_mcs_groups[] =3D {
+=09MCS_GROUP(1, 0, BW_20),
+=09MCS_GROUP(2, 0, BW_20),
+=09MCS_GROUP(3, 0, BW_20),
+=09MCS_GROUP(4, 0, BW_20),
+
+=09MCS_GROUP(1, 1, BW_20),
+=09MCS_GROUP(2, 1, BW_20),
+=09MCS_GROUP(3, 1, BW_20),
+=09MCS_GROUP(4, 1, BW_20),
+
+=09MCS_GROUP(1, 0, BW_40),
+=09MCS_GROUP(2, 0, BW_40),
+=09MCS_GROUP(3, 0, BW_40),
+=09MCS_GROUP(4, 0, BW_40),
+
+=09MCS_GROUP(1, 1, BW_40),
+=09MCS_GROUP(2, 1, BW_40),
+=09MCS_GROUP(3, 1, BW_40),
+=09MCS_GROUP(4, 1, BW_40),
+
+=09VHT_GROUP(1, 0, BW_20),
+=09VHT_GROUP(2, 0, BW_20),
+=09VHT_GROUP(3, 0, BW_20),
+=09VHT_GROUP(4, 0, BW_20),
+
+=09VHT_GROUP(1, 1, BW_20),
+=09VHT_GROUP(2, 1, BW_20),
+=09VHT_GROUP(3, 1, BW_20),
+=09VHT_GROUP(4, 1, BW_20),
+
+=09VHT_GROUP(1, 0, BW_40),
+=09VHT_GROUP(2, 0, BW_40),
+=09VHT_GROUP(3, 0, BW_40),
+=09VHT_GROUP(4, 0, BW_40),
+
+=09VHT_GROUP(1, 1, BW_40),
+=09VHT_GROUP(2, 1, BW_40),
+=09VHT_GROUP(3, 1, BW_40),
+=09VHT_GROUP(4, 1, BW_40),
+
+=09VHT_GROUP(1, 0, BW_80),
+=09VHT_GROUP(2, 0, BW_80),
+=09VHT_GROUP(3, 0, BW_80),
+=09VHT_GROUP(4, 0, BW_80),
+
+=09VHT_GROUP(1, 1, BW_80),
+=09VHT_GROUP(2, 1, BW_80),
+=09VHT_GROUP(3, 1, BW_80),
+=09VHT_GROUP(4, 1, BW_80),
+
+=09VHT_GROUP(1, 0, BW_160),
+=09VHT_GROUP(2, 0, BW_160),
+=09VHT_GROUP(3, 0, BW_160),
+=09VHT_GROUP(4, 0, BW_160),
+
+=09VHT_GROUP(1, 1, BW_160),
+=09VHT_GROUP(2, 1, BW_160),
+=09VHT_GROUP(3, 1, BW_160),
+=09VHT_GROUP(4, 1, BW_160),
+
+=09HE_GROUP(1, HE_GI_08, BW_20),
+=09HE_GROUP(2, HE_GI_08, BW_20),
+=09HE_GROUP(3, HE_GI_08, BW_20),
+=09HE_GROUP(4, HE_GI_08, BW_20),
+=09HE_GROUP(5, HE_GI_08, BW_20),
+=09HE_GROUP(6, HE_GI_08, BW_20),
+=09HE_GROUP(7, HE_GI_08, BW_20),
+=09HE_GROUP(8, HE_GI_08, BW_20),
+
+=09HE_GROUP(1, HE_GI_16, BW_20),
+=09HE_GROUP(2, HE_GI_16, BW_20),
+=09HE_GROUP(3, HE_GI_16, BW_20),
+=09HE_GROUP(4, HE_GI_16, BW_20),
+=09HE_GROUP(5, HE_GI_16, BW_20),
+=09HE_GROUP(6, HE_GI_16, BW_20),
+=09HE_GROUP(7, HE_GI_16, BW_20),
+=09HE_GROUP(8, HE_GI_16, BW_20),
+
+=09HE_GROUP(1, HE_GI_32, BW_20),
+=09HE_GROUP(2, HE_GI_32, BW_20),
+=09HE_GROUP(3, HE_GI_32, BW_20),
+=09HE_GROUP(4, HE_GI_32, BW_20),
+=09HE_GROUP(5, HE_GI_32, BW_20),
+=09HE_GROUP(6, HE_GI_32, BW_20),
+=09HE_GROUP(7, HE_GI_32, BW_20),
+=09HE_GROUP(8, HE_GI_32, BW_20),
+
+=09HE_GROUP(1, HE_GI_08, BW_40),
+=09HE_GROUP(2, HE_GI_08, BW_40),
+=09HE_GROUP(3, HE_GI_08, BW_40),
+=09HE_GROUP(4, HE_GI_08, BW_40),
+=09HE_GROUP(5, HE_GI_08, BW_40),
+=09HE_GROUP(6, HE_GI_08, BW_40),
+=09HE_GROUP(7, HE_GI_08, BW_40),
+=09HE_GROUP(8, HE_GI_08, BW_40),
+
+=09HE_GROUP(1, HE_GI_16, BW_40),
+=09HE_GROUP(2, HE_GI_16, BW_40),
+=09HE_GROUP(3, HE_GI_16, BW_40),
+=09HE_GROUP(4, HE_GI_16, BW_40),
+=09HE_GROUP(5, HE_GI_16, BW_40),
+=09HE_GROUP(6, HE_GI_16, BW_40),
+=09HE_GROUP(7, HE_GI_16, BW_40),
+=09HE_GROUP(8, HE_GI_16, BW_40),
+
+=09HE_GROUP(1, HE_GI_32, BW_40),
+=09HE_GROUP(2, HE_GI_32, BW_40),
+=09HE_GROUP(3, HE_GI_32, BW_40),
+=09HE_GROUP(4, HE_GI_32, BW_40),
+=09HE_GROUP(5, HE_GI_32, BW_40),
+=09HE_GROUP(6, HE_GI_32, BW_40),
+=09HE_GROUP(7, HE_GI_32, BW_40),
+=09HE_GROUP(8, HE_GI_32, BW_40),
+
+=09HE_GROUP(1, HE_GI_08, BW_80),
+=09HE_GROUP(2, HE_GI_08, BW_80),
+=09HE_GROUP(3, HE_GI_08, BW_80),
+=09HE_GROUP(4, HE_GI_08, BW_80),
+=09HE_GROUP(5, HE_GI_08, BW_80),
+=09HE_GROUP(6, HE_GI_08, BW_80),
+=09HE_GROUP(7, HE_GI_08, BW_80),
+=09HE_GROUP(8, HE_GI_08, BW_80),
+
+=09HE_GROUP(1, HE_GI_16, BW_80),
+=09HE_GROUP(2, HE_GI_16, BW_80),
+=09HE_GROUP(3, HE_GI_16, BW_80),
+=09HE_GROUP(4, HE_GI_16, BW_80),
+=09HE_GROUP(5, HE_GI_16, BW_80),
+=09HE_GROUP(6, HE_GI_16, BW_80),
+=09HE_GROUP(7, HE_GI_16, BW_80),
+=09HE_GROUP(8, HE_GI_16, BW_80),
+
+=09HE_GROUP(1, HE_GI_32, BW_80),
+=09HE_GROUP(2, HE_GI_32, BW_80),
+=09HE_GROUP(3, HE_GI_32, BW_80),
+=09HE_GROUP(4, HE_GI_32, BW_80),
+=09HE_GROUP(5, HE_GI_32, BW_80),
+=09HE_GROUP(6, HE_GI_32, BW_80),
+=09HE_GROUP(7, HE_GI_32, BW_80),
+=09HE_GROUP(8, HE_GI_32, BW_80),
+
+=09HE_GROUP(1, HE_GI_08, BW_160),
+=09HE_GROUP(2, HE_GI_08, BW_160),
+=09HE_GROUP(3, HE_GI_08, BW_160),
+=09HE_GROUP(4, HE_GI_08, BW_160),
+=09HE_GROUP(5, HE_GI_08, BW_160),
+=09HE_GROUP(6, HE_GI_08, BW_160),
+=09HE_GROUP(7, HE_GI_08, BW_160),
+=09HE_GROUP(8, HE_GI_08, BW_160),
+
+=09HE_GROUP(1, HE_GI_16, BW_160),
+=09HE_GROUP(2, HE_GI_16, BW_160),
+=09HE_GROUP(3, HE_GI_16, BW_160),
+=09HE_GROUP(4, HE_GI_16, BW_160),
+=09HE_GROUP(5, HE_GI_16, BW_160),
+=09HE_GROUP(6, HE_GI_16, BW_160),
+=09HE_GROUP(7, HE_GI_16, BW_160),
+=09HE_GROUP(8, HE_GI_16, BW_160),
+
+=09HE_GROUP(1, HE_GI_32, BW_160),
+=09HE_GROUP(2, HE_GI_32, BW_160),
+=09HE_GROUP(3, HE_GI_32, BW_160),
+=09HE_GROUP(4, HE_GI_32, BW_160),
+=09HE_GROUP(5, HE_GI_32, BW_160),
+=09HE_GROUP(6, HE_GI_32, BW_160),
+=09HE_GROUP(7, HE_GI_32, BW_160),
+=09HE_GROUP(8, HE_GI_32, BW_160),
+};
+
+static u32
+ieee80211_calc_legacy_rate_duration(u16 bitrate, bool short_pre,
+=09=09=09=09    bool cck, int len)
+{
+=09u32 duration;
+
+=09if (cck) {
+=09=09duration =3D 144 + 48; /* preamble + PLCP */
+=09=09if (short_pre)
+=09=09=09duration >>=3D 1;
+
+=09=09duration +=3D 10; /* SIFS */
+=09} else {
+=09=09duration =3D 20 + 16; /* premable + SIFS */
+=09}
+
+=09len <<=3D 3;
+=09duration +=3D (len * 10) / bitrate;
+
+=09return duration;
+}
+
+u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
+=09=09=09      struct ieee80211_rx_status *status,
+=09=09=09      int len)
+{
+=09struct ieee80211_supported_band *sband;
+=09const struct ieee80211_rate *rate;
+=09bool sgi =3D status->enc_flags & RX_ENC_FLAG_SHORT_GI;
+=09bool sp =3D status->enc_flags & RX_ENC_FLAG_SHORTPRE;
+=09int bw, streams;
+=09int group, idx;
+=09u32 duration;
+=09bool cck;
+
+=09switch (status->bw) {
+=09case RATE_INFO_BW_20:
+=09=09bw =3D BW_20;
+=09=09break;
+=09case RATE_INFO_BW_40:
+=09=09bw =3D BW_40;
+=09=09break;
+=09case RATE_INFO_BW_80:
+=09=09bw =3D BW_80;
+=09=09break;
+=09case RATE_INFO_BW_160:
+=09=09bw =3D BW_160;
+=09=09break;
+=09default:
+=09=09WARN_ON_ONCE(1);
+=09=09return 0;
+=09}
+
+=09switch (status->encoding) {
+=09case RX_ENC_LEGACY:
+=09=09if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
+=09=09=09return 0;
+
+=09=09sband =3D hw->wiphy->bands[status->band];
+=09=09if (!sband || status->rate_idx > sband->n_bitrates)
+=09=09=09return 0;
+
+=09=09rate =3D &sband->bitrates[status->rate_idx];
+=09=09cck =3D rate->flags & IEEE80211_RATE_MANDATORY_B;
+
+=09=09return ieee80211_calc_legacy_rate_duration(rate->bitrate, sp,
+=09=09=09=09=09=09=09   cck, len);
+
+=09case RX_ENC_VHT:
+=09=09streams =3D status->nss;
+=09=09idx =3D status->rate_idx;
+=09=09group =3D VHT_GROUP_IDX(streams, sgi, bw);
+=09=09break;
+=09case RX_ENC_HT:
+=09=09streams =3D ((status->rate_idx >> 3) & 3) + 1;
+=09=09idx =3D status->rate_idx & 7;
+=09=09group =3D HT_GROUP_IDX(streams, sgi, bw);
+=09=09break;
+=09case RX_ENC_HE:
+=09=09streams =3D status->nss;
+=09=09idx =3D status->rate_idx;
+=09=09group =3D HE_GROUP_IDX(streams, status->he_gi, bw);
+=09=09break;
+=09default:
+=09=09WARN_ON_ONCE(1);
+=09=09return 0;
+=09}
+
+=09if (WARN_ON_ONCE((status->encoding !=3D RX_ENC_HE && streams > 4) ||
+=09=09=09 (status->encoding =3D=3D RX_ENC_HE && streams > 8)))
+=09=09return 0;
+
+=09duration =3D airtime_mcs_groups[group].duration[idx];
+=09duration <<=3D airtime_mcs_groups[group].shift;
+=09duration *=3D len;
+=09duration /=3D AVG_PKT_SIZE;
+=09duration /=3D 1024;
+
+=09duration +=3D 36 + (streams << 2);
+
+=09return duration;
+}
+EXPORT_SYMBOL_GPL(ieee80211_calc_rx_airtime);
+
+static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
+=09=09=09=09=09  struct ieee80211_tx_rate *rate,
+=09=09=09=09=09  u8 band, int len)
+{
+=09struct ieee80211_rx_status stat =3D {
+=09=09.band =3D band,
+=09};
+
+=09if (rate->idx < 0 || !rate->count)
+=09=09return 0;
+
+=09if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+=09=09stat.bw =3D RATE_INFO_BW_80;
+=09else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+=09=09stat.bw =3D RATE_INFO_BW_40;
+=09else
+=09=09stat.bw =3D RATE_INFO_BW_20;
+
+=09stat.enc_flags =3D 0;
+=09if (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
+=09=09stat.enc_flags |=3D RX_ENC_FLAG_SHORTPRE;
+=09if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
+=09=09stat.enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
+
+=09stat.rate_idx =3D rate->idx;
+=09if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
+=09=09stat.encoding =3D RX_ENC_VHT;
+=09=09stat.rate_idx =3D ieee80211_rate_get_vht_mcs(rate);
+=09=09stat.nss =3D ieee80211_rate_get_vht_nss(rate);
+=09} else if (rate->flags & IEEE80211_TX_RC_MCS) {
+=09=09stat.encoding =3D RX_ENC_HT;
+=09} else {
+=09=09stat.encoding =3D RX_ENC_LEGACY;
+=09}
+
+=09return ieee80211_calc_rx_airtime(hw, &stat, len);
+}
+
+u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
+=09=09=09      struct ieee80211_tx_info *info,
+=09=09=09      int len)
+{
+=09u32 duration =3D 0;
+=09int i;
+
+=09for (i =3D 0; i < ARRAY_SIZE(info->status.rates); i++) {
+=09=09struct ieee80211_tx_rate *rate =3D &info->status.rates[i];
+=09=09u32 cur_duration;
+
+=09=09cur_duration =3D ieee80211_calc_tx_airtime_rate(hw, rate,
+=09=09=09=09=09=09=09      info->band, len);
+=09=09if (!cur_duration)
+=09=09=09break;
+
+=09=09duration +=3D cur_duration * rate->count;
+=09}
+
+=09return duration;
+}
+EXPORT_SYMBOL_GPL(ieee80211_calc_tx_airtime);
+
+u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
+=09=09=09=09       struct ieee80211_vif *vif,
+=09=09=09=09       struct ieee80211_sta *pubsta,
+=09=09=09=09       int len)
+{
+=09struct ieee80211_supported_band *sband;
+=09struct ieee80211_chanctx_conf *conf;
+=09int rateidx, shift =3D 0;
+=09bool cck, short_pream;
+=09u32 basic_rates;
+=09u8 band =3D 0;
+=09u16 rate;
+
+=09len +=3D 38; /* Ethernet header length */
+
+=09conf =3D rcu_dereference(vif->chanctx_conf);
+=09if (conf) {
+=09=09band =3D conf->def.chan->band;
+=09=09shift =3D ieee80211_chandef_get_shift(&conf->def);
+=09}
+
+=09if (pubsta) {
+=09=09struct sta_info *sta =3D container_of(pubsta, struct sta_info,
+=09=09=09=09=09=09    sta);
+
+=09=09return ieee80211_calc_tx_airtime_rate(hw,
+=09=09=09=09=09=09      &sta->tx_stats.last_rate,
+=09=09=09=09=09=09      band, len);
+=09}
+
+=09if (!conf)
+=09=09return 0;
+
+=09/* No station to get latest rate from, so calculate the worst-case
+=09 * duration using the lowest configured basic rate.
+=09 */
+=09sband =3D hw->wiphy->bands[band];
+
+=09basic_rates =3D vif->bss_conf.basic_rates;
+=09short_pream =3D vif->bss_conf.use_short_preamble;
+
+=09rateidx =3D basic_rates ? ffs(basic_rates) - 1 : 0;
+=09rate =3D sband->bitrates[rateidx].bitrate << shift;
+=09cck =3D sband->bitrates[rateidx].flags & IEEE80211_RATE_MANDATORY_B;
+
+=09return ieee80211_calc_legacy_rate_duration(rate, short_pream, cck, len)=
;
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
+=09=09=09=09       struct ieee80211_vif *vif,
+=09=09=09=09       struct ieee80211_sta *pubsta,
+=09=09=09=09       int len);
 #ifdef CONFIG_MAC80211_NOINLINE
 #define debug_noinline noinline
 #else

