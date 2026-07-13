Return-Path: <linux-wireless+bounces-38946-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zsTmNNWUVGpInwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38946-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:33:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4B748301
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:33:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Z3yXckEx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ePBNFqYF;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38946-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38946-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05FCB30135D4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381D39022B;
	Mon, 13 Jul 2026 07:30:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4838E133
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927840; cv=none; b=SrYO0TTgRLme9kwKpGQbvoVXWlQWuKxiRg1VI66qCiYzNM2TIFcRVXfB5lz2tMxs7D001mH4Kfp/oO7Gi5XL1DQH7krJmaIU3/bOzLISkLnNxWRIkqh3ELqBOM7re5Wcg8fE1NJfjAUUkPD7BJSqw8ZXlGi/Dbp8YR2Uq7X8pMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927840; c=relaxed/simple;
	bh=Ou4xjKO29BEr84tp+hcSjLxPMBWoI8AasAo1v7PeQVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIVYS3qOy9DmuZdb8wmCWT8OHfZDSFRsmDTNfEtdYyO5e8PthasHoazfTrUthW7X5bSKyKSYSthWy5tdaIrIFkBR6JQePfQwTnGlVA5kZCPagG/W/vaejAcgXZRWpBqUsrTRCcL2y8+u5hi62GzDxbbbysDu8J/HGfUG4qMzJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3yXckEx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePBNFqYF; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nx5f674491
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lbntze55jigljzoUT73kZ+mmGEEM5eO3u1lu+cENJLU=; b=Z3yXckExHl7Blhag
	/e/bJSIi21EIaK1wvQfZS0DmM6kqTOuk4ktR5AtvMk3FPvEYwDJM87tiTELryVkJ
	TXimhEeCO61lW/gnOuQVVc7QD0XXTBzJb7zxDFhoZNIs28k/ILcyFNO9bhTUVDUw
	z43qTch+4BXD6kqo5G/fGI2jWfOWDFUpmkCg5Yyqj+IIraLXIxJciFxlROOUR73q
	qlG/EtKsEgBLRl3NkeK2OrGiEW2xpRVCKQP++61EnjM2GEGAMnhgNHK1wTro/Bct
	z/jHGCHlqMNnZRDRA6I6rKY2Q2wB4BU2zKN76F3eJ1RIQ4GVqalDpXJZ6eKh1qpe
	oK9WUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgn0g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca860baea9fso4333615a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927837; x=1784532637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbntze55jigljzoUT73kZ+mmGEEM5eO3u1lu+cENJLU=;
        b=ePBNFqYFmTAvt6E7otjXDlXlfRgac0lxzL9huliITwv+toc9ZUZyklWmIL9YpIHAEl
         X1bR+7JJAHa2HkSafutUm9byWB43GaaeV8tHuPZGEOTDeTVEQwMrmS5URyvnihIcvAET
         6QtQQDd5cgQl0I+cR/hzHYSl/IYWAvrsFRmoJw7WGYyDEW1asT0wr4Y3gPEzoPEUQV5D
         kdDLrqF37gZoTMfpehN1IRRIxU1XUGrky4yKlKPwB+f21ONfL97viR4RxD2FVC6RKkih
         XsdlauF3StQsJ8uCQ2zv1YitclrqMzzcjGZunf05scDV7I2r13cF4c6eSq2t4DqEE304
         E67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927837; x=1784532637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbntze55jigljzoUT73kZ+mmGEEM5eO3u1lu+cENJLU=;
        b=dmRxRafW9wXIA1XjyYNeqGcymK1FRseq8ER5jExU7TcjUpRybip55DpYsNcgGtHxTU
         omt6ZOlGvdVFKroRSvDfaOK6rxPUQqbRZMSxGKxrTA1oMbDIKBzmk4Ac2XtbbNqMcwcV
         jgGfrsHmkJ3n8TfUWdbAXGRFe227omUzEtHV188co7w/DwV9ypO4qMhELqO2V0TE6lJR
         EdpAVvzuo/z3nJpU2QJAM/M3THxZz3lKDGvu9D1zpZ4Ul2itl6szvjgyX4o1QWsKusOU
         v+7kU7j9lupUohgrjjSCad9NZLm5Qdl5xsRE8zlQefNYzISlUYp8XHG5ApCIZNRma8lV
         ZplQ==
X-Gm-Message-State: AOJu0YyXjJX0bUfqqo5tm2Kn+axbhpsDbC3bqySrVxhv+M0cFbixkMYY
	0sGRNpseRrIICxc3Zjotvd5p+jRxWVr3MSk01+zdfQcxEDL2CUS2p01P4dqPEmWVUE3dAQGjNpO
	J+dHM2rodGZ3PIq9bD0kKw9Wy1hndN+PMhHiyY1UBaYwMvmPttMS22b9JgwDcogWfJ7mGnQ==
X-Gm-Gg: AfdE7ckB8FJ2pXrk+vbMlRp9nYWRntey3hKCJC3bUmicOzmBplsaCS7mlfku56HwDEN
	XxVZDUu7EeS5ntdQNfq3Kr5C8tX1lB1+PW08fKFCyXfDcAW9ZDqe7QJM5gc0p5346qSVKNoCS2w
	BRJ/y6MUbCpK/mRFrrWErrMC1PArDoVO22XDdJVkijnQq2swF6l6AyZMi6feJHrRRHT+j2C5CgI
	xosW4Pdb+xkF1esry95uuj9lggIyfjpA9d2Eavn7AyA3Cvl9r/otYF7PyGBoBHb272k1xyU6NIg
	SdPz1K/fdZqqnPloyG0d0p6G2+eKt9lytA6n9HIm4TN9UlmGLHpkrrBxYq316bkr8LAH2i7fCcT
	Xb09Yn/cmeojy5KFc1DRicxs+IDRcF+cH4kSdNUQZ1BVTfCvWxMdvWkO9NOhUGAsJ
X-Received: by 2002:a05:6a21:1b81:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3c110009b82mr8842530637.12.1783927837209;
        Mon, 13 Jul 2026 00:30:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:1b81:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3c110009b82mr8842495637.12.1783927836680;
        Mon, 13 Jul 2026 00:30:36 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:35 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:29:55 +0800
Subject: [PATCH ath-current v6 3/8] wifi: ath12k: keep
 ATH12K_PEER_ML_ID_VALID set in ath12k_sta::ml_peer_id
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-3-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX/11UspIPmOIT
 NY5F00wq6GOVyZQ3BwtGrAKhBmr9ULx+AJegkMsxCUIIyQk3M3S97JOr1vjxDoKuaaTBkwIu9/W
 O4JzcNnNe449OmtBsJt9j4xA10efTXU=
X-Proofpoint-ORIG-GUID: Y_tkQIYCCFUWFx7OXUns2V55e_GuX-CF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX08ciWgAG91id
 ygutfOoeUhB7hbKIKXPac3EYedesK1swtLYxmpFS8lDXTamzdWwh0tjuypQZTZZ5E4dt9Be81c+
 h5loUS3SDErhjehssTwzxYmsx/ptUC66WOZ/RGVjdYAP9gDUYILGsawGlchcCgL4M6Q4wUnUt/h
 DYStFOKYKxHzFBs70BkLF663rs4PbrgGqkdv+AM+YIvS+0hUC1vvXZltcm7Exn55dAnqFXOTmJ/
 kqdv1feTje+jynDOlmeKxCU0B3RLOv638NCLFwQ3fy6BMWA5ZW043D03d2nWgOPQG+UnfPLGdqE
 mtcMdH3K7MJ7qKf+OxT4a5zx0b9ZwKVYLplHHq0f7atXFHSHQXFTmgYVZdHaVfeYyKU7JtjMLTB
 xQJz1ZqtMTZxV8yY0WbVpGIWA+ek7dpEMl/zeOyaPO/M2OcEmQmOzM51ZYNfwhgR42qz1l+M0vW
 ldFFxy2zL7W4a1PriKw==
X-Proofpoint-GUID: Y_tkQIYCCFUWFx7OXUns2V55e_GuX-CF
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a54941e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=MLhnoK1rgViGvFeMoKUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38946-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AF4B748301

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


