Return-Path: <linux-wireless+bounces-32549-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMRvBumrqWmtCAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32549-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:14:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8A2153EA
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0B01300609E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38407282F27;
	Thu,  5 Mar 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9r3+Yox";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NH5010kX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABED3CD8D9
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726874; cv=none; b=amJsqEdBW+TS2aamFGDYDWqXz3JUjFRdZFyWll/toD/ADX0ptf4861SSBdYezd6Xk2GjFs6l+vVoBMoplbhP3BdXJadLqPEyjq4wg/FXgsPZ6LoHnYhTPwLOztiHut9IUu9L5wTXKvTKtJCf1kLokGLoTnoaJYn6grTCnqW0fQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726874; c=relaxed/simple;
	bh=HJrpef4XVpX8MNQnXuGxKDbvF027AQMqksXjqJeCCiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0eaylWSYy3GwxMpKx+ariRa0IwD8keRBWm7rxWrQs5QxexP7UvGyCenLf13LP0laZDV+bB380Hk5u0a4JcqifUOFZP/JHai/WeR0jBUtnm6Ghda1Iv+KLXuqWKq6WcqK5uuDmAqTQj9jCVTcfQUEuPGUxqdoLRrKBstX2W0ITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A9r3+Yox; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NH5010kX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFpd8861664
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tkkmxLZRqBJSNwbCTxAYKDazhnhkaWcVJBw
	La1XkiMw=; b=A9r3+YoxVNhklIEqRd6N3K78SBtD8C0mk0txQKRzfH+UbTpmrFt
	2O7gU/9Ful6DO+wcVv/5mpieRvajw5In7TbBUhcH30mm/sh2dzT52SlJU0EuEhNU
	AMOKEb+3psD5ixQ0b1Y3BpQ7Cue2s3OWdPhdQUXmHdRvZyEZ4ZPA2DCfB24lhrg3
	gNSJQ6cTlEqxNLC+a6la3JW85trNazQEDpyA1htFgAHlKAHK5Z5SbuG5UCgmSvva
	Z8l9TMIHho3/htvOB/6YpCXqWubmcHCTTk8wZwV+itJr5DOXiFjCFrkK8/yHUC52
	K5OzTtJr1dPPypD8/HEThZMuc8x4D1IO4Zw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wby9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:07:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae42659a39so327083095ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726869; x=1773331669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkkmxLZRqBJSNwbCTxAYKDazhnhkaWcVJBwLa1XkiMw=;
        b=NH5010kXdeR3VevCE5digubEjn0sM4jueMcto8MIjuOtXJ+++ln5XJogfFT3yu6gfv
         0o4WZr07D+fmPOEG9fmu5ahyOaESNpaI83IduicHq4bIsYJ5GUdJWtSkfiyvy4EDzPfJ
         6kmUnJ4ZcXx7D6BLDJpiS1hMcUeVb1Od3UJRZVuvwJBQsadhyw8Fc2411k4P32n4TryV
         hXkHU7kA7dsJHbdDH/FbrxYIpIXGSALYjNFq3Q4QbYFMRhKRM9joO+BJIlaTIRHmJDpk
         d1NzwyS83O5M9GEVHV7h7sJlLKWgv1/xZ25UzxTpaIIrHOhUw32Dqw8zUBiBwMOu9ESD
         yetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726869; x=1773331669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkkmxLZRqBJSNwbCTxAYKDazhnhkaWcVJBwLa1XkiMw=;
        b=wlP6rsRk9GTbx9PyEWFx+LyLmAmGwx9A+zQNOqHD1M80AII9mmYAQvwaqaqv7qrTVV
         Mb0f3ouskv+vb+3nK7Dc6MxzbKFQfCQvv6ZYdRHVBFXr4glUqx8B8g3YVk6C1EtvLyEb
         1NRGlGwCL5aAPC6OZa/DAJcnORPcC3uL5Brvoc9zxG6v1N+hKV4NXHb4VBS4rvWV5peX
         9pux28yKPAFMjy262aWCaRZAB3V6hiQpEIDjTDC5+Lx/PqwYIizeYPm00aZ5VIurthg3
         pdARHR+xwcrlvovuxei/pOxIbX4eVqflfEAgtON1jB53AABHtk2DOpiQ/lNZs3d9CuZg
         6uKA==
X-Gm-Message-State: AOJu0YwyUjAbsanGDbBbp9hE/o74781syaNUa49lYLb3wCi1fPfQ4RF/
	UBNIpv36UCb44METSNUtkMlj1hplrqFgZ1Q5Qc4Za9yC5NL3gbKKODDyJ6lwyv4oMwYfE2Qxzv4
	xH0G1HmyOqCdPHfNfgjBQLLtKtYMYUOyiqdermkjRcGftGNEjeVg0GGE6CYq72uTaTNYU
X-Gm-Gg: ATEYQzwskQJeVf4pG5bXZ34LDc1LjSDVEGROHczle00GzdmkyFXX1CnhQsNW5iEtg84
	/mLpwxeo7JDUEMHgS7ZmbBrRoY0PBpnnLn6ydc1Y6ZgkShLYUodHInhE8ghLbOj2qjmel0xWO2r
	pSG6TCZ+JMyn3Sl1Sh8VAfR+b/WwiG0zevgfNc51FXwi/j50ywmTJTfDrJW4OhmqY/tDh4ZFchC
	TTzgFVZX2PInruNfY0HFX36QmGAndmT+XESZHPKz/TQq1juP2pJaowh6FD9g1ePMDrhbKnBVQzf
	XkniwLq7QHxcr9gjQYPmXc1UoI64x45c1/Mv55ecQo7pUCCA3wLskLNccMyJWzQ+qtJ3krjWhkU
	FzrXGhq9LrhAHvcELdzJzGOMc39cOY7qA4xhq2TszN6cwefgT4ZWfaY8=
X-Received: by 2002:a17:903:1a68:b0:2ad:d5ea:4c89 with SMTP id d9443c01a7336-2ae6aa33a2bmr61185935ad.22.1772726868741;
        Thu, 05 Mar 2026 08:07:48 -0800 (PST)
X-Received: by 2002:a17:903:1a68:b0:2ad:d5ea:4c89 with SMTP id d9443c01a7336-2ae6aa33a2bmr61185655ad.22.1772726868201;
        Thu, 05 Mar 2026 08:07:48 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:07:47 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 00/15] wifi: Ranging support enhancements
Date: Thu,  5 Mar 2026 21:36:57 +0530
Message-Id: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JfVErw4vKUJCIOsd5Wnm708KJeCPf8Vt
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a9aa55 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=nYLnki7u2ztXSxxa32wA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX5PNhS5U9sn5H
 IecwndLL7/dlf9xBZ2Y2LmDRpYjAGBjsIfTe8UvUOEoTwUoZxBBlGYY0lB/h5N5y71pJtrZsbzG
 hSZ76agnLOx+QzV1DvRzhJEiQA5ifUOWGoKX5I6QUu9NtXyT/Ju6QpazZLOUu+OdHFNVScr3EQk
 T9oABP8LfjzOkf1eOTWhCeYp15fizzWTJars2MpE4fbrZGkLKoVIT7KhO+57enkGGAfC4IcUThK
 sWZuyCoX9O4TbegCXx1O8VJVCJLZV0mcf6hnswi76uaLij3Ocown7YKqrAQexlPIQ7WLTa0yG3z
 ouT1LOqw8Ah6NbfhAEqS9x8kmrrlVn2L/AKj1ccgxR2gDKVMD61uqpiu7hxVHt4ohNe+lhFu8bU
 R/K09ODRFZCK8c+RZuxh9F7TbSxZR/lCrqMW6+C1JMJH0OvjdMXZ6uWmtCL/ngVrowLhU0S/twv
 NHpybvHY3VL+N9hF5zQ==
X-Proofpoint-ORIG-GUID: JfVErw4vKUJCIOsd5Wnm708KJeCPf8Vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 17D8A2153EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32549-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patch series introduces Fine Timing Measurement (FTM)
enhancements and Proximity Detection (PD) capabilities. The
implementation follows the Wi-Fi Alliance "PR Implementation
Consideration Draft 1.9 Rev 1" specification and extends the
existing peer measurement framework with advanced ranging
features.

---
Changes in v3:
- Addressed comments.
- Dropped patch "wifi: cfg80211: add MAC randomization support for PD requests"
  as it it no longer needed with the introduction of PD iface type.
- Restored altered checks in "wifi: cfg80211: add continuous ranging and PD
  request support" and added additional conditions to ensure backward
  compatibility.
- Added a new extended feature flag to support Secure LTF keyseed installation.

Changes in v2:
- Addressed comments.
- Removed ABORT command implementation as it is not needed.
- Added a patch for enhancement of Remain on channel command.
- Intoduced a new interface type PD.
- Added a patch for suppressing ranging results when requested.
---
Kavita Kavita (1):
  wifi: mac80211_hwsim: Add support for extended FTM ranging

Peddolla Harshavardhan Reddy (14):
  wifi: cfg80211: Allow RSTA role without LMR request
  wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down
  wifi: cfg80211: Add MAC address filter to remain_on_channel
  wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR
    operations
  wifi: cfg80211: add start/stop proximity detection commands
  wifi: cfg80211: add proximity detection capabilities to PMSR
  wifi: cfg80211: add continuous ranging and PD request support
  wifi: cfg80211: extend PMSR FTM response for proximity ranging
  wifi: cfg80211: add role-based PD peer limits
  wifi: cfg80211: add ingress/egress distance thresholds for FTM
  wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
  wifi: cfg80211: add FTM range report negotiation support
  wifi: cfg80211: add result reporting control for PD requests
  wifi: cfg80211: add LTF keyseed support for secure ranging

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |   4 +-
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   3 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c | 166 +++++++++++++++
 include/linux/ieee80211.h                     |   1 +
 include/net/cfg80211.h                        | 176 +++++++++++++++-
 include/uapi/linux/nl80211.h                  | 198 +++++++++++++++++-
 net/mac80211/cfg.c                            |   2 +
 net/mac80211/chan.c                           |   2 +
 net/mac80211/ieee80211_i.h                    |   3 +-
 net/mac80211/iface.c                          |   6 +-
 net/mac80211/offchannel.c                     |   4 +-
 net/mac80211/rx.c                             |   1 +
 net/mac80211/util.c                           |   1 +
 net/wireless/chan.c                           |   2 +
 net/wireless/core.c                           |  31 +++
 net/wireless/core.h                           |   2 +
 net/wireless/mlme.c                           |   1 +
 net/wireless/nl80211.c                        | 173 ++++++++++++++-
 net/wireless/pmsr.c                           | 180 ++++++++++++++--
 net/wireless/rdev-ops.h                       |  26 ++-
 net/wireless/reg.c                            |   3 +
 net/wireless/trace.h                          |  22 +-
 net/wireless/util.c                           |   4 +-
 27 files changed, 971 insertions(+), 52 deletions(-)


base-commit: 44d93cf1abb6a85d65c3b4b027c82d44263de6a5
-- 
2.34.1


