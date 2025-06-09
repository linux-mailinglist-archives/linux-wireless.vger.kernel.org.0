Return-Path: <linux-wireless+bounces-23835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3EAD163E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 02:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AE17A46C4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 00:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AA28F3;
	Mon,  9 Jun 2025 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfPxULB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64ADF59
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749427864; cv=none; b=fXN1N8QNRxE5HE5orNjFYXuqo101WAkeHUyhev8E+2xVOlcgSVjgi1f42ae/DJdI8lm0g0EGyma3VIRQkcY3WgeONc9hLSNQmIswgtkGJm+jeox8k4YQ7HLC4deo+VDamiCGXur1bNWrZkiIo4LpDDrXcJDS0Ov6Cq6S/usYSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749427864; c=relaxed/simple;
	bh=rdK9FaPYl7rIEu+M4ykAzPf0dYII63CsPWPrydyOYmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bH5VW/kNFLqUYm3CZF3p9S7DQoMoYGQ8kyxvOKSqStg0Wn8G84Y1KTfmT8eQm+LEUbG4Y4vaWJRiIJ4K59vDKIi6nQbdO6V8NOd/ywb4nyI2cUKT6wvUOJbbTllVMVqaALT9HUxsriedagZc6GLQrzxxV9o/1fdH7vvO0VhIClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HfPxULB3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558M0gne015275
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 00:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Pssxm74EjvL
	onq2GL5omi6L5LoQks4JqU6dREzJv7bI=; b=HfPxULB3l67zsRUXi4xKFTBRdaK
	RyBzqn57rLrHZm5On3v7K0zeaYnHgwkPtBye0W8UpGVdOPb6wNMQ29yKTVQppwQj
	cCn3RGep702HwqonojEDZovsx95I+w9Qn79erjrl8OD/rlLctOqg+YrUvbiTgsNi
	XgM92q14Dz594xI4CIGz5a6ghqc4Tw7dS06eUdVNa/a5TpFCa9msqnXWAh/20BZ1
	M9O1JLgl6cjcMaeVrqypABTMnyEU6vMqWEsRZGqqD9rQ4cKSMrPeahN6zwLtZDtR
	3A2x12eLZbgmmmFLjPWnzVBcxZl5xH48txdfofg2n6qy2I2BPsbc1Q9a+4w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474d11ve6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 00:11:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26e4fe0c08so2366976a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 17:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749427860; x=1750032660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pssxm74EjvLonq2GL5omi6L5LoQks4JqU6dREzJv7bI=;
        b=e9u6n8mRY8zXux/ZJ/178G68DOOB7tXt/KNbzinqp4y/ZltE/FblG/hviAns5VoRFc
         8L2t9tUxHnzYLE/Ux1nbm1hQELYv/i3mOAHbbVyKjak7LiQWxQ8slqWFf83nffKKoMw7
         QaaWX2wEb0wAyHcNtSATRb7gder5Iko72Alpsu5ret0W990fdGe4yHJKB3zOBSQdpMJK
         joOtP1lwG9ev5ELzEQxmA2W/4iJahV/woG80+lCoS4/U7Bokuo3gs3Apl4YnOBa8NwX0
         /l+S86LT9ShTYNTtrZ9ySADLQXq+8yhGgTJnX5Inq30HUoPiZxzmsidjk/t9hnBPk51Y
         pXhw==
X-Gm-Message-State: AOJu0YwBpnc+1vbeJGaYF9XbY0Mf9OXKmmhWbZ1U4RnhNAy2zBWRjaCC
	Gy7AEYLDbmSDaxz1wAngqczunL7XOAKyNVlCz3buSBGsqQ8y5uYYhmbH7/b0OUJPHVqSgH6ravC
	/pg6l7Liy949pBW3lFSxMDzPku3bUr3nFxu3xqPrS44DlWFllGdcmDDMMG4m7rfVii+171A==
X-Gm-Gg: ASbGncuF/kL754X2eMp+PqN+tFkpc1RgoGnFVmxSGOc6GPT7W69EkMUFbjVO6YHxo3S
	Jju+ehayHQOQUGQA1kExtwsz9CK9IckRlmvU7yA7w/cQUYqumqPwtOGqnB+SMxiwe1WsxfC6iiA
	wOmaZbTa206JeWqTGeY5Ijnbvk15TDYNC4vdAMTMyQV43qSM3rBE7SvfNAaTtYqbeFRz1FQiiYs
	TUkYOW9e76ar5N2TrhVQNcN4VXfiJZa0fmvZZz7EqJhShV81MGLk/wvmXlbd4T18uKWRfziwA6G
	XKMwJ587D4uVO6xJx3k6d/gDFmcOHbi5ixog5YiAdBpPmu2hqqKBFYlFh/K1YcL9VcTPcTFH1BZ
	NQZYSj3opsCd66+9vVKBrFbNS09xRVVrOIsucFOcn
X-Received: by 2002:a17:903:3ac8:b0:234:a033:b711 with SMTP id d9443c01a7336-23601dc017emr135552215ad.50.1749427860627;
        Sun, 08 Jun 2025 17:11:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1KUu/tEjUvpknxoMD5TLenltbICAuhrgw4dTLcSZWeDWalWh/E5WML0iQxjmQcoAfJiSBGg==
X-Received: by 2002:a17:903:3ac8:b0:234:a033:b711 with SMTP id d9443c01a7336-23601dc017emr135552075ad.50.1749427860314;
        Sun, 08 Jun 2025 17:11:00 -0700 (PDT)
Received: from hu-rkaliapp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034059cbsm43731235ad.165.2025.06.08.17.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 17:11:00 -0700 (PDT)
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
To: johannes@sipsolutions.net, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
Subject: [PATCH wireless-next 3/3] wifi: ath12k: Send Puncturing pattern of mesh peer during assoc
Date: Mon,  9 Jun 2025 05:40:48 +0530
Message-Id: <20250609001048.2263586-4-ramasamy.kaliappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
References: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5CWM_z5H-ymfln4EvMiRV5QEGEVDkNfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAwMCBTYWx0ZWRfX7Lx71HLwTVPn
 W808bTKDouLcuX2XKPNqQeEmS5UG81pEnpzf6j1knHxpD2q5kmucPZNhE/jGlgOwO2NOZJi2g70
 15F963ZjV0TeRaIvc5w9UglRB1Azui9GzASsQVFZIad59XefbB+jxcA8yfQSk8GBKCrlhBYaGOf
 yHsFxdLfh22KhSNE63NAUVlZxCeioJUsWdLJRYB5HXk2UAZiwaWT8ZZPxbWNbLklsBICrI56r1c
 FseJgngvBAyIzyoPQCosG8Yq61NJTkaZHs9A9sG953eewY2hlz6ZEaoQc7Awcjj93BnC+hbNyUu
 iIDPrzRWi0Y64ZyuWhBHljOGVASMtscjZNVZoZzj1S7Psk/6n4RnZPTFZxSVdtVZQhe/X/pm8TI
 9SUXATCHMAzYht/lsWfOGFjWYfVeaJt5flA3xG1q03YkMtY68j6OZTNnhRz+H1RfD9cjfb80
X-Authority-Analysis: v=2.4 cv=GYkXnRXL c=1 sm=1 tr=0 ts=68462695 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=U-DH1WXsBolClD83dJkA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 5CWM_z5H-ymfln4EvMiRV5QEGEVDkNfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090000

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Mesh peers can have different puncture pattern. Currently,
when associating with a mesh peer, the mesh peer's puncture pattern
is not updated to the firmware.

The puncturing bitmap should intersect when the mesh station
has a different puncturing bitmap than the self mesh vdev
punctured pattern.

Update the mesh peer puncturing bitmap in WMI peer
assoc command. Firmware will internally intersect peer
assoc puncturing param with self mesh vdev puncture pattern
and determine EHT PPDU Tx bandwidth for the peer.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..4ac3d4f350ea 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3028,6 +3028,9 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	}
 
 	arg->punct_bitmap = ~arvif->punct_bitmap;
+	if (ieee80211_vif_is_mesh(arvif->ahvif->vif) && sta->deflink.punctured)
+		arg->punct_bitmap = ~sta->deflink.punctured;
+
 	arg->eht_disable_mcs15 = link_conf->eht_disable_mcs15;
 }
 
-- 
2.34.1


