Return-Path: <linux-wireless+bounces-23448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927BAC602D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09641BA344F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 03:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4C1F09BF;
	Wed, 28 May 2025 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IrVTDVCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027F1EE7BE
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403601; cv=none; b=sFROFY36eYDvDqNoeHVspGZqiP+xRN6XI0A6WhU/jkhorcoDYsLGU2SCT1JgGf9jTvuqSvs243ACoc0WNoIaxYPifpHzL/ac7P/cmgUBXllqPQ63ejQPPUz1hr5mCkqlPWygLGXdq8KGhXHSteQ6XRpT22+odrPu57hrqrfvTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403601; c=relaxed/simple;
	bh=Rj+NJ4PLxeaQwzs/p/v8q1RN/33Vk8zRHHo0F+tjpuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WMWY0qR2EhCfFHe7lnVM2YRLXvIWefbWXT725teFnpJH63g2SXNtMz+0ZZqHxf0xkO+cruEu3KrmwlDbo25SuQbkWDRbf6fLJHuIb3v39zTK6chAosSi/HhR/N/rtKlI2g/zxknAjmpbvAu8DuIl/UJgz1EHufidJFzWyx6qkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IrVTDVCE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RN6eTr012234
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 03:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YzVUHSb2p0HeHPQHSUuRHz
	aGFXorW4tDid+VwZ5TZNs=; b=IrVTDVCEzKS1A4LMM4koeYaoKt/deXgGHhWl8+
	LvhkeYwtNMhItZDuirNnl1dXFCa1SOYN2+qxp5tx6/SnaswNrq3VkHvIKqyYVYPd
	EECCFPbhfmffz55J0NjVSo9RjZxODpiO6QiVB9EkABiOYNsfXBWf9kqQOUJl+oXi
	qi5pgzyUNowI0w/DcsbPMeuIeWJs8eI2DgkSlS89PNw55xURq/JV2qHq4E2agGvN
	7slzDRoUMPrBfujLhJKHkcbKJiYZvLDYJquHNPYz6RYu4FF68oZsj53blxzCWn+F
	sjdpO1nAS9EnVQNkX3lOjS9WbseBtNr3CAqJATf8KHZpXS8Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691bdnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 03:39:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2344f88f9easo22731575ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 20:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403598; x=1749008398;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzVUHSb2p0HeHPQHSUuRHzaGFXorW4tDid+VwZ5TZNs=;
        b=iFYwAcCo/qioxZApAZQ1g6/dXCOL+mtpm+9ia4upmy3L/cZoZ+gVQrgsh1kvZ0v7Lz
         C+Uy+AFN47PHT1KR3te3v13dM1iFMicVbgW1UCMqJCqSJaQbHvkBhLbCs94XNZjSTroH
         0LufTszflRioPpSHZnU58XFsCinN27OO6B+Zu373oEaMad6BTUQD21bLoq0rTNU++pw6
         BxhjnmwaGRTc0OOFFSkOIsHuVhAMSgwQreqYzpJdh0s5mX6w79UvaQ51ht6NooeunmqJ
         OXXqOoZ8mXyQQ0wWLqW21+x1hn66KTxOnEyGFgVBEyZMfZpD3nKxx8PZ3GlhzCsvQpjz
         NnVw==
X-Gm-Message-State: AOJu0Ywut/XeFAB1Vx1/fySbv9GJBAOCL1xWL7j/+BgXK4GXNYt6BJxi
	Bh875zLzqHatdRe822BFUMpUqzL/Dgvgd0pJiHgdgvt3nIeAnFA2k6PY2kMU2nDmOC0KybjwW98
	oZr5VOA5f1jhGndiPHJNulmDGkbApqyx4tcVWB27vVyFPw2Wfaz5YC/l59/QPIt2QFZPWCQ==
X-Gm-Gg: ASbGncsvhuHhGgB+coFRWhoDNcqgk8tQk4+zh26pbT1zIzGsKxgQFKGjfBnNS5/ljGA
	ay2N/WezhLDKXiCy81WGjdkOdqzGNwuFoRcAJyXL6Kt1uOyu6CGfyNe7pQkN0aFyxcTcf0mJNLE
	WwO2Sv8kTlC4pa0iq4TEN8LHn/x4IXGVXDHliRr/7NokJp1wp2ZI4+Q41Z/vpyYVAlOdcCZ+zJQ
	rZ1an61osOmpii+X0qlhvqF2ziqUjswtd4m6/2z2Y9myI0yrKzI4QKdxVgddMURe8xLNCYdW21W
	ABzKvSt3re0adRMp7Ko5KtGdh+hFxPB7KoTxsOKx5C80y1nhkdBTsqpk7XkbxAN7aimar9RvLFO
	e4RBUOSV/lI4L8OzZcXCjle5POfy6zvmJl1Jo
X-Received: by 2002:a17:902:e889:b0:234:d292:be8f with SMTP id d9443c01a7336-234d292c1afmr12692935ad.1.1748403598236;
        Tue, 27 May 2025 20:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcmVPLrjJUXMuPS+i4A3LJln9/1Uf1Ig4fm/l6xyRdbZHO+0oazRa9hTPOu8LyBJWnfrxzg==
X-Received: by 2002:a17:902:e889:b0:234:d292:be8f with SMTP id d9443c01a7336-234d292c1afmr12692645ad.1.1748403597888;
        Tue, 27 May 2025 20:39:57 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac78asm1977085ad.178.2025.05.27.20.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:39:57 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 28 May 2025 09:09:47 +0530
Subject: [PATCH wireless-next] wifi: ieee80211: add Radio Measurement
 action fields
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-add_rrm_action_code-v1-1-6b7c78b5bbaf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIOFNmgC/23NQQ6DIBAF0KsY1sUIKkpXvUfTGIGhklRpwVIb4
 91L6aYLN5P8zJ83K/LgDHh0zFbkIBhv7BQDOWRIDv10BWxUzIgWtC5qUuJeqc65sevlHKudtAq
 wokpzqBqhgaB4eXegzZLUM3oZBzfwHk+wzOgS14Pxs3Xv9DOQVPrxlO7ygWCChWirlivNGsVO1
 vv88exv0o5jHkdiA/2n2D5FvxRIaLgoWUn5DrVt2wdVxzlEFwEAAA==
X-Change-ID: 20250513-add_rrm_action_code-d2df9e47bfe1
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6836858f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=3Zk8YcGt6z8hooTP5hoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: bRjtk2tp2MvVXNYdwhCwL6H-MYnKDxme
X-Proofpoint-ORIG-GUID: bRjtk2tp2MvVXNYdwhCwL6H-MYnKDxme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDAzMSBTYWx0ZWRfX+N2Gf2MrpLZt
 4X1tNwWUA8To+jk6flRMNSSOli7tQC1BDHKl8UloVyKy7k5wa5oihyaxd8VC/wHYc6/bU/Gzrgk
 vOwo/eRIzvQktE6BbKSw0la80ddDUM8PemDdZK488AZPpsZf/4S4HLUBFYfPHzM5djSGHWYdztb
 ZFr6a0z8PqX4gGH8hsiWDlehSyy8JmdDu8rlpUrvDN5Ok5BeO9clJ8uktybccFIwdtXJiFa5psW
 bnXaM4OWrw7Ajq56sXTV/yNKuv/oOxvJ2WOs9GBD/vZdK9w1N9JaHeSthexO0p6iyofQyV5Mdg/
 stoejf9x119AbZrjXEKmp+Uu2INKbv0ox/eVnbmqoTYU33dCMgdJgtUljFwb1ei9rC6NS3fLmAu
 H9U1PzYmnpGZBxSINnIjmph66SlE+4GfytJmx09CbeeN8jCLgXRQ7dAsvYNPzN9+4qO85+6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_02,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280031

Drivers that support Tx power insertion could examine the outgoing Radio
measurement packet and depending on the packet type, the driver can
insert specific data fields in it. These action field values will help
drivers classify the action code within the Radio Measurement action
packet.

These action fields are defined in IEEE 802.11-2024 - Table 9-470, Radio
Measurement Action field values.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 include/linux/ieee80211.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 420c7f9aa6eea5940785418a5558f74c1b51fb8d..b3ae4ccd73013efcdb57177bd9d929d862cf66b9 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3948,6 +3948,16 @@ enum ieee80211_s1g_actioncode {
 	WLAN_S1G_TWT_INFORMATION = 11,
 };
 
+/* Radio measurement action codes as defined in IEEE 802.11-2024 - Table 9-470 */
+enum ieee80211_radio_measurement_actioncode {
+	WLAN_RM_ACTION_RADIO_MEASUREMENT_REQUEST = 0,
+	WLAN_RM_ACTION_RADIO_MEASUREMENT_REPORT  = 1,
+	WLAN_RM_ACTION_LINK_MEASUREMENT_REQUEST  = 2,
+	WLAN_RM_ACTION_LINK_MEASUREMENT_REPORT   = 3,
+	WLAN_RM_ACTION_NEIGHBOR_REPORT_REQUEST   = 4,
+	WLAN_RM_ACTION_NEIGHBOR_REPORT_RESPONSE  = 5,
+};
+
 #define IEEE80211_WEP_IV_LEN		4
 #define IEEE80211_WEP_ICV_LEN		4
 #define IEEE80211_CCMP_HDR_LEN		8

---
base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
change-id: 20250513-add_rrm_action_code-d2df9e47bfe1


