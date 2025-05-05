Return-Path: <linux-wireless+bounces-22452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DFAA9220
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363063AD25C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE61F948;
	Mon,  5 May 2025 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9CmCQQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACA200BB2
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444990; cv=none; b=fXWcyyBFGDVXIFpajwAWv9DJoASLKGy2si6Erz9Ge2gL1Ug7YFTs/pzipoDzsu4ZhiugWtfY7/S7SPn6S8B7Ge7cRBGffv0fKRP08hNzTCQ7xpAsACHKSxWHov4vHwuiZda95ZHlACLG/aJGithRoSCKC/9zkN8s9b+rvOGYTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444990; c=relaxed/simple;
	bh=8SEyhfjP9X1MSbDm3ZIXz6Yar2UIACms5rw/jzfi8BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uw8wCD5hcmZk6MnV5YaS10P24yx5Y77s5jV16vlpu/lauyVlCSLP8M0ITlShMPKc2ZXYZn70hv0vPKPe1vXVlak42JNhOaTWJdKKA+HBipoWq+c03NSNDKRnhc7dLtdLoWnfqBTJfX7I/6UqmoKRuGgitEHCZ4TtezokgneBpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9CmCQQi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544NHl5K017230
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 11:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=Y86fPAmtKmnZHSfXMNDslF6qXxAkG8J/KBwFQmVGcEk=; b=T9
	CmCQQirrMPZyZoJzsuLSA5tBWYRtJajDHne4toA3dzT6BILnw/0lef6qfHnapRt8
	S8scG9KQAl9rWXyMpMDXp1npzYAVXlqcort3fHnwa2LSbEumzU+CcL6FVhdpEyxM
	W8+oh+MQ9CtcUA50p8xOavvsdqZO+vS1S+aqieHwkOhXA+wAtKm0YYxHU6/BHlvA
	dY2vXsc3l4MPXqxFuFKZIue+w3f9xPQTw9K14SO5qjEGmvgycuYFpPEzlOVtZYk9
	163DoZXeOu+xfKx7RaZ62pHO754S2NQW0qpXqa5IU25OMsXek7IZYo/jMUFb8coM
	elHUeM4ISe3JFp85JDWw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dd3n3u57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 11:36:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736cd36189bso6173370b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 04:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746444986; x=1747049786;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y86fPAmtKmnZHSfXMNDslF6qXxAkG8J/KBwFQmVGcEk=;
        b=EMYDZkghJbFiHt4jL/n4N15kOTNpxk0GWySGAEAwKuXOiouIx5yD1bA5LEDAXY5AX5
         FT4fTvENKxq6FaZVXmeg+srn2V18MU8ouK3g4PJTFVwtM46USjieV/+a9OdVMtJdgIwB
         yyxl//mK4dQAsawlk1umvPjdpghmfbxA5IAPWRtZdvLX6nYgd+SClzS7+t0SVSRhG8Be
         Qx/mRSiqfLGWBitTm/p5H8eQm8g0C3i3jCaNtG6Bw2UN4c+kY5u1LTp7k3O1CqJJo2nX
         bwoDkvtoC54cjvZDJgEy58RooDVzezyGcWSZlfw5EzB+vqHvlZHatU4wGCtGdLf/xQU+
         Yqjw==
X-Gm-Message-State: AOJu0Yw3L9GtfvwHYzAdgdcAg8yBKErPVp2BR5fnbWi6kBE6xl7cOAXR
	HRfKrCy85ANu6J/GIbMoJG3NiEhakBfA3uDlGzLC3wFbr2D+i4Btzeb18Wg03V8Y04HKrM0OcA7
	o6VkOf/SNtEZpSKs/sGbqMUu837HzSjRk3lZdvLiK/Qhf2YzwgCCoUqCA81WTXZzLHmFfacK3KQ
	==
X-Gm-Gg: ASbGncsCxH7ida3hpF9hvhjKiWTkmg+Dgdseir3N4o5WZc/YaAFbTTrZ2FqBq82usZ7
	lHheik1jBDkWFBp7ot6wKQOJOHpXM9YP3U856coDukgeaDn8Jp/A/ipXfEPoK8Mbr/Iv6uFCmZ7
	cwK/1cbv742V98B9H8BniwAWssdJiSG3Tv3BTgEnkBkqRS2fuU84N/wyibcY1wigxzx1LlCoBbc
	u6KQyTHcNHoMn7VZi7BlJRPm6OgYmawYg09Qo45D+EJbpS/UOmFvIbYtFzaaM5gLK9OXtY2aOyL
	ItivqDZBEXghzIVf4NRzyqV4WCF2tAK38vDHR/7dIz6BLbI9il7Shk6wUIjGR7kp6G/SDoHSMBy
	CBVvdfgrdTKH5XwQYYVL8YevR68jW7RG6cR5HnNgg8w4Hrw==
X-Received: by 2002:a05:6a21:c98:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-20e96ae46e1mr8402449637.20.1746444986251;
        Mon, 05 May 2025 04:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoJOLpKJ/OkKxf/NyufKD/iRcK7STotmKlly4YdOo8afr+2kQlzvAiqWq9hqRjmZWyMVI1Cw==
X-Received: by 2002:a05:6a21:c98:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-20e96ae46e1mr8402422637.20.1746444985896;
        Mon, 05 May 2025 04:36:25 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db9200sm6497067b3a.42.2025.05.05.04.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:36:25 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next RFC v2 1/2] wifi: mac80211: update ieee80211_rx_status::freq documentation for multi-radio
Date: Mon,  5 May 2025 17:06:18 +0530
Message-Id: <20250505113619.3654343-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250505113619.3654343-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250505113619.3654343-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDExMCBTYWx0ZWRfX5AxZQ/WqqDU6
 kTtX2bdlfIjb46AhgiO2NdFI6+eO/1ZALK8dbvSb1FwjUjNGtJvIBxC5M2fW0FMV7taiAPsGyyt
 gx5+yOjJe2yfoez61HpKmmK4a2GNfd8CtGGeVOUVA8hKB6n+TCnLbumM/x8atTmWQEYrsoSicSb
 APcfgE8Ik6R1ubD+0vgvahTtdQuzL3a/UQo/mYvQksWNQYC7QLmHoofpSHMHnWVlPulyjpL8sLC
 WiP0vsKg9qdxfkLHUd8aYO5upgYS1e0pEMZ56ge17pj5sBA7rvNZRBx73npQeKerRpHUclUNDKZ
 VHgfXGB8G2fXcDhXEla5AlUSizGpgyOawnTnz6vrhUEPh3lrkNTzDlXKK54lhu/9JF4cnSEag+f
 /5EFVeesIndTAY76JaaF22glBtmcN71ZerulPy2tMEvpm9dobOArnHfheZg989ZelikESdye
X-Proofpoint-GUID: Cz6yBsLRU4qGz5PJZaz-MDH0jAoJWnbW
X-Proofpoint-ORIG-GUID: Cz6yBsLRU4qGz5PJZaz-MDH0jAoJWnbW
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6818a2bb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=G3GIQwjkmUm1iQ8NZroA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050110
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

With multi-radio device, it has been observed that the group-addressed
management/data Rx frames, which are actually received on one band, are
getting processed on an interface running on a different band.

This occurs because there is currently no check to ensure that the sdata is
running on the same band as the frames are received on before start
processing those frames.

Update the documentation of ieee80211_rx_status::freq to make it
mandatory for group-addressed data frames in multi-radio device.

Drivers such as ath12k and mediatek(mt76) are currently supporting
multi-radio and report ieee80211_rx_status::freq in their Rx frame
indication to the mac80211 driver.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 include/net/mac80211.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index fdafc37d17cc..bbb39af4cc8e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1609,8 +1609,10 @@ enum mac80211_rx_encoding {
  *	it but can store it and pass it back to the driver for synchronisation
  * @band: the active band when this frame was received
  * @freq: frequency the radio was tuned to when receiving this frame, in MHz
- *	This field must be set for management frames, but isn't strictly needed
- *	for data (other) frames - for those it only affects radiotap reporting.
+ *	This field must be set for management frames, also for group
+ *	addressed data frames in case of multi-radio device, but otherwise
+ *	this isn't strictly needed for data (other) frames - for those it
+ *	only affects radiotap reporting.
  * @freq_offset: @freq has a positive offset of 500Khz.
  * @signal: signal strength when receiving this frame, either in dBm, in dB or
  *	unspecified depending on the hardware capabilities flags
-- 
2.17.1


