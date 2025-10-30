Return-Path: <linux-wireless+bounces-28408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E1C20252
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C2A5609F1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF7354AC2;
	Thu, 30 Oct 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ldl8GfmU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QNUzrTTe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D28355053
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829236; cv=none; b=fMjnhrrRoeEtUxgMRZCx8GSLCf1F1Z5EnsMPXKdBWv26XvLtP8h2QNss+HPb+ySCh8cUOy6OmjPLljP7zLjQqkAUtIvf+0msVLaHOHsp7oLnwA5wUf5e4Ypc8BOiMJKbhD1jYvWqE+jH30N5lSZLunhOLLwehVR3XyHqkuxIM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829236; c=relaxed/simple;
	bh=LGW7hdfvroyMNsS3xnEjeZR4TQUPNzO2Hk/wStLQaew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDf3NPDdRa6pVq0YCUM6qYDPQyrFrOf4x+MmcS18xdacZi6xZT2UH7iBgs6mN1pVj7SGjMiEZLQYQ+mZGrwMenSyiz7YlpzR+KHOXoSEEa3q/1E78SATlmg1v50cplqVKlDeszXiWlxpvfbam2x6G0ETg1sVBAX3IwaFb/Joai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ldl8GfmU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QNUzrTTe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9PEUg3508948
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YBSYMbXV4wP
	o16RGwlAGSta0tp2sRbEpfdJq3GdZt0I=; b=Ldl8GfmUBy+qMs5f4/aExlHoCB2
	OnxBk6QH7mUDJrtuKZLarliPTm3O8N86zUXw/ydl4KgE7bxNEKkLES7DxCCH6XNZ
	xKeiZJ4sy649qK78+H4IY5zw5G/VUJZW32t0KVDSskRZkc2J8MnEb37T1nRfvSnD
	YuLnWXnBze7fy9gBby0sfw4sPTtErld2X+5zmnnofshJbuZxKrRXyRmRu1OGS0Uh
	2ho5L44zEwrTexQyT47DZ/DKo4VuwDyo9THCNDTi2XeeraDxByvUv81WmFN2CrhT
	wHIPjwhUhVOzGn6MaJMyZpcgxguqF2ENOU0LuxIHZHjVhnui1/lBingW4Rw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45cdgk19-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 13:00:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a675fbd6c7so557731b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761829233; x=1762434033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBSYMbXV4wPo16RGwlAGSta0tp2sRbEpfdJq3GdZt0I=;
        b=QNUzrTTeqFr+/eNJNYL44FPJgZbenNHSfNiwCN7tILb2o1uPjjzibsWsqqY4Cj33Bf
         SWtH1hOHE+gBeVn5qugA7bfzhJ7mGuZPWtwnDq5ffN87K4dOdxIW2OxP+oLNtwGUAUqL
         IZ1Gyq+pYyGrhlpK7GjBZQMe00FLdK7QxlAmzTz1nnNVF6+LqAyHQbHnEYcWt2iohYsF
         yDfRf7iCaLTB56RgbR3pNy2SiVVJVCTwp5i3UT00DX4C0XfKWmxO5rU8Bkxz3oIaPQ3x
         bN/tXGLyw6zlBjsIPz8XXxHtQcY4Arkqjt2RSgJ/HjgF4q2c9Q7jrgNRfHPzAR8sYEw5
         J2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829233; x=1762434033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBSYMbXV4wPo16RGwlAGSta0tp2sRbEpfdJq3GdZt0I=;
        b=GW+9p5t5RvWKv7W5mi7l81BvmDVhJQpC2AkDcng9Of0fmCbsqqlsiSChq46Xe1vjRA
         j2LX6RxeJvKbx6rD+R86GcwYUBwec/OwOEy/uUgTd53himQYwMtZ54acbnVAuTn8PdI0
         3VyGC1xF7FRFzZ6Z/JzjrKh+um0Nf5ONjoQJqI1NeRdNOI/eoZbDZz8ScCUSnokFehGF
         5g+hRTbjcUD8dZFZVc6WELFtF9nxpL84ydv9SdWFNzp2v+lmF2XLCHRuDbD74aG1QPd5
         YF2LXEWAs/wlT3DsNwhg0un14ONGsr6StJSEHflusp5rW5TMDUgf1XtheITfLu/xHHUW
         ajRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp6h9rhiGyPlnj4NPySb/Fc8962Pm6iPTJJbfbCC5L0WiiGeEYDwQCPt680aXL2x7tRj2cCiEqYuG0tmPhvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBpHHSEV85RPndLzXIsnwRcqoNYx4PYVwX1jCflXmu1slSo4A
	fRsWB3/CMmBuidWAV1IG5hX4cMLZDkIRZ+9vnSzF74sCb7GF5ukU+BS8kMIkTBrgAEziluUr5B6
	r9uIGOWa4hx+IwW1ZMF1GBkRqxMTgYOXomPQgOYcVCNPF2L5dGVb+wLfL/W92s8m15gCORw==
X-Gm-Gg: ASbGncvKKCxhBXF3SzsprZ4AFp+xcU+LtsvWrbe3LrtBAYQsemL5weeMRiz8Xk132Ay
	+9T46j3cnNwrd6lpPbsU03mqPuxVvHNSPbe4UjFpv3ga5arQU8VDUiLpjY2KhKTzEYVlLIuWTU/
	F4c/MKg+ZUstqiNRCh4q9ii5DdK6to8cjWcyxc5wJi3yNBhENp2Wlv9dUdEZhHCN6GtAx6P83lC
	+jbHn8LrDMDb3xQyOdg+kXsCBGTn8x72jt+C2D4Cg+3KjABewjmoYkWIbTMCnDk0Bc8zMpeHtlT
	CbZOxYe+uf3zeTLtyddbC8OB1of6psKujwLm0ZcDoHu5IdNtOZviB7f49ZLpeG+HigL/9ZWKbbv
	KP4ufw150U2CTOnJGjEyvNAnBGrLoLAIDsmGETEkrH9igO+AjNPnsAAHyt6tLZ9DEyA==
X-Received: by 2002:a05:6a00:14c7:b0:776:1c49:82f8 with SMTP id d2e1a72fcca58-7a4e2cfc4f7mr8535251b3a.8.1761829232901;
        Thu, 30 Oct 2025 06:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwUbo2rnq1u5I3smURzqZgV3UkEDWSY8iTqhS1M3qZiZ/dcfDt2ClBHzvIFP5gbjiY99BDhQ==
X-Received: by 2002:a05:6a00:14c7:b0:776:1c49:82f8 with SMTP id d2e1a72fcca58-7a4e2cfc4f7mr8535091b3a.8.1761829231545;
        Thu, 30 Oct 2025 06:00:31 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068addsm19078757b3a.44.2025.10.30.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:00:30 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH 2/2] wifi: ath10k: use = {} to initialize bmi_target_info instead of memset
Date: Thu, 30 Oct 2025 21:00:23 +0800
Message-ID: <20251030130023.1836808-3-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
References: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P4vk4Dtr0EyqJoE6z_dO55stHkiC0F_Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNSBTYWx0ZWRfX2kcu7Co+iXfx
 NpleonZ4BzlJqKv1aikCl3uCO0Q4c/GT9XkSolfsGZzw9gji0bKSHyjijOIbgvJ5c7L/3Vcmopt
 lJfIuUablTVcW9+QvK4+7xhWujA9+OmwJL6z9VHQu1yLID1nhzh7e+4eFxeGxW0KEmydo7rDhZ+
 7qi6AGUI53dqbUv+6hupxl9R+i36DTB9oyEa71eFR6TwN6JlZXQOCZGmAdsSlQUov/arkPWZnfZ
 hT1NU+EEN14EWzRS5qzQW19NHnnaWCVrN6sHliCnXdDYONH4srJfCUyc6B1AqUwUWOqj0oxuUbo
 LGNpKcTfXtso59BlQYf3fts9TnrilT8SLKUXuqMTgplZ+zAx+7oMY2kb/iRh3BRPQWu4EAnSYvH
 y8wqNk/3njhGHl9rqDgTh1KSK/HmLQ==
X-Proofpoint-ORIG-GUID: P4vk4Dtr0EyqJoE6z_dO55stHkiC0F_Q
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=69036172 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vBECTLBiNrBzeQB1dycA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300105

Initialize the bmi_target_info structure using = {} at declaration time
instead of calling memset() in each bus-specific code path. This
simplifies the code and avoids an explicit memset.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 670c31a52a12..7c2939cbde5f 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3352,7 +3352,7 @@ EXPORT_SYMBOL(ath10k_core_stop);
  */
 static int ath10k_core_probe_fw(struct ath10k *ar)
 {
-	struct bmi_target_info target_info;
+	struct bmi_target_info target_info = {};
 	int ret = 0;
 
 	ret = ath10k_hif_power_up(ar, ATH10K_FIRMWARE_MODE_NORMAL);
@@ -3363,7 +3363,6 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 
 	switch (ar->hif.bus) {
 	case ATH10K_BUS_SDIO:
-		memset(&target_info, 0, sizeof(target_info));
 		ret = ath10k_bmi_get_target_info_sdio(ar, &target_info);
 		if (ret) {
 			ath10k_err(ar, "could not get target info (%d)\n", ret);
@@ -3375,7 +3374,6 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 	case ATH10K_BUS_PCI:
 	case ATH10K_BUS_AHB:
 	case ATH10K_BUS_USB:
-		memset(&target_info, 0, sizeof(target_info));
 		ret = ath10k_bmi_get_target_info(ar, &target_info);
 		if (ret) {
 			ath10k_err(ar, "could not get target info (%d)\n", ret);
@@ -3385,7 +3383,6 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 		ar->hw->wiphy->hw_version = target_info.version;
 		break;
 	case ATH10K_BUS_SNOC:
-		memset(&target_info, 0, sizeof(target_info));
 		ret = ath10k_hif_get_target_info(ar, &target_info);
 		if (ret) {
 			ath10k_err(ar, "could not get target info (%d)\n", ret);
-- 
2.43.0


