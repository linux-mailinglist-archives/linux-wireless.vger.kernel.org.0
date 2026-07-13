Return-Path: <linux-wireless+bounces-38954-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VFGwAP2UVGpdnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38954-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62879748324
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gM8xIqrP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=E02og7Ck;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38954-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38954-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EE213027D90
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646C39023F;
	Mon, 13 Jul 2026 07:33:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34938F94C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928026; cv=none; b=LupcZlO/iNS4S/nFmCAz9kLofx7lpasDXdBlHXUF+q96YRvo0VWryFNkc5CelA3YHyIF+McH+a2gu6M0ExpTz1gJN01l/wJ6b3bJTQgtj60/7PC1GhrOQ9QrTJ16BsauRupSxcjVNPYYIz8N55whBrobg/u8Lp+uFxAs+fN8MYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928026; c=relaxed/simple;
	bh=2o9y9Zi9OmwlQIIlWoLdNRV+GUZXbtrrxZklrrhkszo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J51yEfoWUGCzvuGL2d1kfuOPcwoyHbb6+0p3j8vmpP2szgUY1MKtAFXXOUM6QHWUp/1sUbLeoDwfZwGSEuzonEJnzb/kKdyHDEiKMASA5ILtKZy7S71V0v9rwVPxzOjZaeuCm6znPMFIiK9lDi+KYMjNNJuxRpD7Ggil6QdGGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gM8xIqrP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E02og7Ck; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NuiS568062
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRoN7bGojJCnIgc2vmQfLaoan0NtbsUh2lM4erLlpsk=; b=gM8xIqrPIVG1t/hy
	GZwNDiRtnaoEMu5dG9J4h1NTGjU1+2BmDNL9g6ZGrR985MMbm1KXJkbzJSXiVsmR
	+YKbALgbZocDKUtxdceayPth3yVtDCqHx9AGSIjs/PTBHsylDPzm9xwEHwSwjr4e
	KvF5gzf6oQ5S48Ba0Xol2hs6nrJwxoYcEGanipq6k9FSC9eInIHTOTq2W3cerPD6
	cHnDAXVNCf6zKFX+VKSvKxuFsKfb2OY0BDGCcVnjzC1d0qwwpcihrHqG+SFP2wXJ
	SMe16iLgOqaqXKaGNmHVfGL4DTT6lG+cnz2hFD1cXrfggQUmlxwG9YreIXsPUPuB
	5kc7ag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe91502u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso70390365ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928021; x=1784532821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRoN7bGojJCnIgc2vmQfLaoan0NtbsUh2lM4erLlpsk=;
        b=E02og7Cke1jTKHphBrq9OkmYNe9W6HPlWc/uSUZRYYpptDcdKHv2HQalqSOZV4gNZW
         aejm/EVpiFiPHoXRRFG9hJLrBP5ldM1qCj+P/Cqxl4nFJsV0hdwj8hELCW7e9N9xN59E
         5OpeIelABzyhVEwLFkwe/8c7TgAB97BPiGICWXHdzUo5EbCJMw/C4gDVCYSkUWFXyHb/
         mJ5x+2hCODOQfOGA1V0QWrjdFO0ixluP9TTpnbRv6AbzXD57k12m7i2x5u6cOH0h1baY
         LDBQ4S7xPeeXpifEHWn/01ECA7p6vMq6YrMpcD7OUZO0QrBiqqkuI3n3BisaBAyHMtU8
         9L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928021; x=1784532821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRoN7bGojJCnIgc2vmQfLaoan0NtbsUh2lM4erLlpsk=;
        b=B/2bMn5uzLKqkNMTZYHQj7owSdzUg7e9DyopmxwyMBsrm8Uuh42rq0xr1YRawC6pc2
         piOhPoMTpyGKu7PLK3OUg0fvB4O5rIUT6tGaNVQr2d8TAMWSTi+5YvWplFmJdgMElcHl
         7ZMGu7WVw5/BlEK0kGJDPbze033+x/r9wWxQ4wJdwg1uP+qlg9bhg36TH9odIhd5veFM
         A6PCuBDmqkZRJg7L9PIdqPu0VCgcrnCmcudJSLBi2ysNp9l77v0yNJbsY7fNUrqGBK9g
         S0XUMck7xvXnmneFL1hN/i9lUsx6hFWp05s07wAYt5vnS8HFKU1N577lt3jEWx+vzq2T
         94nw==
X-Gm-Message-State: AOJu0Yx9rrOm7fuAlmhQKwpnioL2tE7aO2daQXhvPyqJ+U2vBIww+WCY
	L0OcWpXrLBviZfI0iZNQLdQW1pU3/gRq2K5lOIWIlwiCdh38NODNlVaXisD4PP5wXT9E2cMyMcA
	Nuf3CFbwCxEkqyOtU7VOcqhadsZqj00HZHnMup/sUKSoIavSVBAgHulabJEAaTzsGC2/d4A==
X-Gm-Gg: AfdE7ckf02lxibSHyUqjUNJVcA5BnSbcUed3Ukwe88fgZBgnZQgqu+H1IWBMZeWN/Mc
	YLXB+SMfDQlwdw6Ztvavwe35xDbC0khNW6ee6+JPXVWbOrA6ohA6SLfiCmkyDiEzbb+JkL44IY/
	2ltm7v2W/nOKkdBKHea89510AOejwSewmOwsmpQSnUJppV8LLIEZQwi8IZujQh+FRL8eZG6LPOI
	qbG8J7NijL855uam4GomzQRtF/mZBhaW1j8qArcraUg0TJVH72CNP7J4izE6ArnLxfoKlPdK6tZ
	nwhfaKyNP/SJ9YEZekvfZRAcMd+YoeA9IfPHCYoSKovAdJT43jizo61hQgjwMtXYkMvW/aWeZRn
	RYr1jIkwp2Rf/wgtDNr3cYBjUXul++TKo75szU5rmCriuLPIIgddXTm8l91Ij3O/E
X-Received: by 2002:a17:902:cf43:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2ce9e7a5228mr75289705ad.10.1783928021247;
        Mon, 13 Jul 2026 00:33:41 -0700 (PDT)
X-Received: by 2002:a17:902:cf43:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2ce9e7a5228mr75289505ad.10.1783928020829;
        Mon, 13 Jul 2026 00:33:40 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:39 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:16 +0800
Subject: [PATCH ath-current 1/8] wifi: ath12k: fix out-of-bounds clear_bit
 in ath12k_mac_dp_peer_cleanup()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-1-d0a2a1a519eb@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a5494d6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IU88uQVEuTzBCV0X16QA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfXxPsbhY24Y9Yv
 r6/R4mlmRL1uOxKyvb/SrpVlFG3/7fvD7QLgPBTrG21XsiSnICdPrQlz1ABHhgpl/6HBgkYDiKM
 jY2e23Ap8NyIT9d3qtVOs0bAlEAeabE=
X-Proofpoint-GUID: Gds4kXxfMYWw2EGljfu59L9g71A4NKMC
X-Proofpoint-ORIG-GUID: Gds4kXxfMYWw2EGljfu59L9g71A4NKMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX0SZLmDm6leJw
 RSxWuT2Ekl1XRoHTfBY3AeSsgkg4QrZJW51MHGXudB9lXUIL921gmKKYp49ftmfd/2mAZoGsa0d
 42wZv/YEboOFwt4jmCtVZrZiAd/NjV8VtopSNjGyfNXv+/encCTIYrQhdwXEB9xPGa8olbopzmk
 3kfbReKUJWKsGIYSxI7LMvnOyaed6qi3JIsCws0KalOgKOjm84U3/PXN0WEub/eE4btlvyDdXnK
 vo+AQAye0ZJBMFqLU4o8PYfoWEaVZNg4pxfn482vAJE5jSH4Fk8ePRpZHcM4NGNki1dl8DuRRey
 j947Rustg5242nLypWEhr7+yTddNgkpC/44Dx7Hkn+CLU8lmdYuHBqyu8lougtzoaQvIdCa3E6l
 QL++wCL8DKGkxDmTw5Eg1WDP3+YfgEWBrBWu6wu8H9qkm36/wjArWPbfTgaRIJIvFLAZ846Jy7K
 fuaN2gZPVUSG2DRlWWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38954-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62879748324

ath12k_mac_dp_peer_cleanup() clears the ML peer ID slot on the
free_ml_peer_id_map bitmap by indexing it with dp_peer->peer_id. That is
wrong: dp_peer->peer_id for an MLO peer always carries the
ATH12K_PEER_ML_ID_VALID bit (BIT(13)), so clear_bit() is invoked with
index >= 0x2000, which is far outside the bitmap of ATH12K_MAX_MLO_PEERS
(256) bits and corrupts memory adjacent to ah->free_ml_peer_id_map. The
intended bitmap entry also never gets cleared, so subsequent
ath12k_peer_ml_alloc() calls eventually run out of IDs.

The ID without the VALID bit is what ath12k_peer_ml_alloc() returned and
is stored in ahsta->ml_peer_id. Use that instead.

While there, also reset ahsta->ml_peer_id to ATH12K_MLO_PEER_ID_INVALID so
the bitmap and ahsta->ml_peer_id stay in sync;

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: ee16dcf573d5 ("wifi: ath12k: Define ath12k_dp_peer structure & APIs for create & delete")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 490c134c1f29..b7eba8ea981b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1283,8 +1283,11 @@ void ath12k_mac_dp_peer_cleanup(struct ath12k_hw *ah)
 	spin_lock_bh(&dp_hw->peer_lock);
 	list_for_each_entry_safe(dp_peer, tmp, &dp_hw->dp_peers_list, list) {
 		if (dp_peer->is_mlo) {
+			struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(dp_peer->sta);
+
 			rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], NULL);
-			clear_bit(dp_peer->peer_id, ah->free_ml_peer_id_map);
+			clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
+			ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
 		}
 
 		list_move(&dp_peer->list, &peers);

-- 
2.25.1


