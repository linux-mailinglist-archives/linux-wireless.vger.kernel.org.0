Return-Path: <linux-wireless+bounces-21120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35281A79DF3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F2F3B670C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E32417D8;
	Thu,  3 Apr 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Taqp3uVh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A88241CB2
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668543; cv=none; b=G20LlHTjKx8YCL/jT8CJdX5Cpb/D/wpJmRH2mjxuTuPwJeBBfPF5uIFvXSk2fL0Svhk757eltlTi1Mx8sbP9UtyrpvcQHykfGkbPt0GcYTantravbl6mG8nQq83qx5ei0WoBP2ZxABYt2NtEOsWh2OGs+J9Vmw6gJp+OaQW1LtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668543; c=relaxed/simple;
	bh=ClJ02hH3Y3mmScI8ZNEenohqwAVSb93mPHcDzgfRtn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0/gcYMV6NeZjdCRi/dc6i3hUTrbhxZdoIuWKUteMxqTf98v9K5vF1BFBWOlVPAuG5duPwsxBPk03R1t+x49VA4/ZJCMO1oP5VbioGU8cbzOKw0zSTAjSTbHiqxLhRs4DRNEbxXqEeOx9gRjBybvvbUpUMX8FgBF97xpRZq6C/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Taqp3uVh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53382moB022099
	for <linux-wireless@vger.kernel.org>; Thu, 3 Apr 2025 08:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6esBelNOAKg
	OOsjfxg+XGMAKvus81FJOG5HagSUCP7M=; b=Taqp3uVhFgybDvlT0xCokgx0cVR
	QKqJnrMAdlSFAErJGC0n8tS8LOoBWbBs4Jss1t0Jdp4AsVqRN7LszRsxLdpFZczD
	b7LLi7ZpoQFEnQ+LBaL5ECDUL9vNfy1uP6QPUie9IjPngagXozwvDv9N7WpfTRnJ
	kKMjhoh8bfs9qw/e3i9QcxlNqg8GtkaEB++FaYkoSW9GXQO7qXSPkS323MpXB9sy
	KX/Iu4o+V0HwiiwSSqqN9PiV0n0UYkC1cmda2P5M7lRB+Qpnj1OztarxwMKJpnzf
	X5nlbPbisg7W12DBv7DW6/VrVHEp2XM0pgzvoliLWOJKl0TGQZLfFr8G3iA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ryhfuqvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 08:22:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso598068b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 01:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743668539; x=1744273339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6esBelNOAKgOOsjfxg+XGMAKvus81FJOG5HagSUCP7M=;
        b=uOgrgMoyhkDiSV8bsWNr4sU2YGDe+Hz33a4i1iAMjPiBffG6f8ElU/64KC24i9vWDm
         35KYoHX00sphY5v2uJNnAc0KFL0awr5D7eriLP52u+Pkf31ZwjNo+uSVe6uiPCZtFLOr
         qfSsQfFN6VL9egnAHMwnFf5rtrK2hwiYjCeFSas4gVqP3mVI5rMZcdmCw2oaYjKgS6Up
         MTNxpLTFkfnzp2DF8CNHGU+MvmCKpOIIkXEp61g9LEuYlYOpnWa4L7mdQw78t2aeNC7+
         MZgsX22Tqx5wdP44JWAABhUhG3T+2JNf9UUHSk7kb8diLl+fc6GnDLVCDeMWPkz5+uaL
         e13Q==
X-Gm-Message-State: AOJu0Yw2qxtchf8QjUFyYvuhJbjzsoz5B9KgHZyjopOljBB2TTlXaKuS
	wIsEbLJV06Ucw0BrnsUcAn9jj21wy2aPoNOB29rOOxpV0m1qpi606uD1hSeUS2/cF531P6A+rTj
	riYt5l+ZfgSYEM2keavmuebK3GyJT3xhqXNmKBNTXfW4zb9Wec+uaYA62qeIp5+L/L6WByI77wg
	==
X-Gm-Gg: ASbGnctAOQ1sxmGZ5GWNOqR/AoZR4wMS9veHJ3J0AKMvh/bJwASfqEaHgkQAKX1/ELY
	viJiuvZMGTCRzl4RakPq5heLMtabJqr257j4i00vPQa3Oy2CDltcp9E1zITW/yXjO89xAMlXyPx
	vIjYKTmbA59QkweJJ5BzYLDMRTI5PwwUNyAc+U/TAftdHZu51flbrcQfUFxmE8ai63DLbGSW4p/
	cAIh9F+DvLB/Py5JkCd3YBbSGO4/w7LnlQXVwuhVtR38IEp83ykvbYWGOG0zN4tvGnC/dLN070K
	bJIjCf1PW0sCA/ge/kWEcyH4WGHXtCAkbuL2o4peu+z/Cf+1Mm07oNEujPyXMRq9rK76LybW7mu
	KF4jOmzGKBX2VR1JJExEto4a5wNFJ8G4gEYcjfwc=
X-Received: by 2002:a05:6a00:1309:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-7398036acbemr27470735b3a.6.1743668538609;
        Thu, 03 Apr 2025 01:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGETLC/kmGTLpQGVF7+wK9Ovp6qgVpFH5bC1wFzQ+j22HSQk/gmxF+qKaR/EOTG5SXEk/YSPw==
X-Received: by 2002:a05:6a00:1309:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-7398036acbemr27470705b3a.6.1743668538089;
        Thu, 03 Apr 2025 01:22:18 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea080esm900381b3a.108.2025.04.03.01.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:22:17 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: Introduce check against zero for ahvif->key_cipher in ath12k_mac_op_tx()
Date: Thu,  3 Apr 2025 13:52:07 +0530
Message-Id: <20250403082207.3323938-3-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4S1YWMgCVn1w_MtIZDem1BvbTP80YPMU
X-Authority-Analysis: v=2.4 cv=RrfFLDmK c=1 sm=1 tr=0 ts=67ee453c cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=mQDnMu6jyAvxAejt3JgA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 4S1YWMgCVn1w_MtIZDem1BvbTP80YPMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_03,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030033

Currently, ahvif->key_cipher is compared with the enum value
(WMI_CIPHER_NONE) inside ath12k_mac_op_tx(). However, ahvif->key_cipher is
set using the macro value WLAN_CIPHER_SUITE_XXXX which seems inconsistent.

To improve code consistency and readability, introduce check against zero
for ahvif->key_cipher instead of comparing it with the enum
(WMI_CIPHER_NONE).

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0036178cf999..628504ac05f2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7493,7 +7493,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			skb_cb->link_id = link_id;
 
 			/* For open mode, skip peer find logic */
-			if (unlikely(ahvif->key_cipher == WMI_CIPHER_NONE))
+			if (unlikely(!ahvif->key_cipher))
 				goto skip_peer_find;
 
 			spin_lock_bh(&tmp_ar->ab->base_lock);
-- 
2.34.1


