Return-Path: <linux-wireless+bounces-22893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F95AB4A48
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2640419E6A23
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBE1E411C;
	Tue, 13 May 2025 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FN9T0fXL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30B1DFD8B
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108632; cv=none; b=JeY9yNTOiVklaXAT/NC9AH+gspj0pjUMQjHYrBA947c6JbkPW89tZi1zQiELClg7tz6/5ni+7LY8OIT+qUoTv2a8D2mbYcN2p3hbeaoTjZs7NaWjZXIE2odxIIRPiIU1j8IyxOX1qwwmkJmFvF4TgBvyqDHvi53yDxoQvw5t434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108632; c=relaxed/simple;
	bh=xcTsYTCq4hhPRXLgmxGlk3MoAihakw6GcR8Vycz3644=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eu+VSUkIfZ5aSEnwbcp0Y1lN6jeNKuuihmbdbKmL0V0KL6BDsKCSQqLFdxgjRB9We/4aStxIYUhZqLZNfhSsP4X/Fxym6uPbjGXnY3AxoDV1J5Am5xuUX0/FwP8XCvRn5n8EbOYJyrJZt8N18lfyXDAqJmmo7Sw3vFoWhxw8AnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FN9T0fXL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHPGj8023765
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gas3VfMriPFBCDRSn8xWRu/z+ynx4x/EVCs6vj6wClY=; b=FN9T0fXLKw4FUHrJ
	ivSqRDcgP+pYvUeoNPARGHZIQqlifZKF5c9ctAromcEFedN3eQTRkKw5eAqhLdq8
	IB/Qv30O0OCjpL8C1vUX9Z4eebv1TZWBlD7P9rNaPKedkmJ3va79WU30WTzOtib+
	Mr9Gw+NCDBS9rwYUwZ35lxgyPBCSb+7xx8P0ogGjBkSSJs1owZC7KxEAPHiq7ozt
	KPsrrmgrgJOEGNO2yu9VOWkzKsz9AWkvWttRofcG3msq7l5FGwlZh1UJP+BIK+BW
	NPSNczwqVv8nfOTUoqD2rYgsQI35qcTFJxyAcTLYHfXodUkjyMw+Bg1h90StVUbc
	MmFYJQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kdsp2j94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:57:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22e6c82716dso39172235ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 20:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747108627; x=1747713427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gas3VfMriPFBCDRSn8xWRu/z+ynx4x/EVCs6vj6wClY=;
        b=l8+q+L3+mmyvIL+kY1H9dpStTZKhGLP1SLtEFcIbnG1CK8weA1JL2cYt/ZXIl05WCo
         YpdXCs97z4ciP0X54oAsB+rvMPWYcYMFovYjDyMYFYbxIa5+ywNp2luWL9MgnOGi963S
         HJQ3SRjkSLvHITEg4r7tWoXtobhW7IoS6semBQ5qGbQuElj/ldQwqw7b1MtoHBZx6IYC
         zuXV2tIAtizw6QZ5SL6wgOtJI0HJt4JBBSJGOkp/nS++GBmbbrcNBL9SsCkHlsrntV+n
         M+oQoKsgqMMCiUQQOA7OSZR8/xDOzssoMgffUruJmw7bZjhnvXwMb7y693OlIIKfL5fk
         Q3mg==
X-Gm-Message-State: AOJu0Yz2mhnfYCbjbTUutdZRzXtYv8uldw0lZgeoYlTWwDq8s87sNlUF
	DkREXzwvvs7NVTfORxOX6xoHUiO4x8HO1rT4dmm341wN+gKMjmUc7ewuST9rP3InG2xlB6maRTu
	sKMpwqXNS3e2I24Db1kiuIFjQJXQDjZUUkoOviG1Qcs1ZsdKSuDOaw2cHV+RDpSB22Q==
X-Gm-Gg: ASbGncvmEGco9GPejSVro2+hjfGc7HBk03NVyaBtJIks658Phi+gaeSWh/FuxC+9V1c
	5UeReFeZLlOFzaeykTCVxa/sxIrmu0IIy6dTJo+RjiDhJKq2c41i82sAeNl2FmKGWOuS1o22k8a
	zD/KmJaTWcV71ctvPZ3BIXZAynwnQyVhZljYw3AXAXSlp3b/7Lw1FyA7YNBvgzxGyfoBhSNgQM+
	c6IUF8o2NoGebCvf+duzOa4GK4Z/ExjE7V9AYYcAr2KU424qvjbB1OEniRNMEIDXRx+GXKWS6ua
	uzGL4eKVRiMTxKLcq+J3aebqyk04P0DiZvmKNrY66jJAZughVPg4Du8aXFcn5qQmw12mJsTFlhB
	ppgifwv7wQS3+hxbyouzYxKW9Kq7H9cbKqXaW
X-Received: by 2002:a17:903:230e:b0:22e:5406:4f62 with SMTP id d9443c01a7336-2317cb62f61mr25969495ad.24.1747108626760;
        Mon, 12 May 2025 20:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET+2QgCIvchjWzWfnbIUJNGg9YbjqrllZx4sUGIyUvjL6xQ+0ysYQGnvprJUzEJI7ZZsTbxA==
X-Received: by 2002:a17:903:230e:b0:22e:5406:4f62 with SMTP id d9443c01a7336-2317cb62f61mr25969235ad.24.1747108626355;
        Mon, 12 May 2025 20:57:06 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271d98sm70236515ad.154.2025.05.12.20.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 20:57:05 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 13 May 2025 09:26:51 +0530
Subject: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP in
 scan request during MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
In-Reply-To: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: QUrc1Otg8GquuS8mDQnPP--yR6B7V-rv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDAzNCBTYWx0ZWRfX+EmWbwnFL93P
 7F7sIrbumUpEb7XARMxomkIaNTlu9Jo7gqqYiBycl0D9RY1l8l0gmXE176RM4GLyTA0C/EX9D1N
 V+k13sPB5ZCTvMoko+klDG6TTyEUkJTMgtkTJcAC6Od/IKW3jsEkxrOzEoKrJWSRWmkgdtoMFnf
 HwIDcpp5VuokEDzrsNfqcm1rYNQT2M6nrR4QCzL+TiZzGZA714NKeq/uKDbv+pANmYf8+7MrTed
 Fm1TOm9/t1jVSiklfyR7P+raLd6SKRRmV1fgkl87H10r3yIhgl7H4nXpHVqw80/WmaLFQ1EFl34
 XUdl1LaiyylMzGMXhQM4PYXhkPOqoyvbiI5x3U5BTVKtbXihKItFkYh8Sk/N/w3jWAgfzXUTaLs
 lp5MjSl2tfErPXy0eVaG3JspfdvQB5zHptS73yJvk6N7GjtRVCP4SxeHjKhKsMxSorl+Fqm+
X-Authority-Analysis: v=2.4 cv=TrfmhCXh c=1 sm=1 tr=0 ts=6822c314 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=DDi9Blm5zKVmG00JEVUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: QUrc1Otg8GquuS8mDQnPP--yR6B7V-rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130034

When an AP interface is already beaconing, a subsequent scan is not allowed
unless the user space explicitly sets the flag NL80211_SCAN_FLAG_AP in the
scan request. If this flag is not set, the scan request will be returned
with the error code -EOPNOTSUPP. However, this restriction currently
applies only to non-ML interfaces. For ML interfaces, scans are allowed
without this flag being explicitly set by the user space which is wrong.
This is because the beaconing check currently uses only the deflink, which
does not get set during MLO.

Hence to fix this, during MLO, use the existing helper
ieee80211_num_beaconing_links() to know if any of the link is beaconing.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2cd8731d8275b2f67c1b1305ec0bafc368a4498a..9da2c9398c855b9c6f40a234469f21dd361e486b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2924,7 +2924,8 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (sdata->deflink.u.ap.beacon &&
+		if ((sdata->deflink.u.ap.beacon ||
+		     ieee80211_num_beaconing_links(sdata)) &&
 		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
 		     !(req->flags & NL80211_SCAN_FLAG_AP)))
 			return -EOPNOTSUPP;

-- 
2.34.1


