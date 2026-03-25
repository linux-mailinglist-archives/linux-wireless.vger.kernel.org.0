Return-Path: <linux-wireless+bounces-33799-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YiKNHvxQw2mIqAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33799-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 04:05:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3B031F06F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 04:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A461303F077
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3D927A907;
	Wed, 25 Mar 2026 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0gTCp+q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M/zVVHBa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538421DED40
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407929; cv=none; b=qypeOQFOwWfztgiiWVajpDwmJYxNE7EUfSVD8CZ9TDUgfV7L2TISm09Gpz9BFy1q7MWUMLlLsJRYKlcq62ZypJsa9Roxv5bWIUvALo7uBTPezXLz1q+uSJg276ostwTKqRekPG1YWUfJC3C/Nh7ucc0RUQHO06NvKivolHeHC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407929; c=relaxed/simple;
	bh=YUvvtomTAMs9FxLE71mmCXUTtFeHxCZNjgbOUSf9bLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ayLkkn4RChHybsPK13TVpTLNs0Plxpel/SpPErniK++zyC652BnlX/XSpHHDS1I0TOTfhaGO3D8xQGNLpHBxGp0bUF48aqp7WWIRGexWQehUMHN1AURM0hav9kDUtxH1/WENkj7riSYcTqoPPBYGPT7Gka3UZADcHiLn7gT8ycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0gTCp+q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M/zVVHBa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJnivt2075395
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 03:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1LqtPzEsZq4zTBIrXT1uhH
	HxBuczbVUwyFrJqfNmekA=; b=b0gTCp+qo/01NeFai6RI6lRl7kPQ+Vlw6cqMai
	tQDoToah7v8RCFWLgK2mCAqKs9XIEP71Jbk6LApvX17j8iP4Xsy5gxxab6DDyy2v
	mqZuyXNAoZqoK3NOKmrF+XfHVNlHSD0+LpGZih6NKvVE8gdG1aObOlqi58ef6jU5
	HIseZu3nAZGxHF7x1ype5J+kc2iI8ooracaVH8uSvjU1ffV+u1qPDLGEkrTk/vW9
	pCJFoctzl8tgKt9s6gVHtnx1ihqTy1yH3TpKLF67pVlm4e/AboRopb6MANnvxjta
	tzyWJ8bcFfAd23mtkZQSwrGKpxBLeyzaYPqDQQGhfUI4ampA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d414115xt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 03:05:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aecbb78e44so267430605ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 20:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774407927; x=1775012727; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LqtPzEsZq4zTBIrXT1uhHHxBuczbVUwyFrJqfNmekA=;
        b=M/zVVHBaTmIGDUQ5xZ6NstzrBi+G6vkJv/v5O08JntJE0O73rtod6IVBrRbgmmwE52
         s5tPfoupqaAz72Lig4EXUFYZBG/B8K/0FlqpxSWIKgVebKivABtNXcXEsRd8imf8pq4w
         9k3fqCkkb0RQkJkMTPvvdFY0OGivY1y6TJU0ehlRu+8IjR7cK2soqLCPEtZBnbTgpsFF
         xAEswvRNRG+orUb3H2tggqHMTsXt0lFulFscaI6Wp9K6jr+e1k7RxhDXGOTh96/wA8oH
         sUQpkW/ZGXCKDt5zVClI/9/76gUqVkb8paYhvQB+fVqQTtepXS87A4m4qOiCd+c5yaKm
         Ub0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774407927; x=1775012727;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LqtPzEsZq4zTBIrXT1uhHHxBuczbVUwyFrJqfNmekA=;
        b=guhd9YQFqscyRA7XOM81OAdN7c+ZIBemXIYCv5i/64Ywtrk3NVyMKlfqd0Qfs9M+45
         nMii0uWhWNBCg8ZqHcM5o6hedH/u24j5GN5+EfdISWouVkW6aaXINxXpy7W1Uf/POv+y
         i0yUZsPD69WjclVYZ2Bguyf1ki0NUG52ft1kXcz7un0WB6yML2U2/HMMsnpOX9lNAM3E
         iucAZaVyKi/pyRr/opOFqdFQluIzXJNtwziuEqkoRHwN7yeAZTlrZkQX2+DpGd0SWq4y
         bTbmTBLOTDVo/v8D8h8E+Lx9dtrsX2z2Xdvyg6W46cXxLcwLHazkRqOrmAZ6FLye6/F+
         ay6w==
X-Gm-Message-State: AOJu0Yx8E71zN3rpk7zVAgWaqRoedcRxIPNL+AAwfmOciGIhn4YS6al3
	1fYq+aga9xOoKLEx3MkwHcqd0p+Xy4KSZD+DPP2ONE6ip1VbLPgN4iwgatUVypcBwy8j23kwhVS
	kKUkee/8Vj7q/VFOYXQmoe4pyfG5Pg2RnCyqRANjS2IQkPx/VJepCQ6dZ8OcmxELE52tX0g==
X-Gm-Gg: ATEYQzz5X9yjlfaqPyDvjLT/7A4z6jxN5POsF9IuQqRf6vWsU76CGudKc4C74T5Mc2p
	P9ifJul8oyZ/1Rku/m6G24NANkoc8+EWbFEcf35r4Cxp+jeBTScRjjgV40D5JTbW3yLVE5m2tfe
	FtLA6550sEAS3cPZH0XJAj9xTJNvdZPgOryV8yoGIHVrnFs/g8MTvLJeITww6aRbL6nIx1xe0i9
	yBfyDdDUQcU8Sipz4sV1Q57O4rug5thcK77Dx53CBWX3iCNVUkJdpNeuAG9abtthu+niRyZDAq2
	6O8pRpybZ21mZMT9nw5k9tb8hPFFOEw5+mHsUSDBp4HtG4dzWDlrHhqRcj7miWCim58qLr9AMqf
	w6rauiIO05z4FXFpdEtd7RJODyDq2rXCaYwWs3lrJJoWAl5FEpOHm9+S3Q8asI+gN0qxYIb87oh
	I=
X-Received: by 2002:a17:903:1987:b0:2b0:686a:d470 with SMTP id d9443c01a7336-2b0b0a61c80mr21672475ad.23.1774407926626;
        Tue, 24 Mar 2026 20:05:26 -0700 (PDT)
X-Received: by 2002:a17:903:1987:b0:2b0:686a:d470 with SMTP id d9443c01a7336-2b0b0a61c80mr21672215ad.23.1774407926120;
        Tue, 24 Mar 2026 20:05:26 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08369617dsm207422605ad.71.2026.03.24.20.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 20:05:25 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:05:01 +0800
Subject: [PATCH ath-current] wifi: ath10k: fix station lookup failure
 during disconnect
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANxQw2kC/x2M0QrCMAwAf2Xk2UBa3RB/RXyoa+bCRjvSVoSxf
 zfs8eDudiiswgUe3Q7KXymSk4G7dDDOIX0YJRqDJz/Q1fcY6uxowVJDNRXXnJe24RRkbcr45lu
 MA9+dIwJ7bMqT/M7/EyzFsalyqvA6jj/omSiofAAAAA==
X-Change-ID: 20260325-ath10k-station-lookup-failure-be4dd6e81100
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        pmenzel@molgen.mpg.de, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=fOk0HJae c=1 sm=1 tr=0 ts=69c350f7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g3NtLbrsMQ1ddaa6N0AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 0SzJtDth2VV1BRkOZYHB6E8IoXsKYdIx
X-Proofpoint-ORIG-GUID: 0SzJtDth2VV1BRkOZYHB6E8IoXsKYdIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMCBTYWx0ZWRfX+Kf1x6LRzjVs
 WcgMVWgokJzkCxvYaN8XvC8WCFx9NjZ9bnehH8dv3rChKRD9x1dK0NencqwWdXKZi5zMIZYM561
 rrJdXbNlugxeReqst85EepclvznoTniWhm5Zld6bUWFtb4Fr+gG2BsMCp911RqmXwoP5ePKXR8h
 E4H8XFTRHHryy6zngLA6zMqzF4TILp/SsSvYWhcktgKCxjTH4AzEO3hIqPxtvEZ/hwTaUabXmb0
 165SX8ZpoinEMDQaLWRycXKaLXt7DmEu5mXxA8fSypRAhnvrbPmrnWsCWVwdPr7VhKXGSxu7LEg
 9FVibr8DAb0yS2C2yOuB3fNCmi1ykUU8bSFmAmrCtivY15x6vzMv3O9gTxnxC3SvpLviXtKU/ED
 GZqOKoqiBqYM+rMSKyTKt/bBkn26pfkeDVI6YmNeQWknjMCFA8NUDhoJ5x8q4xKhCtTSEJN4zJP
 Qe3kPA3gYAz5Og662Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250020
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33799-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF3B031F06F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Recent commit [1] moved station statistics collection to an earlier stage
of the disconnect flow. With this change in place, ath10k fails to resolve
the station entry when handling a peer stats event triggered during
disconnect, resulting in log messages such as:

wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by local choice (Reason: 3=DEAUTH_LEAVING)
ath10k_pci 0000:3a:00.0: not found station for peer stats
ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22

The failure occurs because ath10k relies on ieee80211_find_sta_by_ifaddr()
for station lookup. That function uses local->sta_hash, but by the time
the peer stats request is triggered during disconnect, mac80211 has
already removed the station from that hash table, leading to lookup
failure.

Before commit [1], this issue was not visible because the transition from
IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST prevented ath10k from sending
a peer stats request at all: ath10k_mac_sta_get_peer_stats_info() would
fail early to find the peer and skip requesting statistics.

Fix this by switching the lookup path to ath10k_peer_find(), which queries
ath10k's internal peer table. At the point where the firmware emits the
peer stats event, the peer entry is still present in the driver's list,
ensuring lookup succeeds.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1

Fixes: a203dbeeca15 ("wifi: mac80211: collect station statistics earlier when disconnect") # [1]
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/ath10k/57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index ec8e91707f84..01f2d1fa9d7d 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include "core.h"
 #include "debug.h"
@@ -14,6 +14,7 @@
 #include "wmi-tlv.h"
 #include "p2p.h"
 #include "testmode.h"
+#include "txrx.h"
 #include <linux/bitfield.h>
 
 /***************/
@@ -224,8 +225,9 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16
 						const void *ptr, void *data)
 {
 	const struct wmi_tlv_peer_stats_info *stat = ptr;
-	struct ieee80211_sta *sta;
+	u32 vdev_id = *(u32 *)data;
 	struct ath10k_sta *arsta;
+	struct ath10k_peer *peer;
 
 	if (tag != WMI_TLV_TAG_STRUCT_PEER_STATS_INFO)
 		return -EPROTO;
@@ -241,20 +243,20 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16
 		   __le32_to_cpu(stat->last_tx_rate_code),
 		   __le32_to_cpu(stat->last_tx_bitrate_kbps));
 
-	rcu_read_lock();
-	sta = ieee80211_find_sta_by_ifaddr(ar->hw, stat->peer_macaddr.addr, NULL);
-	if (!sta) {
-		rcu_read_unlock();
-		ath10k_warn(ar, "not found station for peer stats\n");
+	guard(spinlock_bh)(&ar->data_lock);
+
+	peer = ath10k_peer_find(ar, vdev_id, stat->peer_macaddr.addr);
+	if (!peer || !peer->sta) {
+		ath10k_warn(ar, "not found %s with vdev id %u mac addr %pM for peer stats\n",
+			    peer ? "sta" : "peer", vdev_id, stat->peer_macaddr.addr);
 		return -EINVAL;
 	}
 
-	arsta = (struct ath10k_sta *)sta->drv_priv;
+	arsta = (struct ath10k_sta *)peer->sta->drv_priv;
 	arsta->rx_rate_code = __le32_to_cpu(stat->last_rx_rate_code);
 	arsta->rx_bitrate_kbps = __le32_to_cpu(stat->last_rx_bitrate_kbps);
 	arsta->tx_rate_code = __le32_to_cpu(stat->last_tx_rate_code);
 	arsta->tx_bitrate_kbps = __le32_to_cpu(stat->last_tx_bitrate_kbps);
-	rcu_read_unlock();
 
 	return 0;
 }
@@ -266,6 +268,7 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
 	const struct wmi_tlv_peer_stats_info_ev *ev;
 	const void *data;
 	u32 num_peer_stats;
+	u32 vdev_id;
 	int ret;
 
 	tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
@@ -284,15 +287,16 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
 	}
 
 	num_peer_stats = __le32_to_cpu(ev->num_peers);
+	vdev_id = __le32_to_cpu(ev->vdev_id);
 
 	ath10k_dbg(ar, ATH10K_DBG_WMI,
 		   "wmi tlv peer stats info update peer vdev id %d peers %i more data %d\n",
-		   __le32_to_cpu(ev->vdev_id),
+		   vdev_id,
 		   num_peer_stats,
 		   __le32_to_cpu(ev->more_data));
 
 	ret = ath10k_wmi_tlv_iter(ar, data, ath10k_wmi_tlv_len(data),
-				  ath10k_wmi_tlv_parse_peer_stats_info, NULL);
+				  ath10k_wmi_tlv_parse_peer_stats_info, &vdev_id);
 	if (ret)
 		ath10k_warn(ar, "failed to parse stats info tlv: %d\n", ret);
 

---
base-commit: 4242625f272974dd1947f73b10d884eab3b277cd
change-id: 20260325-ath10k-station-lookup-failure-be4dd6e81100

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


