Return-Path: <linux-wireless+bounces-34935-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJC5IE824mm13QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34935-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:31:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCC41BAB5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E87B630270B0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF022B8C5;
	Fri, 17 Apr 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6d0+7P4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfNCj5gI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B81E5B70
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432715; cv=none; b=rO7IF/+xajJzJf71zUHdb9KZz3Zqql4Q5uyA9JsCLqrPperInq+5cRX0hfcnnGxMYyWKHINHh59TZ//6Y6Tm6fWcvM8JOW8SAUSgDSG87eTBtP2Q2M+NCgJu8hLC6aq3cx7PvyyV6L7FUxc23pjVbTgUEWhv3xOxZahxn+d+WgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432715; c=relaxed/simple;
	bh=1caLOCZH27Eq25BZuQfbeic1pC1O3IbmRYE61/fr8xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NIEuOyW0V6TVmKhPVwd5/G7WXV3f9L0NYDuDpv08hEE7WvL/IuuQIvydrgcqE6Dm/fTDemtxYrckGe9UY6BXSB9XnfEgE7ziEpBvrTA3RMWcKg0lEcM71dCrKtukcDINURPxvj7QEOlb1cS6dUO83ePcfvyScn3nkrHqceN5qOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6d0+7P4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfNCj5gI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8tjUA1971847
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wvoBscxIHQok6zavo0nKotYv4lXyW27ct5/
	pQ24BrUQ=; b=C6d0+7P4ohkjruJ2uyBB1XH2VCHng7G3XXVuJ1rMYPp1vubkgG6
	rn5F83UBc+msAiA6MNBq1G+rmVgpg7mdABbMRn3ZQJ/81b7/eaY1uwRPejAbmFcl
	PIb9RhKvfoYjJ5Zl16SkJ6at/ptJuVPP4Vt7l1bF7WbxtdVwTVxlLoczsYSdhwqs
	mI4vsGjdPe0oML/dN6uEsoalj9jcoBW1WeIbf9Bs2+Un4CQxCWfjN/8YEeSyIfXh
	Pk86/Rns47HmdOWnpUdGqzRA8it5msZqeD8OxUeIuBN5XCg8dPm4EiqoOVPvKslO
	nYRVPvCi8RdFlO7bRBDQ8cAJ8KBLZ1fLgtQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhsh8yy2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:31:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3568090851aso1915488a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776432713; x=1777037513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvoBscxIHQok6zavo0nKotYv4lXyW27ct5/pQ24BrUQ=;
        b=dfNCj5gI6onkrowfn+izhO18a5in/l3ixmJQ/GfR0CnDoGgJ0uVxHT3Xf3CTmFHLl0
         62NWqdDojK3ojB5/vL9uHwLa5HONRJtoxfSvkFVGIM3Fl9aN20rCrO44j8tPCeQPHdjC
         YgYzFIaALDwC6Oa5UaJhMZ/ap09Np+yVoPrvl35QUM7SlxgUeTJP3o0TwWev2CioWMv2
         SYXbKqASzk678Srjiqah+b8AoDTCwgwp/odmxYFV+kqS0SBLC0neSUi1nDI52bANHWzd
         pqDeRHzg1l++9pdfrpQRsg8uPwAExFU4OApgxI0r/0TIHw8Epd0asnZ9NKHIr7LeghS2
         vGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432713; x=1777037513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvoBscxIHQok6zavo0nKotYv4lXyW27ct5/pQ24BrUQ=;
        b=chnmWX4cWt7W/PAjS4OYyqUAqbebJ+HoMznPmLSw9nwEobtyQOYHFLqorSLr/rYoxm
         2Rw6I73a7ljGr01+GrVc9kUnBlNX6L0LZ+pD4TxBgvlO55AsM+W82VrL5VVz6lMEpqLk
         /AW49fodI2Y5P7IUTy2ZPUQ9IKrVifyTYmaaxGxhDjqFQOrsQjO+wEk5XgyzZ48ty+Sa
         QlVzyJWOhjSFhI/vMt0+SJiGcWSD2fp6RZzM01np0v3IniTLv022hTQYOQdKdyBpLm82
         V58BsC/wfrumClRkdG3/E/2r6hRQfbAiYQuFZ/3zteOCTvytjCug3N3WkhId0HJGp72h
         le7Q==
X-Gm-Message-State: AOJu0YyA/cy4wYa5EF1rPZVMXSLsdxid5iu35cg6zzCtRLB8gqZZex9S
	M/FYIWuJfByg1gzYLKMG+abWyaBlIx1g9h/ofs3oS8nuFI50h4ZeSs2JY/adzoFRuITJpUOS9rT
	3IHjxU7wVevIX/UA3cMAzpGnOqt1gBvQx4cdmPYk3JyIsIcrXfDz2nOad2rdq6xBUHmJFUWgaUf
	BTyg==
X-Gm-Gg: AeBDievFDYkBkg7rIVv7ODe2HDga0zKhNAMtO3/B8AYhlCBEM0RWH08NWJRvDn25ASC
	JNSuqRFxdmXGojtOgqPT4qBr50RbEUNEZcAHgOcQAyrSm+ARWDY8aQbLYPRXbbon6cZEWWjQPEK
	mYndTty1EwOtRD19ZVlFHV1Ff1OkABs9Ows4dZCFcT7StZ5NEvFQOVFoZa2RP6E79fk1iGJzQfd
	bGKNacAGPwoYAYQU0D7wvMJHnb8nbolBUJSHV9kff/kqK4vcXVFR5LNgB4fP02QL4yI/8R5wznA
	eoswQLlzcZvcEW1CVOc/O9qOv0XT68fRSq8RE9O9vYXcAOP0mtdQF1S4AO71nBudOFs6RWvJZGN
	7UNrErN/h/4tqkhmDT8XswR4s9s3giUootVkFK6eOhA1Kxq9pYMDMXF+4
X-Received: by 2002:a17:90b:3d07:b0:35f:be35:fedb with SMTP id 98e67ed59e1d1-361403e0f9fmr3016437a91.9.1776432712628;
        Fri, 17 Apr 2026 06:31:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3d07:b0:35f:be35:fedb with SMTP id 98e67ed59e1d1-361403e0f9fmr3016383a91.9.1776432712051;
        Fri, 17 Apr 2026 06:31:52 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361418c3944sm2734438a91.8.2026.04.17.06.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:31:50 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 0/4] wifi: nl80211: introduce PROBE_PEER for AP and STA with MLO support
Date: Fri, 17 Apr 2026 19:01:19 +0530
Message-Id: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d6/FDxjE c=1 sm=1 tr=0 ts=69e23649 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=MFiizzD7uS_rQzf-xLEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: dVrpnf_yLSSGoFmaQCIWYm0jNdM4xX5d
X-Proofpoint-ORIG-GUID: dVrpnf_yLSSGoFmaQCIWYm0jNdM4xX5d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzNiBTYWx0ZWRfX5f5gBXl52fbV
 5ZG54o6lu54Pr0hnETcs/taaWHJTHEvjNDY/mFm2QIE48tFN8FRngCp4HLzUiDNPubzzCro53GL
 DPOcltDHqHvIEpzbw1ukyOjrli1NEAFrioyjHbdOgrP9trbXgs0ULoW6/+0NMxmm4CrAMopSn5h
 0cN3O62Cg3hdVawuA6BBk/gScdPv5Q/8PlZvT1AViley9A58rK9a92TULhVZLl4FooARBEEDI5Y
 fU9ixL0YHDw71KGzQlCQ3lBRelhwlEw7ca3lNCvJtqNyIAVwfBZdFLdHE2lx1HOkBeGqWS0+TLu
 iUah9QKccYlzGuphFTmtj76jdlLCJQUMEUcxQUcoV9lvIRniwjP1AvzQe+23eUVMDi/ScFCi6zJ
 xQflNdCuF/odhH74LbecVN+Gv1nNrZeO1V2Y6DlVaeLoWdxEH4n/UY20bDUWYZ1Jf1zqrtffsXn
 WcGAofZWt1OhOUDf1Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170136
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34935-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1CCCC41BAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

This series introduces a unified mechanism to probe connected peers.
It generalizes the legacy AP-only PROBE_CLIENT functionality by adding
NL80211_CMD_PROBE_PEER and enabling (feature-gated) STA-side probing.
With this, AP/GO continues to probe associated stations as before, and
STA/P2P-client can probe the connected AP for faster link health checks.
For MLO connections, mac80211 supports per-link STA probing to obtain
link-specific ACK and RSSI information.

Patch 1 adds NL80211_CMD_PROBE_PEER (keeping PROBE_CLIENT as a
compatibility alias) and introduces NL80211_EXT_FEATURE_PROBE_AP to
advertise STA-side support in drivers/firmware.

Patch 2 renames the cfg80211 driver op from probe_client() to probe_peer(),
extends cfg80211_probe_status() to carry (peer address, link_id), updates the
nl80211 handler to NL80211_CMD_PROBE_PEER with proper validation (AP/GO:
MAC required; STA: MAC omitted, feature-gated), and adjusts all in-tree
users (wil6210, mwifiex, mac80211) so the tree builds after this patch.

Patch 3 adds per-link PROBE_PEER support in mac80211 for STA/P2P-client
mode. For MLO STA/P2P-client, it uses IEEE80211_LINK_UNSPECIFIED with
MLD addresses and lets the driver select the link. For non-MLO
STA/P2P-client, it uses link 0 with the per-link BSSID and link
address. In the TX status path, the peer address is omitted for
STA/P2P-client mode and the transmitted link is reported through the
link_valid/link_id bitfields in struct ieee80211_tx_info.status, which
drivers fill before calling ieee80211_tx_status_ext(). AP/GO behavior
is unchanged.

Patch 4 makes mac80211_hwsim populate link_valid/link_id in TX status
for both the direct TX status path and the wmediumd/netlink TX status
path.

---
Changes in v2:
  - Updated patch 4 based on comments, moved the function and removed
    unrelated code.

Priyansha Tiwari (4):
  wifi: nl80211: rename PROBE_CLIENT to PROBE_PEER and add STA-side
    probing support
  wifi: cfg80211/nl80211: rename to probe_peer(), extend probe status,
    and update in-tree users
  wifi: mac80211: add per-link PROBE_PEER support
  wifi: mac80211_hwsim: report TX status link_id

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  11 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  43 +++-
 include/net/cfg80211.h                        |  16 +-
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  27 ++-
 net/mac80211/cfg.c                            | 199 ++++++++++++------
 net/mac80211/status.c                         |  30 ++-
 net/wireless/nl80211.c                        |  93 +++++---
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/trace.h                          |   2 +-
 11 files changed, 310 insertions(+), 131 deletions(-)

-- 
2.34.1


