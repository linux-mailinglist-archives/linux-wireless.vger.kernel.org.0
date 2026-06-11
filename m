Return-Path: <linux-wireless+bounces-37653-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id odDsIj5UKmrrnQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37653-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:22:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014DB66EFDD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:22:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SYku6+O7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CNYGtDe9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37653-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37653-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4D0301E7EA
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 06:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814822A80D;
	Thu, 11 Jun 2026 06:22:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7233624B8
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158968; cv=none; b=rIKMcbPXHWAZYuoMrv9R13zFFSoXCgju5amo1itJp0pkBCCQCTkQhBGebIOgQKVQcWAzgWb1Qmb3w1Zm36nbQBHc6cXNrA+jNG7bh2jbpTm8aB0QcT+cSbpZ4opZbNhBgrNmQuh813QnttZNEzxpsW7JmHTxq8tB4Mp6GlJFP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158968; c=relaxed/simple;
	bh=VcoQWSer0ygseCpNXTftzq8wZuTBPc1q7Q2Rg/VaC5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IKy1SCcfrbo1ZFQIm3D13wuY/eAIVBOrEa+uPW9JOqb3gerGBWIdvkksJgom76IYJ5aVl/hpcYLrcjGZCc9C0SYBcxAJ5+XNkySq49IiKfCOkJ8CR14hVt/iS80sEGzbCrIJyE8CVW8XZPGJXYbZ9QO8vjuYibfpZ1djPW97mTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SYku6+O7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CNYGtDe9; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GhZw3846591
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jgAOGpY7wLkaVXAwVFjdCovl6zrwjlnMsBt
	ovx7Wup4=; b=SYku6+O7Wednp0nwKiAJr09ILGOmNUWJQGJsnaHkQ8LO/FVNaZf
	rppjcUER8Llv75grOsdGUG3panAgPM2RhqUiE36QdS1nWNmWOWQyJud/16bf6Nby
	a8KAO4Cu/ruucS99vbX1WKfIhiXhgK5KnrQ87hLVtDSPBf+ETh1A3+sL0L5N88hF
	6k7VPReEPSl2iv9fhTHlkW2uZG/6stREk/hVzO3p8KDsI3Pwv2tef0hll2Vrrcj/
	qoLnnVCnVxFsodid3cYFUM2HMyf5Jg6HB8jiF8ZpJ5Q2ROdCmNoMUZsU2XTyBPBv
	dnxbqGgM+Ituqj0qpMdya3nDx0M/T/VTxJA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1xmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so12255777a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781158964; x=1781763764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgAOGpY7wLkaVXAwVFjdCovl6zrwjlnMsBtovx7Wup4=;
        b=CNYGtDe9XSlVlnY88ziXh/YcwVSiXyKRtdhGIM78qHDw46DSCuU0CT7Zo+4rH7KsHO
         g9etKsVmP45mPjS/KiY3YR+pPpmv4Guqt9WcmpVpJh+v9SaZ7P7JZdwRsVEOnUsMpx3s
         JWum4JdVQUGLG/Ph9jhMlnq7y3LEd8jiFBr1MXsUirC1PO7yhcO0CFCWAtgyC/5lawAn
         p0c74Ft/8jx5YIQKOB6aRcJEztkBbP6D5RjvMas8hEs9EWJ34z6gAUHkjgn2SEeCdTEW
         3t0DJEhhrTRQiOyIqrMsIf+qAv5ZmhRe7MexEIpotVTny0PZYrUEWo2OfjB96CFchHcq
         rAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158964; x=1781763764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgAOGpY7wLkaVXAwVFjdCovl6zrwjlnMsBtovx7Wup4=;
        b=bT4o7xi2gjjnTKkCcqH739atPnpiykC2FwezCbCxmmxH8vDAOTaaeS7313GNuTHHif
         VH/WmNsBn2judHPTDrgZ+Fxrn7HX/fsFZngwH+CyEr7yiFXH5s9Bvq18DRCfFkWJHKDc
         u7E7xWWtx9xyRKf3LpJLItduAhgWvqI3qD7hIHftiOhvpdxs3bBgpmrAdNs7TisjetMB
         MtTByZym5prZZljMR8TPSsb8LC+EO/9zNpcdX8v324QBkXbxKgQ5cfd6QJMucPP59dJb
         zgFqzTsBzcFnDUqgbcRrwva7r+GW4v+PEocuuH9eB86GMjQF7b70XY2ceGMZ2x2UGs8u
         253A==
X-Forwarded-Encrypted: i=1; AFNElJ9fNbc29iLZvm3Q1ZkUUFBkQ0fJwUiRz+Al1Xua+t8f5HgANhCgwm99LHRT02EGHLK7s2o3MsjFCcyFH9FYLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Inn+1F8DIi3ac+sMK3yiZew2fr2azYWrNqwygrBtVmK7gQ3v
	RP56EUYLMLoB0nNn/u0nFkQPAQ9Kq3jHdcZ1GBK7P415mLiLgFYFO+0RIsWBYdNpgP901KB3ivA
	ga3AvW8I2FPs1ZbzdGOVuXGT3vhkSgAKjvazIsjToeCa4XAmTUuIMGMqHqx1bni7Us2lvxQ==
X-Gm-Gg: Acq92OGrumhax0FqGhS6LGj2clJDiuY+0MUEGUtZMvD8WTl1R0wNNfrkqqFltDW+D+s
	5aEX0KKS1GP8/9DI/ND3t2nlzI1KeKW7J/B/niM992TeE9+U8MTd/rjebCPPtSoBGLL+Ukjc6As
	tYhtWUR4NIt7Tp+RBUbzcqfv5vo7wSjlUbYIRlOFj167+fvp07l80fRbP4cuktcDaiGnNTIrBNa
	1FmX+ODp8vken9MuBsTRrOt2QHHdb4q6wHr5ZeLgLuqqJ1ZwOIhhLQOcYuuiMdbRNjFdCfyEPiD
	HaN0d928lEPo54opnqdR/6Eamin/wSmviRaCAN7vMiCaADVNFDEEBZeCWdnulnaTmdqx1HnWQKp
	UV0YwI2c2sZQ5191BkQUhkqrijsZWGuD22C+5rC0vtdT2mrAmv5BhbL8Y
X-Received: by 2002:a17:90b:4a52:b0:36d:63cb:cf63 with SMTP id 98e67ed59e1d1-377a8adc5afmr1683249a91.20.1781158964107;
        Wed, 10 Jun 2026 23:22:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4a52:b0:36d:63cb:cf63 with SMTP id 98e67ed59e1d1-377a8adc5afmr1683222a91.20.1781158963557;
        Wed, 10 Jun 2026 23:22:43 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752874fc3sm1247507a91.5.2026.06.10.23.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:22:42 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: veerendranath.jakkam@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v5 0/4] wifi: nl80211: introduce PROBE_PEER for AP and STA
Date: Thu, 11 Jun 2026 11:52:21 +0530
Message-Id: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a2a5435 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=R0NonwOPtRFAW2HdiO8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: YsbI57mdyPbFDJ4j0i06ZRHkiAQ5oQDg
X-Proofpoint-GUID: YsbI57mdyPbFDJ4j0i06ZRHkiAQ5oQDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfXyOO8NOza8ZkO
 E2T5NcWxagm8Ou+zYDynNpc+SIGHtVHmrmf/bsny3k5/UbEXexdhXaEwdv8mnyM4T2cZN1X/Oku
 2XYLC62Hd6i5VZv9rXb1yOPcw46vKHiyLDUybxgTu0V6MyV5tG3UvhaZIGKL81O3v4IcrCVqNIR
 B7VcTaBPczLPZEr42AmRElZ7RSuXOcpLygBDSMjsf2Rg3vYmC6wkhgYxAM38os+/u+YzBR/jRX3
 pbXxJHS+Me8F6y3gdw3hukAqOc281AgjAMbHYxtRU94qg5KLviRGnjDYYu8ZGrypDZTaUkKYU7+
 Jad5HpCzmvcFmvNsQAgZg9NUxvpYuD2QKiXu2FmaHUbSw5LyvtWr/Fmry6u50yJfmBxbcUixcub
 /lQs7XlZAIjGIjToo7GcV4o4tgD6dHdy54XrxPYgnl9Xh5MLSdcFkLUp3+WZ1BkTqoWMNa8MdQA
 dnY6DLGWdtKBrav/RIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfXx81atEl8wLDm
 ihkNu6MxI4kko6XVt+QLuZmD4u0+FXJCUy06QOWBwAPgGFErlBaengFr5g65PeoBni7//dEuqce
 pR1T639Fm97M0+nKP9N+ePeJYbDoUNk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110060
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
	TAGGED_FROM(0.00)[bounces-37653-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:veerendranath.jakkam@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 014DB66EFDD

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
Changes in v5:
  - Patch 3:
    * Renamed peer_addr to dst_addr for clarity.
    * Reworked ieee80211_probe_peer() to share more logic between
      AP and STA modes by using ieee80211_vif_type_p2p(),
      overriding the STA peer to the associated AP/GO address,
      and pulling the common sta lookup/qos handling out of the
      switch.
    * Kept the remaining AP/STA difference limited to the DS bits,
      while preserving the existing MLO/non-MLO address and band
      handling.

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
 .../wireless/virtual/mac80211_hwsim_main.c    |  43 ++++++-
 include/net/cfg80211.h                        |  18 +--
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  23 ++--
 net/mac80211/cfg.c                            | 117 +++++++++---------
 net/mac80211/status.c                         |   5 +-
 net/wireless/nl80211.c                        |  69 +++++++----
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/trace.h                          |   2 +-
 11 files changed, 187 insertions(+), 120 deletions(-)

-- 
2.34.1

