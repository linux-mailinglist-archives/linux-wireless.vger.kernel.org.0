Return-Path: <linux-wireless+bounces-30813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A80D1E5AF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906983008892
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8C36A027;
	Wed, 14 Jan 2026 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuioDewc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7SAyK7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3462BE629
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389568; cv=none; b=Dpm1ZpvM5rZpLultdAjb0AGA33HhE6pNUq+VXZHRxbc3VQrViAmVnpbZYAWFum1Phcm8aZwdA39Q6lL46OHHt9pNltPCPclgk7TWRHF7NDP5igKaswEhwP+sQ/CCVynbUfYM0J49vvQ/NjztySIbn7qEPdf7YMzgU6hDyFZTylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389568; c=relaxed/simple;
	bh=0cVC6fpfUjHsxuJKJ+M5rVcliHjdxL4F1rMVTi2BhO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDG5ovwhdvIdtO2C4j6GHQTfqOP1NyBn9lqR7ojrE1ym9t01VUM0XbkTvVesgoQ+CA/d4HAfvSn0yh/o3vap1ds1GhuWumShQLkKXPjb2sYJaySg8Cxkmii33nsNsbOfEPZodcDGKncA64iEzVexYu5FxvbMPfSHrfd6j6BPlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cuioDewc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f7SAyK7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EB32Ev3279911
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GghyagXxVQZfivBww2dKs1vPaF0HDYKdlwKsJDShVB8=; b=cuioDewcEOZw225F
	Qy6IoJQp4rTazk+T5/Lf7Z0SVMGR7bTBdKn7fcsxTOEpgQtVnLZn8kGCeDPVZoAJ
	qTHN7yWP80zuwnsd5CheCDHtwQkJiH71GOF33C4CpBYW6cuzu+hPXI6gYlGgFcvD
	dcrJNefwAnQx4DeSKU8Lze/T8gImBfSTT2duu4EQKHVEXh79QNAhTRyKgXSJ4g44
	aOXlddCYLTZEyGcHhJenqSPMbCPbhapTMbIIB+HH6LjyE8DurOCw82pDEnfbeyo2
	8m3Xlv4t6xiZk37Z2VaDrYxDs3323CecLsyg/8JSUnFW7wxUXf1CBnw6VdRVIPKR
	RezK7w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp9x8r337-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c552bbd1b03so3282364a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389565; x=1768994365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GghyagXxVQZfivBww2dKs1vPaF0HDYKdlwKsJDShVB8=;
        b=f7SAyK7qZ6+BTFCdhsD8u3fcAhjBSk5eT+SbywvwtN83k9qI+UxoymIhIl0jcULAfp
         KbwKDyV9XftZEfHGkpWeauf8kFOEeR7OchWb5W4Evly/hr753O5gsYMn1VOCK0nPN8b3
         l1gvJiMXtLALZj5jKy2M2gEZnUtaXwLbElN3ciguvUI0fK7DtpmVVCS3tw+lvh/YROTG
         4dGIDL9sU/mDMa2L4J8HWUjIanNiFuP5FpZieNCklUjZAoTyLZa92zPW5Kjh+XuG/FRC
         S/O/XM1LzmOP3E69O8ehXLZrXf065lQL+w+MBX8gJQixu7jfS1Zkj9o6OiwcntbKGiaX
         Gy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389565; x=1768994365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GghyagXxVQZfivBww2dKs1vPaF0HDYKdlwKsJDShVB8=;
        b=KV8kgcrLjJV5L1u2Pwq6nDVyP8A21ETGl6i1VvNiTn+Fu+dXRS8aak5hZEuGCTeiNZ
         O5Oi/C3nNnn3nkwgb/c/EpcGfV5EN6455EMAYpaMimHji/lxpOGqdGfRboCONp+uqcsV
         AdomJcIzxZPwyStjqIjEvkn2GXxGq1KROoSKxLAFLEd2R89I4ufcFSVhwxG9Gz32HeJ0
         JPkANowy0mmrWimboZdUus6f7+Bx0KgnjNKwhuP1XtfZJdVRueXfRpilPZluHwxJp49Y
         CAQSbn+X2bUlwzzfwtL4SsOkwFWdBTWwcmZi0tBn5t28vMFzw+pPI4Oe4y5mN8XXU0UO
         6O+A==
X-Gm-Message-State: AOJu0Ywbcv+yyiieSe6n/l6mBavQcobuHmdEE61ihUgBLUtJYaXrcDOu
	96+7T2orRpOvMyPtLUWn9Kgg1fSDflFiG4Gpc+THrOF3JzO5r1ubb3zSKlTGrAMONH/Yj0OEYi3
	svVXGMm13KbDQfAbfNj3/xk1aAgTRSs26F9b9vpGpZlirc6DvHeZ5dYz4yANWlKe5WaGAUw==
X-Gm-Gg: AY/fxX7pQAxkWTDdb4qbiZ+R3qrED3fJPL17h7QBrdgB7PCPK6wxLAcC8YtOnMN5IsF
	tnneVuN73HUl69rFLp5Fjq02VuNVvGhrm/LfMGoMFNdU1tl8oEw+27LwzudRYAqHaxA/d5BFvWr
	OnU3LrEeEijKq7HLaYI/Z+XDqT0zhjjlg6SUtsSvpe/RL0tRx6pzCDT5o6KdKkbQWGv5ygtzdj2
	VwtCfZzSKXpkRzDYT98nRk5KARqg7lqWstB9NVjumK5JjldsvoK4G/4YG+BDtGoEU5ikTnVu66v
	Vdu75nMHndt5sH5nZGQg46Lymlt9cOC6EfizWTYa3H4TlJU3VULajBiskBomO7a65LSc5ayK6k3
	G1GBAIj2FlTSFsc2qf6iWua7zVoWtwm+waYUB47eOjw==
X-Received: by 2002:a05:6a20:a108:b0:371:d67d:e56a with SMTP id adf61e73a8af0-38befc042c4mr1780820637.57.1768389564629;
        Wed, 14 Jan 2026 03:19:24 -0800 (PST)
X-Received: by 2002:a05:6a20:a108:b0:371:d67d:e56a with SMTP id adf61e73a8af0-38befc042c4mr1780796637.57.1768389564098;
        Wed, 14 Jan 2026 03:19:24 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:22 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 2/9] wifi: cfg80211: add feature flag for (re)association frame encryption
Date: Wed, 14 Jan 2026 16:48:53 +0530
Message-Id: <20260114111900.2196941-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: w-1Q19oTGxong4PiLJ3JJJJ19-je0w70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX0gSOXCMWmLQh
 Ofawlai3xEA//eEuslsSNJt0AHt6qC6WRfQSQRIoDbdh04CG0kPbyq17k0mRzYwHvpEO99j7Czt
 ehjhpdk0b9I8K+wGuj8DK/b5Y8VGmYQZWtSRljZr7S2dJydUgmJNy+lhPSmu4vhmf1tlo7E+1B2
 S6eb7GbyYCon8eFd0SqmdqXBQbnrU1GYoRC096HG+oroNu9Kwr3CNRK7Q8xbwIbsjWrmcF04fIZ
 VIhG75d5l//rfrsv+lS3aNBN71E19sAEz0sw4t0T4ezpv+RX4teAzX8wdzizc7viJ4f5dVwHqIY
 lQ+avziPu3Z/B9LdFYpNb2RtnMs98TJ2p0ZG7+lnYeMbF4CL1qCWjZp+Lmorfl1lvS1NpsjGiVw
 Qr2xMeXXeUqKyrF/ALh90AJNqVkK5fLqztpvO8pxdZxUTqoEamewJP48JD2T+GYbwTylEp9npss
 5XxeBevkxhIYryq1Abg==
X-Authority-Analysis: v=2.4 cv=HY4ZjyE8 c=1 sm=1 tr=0 ts=69677bbd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2WscfWFMoDXKbaco21QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: w-1Q19oTGxong4PiLJ3JJJJ19-je0w70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140093

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
index 351d4d176f87..60573334e086 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6754,6 +6754,11 @@ enum nl80211_feature_flags {
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
@@ -6831,6 +6836,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 	NL80211_EXT_FEATURE_BEACON_RATE_EHT,
 	NL80211_EXT_FEATURE_EPPKE,
+	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.34.1


