Return-Path: <linux-wireless+bounces-34215-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CClLBvray2lHMAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34215-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:32:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE08436B015
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18EC23064735
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71263FB05F;
	Tue, 31 Mar 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nBkL5SEl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QX9Ejmfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE713FB050
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967113; cv=none; b=QMoHt3QVEpINNiHK8iZtRQNwVGFplhhWCOLLJUEJa0wFw8ygkSHCdBMyymIjAptqhdC165fbB/mughVpyIc4oQVVxdI5aAVDddGDcd5G9ethoh22Br1jeUVKPqWVT0gfdpIkCStPCrEHa3f3xZlUK3VBHYX4zr/oNfkZ/nf3gTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967113; c=relaxed/simple;
	bh=4KB09CwohQmzBpT1WaYWLQmdAAZXLCabcQCRHHjUWCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1BHIuW0KTyHee01MAMBxeDJUlW9LJqczmLF36e1b64OF8z3FaTyysSGrmIPBnaDpFRsLzsZjPB6+tpwKyrHw/shHvRw5H81XMwBDC9qa/MT1b3SHFjfgc3WMe6kum2UtsEoVvNpfQhYiOsU0WITMFs9dITCexueVkxRV3WDtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nBkL5SEl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QX9Ejmfg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VEIkBG2049642
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7x7Sag3p1W6
	KTCAxlSilDkanjEO722npmlRKN1tRFNk=; b=nBkL5SElUfeiCbL2OadIBiGnWhJ
	BxzZ04WrpI8F5fT4t7dJd6Nuh5gfeu2vH8xLw2EgHJwfl3VA+Y8f3nR7hwhJxM0l
	XwK0/6ROZdGdJbJDxM3gOenOcds7gwwc3v1CaETE4X5S9sGr3ONVW5Hr1UshgO2G
	Ws1S+D+eRinUPfRzYB2Vzs8n8cS8xQdx0cUQvlRRH0iP0gNz+figMGUmc6WhcuS1
	CsvUxEx8WqIB/2+9dFZ2gxCsLv80kpyvA8PIa5+uI2BtHHN8eQ+3WCW5JhHwmV4w
	RJFM02c3D/fl3NWkhfXTNiHvMm1BnHXgFN068QV8pJc8AOt9k3FFcp+GI9Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1yscjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242cbb97aso30308645ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774967110; x=1775571910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x7Sag3p1W6KTCAxlSilDkanjEO722npmlRKN1tRFNk=;
        b=QX9Ejmfgf3o7MQUwVtyFmNNgwsXufUNWyYzz4ujAUsbr0isVJrxU1Hx87CabnslsfC
         Mpf4KQ72dNml2BYVXds4w048eQjHR+XSWByN0DHcgcssdxie9UnejCmZEhgGjwBGCY/+
         N6uGgfGlnm4ZiTmvRueUKSxkhmRLzFSFOm9YSYSkEsPTcP8evsWLHwzKTWBUdiSxyCnC
         tJwOQHjGlwPeLaGh9Hmb2BGvft7mQOC7IuSZNyjKa3JW5EzH3GMJ7GoS4Xq3Y8eCiwkv
         XPPwHco0GZ/o9NhgbE57iYDi0pP+E/FkWsWBC4A4hmeqifRNHOtF3A2WmytdGsklCFKs
         HqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967110; x=1775571910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7x7Sag3p1W6KTCAxlSilDkanjEO722npmlRKN1tRFNk=;
        b=E4zOq8AeGen09BtkNImxH1+Zqbx2464YeQpQNwGZBdNNyMdoM6NpxFqX25e8V2/Pfl
         Kji6ya6aYFS6NZjx8APX+BDyF0DEq04hBnvjIYsclFlA62DGsN0ySz+o6JdN1j8jz0fZ
         OjM3wMZWtfOM3MvV/gyVLiNipfK+hBiiP0Lkx8XjkJuMimeA763FZVU56+3duV9iWirk
         m7GLS0pSlB/XaQ8Zp9B8TwXTzn2K4V6vj/aOPuGdKcTQp3PCowgzQFAza3/ZRaJNyOUB
         1T3MVx2vub05piP0OKj1jF376OCRQXsLFQfBoYjVTE7SsqCnN1rzEp1FQXDkkV2Ht/Ka
         KSeQ==
X-Gm-Message-State: AOJu0YwBXs9LmHlOObn+R2jGCbhPyoY7sFzTNeRpLgeB1nUnq1hsIO/O
	4Bemu0vBqJq2Kv66wLvVIMltWmI5qsoxpPOYdsoYQWJcSrC2u2e2pCKVnAeC2YfZsMOPUVyWpPn
	s7+crH4X2qCHDcdyBB7PBbur6mMDiK2DUj3iBIOcByAQ3/0YAZrHktgqx2BFyPeRyCRdJa1FQXo
	7PHg==
X-Gm-Gg: ATEYQzys1fUPMtbdw+iRMxdTnIwjrOnUvSGUFYwXI3q3aqxQB0JyL3G/y8Lj2Wm37Zd
	7oJoFW+CLyVDyILIqTI9aOBRR+fDQCfDGgAuNPs/ziT5A3GTQJm2GFBipQL4In+llJrrCVQ6PnB
	71BDvtuCpKR3JzhD/SFaFiiv56ySqWXHbLO7aMtTV6P1Re2JsSKpIxoJoyjaS1kcqqnqGH/C+8O
	CakAvy2ML5va/doxczKFwJT3bz1Vv/TJdB6YVnlQGANkc8h2va6phoYSY9nn/GGWGf2UJluVroF
	2uLW7WI3faPJoFe9K7M9x951b2pLJuzP+Jo5ZhdgkUM0YD056rEU7/0NOOO00jezIvDLGn7oh/G
	RGSfsv4XLmSsN64311RW1lqF9u6kqgD82SevUUj6lpf5E54iw3yDT+bW6sBdktLiV5g8ydNYImX
	9yanc/7jX89tk676Wh7jutcF3mY+wub3150RfvI2igx3038lLTdqU=
X-Received: by 2002:a17:902:e74f:b0:2ae:6092:8d93 with SMTP id d9443c01a7336-2b0cdc9eac4mr183407745ad.28.1774967109902;
        Tue, 31 Mar 2026 07:25:09 -0700 (PDT)
X-Received: by 2002:a17:902:e74f:b0:2ae:6092:8d93 with SMTP id d9443c01a7336-2b0cdc9eac4mr183407365ad.28.1774967109429;
        Tue, 31 Mar 2026 07:25:09 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm112030225ad.38.2026.03.31.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:25:09 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 3/5] wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
Date: Tue, 31 Mar 2026 19:54:44 +0530
Message-Id: <20260331142446.2951809-4-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aUifeH5U89g13n6Lz1VGEA8OvbMN-mmE
X-Proofpoint-ORIG-GUID: aUifeH5U89g13n6Lz1VGEA8OvbMN-mmE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfXyVq2a/StbNiQ
 G1P9De5Rg8vGARYKnmBAsVaHNqp6TvjhWC558FHQrhJANIrQU91lrx8RST7D6Ogd4Wpqw1PD0Em
 f/C0q2ATCZHuxCG2MIbvqeMIin6R0oTPwkc1EmrxnWEKRxTBkrIbUH7rhA8cQE7K7tid1gc/Ure
 1l9ukXk6dAejswvwqnPSPRwgrPrSZvmv+l2V4zfqph54wREq1mxZDyFQH5hI7011QetRN6fblUN
 D/D045nWMjqlC0yOtl6vhnFV8BeLlUtONnqopKOzp0DSMFYRredEVtcQCei5M//rm/159IJbKdu
 Mfcvd5d7v3xIIQxP9zVj4zQUYqYqlWLqL2R2R8+qR1FOjxudHTWqGOtP+H4T2Prxrd9WNKPFRoO
 vVUkgptozpy81Ax4eRlX2cNQPim91ATRLFb1e9TqcNdUdBPylva9Vtd9nnpKGHjPFi/jZTXg7O0
 u5AihKFyoIlRebeqbJw==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69cbd946 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=9zPADYYpdTKIp-S0na4A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310139
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34215-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE08436B015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both the error path in thermal registration and the normal thermal unregister
path performed the same hwmon device unregistration and pointer cleanup.
Consolidate this logic into a single helper to reduce code duplication and ensure
consistent cleanup across all paths. Add a helper to set up the hwmon registration
during thermal registration to keep symmetry with thermal cleanup.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/thermal.c | 83 +++++++++++++----------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
index 4f76622e8117..6f70c11c1098 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.c
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -130,59 +130,70 @@ static struct attribute *ath12k_hwmon_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ath12k_hwmon);
 
-int ath12k_thermal_register(struct ath12k_base *ab)
+static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
+{
+	struct ath12k *ar;
+	int ret;
+
+	ar = ab->pdevs[i].ar;
+	if (!ar)
+		return 0;
+
+	ar->thermal.hwmon_dev =
+		hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
+						  "ath12k_hwmon", ar,
+						  ath12k_hwmon_groups);
+	if (IS_ERR(ar->thermal.hwmon_dev)) {
+		ret = PTR_ERR(ar->thermal.hwmon_dev);
+		ar->thermal.hwmon_dev = NULL;
+		ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
+			   ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ath12k_thermal_cleanup_radio(struct ath12k_base *ab, int i)
 {
 	struct ath12k *ar;
-	int i, j, ret;
+
+	ar = ab->pdevs[i].ar;
+	if (!ar)
+		return;
+
+	hwmon_device_unregister(ar->thermal.hwmon_dev);
+	ar->thermal.hwmon_dev = NULL;
+}
+
+int ath12k_thermal_register(struct ath12k_base *ab)
+{
+	int i, ret;
 
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return 0;
 
 	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		if (!ar)
-			continue;
-
-		ar->thermal.hwmon_dev =
-			hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
-							  "ath12k_hwmon", ar,
-							  ath12k_hwmon_groups);
-		if (IS_ERR(ar->thermal.hwmon_dev)) {
-			ret = PTR_ERR(ar->thermal.hwmon_dev);
-			ar->thermal.hwmon_dev = NULL;
-			ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
-				   ret);
-			for (j = i - 1; j >= 0; j--) {
-				ar = ab->pdevs[j].ar;
-				if (!ar)
-					continue;
-
-				hwmon_device_unregister(ar->thermal.hwmon_dev);
-				ar->thermal.hwmon_dev = NULL;
-			}
-			return ret;
-		}
+		ret = ath12k_thermal_setup_radio(ab, i);
+		if (ret)
+			goto out;
 	}
 
 	return 0;
+out:
+	for (i--; i >= 0; i--)
+		ath12k_thermal_cleanup_radio(ab, i);
+
+	return ret;
 }
 
 void ath12k_thermal_unregister(struct ath12k_base *ab)
 {
-	struct ath12k *ar;
 	int i;
 
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		if (!ar)
-			continue;
-
-		if (ar->thermal.hwmon_dev) {
-			hwmon_device_unregister(ar->thermal.hwmon_dev);
-			ar->thermal.hwmon_dev = NULL;
-		}
-	}
+	for (i = 0; i < ab->num_radios; i++)
+		ath12k_thermal_cleanup_radio(ab, i);
 }
-- 
2.34.1


