Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89DFC0147
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfI0IgI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 04:36:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbfI0IgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 04:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569573366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+cILNkghthHLJUbEikFN1pkD45n3Y852DLGl/OhbSA=;
        b=NCo+p3xf1Ape1iFGhn3NqROVO64HDtyYSawYcwZnT2M/+YBlHXZvCopy4Ta1xzv9J89doD
        5kArh/ollDiFGkRfFT+loH8VweJVvHiy1OcF7wJVHlnJ0GWi9maKEwrSdGW+MvQujx1WLu
        HR7dql00pT9xilU7/FJBg30H+GxjFn8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-WZm0l44MOJeJ0fsG2vaAuA-1; Fri, 27 Sep 2019 04:36:02 -0400
Received: by mail-ed1-f72.google.com with SMTP id w12so1189488eda.6
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2019 01:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FH/D3/SCX4lVhDtBhubVLa4BQyzg8hAXCWtdL7lkK5M=;
        b=YOsfM+pUztylE/IndeuiPy4FXcpuqFFz1R6plVPN2iTg5MqGisyc94U+2OsXv8+i37
         UZs3C18zRNkZKlDC4G20QiWXSWD9Y5Gblx9pEF1Sm9z0QMeMiZZYxDxs4wPskAHVSc/V
         7uQpU5Kl9sQ13SIvlTULfkcxA7w2S/MPDg3O3KnBqezqllZFTZgVGOW8h3LtKPuxN6CA
         2kBuYZAL9l83YzFrQU83+Li8AZAo545emUfjOOvlMsSx3DFdDD0IJauHBu08HdkrP1hw
         xwTGeay1XUTdaqGo3idJSVUkHAqu/aFnFclaitiGYhWP/duae0cDkrstr2UheZdi6gEi
         UK1g==
X-Gm-Message-State: APjAAAX22/K8H+oECyJI/FaS7vSu5Kq4B1pmEcmexfz3j6efIjlmfaSR
        TFKAxGp1Uw3G0mqAsWIKZOxlYlf+33nLPf/7fpeywarLA+5XnRNj61nN1Rc0yirdDDn+y0w7Dwd
        xgthRCwKEst0SkBZLzymA2VqwyDI=
X-Received: by 2002:a17:906:4d58:: with SMTP id b24mr6789773ejv.263.1569573361052;
        Fri, 27 Sep 2019 01:36:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy74cywCWveEBkf52ENU0RDbu8Gs+13XTotxf1ghCMvKZeT/wMGD3dU0il7Ndwv7BJS0ZsExQ==
X-Received: by 2002:a17:906:4d58:: with SMTP id b24mr6789752ejv.263.1569573360769;
        Fri, 27 Sep 2019 01:36:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id g15sm376968edp.0.2019.09.27.01.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:35:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5DE2018063D; Fri, 27 Sep 2019 10:35:59 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/15] mt76: track rx airtime for airtime fairness and survey
In-Reply-To: <20190926174732.42375-5-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name> <20190926174732.42375-5-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 10:35:59 +0200
Message-ID: <87v9teyw40.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: WZm0l44MOJeJ0fsG2vaAuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Report total rx airtime for valid stations as BSS rx time in survey
>
> mt7615 is left out for now, it will be supported later by reading
> hardware counters instead of calculating airtime in software
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
>  drivers/net/wireless/mediatek/mt76/airtime.c  | 278 ++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 109 ++++++-
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  64 ++--
>  .../net/wireless/mediatek/mt76/mt7603/init.c  |   1 +
>  .../net/wireless/mediatek/mt76/mt7603/mac.c   |   2 +-
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   |   2 +-
>  .../net/wireless/mediatek/mt76/mt76x0/pci.c   |   3 +-
>  .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   1 +
>  .../net/wireless/mediatek/mt76/mt76x02_mac.c  |   4 +-
>  .../net/wireless/mediatek/mt76/mt76x2/pci.c   |   3 +-
>  .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   1 +
>  12 files changed, 433 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/airtime.c
>
> diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wi=
reless/mediatek/mt76/Makefile
> index 4d03596e891f..181af60e32db 100644
> --- a/drivers/net/wireless/mediatek/mt76/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/Makefile
> @@ -6,7 +6,7 @@ obj-$(CONFIG_MT76x02_USB) +=3D mt76x02-usb.o
> =20
>  mt76-y :=3D \
>  =09mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
> -=09tx.o agg-rx.o mcu.o
> +=09tx.o agg-rx.o mcu.o airtime.o
> =20
>  mt76-usb-y :=3D usb.o usb_trace.o
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/net/w=
ireless/mediatek/mt76/airtime.c
> new file mode 100644
> index 000000000000..d5bc4d713a88
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/airtime.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: ISC
> +/*
> + * Copyright (C) 2019 Felix Fietkau <nbd@nbd.name>
> + */
> +
> +#include "mt76.h"
> +
> +#define AVG_PKT_SIZE=091024
> +
> +/* Number of bits for an average sized packet */
> +#define MCS_NBITS (AVG_PKT_SIZE << 3)
> +
> +/* Number of symbols for a packet with (bps) bits per symbol */
> +#define MCS_NSYMS(bps) DIV_ROUND_UP(MCS_NBITS, (bps))
> +
> +/* Transmission time (1024 usec) for a packet containing (syms) * symbol=
s */
> +#define MCS_SYMBOL_TIME(sgi, syms)=09=09=09=09=09\
> +=09(sgi ?=09=09=09=09=09=09=09=09\
> +=09  ((syms) * 18 * 1024 + 4 * 1024) / 5 :=09/* syms * 3.6 us */=09\
> +=09  ((syms) * 1024) << 2=09=09=09/* syms * 4 us */=09\
> +=09)
> +
> +/* Transmit duration for the raw data part of an average sized packet */
> +#define MCS_DURATION(streams, sgi, bps) \
> +=09MCS_SYMBOL_TIME(sgi, MCS_NSYMS((streams) * (bps)))
> +
> +#define BW_20=09=09=090
> +#define BW_40=09=09=091
> +#define BW_80=09=09=092
> +
> +/*
> + * Define group sort order: HT40 -> SGI -> #streams
> + */
> +#define MT_MAX_STREAMS=09=094
> +#define MT_HT_STREAM_GROUPS=094 /* BW(=3D2) * SGI(=3D2) */
> +#define MT_VHT_STREAM_GROUPS=096 /* BW(=3D3) * SGI(=3D2) */
> +
> +#define MT_HT_GROUPS_NB=09(MT_MAX_STREAMS *=09=09\
> +=09=09=09=09 MT_HT_STREAM_GROUPS)
> +#define MT_VHT_GROUPS_NB=09(MT_MAX_STREAMS *=09=09\
> +=09=09=09=09 MT_VHT_STREAM_GROUPS)
> +#define MT_GROUPS_NB=09(MT_HT_GROUPS_NB +=09\
> +=09=09=09=09 MT_VHT_GROUPS_NB)
> +
> +#define MT_HT_GROUP_0=090
> +#define MT_VHT_GROUP_0=09(MT_HT_GROUP_0 + MT_HT_GROUPS_NB)
> +
> +#define MCS_GROUP_RATES=09=0910
> +
> +#define HT_GROUP_IDX(_streams, _sgi, _ht40)=09\
> +=09MT_HT_GROUP_0 +=09=09=09\
> +=09MT_MAX_STREAMS * 2 * _ht40 +=09\
> +=09MT_MAX_STREAMS * _sgi +=09\
> +=09_streams - 1
> +
> +#define _MAX(a, b) (((a)>(b))?(a):(b))
> +
> +#define GROUP_SHIFT(duration)=09=09=09=09=09=09\
> +=09_MAX(0, 16 - __builtin_clz(duration))
> +
> +/* MCS rate information for an MCS group */
> +#define __MCS_GROUP(_streams, _sgi, _ht40, _s)=09=09=09=09\
> +=09[HT_GROUP_IDX(_streams, _sgi, _ht40)] =3D {=09=09=09\
> +=09.shift =3D _s,=09=09=09=09=09=09=09\
> +=09.duration =3D {=09=09=09=09=09=09=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 108 : 52) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 162 : 78) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 216 : 104) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 324 : 156) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 432 : 208) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 486 : 234) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi, _ht40 ? 540 : 260) >> _s=09\
> +=09}=09=09=09=09=09=09=09=09\
> +}
> +
> +#define MCS_GROUP_SHIFT(_streams, _sgi, _ht40)=09=09=09=09\
> +=09GROUP_SHIFT(MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26))
> +
> +#define MCS_GROUP(_streams, _sgi, _ht40)=09=09=09=09\
> +=09__MCS_GROUP(_streams, _sgi, _ht40,=09=09=09=09\
> +=09=09    MCS_GROUP_SHIFT(_streams, _sgi, _ht40))
> +
> +#define VHT_GROUP_IDX(_streams, _sgi, _bw)=09=09=09=09\
> +=09(MT_VHT_GROUP_0 +=09=09=09=09=09=09\
> +=09 MT_MAX_STREAMS * 2 * (_bw) +=09=09=09=09\
> +=09 MT_MAX_STREAMS * (_sgi) +=09=09=09=09\
> +=09 (_streams) - 1)
> +
> +#define BW2VBPS(_bw, r3, r2, r1)=09=09=09=09=09\
> +=09(_bw =3D=3D BW_80 ? r3 : _bw =3D=3D BW_40 ? r2 : r1)
> +
> +#define __VHT_GROUP(_streams, _sgi, _bw, _s)=09=09=09=09\
> +=09[VHT_GROUP_IDX(_streams, _sgi, _bw)] =3D {=09=09=09\
> +=09.shift =3D _s,=09=09=09=09=09=09=09\
> +=09.duration =3D {=09=09=09=09=09=09=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw,  117,  54,  26)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw,  234, 108,  52)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw,  351, 162,  78)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw,  468, 216, 104)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw,  702, 324, 156)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw,  936, 432, 208)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw, 1053, 486, 234)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw, 1170, 540, 260)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw, 1404, 648, 312)) >> _s,=09\
> +=09=09MCS_DURATION(_streams, _sgi,=09=09=09=09\
> +=09=09=09     BW2VBPS(_bw, 1560, 720, 346)) >> _s=09\
> +=09}=09=09=09=09=09=09=09=09\
> +}
> +
> +#define VHT_GROUP_SHIFT(_streams, _sgi, _bw)=09=09=09=09\
> +=09GROUP_SHIFT(MCS_DURATION(_streams, _sgi,=09=09=09\
> +=09=09=09=09 BW2VBPS(_bw,  117,  54,  26)))
> +
> +#define VHT_GROUP(_streams, _sgi, _bw)=09=09=09=09=09\
> +=09__VHT_GROUP(_streams, _sgi, _bw,=09=09=09=09\
> +=09=09    VHT_GROUP_SHIFT(_streams, _sgi, _bw))
> +
> +struct mcs_group {
> +=09u8 shift;
> +=09u16 duration[MCS_GROUP_RATES];
> +};
> +
> +static const struct mcs_group airtime_mcs_groups[] =3D {
> +=09MCS_GROUP(1, 0, BW_20),
> +=09MCS_GROUP(2, 0, BW_20),
> +=09MCS_GROUP(3, 0, BW_20),
> +=09MCS_GROUP(4, 0, BW_20),
> +
> +=09MCS_GROUP(1, 1, BW_20),
> +=09MCS_GROUP(2, 1, BW_20),
> +=09MCS_GROUP(3, 1, BW_20),
> +=09MCS_GROUP(4, 1, BW_20),
> +
> +=09MCS_GROUP(1, 0, BW_40),
> +=09MCS_GROUP(2, 0, BW_40),
> +=09MCS_GROUP(3, 0, BW_40),
> +=09MCS_GROUP(4, 0, BW_40),
> +
> +=09MCS_GROUP(1, 1, BW_40),
> +=09MCS_GROUP(2, 1, BW_40),
> +=09MCS_GROUP(3, 1, BW_40),
> +=09MCS_GROUP(4, 1, BW_40),
> +
> +=09VHT_GROUP(1, 0, BW_20),
> +=09VHT_GROUP(2, 0, BW_20),
> +=09VHT_GROUP(3, 0, BW_20),
> +=09VHT_GROUP(4, 0, BW_20),
> +
> +=09VHT_GROUP(1, 1, BW_20),
> +=09VHT_GROUP(2, 1, BW_20),
> +=09VHT_GROUP(3, 1, BW_20),
> +=09VHT_GROUP(4, 1, BW_20),
> +
> +=09VHT_GROUP(1, 0, BW_40),
> +=09VHT_GROUP(2, 0, BW_40),
> +=09VHT_GROUP(3, 0, BW_40),
> +=09VHT_GROUP(4, 0, BW_40),
> +
> +=09VHT_GROUP(1, 1, BW_40),
> +=09VHT_GROUP(2, 1, BW_40),
> +=09VHT_GROUP(3, 1, BW_40),
> +=09VHT_GROUP(4, 1, BW_40),
> +
> +=09VHT_GROUP(1, 0, BW_80),
> +=09VHT_GROUP(2, 0, BW_80),
> +=09VHT_GROUP(3, 0, BW_80),
> +=09VHT_GROUP(4, 0, BW_80),
> +
> +=09VHT_GROUP(1, 1, BW_80),
> +=09VHT_GROUP(2, 1, BW_80),
> +=09VHT_GROUP(3, 1, BW_80),
> +=09VHT_GROUP(4, 1, BW_80),
> +};
> +
> +static u32
> +mt76_calc_legacy_rate_duration(const struct ieee80211_rate *rate, bool s=
hort_pre,
> +=09=09=09       int len)
> +{
> +=09u32 duration;
> +
> +=09switch (rate->hw_value >> 8) {
> +=09case MT_PHY_TYPE_CCK:
> +=09=09duration =3D 144 + 48; /* preamble + PLCP */
> +=09=09if (short_pre)
> +=09=09=09duration >>=3D 1;
> +
> +=09=09duration +=3D 10; /* SIFS */
> +=09=09break;
> +=09case MT_PHY_TYPE_OFDM:
> +=09=09duration =3D 20 + 16; /* premable + SIFS */
> +=09=09break;
> +=09default:
> +=09=09WARN_ON_ONCE(1);
> +=09=09return 0;
> +=09}
> +
> +=09len <<=3D 3;
> +=09duration +=3D (len * 10) / rate->bitrate;
> +
> +=09return duration;
> +}
> +
> +u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *st=
atus,
> +=09=09=09 int len)
> +{
> +=09struct ieee80211_supported_band *sband;
> +=09const struct ieee80211_rate *rate;
> +=09bool sgi =3D status->enc_flags & RX_ENC_FLAG_SHORT_GI;
> +=09bool sp =3D status->enc_flags & RX_ENC_FLAG_SHORTPRE;
> +=09int bw, streams;
> +=09u32 duration;
> +=09int group, idx;
> +
> +=09switch (status->bw) {
> +=09case RATE_INFO_BW_20:
> +=09=09bw =3D BW_20;
> +=09=09break;
> +=09case RATE_INFO_BW_40:
> +=09=09bw =3D BW_40;
> +=09=09break;
> +=09case RATE_INFO_BW_80:
> +=09=09bw =3D BW_80;
> +=09=09break;
> +=09default:
> +=09=09WARN_ON_ONCE(1);
> +=09=09return 0;
> +=09}
> +
> +=09switch (status->encoding) {
> +=09case RX_ENC_LEGACY:
> +=09=09if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
> +=09=09=09return 0;
> +
> +=09=09sband =3D dev->hw->wiphy->bands[status->band];
> +=09=09if (!sband || status->rate_idx > sband->n_bitrates)
> +=09=09=09return 0;
> +
> +=09=09rate =3D &sband->bitrates[status->rate_idx];
> +
> +=09=09return mt76_calc_legacy_rate_duration(rate, sp, len);
> +=09case RX_ENC_VHT:
> +=09=09streams =3D status->nss;
> +=09=09idx =3D status->rate_idx;
> +=09=09group =3D VHT_GROUP_IDX(streams, sgi, bw);
> +=09=09break;
> +=09case RX_ENC_HT:
> +=09=09streams =3D ((status->rate_idx >> 3) & 3) + 1;
> +=09=09idx =3D status->rate_idx & 7;
> +=09=09group =3D HT_GROUP_IDX(streams, sgi, bw);
> +=09=09break;
> +=09default:
> +=09=09WARN_ON_ONCE(1);
> +=09=09return 0;
> +=09}
> +
> +=09if (WARN_ON_ONCE(streams > 4))
> +=09=09return 0;
> +
> +=09duration =3D airtime_mcs_groups[group].duration[idx];
> +=09duration <<=3D airtime_mcs_groups[group].shift;
> +=09duration *=3D len;
> +=09duration /=3D AVG_PKT_SIZE;
> +=09duration /=3D 1024;

On an earlier patch of mine you expressed concern over divisions in the
fast path. Does this mean this is no longer a concern? Or is the
compiler doing fancy things with the constant division here? :)

-Toke

