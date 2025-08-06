Return-Path: <linux-wireless+bounces-26168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A3B1C4B5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102A23BF035
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176C3AC1C;
	Wed,  6 Aug 2025 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nLMIynCo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223921D3EC
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479082; cv=none; b=h5Y15rO3lN1wiaF8A8HbBD+ZIynHylKoh2UQvv19JHz+tYq5wKrrrByLzklPPcSijLy3CsVhAkaUwAJmNRzT/D1cneQhTLXiNaNgIHVz3Up2Mrb6Ty5tpjpne9qPdH2Rm9zZI2h/0wKp5Eh6qsDQI5f/x697klZCvsl6bqiHN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479082; c=relaxed/simple;
	bh=YbrJgxQet659IHlPKtUr6ixfwTT5J18t2hG+2G0CDSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Wg9qT4lxp6Dwa1ub0p9W/d6kvH7lrG2V61J47iZPUiYREmUCiM5k9GBXIn2iMfE8DC92eYcfHf5z7LZEoI/8iYoGoF0OogBICMydoLQBRdfoOo8MIGeglvoCR3rp7dTJ9a6jRd7HGqu6QBIpuBRu1tokQ+CnRYverAoAwya9K8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nLMIynCo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765FeuH011120
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=M8OlUTnwZcyK3PYRJ/4A3K5RjTuSKvhawKHZj5H9zf4=; b=nL
	MIynCoSk7A0JkUUd2SBncKroYMCp/bTC6mYbc8fjK55yrc2uFZUQRDrOUd6aIsQy
	a1n7/o2dBga/xAb5us/hhhVfkgR8NRLnsJImKGGvG2fPEW9AtnwYFHTNMslmIxZ0
	z//POQdWxLMc7hUVeatHsl1vN+uNw8LF538zFZdjXJhmMjat3ZxbOFbOmFJGQziF
	30F8Qf3gWdOAvkDK3qtZUSvdLkBgXWxBwLabnPyGhD008qyjl0OsvfaLltbGTTho
	/d2RBmLEhOvm+t3acKmQdy/51tfJfZOYijQDjDfVCXER5u2KGSlfzrB4a/2Ppr/w
	aqMyxGRlslB2wDYeH/Yw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw32j2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:18:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76be7fe3d65so8891138b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479079; x=1755083879;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8OlUTnwZcyK3PYRJ/4A3K5RjTuSKvhawKHZj5H9zf4=;
        b=gX6GTC5FXc7LaLx8YNS7MmlAC5jAA3UlRRZsS7KQUlCMMZUaNbhtuG2/Jl10g2T9ug
         6VJVnki+j04sGGZZb57CPRIez7sVnQYXgfGTm8Co99utu+Ero+6QKf7b9+7YTMgoq5fW
         c30fePyu/V4yvcvgbik/4vWnPqNsZsIbU+bvtG2GAovq1q4GWYbQaUx4BO+g1GYuIM+U
         VkkI2v4umKL5mWoLkH2XnmLIGvYf1AJtSZOBwOdrl0MzoZJ0OqnoJGps9hxwiKlu3O/a
         mLXK66/sWOHHCkPk2s1d0kRyqzqTp2F7+uZgnedMKdIDK2jSMl5JpzTc3RL6aI3OUg8e
         K02Q==
X-Gm-Message-State: AOJu0Yxr/SU+9HVihwncSNwJK24u26BSwXJd48D3HZiRzgSgDOrxaf9n
	y9/3UB0Zfa8UkrFlKTasoyJl4XW++3+T6Qo9IZ89zl03pG4sE/UbmI4SgbvSozOTfdfDuhPJp7j
	8/BEF0/iD3UmkP/W7eiME5ufr3+VLqdwxe/3e0dnDdA4KLvAYOEMA91jb8RCNWuir6NcrVg==
X-Gm-Gg: ASbGncsVSrhoiqXCXV5U7PIDpGIGYIBK1nyw+kFB0PEa4xF+2B/bt6ZwWCkKThKuD2y
	htKgpA6YWFaKJcwR1JKYD0EAbTLXB9WpD7Cl3KDe1HBKZ/RkoLzW3fuDeBYupgFIqcO00VxlkR1
	IWaob0J3JbJGWWHWMGz57kXWcJcd3gyaLGiCHByBwLLNbX6BtEid1xBSYW6dVwbpvKgvo7O6uRU
	SxJ6cNA740eRWW7ljANMWlK+08jSOUTfFIFT4tW0rSm2lWVws1oK0s253CVq6+87YOcGJHD3F/b
	O/vYn3lzru6zaMwZ4f6TFlEeL5K/a6pEdJ+AIugJDRT34I/cvdXZ0mDL8NcF2EoJpxECiu5PJ90
	g28DvP7qLgbIXvNEgMpIQCD1xlI4C0q7bnbu9q49CEx0ta/Gc7K07fvN50k63m6G7OulGf+CjUw
	==
X-Received: by 2002:a05:6a20:748b:b0:240:f96:3153 with SMTP id adf61e73a8af0-240313b273emr4417290637.29.1754479078723;
        Wed, 06 Aug 2025 04:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb+fouAuUF/TdecC/26sFjTqCnmLWhb/ae7a5ZTqc15XHhchI0KBGtqhIa47bSGVut5tGMdg==
X-Received: by 2002:a05:6a20:748b:b0:240:f96:3153 with SMTP id adf61e73a8af0-240313b273emr4417253637.29.1754479078314;
        Wed, 06 Aug 2025 04:17:58 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:17:57 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 1/7] wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
Date: Wed,  6 Aug 2025 16:47:44 +0530
Message-Id: <20250806111750.3214584-2-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXzZ0SchTC2gf7
 H6uen8pJL546rRKOuYHroxtUQM4eYHSbL1GwwD5SdAwmUWgHSpBIFE45dIiBCHVMTekv520wHkf
 MM0YNLgGGSb2Pju6utfJc5MG74Xeui2PeAHUM1g4hLG5xO76vAcJvhgxZF7jHc2obCa5NAJ64iK
 bp+Sq2VBy4+ieKtyAFDC4ZQ1ddHjSri4b77T/142hhdqJEcSffY6X+Z6vKx18hd89KHpcpaeW+O
 utRytkKnzNTJsowlQ9wYusW0iVfGF2jDbTTtTfYUsAYb7bpHitVIKrUPZ/5z3JZWAgSVPMb51PL
 Hfn+pRGl1QTwNxwXLSEV/mR05/jN8pm0PBPQ2NSsuDtsi/cVwo4AWB+jWMd/ItJcVCClpZl38cG
 zTJ20E+9
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=689339e8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=nBVPt6iOZMBRpZ3gKqsA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: xTGt6iJEzCH40enPt6_wyUk10eTrtMpe
X-Proofpoint-ORIG-GUID: xTGt6iJEzCH40enPt6_wyUk10eTrtMpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Increase DP_REO_CMD_RING_SIZE from 128 to 256 to avoid
queuing failures observed during stress test scenarios.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7baa48b86f7a..10093b451588 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -184,7 +184,7 @@ struct ath12k_pdev_dp {
 #define DP_REO_REINJECT_RING_SIZE	32
 #define DP_RX_RELEASE_RING_SIZE		1024
 #define DP_REO_EXCEPTION_RING_SIZE	128
-#define DP_REO_CMD_RING_SIZE		128
+#define DP_REO_CMD_RING_SIZE		256
 #define DP_REO_STATUS_RING_SIZE		2048
 #define DP_RXDMA_BUF_RING_SIZE		4096
 #define DP_RX_MAC_BUF_RING_SIZE		2048
-- 
2.17.1


