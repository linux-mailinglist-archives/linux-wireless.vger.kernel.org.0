Return-Path: <linux-wireless+bounces-28001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478FBE60F1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 03:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E950A353FB6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 01:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250E22D4F6;
	Fri, 17 Oct 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pkqAS4wO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F022A7E4
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665764; cv=none; b=d9kHOt2qFsdSqNdnLS+KpHe21K9y2fdK2UDLz6dLyFSXJ6vI/h1ku2f3UrtCykUtNOcGLcuCwfcqFunkOYthWbdlH7KlQ0YhQjCOurrCMS2c7gMTkN9wDU5Ha3IjrP68e4aqOZpMw0BlRvLiCFULj2DMTqmR3rCmmxWuqjrGHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665764; c=relaxed/simple;
	bh=eJgvGLa1nC3DjukRvy+d9ZbkdIAGKX4JLy/spzhvQ6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdK5Kann1wGe85DOwjOopfmrBgkQAT/pf4qnSv4EnnRRfpPD113Nm8+oCnKrf+yrH2XZsS4HZhoSjDRTJfJnk2sd6LiHSNbiHzaqflYS/tmok1202Wcac4l3gYzJHPZocGvobjgB504091k7OFDJhK4hh766/06cOpuj4jZTR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pkqAS4wO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLXe8009503
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/qZkYWus1hBgnRXxe7sUTOT1Ci6cLrIVkU47kAR9L4g=; b=pkqAS4wOs/PqN103
	I0matSH2fDRvjsPhRx4ykn7P9Ip3ImKvmmgN85lYumB1Q/yhiFbvn+0WmGQ67uFR
	sbZChYzK+cto9xyj3bpW5z/YQFGCGsdoww+jNAwqw7f9QMr5Wgo3FROm0HktBw7z
	1Bz2QKAAuRxBIw0Kao9N2nGuk00pYyB+26xZhHM4oDfMgAbEkiBm4ipDDJ9JnlT+
	2Z9GKp8g63r0XqlJpk3DBlvDG/dy8Wuk5ePfU5OFDmfGqwvX9nxiJKCOihYbSFOo
	UTxSTo6FVoQghyBGyI/JdS7tbCaNQ4/tjPDD8+u1GacB1v5E4H+m1uJSGGUWOlFw
	aKrx7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0caat2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc5bso1961004a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 18:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760665761; x=1761270561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qZkYWus1hBgnRXxe7sUTOT1Ci6cLrIVkU47kAR9L4g=;
        b=grBdfj2ENUTQg7Dog1YMUcllioaPRn/BOlY3DNDzHhYRV8n+HqAm8u14nQJHAQhk+d
         QRZRJQFottKhMT7QKAbkJO0GRdMOBPLT0AgE8W8vxxmyeyQ0FMQURJRWUI+niusPq7sS
         LA4ueeWVQIPmrSESIIiolpEWFDoNzL9ksdCj6XNgUwGExDZ7eKC9mSOB2pHsPS8aKbDF
         KLUfmgdF2ROXsUj5/5F8oxxl7ml2B+cHvwRSUNFgKxIbuvWmkgPqqutsS3b86BSXSeX3
         ExpaBgniKCK/XeCIw8FwiaengB5+YpScXpc3QSZ+T6l0oPj/K9z7Y+eY3o4e+u8qt607
         eSlA==
X-Gm-Message-State: AOJu0YzV3UzWNxOH+UpuTepamkbk6AhrPdzkOe5BF0+YA9j5CjcNxisT
	N8TF5czrZ5FX00vFSogC8HnEOE/+nAqpTzUEIpZgDtecmq4MuwAw+UIcGRj25yXEQ/FO1QffzfO
	ZJijthjnMCrYMR/phkidbP6hoYsw87GXbO401KNC3ovpN1mVbEfzOPH5Q2ACpj7HgyDZiHR/sjh
	ySWPZv
X-Gm-Gg: ASbGncvMkcn/0HQnAI3rIP4keWhae5m+aP2UMi3rSZeABzf2vzYPtivrbjASuWWMT8A
	Ed0PRFv+a/j7o6rpILQG1oIFfc6qdxQEKARIwzFseF7glIjbttg9doPzM59LAEJQeWHIXVEyK+2
	MKMceNqKiLWL56Gpzf94BvqjtngkU/v7RdNUzFa3ZpNvyjXBkffz1wXVT/IKLpPKF7nNzj0Bq+t
	Y2d2XuYKVho7qpgmTkWVFMbKBNyZfy2LDficp2qN3tJDwtIq5Ri3nijyQsLzwp/VipyVZT8tftU
	z5iseKNS6iMC9mGaNtMlG1Jk3JvaVNcoS0qnsP7N27T/PGi9OLbjts8aaP5M8JtwWoiU9YrobAx
	jLT/uSUTDrEmD6P3WAOn290iJ4bjggyg9oHh9j3lk9g4vuj87F8Hb
X-Received: by 2002:a17:902:d484:b0:290:a8fe:24e5 with SMTP id d9443c01a7336-290cb65c662mr24678545ad.55.1760665760805;
        Thu, 16 Oct 2025 18:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVljgwflsJFVVL0ZtQZpZAiOSaHCuz836bjQkgB4ja85VP0SrXV4EDkYLO9VWJjBCWrSpbkg==
X-Received: by 2002:a17:902:d484:b0:290:a8fe:24e5 with SMTP id d9443c01a7336-290cb65c662mr24678275ad.55.1760665760312;
        Thu, 16 Oct 2025 18:49:20 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bbe7a0sm4181475a12.38.2025.10.16.18.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:49:20 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:49:00 +0800
Subject: [PATCH ath-next 2/2] wifi: ath11k: fix peer HE MCS assignment
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-ath11k-mcs-assignment-v1-2-da40825c1783@oss.qualcomm.com>
References: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
In-Reply-To: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: dIAH139e-qEpMvLgnSrIJZrAkqlHG1du
X-Proofpoint-ORIG-GUID: dIAH139e-qEpMvLgnSrIJZrAkqlHG1du
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68f1a0a2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7iRMhdnMhBDbN3xG2bEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX3n9fFsJtF1a0
 3xRxnn9Min6VrMIC5swjfDI/Qtdom9FSSuaM/n9nvBUBR0VZ1WVdU4uCAbBSBhqhsCpZIT6D0RC
 YqMXWO1NktlxgEnEHbI5TryI37XgCfXVVihI8kZ6IE2DDrqnCEeM3beeqr4z6D6vVz0wezUMOAE
 pNVlDN0uzhua4l36hINgQQ/HBQFII/8yOre/lflAanXG1u8YLJfTxGskmIPPG5KjALhCrNLFKjz
 vdZms+ZbpaWTAe9EC1NqeKKgVOSKXmE/YBiKuBl1/A/rw2J7eAYWk2+R1YVCUB9L3Chy2d5eD76
 O5sCSjQDNLL5cHv5P7TfBJp/uxhhDmQEA6t6snbkJ41RbdrUNHybaQSNAEeCIWZXmE9TorqSlYd
 gRTTHZXCbidAcI0sS8ve4ehl+xC5cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

In ath11k_wmi_send_peer_assoc_cmd(), peer's transmit MCS is sent to
firmware as receive MCS while peer's receive MCS sent as transmit MCS,
which goes against firmwire's definition.

While connecting to a misbehaved AP that advertises 0xffff (meaning not
supported) for 160 MHz transmit MCS map, firmware crashes due to 0xffff
is assigned to he_mcs->rx_mcs_set field.

	Ext Tag: HE Capabilities
	    [...]
	    Supported HE-MCS and NSS Set
		[...]
	        Rx and Tx MCS Maps 160 MHz
		    [...]
	            Tx HE-MCS Map 160 MHz: 0xffff

Swap the assignment to fix this issue.

As the HE rate control mask is meant to limit our own transmit MCS, it
needs to go via he_mcs->rx_mcs_set field. With the aforementioned swapping
done, change is needed as well to apply it to the peer's receive MCS.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 61fe43e7216d ("ath11k: add support for setting fixed HE rate/gi/ltf")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
 drivers/net/wireless/ath/ath11k/wmi.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 49c639d73d58d46f869aec40f6439268526ea1bb..f142c17aa9aa7483b7d077d51b24aa7b5fd4c48d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2522,10 +2522,10 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 			he_tx_mcs = v;
 		}
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
+		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
-		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		arg->peer_he_mcs_count++;
@@ -2535,10 +2535,10 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 
 	default:
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
+		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
-		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		arg->peer_he_mcs_count++;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 942dfeb8b1af8553d1c872ac1444bfacf11f44cd..edff6fb613449c96edd049b8531d46e5f680cfea 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2091,8 +2091,11 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 				     FIELD_PREP(WMI_TLV_LEN,
 						sizeof(*he_mcs) - TLV_HDR_SIZE);
 
-		he_mcs->rx_mcs_set = param->peer_he_tx_mcs_set[i];
-		he_mcs->tx_mcs_set = param->peer_he_rx_mcs_set[i];
+		/* firmware interprets mcs->rx_mcs_set field as peer's
+		 * RX capability
+		 */
+		he_mcs->rx_mcs_set = param->peer_he_rx_mcs_set[i];
+		he_mcs->tx_mcs_set = param->peer_he_tx_mcs_set[i];
 		ptr += sizeof(*he_mcs);
 	}
 

-- 
2.25.1


