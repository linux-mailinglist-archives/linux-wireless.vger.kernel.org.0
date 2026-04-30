Return-Path: <linux-wireless+bounces-35679-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JKXNdXq8mltvgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35679-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:38:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96449DA29
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D545D300460A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56C91C28E;
	Thu, 30 Apr 2026 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ggKf4wAR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j8dyKNBT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063034405B
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527507; cv=none; b=AiKQPmv971EQtE+pD1g6ye8y7QthpqUpHzgLQTuJIL9ov2E45beXXIjtdz3HXBsAKuIm6sdBwQvIgbIscTTnld7Q75MyZs4XQfaDTbuKpc4d12ie6bUGmzC73Y6YeA411zWQ4Tx/SRCWLRPAcFR1P4GHKhMp8MqAy9RHnhmgI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527507; c=relaxed/simple;
	bh=e+5SsONx0D6f5J3YVIYGlRKdgWCXyU+qHIzr36kWK8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ETYzWeh/7ya6LMJ6UFHdkv0b+CW5QVbO+8PSkzXGArm5hxlIWzCu5DHAartAj1voxvz/DOyU4hfsyzKfg0uFUqmUeRRHFAUR55DH5vb31/LeTz7NCW7KImj5QJzXRylWyTj+vUP9nJb4AWSMsTDx/O0E9oM3HG+GyRxwEofxTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ggKf4wAR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j8dyKNBT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNuP8c3636716
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dhh9iWZ7IPZTLFJfGsFhUajLL4gqeHdwJ1x
	FQGC1KHg=; b=ggKf4wARY18ee415mhOVYLrutzo1/2VUqjqDNuPAFO2OTad1rIZ
	ySiS6yo/Jqo6pnWBf2kvuLpeKL9VlB5GiDPZqL5xDLtyWe0Ri2AcuXmFxSp1YVgP
	JvQU59hY9N0HR1g4AUpdBdIwmgjuAKxM+85oCI9WkpREQNhTORxUHo8ROZS47rCV
	lOqAdIqGqMyR2pazQuUOsIqtU9qK0YOXVW2++mCot+ogUvpfMR7QPf8CFo+hO1Iw
	qCsG90rbieh0gAtzSVtfH9GdzxSe0EjjOIAyXl+tUBPWGtKzegyNlkBK90BRjUVX
	Z4Mj6jWVHF3ZCxUuWez7lIwvIqIAVISlrmg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q0yxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2497cc190so9782025ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 22:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777527504; x=1778132304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhh9iWZ7IPZTLFJfGsFhUajLL4gqeHdwJ1xFQGC1KHg=;
        b=j8dyKNBTe2RqVD8u5vNuJu/KAnN95Zsn+l8ZuvSwpPWLUZnqDqNWoxW0z4z7lPYxGt
         yneHjt5u066AwF16VjOOD0ylKhDuB+5+Bw2rxxVAkwRsJj0GK42ZGKpi/FyhkwjEkAMn
         vSn7lBYC4M3FHX+giafAgIUfZitXtO5qE54pqD+1/oxVcdUbRwtOPSR5I7jH5SDn60uR
         +t5kt1251gPNO6/jxqr2BXD7SE607uTOsB539b63FBKy/fyfcWBpAe3USUcltIsCPrtI
         BMA56vIeaYXHwpD2bEG32im2TW9dSOC86FkeHvQEO8XE3HXzg5Ob20lxNUVBuIq1Def7
         maMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527504; x=1778132304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhh9iWZ7IPZTLFJfGsFhUajLL4gqeHdwJ1xFQGC1KHg=;
        b=KF5s7G7l/nP5qdH9d03iIr3lXHMXdPVU/tLhUGDzMqCQYFiCcPn6MVwGbocwkjjUOD
         S0Ijt4uvUmISPgVsLawH53kGIpBv9lmKUtFIQKpmCgMxp6UxVV3zGy73okw74dRVHnzS
         dcpjZ7+3MKGWmy18UCUQb8Z0Hb1MwTg4XgiFX55DeRbBYwD7UOOI2I8xWf4nRqbtNgNk
         eTshj5QGykWK+Wg1uUOhgZABcRihtrYl4rprIINt2FrmyAGsiOtnjh4yzd4/Jz9c7XBs
         ZtzkgInS6IPn1qxHwxeRh74RC/7K0IP1gMHPWuumhBb/zhdtqj/id25JyBeJuS9JJLlR
         BAfQ==
X-Gm-Message-State: AOJu0YwhWlfAG1VqcbZqHea3lxrjbifjvqbT0Bf4HukVymx2L1G5+iUS
	f4ZpBzZcXwBmKqt0nEHLYEYogbKV4ZgSJ/JiT3WsNp6CZL+PsIRHwclZJH2YL+kNYLR/det/1OF
	Xe8b/EUvC4mfJM2PeVe699AgfbMLDjS6VvbcAdyh6GpNb3H8JOducNfLmTkUppW3VrkY3dQ==
X-Gm-Gg: AeBDieuTOISNpgbiwVwl2lU7z8ugD6ybDCtbeU5oOzW6KuI+PpSDKoPnbpFhxPiSu68
	nXWL2Ks3hQVIKt1rdhcJfRAVWSW9GpWdWM7DXHhtb0nyJYuyf7qg5GLBGZYsex0AAF8KCUNazjn
	a9YWJ7xuEXnMj5pB+9NMfPhUC4K4PKb8UDa2QzLerD5zaM889lDsB+3DIU0EMbR4l3bl4AL9s62
	4A/yJqNbfrZwPs7GC/QBd11wSqAg1BGshmqsENdWDyT3V0oCRwBuStNL/aCcdX2PMy8xi7raoeh
	LeCPB3XxvNrxJMqq1uMjxb6RQvjqPqCkrE1clJHc4lOeA6Q/rpPJz/r6LwR2rmKv5yxvs9jufNw
	LNgdPEPqlYgiFxL1x0FAdLOOXxw2G8+zteQ8IZc2XOJYu6Bczwv6yP7FmGkxlOVDDnjayDr4iyA
	pXMfTLteERVkFlT6BTIZtGwnCqcXi7FaZuq8CjApHXYGn+DTEUQfZx+g==
X-Received: by 2002:a17:902:c102:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b9a4029d73mr8772505ad.0.1777527503926;
        Wed, 29 Apr 2026 22:38:23 -0700 (PDT)
X-Received: by 2002:a17:902:c102:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b9a4029d73mr8772355ad.0.1777527503428;
        Wed, 29 Apr 2026 22:38:23 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm39561425ad.25.2026.04.29.22.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:38:23 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211: optimize station info handling
Date: Thu, 30 Apr 2026 11:08:08 +0530
Message-Id: <20260430053810.2088793-1-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q6XKlF-QX4dClE5cUlFK9Inexki-cZnS
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f2ead1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=5koZO7XqIq10IgpX1VoA:9
 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1MyBTYWx0ZWRfX8Jr3xYD9ud3F
 MMOvmBK+ZCimCwSwE7vz/0BfD3JFl1OHLtikhVH4gEgMvoUy458NN+Ch3AuvJB230BBCdxY4DhR
 YAlu+riEV+9QAY0FVdpH/+8i/s8wB+7JWumam1plTOZ8cCfnKLmDunqHvqo0sRcy2kkIr8xMc74
 w8jfLaKi7DxzrnHXeJ7Z4UO13vTXU/y1OAa/wb2mKJaHsRgvTeYLbaGopxT0JtqHppoIIzF/AMH
 TZkjrutrkdN+CabiZZTdqxomIn4k01ZsHY0XRZv6EES0ZOEQpylEBw3FsKvO5LDzTgsxiJCE3js
 94MKdyOQX2MaeYIeVCqhPpYwR3uDBpXDRTNB7e72aSxOq+Eol1lFd7dnd8YJqdn06+1vaLmAhWR
 PNzvT1M/pWPre1jkxgpMUpYzacMLir7zooHHSL+DmXesnQm5IBF51oTnz1BotVRMfwz7swa0m4u
 vOQ30kMguQlBrYZco9Q==
X-Proofpoint-ORIG-GUID: q6XKlF-QX4dClE5cUlFK9Inexki-cZnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300053
X-Rspamd-Queue-Id: 7C96449DA29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35679-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

This series improve memory and logic efficiency in cfg80211 and
mac80211 during NL80211_CMD_GET_STATION. Allocate link_sinfo and
link tidstats objects only for valid links to reduce memory usage.
Avoid setting non-MLO applicable fields for MLO stations to
eliminate redundant operations and simplify the code path.

V2:
 - change int return to link_station_info return in
   cfg80211_alloc_link_sinfo_stats()

Sarika Sharma (2):
  wifi: cfg80211/mac80211: change memory allocation for link_sinfo
    structure
  wifi: cfg80211/mac80211: set only non-MLO-applicable fields for
    non-MLO stations

 include/net/cfg80211.h  | 29 ++++++++++++++++---
 net/mac80211/ethtool.c  |  4 +++
 net/mac80211/sta_info.c | 63 ++++++++++++++++++++++++-----------------
 net/wireless/nl80211.c  | 35 ++++-------------------
 net/wireless/util.c     | 21 ++++++++++++++
 5 files changed, 93 insertions(+), 59 deletions(-)


base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
-- 
2.34.1


