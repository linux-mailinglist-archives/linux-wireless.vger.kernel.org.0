Return-Path: <linux-wireless+bounces-35023-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH1JKWDt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35023-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBB428ACD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6AC53000E1E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3243783C4;
	Mon, 20 Apr 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3+RIwWc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="do0bGqIq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8BA382372
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676176; cv=none; b=ZD30FvaZoUmrdT7M9QJCKi647tcHSk6dmdYq9HKCNIK2hpIZxgl2c9VnK1j0bLuT/jXVEEU94FNKA3KeGnWHuyIk5ouvp/06e9lge0BYyqy8ZkciOz3+EdQ4WJ4i2qA0XHedQZ+U+f2gRgRulpsuo0gHHc3LqlKDR6JDyYnZryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676176; c=relaxed/simple;
	bh=ByxOIWtuVQh4xR98nas6C2B1xoP17UiDXd0ogp2yKVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPYSX3Why1AMG75KB1RaoTs1gPavlpfy7DqCNBAJPGuVygrSFmchhrniRswqMVQ9EATnV8jxxnYC0fuoMFUlWRZ+tCt1URKwk/u41TZ1zkN56gUaox0YSIZ9VhjYU9ywzUE/ZopKYvx8awbAmy/pSqr8zGAkPVYQi4Q0E/IH3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3+RIwWc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=do0bGqIq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K70Jj73212158
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xcvVYlzbXkZDJSjFbFz1o5tsiGQprWVDJvu
	Ce4uG/To=; b=e3+RIwWcMTYVlx6jgtkkUvgubuDRqUe+GY54VKQ5/N0hWYpLWqv
	0HOEe6Ezll1Tsen1QphSY1VKpEhP1uCPQ6dR3HBpZ5ErOiPLHYYIKeWoubb0mKn9
	LbQGD2DzjGWKVAYcXsbxyN44OyqSQP6w2ktWX+A2w3PGeylBO+rjfMwm4lRFxNt+
	AGEE1C6H7v9wFGniHXstuJ4ZbhKOeJZCQPgBA2oS8Ms9HC/9xgxAov6vi1s076W7
	eQPXu/aCqXZFXdUmEKdqrXs4Ijoj+ekRi9HD7tl50s6lwzWDvqw8kWfvFVuYTqGu
	Fp39v4zfER8nrQK6oKb4ryxHoyp3wEnnqVQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfcfgqtj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso2611980a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676173; x=1777280973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcvVYlzbXkZDJSjFbFz1o5tsiGQprWVDJvuCe4uG/To=;
        b=do0bGqIq6aR9FmgRaEHLFIVWd+QleHOYDzk6cWklrQgr9X6Iolx9Omrm66KKOO/BjD
         SLx8cE9+oDKXYSahwhizSYkRycaCf0RDjRLWqfrmqyxaAd5ZZsLbEF6yMmUw2OT886SX
         3/4WWM1gyucLx6A24XY5e0+hDe9ZsWnj/3/+bCnJOetDOHMX/uUuN0H3yE73sUHsZeX7
         rtrJyV9xIy04xIkQF4cNv8C0carEvz6gcbmlO2pkK9+b0hZpWK1OwwZanJpg2pe5lvgN
         bOg9PkXDid2yy6m3+6M3b8RCJAv7LrWO2sZC6caeS6z0L4fqrJ4zkeAQQyVgeGZNw4LV
         dg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676173; x=1777280973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcvVYlzbXkZDJSjFbFz1o5tsiGQprWVDJvuCe4uG/To=;
        b=bxDl7wuas00eunKfznTLyfViJWUA1KWr3Pb94JhpGpywhZnnK4EdggolbbSPD/TsGA
         Xy/Z6EL4r0BZRAVowaamAwUP7scBDqGUC3OUYRUOTIbnpf5I0NrrA/r3xENtI8xBM9JC
         19N0mwmq6n1m7GsRZHfNu+HDFJNOs7huyMGAyVhRk71sAi+M0KD63XDfhjtMZC2jAdGe
         3wz9e7uN+S1JL5lTgnfBKiYTvUQhKQ8+H8BW22bKqRq6yFBnw9d92v5B5EEMHLHia2RR
         mIUsvvDiz07CpFjvoS2f5qZ2LzjGHv+1gpiHR/qAvjVYG1uHx9FASLOws4bO7O1IofkI
         2SwA==
X-Gm-Message-State: AOJu0Yx6RUj5KszaycFsRoBYV2lmYCiW7CSPvrfVP8f41b9McktHMGed
	FVop77RUktgMmlo5HFqH7DyqOqEJ598j8MQHA3x0CsQYyHkewH1nQP/dXTDJKaZMF4MBIsf0LEm
	CLXQtHRNw46cZnXe+IJOuk/S2D6S8H7xVrdFlNZE/wl82+CoqaJ76M6FqtwNvOCd0UQid
X-Gm-Gg: AeBDietBa8Xt5s1E7Da4qvopTedkHx1srFkOYgcl4OQm+ELdUtLzN9K9vqIl0Lm9mjG
	6OIYkHUPvRFyR2SBf/BRvN1osgU7ZLRLx+CxQ17M8KvR63MXOivDwGKr7U4T3N1ZqpRAl6hEQPw
	1MxiGKu0iTh2ga9lYNsaVN45kUa4vlH5eawm6FtPL2va69oqvritEE0WKMUZbp9QXHcriOfeHVw
	OrccwncUmBcSOoIR6YJxpucFo4gZtyG18xQTcI7c0/csQcnLhOaNPPfRtkhBZy/S9hPqY+TQRAA
	eq0hhcfwVzXyheI+VALwVMlNu2LPYpbpZ+8XQcOT+cSE7OitDqPSElj2OpmivKM3XTFfFdbReQe
	A4GTbLpRra4DDRLJmptztGL8urNhrDPbBlWUD11J5UAgmqwgBu/vYh5wyT5fP8d7kOA==
X-Received: by 2002:a17:90b:5106:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-361403d5c41mr11547497a91.4.1776676172890;
        Mon, 20 Apr 2026 02:09:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5106:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-361403d5c41mr11547459a91.4.1776676172416;
        Mon, 20 Apr 2026 02:09:32 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:32 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 00/13] wifi: Ranging support enhancements
Date: Mon, 20 Apr 2026 14:38:43 +0530
Message-Id: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfX7LlCMyrnKNDQ
 O81ox2p8sWWkVVlafBpOGthw8idSLWnyoIUY1tMkwmLiSDg0hjcgcixDClwRFr2JtuD/ClG6YNb
 SpiHslqXqJYGRpUfp+g9ig7550Wqbz/wsSxy5AX++F2CucrVtGrnryL1AS1P1MbQHNTg7Dkn7IL
 1mgpdLwoNU46agZPS25nFa0X8W/HoSBX9pL/0BlrO0WSYxlIbpsp+eypaSsFjoJ0hfT0qAAe4um
 AxbvVDGxS4v5JXOB2j4RqFlf7jWtGF46ApRMbEGIuRSEJRORxCAGiuFDXkV5vTBxkwLuSxEOKna
 bZKB9SiO9gwAjjyKBSgUp6t8/a8h3c3e1rwrLJ+E3pfV4eyB/VLG3j0kwFdWKJqp5PZzAnNrE3N
 Y2MB7yaoXVYmR776lA4FWedLY/Bmn3SX6gVHwMhZbpPKNfTjwXJdnfGZ+LFEX8OryTuPJdiEy7T
 sA3m1n0QWWyAfx4e9Qg==
X-Proofpoint-ORIG-GUID: MfyeHge2aXJUrb0Kx0_5NwG-bAbW2BPT
X-Proofpoint-GUID: MfyeHge2aXJUrb0Kx0_5NwG-bAbW2BPT
X-Authority-Analysis: v=2.4 cv=L+ItheT8 c=1 sm=1 tr=0 ts=69e5ed4d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=gexI4FMgWFwkBSOqGDAA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35023-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 59FBB428ACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series introduces Fine Timing Measurement (FTM)
enhancements and Proximity Detection (PD) capabilities. The
implementation follows the Wi-Fi Alliance "PR Implementation
Consideration Draft 1.9 Rev 1" specification and extends the
existing peer measurement framework with advanced ranging
features.

---
Changes in v5:
- Addressed comments.
---
Changes in v4:
- Addressed comments.
- Dropped patch "[PATCH wireless-next v3 12/15] wifi: cfg80211: add
  FTM range report negotiation support" as it is no longer needed since
  FTM range report is mandatory for PD EDCA based ranging.
- Added a new attribute for number of measurements to be performed in
  total for NTB ranging.
---
Changes in v3:
- Addressed comments.
- Dropped patch "wifi: cfg80211: add MAC randomization support for PD
  requests" as it is no longer needed with the introduction of PD iface
  type.
- Restored altered checks in "wifi: cfg80211: add continuous ranging
  and PD request support" and added additional conditions to ensure
  backward compatibility.
- Added a new extended feature flag to support Secure LTF keyseed
  installation.
---
Changes in v2:
- Addressed comments.
- Removed ABORT command implementation as it is not needed.
- Added a patch for enhancement of Remain on channel command.
- Intoduced a new interface type PD.
- Added a patch for suppressing ranging results when requested.
---

Kavita Kavita (1):
  wifi: mac80211_hwsim: Add support for extended FTM ranging

Peddolla Harshavardhan Reddy (12):
  wifi: cfg80211: restrict LMR feedback check to TB and non-TB ranging
  wifi: cfg80211: Add MAC address filter to remain_on_channel
  wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR
    operations
  wifi: cfg80211: add start/stop proximity detection commands
  wifi: cfg80211: add proximity detection capabilities to PMSR
  wifi: cfg80211: add NTB continuous ranging and FTM request type
    support
  wifi: cfg80211: extend PMSR FTM response for proximity ranging
  wifi: cfg80211: add role-based peer limits to FTM capabilities
  wifi: cfg80211: add ingress/egress distance thresholds for FTM
  wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
  wifi: cfg80211: allow suppressing FTM result reporting for PD requests
  wifi: cfg80211: add LTF keyseed support for secure ranging

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |   4 +-
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   3 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c | 217 +++++++++++++++
 include/linux/ieee80211.h                     |   1 +
 include/net/cfg80211.h                        | 194 ++++++++++++-
 include/uapi/linux/nl80211.h                  | 263 +++++++++++++++++-
 net/mac80211/cfg.c                            |   2 +
 net/mac80211/chan.c                           |   2 +
 net/mac80211/ieee80211_i.h                    |   3 +-
 net/mac80211/iface.c                          |   6 +-
 net/mac80211/offchannel.c                     |   4 +-
 net/mac80211/rx.c                             |   6 +
 net/mac80211/util.c                           |   1 +
 net/wireless/chan.c                           |   2 +
 net/wireless/core.c                           |  34 +++
 net/wireless/core.h                           |   2 +
 net/wireless/mlme.c                           |   1 +
 net/wireless/nl80211.c                        | 224 ++++++++++++++-
 net/wireless/pmsr.c                           | 188 ++++++++++++-
 net/wireless/rdev-ops.h                       |  26 +-
 net/wireless/reg.c                            |   3 +
 net/wireless/trace.h                          |  22 +-
 net/wireless/util.c                           |  19 +-
 27 files changed, 1196 insertions(+), 43 deletions(-)


base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
-- 
2.34.1


