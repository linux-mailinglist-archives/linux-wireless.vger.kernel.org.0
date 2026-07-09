Return-Path: <linux-wireless+bounces-38819-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ODgHD1uJT2pgjAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38819-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:43:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5E730850
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:43:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nRMxdgCh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DzE6YLi5;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38819-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38819-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1716930015B4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C2404BC2;
	Thu,  9 Jul 2026 11:42:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1933F44CB
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 11:42:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597375; cv=none; b=c6Vik2zQjCoDe6UNqjRmIjk1w5++T2JVUbXirzCTPfWWgyzyZtjqiryricc+Of0QSjL34VFMQJ9IGVWoumKwwSwRkhh+xbK8z80aKBmkN7heRJyuXAqlW0QJdcS9LpPXUWH6kw6t3aMZ9Ft04uWHxbpiTEWdUwtGtn31yaGebUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597375; c=relaxed/simple;
	bh=QtEESnB+7PF3OmY+yROXo9LRoczPIev7WpO0fY+EKDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r7dbHPWP8L7BXu7LOxWiym0JXc7tJEqXDh7t0Zmg3J07AX/A+EPvBFq7wnD3TB9MNABvxZNrOsGovRO/binQQr0Plw90DEs0XffywIMa/PIo22Bmh7k7wikBKC7UR8u6sGiE0tKJGZzYONZUl9Yk+QRJTT0I2il5FyM8khwMgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nRMxdgCh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzE6YLi5; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNNei1667697
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jul 2026 11:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GWzAlHF/nMoKB+7qHlNtLW
	AtVHlFXp8YpjqPsRuAlUM=; b=nRMxdgChcz1NVEGtRFZ3udgo0adLSPabtY1L2K
	26Ng33t6Jl0vq/+a/cR4lVq6u8kZdeyucsFgqLRGd7XKOczQOSeT3VViyEVhB1y6
	Uw6PR5HRkFx5EJA/xpha6AFtpM4j9A1rQNXxGGGkEmLvhPEUUt0ex2CrNMnLwD6Y
	Rb6RCfmlfGJi+AzU4vUoXl/6JWBTm9YWriNmYwFnSsBwSSKwM1Rpz3wn8ncVh9nb
	v4P9cczdhKe9ZsxgBpIYpGNVnR18X/ZfxLJCQnrKp3t9WaN3OuOCGYbLpze3goi2
	hV/lUj53lWFKTvlpfgfi0E9q95Yx6Y9clclxD+2EB8uo6YRQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6kgtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 11:42:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37e5ef8299fso2070260a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783597371; x=1784202171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWzAlHF/nMoKB+7qHlNtLWAtVHlFXp8YpjqPsRuAlUM=;
        b=DzE6YLi57fd08ujg3md49MVr8y2qBbFxH5sehl+jYv9oXGuhUdy8e+rCqYCGLSvrkq
         lW2VvGWPmCy57LbyO6OPtI+rfCP72AH/+hhJ2IFWr3dcB7fmi7EwZ1G6hnyi7z8qSXBY
         dwVi0wICYGF6fyNwMRIXaarzCu72Ux2f/NF+5zYx+/Z41KnyvZk47jjbUHAOT0q3n55/
         aiwly+50yx/AzqcXwLsqK8nZdH4r0wMlouPlzOk93lWa86/e+PyCkvjoCbAkCz88SvJK
         Z33aETNJiTJSOFwf+vEvwUHusaVSI5sxrPC+5eTNbHOkoZ2Dum604Zpk8bajz0IEgfqR
         vNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783597371; x=1784202171;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWzAlHF/nMoKB+7qHlNtLWAtVHlFXp8YpjqPsRuAlUM=;
        b=O/pi1f209wpCnsAp5vgcaw9bhPudeUe8edc9sOMJ+hRyAj1+YWlZp7+JdwoBE+IsiD
         pYIuWjkwFaIzW8CQ5oJAYD434NYronc6r9q3d1OeTDiMAw2J/t623wRKV0SfUiH6Fsud
         4SqzrcrwCiq1ZY7Oma9vUqxsYUve6nmJCklcdChu8/MynZmVj4Rh1FzqIIitFH+wr/dd
         gJ0pZnt+Prim7cBbJmj9JhSenhbJZ5oWo8SRI6fUABpaEWjxkpMq8ev02ESQbJPh0989
         tobgHzmvtYl8iAPK9lPSoQkDEdHubOMprIuVGM8CpCgD0PAaChgDVr68SM9wLcNoROSd
         jkBQ==
X-Gm-Message-State: AOJu0YzTvquDEQsX6fmS21Wgjk+ifLbigN7RXEinp9i+DU9BRFXeRjfJ
	zt4XbgA1svjbmjD33bpd41BWawHQnlXrDnYbQjayMBSyOh9fT18KYiBZBZr05/7jjwK4VnSCI2l
	9iCgC3Y91cLmeq6Vlhh4vZPtTaodWr0jyauqy10QPPn9dXGbefNihsGr0OJJFtXkvGhjQHw==
X-Gm-Gg: AfdE7cnguwnXgBPV0HxHNpJIFqSCnYXbcGlVGeQ3AfD/walhVNGUv6hqz3DPepIlO1G
	B79Aq1Kp5zVX3DVRW+Qz8PWlU0otXs+64C/Rd4rjwzsqhRQuYibXG/bPX4dcVX8yD2uPvf8Dag9
	LcCcOAM2Wgw7IjYNYGSY7P8uLo6LCrNA+tE163m9AGkRTAH+tBNSs/AZsfMu0gGW3RVGeXfWI5t
	4DcwgY9iGHVnohsoxQ5OdHM6khwGCj519/6JRVuNeqERFZ065ydA+jDp6cknmYYM/FUsDv57Ivn
	YQieUyJqOXwU3193H8aG6n+W3RAvRo7RK515WjP1FzgghWtsyCTFWuDDAKKK8F6qFF+Holju/tm
	rbSs1fJahK6R8IrbITCfEfgR1IaRs+ss2Glw=
X-Received: by 2002:a05:6a20:a124:b0:3c0:9c1a:8947 with SMTP id adf61e73a8af0-3c0bd257a74mr8893883637.63.1783597370666;
        Thu, 09 Jul 2026 04:42:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:a124:b0:3c0:9c1a:8947 with SMTP id adf61e73a8af0-3c0bd257a74mr8893838637.63.1783597370020;
        Thu, 09 Jul 2026 04:42:50 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6594f9a0sm31772753c88.4.2026.07.09.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:42:48 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v6 0/4] wifi: nl80211: introduce PROBE_PEER for AP and STA
Date: Thu,  9 Jul 2026 17:12:26 +0530
Message-Id: <20260709114228.672317-1-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDExNCBTYWx0ZWRfXwNuY7Y34qO+o
 N9gWONuCyiTvKPK1RbaOekI0UcLUBB6SgIvH3Aeo/wP0VViGztCtOcXFYT7vQnl8bKzKuwZ/Qfp
 jVHBbRF3kma1GyjuI2+kO6yww+eQ84Y=
X-Proofpoint-GUID: emucJZ6g_0mItoORERpuij03kqIBv8-9
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f893b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=X4KHw_DkP3j3RvtXBt4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: emucJZ6g_0mItoORERpuij03kqIBv8-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDExNCBTYWx0ZWRfX26B/m364CxjT
 anc/Qgj4UOmM0to0jAtnajzOAE4+7y9HvFHtOMg0tAcIXYIpzYAnS70w2bmTJGqNINEuL7ofBwm
 nWb5e4tpFlpt43qXPTFZL4xdm92YbnypNejlhJvKF52rrweR1wPiLSchtYOcH96GzYNNR5f9nu1
 J3SQ1qa2KmOnyz+AyTRgxFo2KVbzeg/EZpivGRbg/iEA29Ojp67bei7X3rpvWxA64vzzbzBG5eE
 5/LlgsSefVUPaNlNWme7iLSIey6bZvGCVzG7FIc1jO81GLpnlE7nGt/Zzp/D5vnPR4+FPshQy9J
 MToUwW9R8TwtYxrWcK+FU6VsYrSW84qedv2nPiSPeDdpAG85WE61aPOztxueUKDdxJsOZ7tNMUQ
 TqgoLiuOAn/CY5fzK8hOvvJdblIA+BfTnpfY+VFWkCbHtN8xTTS+7s6BCPqFGkuGaRJAdLBwNhN
 B5+PWIvyF7v3a4OnJLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090114
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38819-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qti.qualcomm.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33D5E730850

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
band information. The link_valid/link_id bitfields added to
ieee80211_tx_info.status are filled by the driver in the TX status
callback and read back in ieee80211_report_ack_skb() to report the
actual link_id to userspace. AP/GO behaviour is unchanged.

Patch 4 makes mac80211_hwsim populate link_valid/link_id in TX status
for both the direct TX status path and the wmediumd/netlink TX status
path.

---
Changes in v6:
  - Patch 3:
    * Dropped the remaining rcu_read_lock()/rcu_read_unlock() — the
      function now runs entirely under wiphy_lock, so sta_info_get_bss()
      is called without an explicit RCU lock and goto unlock is replaced
      with direct return statements.
    * Restructured the MLD branch: flipped the condition to
      fromds && !sta->sta.mlo for the AP-mode non-MLO client case,
      making the STA/MLO path the default else branch.
    * Added src_addr variable to unify address construction, replacing
      the conditional memcpy blocks.
    * Used skb_put_zero() to zero-initialise the frame, removing manual
      field zeroing (duration_id, seq_ctrl).
    * Simplified frame control and addr3 construction into single
      expressions.
    * Removed the pre-setting of info->status.link_valid/link_id in
      ieee80211_probe_peer() before TX — status fields must be filled
      by the driver in the TX status callback, not by the caller.
      ieee80211_report_ack_skb() reads link_valid/link_id from the
      driver-filled TX status to report the actual link_id to userspace.

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
 .../wireless/virtual/mac80211_hwsim_main.c    |  43 +++++-
 include/net/cfg80211.h                        |  18 +--
 include/net/mac80211.h                        |   7 +-
 include/uapi/linux/nl80211.h                  |  23 ++--
 net/mac80211/cfg.c                            | 123 +++++++++---------
 net/mac80211/status.c                         |   5 +-
 net/wireless/nl80211.c                        |  69 ++++++----
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/trace.h                          |   2 +-
 11 files changed, 194 insertions(+), 124 deletions(-)

-- 
2.34.1

