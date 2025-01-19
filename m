Return-Path: <linux-wireless+bounces-17681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE07A1604F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 06:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0992188561D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 05:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3887741C6E;
	Sun, 19 Jan 2025 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4/vwzaV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A781366
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264178; cv=none; b=DCUWVqD5U6MeNHlFNYZqM2BVQJKPQH2iDCKNjRB8QfQ7GndlT0sEq5kUeJOOIc4h7/kcMtIEzfxG+arIdA8nt2h3a1bOWL9wnAI0gv5IJgQJLpoLpkufftN2Qc5fY/Vy2hfY+QBv5UaHF7VrtwixFToiUsI0ez0Lh2O8r01mWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264178; c=relaxed/simple;
	bh=/tzIi5xlOiiEDCJYpErXGZt6+j824t7hGyRzdHNv8Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQrDCreAlomW4BDdQT+yMllAbRYlza6n3W6h0wZc15Ittp39POphz3B2ZE4m+xhOco9DR3XZ8sfmi1nCca9D3hKMTXCHZmX/HYoKqWXgFN6J8fiG6GWIUzo8lBr3NRSVFm7Q/71r26rcnSL0oLQ9PNujemntfmBkhi8KW+rU99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m4/vwzaV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J4nqGa031373
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gDWiRUfx1ZKo8bEQYsYj0h07t8RZmfw5u+K
	jMRLsDSg=; b=m4/vwzaVKEuOooWxqHIHSvE/g/LVd/1VDXMvkoIC7Uw1AmRvwwb
	3U/pz8lOMphZSmOSFNxHKQELE38D8eczGjBlotLjCw9AH2CkFJ3ODBthIRarsdzn
	m7tK58ppXeQFKNocx6cnEaq7GHHzLpLsY4vBl+NzfjQdI7EmcKaLccq/ddmyv8dp
	MuFmr/nrzcwBrjTkUhJt58tFTpVhCMVtftpKZSoBAxBUI9uaZsbX0dTRtOOF1uPA
	nprqlHERowo1MHIk0bLR2Zu+Bo2PiXCaaTWuZ4y9FgqoYKZ/zCSRTrQ9RgsPmBD9
	HAFe9QxMonFTB8iL81RCy1PWvayq4Pos51w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44820chs02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso6468289a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 21:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264174; x=1737868974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDWiRUfx1ZKo8bEQYsYj0h07t8RZmfw5u+KjMRLsDSg=;
        b=S5NoH5tDM41dmdlOnUrRtBTxtCDKDvqU6fOlzSTgFNF5A+XQwnx+wEkTOSWZ0olLq3
         fcM6SoeKiIn/Z11RwMB6+Nwq4lOxqQCqHHE3KdZofC9ml8EqymKY1hli3gzyn736vMV+
         1DitEN9l2/mQitEFCBANongsQ0/A0aLuBH9owEqijOm4yP6xLzXfF2UuiTEzoajdpuwc
         wQrKPp47EfWvi0/vCWVsSOx3SBRwN0ZF7A8GK9artkyPCpYJAMiqUEng8v0XB3Ldhflt
         QVsJRNH7Vu7N5+mnPWFilekikCV3imR5igvYprzq0DIOIPXz8rpUT7dfXiJWd3R35IHZ
         /wPg==
X-Forwarded-Encrypted: i=1; AJvYcCV+uUTkM2SrdphOKXS/W69gKWJ6cZQi30vkqigeBEvmIJyT4KNVwErQYH1YfuIPvFbhIs/6ygI+CKPR0Y8uuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21qd5xd2p+BN/qmYexnTzLl3EgSTTV0AmgObUKWNckuLYxGOo
	5wnACANrE4PyrLZ+Nih24JhYV03VmMi3P4DUM19H4pyDAuY4hNyc+1S0r0gwixV9DOsI1+tQVgx
	cU5wiCdx2lhpL9FddtpBHMKDzBN0pgz/BcoQzIT8xffkUB0Lx7yN5UBhfT/tLktp4eriAx/sJyQ
	==
X-Gm-Gg: ASbGncsWf60pzdSvxAZ9GSftrp8YzUVFb78Z/3e3TES3DnZtDs78McdtSVGNpuRg2sX
	HjEnpQCdmwXj/R0qdmVNNGhihc9CwAsuDB1wonhJ7rPAu3oNi83BFCZVM9M/9g0gsitQn9rznR2
	eZRUzC6vjQoywA5vAgurVY46CP1Q+67QHKIJZz38OnfY1jRT2QgGX6r+bp+Qb1fash6+KSWJGpD
	xPFYZQlI+G1Pe7kwcYofz5wcYrLR01/v9eiLKtAv4mFzxL/ERAIl1/U/OmjJmWhNle5KItFL47B
	3geWuvC22rPo1KXXEVJOBKy/fnRLtwHXIUnFrY7AedrZEr0uJw==
X-Received: by 2002:a17:90b:530f:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2f782d86491mr11714019a91.31.1737264174231;
        Sat, 18 Jan 2025 21:22:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm13KSOHvfQLgtw6hyQxS9E/MOoHXkOylL19cWnXyfaDpZ+N8bKi720gk6gFcr/UUVFUF40g==
X-Received: by 2002:a17:90b:530f:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2f782d86491mr11714004a91.31.1737264173826;
        Sat, 18 Jan 2025 21:22:53 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a295sm5062553a91.7.2025.01.18.21.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:22:53 -0800 (PST)
From: aloka.dixit@oss.qualcomm.com
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v2 0/5] wifi:ath11k/ath12k: refactor tx_arvif retrieval
Date: Sat, 18 Jan 2025 21:22:45 -0800
Message-Id: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4GNr9Pi4_ldQPkMGBfQlKC3m45QThIKt
X-Proofpoint-GUID: 4GNr9Pi4_ldQPkMGBfQlKC3m45QThIKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 phishscore=0 mlxlogscore=930 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190042

From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

MLO MBSSID series for cfg80211/mac80211, which is in review here 
https://patchwork.kernel.org/project/linux-wireless/list/?series=902914&state=%2A&archive=both,
changes the way transmitted profile data is stored for each link.
As drivers currently retrieve 'arvif' for transmitted profile at
multiple places, MLO MBSSID changes will becomes unnecessarily
bloated with RCU operations for every retrieval. Refactor 'tx_arvif'
to avoid this.

Additionally, fix an issue in ath11k_mac_update_vif_chan() where
tx_arvif is not reset to NULL inside 'for' loop during each
iteration.

v2: fixed kernel test robot error in patch 1/5 for tx_vif.
https://lore.kernel.org/oe-kbuild-all/202501160626.Jbb3GHnk-lkp@intel.com

Aloka Dixit (5):
  wifi: ath11k: refactor transmitted arvif retrieval
  wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
  wifi: ath12k: refactor transmitted arvif retrieval
  wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
  wifi: ath12k: pass BSSID index as input for EMA

 drivers/net/wireless/ath/ath11k/mac.c | 75 ++++++++++++-------------
 drivers/net/wireless/ath/ath12k/mac.c | 81 +++++++++++++--------------
 2 files changed, 76 insertions(+), 80 deletions(-)


base-commit: e12eaef2f7ad3451fea43de58fd9da64ec888c01
-- 
2.34.1


