Return-Path: <linux-wireless+bounces-25844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E8B0D699
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFED5560381
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4012E3AF7;
	Tue, 22 Jul 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prReFMyq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B112E06D2
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178391; cv=none; b=RI00j91yO6rxZ9x0NT+UijgHbomhLXK582usLk9s2PgTwtR3/c1O74uRgc5IaJXcNufyJ2b2i/Q2PG55wWKKY+sTZeKzU4uUE5po0VfsKMPgWLoc6yy7gjUlFdx4YeiJBblatu9CQvQ1B2rDtHzIfplkdAgIMHzZc0bmzablxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178391; c=relaxed/simple;
	bh=FsFUKSq87Fx+md+XWTTtTFenlzxI9QRw2wDze+nwFEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5ZnI0RMxsObUy0CYfhpPxgkL3/xTIjmVX6sjK2if+uN2xhs3WoGLewaHCMMjOqT2yVUau4WcptU7eF7dCgEwiP/25mxAKMeFtb3vzTPRQyN2JTrWE4s6XsEbztS+A8InlUnqyoqihO61ZUo6SxcO5heUQ4CdgVk6rLtoOLcztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prReFMyq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M40l2r001178
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s2Tliujz3v2
	hXcre43/10OqBxyLUYtZ9+byQ9GdnLgM=; b=prReFMyqItf8qt7RBM3VCwHNk1i
	IDIB/k7wrRpZirfK2c2BMaKbrHAiv9BJGmR/mYhUREg5GRDVqvMin4ip/qb0K3yf
	TCD/j3ibuR2q52K2yquMfEz52AN8+ZmrAvZ2L6Nrmd7vlqqc0/QsWqfySS6FsI5Y
	ykLeDBQvDhOC5K9VuAZMbt7612x8/EoPWhPP1kBx+6g2dMA/RBITMxZFWaocUGzb
	HZzTkJuyZcujrSILz7qP4R1Ef1oqE5AlnWjYdpNP4m/xtzoOtitff0SEFDol60ej
	J8hYH0pPmM5E/T9gbNVjXpKPiw5I3/jf6oJqRX6n6Vgacdy6m7oa9ojEdpw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dgvy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:59:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so4574507b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178387; x=1753783187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2Tliujz3v2hXcre43/10OqBxyLUYtZ9+byQ9GdnLgM=;
        b=Kaq7XZ5fVF32sEJzIQFBp3JTvfbOU6I9E+XA3fAL3I2yB/zioCctzOitmnGUiq5cRq
         7rvhBd82SIJy8c1LgOMSbh4KXLmtGjB6teMFH20zvO3rCSftavP2xxsDisNaHs7Q5nyw
         EF+SIE5Z0PIWCXMQuPd+6VwMLkjfxWJsEC24meIRIrOrPj+Mj3D43ecXXaSB1iEdC4uG
         v5FXfjsZAWAGhKsls3Vh829lblB9dc9OqoO9reGFFTUPXgvKxsDjzkBZL3A1q/gTo4/Z
         OmIjRZ9K5yAtve8nCfP4Q0eh3eC+VreGWUaGtWwEgEmtFYUZsbUCbVkIxaPpObRowfjz
         f0VQ==
X-Gm-Message-State: AOJu0Ywlw6zGIsDt464KttBvCxhgTeFwytKpd/aP017TETzFSwfBNElb
	+hwejf9jNms1t1SfJwuh8jTM+WW5bGKU/zrRggw7UpF1gOa1QuSulfLDzWoc8KQLtzqnpci+JVP
	hk7Jx5A93UXv+YCF8zKzmty/QqPpoVMHoNS0NKKATTrnlYqaVKC8/tZisRw23bJkv/CdC1IEcWV
	qgvg==
X-Gm-Gg: ASbGncsGsfm14XgrVAAuMoUmQKoOU3Xvr78R/aEF03E53oYw8q0yomnY40hSYmSIzoX
	3uSciy2JibvEL/YYah44k3Wg5kN12+QC25RR8L4VdtY+WCApZ51JQgX64PYHF3dh4k+gQK0zuW8
	HGuf1pR/++RJc3UgjmM+r5HiuQ1fNCJCPN+uKMEHrGPDbqW91buh7iAb3Gr3J3y9BV7dpiX+Fdi
	AipAi8eFZ06ZbrffJxRhDvZlA0j/TPYU1m9KMEmrw6LC2SCaI9mUcm1rIq5KPFQ2FY6/gkRXczJ
	TSpQsk62OPv35Zw+Kigcl8WiZNlj+ahPJMO0HVfPfhuTOFd2BlA2Bf7+P+3hD001Q5kNcux1B88
	ghs+0/9GoUPS4g9nB1kSOZdKVwETktr7BQYCfL0UFs0faa3A/RUHVwQ==
X-Received: by 2002:a05:6a00:2e28:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-75724872367mr33513505b3a.23.1753178386609;
        Tue, 22 Jul 2025 02:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4XnkA/E4sC41SuBa9XxXzMgLGHoXAbh9kYuzP9oZZXcfEYMJ+earkW+sULmeGbQcdPlaYCg==
X-Received: by 2002:a05:6a00:2e28:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-75724872367mr33513481b3a.23.1753178386142;
        Tue, 22 Jul 2025 02:59:46 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d6bf2sm6851065b3a.53.2025.07.22.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:59:45 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 1/3] wifi: ath12k: fix signal in radiotap for WCN7850
Date: Tue, 22 Jul 2025 17:59:32 +0800
Message-ID: <20250722095934.67-2-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
References: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687f6114 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vhDlo96zGHISquwf_XYA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: jDg_MALtSBH-gFz43f1BSpqm2kAqJAKg
X-Proofpoint-ORIG-GUID: jDg_MALtSBH-gFz43f1BSpqm2kAqJAKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MiBTYWx0ZWRfX/1DcxEogNCKl
 cgjZkwhM6raSkYAQyRK+vVlUsUXaQQMYRy305ov8bDwdBvUrTEDvHoWQFvi+09rMK6OIdxtDMHk
 fmAaw7iiGeqB2/uBGxO0iPdY9TgEH4JCYAx2mb+dmXTwtEex3EEHR5a9NlzHMpZLnv+1yDkRpRl
 14OPafTx93IXkGTUhPhPR4J5D+epacElX7kxQb4zp9fby13J1DfPPA2Lg5e5/mZ6T2teRYV8zVY
 COyRxoN+CHf2ePQpyOZJvgbYoea0uZi7wqGgCdEAXpwvBXLiBNZBc7jqkJNJY6fylztMYsoe5hI
 nhDF2+jMcDG9aYGkOgH7wa0CSS3sT8SstCURK7pnRimHf+1zNRHP6vE2dSsSf4b7/RHYzaradDe
 v5ULddvZW3KMznEmXjBfTWNs3hbX61jeswjm4aY1z8X0fIYGFlGt16pM/h/tuCGrhq0outpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220082

Currently host will add ATH12K_DEFAULT_NOISE_FLOOR to rssi_comb to
convert RSSI from dB to dBm.

For WCN7850, this conversion is unnecessary because the RSSI value is
already reported in dBm units.

No longer convert for those firmware that already support dBM conversion.

This patch won't affect QCN chips.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 8189e52ed007..ec1587d0b917 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2154,8 +2154,12 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 	spin_unlock_bh(&ar->data_lock);
 
 	rxs->flag |= RX_FLAG_MACTIME_START;
-	rxs->signal = ppduinfo->rssi_comb + noise_floor;
 	rxs->nss = ppduinfo->nss + 1;
+	if (test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+		     ar->ab->wmi_ab.svc_map))
+		rxs->signal = ppduinfo->rssi_comb;
+	else
+		rxs->signal = ppduinfo->rssi_comb + noise_floor;
 
 	if (ppduinfo->userstats[ppduinfo->userid].ampdu_present) {
 		rxs->flag |= RX_FLAG_AMPDU_DETAILS;
-- 
2.34.1


