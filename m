Return-Path: <linux-wireless+bounces-25632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54AB09B20
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A34C188058C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6B1DF994;
	Fri, 18 Jul 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yao2Uedm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9D17578
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818943; cv=none; b=n2HWSI7v1T0T6d1/nDsK4Gk5EW3EYIvu2Nlx4iP/O1csAdtTo8ZB5LzeVpknHoXcdbdj0ezo+QFYjCgBuAWYVzEkDmvq2KTvpM45tYy90nFZjHiktlEuiKFjhOH/Lv6OJ6jR7wxKcT2FxbK/vUHxKCikooxE5tuM6S8kies5aSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818943; c=relaxed/simple;
	bh=ZxVyFgg8Y3CqCPNTBa3wYyZmBqA/HCPEKa25OaB8zmw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KA1ihJgc4gGbcgTPKMCHk5I+aSFpGdhEe2b/rXCF3QBDthAqcRWIla11f0rtGLE+obwJWP4QMTiDc44RPMH8hR6IZYu2iWsWeGOydIpFeaK5wSmDZLLSooVMvdl5Wdj9V4Uf/6picrTpwkFWNPHZ8kPxCVT3DPZ2aGR49xjPuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yao2Uedm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLtlR5030480
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=jm1TqmyaJ73a
	Ev/+A0NMqHKknbGzbroM81UPzBcA/zk=; b=Yao2UedmxstYn+aevf/NeEH/QM3I
	UzVUDS+zEsvOsb7OAGaYdClatujU1wdgBo8bohOzM/KAUtCNRbxS6x7ewh6GfbTx
	6E0xGc8vSlkkj9EECbQhGfCvgG1+5wViKVP9XPB2eBX8INJbzJNcTTrw5rPubllm
	xfQnlzf9MCyBqVQ6SotxIYe/p+Sr6NC0lXWBiXAsJ93pIpDQ1dja1WfGdPkhlDmw
	qM41Yw9895FocE+KehVAd+vTBLbN1r0lbOICtmllaI20DC1Ag6m1N2Tqc3mATtSr
	8v3CQ4tn0WEsQwtBxGIJWSwK+YaMD2tWpmpl64pDoTQcB0hpaD9aM9gj2A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7q62c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748cf01de06so2515391b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 23:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752818939; x=1753423739;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm1TqmyaJ73aEv/+A0NMqHKknbGzbroM81UPzBcA/zk=;
        b=IpUXtMZ7/ko6Vhob6m0iTZ75vaQzELkajaqywf/nxeJJGftK6dwIPNUhzHVpvF0pEJ
         loP9B7olwUxQBz3Kp24Iz3O/0+ZD0FYYewGaS5nsoJ2nGo35MwAx/3q/adkUc16VGJL2
         EEJ3szrsPZhnTQ8Nb3x29ldpsa5fjrO9D1i8nNWKgPcuNRpKaOzgcr4TzHxq2j6609+F
         0XxvBkiUenrM9mtFMo9i8KDBYBpUgcaxcBgKVbsddNOacEC6145JXP7aoQvUUwam5W3h
         MOsxPE0RH7aciCk46PNLoByzMACOFDYqOBzFGpOTctguBQz4U9ck+MVSdwrSWTXuBMdI
         OQGQ==
X-Gm-Message-State: AOJu0YzP+TkJ+3xtJrgyZjnv6u+UEWpYmh2AZRs2BAzI+gRmTBM2QAgp
	7LFKN8M6aFFaTHSa9sn3E3QhgAW7ZJmv6RqWDLait3+isWgdM3P7NFfR6wPa508KgR+f6XsZhFf
	7ihmVyvC131tMQdYY/0fHSbEMZAUeLOgIcO1tjvGnZnUXeTFPpYGlF1pBRlbQwMSiH1QovQ==
X-Gm-Gg: ASbGncv+9rxVUUbbJ7fiX9MxYqUc0OVz/9g01alinqmSYhgIWbnUojSRVgqPKWTnReT
	FtgPfP2uqfpHCE25YBfJCqh7FVnixuH+xyAAVy2p6IyRJs3G0WYk/D9LY31pHwK6CFB4oH60kp6
	3z37X3idglIKjjIiDBhQJaCtBBysU/krULHyFjJaY+Ne6NOeQOLCQNN1W0CFZ8aam2/E/6jk1PG
	FuS5OP0wbhNH+ZDqoVUmeWSxU2wZZISUd3bX+IG1BxrY0B50NVvdJFWUTph+jcdA60Uzca/0ku8
	VvVesiyuVl21N+JYKKxFuKLsbUXfsqjU2q+9CTsg/ODHdJZHTPeAPKbDN4S6pQAjYqwzhIAatMj
	RdGzO3RE=
X-Received: by 2002:a05:6a00:21d4:b0:748:eedb:902a with SMTP id d2e1a72fcca58-75724875604mr10736968b3a.17.1752818938824;
        Thu, 17 Jul 2025 23:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpAa2lmp4jzT1+uFjVv9p1F0RymBCKCQqrEkSouLtBg+vv3hzORnwWPx6LuBbYyr1ZjYo+dw==
X-Received: by 2002:a05:6a00:21d4:b0:748:eedb:902a with SMTP id d2e1a72fcca58-75724875604mr10736931b3a.17.1752818938303;
        Thu, 17 Jul 2025 23:08:58 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e26d0sm531236b3a.8.2025.07.17.23.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:08:57 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 0/4] wifi: mac80211: macro improvements and MLO enhancements
Date: Fri, 18 Jul 2025 11:38:33 +0530
Message-Id: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0NiBTYWx0ZWRfXyNEAlddpHOay
 PyGpADSeNavZR8KeNweYICcTwLyyJBn4plZ+p7bcUIQZQXlyPfXOqLs+FQ+FKpqwWVJT1f5MZEb
 Ow/svcRDmRZDoJtO0gVS8+vEheerGWQhM/EBdbU+k3OP1MlOihK1T8tEk933Hqo+yrhAuzPQd4H
 Ms8BCHJcRp+a4NAvkeMi8q8MugZg/5xgT2QAcQSjBKIYVR1BNDFBazmE5g0E+8mT2daufzVkQ2m
 boCDV12U3irC9EtxaM3Nn+aNUqTeC0PotxKF1qU5ofrWIgv5eVR87e10rrL+q7Wneyuu3S8j7ix
 QSAJ+RhE3oZtA1nQHnTGDbybhAhDfQO6TQ2v2qDEqG4KCsKIwhvI7jYLn1jej+c/pAiytVAFU9G
 XVFsM9XEz4+37tBh6hWPqEtC4i+5x3E9dyD9VsP1VrNhTVFeu90DqlFGrO3hkh8vVqOkXJoI
X-Proofpoint-GUID: 8tYriFXaj3KjYV5oUUm_8X8OrSW2y8EK
X-Proofpoint-ORIG-GUID: 8tYriFXaj3KjYV5oUUm_8X8OrSW2y8EK
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=6879e4fc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=Wb1JkmetP80A:10 a=VIiajhFgAjV4fBB1mBcA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180046
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

This patch series introduces improvements in the macro definitions and
extending support for Multi-Link Operation (MLO) in beacon and connection
monitoring logic.

The first two patches address macro usage in link iteration:

* Patch 1 cleans up the for_each_link_data() macro to avoid variable
  scoping issues, improving compatibility with static analyzers and
  preventing potential redefinition errors.

* Patch 2 introduces a new macro, for_each_link_data_rcu(), which uses
  rcu_dereference() instead of sdata_dereference(), making it safe for use
  in atomic and RCU read-side contexts such as the RX path.

The remaining patches extend the beacon and connection monitoring logic to
support non-AP MLD STAs.

Currently, reset beacon monitor (ieee80211_sta_reset_beacon_monitor()) and
reset connection monitor timers (ieee80211_sta_reset_conn_monitor()) are
handled only for non-AP non-MLD STA and do not support non-AP MLD STA.

When the beacon loss/connection loss occurs in non-AP MLD STA with the
current implementation, it is treated as a single link and the timers are
reset based on the timeout of the deflink, without checking all the links.

Check the CSA flags for all the links in the MLO and decide whether to
schedule the work queue for beacon loss. If any of the links has CSA
active, then beacon loss work is not scheduled in
ieee80211_sta_reset_beacon_monitor().

In ieee80211_sta_reset_conn_monitor(), the CSA flags of all links are
checked. The connection monitoring logic proceeds only if none of the links
have CSA active. The timeout is determined based on the link that will
expire last among all links. If at least one link has not timed out,
the timer is updated accordingly. The connection loss work is scheduled
only when all links have timed out.

Also, call the functions ieee80211_sta_reset_beacon_monitor() and
ieee80211_sta_reset_conn_monitor() from ieee80211_csa_switch_work() only
when all the links are CSA active.

Since the beacon and connection monitoring logic now supports MLO, remove
the MLO-related WARN_ON() checks in these paths.

v3: Addressed Johannes's comment by adding a new macro for link iteration.

v2: Addressed Johannes's comments.
    * Changed the comments special style.
    * Blank link after guard(rcu).
    * Changed the helper function name and return type in the 2nd patch.

Aditya Kumar Singh (1):
  wifi: mac80211: fix macro scoping in for_each_link_data

Maharaja Kennadyrajan (3):
  wifi: mac80211: Add link iteration macro for link data with
    rcu_dereference
  wifi: mac80211: extend beacon monitoring for MLO
  wifi: mac80211: extend connection monitoring for MLO

 net/mac80211/ieee80211_i.h |  17 +++++-
 net/mac80211/mlme.c        | 117 ++++++++++++++++++++++++++++---------
 2 files changed, 104 insertions(+), 30 deletions(-)


base-commit: af2d6148d2a159e1a0862bce5a2c88c1618a2b27
-- 
2.17.1


