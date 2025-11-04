Return-Path: <linux-wireless+bounces-28547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786FAC320D1
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654FF3A8082
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E747309F0E;
	Tue,  4 Nov 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6ge4vjn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ULdrVrDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57992248BE
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273599; cv=none; b=lWf1TG3/3GP54L7L9lo05Sob5gtEVZ29TD6IwMfQxMVxzilQkXf8vrGJwjzMKSysH7ZhtX1+xWhYObRWiBhDKON+79FnsJW4WBZCpea7iLW78ex7UkKIPrYCQGMTqe7HqLxhkroyRFL25O68EfjQeLMtd3VexoHvNmRxhWyfTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273599; c=relaxed/simple;
	bh=PbPFma9x5d8sKN6XSZk59CRnA+Ci29PRE1+NnL5DPfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gYOEctp5zt1X6iowQD6RnEB7btztTSDVnmknPw+8MmczVWH/gFdz03OnC7r+nhsUF1H93lnmxmM2KdhU9oCzsoK2hSk7T5BgVSeiM0iay7UVbsbnYlLraNudFamhBGcdP8R/YgjjWFSeLYAKQMk2iiaf1OaC95DQiSLSH+TUm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6ge4vjn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ULdrVrDM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4EdsVX2422360
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 16:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mFND1X/VRImRfWFC66Y712
	TFqLxcKNdin1F++KljD5M=; b=R6ge4vjnLEKAlkKDqm5c/ePW16kcLlfSo5RYs2
	Dp3AxIcx0+XBjLpnuxGmLnlxjF/ry12iIRrtuCPcy4SSnEZr1w9DQWRvGXBWNg6N
	f/+ofv3QE+JWdT0gOQyGDKhkT8wtVkWLHM55MXQOjAX/QEq9S9PiuWMAy3Eu5MGU
	yRcgI+QQqmwXOKi9kMsoKsV+fuIJuhFtfQ/OcB87D3+wMoxZtXAtalt3nIgXrhJk
	hi1ZNVnNZ7PtK5CHwsCl5ryyk0GFFIyOHG+P8B61xfr81uv0XCo+1x41SN84Qysd
	+IuLEtZ0vn70Xfj1P1hq7Kz4xuHvlCOzsyS/KUQtta1BhTwg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketgaxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 16:26:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2952cb6f51bso110640955ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762273596; x=1762878396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFND1X/VRImRfWFC66Y712TFqLxcKNdin1F++KljD5M=;
        b=ULdrVrDMazPkvMOzDqT7OP4ImyKORHYoX/rSFIi5Nf+W5h5pbxYzFjz/o1x+5U8b2L
         RrvQlXiSSI+Tfc6iwtW+wS1hYqVR0Y6/TZ6uVXmywDU1PLlcYBlLENhgmaP95rNz3/S0
         8XhkaPtyUyOyCd1ksOW91McQnOTbsmyaDaY4fxvs1kvDZD6tH940hs986Kt+rrg+1LSE
         5yPwbbP0vj15WPN5Wxrcen2wCkMC9jclCs2ob8RaYp5QIg3hZluqPQWikFYB+BesNq/5
         C/+sE6atfHR35zzX4HFP4xPTdJTuEmP0LSWSNmDU6tWNkmRO5NN44c/1HItLIwG2W47d
         XzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273596; x=1762878396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFND1X/VRImRfWFC66Y712TFqLxcKNdin1F++KljD5M=;
        b=UYH+2PLdIviezfipg0UYClA26Vd9Yv9ob6ftaUdt8DGhmCcu3ej3NjhGjBUK3+ey98
         /sseHN2n5lZ7lNWQk8zgszSKGdIMgStJoG+Txj8UogNneLMRjxkq6CGjUT9zpK0zIXYO
         8CnBc/oYRni4gXx639loGT/NLqjBtG1Xg52FKCbgHPnzoQt3PIlLofw3GgFQrVWvLD9g
         4YQQv/Jtd+sHZDY7nOfxGf2MprVmlFZQHPp6KzeZqa3nW/Y+TUWjrl9g6o5otc72OrMx
         xvwVOGdziOrOMF5usj5Bx0SA6iYk1H8tlmaVoFYbOjOAN6sw+4ysY4w3GvgU10ZZNvaP
         0Wdg==
X-Forwarded-Encrypted: i=1; AJvYcCXItoz88wUtPgj0PSvYEsRQlb14408l043hFtTX2PMc5loCn7l8BVdNzXVdFDgud0vgV0ekLh9QU7Pbjj4alA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0X343mpFOUXY7dWHHcsBf0qqYNKL057DstsT1LoIniio0Qbv
	YzIoW8xlN9YtDpK5Ow40ukNYDBDB4+sLAOxZ7flAbmwne86EsYVb3GEBZTRJqJoTQICgerVdyy7
	IZMC0RoySzdMSChdIiiYQT+1thu9qOAP4xkLG00lz6t0XTdMocpZVfp+9tWTsuKLtr9MCfw==
X-Gm-Gg: ASbGncs9ETwXU93dd4e6tZkhChM0RrlNDkGIY8aWHBG27xerdSo6HADQX0HcA/zqbTi
	IPEUp4yERsGzEyiTqnUYd+xZf3y5kMRsIbiovZGZtRca6PADDfpegdepPs6PNyEuPoQWvAXzOPy
	67vQM7KL0wPZLCShxBys8lxYzTf7tqb/N7E37GhmltT2oJb4HVwwSbtSO6FRArvSXg/nQIImC4v
	tVhvGkGda3vn6IEaMnPdh+Y3p356Eq4J0FnARCXBPrHsfSpok/T9r3wihUTn9YcDjkZU4Ri+9Tt
	hAPeA8hyhspXdkY02HvfBqglKOZdZjSDyfNypRveF7qx+GrYMCJuT+ubiVpbePwpZQ5DWRKV9WW
	scLT/i+Uu0FHUYlTM9tLJ3kmZ1zAakI1Ujpkx8kwaxXMW
X-Received: by 2002:a17:902:fc45:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2962ada4d6bmr2508595ad.18.1762273595472;
        Tue, 04 Nov 2025 08:26:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBUwXeVwkSk0IirZkEPPbrkJQYnb/rbwE7ff67TC2LgRxXyedOxM6ikgcQcHtDZv4YQt7Hug==
X-Received: by 2002:a17:902:fc45:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-2962ada4d6bmr2508025ad.18.1762273594713;
        Tue, 04 Nov 2025 08:26:34 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7a8a9sm31508435ad.107.2025.11.04.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:26:34 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH ath-next v2 0/6] wifi: ath11k: Add single shot/periodic CFR capture support
Date: Tue,  4 Nov 2025 08:26:27 -0800
Message-Id: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzNyBTYWx0ZWRfX5quiBDcRcmMk
 tzWeGnNbXcPO/Xdu3yizk37X3c6LdF78kGZKtqoMjdxXG2j/V6562azANZ+9UC4/yRB6GNG4xpo
 TXXuBi++Uizw+N4SoCyFohGJKDi33ap4hEuRUWW34grWMxzFHvRcBNeuJePgiEv26vWohxMLfCg
 TNRdWXeDV6PCibhnUo0dQ45tf4zvgU099Ojeh4jpjQBlt65Ye8l9C7utXqqU65VkKEJna46cDYf
 K09w8MqNOahQmn4QBZ8z2JmF6FSR9RUG36Tg1YnBbLYwspnzhnU1+q2gHuJ2XyP0v3oBOLUsZWk
 bq3F8CNpTUV23E/6mc64hhg3gBz5GrqDTc7uUcHMKCfiATutUI8CzSg+n8ooOhSDf1r5Yq3GahV
 vr5dAY0xHRnyTmLWYwyRJqE5L9vuGQ==
X-Proofpoint-GUID: 5u_m9xJ52OXbKRBU1ixT9g2vBlGRqTlG
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690a293c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=hBgn-SwW0Swv5iSSo8sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5u_m9xJ52OXbKRBU1ixT9g2vBlGRqTlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040137

To enable/disable cfr feature use command,

echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr

where, val: 0 to disable CFR and 1 to enable CFR.

To enable CFR capture for associated peers,

echo "<val> <bw> <periodicity> <method>"
 >
/sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture

val: 0 - stop CFR capture
     1 - start CFR capture
bw: CFR capture bandwidth
     0 - 20MHZ
     1 - 40MHZ
     2 - 80MHZ
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)
method: Method used by hardware to collect the CFR dump.
     0 - from the ACKs of QOS NULL packets.

To enable CFR capture for unassociated clients,

echo “<mac address> <val> <periodicity>”
 > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc

Mac address: mac address of the client.
Val: 0 - start CFR capture
     1 – stop CFR capture
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)

To collect the cfr dump,
cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin

Previous link:
https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/

Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>

---
Changes in v2:
 - Update related comments. 
---

Venkateswara Naralasetty (6):
  wifi: ath11k: Add initialization and deinitialization sequence for CFR
    module
  wifi: ath11k: Register debugfs for CFR configuration
  wifi: ath11k: Add support unassociated client CFR
  wifi: ath11k: Register relayfs entries for CFR dump
  wifi: ath11k: Register DBR event handler for CFR data
  wifi: ath11k: Register handler for CFR capture event

 drivers/net/wireless/ath/ath11k/Kconfig       |  11 +
 drivers/net/wireless/ath/ath11k/Makefile      |   1 +
 drivers/net/wireless/ath/ath11k/cfr.c         | 994 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h         | 301 ++++++
 drivers/net/wireless/ath/ath11k/core.c        |  41 +-
 drivers/net/wireless/ath/ath11k/core.h        |  19 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |  50 +-
 drivers/net/wireless/ath/ath11k/dbring.h      |   8 +-
 drivers/net/wireless/ath/ath11k/debug.h       |   8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 143 ++-
 drivers/net/wireless/ath/ath11k/hal.c         |   3 +-
 drivers/net/wireless/ath/ath11k/hw.h          |   5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  17 +-
 drivers/net/wireless/ath/ath11k/wmi.c         | 147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h         |  97 +-
 15 files changed, 1819 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h


base-commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08
-- 
2.34.1


