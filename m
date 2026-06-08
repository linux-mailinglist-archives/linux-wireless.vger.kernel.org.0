Return-Path: <linux-wireless+bounces-37493-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JTbBFzmIJmoUYQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37493-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:15:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBA6547D0
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:15:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bKpjWWnf;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NRsOwTZ2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37493-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37493-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35B5830157F9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734163B440F;
	Mon,  8 Jun 2026 09:07:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FA3B42F2
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 09:07:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909673; cv=none; b=V8pAAP0fHIhHTP1wrkEuYVyBKspvHwniMoay9NhtDApEuxQE8lf+PpviqO1ijCgUe6ldlejyptcrHc3DAdRlwnRsTLesFH5TzcN7CDUYXFj2BhWoHtwS+sCzglAtBX5qDYXUSnpaWXPkQ6iWbz2Pub2HpSkjGkOf+6fa/NJVlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909673; c=relaxed/simple;
	bh=em+L8R/eMvzAwH/Szx2mGtcX/dspQ1c36ijq68dUpZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmN/NlXguISRdGWaDJPen4W3sf0SsMku+IrDog9vTAxExmEPjmX3R8hyA1SwMvRdC0/4bNkppQ/z4mZ8OV/qc4lDJtgSK9b8EwBGHuOQcDnX4nn7o/spnaN9jJU+Hc4kryFTMjPDxmT621AQfsoa4LFVjGtB10jwDKQaKGyJ+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bKpjWWnf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRsOwTZ2; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65890s5g3164190
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 09:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+3/R5lmk75UYvATrW4nidQVRUoSrgJqZLKr
	xN01PK8c=; b=bKpjWWnfAhcfZgkWh/ql8DKBGZYdYncJ6ZQZA43etc/PwRKm/FY
	n+QcMWaWNipS1u0leyvmO8r24+V7WrEdOON6oXZPB2Tf8jzbLYDl2xrhitlAbWL2
	2C0wY7bKPdXUcE/wuTeBXX9YUNKv8762gmpZdmBxFvITbt4spX0Megp2zXloCo2L
	vp98yitYiEljLZOODcDJm+6y4TeKRea4XvmZpEzvFa20nWxtqX80EX+MJvr45dF1
	HO9Olqq/S/BpLXP2zwYFIv8f9psUTsjuLzvj91UqPEGlfakT6N/bMO56o+Ap+k/s
	cFqG+nK0bWlZ3UsTuw9GPhiM9nbNT7J1gSQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0g15r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 09:07:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8428384f31fso2872287b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780909668; x=1781514468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3/R5lmk75UYvATrW4nidQVRUoSrgJqZLKrxN01PK8c=;
        b=NRsOwTZ2idBO2lXTu0zd/43l3OQ5/XFaIMKILWDEqtlXq2kT/ih7SmDDLwuPlZ+U2i
         kWXeesMO3TYgrtjX3BeIGyx+1f7EGWaizvX0KNdDxL2UEiDZPHjO+ioXbjFQ5jLmzaUl
         OT1LsQz768BZshd6SDjLLmg2BNAup4GuTuX/ba2nlO02l0jwG/onHOl+92cw8ty1QKun
         DxEQ52WncWYWVDtU9t61HduvwefPreWOWxF0Dvr2ZbhatClXvofOZct3FjgRpg9oIK+n
         J5FR0lpHqXY2KSqMDfbOEbtXCmbqhVFXOpLRnhwlHYNvFxWEXQh4dsBLa861UH3Q6she
         9Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909668; x=1781514468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3/R5lmk75UYvATrW4nidQVRUoSrgJqZLKrxN01PK8c=;
        b=FU5dHranTQMVjby6gwQHAyWIq3+cAqTRacAD3jXxmMm5evs5vtxlyTyqkyPTS407Sw
         O9jekF1SKKN2fX0Y+dboMOIMNQdyu6IIqqtOkrc+KP6GuAoBKC7k9IBexQJq/O7eb3TM
         0otzfPVwv09yXXg/scb1zujmimPAePIU9zmbanXHMCPKiZXyiom0/BLHNQiAXG4WZl9u
         CKglM3PKEznp5rryhEVnX79wdW8m2JKFEFS14qYpS1MLfA4HPmR+esrA8pQix6Zra48u
         kdUqnt/B6xLL8t6bg8YMujelXGYY4880y0RP/+RDOfAJ2BoMvsz+iQMSmA68jJXbaj9e
         MpxQ==
X-Gm-Message-State: AOJu0YxVivMZVHryHFzQiFiY7ZYLeNLNIcnfbSwIhjTJkptCT/OHLyRR
	c4GWBb8gavSY2l4P0ApMDQpzMk/iiYsv1iLpAk1dVfYZPEwBLkcSDlWg8xmSocv7nW7H435TU9B
	9zKPn0frjzygGRl2thydeyUTlFfKDQJB1U/CdBUxEnY56iUiaAgKnRaRy6OGMYdaYaqgJPwtDJr
	SdPA==
X-Gm-Gg: Acq92OHvoHgcsSA7bBj9hsVeu/7f2Tombon8dZJaI7LXOOevQKL3uNOqyNY1j1lp349
	5XoLoOcIzkELPyL3aW6CwaJhv8YLd1jj4SvwL0//d+5iA5l5cXoCzgmyDGLK9B/R3xUxGAaCa+K
	FZ76Zh5cjEi7Zg0Ttq+QAZluVQGiHOHSWJGTOMgda8ZKAF8Cgki2Ix4SEs1i4wlg5PToi5SK0Q1
	boT2Zd060LtAyVQ5TO/d73JvvzaGCmM8N1jh6H+UldCf+rdoDMDYt1gh8HX7E0Tx8bYAxG4RmhD
	KJOhscuFIOmelRkeTL4DvLDiQYTnlC6eA3LSf8XVZmthDTLK0iSqfuvklH3AzHO2/fojzx4LZT6
	VZNyk7MbvDz5TZ9tdY/kQa0FKTpTHg4Lea4GhxeY3QUkMf6eUyKruja02
X-Received: by 2002:a05:6a00:3d0d:b0:842:37d3:de21 with SMTP id d2e1a72fcca58-842b0fbb75emr13734314b3a.40.1780909667783;
        Mon, 08 Jun 2026 02:07:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d0d:b0:842:37d3:de21 with SMTP id d2e1a72fcca58-842b0fbb75emr13734275b3a.40.1780909667137;
        Mon, 08 Jun 2026 02:07:47 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282379db0sm16512603b3a.24.2026.06.08.02.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:07:46 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com,
        veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v4 0/4] wifi: nl80211: introduce PROBE_PEER for AP and STA
Date: Mon,  8 Jun 2026 14:37:23 +0530
Message-Id: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4MyBTYWx0ZWRfXyotNHj8/gFch
 XD25UpReW5KSy2T32oDZMriYOya4DvI0reE6QtkVuEA3bE4FfvMyk3aRkOpmQJtfgYEm0t8AweQ
 M425zohdjuS8pwvHQ4SlShs7AwoCYKLHnReU7dvRAGiw9paZmKDpI9Rr7jqlgWGzVIUjH3rnXDN
 +valJ+72TSXYqQRKhI6l7Xy/FAIkw1wKqkyOe18wRWwohEw3hskA+YWHngfEyl6YDyfMUKc5UUL
 t3K91aILcWJP1CTcKqtsa5PJHXMjk1BMBMaju0sUuKmslTwDFYOMhdAwQkZr+st+l6Wfm/DdHD8
 /vmKJQiUwwSCpMrsWKtTaVCIONKNFuE5BvB9tu85tCUmkXWKDPmBRElHXQEzWnWDt94sFMwpkXK
 kCtvoxvYqZezI+4K8PyeFp1zN8F7XchtGRh/p8bGzfH+4fQAa5kl+mNd9YgBID5tXE4n2D3py89
 lfOR4PDiELuMJv46FBg==
X-Proofpoint-ORIG-GUID: j_uWFgKAYQ14etLxwdtUphiWtsUF4fTl
X-Proofpoint-GUID: j_uWFgKAYQ14etLxwdtUphiWtsUF4fTl
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a268664 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=R0NonwOPtRFAW2HdiO8A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37493-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15BBA6547D0

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
mode. For STA/P2P-client, it uses IEEE80211_LINK_UNSPECIFIED together
with the associated AP/GO address and lets the driver select the link.
For non-MLO connections, mac80211 still fills info->band from the
current chanctx so legacy transmissions continue to carry the correct
band information. The link_valid/link_id bitfields in
ieee80211_tx_info.status are set before transmitting and read back in
ieee80211_report_ack_skb() to report the actual link_id to userspace.
AP/GO behaviour is unchanged.

Patch 4 makes mac80211_hwsim populate link_valid/link_id in TX status
for both the direct TX status path and the wmediumd/netlink TX status
path.

---
Changes in v4:
  - Patch 3:
    * Dropped guard(rcu)() from ieee80211_probe_peer() and used
      wiphy_dereference() under the already held wiphy lock.
    * Simplified STA/P2P-client probing to use
      IEEE80211_LINK_UNSPECIFIED together with the associated
      AP/GO address for both MLO and non-MLO cases.
    * Kept the non-MLO band lookup via chanctx so legacy
      transmissions still carry the correct band.
    * Return -ENOLINK when the associated AP STA entry is missing,
      instead of falling back to non-QoS probing.

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
 net/mac80211/cfg.c                            | 158 ++++++++++--------
 net/mac80211/status.c                         |   5 +-
 net/wireless/nl80211.c                        |  69 +++++---
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/trace.h                          |   2 +-
 11 files changed, 216 insertions(+), 132 deletions(-)

-- 
2.34.1

