Return-Path: <linux-wireless+bounces-38961-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u3XzKDmWVGqznwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38961-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:39:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC44474843D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:39:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JyVT3Fuc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hQilOnkB;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38961-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38961-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CC7D3066C62
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408A365A0B;
	Mon, 13 Jul 2026 07:34:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756A38F63D
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928039; cv=none; b=LQQTSFp3GDSA2qdsD6vw+Q/n33fr1LYYJGMf7tEWZwpE47Agq6d1rBLgvHcCKpRkQgIKR+SCfMqHvZieETQgURCegcdDlmPbYJK8+KOUkQQSXbdimN/ffY6j7TUNPWFiJZdTvmr1OkB+s0C6Pgx5bGhbmipM3N4PmToawHUhnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928039; c=relaxed/simple;
	bh=hudn57kNM0RRBwEgbOs5Zj9bzO6RmmJ/IkpwwKg3238=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATnevUL9DWeZnc29IaSsUr8OLuR631yusjcHIYHS9Mae4vHcAVT2tyCDakWrvUsKpOrcQ8VJds8o5KtwF04nwRHbfBXqwmSuARh57vpLFeRGvMLB4GB0VTHQQxIpMQISq26dJ+C2TJFnMrQ03n8osxHV3X+l13pDrB5+FB5qwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JyVT3Fuc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQilOnkB; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Npti732266
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NDBEu+jlNx39n24MqQgds1XZP2kLksTv74p2DeHkGi0=; b=JyVT3FucjLSxjxlx
	SIAakNN258cSe7YF3xe7UU0hGu118MbUrMhygOVOX1RQ+v/LBLhSr3x2vrfiWdgB
	n4iMcpo6E+xJtz6ELJIBRU2403VDbtxDs7YoX8xR9mmXtPvtkUqpPL/PuBMQ06yX
	IzbRBYUgKMcZrmXhePw2dQL44ZMKEFaJnpkPoEfV8vXCJ+MICWP98Y5U+tqwUihe
	4vZ5PiXYj9ENcHwe3I5SPVhOUIGpzrRIgjC+ni4C6qcXSMd1hP+/PtOxw19w/3eT
	gr9o3MwGDAgjIL3iwUqfURJwQIuVISWrH79mNZr6v+fWKPmyhb+NW9FyrFEiaTQ7
	6LGCGg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn39dsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so57920405ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928037; x=1784532837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDBEu+jlNx39n24MqQgds1XZP2kLksTv74p2DeHkGi0=;
        b=hQilOnkB5xR48IOmhpLkaBvbFe2DnsVD/PBKSiz7U3t5wUB+Ui7782aV5tLNBnaEsB
         Rbwz/1h6o/vhphpgn4kjl6G68fV9rkJgHUrVLrAfzUDlRl2+ZnV038xaYiFKZlulLlpB
         jc+/+0vsG6x5nY1PRQH/uUFUVRnRa+j9XAXxDrbyuUCBMhBwMB0o38AFJAOLZjCfpy2g
         0uT0wC/OpbogsvOFG+oEClFwRm4vxfLbagBdDhMv7bw5dOLCNHsJnNg1huhTZoHCe361
         4zp6cR5+qm7Pwy8CqHbXejPdO8QPZxllKkePXhco7mmnHoxCQuBYfR8OMxgTbWKC/rz8
         UKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928037; x=1784532837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDBEu+jlNx39n24MqQgds1XZP2kLksTv74p2DeHkGi0=;
        b=di8gGAcfylTW282IE0uBWnO+FKc8vK8b+58XbwyyGNYbcw1xO+W9muaPKc1ktg7FQo
         1IHkYwn9nAcZAspz7itegp3lyJei/AAr7sP5YMIo5ejBXVX+TuWWCWfgr0oX7dlfqpMC
         AAngE17AQssiaTlLVZYeH5dG3951dMgltzfhC0apRk3gZ1qk55gAItexhdlWf0LLXOgv
         IgfDSs6CXnWbi4VBzUh658ZrPWAiUAsJz7T2eZlY43b1tmkJhSIL1C2UzJEm+jojZXkK
         ZKk/Iep+eeklO5RETp2z/xYfeSnsaxuBiOk+AQdhfgAYgqG0QuwbeD139YRnDDC4Od6G
         TGZg==
X-Gm-Message-State: AOJu0Yzl5BCkMaKIUUeab65RFkHNQkx3TjPwbVamtKgMwbQmRuUPtSIX
	TL5DUZFYQc4XN/XRc7QwiC4PJpevervbaR0VPkS2wQGO7Y37SyNVXIgWLeeeU1TL6Geh0U722Gs
	Cdb9x9zbbdF093Ik2DNC5sKHCiHulhycvUfydrrhGYDDAY/ooDylFDOtyzzB9qGNL5j1XBA==
X-Gm-Gg: AfdE7ckd7g3IaHvCzhqsXmGSPzmikCqUz5RFzuW10zWexy+IMdEUQymEXqgO4usyttt
	tC+a+yBt8fYl5ojb6OKcuajKMW9Tw1aMoZU+P3rwb6eIJygxsQDvsL0VCo3tJSKZWE0wn0DQmCi
	HAJ17UCxG6NiRyaEeQETOm+fQAgCLoc7P7BiIhyKmS3p/QaZFKijB+u9/vNfxzxf8x6T/fA3Ax7
	rfIPEq0PYC5/pqk/2EPHqjn94MVlC9Q16KmAsSUkKmDUAR7YqkNMfDxD0+xy4bAFh2FjfvWKngp
	6+Y6jrTgNEqRS/NZjvZQrfAVZbauR4gyBlXc0m6gJsdSi5v5yhu8RpSK3uzRiEX8YLkeOQa1bbT
	LEfV2fZiQcFoFGwAT+nbvHaP6PfHP2jhlDNmiO+93lYhtfl/8vrKb0G62Zz3/KhnK
X-Received: by 2002:a17:902:f68b:b0:2cc:7c36:2c23 with SMTP id d9443c01a7336-2ce9f178346mr71019455ad.43.1783928036920;
        Mon, 13 Jul 2026 00:33:56 -0700 (PDT)
X-Received: by 2002:a17:902:f68b:b0:2cc:7c36:2c23 with SMTP id d9443c01a7336-2ce9f178346mr71019285ad.43.1783928036366;
        Mon, 13 Jul 2026 00:33:56 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:55 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:23 +0800
Subject: [PATCH ath-current 8/8] wifi: ath12k: resolve PENDING ML peer ID
 from MLO_PEER_MAP HTT event
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-8-d0a2a1a519eb@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfXy2y5h/0TskZv
 J3XkqbZqrYegsVLJblz8iwLnox+mxC9rVul9LsmUticaxk/Ko7XAWrQXfYP8um8cKDvU5g+dROn
 oaZkotpJmTJSGqD7amDINoX3/GeRegKuooNu93Ur8TiI16XeI3cNzVTjUPGJlFe60BV42u+xRB3
 G35sZUEX1199kTzOU8WD8JqGxUi2PnYvsmUByRbs+yWHvvWQPSRYQmHMxrzg4WNcUXijcT1VEp7
 5ajDXh1FEngfE+3nPWUYL3syEpmYmqd2n4dBc1iNZ+FCb/1SNwoghYohyHOP796qv0+oMzELrcO
 6RygEmCO80jlkzHQXMmI7Jx7sgp5+9asqJfnO6NuSEwBpsrhrjPqYLNXkfs9JFAo8w+nrXXZkjY
 3j7pfgylNLrgvmF+eQEoAEuyrn5Yft8VkkiKFZ3m7uwaq3vUxbmW1plp1OnyB1e85CO9tu0SthG
 F4QMsGvAK6gzIEyWkjA==
X-Proofpoint-ORIG-GUID: vk4AQouL3snci4Cf8iIxhK1g8WZAjfAf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX0NehOMVol8d+
 q9LUqZR8cAkUKlw3zQnjaF9PFFk/4DL9eul6xYaox21yTikXcnuav5vGLnmmUywgq4nynPazHXq
 5kPDRSg98hI1JBMXbHmNClc+blGVnEE=
X-Proofpoint-GUID: vk4AQouL3snci4Cf8iIxhK1g8WZAjfAf
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a5494e5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TDBLFCPSxtiKLUTLmbQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38961-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC44474843D

Add ath12k_dp_peer_fixup_peer_id() and call it from the
HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP handler. For devices where the
firmware allocates the MLD peer ID, this is the point at which
all data structures that were left with ATH12K_MLO_PEER_ID_PENDING
or ATH12K_MLO_PEER_ID_INVALID get their real ID:

  - dp_peer->peer_id is updated and the dp_peer is published into
    dp_hw->dp_peers[];
  - every existing dp_link_peer in dp_peer->link_peers[] gets its
    ml_id set to the same value;
  - ahsta->ml_peer_id is updated to the same value so peer_assoc,
    sta_state and cleanup paths see a consistent ID.

Devices with host_alloc_ml_id == true also receive the same HTT
event, but the firmware-reported ID always matches the
host-allocated one and everything has already been populated by
ath12k_dp_peer_create(); Skips the helper entirely on those devices.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221039
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c    |  2 ++
 drivers/net/wireless/ath/ath12k/core.h    |  1 +
 drivers/net/wireless/ath/ath12k/dp_htt.c  | 19 +++++++++++
 drivers/net/wireless/ath/ath12k/dp_peer.c | 52 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_peer.h |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c     | 24 ++++++++++++++
 6 files changed, 100 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0e7c732f8222..cf9c5b068fa6 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1547,6 +1547,8 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		}
 
 		wiphy_unlock(ah->hw->wiphy);
+
+		complete(&ah->peer_ml_id_done);
 	}
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8769b41f5db5..30726e580833 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -795,6 +795,7 @@ struct ath12k_hw {
 	bool regd_updated;
 	bool use_6ghz_regd;
 	bool host_alloc_ml_id;
+	struct completion peer_ml_id_done;
 
 	u8 num_radio;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 150b190f9c7f..68968f96b4f1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -6,6 +6,7 @@
 
 #include "core.h"
 #include "peer.h"
+#include "dp_peer.h"
 #include "htc.h"
 #include "dp_htt.h"
 #include "debugfs_htt_stats.h"
@@ -582,6 +583,7 @@ static void ath12k_dp_htt_mlo_peer_map_handler(struct ath12k_base *ab,
 	struct htt_t2h_mlo_peer_map_event *ev = &resp->mlo_peer_map_ev;
 	u16 raw_peer_id, peer_id, addr_h16;
 	u8 peer_addr[ETH_ALEN];
+	int ret;
 
 	if (skb->len < sizeof(*ev)) {
 		ath12k_warn(ab, "unexpected htt mlo peer map event len %u\n",
@@ -600,6 +602,23 @@ static void ath12k_dp_htt_mlo_peer_map_handler(struct ath12k_base *ab,
 
 	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt mlo peer map peer %pM id %u\n",
 		   peer_addr, peer_id);
+
+	/*
+	 * Fix up the dp_peer entry created with ATH12K_MLO_PEER_ID_PENDING
+	 * earlier; on chips with host_alloc_ml_id == false this is the only
+	 * point at which the host learns the firmware-assigned ID. Chips
+	 * that allocate the ID on the host also receive this event but the
+	 * firmware-reported ID matches the host-allocated one, so there is
+	 * nothing to fix up.
+	 */
+	if (!ab->hw_params->host_alloc_ml_id) {
+		ret = ath12k_dp_peer_fixup_peer_id(ab, peer_addr,
+						   peer_id);
+		if (ret)
+			ath12k_warn(ab,
+				    "failed to fix up peer id %u for dp peer %pM: %d\n",
+				    peer_id, peer_addr, ret);
+	}
 }
 
 void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 2a2eae194007..09142dcb74f9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -695,3 +695,55 @@ void ath12k_dp_link_peer_reset_rx_stats(struct ath12k_dp *dp, const u8 *addr)
 	if (rx_stats)
 		memset(rx_stats, 0, sizeof(*rx_stats));
 }
+
+int ath12k_dp_peer_fixup_peer_id(struct ath12k_base *ab,
+				 const u8 *peer_addr, u16 peer_id)
+{
+	struct ath12k_dp_link_peer *link_peer;
+	struct ath12k_dp_peer *dp_peer = NULL;
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_dp_hw *dp_hw = NULL;
+	struct ath12k_hw *ah;
+	int i;
+
+	if (peer_id >= (ATH12K_PEER_ML_ID_VALID | ATH12K_MAX_MLO_PEERS))
+		return -EINVAL;
+
+	for (i = 0; i < ag->num_hw; i++) {
+		ah = ag->ah[i];
+		if (!ah)
+			continue;
+
+		spin_lock_bh(&ah->dp_hw.peer_lock);
+		dp_peer = ath12k_dp_peer_find_by_addr(&ah->dp_hw,
+						      (u8 *)peer_addr);
+		if (dp_peer) {
+			dp_hw = &ah->dp_hw;
+			break;
+		}
+		spin_unlock_bh(&ah->dp_hw.peer_lock);
+	}
+
+	if (!dp_peer)
+		return -ENOENT;
+
+	/* dp_hw->peer_lock is held */
+
+	dp_peer->peer_id = peer_id;
+	rcu_assign_pointer(dp_hw->dp_peers[peer_id], dp_peer);
+
+	for (i = 0; i < ATH12K_NUM_MAX_LINKS; i++) {
+		link_peer = rcu_dereference_protected(dp_peer->link_peers[i],
+						      lockdep_is_held(&dp_hw->peer_lock));
+		if (link_peer)
+			link_peer->ml_id = peer_id;
+	}
+
+	ath12k_sta_to_ahsta(dp_peer->sta)->ml_peer_id = peer_id;
+
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+	complete(&ah->peer_ml_id_done);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index f5067e66f1e1..9842671b5475 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -180,4 +180,6 @@ struct ath12k_dp_peer *ath12k_dp_peer_find_by_peerid(struct ath12k_pdev_dp *dp_p
 struct ath12k_dp_link_peer *
 ath12k_dp_link_peer_find_by_peerid(struct ath12k_pdev_dp *dp_pdev, u16 peer_id);
 void ath12k_dp_link_peer_free(struct ath12k_dp_link_peer *peer);
+int ath12k_dp_peer_fixup_peer_id(struct ath12k_base *ab, const u8 *peer_addr,
+				 u16 peer_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 818eb3aa919e..ae874114dc51 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3855,9 +3855,11 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 static int ath12k_mac_peer_assoc(struct ath12k *ar,
 				 struct ath12k_wmi_peer_assoc_arg *peer_arg)
 {
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	int ret;
 
 	reinit_completion(&ar->peer_assoc_done);
+	reinit_completion(&ah->peer_ml_id_done);
 
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 	if (ret) {
@@ -3872,6 +3874,27 @@ static int ath12k_mac_peer_assoc(struct ath12k *ar,
 		return -ETIMEDOUT;
 	}
 
+	/*
+	 * For devices where the firmware allocates the MLD peer ID, the host
+	 * learns the real ID only from the MLO_RX_PEER_MAP HTT event, which is
+	 * handled in a softirq (BH workqueue) context that cannot take the
+	 * wiphy lock. Block here, while still holding the wiphy lock, until
+	 * that event has fixed up the ID. This serialises the fixup against
+	 * all other wiphy-locked ml_peer_id accesses.
+	 *
+	 * The firmware sends the event only once, in response to the assoc-link
+	 * peer assoc, so block only for that link.
+	 */
+	if (!ah->host_alloc_ml_id &&
+	    peer_arg->is_assoc &&
+	    peer_arg->ml.enabled &&
+	    peer_arg->ml.assoc_link &&
+	    !wait_for_completion_timeout(&ah->peer_ml_id_done, 1 * HZ)) {
+		ath12k_warn(ar->ab, "failed to get MLO peer map event for %pM vdev %i\n",
+			    peer_arg->peer_mac, peer_arg->vdev_id);
+		return -ETIMEDOUT;
+	}
+
 	return 0;
 }
 
@@ -15332,6 +15355,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
 	ah->num_radio = num_pdev_map;
 
 	mutex_init(&ah->hw_mutex);
+	init_completion(&ah->peer_ml_id_done);
 
 	spin_lock_init(&ah->dp_hw.peer_lock);
 	INIT_LIST_HEAD(&ah->dp_hw.dp_peers_list);

-- 
2.25.1


