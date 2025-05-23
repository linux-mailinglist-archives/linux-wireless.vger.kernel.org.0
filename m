Return-Path: <linux-wireless+bounces-23357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3A1AC2244
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 13:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC23500348
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08062367AA;
	Fri, 23 May 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p6lJZwo2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEB15D8F0
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001539; cv=none; b=rU5QfzEXq5C8NdJziND0QkdOvMOl6qxTEP+IsYL0htGX4JHR0o+qjOd8oxRh5aVp51YKtLORD0eC6akz77qRIQWtY0LmqSlp7OYSw8Doc5BWgqdJD6kYhme5PNWAFdS5QfJi7STS+lWrKHGDtvHTfGAQlZ8AJ38YX5IrAhC07v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001539; c=relaxed/simple;
	bh=gUNupGepM1WVSMap8KXNT9bP2CjzqWLKV0ztkGjCTRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XXtl6IVordcOa3C2ktW6DtTm2rXmXAaMmPWws+g9SyNvkxknrBwaySos+cspHEs+RIHrKJUZoCPqxanbS78oqN/+8afhq1dSTA5dPHKQUTkw0aby9Yn42QtcdjcsGlF0g95ckZjOCWi96n0+uy8gtwDaUQNUDxdqn8wqIDwEqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p6lJZwo2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N50Jjt023047
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=a+4rMuTii1JkiDDuWIDdg9QzjymHuS15HI2nOtnUfsg=; b=p6
	lJZwo2lydkJBpExQQQo81zznQeUevqhYah8I2NzYlr5qBRzwD8BtxS6nOS2Lpw7C
	LZOLu+kvkGuJnbo9n7Sg5QRxU1pvYeLbZHmsWAh7mLqolGNgHdVRBmi86IShlF10
	UX+ygSA57YFmGkVOXe8JTuCNzjIchCW1QYUpd3sjLc7+WmTVeT/LEV+CdY0hxnTH
	iL0+0eCLX9zJjmsbZMs8bUQt0MmjN4qkgKzQ1QLHO3GZNG/+wLJ6y/+O0tQFjVJK
	GRwywylu3pUAextVzwhJVeplfoncCpUakNy/AI0GyGyQ+eUcLE35YmF2vLt7gvXE
	ikANDS7ITxm/84eacYUQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf51tpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:58:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-231e059b34dso48769945ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 04:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748001535; x=1748606335;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+4rMuTii1JkiDDuWIDdg9QzjymHuS15HI2nOtnUfsg=;
        b=DvId/IsGWt4a4z1YkeMkTzCiebZTJ+4cKy6K1VvcWAxLtmAqb5uX74eBx9qpmDR8Ny
         xndmbRs1b3m361NouS6JSt26hX6BYlL7cPLKxS5ivE2o4Hhp7RAwfOPYYDp/ZByW7Nlm
         rLJUIOftWhBiYRyZuyoLucr3orO4mGxbryrDS2MnkYYXuoG2TU1xjIWYARHwI8P8wLqT
         i5byKQaQcFi08+r0M4YhnzgBkgqysLLZTjt9BDAsfjLMnBt2/J9oPuxwJXCZAoiZXwIA
         fdSmGkvR+wNGGVCk7oEEGP1BhYAEtN9j1hWSrJF8FKgSdnc3d8rh9pjwv0IMQYrpglaY
         TA/w==
X-Gm-Message-State: AOJu0YxrXwQy5MVMdlqvpIg9VFeoQHKE8+mTdk6kjs41QrxHfcFaeGhB
	TMnAg2eTgt9sny0EjLRrQexxBCa4j887R8bx1aW3gM7/jtUxZG8dzzF9ACcHl25B81Luzyh10vr
	UGHD4+cnNTSvVjkuo2Sg8mRTq6qXxv33pnpp/gzcAA8UUvLO7iz8y2JmSFhTTWSQjUmtq1A==
X-Gm-Gg: ASbGncs8dCSFaUVZr3xuQ0b+LnenQecH+HKHlhH11K3iRMgmKsHvLI/xwMIStaRI/s/
	d3/Zc8VKWcKAwJxorLslDNlA/R3v/340X20+9uDEZ9ORYhPR8R2H10Ouq5dRJB9zwxKwC/DKNNs
	BJnB6p1zFY6XtwmQswwLKjA4LsPXPMKQLvJnYQ2OHpYcIJdaKlbUdPzFOm3bIiM1vqeFlDTHjvc
	298yM25QTD8POfW9mRz09j2pc3V3AK5sPIdH3Ww39pHLxnRg2HSmgNRWHpJr3wudDLlFCxx3iDq
	mycfEDKMmXq1vJzGOGJ6e4PeG0kFbHV0hYzG2TPZBTrD7siBQN+1lqmO1ky3ZteUz8ws9ce8cFZ
	vSTlsnbus8A9wAj/aliTpqJPmy4GT9ACMmRqXWJabq46CxQ==
X-Received: by 2002:a17:903:46cd:b0:223:54e5:bf4b with SMTP id d9443c01a7336-231de36c29emr402176245ad.25.1748001535397;
        Fri, 23 May 2025 04:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0W0FLwItBMwzY4Lcx0KGn5zBhb9zVUj9WBY6KUcTfKCntRnRPHoVllcd5BIgNWoltXY97HA==
X-Received: by 2002:a17:903:46cd:b0:223:54e5:bf4b with SMTP id d9443c01a7336-231de36c29emr402175925ad.25.1748001535029;
        Fri, 23 May 2025 04:58:55 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233f9e17e3csm7210725ad.177.2025.05.23.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:58:54 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 1/2] wifi: mac80211: update ieee80211_rx_status::freq documentation for multi-radio
Date: Fri, 23 May 2025 17:28:37 +0530
Message-Id: <20250523115838.481402-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523115838.481402-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250523115838.481402-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: sMSULzkgGzgyMPyiINJSmohcgekyZE2J
X-Proofpoint-ORIG-GUID: sMSULzkgGzgyMPyiINJSmohcgekyZE2J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEwNSBTYWx0ZWRfX3ufnJ8gZz219
 LvtnOU65daA8/TF1R85868BHYw8hMVebH5QyaUudhZm6Go2umtvpoylMSeKqr+L6dG4Bxx93ed7
 pQeRpZi5SDgds3ZOQSB3d0fq1P4zqYm8IDzklc2yyjuzdC0ow3TF790Gk/PaQcj0oKnuVfVZMnU
 G0zWQc/iUA0GRPtF+1m28yqcPIAjS/eNa/38ZUDP39xD6tjuyfYB771dA5u+5+gDcJOnkEnM9f7
 /WGVUyP5/A2V5xdtKx3cknvj6BC/2rJKs0RwCD5b/BHSSHbj2+8f3fLr8pu3lbGL/uAFv3n3xlL
 WZ/RsE+ZKgy/TQIcBJCESHmMLLPNRPT7/BLkFP73JLBibrER5jPy8ZeNHbelrxJfGeLxH4Xs7qk
 MN+b6A8P3noqS4TJksBcCiBLbF0AoBDnabFnqoJGYQ23TgWivEp51AyaFIDLGYifcFhhHPFA
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=68306300 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=G3GIQwjkmUm1iQ8NZroA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230105
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
index 82617579d910..9212c2089638 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1612,8 +1612,10 @@ enum mac80211_rx_encoding {
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


