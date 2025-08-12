Return-Path: <linux-wireless+bounces-26309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D279B22613
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810A35060FE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436772ED870;
	Tue, 12 Aug 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnR1ia3W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158D2EE603
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998874; cv=none; b=ObUVPKTVrD5KoK4e2A5w5SHyNNPupZBtcIb3PUsAgmktl+7c/SvYok2J5tJBKyqllc81swseFnh9Gv4/emn8ISeGtWfkBgawjsMQPylZqTDpR+ytv+zpYZZy6NADVWZ1fmWA/w3p/hIXJ7kC8GcuWswvxHVOK4CQVWu0FLI1lAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998874; c=relaxed/simple;
	bh=xV3QcQt+BG4pjB0xO2mCwPBqBLrBnkGB7FOs91zLH7w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oIMZTFs2qMj1SYZqy1RUbcoFea3rxgP/kAz9U+1Lu5VePEpNu891UlbNeWXguy5MU8s9q8mZ11pPsa91Yct9ArWYIES6p+HOQu7Mf6RiuAnXBBjjkDhN0JqMqa2qXFSAsqOQGW+f1OtNpow0mBzB8zJlyNqyVONrBr8yjkbD2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnR1ia3W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAwdRr025489
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=3R5sDKEWhocU
	MDXHKlZvSUM3IvYOsSpaRd8M3NjbJZU=; b=FnR1ia3W+bfMDOGZfK1lh1J7FxEv
	gsfm7/kQIhAVa9hXw9yLoQUYlElsdlbV8kevsgBPFzfdJan9JYKX1Huv0oF8ArQF
	iv1475iX5vbcbM9S2tZFvD+l1jPmjUgebhpBA5IbDvjlLfTR/pfU3WUsosYUhOqT
	v7ZqXVTIjfIxyMeQzBgd0XAvNeDuZbacKP0I/Hz6TJhHm9g46kVabKB+2Xpfvh3T
	zGW+xcC9RiaQO1+HULPhKLqWxZNlmQK57h/tMoaybxrTU1QCdlgKIFtwtpK9Ars4
	sWSi185FajAkJLBZhl556pHT0CXsbEmPV0pqkWM5zaBC/bPGtraxsnDCUw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sr58s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76c0039e0f6so5629488b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 04:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998871; x=1755603671;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R5sDKEWhocUMDXHKlZvSUM3IvYOsSpaRd8M3NjbJZU=;
        b=CMYEEsieje8552NH9/sm/7ULRTbuS/MDbIawFZSj8TKR9Ymz6upiDOWASRTFnkK8Nv
         ZmjsZqgHGnZs/1p3aiEcb0iL47oqnxEO47TAv0P/ofggp1FPic6Aig+MIKcPn4SQMAaW
         CEHlRx1d3nV0b/b7MxNBHyDw4hHD9WYTUSFSCi+lZue7Rj00HVjgBbYuxQRpfrSE6TfX
         TMD2zOGet51zGEo1jbfltXQBHrzTqMGSxRDAdN+ACmkE8DkynX5IP0sG2HVeet9lZZBl
         3BLE++C6xcjTxkVsbmYCOuqeoQmpKyPL1uPujwR/Y5kMvQ/U9sDT7X71g4nNqCcmIIn9
         z4+w==
X-Gm-Message-State: AOJu0YxF2Z+iZtJSZvlgQeV3e04QMfILOGaLn8PJDrb5kf8+Pux27yuM
	YVZKdMtnoRd3fc/KzKSe49Gm0ttSBSUc2Mu99dQUc6aQBSTCrL5IjCOvDT/tkg2JaALjvvAKZ1R
	oPARtgntqVk7PyXqDXtwr6fswkmD0XodFDBSGm2xf1HwbkbbaAwWiYOP5MIe28NkDQCtMCIoyPg
	3hzw==
X-Gm-Gg: ASbGncurzHqSEn0yP3Lv7NHca01M/YwKj9ssEMdumuBlzSvYmY7NFMnX/wTV99fzi/x
	tIKLWsOMHvbw/9o3VGoLmnea45Vo2X7Fs/LcwWvqJnTbwTev/5NyIrzUNueGSPDUC3Y2xSQTrL4
	aZzdlPpLdrul53GYTV1d55HfqNZuAhlyOjpkZoOKkyLoOMCff4aozhghwEnxD38DWvBKdfDP8EZ
	jjJ1Onq8zYGsnD128vKFN0ZDEijbe7FYw0rWMDxfxnY98dXGjp+JSEkSvq6lrR5XXpgcVJ2KrHt
	ArA2gymlRq7wBYLfcak14Q4ConT/HNd6KyrP95jIm/hhH7l62C41Id3gdhWrzP2YG6/HI+McIFn
	KMfSc5IA=
X-Received: by 2002:a05:6a20:7289:b0:23f:fbe2:c212 with SMTP id adf61e73a8af0-2409a97c311mr4596307637.23.1754998871034;
        Tue, 12 Aug 2025 04:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeXam99PvwZefaYQsAUhjmjtcbr85xqKqGTLLxVMjyAZOxzHU6LI0gsDb/mmoOePY9dko85g==
X-Received: by 2002:a05:6a20:7289:b0:23f:fbe2:c212 with SMTP id adf61e73a8af0-2409a97c311mr4596270637.23.1754998870634;
        Tue, 12 Aug 2025 04:41:10 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm29344061b3a.54.2025.08.12.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:41:10 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/2] wifi: nl80211/mac80211: Add support to report time of last beacon
Date: Tue, 12 Aug 2025 17:10:27 +0530
Message-Id: <20250812114029.23538-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689b2858 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=kBEhk56_49fpdFUAZUkA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CFicY4He7ga8XGNQBZivf7s3pe9NFm1e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXxlZf2JrpKann
 hJ+HhcQTAuVgAu25XBgPSyliafjza3mjaHMvpC9mvtgHdKisOokZ1Wpm8Ui202DPJ4upQKgR+2R
 EU6dWMCCz6usUmvFIAUmrOGo07uzm7vDU42YAbeDfsA7ii1FwHd2U1T65DJDBJKSd3djytVk78k
 pMSRUIaWmNXdQjHLmUSOL0wzvUolKo79u+cLFuY2YDAoMynU1c7Og58kSuGmooTo0oGGcePZXiR
 z8t1dKcwWWZyKsdySKr6YoTmhwJpMfxxF8qwSZKQEficKv7/BUQP9YI4UsZZOgW7pr04oj5Si35
 v+ksQ9fcFby/wPzwPYN0tkiFAB38E5IRJJmiRW7dz/qBuzVmHB2gJ6FVBeuCYZ/hVGKIHqF4g3E
 y0yn8OHC
X-Proofpoint-GUID: CFicY4He7ga8XGNQBZivf7s3pe9NFm1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Introduce a new NL STA INFO attribute NL80211_STA_INFO_LAST_BEACON_RX_TIME
to report the last received beacon time to the user space.
This will help to detect if any beacon miss occurs between the mesh peers,
non-AP STA and adhoc modes.

v2: Addressed Johannes's comments from the v1 patch.
    https://patchwork.kernel.org/project/linux-wireless/patch/1653893292-11092-1-git-send-email-quic_haric@quicinc.com/

Maharaja Kennadyrajan (2):
  wifi: nl80211/cfg80211: Add last_beacon_seen in station info
  wifi: mac80211: track and report beacon Rx time in station info

 include/net/cfg80211.h       |  9 +++++++++
 include/uapi/linux/nl80211.h |  2 ++
 net/mac80211/mesh.c          |  4 ++++
 net/mac80211/mesh.h          |  4 ++++
 net/mac80211/mesh_plink.c    | 18 ++++++++++++++++++
 net/mac80211/mlme.c          |  2 ++
 net/mac80211/sta_info.c      | 31 ++++++++++++++++++++++++++++++-
 net/mac80211/sta_info.h      |  3 +++
 net/wireless/nl80211.c       |  3 +++
 9 files changed, 75 insertions(+), 1 deletion(-)


base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.17.1


