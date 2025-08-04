Return-Path: <linux-wireless+bounces-26115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15BB19A59
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7471F1897948
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96088221280;
	Mon,  4 Aug 2025 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZnr9AmE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115A21FF4C
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276613; cv=none; b=NmEDkKAv0OgXSwCn8YJjGoJaL+zugL+gxeYMuj8UPvCklaaYC5yRqro4K38BncfgYg4o9AdiHPEszN+znwpnSGQ8osLxwFzNE8HFEnYAKBzRyviXP+j2lskYi/tesh/WWQcQl8dKDKzKmf4KBXXNU2Yn/oHerT7xUVIpX4x1gC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276613; c=relaxed/simple;
	bh=fulF+7++kKIq3FU51fxvSd6TZ2z/1EkUJ+ZdPG5wMqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxbiDBJmnmluBWdeJQWJLFhN9hUc/qee2ZTjMcKIYDFLzH3FCQPevvYj5ki9hNeAhAceXdtkDAlWE/YtKFDytNlnLizrZc6gZ7D+EPzJG1iUB6v2mshzySMmAAsdOKtRSnfV1OUlQfApnH8MoCAS009OiumfxonCVKZksEUkGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZnr9AmE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NmFe6009065
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 03:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ws4K34M895QlwoqCvDCnlEt/m9zE1eKyV/9hDVzwdwA=; b=hZnr9AmEJIIm/hBU
	fzKLwCRWWUOWCxvwjZGHxP4X/PXt9H+WCJcns3ZyEVFyDslivoEArEgKWaDckw7n
	irbZYKBNY2Pi5IyQv3dtbAcKPwDrMboPTNdu1QHlZcCdrVdt56x9AqRyTB57VxAC
	oY76ggdZfMWVRB2aIFJ0MMeHLaevRBQSUadkTEUs+KXg/jLg7Txvik0RC66tt9tK
	obCodXGi0Uozsf/C11jLnnw78OJOTw44TLLnzczQYiLVws6+kCt9KqhNcsDYTHDn
	DNRyCMQUzJkuMBzPK3IflC+N2qF2ou+r5e1kaZs37rFMCidTE/U2wRLCCGkHwASk
	TL11hQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489b2a38cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 03:03:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b321087b1cdso4921828a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 03 Aug 2025 20:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754276609; x=1754881409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws4K34M895QlwoqCvDCnlEt/m9zE1eKyV/9hDVzwdwA=;
        b=PNCEnbsdzG7hUcr+yjPq3R0vpHboMrL3ZhOi6T3As/6iC+3afBQv/0N6IL5vtHqX7U
         u/mDJFJDi9deLjPMkBt0wxrBB3aZxsd/QCwPU/5E3J9KWIH5zz3PuE21OCORFExWhkOA
         AOGnroIxfCiuBBs1ab8MkXVYVBMnb0mFyElOlUu+nSVMxkFG8eV23WKRjL3+nEfmbq6x
         R9xUflydPk0U7C1RjSV09NRoNEHIfC8xqGDbxFQKr1VKYX7grf6y9CSHJjRp9o5sSJu+
         nKvREysPAFrW7UCS12bUL/Go8lVh8eAwnBHbXALqPKUjDtuCblqdJ2bWXfTf2szvuKm5
         AjQg==
X-Forwarded-Encrypted: i=1; AJvYcCXhdWo4/dv/aX29bBUAtzOQD4vfnafxXgTPVPX4oi1VrTeN4wF4LT2txP1aMpey1bDhokHy9I3I4Pi5O1Y6Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNUIN6BBnLCWP4QqQBU3NaMYeAm2ygGocP2zHktu1HOD4VMXZp
	DcNbahB+cQLXfzivY2rUMPTiLLi/PjQpyaJWsM0oSRpQ9ZWWRxvMV8Pq6a8DU10S+SqKerPsgYa
	QpXZ5n89Qvjp2e2+nMKcm9iHGrxIflFBLL2gZmmlTobW9zaDNPqryqDorWmCCqy1+y6mNzw==
X-Gm-Gg: ASbGncsPRGsFxRB1ZTUoyDdKwHTTW8ULIFQoZ0vxqBzQA+RvjuTdG2T/0Ecqcm1wRKG
	h3Jue+9b5vL/na8NpDVHAv85IG2DfZ8UcMQ/uHAvrxxRRXHnEFq/cfUcR+eXXX4LOfsQsta25Uj
	PJBi42MBRUlv7RQ01TRUeU+VUxidKuBxdEfdk2UMjndZlpMAdxw9uCipXLZUEKZqGHUYpvJmjea
	uTUF5FCVuwOGGEdfl/5zw2NYD8Vt6yDbkcryGOZ0TwwRMlMvpa+Y/RfuXcpVE/JnrC8jIOkurNl
	pZgkefiSNcZikXeyBakHY8aurnGTLELoVUYtDhqAFmiKqeRmDW+kRSrSjXlZU8diEEfaEWjxPPg
	Vbc9E/8HBMCSF7peLLQ==
X-Received: by 2002:a05:6a20:1583:b0:234:8b24:108d with SMTP id adf61e73a8af0-23df9802825mr12965506637.22.1754276609368;
        Sun, 03 Aug 2025 20:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNOz3T56VRaGLUiNKjisoMK0eXMn1xWIfG3yzjpBzA6Ry//yUXJa0ThZsF7/BH5KTDJ3p0bw==
X-Received: by 2002:a05:6a20:1583:b0:234:8b24:108d with SMTP id adf61e73a8af0-23df9802825mr12965460637.22.1754276608919;
        Sun, 03 Aug 2025 20:03:28 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc0e79sm10489000a91.10.2025.08.03.20.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 20:03:28 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 11:03:10 +0800
Subject: [PATCH ath-next 1/2] wifi: ath12k: initialize eirp_power before
 use
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-1-56f1e54152ab@oss.qualcomm.com>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
In-Reply-To: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=OKwn3TaB c=1 sm=1 tr=0 ts=68902302 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LZTIgfvDWzmdvsE2OGQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: q1kGwWXzzc-O4OCjCe77a5I5tXiVN7JK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAxNCBTYWx0ZWRfXxp1nCXmSsBv9
 femtz9KdHxtiD/c07tJgL3E0eS29+1a42b1mNd2MpoVkx1zc60MgsDanXIQsgAWAurEPQ2YezoP
 6LI/UAGM9RSfkvy7e88Py3Y4m3SAJV8u25Rs43UKDoQEuMzwawwDaed317ZYDsTuwTpB3Ij0Ebe
 igZ3ffQEbRs4+DUV0ufzQJRY7KATpYhRdsVvU/IGhI43nos+XF9I+hsbu+mAYR6esfx0ryympw3
 Yu4IOKBU68cpyaUr4CH7nx7JLM0hsTqyXBeqY6BmZiT+wPPYup3WA8Kc74Pl2sMiZL8ZZLSdPEn
 mgHLmhf2FZG3lbIZFntMu5YcviDcZKdlwdD6myD3S9AoGWlpiZgj3K1VJbvvGG1XWptvJfbFuOs
 65jWeS6NQ3GsHRaPTCjfwAw5uAxaxN7KUKZWyMlW/+ySY0+GfHg9EJFYZCg5tgnX6VpQlKWs
X-Proofpoint-GUID: q1kGwWXzzc-O4OCjCe77a5I5tXiVN7JK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=689 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040014

Currently, at the end of ath12k_mac_fill_reg_tpc_info(), the
reg_tpc_info struct is populated, including the following:
reg_tpc_info->is_psd_power = is_psd_power;
reg_tpc_info->eirp_power = eirp_power;

Kernel test robot complains on uninitialized symbol:
drivers/net/wireless/ath/ath12k/mac.c:10069
ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'

This is because there are some code paths that never set eirp_power, so
the assignment of reg_tpc_info->eirp_power can come from an
uninitialized variable. Functionally this is OK since the eirp_power
only has meaning when is_psd_power is true, and all code paths which set
is_psd_power to true also set eirp_power. However, to keep the robot
happy, always initialize eirp_power before use.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: aeda163bb0c7 ("wifi: ath12k: fill parameters for vdev set TPC power WMI command")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202505180927.tbNWr3vE-lkp@intel.com/
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bd1ec3b2c084169b841146931c54b6106f7006f6..8295480e8b1eeaa3e69cca823e6745733ade50e0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11228,8 +11228,8 @@ void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
 	struct ieee80211_channel *chan, *temp_chan;
 	u8 pwr_lvl_idx, num_pwr_levels, pwr_reduction;
 	bool is_psd_power = false, is_tpe_present = false;
-	s8 max_tx_power[ATH12K_NUM_PWR_LEVELS],
-		psd_power, tx_power, eirp_power;
+	s8 max_tx_power[ATH12K_NUM_PWR_LEVELS], psd_power, tx_power;
+	s8 eirp_power = 0;
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	u16 start_freq, center_freq;
 	u8 reg_6ghz_power_mode;

-- 
2.25.1


