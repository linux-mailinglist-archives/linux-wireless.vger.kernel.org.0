Return-Path: <linux-wireless+bounces-23507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52DAC956D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 20:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA091C21EA1
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA12441AA;
	Fri, 30 May 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nWMoDylt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3E27604B
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628185; cv=none; b=ZJ2k5jmJWrEaSgmCvc/LgY+UeXHbSzUNxD0YoM52TbQMnLBeCH4zPQgRxcddna2Z+KTiVrK42J6QCYvJZHiv/GA147F2deA1oSeF+OvCDIjH/vLNv9CZFuuQNAZSEXaISzqiM4ynm0ktPZaJyoIi0P5eYLS4lpRM5TGjZqK0tRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628185; c=relaxed/simple;
	bh=cGzujHPO/po5q9k2YiCn92R3KpaBxartUQR31J4OQic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o8qJFSYzsREQ0l2SqxCWAq4KEQMSIVWnThXZe0pzl9y3ITjnEs2LCkKxKmW7DKTv7SiKdhMUKEKNJpWv/GMo/DcpleC7bNjNtxvgHvC/qXpgpwr71bRnCZQ1Q+8T+ehk/m7qVY4au6ZVPdXFa9LrBVCDQjzpfVcypoQG9Sa5u2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nWMoDylt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UBo2ow017995
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=bNx2PZVkJVHdlf+U6Dk6y7/+9lqdg3iExttgGZVWadc=; b=nW
	MoDyltudx4Z+x9T+JgVnEtGPdioHO4GlyzcoMGbrabVZHP07XEK7rtorePi00is9
	hyuwiqy/8jyP0gSabVgB1sYPTCrCyyyxpPLsXB031iYJcFUI5iRdWEBBbNSyVv23
	tdq5J+LXkufx/0nx/1+3F+9ZP1V3j3nPOstAj9AjWpfm5G/VKOZP2JCEpybcU8Sq
	e96IUrR0on4RnVOSrGCxJuAkppHvWkqgCMAKG3EW6kB6z0KWt5Z9oNRTatr8aGfL
	QkEemL8cejr2Uphi78JY3z9OibtAATicuqBvhn66JzPoA+AisDgzN3Xp0T6iaU4U
	ztGbud/S9WkTgIdkNb0g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46yc4ys57y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 18:03:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234dbbc4899so34736095ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 11:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748628182; x=1749232982;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNx2PZVkJVHdlf+U6Dk6y7/+9lqdg3iExttgGZVWadc=;
        b=tkZ+eILwmUFRTNWKYDtaL5U9gx4kiu8QKHZK4JkPI91fMup7/HgtlCQyCjaoedX+9Y
         dVcJy7m83ii9MPrkjZ2yXyq6MynJkOt4dsPbWBOnkLn7YXmFUemnasFTDo5BepRfHuBn
         cyNESzozcblmuLuNE9XJyQYCxJLZ8ojATfXT55PbesssqtzT3cEbNUPFayxBEYXSjaTl
         7jqSv0UuiD0pU/a3sfo4LTQiVbBORcpuoTOG4kOlWZSvNXfRNAmvyW2ysxiorGcHEgWL
         VwnUIYaYmzeR46TEHCcmte49NShhpdybkku4fEMDszE+vk4cnN1doNP912SJkxZ0cvd4
         55CQ==
X-Gm-Message-State: AOJu0YwFzfLFcpfL9tUX1b+djoRx7U4/nGn2QcOhcxDe3EG51lTtq5da
	phFGX9he6GaLbbVWxe7dJvcyjKtts+CRAigXZZJZSKa5LzMG4qxLO9CI46eeLbsbi3BfPdwG+xw
	/1APKq+Etj4SXxrszFn6DflH34HS31w7l4898t12vIB69nQnR5ZWOO3XSoMubJmdqbVv+pA==
X-Gm-Gg: ASbGnctb9dRV3w48DvN4xuWy/w3maufrFaaM4g0MDbQ+MWR5IB2kGD6+Uee8Nd6YOFl
	TLUW4nwxqJ55YTI04t+L9WOpoq5l9dvFyXC2qB67roAxZyPkA1JhtOnjB/Ik6vuN7CRTxoJufju
	CMSpphRSUqC2GI2EFquxvW+Awbw/YUG96ZJeOVbupmPoBPolNYwB6h2ZhTN5rtBzaYQvNkPM3Jx
	cRfXfA+dYN0r50Qo2Kes43ppDPsrwFFmNUyfgoymHVugQlcOcaIuDs1uozRVWFzHoam7zmbaJdM
	U2jKoYDWlOK/Nuu9AIi5gjKM733lnHdL8EDRSLYGID6qbZoyYzPyW9qiyzv8C612fBebtvmwMuH
	jwm6cjlHXY7dDWtQ/2EdTpd/koa04EZmgUIG05+uVaR4dAA==
X-Received: by 2002:a17:903:19cb:b0:234:f1ac:c036 with SMTP id d9443c01a7336-23529a1357amr66794135ad.50.1748628182193;
        Fri, 30 May 2025 11:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFOJdnxoFqU+W4FFU27jXFptIu+Ou7L8bFIvNvx7C7pS7+NxgCzhEaoR1G6UAMm+MfA13U8w==
X-Received: by 2002:a17:903:19cb:b0:234:f1ac:c036 with SMTP id d9443c01a7336-23529a1357amr66793825ad.50.1748628181803;
        Fri, 30 May 2025 11:03:01 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc868asm31374435ad.31.2025.05.30.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:03:01 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next 3/3] wifi: ath12k: Advertise encapsulation/decapsulation offload support to mac80211
Date: Fri, 30 May 2025 23:32:47 +0530
Message-Id: <20250530180247.424349-4-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250530180247.424349-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE1OSBTYWx0ZWRfXx223QcR0h0ox
 QNgM1Rt67D5l1s/eDk/nkXegokzxsWozeVabYTqBRjUu1M5e1iMTaRNV9FNfFQWbmlZmqbBoMc7
 YKBBk5ZTehRX/IIASCbjvW5IaRhreU1fJ31S7KfbVvI9oyFI1Pdr5WewBLlwQ52zIybTh/EDw5S
 faj86Aga+guizD1aq74ijuhU9zThQpPcAoFEmdZX+aGX2L7TXjKybA2GO07/LHnBNpC2cSmU6o7
 iATtu/UoiSfxryzC2jDtJ+iWdtSnNEbyOJNbARbQGvsreCaR5B+cmzhFcmmO0kipKFl+QtlTEMe
 1GEu1TGrSF+EQnw2EVq79w8EvLBBjbdFKrHLuOBk1Mu8LWDmPHidSj6mozSJjTQf4f7jEbzZeQc
 FSg004gnmKYuMByM3U75MowsqKYgssD4S6FJyLpN1alUH2chS4llWAXiZGYk3vHJ9yMhhsr9
X-Authority-Analysis: v=2.4 cv=Ybe95xRf c=1 sm=1 tr=0 ts=6839f2d7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=xmVKpWhJFmdleDmdprIA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 74PdtjX3ciurdz3BrxGSd_-y91iI3h18
X-Proofpoint-ORIG-GUID: 74PdtjX3ciurdz3BrxGSd_-y91iI3h18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300159
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, the mac80211 layer handles construction and parsing
of 802.11 headers during packet transmission and reception.
Offloading encapsulation and decapsulation to hardware can
significantly enhance performance. This can be achieved by
having the driver advertise hardware support to mac80211 to
bypass 802.11 header processing

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 958299bd5acc..f65f0e9e7eb8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12011,6 +12011,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
-- 
2.17.1


