Return-Path: <linux-wireless+bounces-21628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1171EA9134C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3874432D1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014AD1F8908;
	Thu, 17 Apr 2025 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVFsZneF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B351F3BB4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868977; cv=none; b=oLNvOG2i+FmBZaedEPzcgMGy0ZO6DIYqWTipk3v+D538dceZ2wBPz9IZowHobrrayaBL3DglrJ+CRPSZ21bZ5FnIAtYvhYBr3js+qPzC6RBq3OKDbBfigNH0LSBxbACzlcQCrKkvvr721d1l7wqHCZ7ymIKMLw8nvYW5p4cDzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868977; c=relaxed/simple;
	bh=tHiVnT7RXrAhLWc0zCOIe11ZYGhvFv9vycPVm7BXblA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+STCdIChG5umd5XDob/+nnNE6RuKAny7FkA0Wipaed+3TF1WnV5kcOFznZ7WTz3Xr/J+i3DBRzkNDsTAaIEaDBlWB6XFZkndSlbXB+VY0fv6YMS5wEWUx57PlN4rIrrYCiEiArprrGKMRib1mO+4Sww0b0LZWNDq21C3XeRlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVFsZneF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5lEDM030241
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/jv4RsssVGnpHJQ0Yb1OoYhjDQ9B5Idtfd3Pwq2rl3E=; b=OVFsZneFzQoYIZQI
	pQFmXdp33zmE2n7pIvOHdcaaZkJJo49Z5beCeZfK1VTtSCAMc6OI/qFWzBg/8It9
	LrnCmC83qCX9X8kCOK1xF0hpHMlK5N6ByEx7iyG26cDOjjEBmwRwVxsiq9/jwDdp
	NNYERx6vmWgKNieDH1SaE70BqsQ9Lkl5gRXdUV6ND+dub1HO5CVantE999dg5DFS
	JxTdep9AHc62Nh+ScnZi5JjnZAXLpCzuZYorcthSnFU+pZRZt/AkRpti4J1QD29b
	L9vE31IF6be9jx7XKYHXX/7qVcGgMAAEKObuyGzpQ52l2lq8qyeUkekNm7rOW/9x
	/B4sMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69wt1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2254e500a73so4152675ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 22:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868974; x=1745473774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jv4RsssVGnpHJQ0Yb1OoYhjDQ9B5Idtfd3Pwq2rl3E=;
        b=pJStGn01iC41T1bnB8TPpwD/X32hIPQQcRWMvMoHZCZL0ExTBQS01XyPGWnXyQYrFL
         95PApi7RR1DMlQfguuVxNSofCK2x/NCjEL9KvRcnMDesGOAjJa6J7qvf0vMW/GiXQKnB
         rfTqk6P2h6+Gxf6p6KDnyT8XuO6tyWaEjzuc6KdvSdxDFGRzTDlxmip1utT8LkRTGL/H
         DCHotCuVb4so+/RNYDNfyAj/+zQjkh9T7TjJVK19okP3rpbhqIMGeezvwIh3b5Du2raW
         b37A156EFfqitLMFqFI+WvgO3NVNP4R+Cpystad38pxyluY+m+tqMzMeWY09QM3gh9ni
         lsWA==
X-Forwarded-Encrypted: i=1; AJvYcCUs6LUtWhecMl9k+NSp8vvpG0wE9ski61Ly0ds6FK5kCBvorYllPX0z+8NW74hJRBWZx8zlcZKnM+MvunXqIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MwOXXaLeJs9reUAmTZjh6K+T4VQg7PZXB+Ix9JqFtX7vl+cs
	YUsA4nkXRL7FnVdxYJQOGDHIlOXGlzskq18RPXaLMb2bodtKU35BE01lEjiWYX2jM0mWDK3WGTt
	sJJfStLNtZM41W2Bqri2eXNoEMZLti9MRhwEY8iBF/kjsvuAB8jDvmQ6wGpe3zFtl/YQ94F+J7A
	==
X-Gm-Gg: ASbGncsBQcXBQr4zSo0NCBbCcj8xJ5/cX40W3Qy/Cv/gMXjvgD5Y7OR2QYDSNyIki3D
	gyL4RLrgcS96EwXZ2vj2xZQKr1R6f46YdMrJ/ehVqTv5veEhu55qGoBY/Eet8k7qJRrN9mDH/9u
	uf1sq88bixsZy4E2TdMlkLDv+Nr/TaotzDto7PJt0frGeC/uklvn69x17wEmzXp4FI/d/DaAYoo
	dl1knsz2xYgofBslidESqqyZ3yR4ZWd093wIywtA1hgBs9B57LI3cgR9E0svaLCOeKEZZYPES2C
	cbfGtUxhGXwvQPdeFP7XcQsLKu5C8TOeAFlPAxzW5HYmLJ4spvDSKhifuNVUe7QMsFRxaAReVSW
	Ws7/XSlVssGrPwmubOTGQOipmXGAA4fEbyGXJ
X-Received: by 2002:a17:902:fc8f:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-22c358ebd79mr77625365ad.23.1744868973794;
        Wed, 16 Apr 2025 22:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmWzEnXzI6K18qhm1XkVw0g9sKnW73TV706ko6b0LeLWy3RIMhAT8HKqzp3d9+9Aw/m2GXtw==
X-Received: by 2002:a17:902:fc8f:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-22c358ebd79mr77625175ad.23.1744868973440;
        Wed, 16 Apr 2025 22:49:33 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc47e0sm24745715ad.167.2025.04.16.22.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:49:33 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 11:19:14 +0530
Subject: [PATCH ath-next v3 2/2] wifi: ath12k: Use scan link ID 15 for all
 scan operations
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-fix_scan_vdev_handling-v3-2-9ec42513d26b@oss.qualcomm.com>
References: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
In-Reply-To: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: kRB5w9p7XMX-6Dq-tZWR-Ql0lM2IoSI5
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6800966f cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=HrdbKVgjrEfcEFtqRF4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: kRB5w9p7XMX-6Dq-tZWR-Ql0lM2IoSI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170043

According to the code documentation in ath12k_mac_op_hw_scan(), "if no
links of an ML VIF are already active on the radio corresponding to the
given scan frequency, the scan link (link ID 15) should be used". This rule
should apply to non-ML interfaces as well to maintain uniformity across the
driver. However, currently, link 0 is selected as the scan link during
non-ML operations.

Update the code to use scan link ID 15 in all cases.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d219c5b07a79c9829a1de12183e298d24eb5336a..5e3f77894d035e0dab6d24481e696fd15415a3d2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3466,25 +3466,18 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 	if (arvif)
 		return arvif;
 
-	if (!vif->valid_links) {
-		/* Use deflink for Non-ML VIFs and mark the link id as 0
-		 */
-		link_id = 0;
+	/* If this is the first link arvif being created for an ML VIF
+	 * use the preallocated deflink memory except for scan arvifs
+	 */
+	if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
 		arvif = &ahvif->deflink;
+
+		if (vif->type == NL80211_IFTYPE_STATION)
+			arvif->is_sta_assoc_link = true;
 	} else {
-		/* If this is the first link arvif being created for an ML VIF
-		 * use the preallocated deflink memory except for scan arvifs
-		 */
-		if (!ahvif->links_map && link_id != ATH12K_DEFAULT_SCAN_LINK) {
-			arvif = &ahvif->deflink;
-			if (vif->type == NL80211_IFTYPE_STATION)
-				arvif->is_sta_assoc_link = true;
-		} else {
-			arvif = (struct ath12k_link_vif *)
-			kzalloc(sizeof(struct ath12k_link_vif), GFP_KERNEL);
-			if (!arvif)
-				return NULL;
-		}
+		arvif = kzalloc(sizeof(*arvif), GFP_KERNEL);
+		if (!arvif)
+			return NULL;
 	}
 
 	ath12k_mac_init_arvif(ahvif, arvif, link_id);

-- 
2.34.1


