Return-Path: <linux-wireless+bounces-33596-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCQsKqCLvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33596-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262F2DF145
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A42633056177
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317730EF89;
	Fri, 20 Mar 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9wOoR5G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GVNnQQXc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E63112D2
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029633; cv=none; b=c+n6y/vV4l8zya7uiUQUTU/YbwFo3iI2TyyGA4ZZXng9pWS2AdjNbSNwiKg+UZlkYOHrnQG78+77M0MUqxv1LXn73DjplEQtthTfGhu/jJVPFoozMgOgTdwyvyaty9nwpRTlEV0QN0bMjktY2NsLwrK1DELHS1jxihHJ9PctI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029633; c=relaxed/simple;
	bh=N6a5IhD4WmDNLDCn7xzaTiHcKGK7AYaBCgpK27R/7VM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEbjYAwhlke6bBk0B+CY9giC6O0pQiyFoeiAqOiFA5txy07l+hPFj8lcWWZ0k6UHI8/e8+YD5e+Pv9w/eywajGfsTWgVLUmiJiaEJ9JnUxDWvV1Mr0aOJPoabmUVPD598nVdSYStvIMwyGHcgatZAYqEV2PRPRa7LU4DXDgelYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9wOoR5G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GVNnQQXc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEcj943557763
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wp/i8MNH632OLRQKJYuEmZ+Dnhpf5F16T94
	YMcKgjw0=; b=E9wOoR5GdAXv64htaKQ/VIYrr3NvbxDRZEwb6mvSCPYOs1etBuG
	SQTNyTAADzVrKXOfBCN3Id/JbLKWsKTt7MLR15JKeeemPMN2KZzBadJbjOWQhdDN
	ZsB60WgfpPOTQSH59en/NfnQRY1keY3TbXLCSbaeuXUtmBVOnl7UbXgzqPsxdl/d
	xUwMUCXNcj7NN1yD1kytrOf0wfPptK5dSSUYRZmmf1o2cZUfWwh85BVciPNJndG4
	nSoudcXKiG0jA7eCQDDDApE8N5Pi+d/ngydYCQ9EIbm81VZ+8qpppINNT0ISRAU8
	kZR+MjZS5SRXNjTBVEYVDQ3/VaUaA8JqtJA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0r1gtys8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aeb90532f6so11448295ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029630; x=1774634430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wp/i8MNH632OLRQKJYuEmZ+Dnhpf5F16T94YMcKgjw0=;
        b=GVNnQQXc8bYAffvFC8mTeE4oDYyvCAOnLfsjPq91pJNel11s+VifH9JqZNP+nvJbxv
         AhE8o0l3lipNU9LmxMMAaUs/ijM+f/vjtHX82WRk80zoDJ4oIuiBBU27pcZKez72djDn
         lc03eztuIxHS4ytFXV+xtP9ec/XGZRBhy2UIvKgTk4bP8V052FwNx3zZeOl5br7x57Iz
         vPrNyXVTxLoSlSYVbER40PAt93NLYg2ayxruwJHhmbR8ghjuQ/xj9trWcDOQA8l9tVj9
         PITDrGXuIzh3nLGsrEDifRjeVua3xXWVDRKdoqREAwTo4VJ9NUwqaGKkfhRE2O7gpJka
         Kmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029630; x=1774634430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp/i8MNH632OLRQKJYuEmZ+Dnhpf5F16T94YMcKgjw0=;
        b=dlPxdNDlDRLBpSsc5Que6GfMKCjSfHBlN0QP8kaZZ7wXjFPcxiRfFf2GXlqJo30qGl
         1VZ4sXrBoLrWVFtHebidDuQPzZhQXYlAmchvKtCcIjS8hrz6yMmNXg08GGi2aWR2cfok
         XQUlmAmtEh9sz6fPGlYrsUkU3zWA0TWgCGAFarWHw7AYiS3m+wHdkuBYvmOx9VEhpLIC
         m1gAdOOMcECZLi9TicFDacQ3ValiMhuQRfsjbPVvdJUQsubdHoGZLDVJAXSd/b689OWi
         zGIYaxy1Y+0acje0ooshLLWlIDdx4YySADePoEwMMSFjfkrH3+ninzUyba7zwFZTZwv7
         Ug1Q==
X-Gm-Message-State: AOJu0YwjsikiVKnURYfyr0WkNG1+UqhTKR8lXBZprsIGIECvDLNV13Hh
	CplAqQUxHjoJL9yFFj7t/kYRodA9QPUJ5MTGCQlzSMzdH6MgmyyA4w959/ze11s7buP+frbzpbv
	pVpsgHlJm6yYrytldLjchmxkBFVEFITscFbJCXN+5ha7bebRRfpYwvng8XklLHJHFv0aToN681P
	gK
X-Gm-Gg: ATEYQzxOvFS+icjmfmFekZUJvSGtSb4Gz2irVDjXlYU9enZA5euT2xlqDw+cMmgw2Zq
	dxsReSH18hvmFkA2x0HOQL96D/XCpEwM7HgSsV/WI+nTJ8SRU/H60XJTpZzan+vP2SU2X3GbdSh
	SETWQrbp/GDbCRkEIOk1sMpw8+fVeGq8JXZPEafwb/Ii93dWb9ZDJbNSM5PuCKn4/hRY9HqbUDK
	VUlb5uBxWEjOYx5GY8LMDz4RTr16/c82+ajXDAaAdENdJQhevcAd62tjDU8QHEWxRpnOhVPkD4A
	Qv2F1IAFZVYIYWd/+FSxbZFComeXl9CDgYvDFe5GHtzbrfDwO/d7oF7XesCmtcxB3180aZC25c9
	vKEfH9PGx0hks+4dKplwteh5HNJ5HSumgfStq7Bbe/JLLt9fhj1LGNrE=
X-Received: by 2002:a17:903:94f:b0:2ae:c862:3a2 with SMTP id d9443c01a7336-2b082733d15mr32673585ad.17.1774029630121;
        Fri, 20 Mar 2026 11:00:30 -0700 (PDT)
X-Received: by 2002:a17:903:94f:b0:2ae:c862:3a2 with SMTP id d9443c01a7336-2b082733d15mr32673375ad.17.1774029629571;
        Fri, 20 Mar 2026 11:00:29 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:29 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 00/14] wifi: Ranging support enhancements
Date: Fri, 20 Mar 2026 23:29:24 +0530
Message-Id: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NCBTYWx0ZWRfXwj1vGzXuXFFa
 E1wxG9QvCGF9QOOgOiUT6NiYn6vJkMVHhFisHsnsOvp5Gcqta4XwGy8Zl1UNMRKGAY3TFF4ArbP
 qJlP3Ecpd3Vo9/9lOiY8gOoBj/NqW0kC7yI1Ro6esu3FtlC6ZTxvy0yYQVg3AYgRvUSvHAQwPpu
 dcEr1aeUixYOL/+SV2DUJR7hbY0Y7fRkEcAYqU5z4OfwodQH95HjdAiyN2XFQezQYxqHt8NkQXP
 J+JEQyrbBqOFh+MkDArsTZOV1vW7uJeID5sXJ/8aTbndq064uV6JphEcO2j3fgwBqce0MJu7FHH
 Y8jKgHlEO1b+ndMSasqXLIFf1rbkti0ilCt9bPWWhUtXSHnFzcR8Z+3/orhbAidx3g2DM+JGyCm
 BdaIuRAvLtPcIApt4Qx9XcTNPdkaRypqAqpZipZf1igYNc2LN2mlyaBF8Qbsf2pz+yWq+8W0Yb0
 rPQc2u3zvI1DvRB6Kag==
X-Proofpoint-GUID: gkavM2IT0Yf09FxL5EdSM0lSMkK5aPw1
X-Proofpoint-ORIG-GUID: gkavM2IT0Yf09FxL5EdSM0lSMkK5aPw1
X-Authority-Analysis: v=2.4 cv=Y/D1cxeN c=1 sm=1 tr=0 ts=69bd8b3f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=gexI4FMgWFwkBSOqGDAA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200144
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33596-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2262F2DF145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series introduces Fine Timing Measurement (FTM)
enhancements and Proximity Detection (PD) capabilities. The
implementation follows the Wi-Fi Alliance "PR Implementation
Consideration Draft 1.9 Rev 1" specification and extends the
existing peer measurement framework with advanced ranging
features.
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

Peddolla Harshavardhan Reddy (13):
  wifi: cfg80211: restrict LMR feedback check to TB and non-TB ranging
  wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down
  wifi: cfg80211: Add MAC address filter to remain_on_channel
  wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR
    operations
  wifi: cfg80211: add start/stop proximity detection commands
  wifi: cfg80211: add proximity detection capabilities to PMSR
  wifi: cfg80211: add NTB continuous ranging and FTM PD request support
  wifi: cfg80211: extend PMSR FTM response for proximity ranging
  wifi: cfg80211: add role-based PD peer limits
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
 drivers/net/wireless/virtual/mac80211_hwsim.c | 200 +++++++++++++++
 include/linux/ieee80211.h                     |   1 +
 include/net/cfg80211.h                        | 198 ++++++++++++++-
 include/uapi/linux/nl80211.h                  | 229 +++++++++++++++++-
 net/mac80211/cfg.c                            |   2 +
 net/mac80211/chan.c                           |   2 +
 net/mac80211/ieee80211_i.h                    |   3 +-
 net/mac80211/iface.c                          |   7 +-
 net/mac80211/offchannel.c                     |   4 +-
 net/mac80211/rx.c                             |   6 +
 net/mac80211/util.c                           |   1 +
 net/wireless/chan.c                           |   2 +
 net/wireless/core.c                           |  31 +++
 net/wireless/core.h                           |   2 +
 net/wireless/mlme.c                           |   1 +
 net/wireless/nl80211.c                        | 209 +++++++++++++++-
 net/wireless/pmsr.c                           | 181 ++++++++++++--
 net/wireless/rdev-ops.h                       |  26 +-
 net/wireless/reg.c                            |   3 +
 net/wireless/trace.h                          |  22 +-
 net/wireless/util.c                           |  19 +-
 27 files changed, 1117 insertions(+), 51 deletions(-)


base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
-- 
2.34.1


