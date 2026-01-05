Return-Path: <linux-wireless+bounces-30344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2CCF2345
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3ECD300BA34
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1422BCF68;
	Mon,  5 Jan 2026 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YKY4hbN7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NqmO0ac3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B02D8DC3
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597915; cv=none; b=FaCWOJQwM8YOcys7ird7eEAtxGJBJGQ4Dzi+RzTeljz7FeEdwkpdtjBJNeFkIwIPP35C8L4bWFSzvYV+tRUaXfpG4Uza+f5U/m7q9glImoW7dcTyOLtcqt5W9V8baG974/ZeutaUXZ5lvtGFyLcGp7VpPmsoXyIS9//vq+P//dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597915; c=relaxed/simple;
	bh=84zqECf+2cCwe1xfCyE5Ocbh6kpDZai6vUViJD5wAEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXwYAK1M6jGtA15BOHh2eg/9GqYxchfUV85ZKIo+808mOzZEOlPb9s3m+SXJ7KBbkadtNc8todrbXwUkckB3c3o1Z6H+qdjBs/pYXlmHprrmlpQ+ngTOStLuY/SjubyBjCSMHQI8dEVypDq+PNafl9t8OgcVNgjutT5LbD+viyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YKY4hbN7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NqmO0ac3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604MFLhB3959888
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QlDNjj7M0DuTFDuEnE3mXGP/nRXMqxQXD5r1RMWOAfo=; b=YKY4hbN7I6kycu34
	TrXpl7wtbbavVdUa+RXHHEIatSjJiHujoy6joH5rcekoamdMluh8dlR38NrZT4VG
	o10NYcvFhqe7RJ5gbmyRxoS4QfhP0JC0PRTxXRSYUR7MeHiUzLf3yHDgQjOuN4Gm
	0KVrI03yYd5cpmP1gxvqeAXYN9tekGT9Fd6Rd5w1GQPRpNjUCAfzcXdMbWTkPPoc
	WZWSkwQ2LuooMzIYlZVjv6okAIn9/InX+0Af/Qo4XoI5ol07LT5O5R3+BV9D0yr7
	Vustf9jBTzkq8dpgC3SsKBo8TJLAU7aqVQqqAj1FMzb8lfBcbtHIJFAVQvkMr1GT
	zpZErQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bet463np0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso480350915ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597909; x=1768202709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlDNjj7M0DuTFDuEnE3mXGP/nRXMqxQXD5r1RMWOAfo=;
        b=NqmO0ac3joIkrO7J8DTUC2Gw+69J0+2bMD5AmMJreOY/DcR3DDBHvS6egUfDKM/alV
         oObmFlV1MIe6BhSFGkXmSj9kPXwE7ZGjv5z7ii4Bhaoqxi8DKg49+tZv18I4Jjh0zjX+
         2u+3m40rkHz3iey44o3JhqCyzrnlQNO0le8JMbCS1kN/kecy7sYq9imMmtxmnLWiaycj
         hHn5sEekkCaHzOBpbHHfIbaYy/OGDf0yJvW5SDpPVlmz5zISYrIDQmz8EQm0m81z1TsQ
         /hF6T6rEmZST3t7PEOe6b02Inh/EdIxS3mDvgttOA0rozYdyNA+zf4azANuC/CYylUmH
         y7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597909; x=1768202709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlDNjj7M0DuTFDuEnE3mXGP/nRXMqxQXD5r1RMWOAfo=;
        b=hryQG9d+EOdQYZLPLhuZ2X4Ijbm+XY3inp+lWBVAKvhmMHMqLgRHeqEtwao/npcl3W
         r0gPbfxwJ96mwXsyRR3Tv+07BkqElgTIDxpY6P7wvAcIut7gudvr3AUbzwNV+kOgtHE9
         PgtsJyF/nvhxuwc5EwqbfwU9E7Hy9F6kF76+w6xbodm6PetqB9haa3UVDAEepkr2q+8K
         4FWEtMLAiThkCbNM1V/s2bWGZ2oYcgjZHavDrsYd/7KpaVntVVoDsf3CnHXXLMQ3W5hc
         +afRs4GY+Rmqlx0LGGPp+XlM2LNtXKCNNqAEuMcgndAe8pSHbyBo+ekb9m67kmbTB8J+
         2tAw==
X-Gm-Message-State: AOJu0Yx00aZ6vp3aWBMYC14wpGtR7QnghDmO/Nt0hyLw1dUXQq6SQ01F
	uiujLAgI+8Sav83xRWQ40Ni7D2MdJxXwxyLopsj1xUElV8fKOM7IWN69Ox7mlIibk5Tus1o5/4B
	gisBciQrMiA7w48sPAsVL2yZx2mOMgO8sGNszpCSaYNljo0dB1QA6WQBF13X5mFzx9SbRlw==
X-Gm-Gg: AY/fxX5iPdQ0ArK8OWAeSCZsV9+DhWAJCWGhiZe4MyBFpSLhNyMKWi9SSv+9Oir/oA3
	FSmSKBBYBor/IFfNrjisk7Gzy4BVJqEva2RvtxOGQdECow91IWOrkSw2ziaK6Tzf7GrtPZUZP5v
	JFQk48yaV8fzt7g1pPcA8xOU0S3iFtiXKaqrRAWWT8xAnPR09eGIbyPReniEnYRA2DdMPC08OBV
	xEfEDctBEvdL5RNCMjCOHEfBdVoCQc47aNcgtHrG+p6cq9pZOXyAJZ6DHoxlJUfsm/nKWKDKLx1
	vWZyB4UTxWpcZfVIaWKBld0NJ2gRXDZE/KMm3SZS3u1Nuquf7PaMWqsnSxod9eOD+h8YYnx7f4b
	q+4ZM7HoYsWeFwEH4J6RI/y1V1LvMKNfvEu6BSuO8xg==
X-Received: by 2002:a17:903:32d2:b0:295:ed0:f7bf with SMTP id d9443c01a7336-2a2f2a4932dmr384141715ad.58.1767597909439;
        Sun, 04 Jan 2026 23:25:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG050QlldvuHqvTQimva03glOJK2mop99zhYfhj+TqldJkjTkZy0jM53iP96mL7TeNo+UzGLw==
X-Received: by 2002:a17:903:32d2:b0:295:ed0:f7bf with SMTP id d9443c01a7336-2a2f2a4932dmr384141505ad.58.1767597908993;
        Sun, 04 Jan 2026 23:25:08 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:08 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 2/9] wifi: cfg80211: add feature flag for (re)association frame encryption
Date: Mon,  5 Jan 2026 12:54:08 +0530
Message-Id: <20260105072415.3472165-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfXz4Zjy/hfM9+w
 iWJvLxHetELuqRZmNmh/gJNwWtOjBsJMjWKOZL14CCikCGJSOfCeQuemDvNpWLz/fGIEipwvLRz
 nhSCqt2i4UnypAr34ZLIaPZibIROsGmFS4EeyPDOpGkCDiYeCpScZ8LBk2znlZ+fIcR3JnNFPQc
 yKE25fAGF54RkfN92EhBbCA1yJlBkdHWNrPCjJNBGYzNZvbDVt0VklQsgn7/aR32gKqZ5BQSN2V
 zS8gP4kWaiwqHNKaBasWFl2vPsB42ME3YYN9aXIj2YKOezGz62iv8CQBaPIpYeMaziiOgoLw8bQ
 bX+YR+3GUFyZP9XR6y26pgHwVQx4zAjSD/AEpDdGgGA2/Fs3FU/ivJZfdksUYcbyKIjqgB0GLag
 dkovGBFT2G8lHZPbrDfGc/b8p2/ad1K7i7W7O7MMuJcIe9ZOu7OhUqXFdukTRL/2FTB8xuAPq4x
 xozYIao6GMz/e/H90ww==
X-Authority-Analysis: v=2.4 cv=UuVu9uwB c=1 sm=1 tr=0 ts=695b6756 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2WscfWFMoDXKbaco21QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: kcMI_Bhka7Uk_eWxaqW-EqmJzZ7fAh-K
X-Proofpoint-ORIG-GUID: kcMI_Bhka7Uk_eWxaqW-EqmJzZ7fAh-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050065

From: Ainy Kumari <ainy.kumari@oss.qualcomm.com>

Introduce an extended feature flag that allows drivers to signal
support for encryption of (Re)Association Request and Response frames
in both non-AP STA and AP mode, as specified in specification
"IEEE P802.11bi/D3.0, 12.16.6".

Signed-off-by: Ainy Kumari <ainy.kumari@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 371249a2f0b0..5c33486c6380 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6750,6 +6750,11 @@ enum nl80211_feature_flags {
  *	Key Exchange (EPPKE) with user space SME (NL80211_CMD_AUTHENTICATE)
  *	in non-AP STA mode.
  *
+ * @NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION: This specifies that the
+ *	driver supports encryption of (Re)Association Request and Response
+ *	frames in both non‑AP STA and AP mode as specified in
+ *	"IEEE P802.11bi/D3.0, 12.16.6".
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6827,6 +6832,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 	NL80211_EXT_FEATURE_EPPKE,
+	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.34.1


