Return-Path: <linux-wireless+bounces-18041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F0A1DB3A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF3F3A5441
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACB9189F57;
	Mon, 27 Jan 2025 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LdUgn21x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BC7DA6A
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998539; cv=none; b=DpXAGUz+NCI7JhrmPXjxOG/O7t4a4CY8MrI5yEh1gYVDHthsRB2AMJqWmNHhnMEgJofMXeETw3QoISaqeH4s6SlyWtkySqMMadASUya+wg8W5Nx65GnBohDxFrkijCF1NtOIxHRih3VNkjjtIDcYG0m3qBXPmRGonuIbvFO59+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998539; c=relaxed/simple;
	bh=7I3f88EMzq2rgXVXJCUCPUbx1BzOvLzMu8mNcX7ocbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLCNYG268EeI5f17NNkXu3ipGC9ocO+Jk8XDrAmMN1MvBKaRRwCN0DIpG8yL6lAMO83YRfCzO8rkeG0ZYAghXNLC2U/loOD62Tsios7B2mlaDadQ4Ifm69UWbwqImewzoiNhluG6cBVc0vTOMK7ruK1e0PYD4nwMHvREqOLlCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LdUgn21x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFtFHu020870
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 17:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=w2H3WUaNQwsaAb3gCGRdZw4v18QA9Nzh15V
	6dq6hVJc=; b=LdUgn21xtWQ/xwoVdvmjV+LeYGILxaIaoP+gBWN201M/ldmMhAq
	ZBGq8pLf48GuuKiLBoQYCx/Fvxy2c85BzOksm8gAheCf6xIWqs4V2qNGdy2DCfjY
	LtoXUrXkx3oPDGEfUO+YOyQN9X4dx1qnyjRehe2VyVEqr9awpF3EfWLcB8MWjpa5
	QZoViASk8NH37Fl8dKC/ACdnTc/eE/F9UPfjSZzX+iDLHT9X8ggaUG8t9FxJQu45
	+XmwryYfi+mYEtDCRFaYYx1G7ZtGXuqDcvJrCTRSaORPVzwdCNFmaXJNr3h0FBlG
	eKjmLiiK+KURHVw5Vk7C+C69fGWF0z+jhXw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ed6yr6s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 17:22:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21631cbf87dso94645555ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 09:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737998534; x=1738603334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2H3WUaNQwsaAb3gCGRdZw4v18QA9Nzh15V6dq6hVJc=;
        b=n5f2CI69NwQrE+UeqiUsqxA6Y2RNMqWRWtNzTfTAs/0gEFOwZCqRIC7rh2aCAOUQ9B
         4wuzPWkxU8zGJEnz40zNkkP7CbXx08ZiD8dJO+OLI/zNwcZIaBjlMsijfirV+xBD6qEQ
         7iPmUSMsU8UuZ0muEWv4z+9IKUNEBxYcuCsa9k/jq7TwG1iHCMmJUBB/7T2Q1S2Lw+6T
         n4EwC3MI74VaySJk0qTyOhtjx6+C3gy8ZtcfiX0ORe8Lqu31IDWfP6yGC3jI3Y47sOPl
         FWDpBfOIZ0maY3uhgQ1TPYT+4MW6jno2DKt4tF4E9o5FIBK3Y7PGBMXpFP4QQchXctfb
         KQIQ==
X-Gm-Message-State: AOJu0Yykbb6d4ZGyOrLICO1ix9BQvFx9+AzhuwcQ3l0UUknrILIjOBEj
	X7xdg8M72T9cspiogSZ69+k8NsPxcO/AvTz1hUXm9zog4eR+3HnU6eNvP9vJVoNB7X6smKLyMAG
	StfiWDdGR+jkykLEAf4CWtCWq7XLJpJlUraV3BTb871TN+wpmmN7R+f75r1VZYDe7oA==
X-Gm-Gg: ASbGncufBalYAGSrH1+r8TPQ1wpgIJGbgQlwKcl0AqFpZ90QCk2ODm+gPTTbUv+8Vg9
	OAeVOc4kvChkMBQTHzETvy/jiTqMt0L5biqjIp8yYUSj4C47WLWJ+EuMIBxTDVBB2K1odfRrXpo
	LX7SYrqFuWeuI2ZNAzrVP4pqS7PpkZPnEdMoIxF91W4EopoiUbT5NnnTnql595QfkfjsilKC9fc
	1LGbNd/u8gYRI6/5BX2vzLpl7BdQWlNqH7NNufpXl+ryzJLupWGdH6zRUAaa5VQwdWXc4B2h/rU
	N0W7OcJvHONgpjmMf/qXUTLT9sEjrlXVRPJ4WKzN7ld5WuHMIInl+IfAB8dAgOjt3rqPNb+1yGm
	kO6+GcZC8wtE1onezEyFicmoCoL6zrEEQ1w==
X-Received: by 2002:a05:6a20:9152:b0:1e1:aef4:9cdd with SMTP id adf61e73a8af0-1eb2145cb7cmr63636517637.1.1737998533835;
        Mon, 27 Jan 2025 09:22:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG418GSIzCDpHtOEMEZjmZHoa7ZnZu/zhFFWaiALhb8y/n8B5l7GrsF9CE0e/RWvHzzd2IBTA==
X-Received: by 2002:a05:6a20:9152:b0:1e1:aef4:9cdd with SMTP id adf61e73a8af0-1eb2145cb7cmr63636479637.1.1737998533418;
        Mon, 27 Jan 2025 09:22:13 -0800 (PST)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b2c07sm7464639b3a.40.2025.01.27.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:22:13 -0800 (PST)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH 0/2] wifi: ath12k: add support for get_txpower mac ops
Date: Mon, 27 Jan 2025 22:52:00 +0530
Message-Id: <20250127172202.1410429-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kO-xR5Y0afDVpqyDeSh4n-IiHN54G89F
X-Proofpoint-ORIG-GUID: kO-xR5Y0afDVpqyDeSh4n-IiHN54G89F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270135

Currently, driver does not support get_txpower mac ops because of which
cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
gets its value from ieee80211_channel->max_reg_power. However, the final
txpower is dependent on few other parameters apart from max regulatory
supported power. It is the firmware which knows about all these parameters
and considers the minimum for each packet transmission.

Firmware reports the final TX power in firmware pdev stats which falls
under fw_stats. But currently, fw_stats is under debugfs.

Add support for get_txpower mac ops to get the TX power from firmware
leveraging fw_stats and return it accordingly.

Also, move fw_stats out of debugfs so that get_txpower mac ops can
function properly even when debugfs is disabled.

Aditya Kumar Singh (2):
  wifi: ath12k: move firmware stats out of debugfs
  wifi: ath12k: add get_txpower mac ops

 drivers/net/wireless/ath/ath12k/core.c    |  45 +++++++
 drivers/net/wireless/ath/ath12k/core.h    |   4 +
 drivers/net/wireless/ath/ath12k/debugfs.c |  44 +-----
 drivers/net/wireless/ath/ath12k/mac.c     | 155 +++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h     |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c     |  94 ++++++++++---
 6 files changed, 247 insertions(+), 98 deletions(-)


base-commit: b5aeca2e66899430827b8afcad061201f3b7861b
-- 
2.34.1


