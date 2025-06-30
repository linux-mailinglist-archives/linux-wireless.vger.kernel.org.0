Return-Path: <linux-wireless+bounces-24642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470FCAED339
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 06:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CA318950FB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290342905;
	Mon, 30 Jun 2025 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AaqFnwHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2E5695
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256940; cv=none; b=RZbbBVeuwts2wNqo/F4kgrqMIM2onGicoPsr6FPBWRxkNJZwkqovM68a7UH1m+HBHWJ+CM5gulVxrvGMfhJDZ3HgF7wXHoIF4w33/OVSNbBVm/2/7Q/eOfioYC7YTAYpU41OD8lKGsUEEkHhvfVTq0O1yHfucQEBaLIEw172UTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256940; c=relaxed/simple;
	bh=dpAMUqYYxK35rw+dfbYr6B3/oW/qsvP66eDQqd4x29c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DMDjalKsFq1gBX5KZBuY1vuH+p8zu7004m1hJyt3LvSq8neWaOqm+fgX0SMeesmrwauiwnBZhEN7U0VNcHycBwiu5V+HQGw8fzKWBldm3K54UmeNi8g4wB5r9DTsHB4DbPXujtYSXw92/ecL577GZo0dp3aa4Gwczh18ZN4IE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AaqFnwHm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TN4wR6030437
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qGzcms3g66ClBMUbAsGHzO
	LkXJSGY0Hq5IfiKugct0Q=; b=AaqFnwHm6yBQRurkcdNN6iPNLtySSvS+eMRbGb
	MQ4XVxHDG2f6Jb1qAhTo717ER5E1K8svP9YDRjmO5b74VP5lhRv7Q01SZ8Gwr8lC
	ZKWujMFlnf/WKJZ8z7ARj/yfVIP1V3IvstFRFVp3vQ6wfbAQlRl6ZvTGGnwKRJYt
	mLkQZl/M/Z2FLDHcKc3UL+DEsYoDIDYq4dn0B9Occ29t2fMT0XN87RZ5gZFUKOLB
	g/inyzDTpzCswWfmbR+PpaGBnbXx65/kIxurV2CTeP9pt+mjMuugzk/XAd8ghkWj
	nytkAcr8p/r4c00o4tpoKN1H/2rjFxUhNHBx2sJq5lAImWlA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9jpu6ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3183193374so1391382a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jun 2025 21:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751256937; x=1751861737;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGzcms3g66ClBMUbAsGHzOLkXJSGY0Hq5IfiKugct0Q=;
        b=GXeTujPtNgwdV74t2uq8b+LbcHUb7utrniiWMt7LG2NMRtjYoSKZ7hzTPlDQ66MJmQ
         bjVrhxh3EF9Of3M4roAZKgj4wL9szQPxshntSSh4fhbe/AuhC0FwN0BLZKv475qj2Yak
         RavxCqWHdzmQDq8kxEtzbvb3F9Z+eXCz1uigtWSwAUvWYrs79WIOg3ImyN7V0i7c5xMn
         7KX6WPynyJ8A72asp533wjFRPwL8e/y+hEjM9ASIC/m2dSImxotjmpljlaUemmk4qSQJ
         ru4V8g1UsrYGZcB8ssQUuMOMZ7n3qBWX100/jQSmmMvAXry9K/V8wtnqhyhVPyLCBKD8
         KW/g==
X-Gm-Message-State: AOJu0YygJFLzuJpTEvzEI/ONlDK8PFKn1WWNhc234xWc435qRGc/SxuB
	ZFht5tS7TOUcaN8AT2K9xPo787zf6wZ8mTW3gyvP1OWD9OD8BxBQXJD5RK4Q5SO4lhtG+iPfUqt
	pCVeVopy6YFJYUVxf4eOCfhANwCzMUnq14dxmGrGzhtn4S8uot3DMXlCqTQAjSwjsJx7DgA==
X-Gm-Gg: ASbGncsFEI7iddU8pSB+/ObT9gWLiBMRyIvhpxMfvadyQ4IC70aGlDZ29fTXRGFZwT5
	Rwuyedkr7H5IGCqAfFmBuU9YhNA8s/oQRa+tvYIizJnrZCg+r97IeaOH/g9yxOEUgYXg5FmOBYb
	9Fe0CEzzZ5Xow1sx5C4SawXUjQ4a41LKsDY4hSiOFOMMSgZIMZCHzTtVXwxAgEYgMu2sjZxz44f
	vXWPo3S+QEACLch46rDrLc3+xksnFe+DBatjjOq8yatStQ3SFckwRLuroq2U3UndQsH68zuAvgK
	6kllpo/BNVFoK4URthGmGlseZbsaq89TeyGgiUzN8Imjirrd6CVWnj2IrEfK5+aDBjAYAe9Rgo8
	6+Wf+6TwusrHTwxEBCAIlSucrGtWu/fjLVLsblSlNt2+TjUM=
X-Received: by 2002:a17:902:d2cf:b0:235:be0:db6b with SMTP id d9443c01a7336-23ac46072cdmr186350315ad.45.1751256936649;
        Sun, 29 Jun 2025 21:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqeRKfxDY/iKMYr5DMAalZ4UACgTDBd3pi1SPietxc+zp47vSCTe+s2PWEi7FrhvcHcloqnQ==
X-Received: by 2002:a17:902:d2cf:b0:235:be0:db6b with SMTP id d9443c01a7336-23ac46072cdmr186349995ad.45.1751256936247;
        Sun, 29 Jun 2025 21:15:36 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f069csm69366955ad.59.2025.06.29.21.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 21:15:35 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: add support for Tx Power
 insertion
Date: Mon, 30 Jun 2025 09:45:14 +0530
Message-Id: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIPYmgC/yWOSw7CMAxEr1J5jaU0ERVwFcSiog7xJgmOW4Kq3
 p2ULmee5rNCIWEqcOtWEFq4cIpN9KcOnmGML0KemgZr7NkMzmCZc06i6JOgVszpQ4IcW422KDo
 3eN9fJhqvFlpJFvJc/wN3GDVgpKrwOIjQe26LeuDdDFw0yXe/s23bD5rnrcWeAAAA
X-Change-ID: 20250630-support-for-tx-power-insertion-336ff18dea92
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDAzMiBTYWx0ZWRfX1SGSs2mlsIyk
 wMbsF1H/GqyJ3zOS8kcm46ayKRuUg6+tsWlr5LmKqKl0oOn2e8aiOFBjBLIvpL7VXvOOxeRBb57
 +8hzauhNhnfsvmnX613aK7SYO/OhZoZ1EedbptcY+oqKmR7+TDuoYtlqeSKeDrCpV0fWUMCy/Yg
 cLpqDvALHBujepPikQA67BsauNn1uClWyn9Lx7LBHwQsJtDpm3wy7hgxZMNSW+aAppGJuD3oVHd
 5GJ2CGWmOuHoAaxMx237jwf0cacxL+Nr4GEgafn8chbDDXkUi2b1UloMRSF8ekeE2dw9algkPTt
 LAp/eJkJYwP45OCqvWgrMStkQ7XeZVOP1ctJ3NUhqblho3Strwj7neNxmqtR1+VTjc824I9frL2
 JerYOhf+b1VOXaT37YD3zetlxcU51kU++Z0rAm/8zZQPDrRM6zzfuJDyDDzTwEmqXJnhq9Do
X-Proofpoint-ORIG-GUID: BJ2qTEcFRnbMRXYtXpDWEZt5CSWylN1a
X-Authority-Analysis: v=2.4 cv=Tq7mhCXh c=1 sm=1 tr=0 ts=68620f69 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=j-PG032osGwMdhHMkLkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: BJ2qTEcFRnbMRXYtXpDWEZt5CSWylN1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=915 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300032

For certain action frames like the TPC Report IE in the spectrum management
TPC Report action frame, and in the Radio Measurement Link Measurement
Report action frame there is a requirement to fill in the current
and max Tx power of the device in the packet.

Add support to populate these fields in the relevant packets. Advertise
this capability from the driver using the feature flag
NL80211_FEATURE_TX_POWER_INSERTION.

In software-encrypted cases such as PMF, skip insertion since the packets
are already encrypted and cannot be modified.

---
Aditya Kumar Singh (2):
      wifi: ath12k: add support for Tx Power insertion in RRM action frame
      wifi: ath12k: advertise NL80211_FEATURE_TX_POWER_INSERTION support

 drivers/net/wireless/ath/ath12k/mac.c | 184 ++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)
---
base-commit: 391a83d0c8ebb1e476cba73bf4c010af73993111
change-id: 20250630-support-for-tx-power-insertion-336ff18dea92


