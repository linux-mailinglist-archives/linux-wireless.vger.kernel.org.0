Return-Path: <linux-wireless+bounces-18317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB75A265F2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40E71885451
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F92620FA80;
	Mon,  3 Feb 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvmaUI06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774E1DC075
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619095; cv=none; b=fDCotPCThlU7FQBcSbucpAYv59on2xpZAFhvYhviVZHuKqPu+HdqW3SZUZY44cuLJLNwVWB7/WalnLJqQfwCOLJGBkZ2RZEIjD9Ark4JxjVj+j+bMq2B3ykxmZ1yLCpambfcg0+vrtoBsFibxoF96A1hzeUcLMX4EdZDpVg4c7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619095; c=relaxed/simple;
	bh=s3syLp001Mbi3cGLUWqD3+/a99Iy50jL8zCJRLbgyE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ga03+OPN1O5ptFWsTlh9Tevk+YCfg/aldMgIqqLX5Dyw+wdoZ8/OyqPBR293aPpP21iCBw6teJgoo9kgMUr5o9kXsujNvdra+r7z0OLql3fZV16Y9SlB8bgFK21lnL0HkX415qkGzrgAm9lK+Sou1PiXwp4M5wuoJBTkD2Xb6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZvmaUI06; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513HfVkf017320
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 21:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ZEDn3XVEt6akZzZOwx/nZAjeG/MuYCZj63I
	sLrgaYEk=; b=ZvmaUI06rR7bRNd5SvmSsuMWmWpoBYo9YvIG3EzSI76BN4kjFCw
	AWP+Mldenx6Lovr3t3IbLvsbJ2NMVl09UBsqE0kX7sSu+vBU+Y9uyJopGJNTWBh/
	Fnd2W/caboMvF3FdWJoYgSqKpq09Z5WvZo0yiw6omgq5zlVNjwCa2FvMSpn5HW6Z
	FNisD1iW3iYeakW1sqmvTYJWHM6Y5OO7cZXlmwv7f3nLw6GYCOUh+FLbG3IocHdf
	PfQgknFNW9w1MqR0oLDOMH3tmw76zq30fwiapPd6GYO1ZT4S29uav2UaYIY8Suh8
	aqJo3XW8XyGx3yQXkgD0tK+i2qy8cTSGdfA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k2e1ggh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 21:44:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216430a88b0so104829435ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 13:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619091; x=1739223891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEDn3XVEt6akZzZOwx/nZAjeG/MuYCZj63IsLrgaYEk=;
        b=f1kpstRFH+P4pvuyIRsoev/nAt+SWDiQhL4q2S5fc8USdzr3p7LGTsWsG29qXEUty+
         SX1CZIaSp5nzWv283rxIAQtxJVjgr9emSSe+2LxEtm6K3mGxzDA2lqpJHeNWzVkp8Dtg
         9N8zRaKEQrzGJSFf7cIh1XQCtP0J/W1r9MSKoVoxlu4XtJCm8dMvkQKVqgmX5xjSlDgb
         D/Bx2YKadFS/PhbDrFNaWyw9KxLdOiLAJbfzhI9X/ZR/bocLcYCDtUOzbxNjhXioeSJ1
         +VQwSByxiz5jHRTA+K7fbuVdaK/lHVuYALQTVHH+mqr03Rrcx9qkDBiept2IS+WJ1Zj/
         3mYA==
X-Forwarded-Encrypted: i=1; AJvYcCUQHWm6fMO39OHE5E7oRnD6kVNRc1f9y0HAXeCZg2FIj8OO3aLTjiOzb2IHyKf2mtcVkLB4xrjRln8vYlugNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/drIJD11pZJ5wpNuXV2osI2cTTuEIxpPrxdemr+zVu6CFjXU0
	ysfnay3Ld8DpQdaEdzy8D3NMVFNaESuYyy5BmAYL1piyHK+7q2y51vXeEgIanwPPJBJ2TcurJF7
	gESk5cLYFutOLpyrBW5jfSwMha89JC/uXYvqBWrwH1VMpDuBo2aGxxXOb5C6nTgcDV4fBdEtEXg
	==
X-Gm-Gg: ASbGncu6Xm3+wvE8olR+ARYykwbNCfNBoncAXJm+aD9KR7RvdAA65NmrZmN0MJtpcK0
	3q6ZKlJ4uP02gFkS8f0Yx9Sds/Zpoww8VYjRFzhATF8VyxOXw0b/NSQMEwsN17FfuVNVkCwsngt
	jLIYtpCpAJo4b+iw/N7L6Q4tN34Q4Ph3JwqWe7NySK2oiDvGseYG/r3CbknBeE9hCi6g7UX3VQs
	GPKAjFyq+a0sRwVB+1qspsbv+kjgNNSAyVVqPMzCuQZmIjDKLdKnFxlUB5sIgIAXDRgCjMYQ6Wn
	w7y4/AaE3vk814bplM6Zsziu/jzUXZZLvB7Ihd/uJkj+/IKyrHUJQFXed8pj
X-Received: by 2002:a17:902:ecc7:b0:215:9d58:6f35 with SMTP id d9443c01a7336-21dd7c55feamr355493685ad.1.1738619090873;
        Mon, 03 Feb 2025 13:44:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJSldFMmHAs1GyZjxpsdqWbVw/GYRVeb9lNA6EfYL17e+NvTXnW1K4z1HGv1AicIKVEuGm+g==
X-Received: by 2002:a17:902:ecc7:b0:215:9d58:6f35 with SMTP id d9443c01a7336-21dd7c55feamr355493485ad.1.1738619090559;
        Mon, 03 Feb 2025 13:44:50 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331ce6asm82357895ad.209.2025.02.03.13.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:44:50 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 0/5] wifi:ath11k/ath12k: refactor tx_arvif retrieval
Date: Mon,  3 Feb 2025 13:44:43 -0800
Message-Id: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A418GWkmkA9GwtLQRCgppzrEI9sxAHJE
X-Proofpoint-ORIG-GUID: A418GWkmkA9GwtLQRCgppzrEI9sxAHJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=962 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030157

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

v3: address comment from v2 and removed NULL check for
vif->mbssid_tx_vif from patch #1.

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


base-commit: 1ed13fdf7d8284742c8ede36dd553387839e5163
-- 
2.34.1


