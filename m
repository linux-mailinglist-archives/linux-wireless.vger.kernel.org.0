Return-Path: <linux-wireless+bounces-29877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCECECCA057
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CCE301FF76
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5007271470;
	Thu, 18 Dec 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqPPGtOQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BpHMDEG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF0271476
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022939; cv=none; b=M1tTJWHp6qH2Pwr/InVjt+3DSAt1CmSNpkG5+G2ozmozG8AxGKw+Ln+WMITz+F6Xxaei+xLmymKoA5hgqWwx92MC1J6XR7fG3nj3QmybY6njkZdR9WFhBHf+gT5zw44AWakxxQnnycG8bafFCVKGqeR2GRI4R+ZnEcHDlshdKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022939; c=relaxed/simple;
	bh=nFJok2+O8kc2HvbehA7obQVg+sWrfabbEZq6M8o2/i8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKTjbRITlzMjbPigDcnBe9m0AQePxu0fmj4sxsDBgonkpskeJ5h34r/+nPi415cE75bBNHQEXtuf6WfYy5igXORP3FjcDcjhC0AuE5BVuUWOw04ltNQlsYD/GsxD2vDDtDj9ul24BPezoPSN6rToOE/vJnuFznBdegmYuCHj+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqPPGtOQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BpHMDEG/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yeql4148006
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NwrnbmbFkzlCKk2+xSj24BctUGgqYF7I+RkbqstW9fs=; b=iqPPGtOQq+4sCXxx
	aFeHAhJJb1GMp7PFlpumXTK8iTy0gV32MgwXIVk10qk5v9tSX3JS55be1Lg9ecD1
	nQWaRtk39jaIr/aXLGCnSzhbLnKoC4UoiQCujRCo4XLW5nXhWTfPHAmJwIqUJ3+J
	0XKRi4HbWB80zcaWP2AGOneSAxxeAR56OxjIlMnre4SYEE6nxCDtc+PsO0lxpWuT
	g2t1j/yyEJFfsxXuJB7cwGvty/xQlrVXq2iTo9slxR2jRs7TeDFiegLZlgiTTPLm
	EoZI0zxewb5gMBEZeOgikQn+pNs8/dkzyUSFAQiGbn33VEMUxaXPlFSr8hzv9Z67
	Lmywlw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u798nq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29e6b269686so3308445ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022936; x=1766627736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwrnbmbFkzlCKk2+xSj24BctUGgqYF7I+RkbqstW9fs=;
        b=BpHMDEG/OdhRvvaD0YHAS9fcdDZmgXm2Vb0vAhP1kfNAdZoVPXMTi8LE9YaeFmGO2q
         DsDm6iUdPQzaeA/SjzKZGlJnRv9MfCikxXnPYpxyuuCDMo7ZWaiOUeoLGmmEsC8/0QL5
         Vjlr4zCHBMZpDjPcsyxyACTszbDQav5pxbsdv9B1v7MfTBHN6B0uJbIrDzPY3cdWmIOJ
         S9nxzPPLPsKfuGFsGM+uktFj+PXQuFvPRvbh5PMoytOZDXADauq4u9gkppIe7SY8LT4D
         oUtze+2YpEV8MmnZej+PYECwB6PqodHjgKESi9v/kuH63xgb+1kj1kn5+oFrhEfV7vOb
         G7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022936; x=1766627736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwrnbmbFkzlCKk2+xSj24BctUGgqYF7I+RkbqstW9fs=;
        b=VZ5rouEfCnGd8JkKaZjUGF/Nw+VDlj1iVtyy/Q2AXWVL71Ds4SpYBKWEDfVy9cEaUw
         5WU00QobzklD1SD39hsEpYLNrERDmVrbw0xx6r/WYhbHxj05NuTGXoCxT76dtGFiOkSR
         o8f5GzW4StjT3COG8CrXD+0rJfEeKXx5eUDi2u5D5R/Iqe7VL+gxgIVhxAIzHqtggWka
         7DhBlCkgxcMlSZoqo7NPiswUFWb4zCU5t6b7VhtXNLX86Z9msl/6hJmq21bsCQNSaXCJ
         Mdf/LJ1sxS3H+48CZyTxxJIUVVc8E5WMMw2WBZK8inTpDieAOESIf1+B3lKDitjnExZo
         E45w==
X-Gm-Message-State: AOJu0YzGzD+MCVhJVWegeX5PGjiGf/M8RWsP4TIBgmSb4B9UQOg+j2rL
	XKs+PjWJJuatolEM00ypJ98Fa3rXU/LRGYMLiLLncv6oM83AKDNNnmA9Wmm/ZjX4HU5cYCYxtzw
	IR3vDwHALRaa9UGw7k+pVKOoCI0z9U6c6ZwScMARA6ZlCS+V1ihlQRXe6KAP1qfjUrzPgTwlvWA
	7YMESy
X-Gm-Gg: AY/fxX6ZTtAJw7Po1wEsKNrWMqYqXl0WreVczsw2TzBxv9TSBejRqkfqW5QDUpuTVRY
	KtXZpPz0ZtYh3XfBW3xFbOYG837KHTM3OXj0lGDc5rEJ8cBqhIQ4SE50aw+E0TX1kdk6W2saAN6
	aV/BMiQ4z46Ee6la5eZ63xy9K2mLhJARJx+myNYPZ9DV/ns1YFG+6mZphcS3qO+BB9dMnUL9nSH
	ytLusvCAugvaMt4I7TDK93pgoBIMXFn/Jxq4l+r+WPXvHrUx5WmbS9xhfIRzy0ZXlc8H3pr9OSt
	j32Am2Hp/Nn+e6fH/MgIr7Fh58EtBQl6umtBHj2Vwi4w4rIq0BiNbAM/4EQpdKLRx7FX3E7QgdM
	qtlArRvgc+U8BvBwKL5DPhwrJ580ARfwt3bCV0/Q25gzy+OOW0sm+rBv3kEwfhDU=
X-Received: by 2002:a17:902:ce11:b0:2a0:c5b6:67de with SMTP id d9443c01a7336-2a0c5b66910mr153902895ad.52.1766022936490;
        Wed, 17 Dec 2025 17:55:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZfB6asy+mZsK98bGd3uS8a/hwJZbG5t4GAwPAXMiLItCxW5RZ6jXEeSDgzGvGUrjN4rUaRw==
X-Received: by 2002:a17:902:ce11:b0:2a0:c5b6:67de with SMTP id d9443c01a7336-2a0c5b66910mr153902715ad.52.1766022936046;
        Wed, 17 Dec 2025 17:55:36 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:35 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:30 +0800
Subject: [PATCH ath-next 16/19] wifi: ath12k: limit number of channels per
 WMI command
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-16-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: tkHD6RgK-0Ozs5yyQNCWYF9G4mLx8IPo
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=69435f19 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3KhbVLdr_5p6mxRQPsQA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: tkHD6RgK-0Ozs5yyQNCWYF9G4mLx8IPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfXyCuIFzHHlaEQ
 4oZNayoZQL+LGiYpbxJHZzpwlI01ir/GJI93kM50YHEUBrqmk3mn3Iay/vplLan5HogLF8Kbya8
 CeC1H0sp0CIblCsYnzvoMdJVZM8fSUyYwJQQVtj55oN0l6hGu25oejdPTBQuLnQ0w6N4f1yjIIy
 lqHisKOJRjHVkNJGUtb4iFXxNmxcZDEUQXIvmUQjQmPyTro14z1oPymFfrOga4O0CIz0l85UJxT
 +tJUBnXjzEQQN5m+qeJWbRLtdOAL462lxmym1qmF1nbyU6CILkOCjKmuxgewMh/VHHcKWPknQRj
 4SkUN+P7+bxoti1L2kIsOYV4SqX79glLmjMeofAD5VKCwKm+9BEaQ5Qsr3o7rQ7tw8Ck7PBV8TR
 isu0AA67DjHY8m32qF9vkViCvO3OrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

Currently the number of channels can be sent in a single WMI command is
calculated based on the maximum message length of the target, this results
in WMI exchange hang for QCC2072 as its firmware can not support those
many channels in a single command.

Add a limit to avoid this issue.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 ++-
 drivers/net/wireless/ath/ath12k/wmi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ef7690f829ca..ed2374c4aac0 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2806,7 +2806,8 @@ int ath12k_wmi_send_scan_chan_list_cmd(struct ath12k *ar,
 		max_chan_limit = (wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len) /
 			sizeof(*chan_info);
 
-		num_send_chans = min(arg->nallchans, max_chan_limit);
+		num_send_chans = min3(arg->nallchans, max_chan_limit,
+				      ATH12K_WMI_MAX_NUM_CHAN_PER_CMD);
 
 		arg->nallchans -= num_send_chans;
 		len += sizeof(*chan_info) * num_send_chans;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 65f0d7ed4178..daee2787cdfd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -6322,6 +6322,9 @@ struct ath12k_wmi_rssi_dbm_conv_info_arg {
 	s8 min_nf_dbm;
 };
 
+/* each WMI cmd can hold 58 channel entries at most */
+#define ATH12K_WMI_MAX_NUM_CHAN_PER_CMD	58
+
 int ath12k_wmi_cmd_send(struct ath12k_wmi_pdev *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_sc, u32 len);

-- 
2.25.1


