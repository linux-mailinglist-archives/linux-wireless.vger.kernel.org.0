Return-Path: <linux-wireless+bounces-38956-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YFlqJmaVVGpvnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38956-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:36:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A45748372
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:36:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CENFKJ41;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Z+26Arzm;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38956-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38956-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C0DF300F248
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACCB38F629;
	Mon, 13 Jul 2026 07:33:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CB38F62A
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928030; cv=none; b=YQE6rhI5xiAviXB/Ze8oJWpC1HuclB21hrdSSYj/dVBH9LDg9fqdhY5U9cfMd7yW6qz/7qM0wjufka25o270YKlvi3BPj0LOug8D6GN3xKCJd+EtnC0+fehGwl6rWEvVZ11FGXly1GWtDhaNsvtpPKBKGVgByreGNvxKIXqn+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928030; c=relaxed/simple;
	bh=Ou4xjKO29BEr84tp+hcSjLxPMBWoI8AasAo1v7PeQVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6Z/t2KlUL7FVEdI8LNCRIEFkkKBu3EK+r7hr9D/CL6qL/t+YlfKcl9a2TcsFt+Xe9DfjJuwW9N7crefb+aeQsbx25EJRlb+QYY1y9B1tnqFWdUK2P7diQU63Oke3z2+qan8o4pxW2s4gnqDgqY4VIqKBihEINsSlz6ivMH+k8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CENFKJ41; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z+26Arzm; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nnib469617
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lbntze55jigljzoUT73kZ+mmGEEM5eO3u1lu+cENJLU=; b=CENFKJ41nlah8lln
	OoZAFKAkIY0mwSuikKUrqvnnD/hSLjbFQ3yGfkxHQH8MO84qv66viNuxcnbpqVEw
	YX+RqbInX+Y7SMwFtuw2fSK9Tix+Coq7pH0EPj90VxZUh1NOztD7qpZBgGAIgPwX
	tPwIVgnMEFk+WNeBMriFZlH5Rhsy0/uf6I1eGsjfg/iexOFaMQb8eCi59LSrPu6r
	XnXI5dwAn6F94OOTjQBYAKG9LOPE8PH2ZWhe+FybEAimRgq4IVxUc8sVr5ZtLqra
	rYC+U5epz6vUwoAxcf4+rYCON59Wil0ns7d4r8li2WuOiydZ3nUlQ5bSFSobifdc
	63kh8A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf484y9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso51140845ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928026; x=1784532826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbntze55jigljzoUT73kZ+mmGEEM5eO3u1lu+cENJLU=;
        b=Z+26ArzmIIqGyJOD7EGmjSAoPYB413kzaRGbiq2+vAcx+UIaztmJ1jYy0L4khtkB+H
         UOBP/Czchl2EyflZJS34KaE6q6zrpPeFKWT9KIUOLwV8wsTCZJA0TmXgcQwu30j2SPWw
         tQ1ijnlKZQFdcQUF+Ig3UbJSlchzA0bQyORotsOamLzecVdSAUWlnuO6nyJv51t4b+iv
         Gych+cX9zhyCHvd7AT9ebEvyEoevRCUy9xDB/PCN2g1sdZnvV7MVXQ5q/eMOKV2JKtTP
         szWjLgYvt5Z2hfMMrdeHqsbTYCUJKhAfWkSzIGo+8U+8Vh6XJLlDAVFsw051/wx6Laky
         GDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928026; x=1784532826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbntze55jigljzoUT73kZ+mmGEEM5eO3u1lu+cENJLU=;
        b=ji7NGBQktTO5oStjA39UoKLpPejvNF2CxWFZPSmw9BtBXh5aHq0iuvkvTCpu0SnkS7
         kwVrCJPfMGxVxJqrAluc1lpxbv1WUIXJQ0CAFIRJ21RuvH7x2BHzPfpVcQXMNzBXFSPR
         DhPD5g/Q3qVwhRsnfnSdtr83uvCfc70f5QIXYQVzYErow4jpqI2O1ZT1mIoCWAaJKSdH
         ibbRjlddXCYwqyrVofn76kcJpZrmcIF8comhiesVcx+W6031PEN6sS2OHllI8qKC+v6t
         80FsSiT8f97PVnxI+G7E8WJCMlDKCPwFFzy4LvjQToBAI7vhA8Ad7NS3RPgs6Vx+22Pq
         briA==
X-Gm-Message-State: AOJu0Yyisu8Wb1ym0qk05Z36JIDpZvQgT0L3LMhRpedmWZeJRNexb5bz
	3kzOvCzrOFP7n30GD91WpLqnH9Z917Hhf5v/z386gfZaXN+/rk8qtJYJmTmjHfNdHZzM1yDC1fN
	buoBTQO3d66NTVJQ/GhQC61r6PwU8+owi0vrKIhWaGIjIV0Q4GvOBmvsEuna5fmGNnXMknPAfuk
	xdK7qy
X-Gm-Gg: AfdE7ckjQujrTrPorsnarmr7LnRbDZB6Tk5N3Hhxww0qtVVGaS5X9pT4U73jBe9p7tQ
	gqD5kXonchcwOzCz6Cl8wTeZmhaLi7Zc85+rECKR1VjXS669aOLfuW7OKoK2pTUOhwj0eGN1fHT
	duEFLIyy2Yx29mE+JQamQ2qmRczWwzzCI3oIrabVNc4XHnVUMK28fdanq18AVySFtmEcE2IAZVi
	zsVsk2rwkdvg1hlspjkSh5/vook0Z47vT1EK/OuOt+/L03Hpw2jukKuDnjV+lb8srN7CrYCHLP4
	YaRKgKFHP01rGr8IXzBz9Cyv2o0M19Sl7H4F3RJibchfCj2rRkX2TrqKzcYdqJ6yXdc/Gkw0EsD
	h5qiNqUDXhI0w31WANe8Tamkc7zJm5v2SXWPhYDPsKAnwpfAAHh26Asp/F6nWH9jn
X-Received: by 2002:a17:902:f641:b0:2ca:4b7a:4a02 with SMTP id d9443c01a7336-2ce9f2876ddmr76988965ad.43.1783928026315;
        Mon, 13 Jul 2026 00:33:46 -0700 (PDT)
X-Received: by 2002:a17:902:f641:b0:2ca:4b7a:4a02 with SMTP id d9443c01a7336-2ce9f2876ddmr76988725ad.43.1783928025830;
        Mon, 13 Jul 2026 00:33:45 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:45 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:18 +0800
Subject: [PATCH ath-current 3/8] wifi: ath12k: keep ATH12K_PEER_ML_ID_VALID
 set in ath12k_sta::ml_peer_id
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-3-d0a2a1a519eb@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX1Go4aZ/IZdlg
 h4ho18UNNQViNyXuH+bosgCDKaq2B6+wxs1xCIhfrAfpW/P248OqFXPVVHP54rw2jVnwSkpim1S
 2+PIzkQtZTDuPAZYCvH0IC2+R6DYSDQ=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a5494da cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MLhnoK1rgViGvFeMoKUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfXwiwxc1LIzh8h
 lfjdHbkYC4Yi0Xu2V/Cub5vN5XVBBSE54d7TcrlzDWQwhT+DrB9hTzugO3jFOFCZ062Iep9mpDs
 akS5ceKx0wxcCjbsg5RDsWvn0RBQI2PhubrnrQuynO6pax6etbjH+N2l6OJGV/wgHpO+yvfgRbK
 gm4os/xiO6TEFmpWGqHRgfBQdLXiFyrPj+Wp4hVBaSXSXIr6Z9RF8xAKlyISToVkKYqBoDxNCwx
 BSHXlFPZtKf+KisDHzxYYvzNcyhppLUkC1DdcTkTeP/cZux9AF6xDE5NOs51RQ101FYaaXaDMm3
 RoiVCEntfVZOG9Gq3fesZD+r3MfEZjHzSl3471peWcb3GXnCHQWQ1/XMa77jMz4rHjT2YP8ECCm
 0gCuRL1qAvejifW2Xc5xTuLDI9u/7kOFplYLeC2E7oLj9+H3/KkReubEonDwwA8CvKc14iOf/4V
 SAQflEkq1ol834Q6Wfw==
X-Proofpoint-GUID: x_ehBNKqgazCgHAWd0fwyGJStkZ1DgvY
X-Proofpoint-ORIG-GUID: x_ehBNKqgazCgHAWd0fwyGJStkZ1DgvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130077
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
	TAGGED_FROM(0.00)[bounces-38956-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 68A45748372

Several pieces of host bookkeeping for MLD peer IDs encode the
same fact in different ways:

  - ath12k_sta::ml_peer_id stores the raw ID in [0, ATH12K_MAX_MLO_PEERS);
  - ath12k_dp_peer::peer_id, ath12k_dp_link_peer::ml_id and the index used
    on ath12k_dp_hw::dp_peers[] always carry the ATH12K_PEER_ML_ID_VALID
    bit (BIT(13)) when the ID is real;
  - WMI_MLO_PEER_ASSOC_PARAMS::ml_peer_id sent down to firmware is
    raw, without the bookkeeping bit.

The mismatch leaks into call sites that have to remember to OR
the bit in (ath12k_peer_create(), ath12k_mac_op_sta_state()) or
remember not to (ath12k_peer_assoc_h_mlo()).

Make ath12k_sta::ml_peer_id carry the VALID bit when valid, the same
way ath12k_dp_peer::peer_id and ath12k_dp_link_peer::ml_id do:

  - ath12k_peer_ml_alloc() OR-s the bit in once on the way out;
    the internal bitmap stays raw [0, ATH12K_MAX_MLO_PEERS);
  - ath12k_peer_create() and ath12k_mac_op_sta_state() drop the
    explicit OR;
  - ath12k_peer_assoc_h_mlo() masks the bit off when populating
    the WMI ml_peer_id;

While there, introduce ath12k_peer_ml_free() to mirror
ath12k_peer_ml_alloc(), which helps avoid code duplication.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c  | 27 +++++++++++++--------------
 drivers/net/wireless/ath/ath12k/peer.c | 17 ++++++++++++++---
 drivers/net/wireless/ath/ath12k/peer.h |  1 +
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3e3b06e15f80..7d0d7d5fbf53 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1278,16 +1278,15 @@ void ath12k_mac_dp_peer_cleanup(struct ath12k_hw *ah)
 	struct ath12k_dp_peer *dp_peer, *tmp;
 	struct ath12k_dp_hw *dp_hw = &ah->dp_hw;
 
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
 	INIT_LIST_HEAD(&peers);
 
 	spin_lock_bh(&dp_hw->peer_lock);
 	list_for_each_entry_safe(dp_peer, tmp, &dp_hw->dp_peers_list, list) {
 		if (dp_peer->is_mlo) {
-			struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(dp_peer->sta);
-
 			rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], NULL);
-			clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
-			ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
+			ath12k_peer_ml_free(ah, ath12k_sta_to_ahsta(dp_peer->sta));
 		}
 
 		list_move(&dp_peer->list, &peers);
@@ -3547,7 +3546,11 @@ static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
 
 	ether_addr_copy(ml->mld_addr, sta->addr);
 	ml->logical_link_idx = arsta->link_idx;
-	ml->ml_peer_id = ahsta->ml_peer_id;
+	/*
+	 * WMI_MLO_PEER_ASSOC_PARAMS expects the raw ML peer ID without
+	 * the host-side ATH12K_PEER_ML_ID_VALID bookkeeping bit.
+	 */
+	ml->ml_peer_id = ahsta->ml_peer_id & ~ATH12K_PEER_ML_ID_VALID;
 	ml->ieee_link_id = arsta->link_id;
 	ml->num_partner_links = 0;
 	ml->eml_cap = sta->eml_cap;
@@ -7264,10 +7267,8 @@ static void ath12k_mac_ml_station_remove(struct ath12k_vif *ahvif,
 		ath12k_mac_free_unassign_link_sta(ah, ahsta, link_id);
 	}
 
-	if (sta->mlo) {
-		clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
-		ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
-	}
+	if (sta->mlo)
+		ath12k_peer_ml_free(ah, ahsta);
 }
 
 static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
@@ -7739,7 +7740,7 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 			}
 
 			dp_params.is_mlo = true;
-			dp_params.peer_id = ahsta->ml_peer_id | ATH12K_PEER_ML_ID_VALID;
+			dp_params.peer_id = ahsta->ml_peer_id;
 		}
 
 		dp_params.sta = sta;
@@ -7876,10 +7877,8 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 peer_delete:
 	ath12k_dp_peer_delete(&ah->dp_hw, sta->addr, sta);
 ml_peer_id_clear:
-	if (sta->mlo) {
-		clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
-		ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
-	}
+	if (sta->mlo)
+		ath12k_peer_ml_free(ah, ahsta);
 exit:
 	/* update the state if everything went well */
 	if (!ret)
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index c222bdaa333c..ae93731b4177 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -230,7 +230,7 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		/* Fill ML info into created peer */
 		if (sta->mlo) {
 			ml_peer_id = ahsta->ml_peer_id;
-			peer->ml_id = ml_peer_id | ATH12K_PEER_ML_ID_VALID;
+			peer->ml_id = ml_peer_id;
 			ether_addr_copy(peer->ml_addr, sta->addr);
 
 			/* the assoc link is considered primary for now */
@@ -276,9 +276,20 @@ u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah)
 	}
 
 	if (ml_peer_id == ATH12K_MAX_MLO_PEERS)
-		ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
+		return ATH12K_MLO_PEER_ID_INVALID;
 
-	return ml_peer_id;
+	return ml_peer_id | ATH12K_PEER_ML_ID_VALID;
+}
+
+void ath12k_peer_ml_free(struct ath12k_hw *ah, struct ath12k_sta *ahsta)
+{
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (ahsta->ml_peer_id <
+	    (ATH12K_MAX_MLO_PEERS | ATH12K_PEER_ML_ID_VALID))
+		clear_bit(ahsta->ml_peer_id & ~ATH12K_PEER_ML_ID_VALID,
+			  ah->free_ml_peer_id_map);
+	ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
 }
 
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta)
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 49d89796bc46..0f7f25b8e89c 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -26,4 +26,5 @@ int ath12k_link_sta_rhash_add(struct ath12k_base *ab, struct ath12k_link_sta *ar
 struct ath12k_link_sta *ath12k_link_sta_find_by_addr(struct ath12k_base *ab,
 						     const u8 *addr);
 u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah);
+void ath12k_peer_ml_free(struct ath12k_hw *ah, struct ath12k_sta *ahsta);
 #endif /* _PEER_H_ */

-- 
2.25.1


