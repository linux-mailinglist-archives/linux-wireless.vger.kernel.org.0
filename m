Return-Path: <linux-wireless+bounces-29655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E100CB5E8B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98374303BE0D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69630FF36;
	Thu, 11 Dec 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvRq6ysF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZlEcPP1Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8730FF37
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456880; cv=none; b=CUpiHEV3nMj9j5s3cGSvy1ot7mgJ8+QwDZiK8kRVMBsaZ7JwjQmbLS9QQSi3R/GuAaA3hlgqPrqCSbyGrk7MCZfH2qOMxVAsWxxID0d5LS85Qud8PtWkA7BdEX1S+F3BVIFx0ZAslWe9b5aOZ64Rai58h/ij86HRgtkjApRk3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456880; c=relaxed/simple;
	bh=raXni5S7+bRpLIi0rRw6+21JQx2u8/5sQGGyGEtG2vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPNuulD0X9t2qQ55pbWlqr+D0N8Dl3xgyBZfeVYDS6zP4lx2CWGYclOwmI2mZCN5RT08dgTIKucxILju5bIvUcspSUzwxjXa1OKHPFARR2XtwNsg8hsIFU8nKWSvzaa9VTPf4yZeRQAk7M3tgCuBGI+GfAWDVIL5is3njgSjtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvRq6ysF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZlEcPP1Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXpc11597454
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8+azEMPAyac
	CuRvwmN0IXUit231R2OkPV71Pb8Yo7To=; b=OvRq6ysF2V3zpaTMkg2kafE6MBe
	7Y8yjO2MO+yEvsCQUaSpHZB6FfCwSAoBe0pwsMpM1I+jrP+q/jZauAJSLvUSFPsH
	2Sr5m4INcxEvzvH8SMbudc17B+xn/GVYZp3+xMfogsang7AgW+0B1RMRKMq0irUR
	RvKC3/1P8zRc3FylALRGPEK8KkM7DKWLhfshrYi+LLrIAMM/NeaM6bbcQn1v1Gc6
	Ys7J7AVVWkS7BGKn4p5yTP2Aj8b2qT/7HEchIot7al5BhbULOqyI00qP+N+uDTxd
	HrFRzZtPX1Yo7uolnmKgxOLE1lvuPuZ8rPPovqZpG6vKo95oVgaIMczzKJw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aybhpbmp4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bf222e5b54dso13181a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456876; x=1766061676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+azEMPAyacCuRvwmN0IXUit231R2OkPV71Pb8Yo7To=;
        b=ZlEcPP1YxYBUBtz7yKSxCZc6tiZFrgqdTGWsDRQGTo/xeii8E+pZsVCMZhIZxpFjsu
         m8i1txoZ1drQLHOOZ/XZ8ydD/t9Dphxn5ugQuetIIlhzGLt3Z+twuOTgGH/s20U6nbUt
         iVuAdP6mjuTRIIhOGMRfnEWG5ucs9ANUtQw2yLypP81Q41WzoQ+5ZNc3boR5Dnr7Ddcm
         rfyESanAxyJ6CjtDwFrMdRq0b5frv21R9S6WRc6qu4mDwpPhHJW+TMVBkJ6XIODKSZ/8
         BsGIDfYt5c0/WhR6wITMIqS4VvoRsOl7d75B6jLiruHEEKThJYqprVAYgexdZtxR9KsK
         Fw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456876; x=1766061676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8+azEMPAyacCuRvwmN0IXUit231R2OkPV71Pb8Yo7To=;
        b=m7VDi6u87OZZM9kWhJnjLyXD6KiG0LpnFfKYHZAPOTbsHQQDBY/x4WwOx9Tb7xuAKn
         YHZB36kh4iyLkIdTi+mrM1f9Xhv4L47nxNGFt0onIZV6+fdB8llPoF3V+rwoPG+MH701
         IV2brZRy01toFo+yLzXgB6B6AgOuS6BEdsxQ1dPrivAk9+5+Q/4zB4ywZIqSRoewksXT
         gp9d+EYHlHWF2n2bLC9Pv/wWGVHZ4asybshppzR4qKCRvGuyj84+APxZGttC0LZ2+2D8
         6kwrVW8M31tLDf6wRqp/970w+JiuJZ0ZrJIjBzAbu0UNx09AGu03uCfTgLCTBVS0jTGZ
         kNfw==
X-Gm-Message-State: AOJu0YxSJCSO+UpNKlG+zjrgC4R5FFC5v1zXAympWIgjgfjX+ATNAuiM
	De3ynQSQzJmvWaHTNNFO1/rGziB/He9+Z4AhVjZPqyzULbFxoASeeZmpOUIJvpxhJMcR1LRpBRn
	xjRxqOWq/RXnG36PrG+2BUxnutYzNY2QhzJ6WlWq36kIB9pYCpd0V6uCnMgCCPEh5EZLFL8STg3
	84gA==
X-Gm-Gg: AY/fxX7e2Ly3wvM+2YIuBHIsd9pTdwBe6G5lMrzEp/bcZRXAyQCo+RO0rV+avkifRTU
	JBo7lnj65NmanvVSgZ+QRPXgklroIqApjjr/WkDqilwirRs37TufCmJyjrTrd2J+Qx6HEI9GdpC
	NZru0MqlzX7cBjgmgMPhiNyBQtgS1OLMd/e97G0aZsZOc2BP0SfLeb+jPvZGB040K3QXXbS7VOw
	yC+MT0xs7CsEI8H3syjrDVGuiarekGGIzz5Qqrsh53RPoAHhwNng+6g1EYRvk/Yxam3y425/iNx
	WKwSWDmxyXTc7oqxstGt65O7BNw5T/46SlJ4gAu0b7NxJJzUHFBGOW2preqJyjP3L44r9GFop8A
	iR1G9zSfKCIFTdMFqMxJR9oFqRxLNJD7kx42A9KOIBw==
X-Received: by 2002:a05:6a20:a128:b0:366:57e1:3919 with SMTP id adf61e73a8af0-3685f33ca67mr1947616637.26.1765456876304;
        Thu, 11 Dec 2025 04:41:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF+WQCRDMgOHeavNI0quPHoQs0R4+dsDYlWkqHe7w1CxcJOcX7DczUBK+XxIJQi1N68dn9SQ==
X-Received: by 2002:a05:6a20:a128:b0:366:57e1:3919 with SMTP id adf61e73a8af0-3685f33ca67mr1947559637.26.1765456875205;
        Thu, 11 Dec 2025 04:41:15 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:14 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 01/14] wifi: ieee80211: Add missing AKM suite selector definitions
Date: Thu, 11 Dec 2025 18:10:38 +0530
Message-Id: <20251211124051.3094878-2-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX871xWOaKn7hB
 y1rZNiSYt7SOIq39O0CJ9MoPY77MiqcOgq6VoClY6MbZWXYnvLOq2bYunA5j1ssTu1s9RHE9jst
 UEr3IPOQrqgH/lxk39xZcH1B5mofV0X11zW+tREH/Cz9MHJqvh5FmbvL69MqcPFH4jqhVmCoOmz
 gDLcFKRRlJidJmkzz+maccJEPb/Cjpk99iDISPl8kGqJDS2Idz//b53fopKSFVv6SQqiqyXpYzw
 AgINfPBqS7Sr0AV2Q27D2LtJULzLZ+4hT/kpJR01h1LRKb/uWv9b+J7eAchYO6561ZrUZw0v2kr
 gqyn/y1f7J5sp/FHfwV6lyCx7HM5gV6qfmZGs5bnFZnm0lkjb89qtPE+Jl6oBmoLmMHMVFOOseK
 c0AJ2cAV3li94drz6iyPdNGFX2c2sA==
X-Proofpoint-ORIG-GUID: 9Uf9wyR1Fzm9s7HrDKU_yk-IbwNWa3a2
X-Proofpoint-GUID: 9Uf9wyR1Fzm9s7HrDKU_yk-IbwNWa3a2
X-Authority-Analysis: v=2.4 cv=LJ9rgZW9 c=1 sm=1 tr=0 ts=693abbed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=A-uAeEEKJvxK9as7tjEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

Add the definitions for missing AKM selectors defined in
IEEE Std 802.11-2024 and IEEE Std 802.11bh-2024, table 9-190.
These definitions will be used by various drivers that support
these new AKM suites.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/linux/ieee80211.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 96439de55f07..9d36695e1468 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2218,6 +2218,12 @@ struct ieee80211_multiple_bssid_configuration {
 #define WLAN_AKM_SUITE_OWE			SUITE(0x000FAC, 18)
 #define WLAN_AKM_SUITE_FT_PSK_SHA384		SUITE(0x000FAC, 19)
 #define WLAN_AKM_SUITE_PSK_SHA384		SUITE(0x000FAC, 20)
+#define WLAN_AKM_SUITE_PASN			SUITE(0x000FAC, 21)
+#define WLAN_AKM_SUITE_FT_IEEE8021X_SHA384	SUITE(0x000FAC, 22)
+#define WLAN_AKM_SUITE_IEEE8021X_SHA384	SUITE(0x000FAC, 23)
+#define WLAN_AKM_SUITE_SAE_EXT_KEY		SUITE(0x000FAC, 24)
+#define WLAN_AKM_SUITE_FT_SAE_EXT_KEY		SUITE(0x000FAC, 25)
+#define WLAN_AKM_SUITE_PASN_KEY_WRAP		SUITE(0x000FAC, 26)
 
 #define WLAN_AKM_SUITE_WFA_DPP			SUITE(WLAN_OUI_WFA, 2)
 
-- 
2.34.1


