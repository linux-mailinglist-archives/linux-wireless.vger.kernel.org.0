Return-Path: <linux-wireless+bounces-22234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC3AA43B2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 09:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BE34A7F3E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A8B1F76A5;
	Wed, 30 Apr 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hyKWufPA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C71E1A16
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997439; cv=none; b=hWpe5KMuHAVGTt4/W5uv0Hn55lxq6wJbZt2sLE6wwgehPSrU+mY30mX0FkBwtXVl41oDpg2e0A3reglkPq1j+QaegtU5xwKkKC0tk2nagnnNutM2KDJUoFW4/sieBFKZ4JJDmKUGh14B+cHWS89AWHgaf9QcEodCRDHfJWV5bK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997439; c=relaxed/simple;
	bh=8SEyhfjP9X1MSbDm3ZIXz6Yar2UIACms5rw/jzfi8BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fuAXk5c9WLtI4Q3rgaPdOBS5k8Aq2FoL1O3gVGtjjNr7gZbup97DMFKRvEATVxxbcVViufacAJe+Tfol7jTxytrN0YerQJRCluyoiKwYBoxKAMEu4exQh/gzAhsSItkP9mqBC4CJBL8XjU7+b5+OtN+1U6ThWzAncDfAGGchLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hyKWufPA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLaRgC012228
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=Y86fPAmtKmnZHSfXMNDslF6qXxAkG8J/KBwFQmVGcEk=; b=hy
	KWufPAh/ssw4b0/aDE9VF/cMJA0Uxu4El90wGKzBKGgqzgJzqER8Vq4DYsBFuwkD
	uZ6O2g4ouV0ThSZwl9/tq77Bmt2t+p0lBWKPs+jOZP1PlYYJol4TfOklG2KXRw6I
	oUFdkENR48vdNXLf8MpRAaSnVIIcQZV2eHHGilBH2ZT+r44to28FT0EtPvCcUGZZ
	e9oBdHGg5FILEwI9mwCpy407SN1SkC/QyrVovYkr1lPLR/Dq54paI3hng5/cJc7B
	OKz5Yl0wkKulx7JNjeSUt09XJK49udEiN2MY2gHkH4TaGxEvd3WaUmvUynGfmUEe
	geyyLDQQULI2QxJDl00Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u3s5va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 07:17:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2254e0b4b85so7160875ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 00:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745997434; x=1746602234;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y86fPAmtKmnZHSfXMNDslF6qXxAkG8J/KBwFQmVGcEk=;
        b=NDQAYg6nN12uomE3FN7QQDQ/fde60gj0U3taFfnBnvwfZ9f6vl9shGoNkiLUiqBL1f
         FBHlz7uLC0lBw0h0I0JJKsms94xwj5wSVQLpRAjj6ydDKuXlLKnUEMKrWZraZj7sKZek
         dOTP7j1qn2zpXOZ4BuItpE3fdVYEUvn2RUOoJcDxz2A/VwkU1mGvkpz1OXIiOWKsjfZA
         IvYIzzxTevreBRI2IPIIJ5zhnZgCxc+dTBNCYhfUhg/BUpEj9C1p4ojPiN5ugj8Ismd1
         9VHLJhRmX4KT9dOQhhhS+6xu2u/UmSCeVlDQPXjKZn/m8/XN5CyPKmqODMALAeCHIVix
         f61Q==
X-Gm-Message-State: AOJu0YzkGAu+Fw/oYdfAwLUqkHE5RSe2nUbp2BHa6EkmwFfPr0aTuOPG
	fZ/QEfDdnie9avVvlh6F9/zlQI6itD8zUabjfz7z0Ivlk0vqxcVBkm2KYvcOUTfCmed0uF3/L86
	MPtJPbB2Kwj6hZWzuAxIT5umg/WUwLbaq1+k5rTt6YhcN0Q6Hh4GQvpq5PRwxV+sbLA==
X-Gm-Gg: ASbGncuD5phGGS9n8hRszUU/i+mAI76zhyAHTwF5NcCSHC4KIpOblnAi2+wuYtquND0
	Y0TElLq3RNmI7j7XkzVWSHHzQflXir6hCalB3k0iyNFRtnpVbNlWuBY7UnRlMfrtxxn3+rKr9u9
	iq0nVMHvXBMHSZSXeHkXJ9vZ5MIF6VdDwgFQhsUCxqTSCjSPaibcRr3a4pwEa8+bA3SyQ0MOtgh
	jnlE1PLJdbewA2cHEqbRRIAm9gjMwff2xOzVKvSsMs++AoiyndKsQuU0CZ9IaeU+HNY0YclqSr7
	3tWIwmEybw/TZdUa/6WwcDQW4hhCDpV1Elma6+E3MaNiCFPYvvFzBlHaF/V22gvwz/yIm5VQNWY
	TuGR8BkqejkcLWJOW8CV2Va+LSvrlRJQ+Yy/N8v82ZJbkPg==
X-Received: by 2002:a17:903:1a2c:b0:215:a303:24e9 with SMTP id d9443c01a7336-22df4748c43mr26063515ad.3.1745997434038;
        Wed, 30 Apr 2025 00:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcOG2+PblPaj4xaXAmbx6p1Ax11dOI7ozz0HRJEHYEv7nwxRNDcJpchQ7fXaa/YdZpBJrF0g==
X-Received: by 2002:a17:903:1a2c:b0:215:a303:24e9 with SMTP id d9443c01a7336-22df4748c43mr26063325ad.3.1745997433677;
        Wed, 30 Apr 2025 00:17:13 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc70efsm114817915ad.95.2025.04.30.00.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:17:13 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next RFC 1/2] wifi: mac80211: update ieee80211_rx_status::freq documentation for multi-radio
Date: Wed, 30 Apr 2025 12:44:34 +0530
Message-Id: <20250430071435.2201777-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Bv6dwZX5 c=1 sm=1 tr=0 ts=6811ce7b cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=G3GIQwjkmUm1iQ8NZroA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ZO4oKevdyDNwIJblE2VzpVnC3tHDtuV_
X-Proofpoint-ORIG-GUID: ZO4oKevdyDNwIJblE2VzpVnC3tHDtuV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA0OSBTYWx0ZWRfX9oKoLvFwYMz/ zAJ/Vt1yGKrBASvyyuKxhuOFTwu0MYWT2ekaSimWASH/pEUzJj0U2BrkHlDHsH7jCDz4z0RTMfs EwdvUfvvBlKhWDBWah4jeFRR/H3ltMqHjAl6K/aqqyCgwDbKCHJUPiD3TNG6Ro5EwsYPKwcH6bT
 ObWbcUikILxPRFm9mIqAKHDTwKZ6XCf72DFzEklDwoDHUW6hiRnKPtLC+6+vMC5unoLOncZmRIm 1/BdZQ3AFHRfHWYDjbz407F5t8rs0xkfDDdRwlTcIxSz9CedCopWbyI9uy8EFfphrqtIdDJ00cd YS5WvA3quvwCsca7Yc72qGqmuDM9OHbAx+29qttjGmQ0pJzmMAaQm9EfS399WgdohnjG7b9Ho2y
 qlNky9yNLvEPsjYCoInlDKCSj02HgElzBytbY5CGZjb16fifO9yQZ8dIB6wp0v6BJDEjp4zh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300049
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


