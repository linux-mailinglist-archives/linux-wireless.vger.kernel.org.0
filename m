Return-Path: <linux-wireless+bounces-38951-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id psUqKwiVVGpgnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38951-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C53748332
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pdu5msKI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dUNGd1TF;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38951-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38951-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 347FD302EF83
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2FE35837E;
	Mon, 13 Jul 2026 07:30:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10238F947
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927857; cv=none; b=Zk3jZqJ3AiOccqtCRzn2nbsPdftx76R/Y5Cqq9LGYYAFElVeLvuXlf4zJCh74GYbbcaZElhv4/grpkPiNbvbRg2syhBCMRu3V5XSUiwWkzIzxodJsMgGI7pUptRG61MgTmJTaeEZFwPEFaciUCCrHAe0W5p84tyLOuDw2Ffp2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927857; c=relaxed/simple;
	bh=hudn57kNM0RRBwEgbOs5Zj9bzO6RmmJ/IkpwwKg3238=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCCgMkFi2s2J2RdyvA9voGPyDI+8l8pwnPTxJnX+o/mgDda7xSj4lkvrS5eFn8omRQ+KnQYyL2runaHcalZL5HiTi++WliIpfQAJ6HuDFk/vrAIQYqVHqXt5Dwjw1M/jk21vIh6yWUJ2vWpIJrt0Lo/l4mhoQSDRVebw0tJn5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pdu5msKI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dUNGd1TF; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Ng8r731641
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NDBEu+jlNx39n24MqQgds1XZP2kLksTv74p2DeHkGi0=; b=pdu5msKIZonlP3Oj
	VGbGQSqY9YaM3x9WkE/tFdWkWZifkS84XIj9ZUSxvaY+9+iOfaX6zXhOSnObsQZq
	e9xPt67ZeSLRKVCoAfsq3W5iI/WMPAAR9mNX/NIjWHxv5ZcFhI4dleTxgqzJRm5P
	RgH59l7Cpoepsn6WJWrzP+VVvEtVBHjlzR+iU37QVZaQQLu+LAHs14ZURdjzYvdu
	E0iF1l87oSb5oxn3h9u/pznf1hg06gAMmaC/NPEpfMvdJOWxBrM3FY7dk9qe3hHV
	U/fDbf4wIE17ucDZM9hyvJk9iLYqmmRLmnzMhQF7+6u6nVW0LtaD2teprNPJnmUI
	ncZo0g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn39d6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab041eced3so2624000a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927854; x=1784532654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDBEu+jlNx39n24MqQgds1XZP2kLksTv74p2DeHkGi0=;
        b=dUNGd1TF3f8phNo+Kdo7+w/GsMhArgg9/rTKn3xggVoIStJ+mKJppGBT43zHgFm0Kx
         kXhgvoOj++4mQVX+v2WREub5IWsCRy8Gto3ieLpEAyvn68v/SaHq+lg7+Js9xYVjCwKD
         0roBZJIOLNayjkSFh8CPwl/rpO3PpssyZRMXGiAnfrc5jorHPkAapGZyCd9KYmVZae0b
         5ThYR8apspXlTs/+trRGQTtAY8fwJF5Z0+8S7r0ve9xwnLZjYaLngrNaZVwdszGPsKlj
         xiErYUx0/Zmn1BoUXJww3JE/dDyZ4/HIfR4MCrLrKhfU4ey2Q1Zf3KyaSP2h16k4qs93
         wsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927854; x=1784532654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDBEu+jlNx39n24MqQgds1XZP2kLksTv74p2DeHkGi0=;
        b=XTeumrySzxrNyluLuP/ownJ5IBCifKywvxjpzDduo/cDBP9FnGcJESUb4SOHOeQ4Eu
         ilXSE0uPbGx1uRHMFUnDW4EYqy6vKU9zQIieFAM0+8ShUqmKZA1w8PoQwJZiCO7ASb/2
         z763WLQPzSLlwF8Y25BuGFhTkBKgdcybt5uPel/DFGld+xCg6mt0H4suxZt71hC2cAHd
         PICvrVRER4b8js97jyYvuxB2Ub37+YwaSzQERnb1y6uzofkU2yhiUfP0Lt6EmD9DXiaG
         qGQ3tQA2oFPGw1QCrdTw737+whJd5gihWqUYvOXFFXNljou09d40LDwvC+/mLhTQz0Xk
         mwaQ==
X-Gm-Message-State: AOJu0YyYHYYmiEybWIel8sFaqmIdReJjqA2lO0AYg0v5TL+bx2rCqfYE
	oKTu79JrBiWCFjQ4aD7kwa0+ZKPZlUrvUpO3aIG5wPvqjrp6xz5oO3ajyIwbY3vCPp1VNcTE0N8
	m3uKDQZiJf+wssITxbJlcLYHeDf6WwmZDEhV3Bi8/YlZWGSBpww6OS85WxCRGmukDTkqeZA==
X-Gm-Gg: AfdE7cmDAXBiLsv8hKMJN+bDModA8T1hq95MtxfKJb36R0/EAUMezcbZ7pcoF089uJo
	URcCgWcJLxGGcQwefVtqpV1uCSn93kqcm8uObliCau03QxmTvyQYrNmm6W72oH6MqKaw21uKIkb
	FwIgvbNZEO4TY2q6zaHMEmwUqX49jShqXvQF/c8VlkStvtkVfAlw9MG1ALZ0PMmg93CRKmjqEVV
	lU6TPTKAe+unw81m9/PYcwnqL35dS7KOA2vIuYdFk7T8Aw1LKjB1HW8IqWfe6S9/kk6OWPE3RSf
	kQnvKEWxeXPKrQw+3r5yNrlJ+sh+PIlz2BGGJ+Hlkq2ulWNuGI2hgCKv5zCzBmRhGFYe48JSf4Y
	CVNcI7JebyJ+7c1VxPre4fFNLVtE6Z2CS4rvbLqCKkDYytrLKWP6C5K/FVKjbKUur
X-Received: by 2002:a05:6a21:48d:b0:3c1:744:a584 with SMTP id adf61e73a8af0-3c1108b601dmr8730040637.19.1783927854205;
        Mon, 13 Jul 2026 00:30:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:48d:b0:3c1:744:a584 with SMTP id adf61e73a8af0-3c1108b601dmr8730003637.19.1783927853727;
        Mon, 13 Jul 2026 00:30:53 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:51 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:30:00 +0800
Subject: [PATCH ath-current v6 8/8] wifi: ath12k: resolve PENDING ML peer
 ID from MLO_PEER_MAP HTT event
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-8-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX2YGFIdN2lc5d
 SAXa67WlGrJkUOJgyWKRhsXNaxiDP6Uk36VvdYUAh37/95aLgw2XbqC9pfManO7TXbYtFsnA8H6
 48s3zutBuf6eJEE2n48p5ieMzGTeioXdHtziDRHP/jGdyFcef51PnuyisirpL3rm1e/+nUWJ1fI
 tUs7hUyBHI1w07RqO5nw7W3Ojd2T7UmxhWjlWkulusiZG5t4a0ZxpvC44oTIAwU7Iv7Mh54k/nF
 xb+ORsJlahKGMUuw1Sqse57AubIq7FEzLUygAalWUaLOACQ5L8r399+jHoSDbYkGot3HA2FabmT
 PP2W1mHMQUUI/4SdRtKBXtkZJkP4S/WYA3M6l1UF3Q9qSj+2B/VuKLRw6OiQXvauu7hKUbSq9Jm
 ot+PnAXCKFmIZV/JMhJQU7MhJbdn2HdT7cG4zP34QBGgIrpmocoa5Xk5qOnzEihk3t73drqjZyk
 TTxMpMUYqSkUlccxGPg==
X-Proofpoint-ORIG-GUID: JbwHhoBoFqmTy55BTICJRihwCNzYSXVz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX4NvdRgHKVWfo
 kgcCDXa8F6sIXmWCb/bUaJMX+at5lPe/H7pcX7MeH3UltPbfGCLbEEVkxjY1VF7kmiS6EqcGmZ5
 pYBMa54YddGeij2Tpcm5o/PWCS55c84=
X-Proofpoint-GUID: JbwHhoBoFqmTy55BTICJRihwCNzYSXVz
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54942e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TDBLFCPSxtiKLUTLmbQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38951-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0C53748332

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


