Return-Path: <linux-wireless+bounces-22235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82007AA43B3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 09:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E848C1C011F0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AB1E1A16;
	Wed, 30 Apr 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLS0f9k6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09281F0E29
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997440; cv=none; b=bfRxtZieTLoEf6NZrt9Pl4S3Hd53Dy4BQNT1TSO9yp4NOuiGmN3fNJG8i5pbKMTUFZlo3dv4biAMdjtEm0IXFmCO4DXmZbjHOi1eqIcfnSH+cb1Ogzg64TqknIVmlJ5vi3fifp2UClrsl4EM64wa5n/oTkWCbqbAzst0X6mebto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997440; c=relaxed/simple;
	bh=4TK8HQIj15lto3+ClS9HxZpmVYILZ28BbhRNrai4rp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gOTZDesHoxfEGFJoxuxMCo6fcqkU8fFQTW01+wZulynxY1fo1AD5cYmejFEKDz58vlUp0BfpSrWamvtLHmV4UEXh3o9JCAgfhbsqBt059dy4SKbW+0vkVfyJOqFUTZ0OwQDAaVDIN+4YBh+qsf/kFDvHqxwqblK1yLo+IsBlv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HLS0f9k6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLb8ZO011115
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=fLmXct3wLec4zgJMIrLjV0KKLjKZ4+N8Foh4JZVS7wI=; b=HL
	S0f9k6Vb2n69GPfDu9OJ1LrwRApS8CCDyWfrjvxdznvBe/2xnYILmsFpLXiay6X+
	Yg9StoK7Y4MVXKZ02SBtPGHvut7430jLAJH7fzzV4sf0yAOBp6X4xBNkg9aekjcK
	jQcJpEgFkgo7UmCXqm2nM4U24+UUpt8KucyY0lhbGT8g+PKBwY62m10ZyTFA7Bg6
	YkArIYUwcdTpnKRZxZzFoNeJMarUo3HxpKjakG9WS3tgqNbctyGN4QbvyXI2F9iF
	Czma0VngeZROyzsy6hl4ctmPxbH9BH93mGN3KImxF+rLTFriFaU83psSB8ZvzVk0
	x2dAB09Du6eyY9FI2wKA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6uas5pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22c31b55ac6so120075495ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 00:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997436; x=1746602236;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLmXct3wLec4zgJMIrLjV0KKLjKZ4+N8Foh4JZVS7wI=;
        b=HA7UQndxqghGZWFYG6nowGUBnQ4J32mr6Jh/xx9X7fd/UKu9CdEDbLBcJzmFN4ox9G
         HCugRk6hOsy+CgWZGbfGdmAd65HLCEbofgBvSrZrnotph8bKSAZzSVA3Z2Z2A3j4GgSL
         uqqOQW3iPXAX80taBYza3MKvQovVTM1pUvjIKHDcf7h2VgaJzmHWa0D++7w9vH3rcxO7
         MTJUcC8o0e3agVUyKLgwzLBzg4jwKXQaHMisjhBylq/Kl2a2ey8jppEWi1IanYDD15SE
         YZk+WLhwdbbP705UeJM8KPzJElJt/b9jA3/hJIB9f8cH4RUbxi7UZs6194P/upq4mO0w
         7NXw==
X-Gm-Message-State: AOJu0YyxpRNfWZuBq2xEJGyNTaGIPTnRoObThkVUPilwG/285Xd92uYN
	RGLNI/E+th8h3EdWcXlTaSZXzsHlsFaMWQw/CLhw+SZGibCGX7o8XP915pifboPl59wvwrjcy3+
	D6ws7zcLMQmoh1wDCKy5Ne+AVUT1oVBWSKxI/OBVEpDt8w2HS6tYFXSeCIbpngGYDh1zvduVMqA
	==
X-Gm-Gg: ASbGncsdScR78jmxgY5Besaolmqk7ooBomYLN2C2rzq8MajC61KTOJQKaKuAjGOOw/N
	dblYQvlByZRlgb3erradyXzpYf49cwnFIGAcubmzadPazJCMIJwOQyWAIaIA2OKdswZLFM2H6Nl
	VpKwAeRkCdsBGOWyDZPlDrr61SAta3Td15gM2Qak/msHja3V/Hv06LcDqm+iuksImyplgUHhyFV
	pJVNa4B/K2Ucy7vib8EAHHj9yoyhaJnr1V2xxu967n06OM2f0wo4TPd7lP8kgGgNfHI16MNVz+D
	Xz/v5T1tZjstIjxiBCeWeJCnHNj+dknVqAFEBOUjAsOxnZTybTYdb5k1upeAJzKD0MdvdzOZZzr
	JgNHfCL79rcHTrJ+G1g4YrG9SZBRjHPg5GnwDlpDtyuU31Q==
X-Received: by 2002:a17:903:1a03:b0:224:1ec0:8a1a with SMTP id d9443c01a7336-22df35de9cfmr36413775ad.51.1745997435715;
        Wed, 30 Apr 2025 00:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG5O150Af6by0DiKeXL0Yn7sF/JTBlEhU3pS2GzwwfRsKDOOYt7r64DAe18Me2MZoiqa9oAA==
X-Received: by 2002:a17:903:1a03:b0:224:1ec0:8a1a with SMTP id d9443c01a7336-22df35de9cfmr36413515ad.51.1745997435336;
        Wed, 30 Apr 2025 00:17:15 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc70efsm114817915ad.95.2025.04.30.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:17:15 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next RFC 2/2] wifi: mac80211: process group addressed Rx data and mgmt packets on intended interface
Date: Wed, 30 Apr 2025 12:44:35 +0530
Message-Id: <20250430071435.2201777-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: lfAvYyfk1YmcwPUKcI3-CaMse41_wxt5
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=6811ce7d cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=OUs3SMZUshvc0dJ8bIkA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: lfAvYyfk1YmcwPUKcI3-CaMse41_wxt5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA0OSBTYWx0ZWRfX7XCMPaIM+Lfu 3fwHz7F8v1GELITNVOUhZ2ZY1VUVoIHuqAkKp15Am/Ql24lFYpNuG5AVyjuJKMlY3/zyqyyik3h 84z1BFtyd1xniW12JoTSbqQwY+bW3ZiVtYaSfym9uLNftk9FRw1OVg56WPAcKmuaAYFTyrLCXmB
 NjT5ZKHFXswKocd9zadE4fC+hbAEmh8YGy21/hrvMYzSBSRzloAoGbCiVCbVqZrcH5sAi0PZ1VL 7Rn/OIXI80fD1HCQv/wNCBvjdMvytQrXATlJ+yXVLCSPAVuRef6uff/Xf9qxrKL3c7srBF1SCGa UJjsLwUp8NDPWut0KnW8vVVERFD/DclGHu2ZHnrhv2KOr0dp7QI0LsNI6gT/4w9hOwEfjbVXpeq
 rRVu4fXjmHB43Lfdn3K2hGitg1/R82Z30oN0OgAjGEG/E6HsEnI+z0pFueXiZrrTKMlLWsFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300049
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, in multi-radio devices, group-addressed data and management
frames received on one band are getting processed on an interface running
on a different band. This occurs because these frames do not have the
destination station information, unlike unicast Rx frame processing where
the transmitting station is known.

There is no check to ensure that the sdata is running on the same band as
the frames are received on before processing those frames.

Fix this by checking the operating frequency of the interface against the
frequency of the packets received before forwarding them to the interface
in multi-radio devices.

The current behavior is retained as a fallback mechanism when the frequency
is not reported by the drivers.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/rx.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..c28bb563ae04 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5125,6 +5125,41 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
 }
 
+static bool
+ieee80211_rx_is_sdata_match(struct ieee80211_sub_if_data *sdata,
+			    int freq)
+{
+	unsigned int link_id;
+	bool is_freq_match = false;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_chanctx_conf *conf;
+	unsigned long valid_links = sdata->vif.valid_links;
+
+	if (valid_links) {
+		for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+			if (!bss_conf)
+				continue;
+			conf = rcu_dereference(bss_conf->chanctx_conf);
+			if (conf && conf->def.chan &&
+			    conf->def.chan->center_freq == freq) {
+				is_freq_match = true;
+				break;
+			}
+		}
+	} else {
+		bss_conf = &sdata->vif.bss_conf;
+		if (bss_conf) {
+			conf = rcu_dereference(bss_conf->chanctx_conf);
+			if (conf && conf->def.chan &&
+			    conf->def.chan->center_freq == freq) {
+				is_freq_match = true;
+			}
+		}
+	}
+	return is_freq_match;
+}
+
 /*
  * This is the actual Rx frames handler. as it belongs to Rx path it must
  * be called with rcu_read_lock protection.
@@ -5264,22 +5299,34 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		 * the loop to avoid copying the SKB once too much
 		 */
 
-		if (!prev) {
-			prev = sdata;
-			continue;
-		}
+		/* Process the group addressed management and data packets
+		 * in the intended interface when the operating frequency
+		 * matches with rx_status->freq in multi-radio devices.
+		 * If rx_status->freq is not set by the driver, then
+		 * follow the existing code flow.
+		 */
 
-		rx.sdata = prev;
-		ieee80211_rx_for_interface(&rx, skb, false);
+		if (!status->freq ||
+		    ieee80211_rx_is_sdata_match(sdata, status->freq)) {
+			if (!prev) {
+				prev = sdata;
+				continue;
+			}
 
-		prev = sdata;
+			rx.sdata = prev;
+			ieee80211_rx_for_interface(&rx, skb, false);
+			prev = sdata;
+		}
 	}
 
 	if (prev) {
-		rx.sdata = prev;
+		if (!status->freq ||
+		    ieee80211_rx_is_sdata_match(prev, status->freq)) {
+			rx.sdata = prev;
 
-		if (ieee80211_rx_for_interface(&rx, skb, true))
-			return;
+			if (ieee80211_rx_for_interface(&rx, skb, true))
+				return;
+		}
 	}
 
  out:
-- 
2.17.1


