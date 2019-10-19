Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFEADD892
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfJSLhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 07:37:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725912AbfJSLhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571485042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=037kYcrwRSTSMLRfx4CfzNcNZlFM0quGkGQoN08cL8c=;
        b=GWFYCsbJUAwSwPwovvpcC7es1Sek6oegz+ruVaRzzkrXSO9050jMyWuAvQaYYvsGIBdn3g
        pT+JVQCLYh8P6MYHpvpmrLhLWajcdnAiaU4N1/GjqiVVWZCyTRSB3E2iDp98P1A5NledHR
        2dYj9S6qNcYUB/N89kRsv8RTIi0JSXk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-LsuxyQ--OQiMH5zt02wo0Q-1; Sat, 19 Oct 2019 07:37:20 -0400
Received: by mail-lf1-f71.google.com with SMTP id m24so1760989lfh.22
        for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2019 04:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8YRb2N6dvs3xtiXuol7/wWZTQ7TYCWwqAjekk5alzxE=;
        b=uU6/JVgYdoUY5ulA+n2bVIZTO2sn7oU8j8FSrA21TralLEDBDuLAVuOS4A1CchJeis
         x8WA4m2vfRHo9WHY10Px2IZg9x6CrClW0gudeSJMnhD9JCH2Ri4guNGfu+aviwdlI8c0
         FFwdDYpluHl0GfsCBzO0bQwLzDfS5dDMXzYnfQrIWZmB/1sME4JH1Ouu45rtyBGbw9JQ
         Q08Pnhh94x/MfLnFE5jPkYakBZgeGDhG9wDvO9+YRA1yZMUV8wCfBy7LUrm80kfUPn4M
         ZFuyOQny6NmaPOD4DTsv2GiotiFHY+5F+0PS6oeNc0ah7xNS4Nu8XDOAl/YvACEapIfG
         Gt2w==
X-Gm-Message-State: APjAAAWNOFWvT6bsvm9LmXkxfxFCAhmtC3f8yGSu6p9U7EWMBsAZHHuV
        A2RN1SmO6OM9xPqmDIF0epxxKqc1WdIZqYs4FD2nA7SNdS9v77mBBDMAlpo3DFxtzVj8+86rX0H
        uwe16XF20njiXmGZV2YkIUMgtSRY=
X-Received: by 2002:a05:6512:71:: with SMTP id i17mr8732633lfo.68.1571485038572;
        Sat, 19 Oct 2019 04:37:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5Sb37FfZdcXLsWgNLkG3Qp9yoKg+1KpKvOrzk68btQ0fb7apBhu+aAD3ATqBsh9D3ijUO8g==
X-Received: by 2002:a05:6512:71:: with SMTP id i17mr8732613lfo.68.1571485038103;
        Sat, 19 Oct 2019 04:37:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id d24sm269009lfl.65.2019.10.19.04.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 04:37:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 800331804C8; Sat, 19 Oct 2019 13:37:16 +0200 (CEST)
Subject: [PATCH v4 2/4] mac80211: Import airtime calculation code from mt76
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Sat, 19 Oct 2019 13:37:16 +0200
Message-ID: <157148503639.2989444.8337290298332344733.stgit@toke.dk>
In-Reply-To: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: LsuxyQ--OQiMH5zt02wo0Q-1
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
calculations later.

The airtime.c file is copied verbatim from the mt76 driver, and adjusted to
use mac80211 data structures instead (which is fairly straight forward).
The per-rate TX rate calculation is split out to its own
function (ieee80211_calc_tx_airtime_rate()) so it can be used directly for
the AQL calculations added in a subsequent patch.

The only thing that it was not possible to port directly was the bit that
read the internal driver flags of struct ieee80211_rate to determine
whether a rate is using CCK or OFDM encoding. Instead, just look at the
rate index, since at least mt76 and ath10k both seem to have the same
number of CCK rates (4) in their tables.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/mac80211.h     |   14 ++
 net/mac80211/Makefile      |    3=20
 net/mac80211/airtime.c     |  377 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/ieee80211_i.h |    4=20
 4 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 net/mac80211/airtime.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4288ace72c2b..f058386e3fef 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6424,4 +6424,18 @@ void ieee80211_nan_func_match(struct ieee80211_vif *=
vif,
 =09=09=09      struct cfg80211_nan_match_params *match,
 =09=09=09      gfp_t gfp);
=20
+/**
+ * ieee80211_calc_tx_airtime - calculate estimated transmission airtime.
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
index 000000000000..c8d0cee61366
--- /dev/null
+++ b/net/mac80211/airtime.c
@@ -0,0 +1,377 @@
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
+/* Number of symbols for a packet with (bps) bits per symbol */
+#define MCS_NSYMS(bps) DIV_ROUND_UP(MCS_NBITS, (bps))
+
+/* Transmission time (1024 usec) for a packet containing (syms) * symbols =
*/
+#define MCS_SYMBOL_TIME(sgi, syms)=09=09=09=09=09\
+=09(sgi ?=09=09=09=09=09=09=09=09\
+=09  ((syms) * 18 * 1024 + 4 * 1024) / 5 :=09/* syms * 3.6 us */=09\
+=09  ((syms) * 1024) << 2=09=09=09/* syms * 4 us */=09\
+=09)
+
+/* Transmit duration for the raw data part of an average sized packet */
+#define MCS_DURATION(streams, sgi, bps) \
+=09MCS_SYMBOL_TIME(sgi, MCS_NSYMS((streams) * (bps)))
+
+#define BW_20=09=09=090
+#define BW_40=09=09=091
+#define BW_80=09=09=092
+
+/*
+ * Define group sort order: HT40 -> SGI -> #streams
+ */
+#define IEEE80211_MAX_STREAMS=09=094
+#define IEEE80211_HT_STREAM_GROUPS=094 /* BW(=3D2) * SGI(=3D2) */
+#define IEEE80211_VHT_STREAM_GROUPS=096 /* BW(=3D3) * SGI(=3D2) */
+
+#define IEEE80211_HT_GROUPS_NB=09(IEEE80211_MAX_STREAMS *=09\
+=09=09=09=09 IEEE80211_HT_STREAM_GROUPS)
+#define IEEE80211_VHT_GROUPS_NB=09(IEEE80211_MAX_STREAMS *=09\
+=09=09=09=09=09 IEEE80211_VHT_STREAM_GROUPS)
+#define IEEE80211_GROUPS_NB=09(IEEE80211_HT_GROUPS_NB +=09\
+=09=09=09=09 IEEE80211_VHT_GROUPS_NB)
+
+#define IEEE80211_HT_GROUP_0=090
+#define IEEE80211_VHT_GROUP_0=09(IEEE80211_HT_GROUP_0 + IEEE80211_HT_GROUP=
S_NB)
+
+#define MCS_GROUP_RATES=09=0910
+#define CCK_NUM_RATES=09=09=094
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
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 108 : 52) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 162 : 78) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 216 : 104) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 324 : 156) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 432 : 208) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 486 : 234) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 540 : 260) >> _s=09\
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
+=09(IEEE80211_VHT_GROUP_0 +=09=09=09=09=09=09\
+=09 IEEE80211_MAX_STREAMS * 2 * (_bw) +=09=09=09=09\
+=09 IEEE80211_MAX_STREAMS * (_sgi) +=09=09=09=09\
+=09 (_streams) - 1)
+
+#define BW2VBPS(_bw, r3, r2, r1)=09=09=09=09=09\
+=09(_bw =3D=3D BW_80 ? r3 : _bw =3D=3D BW_40 ? r2 : r1)
+
+#define __VHT_GROUP(_streams, _sgi, _bw, _s)=09=09=09=09\
+=09[VHT_GROUP_IDX(_streams, _sgi, _bw)] =3D {=09=09=09\
+=09.shift =3D _s,=09=09=09=09=09=09=09\
+=09.duration =3D {=09=09=09=09=09=09=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw,  117,  54,  26)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw,  234, 108,  52)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw,  351, 162,  78)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw,  468, 216, 104)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw,  702, 324, 156)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw,  936, 432, 208)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw, 1053, 486, 234)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw, 1170, 540, 260)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw, 1404, 648, 312)) >> _s,=09\
+=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
+=09=09=09     BW2VBPS(_bw, 1560, 720, 346)) >> _s=09\
+=09}=09=09=09=09=09=09=09=09\
+}
+
+#define VHT_GROUP_SHIFT(_streams, _sgi, _bw)=09=09=09=09\
+=09GROUP_SHIFT(MCS_DURATION(_streams, _sgi,=09=09=09\
+=09=09=09=09 BW2VBPS(_bw,  117,  54,  26)))
+
+#define VHT_GROUP(_streams, _sgi, _bw)=09=09=09=09=09\
+=09__VHT_GROUP(_streams, _sgi, _bw,=09=09=09=09\
+=09=09    VHT_GROUP_SHIFT(_streams, _sgi, _bw))
+
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
+};
+
+static u32
+ieee80211_calc_legacy_rate_duration(const struct ieee80211_rate *rate,
+=09=09=09=09    bool short_pre, bool cck,
+=09=09=09=09    int len)
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
+=09duration +=3D (len * 10) / rate->bitrate;
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
+=09u32 duration;
+=09int group, idx;
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
+=09=09cck =3D (status->rate_idx < CCK_NUM_RATES);
+
+=09=09return ieee80211_calc_legacy_rate_duration(rate, sp, cck, len);
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
+=09default:
+=09=09WARN_ON_ONCE(1);
+=09=09return 0;
+=09}
+
+=09if (WARN_ON_ONCE(streams > 4))
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
+
+u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
+=09=09=09=09   struct ieee80211_tx_rate *rate,
+=09=09=09=09   u8 band, int len)
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
+
+u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
+=09=09=09=09       struct ieee80211_vif *vif,
+=09=09=09=09       struct ieee80211_sta *pubsta,
+=09=09=09=09       int len)
+{
+=09struct ieee80211_supported_band *sband;
+=09struct ieee80211_chanctx_conf *conf;
+=09struct ieee80211_rate *rate;
+=09struct sta_info *sta;
+=09u8 band =3D 0;
+
+=09len +=3D 38; /* Ethernet header length */
+
+=09conf =3D rcu_dereference(vif->chanctx_conf);
+=09if (conf)
+=09=09band =3D conf->def.chan->band;
+
+=09if (pubsta) {
+=09=09sta  =3D container_of(pubsta, struct sta_info, sta);
+=09=09return ieee80211_calc_tx_airtime_rate(hw, &sta->tx_stats.last_rate,
+=09=09=09=09=09=09      band, len);
+=09}
+
+=09if (!conf)
+=09=09return 0;
+
+=09/* No station to get latest rate from, so calculate the
+=09 * worst-case duration for the lowest rate.
+=09 */
+=09sband =3D hw->wiphy->bands[band];
+=09rate =3D &sband->bitrates[0];
+
+=09return ieee80211_calc_legacy_rate_duration(rate, false, true, len);
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

