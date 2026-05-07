Return-Path: <linux-wireless+bounces-36083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJVKGPLI/Gn1TgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6C4ECC59
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 580AC3004605
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A55836EAAD;
	Thu,  7 May 2026 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="piWd+qIi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5yRUJm4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E4306B37
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174187; cv=none; b=nu1oD0KTvlsK+PjHJC25KJxq5gmGFYhj7eFgCv6yp4Ecx1whltFcRRVUjQz25J9CJwU8GJsYRm4D2gVNvaSLAHUl+eByeC2wo1KNpM8MrfUvjkvmx0+rruqtpBtHYE+Q4VtNftU5be7M8foySFEOw6TAO6iu8G8MfglyYLrb6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174187; c=relaxed/simple;
	bh=UMC6myDmJ8md947Obn2ikUU4d5AYKVqthUL9JGaA+eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UU2kuCqbcW3GaVBS5u+dnF+HuVSbcvVSVmnUKWVpY8Dof3i87FFm/VAZUt2WwyccVVsnVUAwZTFgTS2TLsN7TiEX8Mwpn42U+rM9RJA8TRcGdWjRVwv+6JHspiu3U3BpBobHP6JpOtv/PKMh3vIahE1qh9E18+59LEPDtlYWKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=piWd+qIi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M5yRUJm4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647C5WI01971630
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 17:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mydhpnG4xbHlNnH/nvJEi0uno8sH4sdaKhQ
	+yR8Ypnk=; b=piWd+qIipwyNMm2V+8W+sd1nKsOYlB12lIFWBTzDPgYcoWQpm/W
	siyhDc6wd8/NyGOxRP4N3ygDdIzyhCG1MbH/19odomdzlhZr5JkxhqhLdHKdFxYy
	12kPRqBd7WfYAkeZ/Op7ztZcE6tI9DwSH5KW9UFhgnyJezScOG3TrbRFRG77VdHZ
	15kT/HjMsop5h1L+wYn6z5OuStO7j8FJZib24HoLmQ8OOKQe3GrcLOiOXfsvhztB
	+Wa4s9BQeP809Z9SXIQ+DepQicsjO0+SsA1rwRdJGbj5BMzgkpnRbCt5zkIvqrsb
	+zWTAIpq/LIG5D6UGnfV83njsvtr8ooU8fQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej9bjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 17:16:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c81ed67fcbcso532378a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778174184; x=1778778984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mydhpnG4xbHlNnH/nvJEi0uno8sH4sdaKhQ+yR8Ypnk=;
        b=M5yRUJm4hNBi/nbl0gAUVYAB5QRfbZh7a67nuZFHY/kg9VOEaUTq7f+EMTo0r0nz0A
         DTNGe5bbMivvjflwbp0r8z+9KgpcVC4kIRIu2k/aMSl5I48Uq1Pte9sY1VzlCMFcngdI
         btfnK0IqkkDYL3mYP6uVQo2HCyJ+68leXqnYLpl/EONyvnGhT+Ymc5jDsQaW4HublFvG
         BuK439MNg2bwIgoiyGabXOAkqXm4l+CYMsAcCQ86dKJcNu5VZkutzepvD4HV3cYe4Y4I
         In//gLBe0nEOnK23a9QCkpUYNE81HJ+SWhO6t76HjmTDQiiFG44G2P4OCMQNCw/+Brhh
         3lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174184; x=1778778984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mydhpnG4xbHlNnH/nvJEi0uno8sH4sdaKhQ+yR8Ypnk=;
        b=nP67eEKQezAtndgoImI4J8qRzNH+IyARu1GP+LrDpDniaazNlo8r1Gwx3fbyNyB0fk
         0hSflnbf5uZexQxnGYNofrQju/eT0pVful+Td5uzcEZW3M2OkQFLeLz2+mZNhgxMoXsq
         DDFFhhNo9lIg9NF8Lfbj+bLy2rdU9bh/ATjQASs3q73RBcPMu0tAHAuOpNXBE7qOfy5i
         PqA/Jf18Egt471Pv6EMuUNAToLP03xG40XZd+DW22mIGDzi1eWof0KzTs9zPURHY4UMr
         iKeZF5bfRuY+hmqKFVgtoGrjk+nAhtNrpU0JUHlZAgiLWhrH30GGSzN+O2tIPPOJ1wea
         DTRQ==
X-Gm-Message-State: AOJu0YxBiT9Zzkn4wVY0lGTce0okMuJU9kooyv2+v38pyDRg/NDUXorw
	43A+TnGJY5DpNL+D3IXioeic2yDL9kJRgjeJ4pH/5CovV+IAA9pAwPdVNygjOcnbCUzaUYN2YOt
	ZYnRlAdStiKICl+MujXMvpglqwCOa6Un8d1IFvPSR0k3idR6sMa6oQm+nVz8AEu1qhitw5eQ251
	Dijg==
X-Gm-Gg: AeBDieu7LWlVvUpE2a5fXMjqvnyDyHAW8BskWeyXIbr+UJ+C4k63kYWlQXl3wSJHdJD
	VUS0piPvAyDn41G4MbfuLFxdslXtPSDDLUj7QP/abCFDdn2iDoZjOa0eTPVeaKZSxIJ757zEkx9
	73qKWCk0L1L5b+fJuuCK6FNX8eiVRLE3IZsMrCN48F96yVoXq1M3VpkplmxIfADwDS9uB7+j3W5
	SrjBDlKzeVP9IBzpr7j0PakLx88GxDwxxK37A0MBPwDo0K+6kZ5OBxEQFEbCegLp94HvNDDo0kb
	8Ge6KXPL6A0NKs7AAeYJb8QGJZLl1NwbqA4opDsfp0o+z0kOT1Fk076i0fPZtOQ/xOhyHPosJ2j
	unIvs87sujUgmdxMynIjqCm3kSrYxgEi8Xrul7FeCMk4yqA==
X-Received: by 2002:a05:6a20:3d1d:b0:39f:8b01:d968 with SMTP id adf61e73a8af0-3aa5a6d868dmr9780463637.11.1778174184227;
        Thu, 07 May 2026 10:16:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1d:b0:39f:8b01:d968 with SMTP id adf61e73a8af0-3aa5a6d868dmr9780436637.11.1778174183684;
        Thu, 07 May 2026 10:16:23 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640f7838sm121457a12.32.2026.05.07.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:16:23 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 0/4] wifi: nl80211: introduce PROBE_PEER for AP and STA
Date: Thu,  7 May 2026 22:45:59 +0530
Message-Id: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3NCBTYWx0ZWRfX0HyzrRRYsSi/
 oH5nTrETzt/+ePeLWD9ukPFPnBM/4JpuvWU0lG2Pm6fy4WspCJ3ullr13caL9PuiaQ2X/hb184f
 QfHuIEteU185INm/EvXrQ8iIy8bPugDeMXxvsYF3EeuywWVWbCACGmCVsaoOlCuizEl2jNz2O8B
 gCbIiVAUMB7W6hjoUR+7/FMAbkpB34oXhVz96sPYZvKbDlAiDQdGC6jYjRJCPFi+VkDaRgWqifc
 PLpY7/JX+Ta3rffLSX6qTWqMBUtHqOfyNmIu2gVM2ar3RalhfxWp4hXZc7KCBH+e0jYHEwy9Iav
 FV9U9jQUnZ7iVTcBOOUpFoOlcTG9bxyHxpLkJ1vh3hmYH2VfUOTZSW0NOXv9j+396sDvqw/BeRC
 eVufRihFuPMWKJShN5KZFAqR8Ei5QHUCRz+kDa/3nV1NnzXDhewigDLTtXSYcItuLg1s26SKcfc
 vYxudwgW0KYpG1OfEAQ==
X-Proofpoint-GUID: ijYRChWrT27v4SlkCmXFISSzsit5CCiG
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fcc8e9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Wg3stcJrRSMsM5Mpm90A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ijYRChWrT27v4SlkCmXFISSzsit5CCiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070174
X-Rspamd-Queue-Id: 58A6C4ECC59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36083-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qti.qualcomm.com:mid];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

This series introduces a unified mechanism to probe connected peers.
It generalizes the legacy AP-only PROBE_CLIENT functionality by adding
NL80211_CMD_PROBE_PEER and enabling (feature-gated) STA-side probing.
With this, AP/GO continues to probe associated stations as before, and
STA/P2P-client can probe the connected AP for faster link health checks.
For MLO connections, mac80211 supports per-link STA probing to obtain
link-specific ACK information.

Patch 1 renames NL80211_CMD_PROBE_CLIENT to NL80211_CMD_PROBE_PEER in
the UAPI enum (keeping PROBE_CLIENT as a compatibility alias) and renames
the .probe_client cfg80211_ops callback to .probe_peer. All in-tree users
(wil6210, mwifiex, mac80211) are updated so the tree builds after this
patch. This is a pure rename with no behaviour change; documentation is
intentionally left unchanged.

Patch 2 updates the @probe_peer documentation in cfg80211_ops to describe
the STA-mode semantics, adds NL80211_EXT_FEATURE_PROBE_AP to advertise
STA-side support, extends cfg80211_probe_status() to carry an optional
peer address and a link_id (-1 for non-MLO), and extends the nl80211
handler to accept STA/P2P-client interfaces when the driver advertises
the feature (MAC attribute must be omitted; the AP is implied by the
association). All callers of cfg80211_probe_status() are updated.

Patch 3 adds per-link PROBE_PEER support in mac80211 for STA/P2P-client
mode. For MLO STA/P2P-client, it uses IEEE80211_LINK_UNSPECIFIED with
MLD addresses and lets the driver select the link. For non-MLO
STA/P2P-client, it uses link 0 with the per-link BSSID and link address.
The link_valid/link_id bitfields in ieee80211_tx_info.status are set
before transmitting and read back in ieee80211_report_ack_skb() to
report the actual link_id to userspace. AP/GO behaviour is unchanged.

Patch 4 makes mac80211_hwsim populate link_valid/link_id in TX status
for both the direct TX status path and the wmediumd/netlink TX status
path.

---
Changes in v3:
  - Restructured patch split:
    * Patch 1: pure rename (probe_client -> probe_peer), no doc changes
    * Patch 2: documentation update for STA-mode semantics +
               nl80211 API logic change + cfg80211_probe_status update
    * Patch 3: mac80211 implementation
  - Removed unnecessary bitfield padding (no pad2:3)
  - Moved MAC-omission check for STA mode into cfg80211/nl80211
    (not mac80211).
  - Used switch statement in both nl80211_probe_peer() and
    ieee80211_probe_peer().
  - Used guard(rcu)() instead of manual rcu_read_lock/unlock
  - Return -ENOLINK (not -ENOTCONN) for unconnected STA, consistent
    with cfg80211 conventions

Priyansha Tiwari (4):
  wifi: nl80211/cfg80211: rename probe_client to probe_peer
  wifi: cfg80211/nl80211: add STA-mode peer probing
  wifi: mac80211: implement STA-mode peer probing
  wifi: mac80211_hwsim: report TX status link_id

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  10 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   8 +-
 .../wireless/virtual/mac80211_hwsim_main.c    |  43 ++++-
 include/net/cfg80211.h                        |  18 +-
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  23 ++-
 net/mac80211/cfg.c                            | 157 ++++++++++--------
 net/mac80211/status.c                         |   5 +-
 net/wireless/nl80211.c                        |  68 +++++---
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/trace.h                          |   2 +-
 11 files changed, 216 insertions(+), 130 deletions(-)

-- 
2.34.1


