Return-Path: <linux-wireless+bounces-20128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EABDA5AA68
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 00:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDD7171926
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C811C6F55;
	Mon, 10 Mar 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nIR7c+6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864818C011
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647673; cv=none; b=Mf9XZRWxAehbYHV3iQ+vr6IPZyujEaFjfyxFcyWKMgHlTR9wRYDd7/tfdyONh4uEFEVPpG0lXbxBJHdyvpmKjdzLn0LUR4jvK5mhTHa4VtQUAmHntjsXPVy5wVTMQBdTXvhdqWzLavXAFRJWz4ubHFjKYCQCn7M16orvWNMzv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647673; c=relaxed/simple;
	bh=hlnBokKq9YP8eDFtnmJoRpj9H95KsaYKHxRln6/3TJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jc1/PKIURbDZBWS4J7CG36roMNG00NwGn5OU+OudhTgRokts3if+XzRJUzRkT9y2E1v+2nfEgicupdJIcRXPeKXhMeGTKeFiIbDgF8qM54x1KafnIo5gzx3lLhx3Y88LnUQ9b164RCsVYA6S3xR6ftB6InfYmdnfjBwXk5eGAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nIR7c+6L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJo5rn030297
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 23:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kZorEsNh/qWSFIhYLEsw65VFgF7Utq5nKIY
	ynGPWCSI=; b=nIR7c+6LYVA885zM2Nlb7QHhOZbQJfFbh8c1nKhVngZt6PJtEuN
	TyHLi5YlsLdGgqfI13UZ4d/QEyecXXy9IPRDwjhG1oMuBCaz/g9zugNjgO9z+HsZ
	6sWM5mZHc7pVZg+YZYFu1ErMcaHUa3akiPjrZ2SP267qE21nJSw/JiXa2JhoQ8BE
	P6s4EH33W1+Jp7jNyVKJ5USI/f97Nd/yv+uTN0r1eh+d3LeOqYHTISoIB7Jm3Ahz
	7FHcuXfOfzO2hqn9U79Iq9rkxJY8yfJ/2Pe/9nk3Bk/GOJtlrKH+BiIevvUDyY+O
	ptecbhgEwTa7nScPTTW1JmfCQnOGIANjbcg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt6abu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 23:01:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241ae15dcbso99000635ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 16:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741647669; x=1742252469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZorEsNh/qWSFIhYLEsw65VFgF7Utq5nKIYynGPWCSI=;
        b=fRoGNbHnrekQdrLsrBhSll3k/jkawOr0aNwih/t0wmNnJY5rScNg7VY9pOurcGT+Yr
         Q/udNkXtcmbfNEoztatFECJXLqhqxv1B1qJOi/Eczg+M3mb24m8wUmDvbw09yLbU+hYC
         wNWWwVrG6ihR8EdmaG47vbUOZYCX3bX4JfAFZ9jFt6oHWaVB/Q0/V2XiUtH0U4sxA3eM
         2ibu4Hpmnq3cfAszC/NRNUXEjzl64RII2vm0qsn+iBNmA+YaX5e1JFMtZ6h6s9E5Puro
         8X831cHnDXg6C4wxumsl5Uz1++mo7XW5F1ieDDaHq5G6GRpmLooIChjFqeDydXojEdS5
         cCfw==
X-Gm-Message-State: AOJu0YygUydU0MweBv2gRG2AIBvhWUL3lg/3pFEv0XsQQa6o98nFIVVe
	tsfsivnkRwvXHM8KdDkeVTRvVdPuuZNc101ELWuJurn6aixo17AombskTmqnusR8ODz7+B3PDUP
	GVpODhubH68VA2ko+MKqfoA99zChOOAHXQuRr5ytZpSXQZU6ORYdgy3RUXOXH7mvDYP+ZYDQKkA
	==
X-Gm-Gg: ASbGncu/7sGZJGTfbcBmxF2kCCM+8d0fmZAXYWaEzd4hMHagLGd5mLKLR4G+TWEWE4e
	l/ctJqagn4vde97c3Nk2+IaovP7VFwq9KBxl1CDTd3UzUcBgKj3JJ+yRCeZULfvG+g3tVQ7TFAN
	zxD08khT7X93m6lHWcS9jmTYFYZtdzAe2cSVfsuK7JpXbnZ5MvOTiXdaVtQQqzMscs0uo6MgKrc
	bTJKhBiODTYQM4tN8fchUnrJmibkrczUp481ERvjh618bo7eiVLgtAgh4QsrqgAuOGEb3YrDcN5
	exsw5DFE1IhPDyAAOl7SmmZAGfYnaeOjs/1THJdJXynMrhvWtclNip1l+Q8BlK8x+CVJNRSK
X-Received: by 2002:a05:6a00:c8f:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-736aa9e0a95mr17814869b3a.9.1741647668700;
        Mon, 10 Mar 2025 16:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEbfaXDCrTsTjJcjzzDGbR0SIZGCtvh+f0MsKyA8IHVzO3u6apvFa/1hIvAlz1o7gF+gwBrw==
X-Received: by 2002:a05:6a00:c8f:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-736aa9e0a95mr17814842b3a.9.1741647668327;
        Mon, 10 Mar 2025 16:01:08 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a80853d1sm7906959b3a.91.2025.03.10.16.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 16:01:07 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Prevent multicast duplication for dynamic VLAN
Date: Mon, 10 Mar 2025 16:01:05 -0700
Message-Id: <20250310230105.3534334-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5jIT842t5NlGwvheRungcdguShbu0Bpy
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67cf6f36 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=xW75EOlAb0IjOozs2BkA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 5jIT842t5NlGwvheRungcdguShbu0Bpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=795 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100174

Since dynamic VLAN traffic is software encrypted and encapsulated,
mac80211 handles the duplication on each link for MLO dynamic VLAN
multicast.

Currently in mac Tx op, all multicast frames are duplicated and are
assigned a mcbc_gsn. This is causing dynamic VLAN multicast traffic
to be dropped in HW.

Prevent dynamic VLAN multicast traffic from being duplicated again in
the driver. Check if incoming packet is a dynamic VLAN packet and
avoid defaulting to multicast conditional.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfa05f0ee6c9..a7b8a7d2637a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7337,6 +7337,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ath12k_peer *peer;
 	unsigned long links_map;
 	bool is_mcast = false;
+	bool is_dvlan = false;
 	struct ethhdr *eth;
 	bool is_prb_rsp;
 	u16 mcbc_gsn;
@@ -7397,7 +7398,14 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
 		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
 
-	if (!vif->valid_links || !is_mcast ||
+	/* Checking if it is a DVLAN frame */
+	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
+	    !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
+	    ieee80211_has_protected(hdr->frame_control))
+		is_dvlan = true;
+
+	if (!vif->valid_links || !is_mcast || is_dvlan ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
 		ret = ath12k_dp_tx(ar, arvif, skb, false, 0);
 		if (unlikely(ret)) {

base-commit: 0e28ee106c46c95eb322833c17c33e3c231ccd0d
-- 
2.34.1


