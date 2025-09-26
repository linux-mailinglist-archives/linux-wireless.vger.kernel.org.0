Return-Path: <linux-wireless+bounces-27677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F030BA4FF7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAC7B7B0D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F338202F70;
	Fri, 26 Sep 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGBJ16G1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42FA1C28E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916326; cv=none; b=gvc0AL6tBP0A/go6da+pLML0kOZsxndQpF7RXHUzLV/dmZHGOdugSyHekn0g1lcIyuf32SfC/tSqLvbMIAtUN22NvzpXhZq/ng3rfSPGM0/9YoUKr+Lz/CjF26TToziUc274yyqDVUbk4DQInSHT3h9L59rXLt8mQxw/Kc4Bgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916326; c=relaxed/simple;
	bh=EvpJIwsN7NO1L/ul1TWWybHV8/HqHXebuJH6zUXxFnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vu37RMJ6Uf0aI64V0hpGhQgiD9k04/aOVvYnYXDDx8lJ3zeSj4Je0iJRo3aRu8z7LHQrNwEPittAKad13udfdefxBwE4OuuFQslOp+D3Z+IiOQzl0IXnGmLQjcKEunyt/c1SV3k/Kb/ideO2r4YTemyP+p2aJPLUHkNZiop+cSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGBJ16G1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWsco030280
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 19:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=d8ueuYdGiy9O1v4kSJsRe4M/o7UIf63cyFd
	c4Gv+kNI=; b=KGBJ16G1B47ofES3YruX0jUZj9AjJdBRyIOgJLbuHRXZXUEalGj
	7EvwA/rMr91IPpJEln1buGRw6fETk0uxiEMOKqB9//0nboGFF2px0+CdME0RUzeR
	FU+KzA5qb2rggcBD1x7uMiP7a/c8kCA+OXUuAwrvVLAwLN/iVsopoVTijrsnsJgN
	fZQx3/JNRS/iYj6MN3JuP+/H44CDLJdUlHBcBp4uM2why/V/oL9FJn/9Z/Jdr0lI
	jEC1nO+S/I7HLe2UGp/OyMKcbZc6x3ooD8ru7aaoDoQ9+FDJ06oxWc7S0QE5v99K
	Nv3WREq55yX1e0+gGH8FA7wZ70E4cXSgwjA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db34m0d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 19:52:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d8b8c3591fso69738281cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 12:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916323; x=1759521123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8ueuYdGiy9O1v4kSJsRe4M/o7UIf63cyFdc4Gv+kNI=;
        b=TSIwnTjstvLCYy/L5hkfcX2pmEn/Bjoh+5VGmBCvT5woqUdhBBVVUEul8mLoW7C7Al
         q0ymOynoaq5UZ59jNKRT3dfR+g0xfz4PZa0W/SgGoeN++sEI5bWch2Rz7svvgHaIT/QH
         6MsDuDoH64KVIdeHdwHg1Ia+ORu+k7hizP/1xOMlKFjNze39F6x4E9bs9IMg7K3d0lut
         R6mZZ2Ir5VKubM1yD9ej0gsLfANv2L+TPsgdzh/XfZwfNjyBzS3kLDjY/Rn0E/R2ys0I
         TSob7lOqPyu24+ExzTrQsDH5UB5GPRYHORe/6TnWb1QOFbOk2+XkYaKV+hA4VnbcEdSL
         xL2w==
X-Gm-Message-State: AOJu0Yz9dHhHoEXVOCl47N9jD5CRYAKUZT6ivmBwV84qDWFi9Qgg9Bxo
	2AojDUXTGq1wQSQHH/N+Lb6Hsj+tE9H9shDIFFMqy8nO6DEw+za4LlXGOUGF6XzE/Y188Rcg+/V
	PMOWXIfVyIthkbWqWMA5NM7blRYzNanA6A3gc3LvIbq9WWeDjJ17rpKaKJi3VQFK3bFHmDg==
X-Gm-Gg: ASbGncuDZWmDINwWoPiJcZTHK6+1OuHS4fWwhOYeimkp/TpIxnYoBh+1H4U05ZJZUHW
	n/aH3dO5fxx53JMPZQIodNl3a8ogTwAAngmXFbQ9ttVAR0jFMzqTMuDw9O2IFuMD1NMI39pTH6c
	HlIXXTmutvZtPdoFrxRQMSCSjJA9kCBzj4pjc57bKzBoxGx2incktcFy2dtyFC8EDzlLe//APjj
	lHR2ocmCGevz1NaFyMK+jVfX1Ye25EjYyftawAvW2uAitkpa0ZrFYFbrwXUm1d6CNemNtjm1Gnb
	FyUpJerVYtwyNTLcqoBExW/fwQr06YnCNxE7wUzFOPUj4VP8scYBKPbA5CBlrONnLCDZnSjmrpJ
	GNmGYbQ1Hineff6YIVi9G3SDQ7Yzy
X-Received: by 2002:ac8:5990:0:b0:4cb:57b4:4d6e with SMTP id d75a77b69052e-4da4c77c788mr126863341cf.56.1758916322539;
        Fri, 26 Sep 2025 12:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1xuwlno1wxXrKm77baA93fP4S42v4JWePpo8Lou6LvKS21uLZelQjYHOisWdQ//kZ1fRbow==
X-Received: by 2002:ac8:5990:0:b0:4cb:57b4:4d6e with SMTP id d75a77b69052e-4da4c77c788mr126863081cf.56.1758916322036;
        Fri, 26 Sep 2025 12:52:02 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:5de9:cd6:92fe:bfb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b0595fsm3355162a12.52.2025.09.26.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:52:01 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: jjohnson@kernel.org, kvalo@qca.qualcomm.com
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath10k: Fix memory leak on unsupported WMI command
Date: Fri, 26 Sep 2025 21:51:59 +0200
Message-Id: <20250926195159.186193-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX9MAZyPAslftn
 WPiIujkZeHgDm5zPtFoMW/srf+cmZRMErlJZjrkzYJECmkODgXn6itMGK9oiZ7bQju9IkBpFrKI
 LxxteunRxZD0ZByjIlKSwSeetqk6T9A32FTH5LAkpSi6ooQBgpEBM5s1S+CEOUXvhl+Xb6XXdBK
 lKSZBQffdOhChUPG0jrjR1uikQ9XSnV3UcucImk6MIURyCPEvkzla4yCplb+j1h9JzLorHDtPaz
 WmXEax/uJgWEuf3A0jNw90po1wsD/Tp5OrP9Vrl/kio2JlE1AWUoHgt9+JUfvjxbwEIYvS0CIgM
 jnZHFT+ZmxfatbNGxKupLeMa4Vr4/FUlsn8NYo7Llas2LpVYHr03WnEUQJ31565Iyllwngtf2+2
 PX6HSUHggVycyw7NpCdmBU4llGmgHA==
X-Authority-Analysis: v=2.4 cv=Hb0ZjyE8 c=1 sm=1 tr=0 ts=68d6eee3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=_ECdSzBM4LX7PmatiasA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ErZ6ASgVMcWRBn9zm8rspJ9OdkkbksGK
X-Proofpoint-GUID: ErZ6ASgVMcWRBn9zm8rspJ9OdkkbksGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

ath10k_wmi_cmd_send takes ownership of the passed buffer (skb) and has the
responsabily to release it in case of error. This patch fixes missing free
in case of early error due to unhandled WMI command ID.

Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1

Fixes: 553215592f14 ("ath10k: warn if give WMI command is not supported")
Suggested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index cb8ae751eb31..b4aad6604d6d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1938,6 +1938,7 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 	if (cmd_id == WMI_CMD_UNSUPPORTED) {
 		ath10k_warn(ar, "wmi command %d is not supported by firmware\n",
 			    cmd_id);
+		dev_kfree_skb_any(skb);
 		return ret;
 	}
 
-- 
2.34.1


