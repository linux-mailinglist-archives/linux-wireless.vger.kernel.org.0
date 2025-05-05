Return-Path: <linux-wireless+bounces-22453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC286AA9221
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 13:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3632218891CF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A90200BB2;
	Mon,  5 May 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m5yuYO65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BC204592
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444991; cv=none; b=Y1yPLzJ3GhIXWCdHZPjwYTS3TZjs5v4ZpUj6IH7V9xHvKOCwq7THKnqOt8sjN8/KjEoCmnuBMyeyLUQL9oJ2PmlZSaMc4XJAkan0SyQVl4O0XmuDp+ivHCYq+hxpl7VbWHqd0Wp3UZ3pmeNM+Bsljz4NXeXIRXT5CyBoZ+snLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444991; c=relaxed/simple;
	bh=tg9Z2/C7Cvlvx0J305uqJ8kQlYGc9SuOKtHSzPFzmPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=L6DOm8ZRebXOyQ3Epza6OrnoGPkieOpcQVX4IkCmSKUxbzd0hhx8P+ZWUyZ/ZDLND4mIbO1/OpsCKeUoCcQNWERyAp+1aSGM1nAJS2FmHcr2d4D9Z5m7XyjI8b2BOmPMZrowQYP+F+gxBkQ6C8J1vcpYE99l08smJjtlpaAs9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5yuYO65; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544LwJGi014092
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 11:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=Qq51XT7YYtig8sR6o9TZUSlLWr6Yl9WicUlD2R+enF8=; b=m5
	yuYO65EoMCUk55F3+PteBT/0Q27g3uTV82sct3Z1bxw+3Euq/1Zn0l2wxNJdicpY
	C6DMInOHXpk7O/GL5BD+zLZJ5AfPzORwykAgDuXO5BQ4gl3KhhSbIgXwDmL3DZJY
	g67XxqJvte0ZFvxfk4dZcqFL3OTNb28p9uvQhEiB/24LYqi1+qgKemAU3E063pUi
	vCh1YTXQm02Q2a13TmDVw7+mK7mR+yv31a75FfiAzgPc3x06YyXqZTjQO7l1z6YE
	jW7+0hTQThUhtRKMw9Vm48n7QqUm7C0ZhjN/fb1fNdFTkKoWIgpOClKkK2Obv/9o
	YUotIsExmfxgKuTHPCTQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46d9nkv209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 11:36:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73720b253fcso3286516b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 04:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746444988; x=1747049788;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq51XT7YYtig8sR6o9TZUSlLWr6Yl9WicUlD2R+enF8=;
        b=Add1BR3Yx6iZV+gK1SvnRRtOR4qqJmpWDoiM0WERcYNlal8VMdwAygdMxkgXZT75Yb
         ethXV71zph/WgF5qN2Q42O2kL/DkSjdGl/qX3r7pjZ0bOMcwiCePLPfww/nCQiERivOR
         /RRThkDT7AqMhyQd3nQZv0Tov/V/p64IU4c98JgXooufgiJjg7qfMkL6zaWWeftSWP9L
         DVVZTiTAWsxZf2nWrIGUm9ldjMLuaPKEhy8i+X69Mms9AXH0NfK1AT5Qk9KhMPwfak0Y
         zYvCIjqtC8hTb2qRL84j0ZlTHyJy1d8gqbcY1hrexnnyGsVRhPbSXd00FP9/X7Grrh+g
         brRQ==
X-Gm-Message-State: AOJu0YzDUrzW+ltdgM6/p40PFEmY4WW7Ty+Ab8vc4cFp5kn+Sz/DnZKg
	IPHMTYydo5NEYjl31sI10MK0cBa+cF0IZ4H+3cIhvKGL+KRe4IjLwgvlBpFf6130r4oI/EVDisB
	2xP3LMVjIgq+j+xuoDB2ozQ6GZM+IPHNFDky8YgvzKZq4YJe5xgsloY56t8kiPW1wSg==
X-Gm-Gg: ASbGnctE7bUbqC8qmHfpWsP/ABtDe3k0p0GZlCryZ0IJ/xsw2BsIckoBdrbXrxQleJI
	DINowCqNqQIw7LtF8zlzon4puNG30yxOIgciPE8WLYU+omo0QeD+T8my9cui1ylYTf93p4IB5zB
	1bp6ae7FBjxOLgMH++4ebwdUe2Oq5kR0uAIsv6sEYoyZY8SJWLcA8PZNkoM9IuEZ/GqJ5Gnqd9m
	k5JKiJod5/bmDPb9S0vEvs/2YU7KninsTgHgtcPxo4Xr5gnCeVN6Uhz+dmsYAyhc4QvgoFAtu0f
	tmmhcOhvKCI3UtEEbE4YVee53iqxROCpO5c93gCqP6A6NalE8p9P/LX2GNriXd2X8xq/N0DM+4B
	f6v2v1jDxFNzbNjTTrbnfl/Tkb4SqBOlTGypXHjN7J2ZLeA==
X-Received: by 2002:a05:6a00:808e:b0:739:4a30:b902 with SMTP id d2e1a72fcca58-7406f08b5ccmr9332429b3a.2.1746444988011;
        Mon, 05 May 2025 04:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/CJU+Q9tDRMDbB/CVYkiL73Ye5BxywuI+MtNZ4fq+E6hd1XEHoYA1w2mQQXAjjYC69+4bfA==
X-Received: by 2002:a05:6a00:808e:b0:739:4a30:b902 with SMTP id d2e1a72fcca58-7406f08b5ccmr9332399b3a.2.1746444987617;
        Mon, 05 May 2025 04:36:27 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db9200sm6497067b3a.42.2025.05.05.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:36:27 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next RFC v2 2/2] wifi: mac80211: process group addressed Rx data and mgmt packets on intended interface
Date: Mon,  5 May 2025 17:06:19 +0530
Message-Id: <20250505113619.3654343-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250505113619.3654343-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250505113619.3654343-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDExMCBTYWx0ZWRfX61lG5LrKB29g
 tQuG1/ENi1pPsS1w+Eq3SWNwiUdqMx8nX7AkWe68+9kWthe9nvTAmU2ad8gd0gGsfhBUw07o29f
 7RJxTtuOo0WduLhljoRKLHNSz7I4OprErw2cTSdWFxuEZlLq5DejQOH65ILvhO070LrRO7wGHky
 F0Nx06UJNmw60t0MMRc0qi/bfun5EgIIyXE03OhBhTzkoi+xkwEtRF9kkSzcYznZlPAq2uPD+1U
 gkhztBXTh4PfVavW6OMpADGo0ckyfAElfdyjTUgaKWoT9tqRipBpeKD+DOvzbcHgb7gHZZVulGH
 sssFL1eFnxNUPAxfzXt+X06KlQoRoBxeOt+Xr2WLaqFrmu2j/c7eGaWSSwGZfiVqmVYxQ7ssrqG
 4gSBol6ASxvOMzSxu6obKEKLbNJyMxXr5DSDXwQfN1oB+xm0MLJBfX13nxz5TGxN4P86XS8C
X-Proofpoint-GUID: V2nnpygY-Xva-LTouWtsirkF5BTOvYky
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=6818a2bc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Y7y7kotgnV_wd4PCqGcA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: V2nnpygY-Xva-LTouWtsirkF5BTOvYky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050110
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
 net/mac80211/rx.c | 48 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..59028c08dd52 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5125,6 +5125,30 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
 }
 
+static bool
+ieee80211_rx_is_sdata_match(struct ieee80211_sub_if_data *sdata,
+			    int freq)
+{
+	struct ieee80211_link_data *link;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_chanctx_conf *conf;
+
+	if (!freq)
+		return true;
+
+	for_each_link_data(sdata, link) {
+		bss_conf = link->conf;
+		if (!bss_conf)
+			continue;
+		conf = rcu_dereference(bss_conf->chanctx_conf);
+		if (conf && conf->def.chan &&
+		    conf->def.chan->center_freq == freq)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * This is the actual Rx frames handler. as it belongs to Rx path it must
  * be called with rcu_read_lock protection.
@@ -5264,18 +5288,26 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
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
+		if (ieee80211_rx_is_sdata_match(sdata, status->freq)) {
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
 
-	if (prev) {
+	if (prev && ieee80211_rx_is_sdata_match(prev, status->freq)) {
 		rx.sdata = prev;
 
 		if (ieee80211_rx_for_interface(&rx, skb, true))
-- 
2.17.1


