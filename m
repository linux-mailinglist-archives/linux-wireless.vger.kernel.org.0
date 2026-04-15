Return-Path: <linux-wireless+bounces-34757-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KA8AwZe32m5SAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34757-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:44:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3463402C50
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69A4530466B0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41733ADA0;
	Wed, 15 Apr 2026 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBsMkIeV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnVcHjnT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E433B6F1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246209; cv=none; b=TSBYgHWqFqy6Eyzv/vZaGsRlHToQr4H+zPpdsBpQnIUtD3IUBKxOwmXxMguk6ulTrdN7MHX7e5smb74G2AlTTB2No39uRMg+C10B+B4VqPMz/QMroLqpsdR2IOzpvr5+yPGgTd2sF+t3dDm+bzuIMOEHBm5zSt93GfOORsB0lj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246209; c=relaxed/simple;
	bh=YpaoLP6hQAxkjjaaY/sb2SXQGG/3cA2/gUbPCTMkPZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLaQt4IQNMyPBHahxsL5gCkxo5WxBOiLyC+42cZ3BLZoxvp0bnXJ/hP/x6ncx9bnHnhGf5mP6quaq3FU9gLsV0E7YVbH5LGIT/6q8fgfoOfURHtbemthcphClR8PP8STW8b6fOMJPYTsc8woruLxnf42QxmYvBhEL3hLwXMtFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBsMkIeV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WnVcHjnT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F91Vlk1778920
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ysMpaQeoiWyRhgVLJeVU0ZondPToI1MoIF3
	02joqLoU=; b=dBsMkIeViELsRwqs60gcmYeIBzAfV5MWTtYBu4GJJ0Ifz6OzBO5
	le6PUVRPBgbe3WE56WvmOlg801mquo5Jwiwk9i+VEQh2HC0hnBSQgFuHQIh292dp
	aAGpQbH7cRG+nb9X8x6t70BgN372GA+LpJ8I5hR9TTnFWdhLrml5vAAKnCXcH9oL
	LM4hJ226HCP7yYNsXYGVbDojELnyh96snLoOw2pbD+XrTe8CxKbcVFLLo9B3BfUS
	SgmZq7oYwrraQAKb2CcSsoG0q12Jy8CXQc5dZsvIciQ0j5afJewIF7HzmK2c9Q+h
	mZGCaVMUWZNzyOBgC/lirlaB8XfLof73Gdg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrw031ma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fb3bebb30so6353784a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246207; x=1776851007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysMpaQeoiWyRhgVLJeVU0ZondPToI1MoIF302joqLoU=;
        b=WnVcHjnT2DrZ1Iy8mBGyjiqRUvh/n8sDn1qNVtb96g2th4aWOaLVD7KQL7yQI6hnmY
         quXGRUcLT+C78W4NtTCaLzQ1BNVYVnAyFeZWeWaUdBhpGzxNsC/fNWiIw/QKUN/yB9wu
         YXYLt/pwH/JmYjr2PzQi4WumIF+pfA5UZYiznSl/PEoawqp5ZZ0/EdrCW/rELTU47XUC
         m/H0PGFekSWXkwAtpxU/Rt0S6AzeQpiRb8y2bUb0sf5JfcVa+imn3UE+G4gpCBRy7+ay
         pT2Ywj2Jlj2CKrpG6kERQnFl21kLMv+jGDD2lRG2oxXiH5LkAUEvJaYY0nyYWLci29F6
         Zl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246207; x=1776851007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysMpaQeoiWyRhgVLJeVU0ZondPToI1MoIF302joqLoU=;
        b=LnySzyOkSWkzN+SWCXKjEO7vbjCSJDnJBxjEoIWXh3y4TuNnrBIsMOzZ78WBIRwrrS
         JvPC5ymOjqZE2k1ghxRUMgb036MM9L4Zg+iwS1YB+2YFpg5CVdqpLZhYmoEd6PptYNSR
         3i6/diqJGZobbx9JofWM1uTW/peaaIj3Vqyl4Ebu6qKK16U3GKnRBKiw2dQ3AnE75imz
         JYW1VKBjB0IUdOEPisNmfLm2EDKWOqaPi54Si+Ur36oy/6Xi/jc1xHnH7+QhytOW6mjW
         Cv+Nn+/tBXtpkWtTADQhceQw3bICgoD2CXjvc6ia6xylOumaO5NtcPBj5Y/Kqgtz8CoW
         CrsA==
X-Gm-Message-State: AOJu0YzzbZDxP1Th6+gCUcrc4W4MDfVSG+xsFtkUs1sbznN0wvm5aGLK
	Y8q6ON1Q+rryun0IARgRXvd6GjutpU7kvzhRAYyPocljQmks3VAw60EypoWyU0lMZBk59wqblYc
	TlyJon//itobX+ZSWbJIbfkpn9SrpUuICUYxqOmRH5zWWTEw7T9AN25p2P4CIMl/y2gbV2w==
X-Gm-Gg: AeBDietDD7TkRRkNncAv9Yk2fNQY/R3QP435QlX4/laT7mGKTSGyNCtTe52tcG/uQtu
	zVD11KJxF/YdK6qjpWWQEolTMxbWbBUuKH9o4hTAA91Thr/tK2mShcgefs+Q984WuZcvqHGxZPA
	8hD0K8HtThgs7tG0mtZg99sVsdfY9C21BZ5+JSa1+/urRkCMa7a75RbmiGzIAiH87kjqdu0aJt7
	HBDUfov+DZLctAX2YJbFp7XjFscOovjrtGLQaz1FXaNGcZ++1cJ05Pd2UlUbpm392kDJ5RlKhXj
	PcgoGKF9XoznENndS6qQHq/1UYl/5zXvIqOZRis0QsHk5rvtzGDDcpt/eXsXOGFubYLms1+MHsg
	AsdhEuILLMcFBo5enaSTNF6GjwBd2Cmd9xtRX0qTAR+d3nqXrKDc7OacU
X-Received: by 2002:a17:90b:4e85:b0:35b:a8cf:7960 with SMTP id 98e67ed59e1d1-35e42769f93mr21316966a91.3.1776246206725;
        Wed, 15 Apr 2026 02:43:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4e85:b0:35b:a8cf:7960 with SMTP id 98e67ed59e1d1-35e42769f93mr21316941a91.3.1776246206169;
        Wed, 15 Apr 2026 02:43:26 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd2101cf1sm2391200a91.15.2026.04.15.02.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:43:25 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v1 0/4]  wifi: nl80211: introduce PROBE_PEER for AP and STA with MLO support
Date: Wed, 15 Apr 2026 15:13:00 +0530
Message-Id: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5yxkxjS_hSKOHbGE-a-bKzT-wzPanSOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OCBTYWx0ZWRfX6Im++22vQ1Y3
 7H85wDaZtJGSMuL01U1ET7T/2W+KKNvHpIJXpkrN7WzGlEWlGWNyCHlEFwMlagyIpPPPTNR8KbP
 P5muGE/o2prfUd7SV4yJ8fIKfHbNOqzXXPcpjCO287LJhzOep/tc5symZNH5h2n761rIrNOsNw4
 owuev2yprTIIlmV9dN8fxjAKVyBuHWgyUJFTugOscA6SGXKMY6eoRiT9Eq0Q1aDIZnUCNOporI9
 0JtFfDs+fi7aA7+RcKa6XUzqQpN5Qzwk4N8rK/FabwUrnYam5D7rk02IOWsaSzslCzNUn6/lGHK
 Q8qszjzIMMYktNVRt7l3akLNOEN64fk6AKfazQaxz+y6kU0mo7P+5qUrxO7hkOLelK4rBKAVU2k
 QjHAeaNJdPEefjRoJ3JHEZzeNJ/KEjPW8WX3MokuPIqefmIWf68g1P/SXwGu6S1SSHB5nNDvjQx
 Xq423BGILDs1cKGrl7g==
X-Proofpoint-ORIG-GUID: 5yxkxjS_hSKOHbGE-a-bKzT-wzPanSOC
X-Authority-Analysis: v=2.4 cv=YMGvDxGx c=1 sm=1 tr=0 ts=69df5dbf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=MFiizzD7uS_rQzf-xLEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150088
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34757-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,qti.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A3463402C50
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

Priyansha Tiwari (4):
  wifi: nl80211: rename PROBE_CLIENT to PROBE_PEER and add STA-side
    probing support
  wifi: cfg80211/nl80211: rename to probe_peer(), extend probe status,
    and update in-tree users
  wifi: mac80211: add per-link PROBE_PEER support
  wifi: mac80211_hwsim: report TX status link_id

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  11 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  46 +++-
 include/net/cfg80211.h                        |  16 +-
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  27 ++-
 net/mac80211/cfg.c                            | 199 ++++++++++++------
 net/mac80211/status.c                         |  30 ++-
 net/wireless/nl80211.c                        |  93 +++++---
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/trace.h                          |   2 +-
 11 files changed, 315 insertions(+), 129 deletions(-)

-- 
2.34.1


