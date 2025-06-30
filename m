Return-Path: <linux-wireless+bounces-24644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E1DAED33D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 06:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615DE18953A6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 04:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D0D1CBEB9;
	Mon, 30 Jun 2025 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cRJTVUzG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34051B4F1F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256944; cv=none; b=m5fKLYPUmOZfgBE89dUjwtrqV3uJVwmoPKD0Z4cqCk8EY1txr8NPkdPJm1qjYbd1vZLvDFNgY9XwgznyvfEBpNKBEuA9e3skCutkl8/RnpPZRznPRDwZddkG+iqKal5pW/Q8D7CkAOm5uvo3bt3Dg7t25j0yV9Mk5W/dGig9Bro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256944; c=relaxed/simple;
	bh=RwToH/cGCZH+YJlEXJRY3Lb9zN50RXZwi+WeP0de+ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaYu64cP/AiT0a2KTy/SKJxTDjL8aDXnfWu4jpbZostFaD8ZY7DKKsj4A1HLGi3hckXZzKN9E1QOUnOtALOCN7/idB/hpCgA2IhTgRh/8hSauvgebCTKSHc/rE9ru60BFYsZz3KudwOaX/PU7CIrjwOG0PnfjPzT09nGs9qstzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cRJTVUzG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMdaVl020074
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6zlwIaUvtBdKmWYrvQBftvSATw4E35AAP8krPXhnxFc=; b=cRJTVUzGg9n8pYoY
	tkBd0SntV2ekvMA7U74iOhbFFEq/CUfnRTVpiXMfYuE5cpBF331Ogc3ESCtjQLwQ
	j9LNfpppygkqS5iqCmpDYbs1QRwS6aqZ+uK5Y4nizTJV8PW1o5eN5TcuIjOg7kON
	H8XhHtfhTc+B65MxfrtYfggJR+6YsXkRsBDHWDe7fEvT4w39VatumbZ9hnFm3TGC
	VU0gsadP52JwdNPwaPUg2qHGNBwPBmmqrSSKH3sU8fTxa4PMfWqMSa6oh44lG52F
	VIYr1YWwg8lLZj609I1yHW8vwdl5iKCFKNotk2i9xhUNeeIA5ONR0rRlwxCeT4L0
	RGCO/w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9jpu6e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2349498f00eso38435385ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jun 2025 21:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751256941; x=1751861741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zlwIaUvtBdKmWYrvQBftvSATw4E35AAP8krPXhnxFc=;
        b=ZA7YoytXveGl8HEvLIQVC6kB3P+HMldFtDnrvOqKgfnws0a+UZ6VwdILC2RXndjOSy
         A4J85u2zYznIuRsZ3ABPAVlU62VGR9gNOTmjtc7srjPSixybMtvCyn9GSrcujIXnJGXb
         T0zyZGxJkNIoxkqqfrTDVpgN9I3xSF6QBnhlSYplTrVy/B9BwiNZKHifAm6LxTjrnFMN
         yD7nssnpBkggVq9ulLkFX6Vn0YqRV41Er6Vb/Ncdz7NhBt8T3b9SoPuj8wV2ieF/pG7Y
         PJajdhUkulrcs7YUndlE91vKp3jXvW1XlwCfxI3WU1K8VoDU3DhKcHVIgoFDAPdaVfZ2
         5kUg==
X-Gm-Message-State: AOJu0YyfkL1CdxfREYjswBQacEQesxJx5GQ19mEBb+yRdz0FM8rLHQCx
	d2bWZxxcRQTZj/9lZT6mjLr6WDyLaYV3Kx4K6fjF7zwDQ5A2x1+QZ0r9N/8C0QZ83dL7RwCuPH/
	MM7+UW7Iq19hHeZt4qB+prh8ZPIf5QnDrn2deOjUHi2Jh+p9akGJCDjFJjY9a3B0ssl/BOForc4
	M8OA==
X-Gm-Gg: ASbGncsFv0Y/G7xp4IsGlt41hOaRhbq9lE4VnACzKY+OBuYts4+ZH17575duCvdkor3
	uH7det19DgTStw2nzRlo6GACU19wCwqE9+OsKKwjP0EwpKTp2e/WTCXGNzy551UA4NhZwI0TPOn
	tgUd5GrHCy4UCqaRsenUYrY4VpF3U9axdpXjehsd1cpSAewQ73Eqbn8r4mKS3YOXIChNz7GFVtr
	NCCfmfhwwvwDExOtnGseChumJWQinwWoBr6SpyClns2gli/fHtbYZir3GDJlwnUZ+YXYLpcQmp2
	PMFCRmgYS0fDB4qBUS38hRjpirqT0Um4/0ZeMY2WMYjAUGxYt3Rdj2r3jxOZF72YKwOdkTR0Rh4
	kh0uREOGQ+QWlYJt0F0vSMejE7gD52GqhD9elhDOYy4UYSSY=
X-Received: by 2002:a17:902:f60c:b0:235:e1d6:2ac0 with SMTP id d9443c01a7336-2390a54cd4emr229127125ad.24.1751256940761;
        Sun, 29 Jun 2025 21:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ4EKBLyFvklT/nNxN/0BCu32hBk9XzR7iL2Rmh9tkeKSzTTpmxpJFvoPr4pnVeNNd+SHgyw==
X-Received: by 2002:a17:902:f60c:b0:235:e1d6:2ac0 with SMTP id d9443c01a7336-2390a54cd4emr229126815ad.24.1751256940322;
        Sun, 29 Jun 2025 21:15:40 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f069csm69366955ad.59.2025.06.29.21.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 21:15:40 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Mon, 30 Jun 2025 09:45:16 +0530
Subject: [PATCH ath-next 2/2] wifi: ath12k: advertise
 NL80211_FEATURE_TX_POWER_INSERTION support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-support-for-tx-power-insertion-v1-2-77f45484d5bb@oss.qualcomm.com>
References: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
In-Reply-To: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDAzMiBTYWx0ZWRfX5pvVB7nH86cY
 qJQ+jgiQ5KHsofwolS+zeqRHCfIGU8FMucC0ipOHzaHfltCwCKdGfDLe+hzCJHbt2lb6qiJAoXS
 5mb59ePk2OyOXQEBtvn6r1sbZm6DbUtcid2pbFv2qEsxGGXQKP6/mOyA0J5Xdfvcz5VkrEfYjYs
 spAxiajvtnqJ+8VUMZ/5EPr95+pyaMFZ/BdrZ07QVvzx77wdQvtLlnK34C3FeQtLVxmeqzvYfMe
 h+RyasR7p1Bry3G0itx32GVeWZT8OGY/6vb5HXEKgcdG0hnlsJh2vXJMabFAgMDigrdrThL73ad
 iNAEpJ/5GGyLVy/9TkWtBOqkZSgu22VfwhKQxse5BAsCt271lnLG4Xxux+tkilkWkbaOpnxkFOa
 2B51wc2qwx/6UhzKeeKWfnrjJsVWuJ1q+ZPmMC6CQyVYlwPmZzh28hqelOnl95qLa1ywTjdC
X-Proofpoint-ORIG-GUID: IqGOeJ4ZxfziLTV8mgCJxAqvqVsD3C_S
X-Authority-Analysis: v=2.4 cv=Tq7mhCXh c=1 sm=1 tr=0 ts=68620f6d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=xmVKpWhJFmdleDmdprIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: IqGOeJ4ZxfziLTV8mgCJxAqvqVsD3C_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300032

Now that driver is capable of inserting Tx power, advertise the support
for the same to upper layers.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 241f11bd8c4051db4873d1109acbafa1aa9815c2..318b651c6d8e60102317f05549f7cb2da6a05620 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12894,6 +12894,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
+	wiphy->features |= NL80211_FEATURE_TX_POWER_INSERTION;
+
 	/* MLO is not yet supported so disable Wireless Extensions for now
 	 * to make sure ath12k users don't use it. This flag can be removed
 	 * once WIPHY_FLAG_SUPPORTS_MLO is enabled.

-- 
2.34.1


