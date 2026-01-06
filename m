Return-Path: <linux-wireless+bounces-30401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B92CF90B1
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDD8E3009691
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BFD314A8E;
	Tue,  6 Jan 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GF4TQNrX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="erV9nTPF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0633F39B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713117; cv=none; b=W63FJGm6Uqmfi5HBJJn8ZzcKYE944qh32QEhhTUKikkenBPQmQZVhEIzXGt8zKWdcDsvRMcmD6p3vCMpR1903ZlmNy5IMp0MkmVJvI28tSFp/YYyAvuRwbG88yfijJdqVy8jlGK58SOImoa6PK6kuX75InOscROi4YPUi42NjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713117; c=relaxed/simple;
	bh=eFcS7aZABzxPfyL9RHAi2j6f6U0eqhmZmvp/RUiIFB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r8l309eZMgY5AmSD8eRASsN9Jwxr820rm/YSogizu8kRqR1iJTnst2BI8YEqssmNfFyvIjHXrY+cMSKssCNhDFEEV1rMUkUcRt/vAPSgPVNZJ7aRcCiIXLMP51eOHI5SvRqOhgOoxUJLfXQTwzr+gNhiaChSdmLApqtLJJAUicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GF4TQNrX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=erV9nTPF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606Efo8e322971
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=k13WNZYfb+ckJdxd4UaWtB0SWsw7U4s5oNr
	R+ZhgLNc=; b=GF4TQNrXWtH0VXuAJhPD2hfInDbcBzJSr+RPCXf1dqenQBX1AqQ
	xLns0ufXRbwqFfQKox2FNZXP8mCyPXgeuwjzsssfsW2SvqNtiqjKIk+NKmaygxTg
	/Uh0nbfNh7lqZ8jqfWk7e8Csl9l39kwNKCAqEHNjy+vhC0SosFRPxWOvyyayHTDT
	+EkXghw9cVKszgORJMG/aU/4d/NVTBE90DAPvDrgkQzI49zoGFmENN6jW6hD0mUg
	z5bPWSMcidT82L2ifxrYkLvIf+YV54rLLTB4gfwJF7wHeN2dtS0WRr60Cgfu2/BI
	Hs/WnC7vF+LYrcIJQ7UqfPb3Q2v2IE+5W0A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh4crg4cg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0bb1192cbso19239355ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713114; x=1768317914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k13WNZYfb+ckJdxd4UaWtB0SWsw7U4s5oNrR+ZhgLNc=;
        b=erV9nTPFvN07c5354EAAY6oJtz4a2kXv/i+9NCYdTPZAf/BY4xWNXTXv6BLUhCIzD2
         qauyn6wniBdrC/PrQwDwbbza7i9wstwsrU2X9SPYOE8eCrS8gOJODbCgn5qEIxyZ9wSu
         juHChvAohdg4VZ9/tCPdaFcy80EF1a0kDpjMMgJDluJv6ln6mtrPYC6ydvnFFnXe4CLH
         i23KIYxjDgjT0P8YDExq3n+ndlDG1jSRxYPGrwcPste4I1yWq1oVdTESjknx28ocgkh6
         GsfRNYePLdr52Zhx0X4U1HRTuiiLRGBXQvGXnNhMfgdoo+zTlVA9jfztGSOuu7tpk+sN
         zgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713114; x=1768317914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k13WNZYfb+ckJdxd4UaWtB0SWsw7U4s5oNrR+ZhgLNc=;
        b=rHx4HfphKQQYOfbeszewnpWOW7FSrW6I6Sfnqw+bg5u2TL9NlI+XsN7QixQft4Mipn
         fuPxnMBPf2EKrjl3DcW9WqtxXG1umPekZz56+4/uRqrlsnHpLOIgiNLzuy0cgYqnseKz
         jpectZmydIDf38cVFZrbMqjoChuJBMzFyErFylwL4HJQHDPCNMl88+/4Ja0vi7IyDIWY
         Va7c+TnDu6yrh0Y65hJ2zHbFVFmwKKZN0XKTPKk672q9v/ptSYYFd8IoD1asNhnCwGso
         D8OS4VMv4yf5If21vqjTubXQPCTfLJ5b81UIfmdVRS7Y2/+1ADapfoiw1Tinjn7QsKQj
         9LaA==
X-Gm-Message-State: AOJu0Yx++GnEMkcHZuH6ZPSJqQjdZTR5M0X+JdMBBDLVo5/dx0WUFB/v
	khLmP0Q98mrxLELP+fY9HCqj462aKW2JOyuowkRgvFpYxarMHmri5BKwj9KTJeJeKDDjO83q0wr
	F20q12LnKfjuDBcbTO5eZmdyVFLOYFcC9AqwV3YkcUk5vfoUUK7vOEVgF+p/N1PRDzxv8Ra9oFj
	pXbA==
X-Gm-Gg: AY/fxX5pxzAz4sFpNtW0z7dfL88Xbt3cwggaidw7STxkdClsXZsq5JLg6COfnngcoMh
	HVZ+rOc7P3YVKohgylMZB1JMUlhUibdgt9ObApVZl3zyj1FoTkFNdNuYtvDNssLuR5gdafYyj1v
	6iHPHYQRZ4GSu4FS8XoNMzfbt4/3/EVjkGznN+cYHrlinc5uh4JTiPG2WK8aIeuLVynM43VMD5c
	m/BHO5J87UoZZUtoKVZZJSVGq0RPDYJ1KRTSzYdjixcDGTAntTVvRscn7klkX4AIdxXHGM4Q+ad
	46GhEpo04uIjK0Q07Wimnp8vd80TZKheaxgm5D4P1ZLphqSwPs5UT8uC4xCcdKF41iZtngL+Uso
	SvjUiAwWOuisKptL58N8RFqFH7yfysTANyBYiQ+K8Jw==
X-Received: by 2002:a17:902:e74c:b0:298:1422:510d with SMTP id d9443c01a7336-2a3e2d2f925mr33755555ad.48.1767713113686;
        Tue, 06 Jan 2026 07:25:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ3JRHlcK3YVW1/ZgB0JLSt5/CTt3a0ax/7CruIA4A5mCZ+fJEQcvlQkq28dlJelneFmCyLA==
X-Received: by 2002:a17:902:e74c:b0:298:1422:510d with SMTP id d9443c01a7336-2a3e2d2f925mr33755355ad.48.1767713113195;
        Tue, 06 Jan 2026 07:25:13 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:12 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 0/9] wifi: cfg80211/mac80211: Add Support for EPPKE Authentication
Date: Tue,  6 Jan 2026 20:54:54 +0530
Message-Id: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V9FwEOni c=1 sm=1 tr=0 ts=695d295a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8xgW8lJkV5295r88nJMA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: KrpCZ-F8F6s2R68WFrGnKcTFV4ZCFWvc
X-Proofpoint-GUID: KrpCZ-F8F6s2R68WFrGnKcTFV4ZCFWvc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzMyBTYWx0ZWRfX4RLCnyeooIZP
 SKavBJDBeDoOzViGdYnSe/vcnGgjiImLR+832/fZ3UyMPOG63qvs2F1Fu4WaPnY8/bNekWD7COU
 rYStC6cE4kOFMfgSHA7JziKJpExAlrvuVqg552iBQ30LyLkDYXxNybwlsXIFzDsDM4Omv9KdwlX
 ACEkbXjxfES4Wz1Xd0io4repDEza6TTcwW9YQapT7q2AixpHa/ZLv71TnboGRaG9kEjdISAK5Pc
 QSsZp4LJtCN9mlhBx+SDfKpN7LB3Blz2zerRZh9+wURqqcuf4VBud5eMr97+RE6V7lIHMXoX3MW
 DhPdwJd1N9PCf+H4XSH6Z8g2WYENV8+Z13sHhyL5OeWQQmrqOdjERvWbMu0MIdX+LkqTeUp2hgF
 pPqJcGWVIYZNCJomuUOBGDiEOZWQoZvILfq6xdF8E8sfYniqGwhLwCsan0iDCyv9fKreOu1i63X
 xlcs9UwvRm/5MQ5N2MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060133

This patch series introduces support for the Enhanced Privacy
Protection Key Exchange (EPPKE) authentication protocol, as defined in
"IEEE P802.11bi/D3.0, 12.16.9". The implementation covers both AP and
non-AP STA modes, with clear separation in the commit descriptions.

The changes have been validated end-to-end using the hwsim tool.

During development and testing of EPPKE feature, we encountered an
issue in mac80211 related to incorrect AAD/Nonce computation for
management frames when MLO address translation is involved.
Depends-on: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce
computation for management frames with MLO

Without the patch, EPPKE functionality will fail for MLO connection.

---
Changes in v2:
        - Resolved reviewer feedback
        - Removed few patches, no longer required
---
Changes in v3:
        - Resolved reviewer feedback.
---

Ainy Kumari (2):
  wifi: cfg80211: add support for EPPKE Authentication Protocol
  wifi: cfg80211: add feature flag for (re)association frame encryption

Kavita Kavita (6):
  wifi: cfg80211: add support for key configuration before association
  wifi: mac80211: allow key installation before association
  wifi: mac80211: Check for MLE before appending in Authentication frame
  wifi: mac80211: add support for EPPKE authentication protocol in
    non-AP STA mode
  wifi: mac80211: add support for encryption/decryption of
    (Re)Association frames
  wifi: mac80211_hwsim: Declare support for EPPKE authentication
    protocol

Sai Pratyusha Magam (1):
  wifi: nl80211: Add new NL attributes to support (Re)Association frame
    encryption

 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 ++
 include/linux/ieee80211.h                     |  1 +
 include/net/cfg80211.h                        |  5 ++
 include/net/mac80211.h                        |  5 ++
 include/uapi/linux/nl80211.h                  | 39 +++++++++++++++
 net/mac80211/cfg.c                            | 18 ++++++-
 net/mac80211/ieee80211_i.h                    | 10 +++-
 net/mac80211/mlme.c                           | 47 ++++++++++++++++---
 net/mac80211/rx.c                             |  8 ++++
 net/mac80211/tx.c                             |  4 +-
 net/mac80211/util.c                           | 12 +++--
 net/mac80211/wpa.c                            |  6 ++-
 net/wireless/nl80211.c                        | 28 +++++++++--
 13 files changed, 168 insertions(+), 19 deletions(-)


base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
-- 
2.34.1


