Return-Path: <linux-wireless+bounces-25016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D2BAFDD7E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631BA5682ED
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F52A1C1F13;
	Wed,  9 Jul 2025 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HgPaaBgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32D1865FA
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028539; cv=none; b=aPYsMV8RMPmOo3259AkmUGAGzViCopSMxp1xR1EdnjEfjmFwANMlOhexDumlp4AjT9Q0vuq+bKluOdWa3WqeuPwHp2tNKIx0NcRiad9K8CPpV+aik7IqxbbtNMCZbieEWAY+TzN31/PFvwVvzerj4rkUfZGIgGr7tNF/LqYWJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028539; c=relaxed/simple;
	bh=9TO0Ie/tiu0fshmmifYBLUQYkYOY5QIWQq2+zPaxfDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DeOrzcOPW1v++UmhkCh/I1+1XAxLNwMvV/7botqQV4Q35UJnMMWgNHGgQirDhoRU3Hkvk6hruBXGe4cEc9Hyr1s3NYzPjlW0+IJzF+W0LL7fq+Mu7UU2vFI3NdGTblfoBvelSW0IkPYTL+iLbh5Uc6qf1PKwyVyLMzFOCa1WFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HgPaaBgN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JIVho025447
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 02:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hLMsEUe26f5H9JEFiKOUnL
	PAORFVeXyz8x7J6XwjUvk=; b=HgPaaBgN1Q3w9fvb/kbMyfgbY1iCkkHoeroPED
	UVvPc+OigvogN1u5+170fcUsfxLXNQzL9hQWG9U9DqaOwbYFc6BKFEBckhwNVgns
	dSLTvrKPNG/rMcuhbuOi18/i21akVMvxEMfXgpdlhuwgQmzMyhgb/MQ1MjOOMHZ9
	C1fhwmNnvzYOv26bPabt9+iZwP0HeRkAfQKkniLm9rFpnRYt+HjxjICdg5AfNCTd
	p/kOndhWygl82cCmYas4qfjDZaJVugchWOki++9Mv3Z/9YGAmVEsRdQKkNg+HoUu
	iMAK/nx+yVrvIqPmkqCjL5QhRyLTGn1YGdJQ9/0V0X2E8JUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wj7jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 02:35:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234906c5e29so64473945ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 19:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752028528; x=1752633328;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLMsEUe26f5H9JEFiKOUnLPAORFVeXyz8x7J6XwjUvk=;
        b=YUHFgvAbeTDTIdN6OgbZh+puEq3hEts0bzmeFksXKyD+Z7giesy9dzwh0sVdcrw1Qn
         h/EPqxl+ynxL8M8GzunbokAwShRNYDZEowzJymaPJE6AZhSkWAll26w49spZkOid9NOy
         TrkgMXMTyVEs+8hxS4geV8QIpHDcn1gCsVE90kTOu3NxsAI/dEiTu9dSTvg/WjMIgIHn
         1db5PRBPb42NehKhQEHAkb9p3ZSCTs+nwRgjrhb+zjEFA8GSMLi+1cU2aXE0YtjHPki8
         HWo7jYeYxU5wzz650lN1VDWJYbwXbs6fbGQjt1dXcgvQSwCEY9vMZOuBne9CHcYH61Pi
         h4sQ==
X-Gm-Message-State: AOJu0Yxu8y4xNhkyLrbhb6Kl7Rg5SiNY8ovz3Yt+LDW3vopXY5Vbf27A
	x5oIXcOgjmPd6EO2aZ5HcWp6kaq8yY+tltBDC2pemu4cQ+E494fKvojvD0t/WzJsSwHL8B3h/T4
	o84G1yXYOT4zxRqt2k/k+Wea4ieWAOk5D10JNRRTPc6I1bfLzRRt9rQ5BMeAnFlE1/Dtz7A==
X-Gm-Gg: ASbGncvzOQEhFDDiiJmWVApnEiCukxCTAr7tMxE9uk6HQDZv9PfuENqrPdMSA/4d9Od
	gdYXeXTorPQjVKxVU3XdfO4H+BOkINYWz9jw0BwUH1s2Rnv4MrSOu4raNCx13valu+Msrdk8xg2
	k3yVmJQHk4SCI69CuSoy8KRNZ4hwFmj/VJsO8o1rIC0Q7LWmJce4/fPkUSCyQPTEZDTxGneGlrB
	3gNUmxasMT0JSvQMzX12QSxBArgIyPd8R42Kl74o08ZoDMCxqyb+COxDRYhbWyrLwAPKK2uaRWI
	f4gMbYhfkHVYuuyuo63ko0Om6Gb2krn150tS+zK7k5LNaBBz0xGlgQ/Sn5INo+R9pPRQ3pTueez
	mysNaaIEHrxcNycOfKt9lT9Rwku5NvOpu4HhuSqIWjojR1+c=
X-Received: by 2002:a17:903:3d05:b0:235:a9b:21e0 with SMTP id d9443c01a7336-23ddb0c8821mr11858385ad.0.1752028528593;
        Tue, 08 Jul 2025 19:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhfR0QvmpiQ/tYvfymKWBtnaEA+zKZVZAoyoIq4XGfZxPY3DboSNdAbywwp4KVgp1XVSKJvw==
X-Received: by 2002:a17:903:3d05:b0:235:a9b:21e0 with SMTP id d9443c01a7336-23ddb0c8821mr11858105ad.0.1752028528181;
        Tue, 08 Jul 2025 19:35:28 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ef2bsm133169315ad.33.2025.07.08.19.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:35:27 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/2] wifi: cfg80211/mac80211: parse and
 update unsolicited probe response template
Date: Wed, 09 Jul 2025 08:05:17 +0530
Message-Id: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXVbWgC/4XNSwrCMBCA4atI1kbyrMGV9xApSTpqoDY109aK9
 O7G4sKF0s3AMMP3PwlCCoBkt3qSBEPAEJu88PWK+IttzkBDlXcimNCs4IL2bWU7KPsGY106b7E
 r2xQdlAmwpd6YrSnA6UIxko02wSmMs38g95CgBkTawNiRYz5fAnYxPeb6wOenT8gshAZOGXXgK
 1BcMGf1PiJubr2tfbxeN3nMgUF8oYItoSKj0hunTsAqo9UfVH6hchGVb1Qr5Yz03jD+A52m6QU
 rrCgeigEAAA==
X-Change-ID: 20250612-update_unsol_bcast_probe_resp-c88786eb5640
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: VxBO9EU9QLn4-xmE6tyhSP3AUNo24XpJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyMyBTYWx0ZWRfXwXJUiTGshrt3
 lDvoNtUoIbv2zRASPG+8jzKsKOtcLHbpbrZ0t0aZ+AADOgI18IVrgjeOas4zqj582NKoYJQzNbp
 wDj8WEaA6ztSIpXEjAH6YHiHyQPTFZ4zyEcVkumTcGnl0OMIkr4Vt10Sl6RPAk+tNS8XQ7ue+xk
 CJcT5LI5uSd7QnhDuwLcvj6s/kktn0sy1mi1ZRStZ5wN0PbF7xh5MCxA0xQ7+4Av4hoSvllBuwD
 332xIOap6NodK9oc0FVTOXWHvQJoNIw4dN1MzV/WovvuIYz3qljkJIWCluotuZ8QQwzNViESHgg
 RXtusY65ZjZ6Dp4JCUX3ZvajyZdFP5LRX1F5+EMneAL26xLyEbONe5o+ac9vbBZaVXzps2V+KNV
 86b5dwFh9WgTNIyFvfJImmPkxAD/IIdnO192ZLOuS+u8IeJdtMmkNZ/hEwfvbFCrBNjm9Vi/
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686dd571 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oCrXEwr5G_U2PBqafwoA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: VxBO9EU9QLn4-xmE6tyhSP3AUNo24XpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090023

Currently, during channel switch and color change events, the unsolicited
probe response templates are not updated accordingly.

This patch series introduces support for parsing the updated templates from
these events and setting the appropriate BSS changed flag, enabling drivers
to respond with the necessary actions.

---
Yuvarani V (2):
      wifi: cfg80211: parse attribute to update unsolicited probe response template
      wifi: mac80211: parse unsolicited broadcast probe response data

 include/net/cfg80211.h |  4 ++++
 net/mac80211/cfg.c     | 12 ++++++++++++
 net/wireless/nl80211.c | 17 +++++++++++++++++
 3 files changed, 33 insertions(+)
---
base-commit: cc2b722132893164bcb3cee4f08ed056e126eb6c
change-id: 20250612-update_unsol_bcast_probe_resp-c88786eb5640


