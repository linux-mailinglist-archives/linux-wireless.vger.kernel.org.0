Return-Path: <linux-wireless+bounces-21767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B6A94B06
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B81188C6CC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC162561DD;
	Mon, 21 Apr 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+zjEQ1f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00B17BEBF
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202937; cv=none; b=UcAveoLimkixXfsOlhVZMpNZGANLMkd4RiLU47u+aTlHYDWANicPNce3i8SI/JIhlUKiom/G4Mkz5jbGIT1Ctoz6Kq9dsl83gqaufgsJ0mWrNjrJPeExM4qpAGufKJNzSh5X+gfYkLaHAeQgLhnlOcsjQ5OrlrjMmWKtgH1uof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202937; c=relaxed/simple;
	bh=PynSTx5juJKKbG8xZydzO4iDHs2RJgq4NypZJsbDUos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTo7tjgFfqPc9ixBI42fXB1BI220kEfrbfAhC4wyV+wJRZU6NhKQ+1C42xdNOt1BbWykBD3BXSEB/iJS+zj+5HyM2yibtFBNI2hK29LXLuCLwK5zJ0uls1k2unz6Wp4pOz9+QytVo+VUmbPIKevC8FYXHA+2VUJkofOPzmun1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+zjEQ1f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNDrVD025830
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tW3j/DnQ/3J
	QHYjRoZr4kKxIV+9c+oTW2VadZhYyqC0=; b=S+zjEQ1fwS/x18fHYHy3HkSP3Dx
	w5p8IdCS7F7T/yvFb4PEa90JLqDQ/q1KrRPJfI4HIgHrrFl9UyIcNJVKF2BRgoSd
	NPtNgOJ3AktD5Ih2duu7YSqNh7WwN0Lxk5BJFGPKmLMhwnPsd+pjZElC5kdHcmW7
	DgCm42q7jaSS4PYbFrEC2NKgRyxr+N5fCRiHIMrXdNyE3IXKrLvauEjfSVc7YynM
	L9kOZWJJWeetdisO9YXoGq8r2htf/IP/bPWC9QCB5/pkeyk4PbcZgRVpxWdNo/Aw
	hlrauzSwevUDNQ137ZVE/VQP05P92PHJtaK/qStmbdghsnS84ABmQCZ2uRQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464426jqv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so2761139a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202923; x=1745807723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW3j/DnQ/3JQHYjRoZr4kKxIV+9c+oTW2VadZhYyqC0=;
        b=YPCJfO9RZqjy9Af7Vbine87FgsCk77NplVkhtynwoA2jZJmt0mNB8z3Xcxej6pKk6F
         qJmnN4uojwWNALn/N1MpgLZPFxHPbthIjygQNm1JYPjrr7UGHwsLKRe/A+uz110aNu/4
         gB0N7rk541v+l2NKnl/yjvO/E81V3S2HsexfIQBdJ801wFV1e8Rmr6N07l69bpTje3ys
         +fG+d36amI3XZaoMENvePpYAjsVyrD5/1FI/HY2QgDV4MuFqBP2WUIFfsBSbrk3M3YF1
         chJHagKnMKIdAEYvua2UEggjyN3A/s46W1e2ZE/j7G9hpE2hTXoGctxmBjgpcT9hswTu
         3sJg==
X-Gm-Message-State: AOJu0YyXdGoUizGMmOeIgQiT6g4WaRp69DbzW4A8QQLC9DcVAUlD63pb
	IKvFMVN9fVibbZP2ynoIEHyvjtPd1LUI9k1Eb/sQMjKXAwhq3bvVewNMl4ukNLIq+jChzT1kqru
	2BSic5J85v7YRUehMlWMWW37uvpTzAWRBS5wd43oyI2rLg4sPYEiiwXQ+2E1EQSA2Tw==
X-Gm-Gg: ASbGnctKlVvZJI4Q/ZF9tI7M+jWR2YQ+X7VS9eJ3HZhri3qhoDoab2AQpD+Qq5wRLnK
	zKN8L8hAH1ugeSbFxiri9lfM/KGiImX8tbWCilTYvbUFPXgYTp6d+tCI+CqSxZQL3e+gj4kXxmX
	/8vM5ti22wLsjvJ8K5bYcgoUBq3UPt67aNotRtdvTnojYy/WzbrD/4GV7rhcssH9uICSDcKzi1G
	kUui690x0O18uI9bjfPgNq1n6sDHZuYTSbCJt0GY86cJx0SioEsbtkcH6tiAf0sHb/f6p+zIfC5
	PJkCYy0FWQ2APcmjq02EK1S2A2dHBQlMiVPOJMZSo1ZK2MlydSeAAf/WED7ujWMw9UbEtIpA/4K
	VRXfL9Vz32JE=
X-Received: by 2002:a17:90b:5608:b0:2fa:1c09:3cee with SMTP id 98e67ed59e1d1-30879bc43b7mr15652646a91.9.1745202922768;
        Sun, 20 Apr 2025 19:35:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/mlRGhasf2sU4iF4A5vEYt858J1hyPpugHlHFsR0aiwrQcwl6dk1z1Pj1OmGFdXZ3u9KOdw==
X-Received: by 2002:a17:90b:5608:b0:2fa:1c09:3cee with SMTP id 98e67ed59e1d1-30879bc43b7mr15652623a91.9.1745202922344;
        Sun, 20 Apr 2025 19:35:22 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:22 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 02/13] wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
Date: Mon, 21 Apr 2025 10:34:33 +0800
Message-Id: <20250421023444.1778-3-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DB5OC9c1Rj54H6aDkSLU_PGopU0Yf4lq
X-Proofpoint-GUID: DB5OC9c1Rj54H6aDkSLU_PGopU0Yf4lq
X-Authority-Analysis: v=2.4 cv=IP8CChvG c=1 sm=1 tr=0 ts=6805aef7 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=5djAQ6t7vT4tMu-sRqoA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=856 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

WCN7850 doesn't have RX MON component. So it's monitor mode design is
quite different from AP based chips like QCN9274, which have RX MON
component.

ath12k_dp_mon_parse_rx_dest_tlv() is such a specific function for AP based
chips.

So don't call this function for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 7404d21eed3b..351f52138d39 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2368,7 +2368,7 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 
 		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon, tlv);
 
-		if (ar->monitor_started &&
+		if (ar->monitor_started && ar->ab->hw_params->rxdma1_enable &&
 		    ath12k_dp_mon_parse_rx_dest_tlv(ar, pmon, hal_status, tlv->value))
 			return HAL_RX_MON_STATUS_PPDU_DONE;
 
-- 
2.34.1


