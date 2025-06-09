Return-Path: <linux-wireless+bounces-23834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B38AD163D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901D016A208
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D620EB;
	Mon,  9 Jun 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MicA5wEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDD8F40
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749427863; cv=none; b=M0sMRXS8wDl22oz14uQYxzr05e0p8pnF2dFUONcYUa9GLWU3TnbaptuPp9R3Ptg+clvav8rywlW/Pf2nPa2os2sUp2DgLTQe48vv9sUYffy+CtoOBuDhm3DjCSLIROmUB6yYw9SFPpbT44MJgdfRm+JaZQU5ZpAup6It8mePscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749427863; c=relaxed/simple;
	bh=+uEH+RsDs6PX992Gbo7a2cJgUHjBlgUaRl2xMaUCTGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f32RpJOe4ycvL/WXv+7whl5QNA7XB84ySSMH1uyICzwj5gD+81bsGMNidihV1g9MyxDscpem2xZ6iGsp9WCuXX6bHg1nOrW/xA0kF7J0sY8aqVBaL8MdiC9Y47s6vazIKgBZ1gF6exF4dZB9YhEoTSVDVCZT7WwUXI1CrFXc+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MicA5wEg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558MUjDg030063
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 00:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P1EmRpD2npRNqGpUwjI27WjLXqjYKB6qqybJcEPpnv4=; b=MicA5wEgEWoj6jet
	rs/iHA5F3I4fE4UPGxhnPYNslhghWl6ebhjqJOaY7RlfTf8VOgVrbpqXPffStkiB
	d5cm5eL6pKMlZmw7GVVYGdKPITv6bayOWS/6YokSI10JVSKp6EBbRv3KQ9fwgPfk
	nrh4a97l45JZoGpcDOmzWLA438q2DjlzVc6cA5cVRozB8zesYIWbf9xxE6JFvKKV
	qZl8c6Y+7J9IHAmirWFd+h5OCAygEOrB9FkhI/AXVkvp4c3nbMcjlfI/81SgOG7D
	2slarpdCc9cINAlL6KbGeevibIaIFDfvfDvxVNYYp7GA029Nxl9oPlTq5UmtTjKM
	wLTUnw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dt9mav2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 00:11:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311b6d25278so3541780a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 17:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749427859; x=1750032659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1EmRpD2npRNqGpUwjI27WjLXqjYKB6qqybJcEPpnv4=;
        b=JDkuPaldK/s7NtVsvg3qxhLmcNmVsTVTMw8xlloe3zzOLpWfL2HaN1CACF5UZyht8P
         mCu2ToN5Q6XYRs9baM2ZyawIULDovTGNzyb9TUqULbQbQfjPsC988L+WUrYJxSc0rreA
         vrzmwKho6fuCVvZWfUNlrAgRKNQvwXXIwwgHTH93bw8GBvVuTGFqRHgNFMfdu0xP6VXV
         mJ3STP12shI7SAXOAS5bBr+i7tcKOF5iUuo/U1ccq1L7moWetgzVENmhKivlF/3nCqus
         gk6U3PSQGhHm9z2/pf9oAhRqMxf2yQmmrO6h2d6K2GQcb3TGhlvSbLoH1c/D0OldkeQx
         7j7Q==
X-Gm-Message-State: AOJu0YyeRd63EVHyHaqX9JYy1seltNPrDzU9I+WdZj5ksKk88ZthiVng
	asjtkVQXd3QyN7h9zxMjSArYVtgkDvYhE4aFzA5oy9T0fLa55bXEcGnidBKY6O8onHblqcOWqPC
	k906ET6TRCm6Jq9+FPcUkN/50wB0S08eWcdXXq/dbiR5juf1yVhpJA3PTCe3o3x4R0Ba09Q==
X-Gm-Gg: ASbGncuLq0nyC+dKGQAXCT3FpK3HlrJLAfkQYlzrohbNohAtNb3d3NxNHhsHIsmx0aU
	d3iEYgp0xoAiZfiLJUbNOv32LnttcYxqGXsTDGERNUcBXal41rMPMSQk8Cm9AL3kNdjv3dqgcy0
	43yLaK6XEeO3CWWx54xTZN/sc/vAqQbKMgxT+DyCsrrEN7ZUuQpR+sDX9XPupUDOd6FmUaZIxWF
	X8EVdOs3yf6mS6KcK5FnTx8Oh4hQcfJbLjxkQQq/M0qObsLo0CyvRFGy8So60fn9HCBzTgM1+Uz
	ZQ+QwbiefMRhQfap5fWKg8AU9UOvsTc1me4A/J5QS9mT+DFkHSip0tVvs9FhGKGw4C2J0XqigCg
	xGP6qL6ePnGFc9LypGS3UkhAMwwOD3TJW9RBKGqwu
X-Received: by 2002:a17:90b:2f8b:b0:311:9c1f:8524 with SMTP id 98e67ed59e1d1-31347308561mr17256526a91.15.1749427858772;
        Sun, 08 Jun 2025 17:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf/r0Krf3hPhdgF4Y9krR6qZUl1T8YlKxxhKcWEiMCI81N7H20/OqAQvrHMKwi13aN0C8YlQ==
X-Received: by 2002:a17:90b:2f8b:b0:311:9c1f:8524 with SMTP id 98e67ed59e1d1-31347308561mr17256495a91.15.1749427858248;
        Sun, 08 Jun 2025 17:10:58 -0700 (PDT)
Received: from hu-rkaliapp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034059cbsm43731235ad.165.2025.06.08.17.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 17:10:57 -0700 (PDT)
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
To: johannes@sipsolutions.net, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: Add preamble puncturing support for mesh
Date: Mon,  9 Jun 2025 05:40:47 +0530
Message-Id: <20250609001048.2263586-3-ramasamy.kaliappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
References: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KpNN2XWN c=1 sm=1 tr=0 ts=68462694 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=guqm4oZRX9gV8awLTVoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: JrjOH_HeRBw-s_7uoy97QIjx_KgvNrsb
X-Proofpoint-ORIG-GUID: JrjOH_HeRBw-s_7uoy97QIjx_KgvNrsb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAwMCBTYWx0ZWRfX79xyiCHcy4qw
 vsAX4w1MwzObByTCtswrD4Jwc51Iti19S0BKXOk1xGjfyKw4gya6aiS9GgD1nQyxmJc5s623wlE
 +RvREcTp9gbIXHoOOr16CIbufzN04mf966xuL00LmI3UlF07B7CbvEvxNu/47I8QzPIb8TkH+cd
 zBO0GHnuX88f4dmBDA+uqx7Q4K78gD0ak+XKbbz+69vnTtSl+9imXK49b81UphhZTCIM1z1kfnE
 rR9Co62tF4Xui3UFyqSBJWCkJg3WyqI10BE40z+18hugzpyoqWEjs5mVAfESqdNETfTASIlvLY6
 /COJq9sEJq72GiwhwEgQs4wSLMv+WDsPlwWzbajJQqiVl9o+6xzW3JuGdDm91ebkYz+zfV3gdA2
 DJhW1x7O9K+7Yl6Cp0AZntQVEJBySBEHzV9rC0ZU54Kea6p80PIRWcIA17qBHFx5H2JZS4wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090000

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Preamble puncturing(“Punctured 242-tone RU") refers to the
transmission of a PPDU in which no signal is present in at
least one of the 20 MHz subchannels within the PPDU bandwidth.
Puncturing might be the result of the unavailability of 20 MHz
subchannel(s) within the PPDU bandwidth, such as a busy channel
indicated by the CCA or the setting of the disabled subchannel
bitmap field (16 bit field) in the EHT Operations element.

EHT disabled sub channel bitmap is a 16 bit field where
each bit corresponds to a 20 MHz channel in the given bandwidth.
Bit 0 corresponding to the channel with lowest frequency.
Bit set to 1 indicates that the channel is punctured, otherwise active.

Userspace may send the EHT disabled sub channel bitmap via attribute
NL80211_ATTR_PUNCT_BITMAP in frequency params as a part of join mesh
(NL80211_CMD_JOIN_MESH) command. Validate the received puncturing bitmap
and copy it to chandef’s punctured bitmap for the mesh interface data.

Build the mesh beacon's EHT Operation element, including
disable_sub_chan_bitmap_present and disable_subchannel_bitmap
based on chandef's puncture.

Validate and update peer mesh stations puncturing bitmap
in local structures while adding new mesh station
(parsed from peer mesh station's EHT Operation element)

Add changes to allow mesh peering with stations that advertise
different puncturing pattern than the local station, and determine
the bandwidth for each peer mesh.

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
---
 include/net/mac80211.h    |  5 ++++-
 net/mac80211/cfg.c        | 19 ++++++++++++++++++-
 net/mac80211/mesh.c       |  9 +++++++++
 net/mac80211/mesh_plink.c | 38 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/util.c       | 15 +++++++++++++--
 5 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 82617579d910..fc3fcd3c3ec8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2435,7 +2435,9 @@ struct ieee80211_sta_aggregates {
  *	notifications and capabilities. The value is only valid after
  *	the station moves to associated state.
  * @txpwr: the station tx power configuration
- *
+ * @punctured: Preamble puncturing bitmap. Each bit represents
+ *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
+ *	Bit set to 1 indicates that the channel is punctured.
  */
 struct ieee80211_link_sta {
 	struct ieee80211_sta *sta;
@@ -2456,6 +2458,7 @@ struct ieee80211_link_sta {
 	u8 rx_nss;
 	enum ieee80211_sta_rx_bandwidth bandwidth;
 	struct ieee80211_sta_txpwr txpwr;
+	u16 punctured;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..8caedd353796 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1948,13 +1948,30 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 						  (void *)params->he_6ghz_capa,
 						  link_sta);
 
-	if (params->he_capa && params->eht_capa)
+	if (params->he_capa && params->eht_capa) {
 		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
 						    (u8 *)params->he_capa,
 						    params->he_capa_len,
 						    params->eht_capa,
 						    params->eht_capa_len,
 						    link_sta);
+		/* 802.11s mesh STA may have different eht puncturing pattern,
+		 * update it here so that drivers can use if needed.
+		 */
+		if (ieee80211_vif_is_mesh(&sdata->vif) && params->punctured) {
+			struct cfg80211_chan_def chandef;
+			struct ieee80211_channel *chan = link->conf->chanreq.oper.chan;
+
+			cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
+			chandef.punctured = params->punctured;
+			chandef.width = link->conf->chanreq.oper.width;
+			chandef.width = link->conf->chanreq.oper.width;
+			chandef.center_freq1 = link->conf->chanreq.oper.center_freq1;
+
+			if (cfg80211_chandef_valid(&chandef))
+				link_sta->pub->punctured = params->punctured;
+		}
+	}
 
 	ieee80211_sta_init_nss(link_sta);
 
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5cc56d578048..1edb4bc9d635 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -112,6 +112,12 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 				       ie->eht_operation,
 				       &sta_chan_def);
 
+	/* In order to allow mesh peering when peer advertising different
+	 * puncturing bitmaps, update the local mesh punctured bitmap
+	 * with the new mesh peer punctured bitmap to ensure compatibility.
+	 */
+	sta_chan_def.punctured = sdata->vif.bss_conf.chanreq.oper.punctured;
+
 	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chanreq.oper,
 					 &sta_chan_def))
 		return false;
@@ -672,6 +678,9 @@ int mesh_add_eht_oper_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *sk
 	len = 2 + 1 + offsetof(struct ieee80211_eht_operation, optional) +
 		      offsetof(struct ieee80211_eht_operation_info, optional);
 
+	if (sdata->vif.bss_conf.chanreq.oper.punctured)
+		len += sizeof(sdata->vif.bss_conf.chanreq.oper.punctured);
+
 	if (skb_tailroom(skb) < len)
 		return -ENOMEM;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 9c6a2b342170..5fde9d6ec1f1 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -430,11 +430,49 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_supported_band *sband;
 	u32 rates, changed = 0;
 	enum ieee80211_sta_rx_bandwidth bw = sta->sta.deflink.bandwidth;
+	struct cfg80211_chan_def eht_chandef;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
 		return;
 
+	/* 802.11s mesh peer may have different eht puncturing pattern,
+	 * update it here so that drivers can use if needed.
+	 */
+	if (elems->eht_operation &&
+	    (elems->eht_operation->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
+	    (u8_get_bits(elems->eht_operation->optional[0],
+			 IEEE80211_EHT_OPER_CHAN_WIDTH) >=
+	     IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ) &&
+	    (elems->eht_operation->params &
+	     IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)) {
+		struct ieee80211_channel *chan = sdata->vif.bss_conf.chanreq.oper.chan;
+
+		cfg80211_chandef_create(&eht_chandef, chan, NL80211_CHAN_NO_HT);
+		eht_chandef.punctured = (elems->eht_operation->optional[4] << 8) |
+					 elems->eht_operation->optional[3];
+		/* Validate Peer's Puncturing Bitmap and reset if invalid */
+		switch (u8_get_bits(elems->eht_operation->optional[0],
+				    IEEE80211_EHT_OPER_CHAN_WIDTH)) {
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ:
+			eht_chandef.width = NL80211_CHAN_WIDTH_80;
+			break;
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ:
+			eht_chandef.width = NL80211_CHAN_WIDTH_160;
+			break;
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ:
+			eht_chandef.width = NL80211_CHAN_WIDTH_320;
+			break;
+		default:
+			eht_chandef.width = NL80211_CHAN_WIDTH_20;
+		}
+		eht_chandef.center_freq1 =
+			ieee80211_channel_to_frequency(elems->eht_operation->optional[1],
+						       chan->band);
+		if (cfg80211_chandef_valid(&eht_chandef))
+			sta->sta.deflink.punctured = eht_chandef.punctured;
+	}
+
 	rates = ieee80211_sta_get_rates(sdata, elems, sband->band, NULL);
 
 	spin_lock_bh(&sta->mesh->plink_lock);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..442def202cad 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2850,9 +2850,13 @@ u8 *ieee80211_ie_build_eht_oper(u8 *pos, const struct cfg80211_chan_def *chandef
 	u8 eht_oper_info_len =
 		offsetof(struct ieee80211_eht_operation_info, optional);
 	u8 chan_width = 0;
+	u8 ie_len = 0;
+
+	if (chandef->punctured)
+		ie_len += sizeof(chandef->punctured);
 
 	*pos++ = WLAN_EID_EXTENSION;
-	*pos++ = 1 + eht_oper_len + eht_oper_info_len;
+	*pos++ = 1 + eht_oper_len + eht_oper_info_len + ie_len;
 	*pos++ = WLAN_EID_EXT_EHT_OPERATION;
 
 	eht_oper = (struct ieee80211_eht_operation *)pos;
@@ -2904,7 +2908,14 @@ u8 *ieee80211_ie_build_eht_oper(u8 *pos, const struct cfg80211_chan_def *chandef
 	eht_oper_info->control = chan_width;
 	pos += eht_oper_info_len;
 
-	/* TODO: eht_oper_info->optional */
+	if (chandef->punctured) {
+		eht_oper->params |=
+			IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT;
+
+		eht_oper_info->optional[0] = chandef->punctured & 0x00FF;
+		eht_oper_info->optional[1] = chandef->punctured >> 8;
+		pos += sizeof(chandef->punctured);
+	}
 
 	return pos;
 }
-- 
2.34.1


