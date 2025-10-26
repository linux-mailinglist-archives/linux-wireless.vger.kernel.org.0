Return-Path: <linux-wireless+bounces-28282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09217C0B01E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 19:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C518A0951
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007492EDD5F;
	Sun, 26 Oct 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BWz/PRQn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913A264A74
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761503022; cv=none; b=VwkxCogolrsJrvi6jOnV7x0EJaA3f9KiETCLdTRUaBOEVmRduoStAekivRHS4N3biuDDAPcRs+aKJfAeShgpWu5J03vm2ZzOGleBK2Cr4rYfEjh0l9N0PF30ulykR+6zDvXeUM2CxY5XkhDgcTPJ1jEgw3A7sNyPDB575jP8WzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761503022; c=relaxed/simple;
	bh=L+pJhFN65WsZfwXWScfF0u7lBCvXTl+slj+2w38upvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KISLwLd5NqU6gkz06qGP/SGGcvIrlmOXe3i0m+phxgvbJGdb1HLtDtzdiELKh4g5pzYSGjkZCKTvVsEI/igLkV84twiJPe0LkSo79dee+V3ZNr0LG7pjZnPs/2fkwe2Cf00hRhe9BSvWi4zzUdJ6JTJL+ntzo16Se51lyv5sSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BWz/PRQn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QDSWWP4158530
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZqsEVxFe/QE
	M6tmcBDnoo6nTSqcqq3a1xNgox04mkJ0=; b=BWz/PRQn6XWu65/hjesMOQ7d+UH
	PZYIhAMs5x5Kgxzh3XQaaTDTJqVsjo5EKUPaQKpw6EAJ27QJA/fAnhQBkwpg+ldt
	jr+o97eyiYB5HQdoJbeTnJd9eZv9GfPuhEgDrjgkC4Z5bMJsswnZTckemBVenPZ8
	8fGach8SVXcmDjhyYPe103kO8OzLNcMMHBgGvJM8EmT4zlWUjBUoQjx1iqQpW/fn
	LZKptHvb4oGAmFbbRWviFdAa1caNLj+Hh6WOvIziRSkVkzXZzPk1b2bHBLISboG2
	u8WQ16tuUO50bxjIvbjW8Fn3r/xsQtCzfqL4V8zLXVG9W4h1ER05nXJdThQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nkajf59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290c07feb72so30902635ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 11:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761503019; x=1762107819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqsEVxFe/QEM6tmcBDnoo6nTSqcqq3a1xNgox04mkJ0=;
        b=KMHB9lrFWieR9fJf4hfuqqe1nRj7oRiMnQf2IurSxF1CskuHw7PbyUAfUpu0MaYZHm
         bBJrnaE8y5HNWtqAkON+FiBGSFIi91vG/tbnl0rpvPsMSsLKbkjc2UImJjqGTdRcZPGW
         +MlGD77a6mQ7Xk22l0gG7nlkzgLhTHlbr571oVEwI1fK+GrZ/WvYyCUrVM+QvN5Z9yjr
         BqMOowsAvFkpN7uERNZ1oWuKrqSyWG6+h4uURs5yTFh/FOCfkp9WMBsJnpzVq4dRlD+P
         /CSdvAHPBpIw47yEoRJxsXljXKlFSP/98hhd6TZ4RXeyrnsopLOvR4e9yoSqCaFsgv/5
         rG3Q==
X-Gm-Message-State: AOJu0YxCoxSiwefKkQoG1TTzH17ANPFheOSJLW+v6IwFlDLSRO6DidQE
	rfjye29ohig4AE2X7a5vMYs0c4ptlVAVr7cbf36DqXRNJiL47Si+l4KSc0qyGbb6d0WnuygG30I
	qGk4sr7gN2tuoJTSuswOqYU8PLUOfLRe/2I7kJ3aTqLeJXo7yS0Rg9DFn+cJN73IJeF737Q==
X-Gm-Gg: ASbGncv1q+XjGbvyHLu/NDA/LnbVxOjcl05A/e5Dxi/Hcz4RH/w6Th6xvRvb7Qk+SRE
	KoeTslVZnaMY/Rmg3HZn5sHX6BoC6Vih5i5+iDMbSTzYeNpMFJ3NbSb+Z0YQEFSwb4mJ4BH7fP/
	7tP+Gksy6V3/HquRb7p/KyRX7TFIYXTsppf9fUCxCCX6um52I0wmxoVZ1ldQPyYBzWhGoHQAcUc
	vCzqn0iQzcgt0D3y0VLi1hWegdPoi3TcTwAFdBxqKEnNMZMe9m4BbBbqvmS8HtyZ78/3ntuH3vk
	ncELlwYbumVI6Vlto6int5iOPbEAUVohMvD9FNO3+N4MMJjJYa9UIV9GupZ9AZx4ytp29I0opLr
	d/GD1w0yXtiMWOo+Eebst/piSjVRobS+dy54CQglBfZZz7bdZvw+s0PBAdxmBlRKoHbNPVLtBnJ
	sy6mr4TWXc1IMTSmeLWGacqdxHh0Q=
X-Received: by 2002:a17:902:eccf:b0:290:91d2:9315 with SMTP id d9443c01a7336-2946e128595mr151526915ad.42.1761503019061;
        Sun, 26 Oct 2025 11:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2ACezJkPsU6V3ps65VlD3fH5aaIoToRyiVREfsv5gGh1rZAggvkW/92gRcnLRHd+C8BaHQw==
X-Received: by 2002:a17:902:eccf:b0:290:91d2:9315 with SMTP id d9443c01a7336-2946e128595mr151526685ad.42.1761503018447;
        Sun, 26 Oct 2025 11:23:38 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm55208655ad.100.2025.10.26.11.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 11:23:37 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: unassign arvif on scan vdev create failure
Date: Sun, 26 Oct 2025 23:52:54 +0530
Message-Id: <20251026182254.1399650-3-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=68fe672c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=YQYput0e2kp1zi38YLcA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XinuUKAMkbMStC-4Ejz9A8z7S2P1sAQg
X-Proofpoint-GUID: XinuUKAMkbMStC-4Ejz9A8z7S2P1sAQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDE3NiBTYWx0ZWRfX0YvbTQFIS9u5
 glx0japoj45woY8I2i3tKret2lHCn2vxF7iciUvATWVXId/mS4rcSo3a6S9mFX/htOWJeXoQe71
 4nNx/fG9vtBN//ILILdZfarXZnwUihPOeYbrJWev9NlFzEsuqEV3Hxb0DmsolNlsoU/g+k4IH5F
 wiNfLR3Hse0BriM6OE5jpVokrazVlSLE6qzpQVpocW/TjgSP9yfSE6y4AJYSC5QkJGFH7iGnlhm
 2qcSvesMKR7kwylLfZwH/zujV4hA1pw3kryB5VmqN32G6HNVHgTOWvX01k0qGR0mD/ImIfdei5/
 WNtauV9WmUsGts3srxyMmlhV+UwqANxZqQLawJzwpDEuzr37tJJGkU1EXzmw2kMzpwHgUjHMXIR
 tBJupsYouVWfzjF8/qkyJfk8PdXGFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260176

During scan and remain-on-channel requests, a scan link vif (arvif) is
assigned and a temporary vdev is created. If vdev creation fails, the
assigned arvif is left attached until the virtual interface is removed,
leaving a stale link in ahvif.

Fix this by freeing the stale arvif and resetting the corresponding link in
ahvif by calling ath12k_mac_unassign_link_vif() when vdev creation fails.

While at it, propagate the actual error code from ath12k_mac_vdev_create()
instead of returning -EINVAL in ath12k_mac_initiate_hw_scan().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal for MLO")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 931aff85d35c..28d6b2b3314a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5125,7 +5125,8 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 		ret = ath12k_mac_vdev_create(ar, arvif);
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
-			return -EINVAL;
+			ath12k_mac_unassign_link_vif(arvif);
+			return ret;
 		}
 	}
 
@@ -12973,6 +12974,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev for roc: %d\n",
 				    ret);
+			ath12k_mac_unassign_link_vif(arvif);
 			return ret;
 		}
 	}
-- 
2.34.1


