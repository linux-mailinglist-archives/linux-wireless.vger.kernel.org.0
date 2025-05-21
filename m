Return-Path: <linux-wireless+bounces-23237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3BABFBD6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFC31BC69FF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC4256C94;
	Wed, 21 May 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CaDUV+g6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA723A987
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846781; cv=none; b=kmTRftOp9ovDBSMYcpGj23KcgAzcThsDZejla7LVGcrkYF8aelxWvTnaf6vapEbpPJNx2sj0D03o0QjlvReTAEAfrtB+4D9Vj2My1pv5r3W47xIuqJ/tkZ/lk8qk8w3Ek2hrQvL/DUOZSTmOhsvViR7ZJJ3OJyjqxxYxVvxpONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846781; c=relaxed/simple;
	bh=ZLxhqVrgD1aG+H5ifsU1SecBZEhPsL25ubEigTaeSYg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dYGhy776IKu3myuDMIb1VdolQjC3++NqgbZIQYy+xo+xD8mcCafZcVxSxbYTMUV+gYfJ0C9AXDM+R3jhW2ShlbTcAtGFx9TmQCy4aoHdpR72uhP+g6bDNxeV4wi2IY5ucRm6B4c8YsG+0H0UQVZ2QNfjG1LydngHjdk0XN73Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CaDUV+g6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XTeA011376
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zr4WSApnfNvfnXCeJq1mAi
	DIlMO8zxTYHyPtn0ik4nY=; b=CaDUV+g6h6ltTYOonhUfIS5gPp+CcfLIUJAt7O
	qFFPW0pCe8ZOcJ8bCrNOrd5veZTv+XK1y5FZyBRDGJx/Ar3ppWfZAgAMjEsQFnjm
	8E5QAyB9krRb0GEy6KFG7PVMw5HzJGk1Y+SvnfRc5VptMVkljGoCZRwZkIvtf7me
	Go7W8wWonKhQt7UWQOk9lt/NwjIc9nkv0pKzVzqwQJwcZsBRVd+jmlpZ3ZSRevR7
	d0SW9GWU3nHoMOKjQ1is0KRTdP4Nf94ZQXHO+e1dbuST/Srjo9raLYG8UaZeNM8I
	Y5sC73VFIZpsMCD3JE1N/GKq5qjdrVt5gHUGkepCLi7y3ZFA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfb3max-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:59:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30e5c14b49cso4798352a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846777; x=1748451577;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zr4WSApnfNvfnXCeJq1mAiDIlMO8zxTYHyPtn0ik4nY=;
        b=XxaVnVjlmHds1vpYqbDfEdXADnioftPOd5nkLzOo/kGHxvEHRvapizCALDbRUpz8yz
         0HCfy9PWQudze48CAxFlnHeGz0WvjYCdf7QMHPX1hOzPTWr2eU6MPXvrnL0Kw1VPLe3h
         wrV+4+UNlLBdl9IZax8MnDCF/pwJnK4Y65m5L7F50rhVUz1mBo/Q1NiJuHwt/8NpCFKb
         0r9xZDkA9H7oXZOTsAR9y43y115uwb1hSU7nDC2FQBybI09SEjhOGNR6hFwK8OvnpjMD
         zQyQhJszlO1UDKGsgJnLazXBi0SUGtrqvkBx0KWalWXN0TT1zoZnwWn7T7VODBx7JK1a
         qgdw==
X-Forwarded-Encrypted: i=1; AJvYcCW17cArcPX42H2+6UccpmCL/Ei/k4KW+aZttzSSK46lLFFKrwETJvgdz5OrkFiFH0+d65C3nuoIX6g3aWMLIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXQYelTS+amc7s9UxRELmHas+KNuhHDXBes0vYuDXBs9Cxp2h
	HD6os4QPt6bdF905eq5MexyTPLRcxGWokXGT9F4+vW/eSdbtA9ShbtS45QvYdK920qrvwAh68VS
	3S9vJ5AgV7avly/hTKBemx/+kuaqQcAvpFs6RK7Qwau/umSnNxkNCp0AEpBInHLBAp3tNHZCBxW
	64PQ==
X-Gm-Gg: ASbGnculO1lDy/6zSWHXeJKmwNURXd9eX0twbbuBEVoCcVH8E4Cj2Du8IVhYBQvUfUj
	h8Q9qpRP3TwEU2c5QaIzIg1IbHYGX4WSD1UmEVivTwM6EIYz3yiq23dDTOf0svE8VxOE7FTfhzk
	irNtSmnDw85fdMCBks6emSpyCcR8S0QkRuM4dBeJubj8/oafzaB871rQxEHXcVggsiw8CV0MpcK
	uwIIdXRijKQjH0bbUEIxNDm9qmVZLEIoOqrc4rm6QMFTiPdT4My0p+vFUmcHbpcxo3zeieJ0PRk
	zlF1D/7gTt7rB0N4imSq+3cbSu/Yn8Q07gc0DoDfB/2DGIvHi00TUqIiC3jdBby5srC0SrMu5aZ
	0moKtKKGGW7Tq2fo4updH15KDdtuFwuChOv9s
X-Received: by 2002:a17:90b:28c3:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-30e7dd430ddmr36472190a91.8.1747846777523;
        Wed, 21 May 2025 09:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKNrVIcI8Rdmnz/M0wlFT/WEJL9WfEZ6e9A3coQK80grSSbO+IdGvRiCwx3jNOkI6C930Cjg==
X-Received: by 2002:a17:90b:28c3:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-30e7dd430ddmr36472148a91.8.1747846776986;
        Wed, 21 May 2025 09:59:36 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365c4ee3sm3875055a91.18.2025.05.21.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:59:36 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath12k: fix several regdomain update
 issues
Date: Wed, 21 May 2025 22:29:28 +0530
Message-Id: <20250521-ath12k-fix-ah-regd_updated-v1-0-9737de5bf98e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAGLmgC/x2M0QrCMAwAf2Xk2UBaqTJ/RUTCGtcgdKPtpDD27
 4Y9HtzdDlWKSoXHsEORn1ZdsoG7DDAlzrOgRmPw5AMF75Bbcv6LH+3ICYvM8b2tkZtEvF2JQyA
 muY9gg7WIaef8CdZhlt7gdRx/kUXGUnYAAAA=
X-Change-ID: 20250521-ath12k-fix-ah-regd_updated-630a550a0e79
To: Jeff Johnson <jjohnson@kernel.org>, Kang Yang <quic_kangyang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: iVFwe-VJOYa_bkwH4G8LBlbk5mLUF-wo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE2NyBTYWx0ZWRfX0WAx36YiGn/E
 PD7KRG4/JZJbx1xE31Q2GG3pWjd6ePHA5W1Bi/hmjK+Z+Gdm1HyjC/56Wx1SCJ0r28uPJG2gH6I
 0+Oox4iWC9aQj7+245Sjmz/IWaB5dc6a4dezNDgW1PrasJi0Cdmv6rHEy8KcY9XvRwHi7ofk0YO
 gHRE0O96G1zuh3lNeH3cRjmjgVIfzijehUeywZs7WKDqj4hHfN/XD3ZfI9ZZ3AyI7iXUW24D2u8
 XytULskbS3uFxO1btS4VMF/dY+VNofcnrAxDVu3C2lIVjCKLgBjd39+Lql6zI5vrqx4lrdTM1du
 /jkyjDCjjoY0umerwiy+JXyiJ7op2WNj9gU58j9t+9VP7VTuysNCV4npowm8i1LZy63FU41ECnH
 KuvTMSGkPg9coMV+tC9e5pMq1Ud2UGpKNbJ4KN3Z4Wu1hJ5nuc9KYm3l9BXhzayDLJddrtH8
X-Proofpoint-GUID: iVFwe-VJOYa_bkwH4G8LBlbk5mLUF-wo
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=682e067a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=cVR6XFeMKWr3T3-t-FUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=825 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210167

Following commit 4c546023d71a ("wifi: ath12k: update regulatory rules when
interface added"), the WCN7850 fails to connect to a 6 GHz AP due to
ah->regd_updated not being reset. This issue is addressed in patch 1.

For the same reason, regulatory domain updates also fail during interface
addition and connection establishment. These issues are resolved in
patches 2 and 3, respectively.

---
Baochen Qiang (3):
      wifi: ath12k: fix regdomain update failure after 11D scan completes
      wifi: ath12k: fix regdomain update failure when adding interface
      wifi: ath12k: fix regdomain update failure when connection establishes

 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 drivers/net/wireless/ath/ath12k/reg.c | 2 +-
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 5b5f14fc4d737a956dedafb996459c4276f4fa49
change-id: 20250521-ath12k-fix-ah-regd_updated-630a550a0e79


