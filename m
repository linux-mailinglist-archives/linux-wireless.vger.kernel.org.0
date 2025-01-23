Return-Path: <linux-wireless+bounces-17862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1579CA1A515
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 14:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325123A1C78
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5100320B;
	Thu, 23 Jan 2025 13:34:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588920F060
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639243; cv=none; b=GAZDkhVrCWCl1fuvm1+0PqQ9KOi4m3MSMNODNqGjjNOAwMV2lk5bFwE5KGjwaVh7ykIzqt8BKr5cvGdn4nev2gdR+B92h9Z2fYnrsa9wJtaZKmn789aYu1hVbvkCoFFqvVA64lZkPlOH7muBr8LQDNHB/ri7LQmjASpWt0Y/P/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639243; c=relaxed/simple;
	bh=sIFKe8uIMU2FzPXU8NsPMnCqMcgfmT92OIHRYWor2Do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ixdFY8SuVmPsE2hrYT4owfzR/VFNyAuTSCPEd1R1ODS2uS5HiKLwKi48U54xO9sU6mH7K6orkkEHagGslssuiKkhNmkpFKX3FYDl5fs/gnYqhmqzEsZG/sMtgUDPyN8mXwEAz4CZ+IS/a8f+TpRlpegEHqsD4yuwR2cLTXiIHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id B5B07201D5;
	Thu, 23 Jan 2025 14:33:56 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id A7552200F2;
	Thu, 23 Jan 2025 14:33:56 +0100 (CET)
Message-ID: <653484cd0984e12dff094e5f9436ae4170509976.camel@freebox.fr>
Subject: Re: [PATCH RFC 3/3] wifi: ath12k: add EHT support for TX rate
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Date: Thu, 23 Jan 2025 14:33:56 +0100
In-Reply-To: <20250122133424.1226555-4-quic_sarishar@quicinc.com>
References: <20250122133424.1226555-1-quic_sarishar@quicinc.com>
	 <20250122133424.1226555-4-quic_sarishar@quicinc.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Wed, 2025-01-22 at 19:04 +0530, Sarika Sharma wrote:

Hello,

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case WMI_RATE_PREAMBLE_EHT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0arsta->txrate.mcs =3D mcs;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0arsta->txrate.flags =3D RATE_INFO_FLAGS_EHT_MCS;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0arsta->txrate.he_dcm =3D dcm;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0arsta->txrate.eht_gi =3D ath12k_eht_gi_to_nl80211_eht_gi(=
sgi);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0tones =3D le16_to_cpu(user_rate->ru_end) -
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0le16_to_c=
pu(user_rate->ru_start) + 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0v =3D ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ton=
es);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0arsta->txrate.eht_ru_alloc =3D v;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20

The logic to set arsta->txrate.bw to RATE_INFO_BW_HE_RU or
RATE_INFO_BW_EHT_RU like in dp_tx completion is missing here.

How about something like this ?

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/at=
h/ath12k/dp.h
index c3c607eae476..de2095ed8863 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1506,6 +1506,8 @@ enum HTT_PPDU_STATS_PPDU_TYPE {
 #define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M           BIT(28)
 #define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M          BIT(29)
=20
+#define HTT_USR_RATE_PPDU_TYPE(_val) \
+               le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYP=
E_M)
 #define HTT_USR_RATE_PREAMBLE(_val) \
                le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE=
_M)
 #define HTT_USR_RATE_BW(_val) \
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless=
/ath/ath12k/dp_rx.c
index eaec3949470d..c8d377544422 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1370,12 +1370,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
        struct htt_ppdu_user_stats *usr_stats =3D &ppdu_stats->user_stats[u=
ser];
        struct htt_ppdu_stats_common *common =3D &ppdu_stats->common;
        int ret;
-       u8 flags, mcs, nss, bw, sgi, dcm, rate_idx =3D 0;
+       u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx =3D 0;
        u32 v, succ_bytes =3D 0;
        u16 tones, rate =3D 0, succ_pkts =3D 0;
        u32 tx_duration =3D 0;
        u8 tid =3D HTT_PPDU_STATS_NON_QOS_TID;
-       bool is_ampdu =3D false;
+       bool is_ofdma, is_ampdu =3D false;
=20
        if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
                return;
@@ -1403,6 +1403,9 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
        mcs =3D HTT_USR_RATE_MCS(user_rate->rate_flags);
        sgi =3D HTT_USR_RATE_GI(user_rate->rate_flags);
        dcm =3D HTT_USR_RATE_DCM(user_rate->rate_flags);
+       ppdu_type =3D HTT_USR_RATE_PPDU_TYPE(user_rate->rate_flags);
+       is_ofdma =3D (ppdu_type =3D=3D HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) |
+               (ppdu_type =3D=3D HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
=20
        /* Note: If host configured fixed rates and in some other special
         * cases, the broadcast/management frames are sent in different rat=
es.
@@ -1479,6 +1482,16 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
                v =3D ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
                arsta->txrate.he_ru_alloc =3D v;
                break;
+       case WMI_RATE_PREAMBLE_EHT:
+               arsta->txrate.mcs =3D mcs;
+               arsta->txrate.flags =3D RATE_INFO_FLAGS_EHT_MCS;
+               arsta->txrate.he_dcm =3D dcm;
+               arsta->txrate.eht_gi =3D ath12k_mac_eht_gi_to_nl80211_eht_g=
i(sgi);
+               tones =3D le16_to_cpu(user_rate->ru_end) -
+                       le16_to_cpu(user_rate->ru_start) + 1;
+               v =3D ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones=
);
+               arsta->txrate.eht_ru_alloc =3D v;
+               break;
        }
=20
        arsta->txrate.nss =3D nss;
@@ -1486,6 +1499,13 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
        arsta->tx_duration +=3D tx_duration;
        memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info=
));
=20
+       if (is_ofdma) {
+               if (flags =3D=3D WMI_RATE_PREAMBLE_HE)
+                       arsta->txrate.bw =3D RATE_INFO_BW_HE_RU;
+               else if (flags =3D=3D WMI_RATE_PREAMBLE_EHT)
+                       arsta->txrate.bw =3D RATE_INFO_BW_EHT_RU;
+       }
+
        /* PPDU stats reported for mgmt packet doesn't have valid tx bytes.
         * So skip peer stats update for mgmt packets.
         */


--=20
Maxime




