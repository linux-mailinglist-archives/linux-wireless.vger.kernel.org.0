Return-Path: <linux-wireless+bounces-37859-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d453GtVpMmqVzgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37859-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:33:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D9697F5A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:33:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=V7kXOq+a;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AO+Jc5w4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37859-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37859-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE6530C642A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6CA39EB47;
	Wed, 17 Jun 2026 09:28:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6639732C
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688528; cv=none; b=aoVIUbDIKzhCVyEqrXHGz0NQ+OZXFxNIouXUj3eOnvIjsm8JquCrew+HfHbOMUVqRkYmSsxw2jd8VlC/acZY5Ap3CJO6JV6J6zTXEfN7ocYZkyDaCnngM3q7oino4aTKMR7QjZ6KtfcA4PdiW8lK+5wytf1V9rf3DQXGpiQ7s8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688528; c=relaxed/simple;
	bh=T5896CDaNf0F6QyF5124nkh4/1XVbrwwwE/bLuH8Leo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gg1u3UJuJJpGgSvHsrb2FAgfz6qM9PFsQOEHUoaAly7tK7bNGscMs2cBwjrc+HR+UH1Gc1NVhhkMwIC8FYmRhgh2HtP5UegrYkoFdID9EDEprPmCZHPAbsWAP1mgSuYgeozIwPU1wWPPiNMMgnnsDFU3tDDLPz/xTdSibSOt8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V7kXOq+a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AO+Jc5w4; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8VtkI2192068
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YmgotrVByV7ndgg+t5wTgSkSWrKs9Rj+oRvM7lmSuPY=; b=V7kXOq+afa9OPpPl
	OMB8urvLQc8e/DBWGWyBlzWZCWgY03SrnvCLyvgxfrtFMSPj1PHO66NeUYbSxD0N
	c9hkg5uID2s8a5FXFITe4t6teTGcu2jfNuRjAidY/R3tdIrscGFovb39npa0ug07
	/J2PwJj4iIVuRF1LbGqWpu9vLf3YfeG9iUZMO1CRdsk1q6jrvEMe7UCDC625KOyO
	wYYYdXuSdEKialLWfeQI9nEJPitf8sNVJZhRI6kyPhP8HQQOCL19Du+x8zLoIhw+
	tX9O4mysXJiCXLO4vmPZDHRg4YS1lquYD9zG/WL/o4FXadfsJHF3ZYSFF6vFqJcs
	7WaRvA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesjf1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6cf1126cbso876765ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781688525; x=1782293325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmgotrVByV7ndgg+t5wTgSkSWrKs9Rj+oRvM7lmSuPY=;
        b=AO+Jc5w4XZgyr0cW/D1zcnx92CjYM6ejwAksVF/JsNLR3hgahBZNG2eS+zhLexeIh7
         cudaDJHWG0i4dBu/rNY4kGWfi4AkZmo6DMV/9sMXq0oil/5XVTdnf+K2sg052w92whJG
         Wv6E5avrfQiV6DHPURf2z64BteCQqqMKoHQhMdmhEtdmWy35tBQVKF50NhpGNchl1m5D
         kVdbuuxXVwSjM9WkMpqi1iJmt/zg1P39tEd7gT+cWKCJeC739vvcQfHdw1zNsWGrVvmp
         Pla37Ngj6GvVn5nOFl+IWQre/bCrlpUdWf0OqQVZKAaxIfxgNg8tqc7CZwFhvM5kSuCr
         Ij+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688525; x=1782293325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YmgotrVByV7ndgg+t5wTgSkSWrKs9Rj+oRvM7lmSuPY=;
        b=RurLXHom6qvhEejYSCJqBokR/tacrL6wBrLeUyvJ1gLeVgpR1AAtBYfhZNRHTQTiFk
         zrAt6nIo3mO2R+aVjI2pRM6OEE/n0xX4aiG8X1Tufv8d8CUJwLN9OSf9Wk0qrp7Eu1lb
         5GkdrVxHhWKt+ADhakNyLhpVcisvrV8fGTGR+f4l4Ex+djIoBwluV6itSjCJKGyEITmr
         Co5COwIIm25+288yUsrTJcbHLNGK48A6n8brjUTRCqOdoZQb2/S3OBlOi6JcNG8/yLlz
         LvvSGUOBtZlatoC/cmeJ4LhAK/JbhSJ9s0QZ9IRsyxqQ10cGbLtRXYLSrx/y2y7wXFot
         fKUg==
X-Gm-Message-State: AOJu0YyA87jOnEvYFHKMOEswiG1c1IfLdLwktOZJ/PRioBZy4ypdhQcv
	3Nk4imzIB1CSo4+YS1L5Vn7wTzjUZeIxYWMKTAatYqfv5MJJIFcPnKLqDVMSn9NX00SQDE6fpGs
	b5lXP/ypffhZ77Ux1Zs581I+G7MfJ4xhO01cN39eeEvyGLZn54ripUGvIZNavYDV5Yd3p1iVSbL
	GB5Q==
X-Gm-Gg: AfdE7clwkWUC98DcATTFj+lFEu/MXIhQ6r/bI/CoOHRISOkhIcvlzKDn3f/HsJVBd63
	aASBYqEXtOXX/znGF40w+gfXn6SZ5Rk9oPhTNpS87MEvNBxmlkkJXgXvHY3uOOFahonGNVELFTL
	1djq8Qpn7gFB5Ra2in87xhCbOiNmVb8v2qBjIPCMt1vRs4Ll7yFPpvLX7ntartV40b2hVV1lySi
	cfLtd9Y+E5y9pKxrBODQuZdx/vpKg+r+VqLxe/2Rm21U8x2HFRUUbM1dfqGXhRrhjo2c06HHfcU
	Qh6t6RUy80z/oE0l6R+n19v73MVweh7+9cDknQbYNZfxvdENjfQS8MmR2SkK8hxHreEopn9O9Jk
	BF7+oDrO/3CMkX2ftyVLJanKRdfWUPNac56kwjb2NowWAAioJmYZiF6H12t0VuG/m
X-Received: by 2002:a17:903:b0d:b0:2c6:95d1:3bbc with SMTP id d9443c01a7336-2c6bc1e0086mr29694955ad.24.1781688524491;
        Wed, 17 Jun 2026 02:28:44 -0700 (PDT)
X-Received: by 2002:a17:903:b0d:b0:2c6:95d1:3bbc with SMTP id d9443c01a7336-2c6bc1e0086mr29694505ad.24.1781688523641;
        Wed, 17 Jun 2026 02:28:43 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ca31sm157080445ad.55.2026.06.17.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:28:43 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 17:28:20 +0800
Subject: [PATCH ath-next 2/2] wifi: ath12k: fix MLO peer delete race
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-ath12k-mlo-peer-delete-race-v1-2-ab3c4f455dfb@oss.qualcomm.com>
References: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
In-Reply-To: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA4OSBTYWx0ZWRfX2LMFWb+/PmSO
 j9dKb0fTCKdYGDE8EKmjgDlma1ef008Zlavh0wgaVtgdwKMU861JZtb8T5PdpYdIjAvgf8Co8dV
 6HSBrNMSoy2lxQQ9nPi9LDFXNQFtg4FDMDHV61e05bG9h2BAwpu7nTiMmY8k/r8cunutnrXiMf5
 KK2piBhbVhyRBZrze+iZAgZmo976FZfGLXeLide7A8wgzzNMsuhpldA+pzTUVXhwdOUzJ4neKPZ
 zS+blII701NkvpH6X7tpzXICOLl1j4N54BctauSHXBq0aXW5TKZIpBRtBJ3rV4nycMOVX3cFBMq
 AN8frPzava7WPAXPXddrf3BpIHgIC0qQitscFX01iOZKTePw0ohmpxMLSm9uUO4f6wYMEtdWntJ
 qqh0VHc2NKdVuJRPEQq89o9xFk0hs2C/dsI3ZnshJmmOGsDUon1nsLdt3Twgf9Zw/HyGgvSjHo7
 dOdy5QcuypzOqtGH0JA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA4OSBTYWx0ZWRfX2aAQSkaZQs7y
 tlqJmsv0FjLNmXFRgaKYjJnNi907DShFkFXeYRHXYT06eeZ09ro37RCU31l5kUeGkfesBZHumkm
 /Jh4le2n5uAzRliGkoiCPRqs99WsVr4=
X-Proofpoint-ORIG-GUID: PTrgUaCRJ3S8in95ojsaEsx2V_1WQUPF
X-Proofpoint-GUID: PTrgUaCRJ3S8in95ojsaEsx2V_1WQUPF
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a3268cd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=MeHltSpte_P3IK7tgeMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37859-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 9D4D9697F5A

ath12k_peer_mlo_link_peers_delete() sends WMI peer_delete for every
link before waiting for any peer_unmap / peer_delete_resp event. The
shared per-radio completion ar->peer_delete_done could not
disambiguate which peer a response was for: every call to
ath12k_peer_delete_send() did
reinit_completion(&ar->peer_delete_done), so when an event for the
first link arrived between two sends it raised the count to 1 and
the second send promptly cleared it; the wait for the second link
then timed out with

    Timeout in receiving peer delete response

Replace the shared completion with a per-radio waiter list, with
each pending ath12k_peer_delete() caller queueing an
ath12k_peer_delete_wait carrying its (vdev_id, addr) and a private
struct completion. ath12k_peer_delete_resp_event() matches the
response against the list under ar->data_lock and signals the
matching waiter.

Also correct the endian conversion in ath12k_peer_delete_resp_event()
logging, and add the missing \n in some logging.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

Fixes: 8e6f8bc28603 ("wifi: ath12k: Add MLO station state change handling")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c |   2 +-
 drivers/net/wireless/ath/ath12k/core.h |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c  |   2 +-
 drivers/net/wireless/ath/ath12k/peer.c | 130 ++++++++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/peer.h |  19 ++++-
 drivers/net/wireless/ath/ath12k/wmi.c  |  16 ++--
 6 files changed, 136 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 742d4fd1b598..f71650039292 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1524,7 +1524,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			complete_all(&ar->scan.completed);
 			complete(&ar->scan.on_channel);
 			complete(&ar->peer_assoc_done);
-			complete(&ar->peer_delete_done);
+			ath12k_peer_delete_wait_flush(ar);
 			complete(&ar->install_key_done);
 			complete(&ar->vdev_setup_done);
 			complete(&ar->vdev_delete_done);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fc5127b5c1a3..1436ff4316e7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -665,7 +665,8 @@ struct ath12k {
 
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_link_vif info,
-	 * channel context data, survey info, test mode data, regd_channel_update_queue.
+	 * channel context data, survey info, test mode data, regd_channel_update_queue,
+	 * peer_delete_waits.
 	 */
 	spinlock_t data_lock;
 
@@ -687,7 +688,7 @@ struct ath12k {
 	u8 radio_idx;
 
 	struct completion peer_assoc_done;
-	struct completion peer_delete_done;
+	struct list_head peer_delete_waits;
 
 	int install_key_status;
 	struct completion install_key_done;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2e5a075191ae..4c86a8eb5841 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -15040,11 +15040,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	spin_lock_init(&ar->dp.ppdu_list_lock);
 	INIT_LIST_HEAD(&ar->arvifs);
 	INIT_LIST_HEAD(&ar->dp.ppdu_stats_info);
+	INIT_LIST_HEAD(&ar->peer_delete_waits);
 
 	init_completion(&ar->vdev_setup_done);
 	init_completion(&ar->vdev_delete_done);
 	init_completion(&ar->peer_assoc_done);
-	init_completion(&ar->peer_delete_done);
 	init_completion(&ar->install_key_done);
 	init_completion(&ar->bss_survey_done);
 	init_completion(&ar->scan.started);
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index c222bdaa333c..98509c63c580 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -9,6 +9,55 @@
 #include "debug.h"
 #include "debugfs.h"
 
+void ath12k_peer_delete_wait_register(struct ath12k *ar,
+				      struct ath12k_peer_delete_wait *wait,
+				      u32 vdev_id, const u8 *addr)
+{
+	wait->vdev_id = vdev_id;
+	ether_addr_copy(wait->addr, addr);
+	init_completion(&wait->done);
+
+	spin_lock_bh(&ar->data_lock);
+	list_add(&wait->list, &ar->peer_delete_waits);
+	spin_unlock_bh(&ar->data_lock);
+}
+
+void ath12k_peer_delete_wait_unregister(struct ath12k *ar,
+					struct ath12k_peer_delete_wait *wait)
+{
+	spin_lock_bh(&ar->data_lock);
+	list_del(&wait->list);
+	spin_unlock_bh(&ar->data_lock);
+}
+
+void ath12k_peer_delete_resp_signal(struct ath12k *ar, u32 vdev_id, const u8 *addr)
+{
+	struct ath12k_peer_delete_wait *wait;
+
+	guard(spinlock_bh)(&ar->data_lock);
+
+	list_for_each_entry(wait, &ar->peer_delete_waits, list) {
+		if (wait->vdev_id == vdev_id &&
+		    ether_addr_equal(wait->addr, addr)) {
+			complete(&wait->done);
+			return;
+		}
+	}
+
+	ath12k_warn(ar->ab, "failed to find link peer with vdev id %u addr %pM\n",
+		    vdev_id, addr);
+}
+
+void ath12k_peer_delete_wait_flush(struct ath12k *ar)
+{
+	struct ath12k_peer_delete_wait *wait;
+
+	spin_lock_bh(&ar->data_lock);
+	list_for_each_entry(wait, &ar->peer_delete_waits, list)
+		complete(&wait->done);
+	spin_unlock_bh(&ar->data_lock);
+}
+
 static int ath12k_wait_for_dp_link_peer_common(struct ath12k_base *ab, int vdev_id,
 					       const u8 *addr, bool expect_mapped)
 {
@@ -62,20 +111,19 @@ static int ath12k_wait_for_peer_deleted(struct ath12k *ar, int vdev_id, const u8
 	return ath12k_wait_for_dp_link_peer_common(ar->ab, vdev_id, addr, false);
 }
 
-int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
-				     const u8 *addr)
+int ath12k_wait_for_peer_delete_done(struct ath12k *ar,
+				     struct ath12k_peer_delete_wait *wait)
 {
-	int ret;
 	unsigned long time_left;
+	int ret;
 
-	ret = ath12k_wait_for_peer_deleted(ar, vdev_id, addr);
+	ret = ath12k_wait_for_peer_deleted(ar, wait->vdev_id, wait->addr);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed wait for peer deleted");
+		ath12k_warn(ar->ab, "failed wait for peer deleted\n");
 		return ret;
 	}
 
-	time_left = wait_for_completion_timeout(&ar->peer_delete_done,
-						3 * HZ);
+	time_left = wait_for_completion_timeout(&wait->done, 3 * HZ);
 	if (time_left == 0) {
 		ath12k_warn(ar->ab, "Timeout in receiving peer delete response\n");
 		return -ETIMEDOUT;
@@ -91,8 +139,6 @@ static int ath12k_peer_delete_send(struct ath12k *ar, u32 vdev_id, const u8 *add
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	reinit_completion(&ar->peer_delete_done);
-
 	ret = ath12k_wmi_send_peer_delete_cmd(ar, addr, vdev_id);
 	if (ret) {
 		ath12k_warn(ab,
@@ -106,6 +152,7 @@ static int ath12k_peer_delete_send(struct ath12k *ar, u32 vdev_id, const u8 *add
 
 int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
 {
+	struct ath12k_peer_delete_wait wait;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -114,17 +161,25 @@ int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
 				     &(ath12k_ar_to_ah(ar)->dp_hw), vdev_id,
 				     addr, ar->hw_link_id);
 
+	/*
+	 * Register the stack waiter before sending so the resp_event for
+	 * this peer cannot arrive while no waiter is queued.
+	 */
+	ath12k_peer_delete_wait_register(ar, &wait, vdev_id, addr);
+
 	ret = ath12k_peer_delete_send(ar, vdev_id, addr);
 	if (ret)
-		return ret;
+		goto out;
 
-	ret = ath12k_wait_for_peer_delete_done(ar, vdev_id, addr);
+	ret = ath12k_wait_for_peer_delete_done(ar, &wait);
 	if (ret)
-		return ret;
+		goto out;
 
 	ar->num_peers--;
 
-	return 0;
+out:
+	ath12k_peer_delete_wait_unregister(ar, &wait);
+	return ret;
 }
 
 static int ath12k_wait_for_peer_created(struct ath12k *ar, int vdev_id, const u8 *addr)
@@ -184,22 +239,26 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arg->vdev_id,
 							 arg->peer_addr);
 	if (!peer) {
+		struct ath12k_peer_delete_wait wait;
+
 		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
 			    arg->peer_addr, arg->vdev_id);
 
-		reinit_completion(&ar->peer_delete_done);
+		ath12k_peer_delete_wait_register(ar, &wait, arg->vdev_id,
+						 arg->peer_addr);
 
 		ret = ath12k_wmi_send_peer_delete_cmd(ar, arg->peer_addr,
 						      arg->vdev_id);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
 				    arg->vdev_id, arg->peer_addr);
+			ath12k_peer_delete_wait_unregister(ar, &wait);
 			return ret;
 		}
 
-		ret = ath12k_wait_for_peer_delete_done(ar, arg->vdev_id,
-						       arg->peer_addr);
+		ret = ath12k_wait_for_peer_delete_done(ar, &wait);
+		ath12k_peer_delete_wait_unregister(ar, &wait);
 		if (ret)
 			return ret;
 
@@ -283,13 +342,14 @@ u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah)
 
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta)
 {
+	DECLARE_BITMAP(registered, IEEE80211_MLD_MAX_NUM_LINKS);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
 	struct ath12k_hw *ah = ahvif->ah;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_link_sta *arsta;
+	int ret, err_ret = 0;
 	unsigned long links;
 	struct ath12k *ar;
-	int ret, err_ret = 0;
 	u8 link_id;
 
 	lockdep_assert_wiphy(ah->hw->wiphy);
@@ -297,8 +357,19 @@ int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_st
 	if (!sta->mlo)
 		return -EINVAL;
 
-	/* FW expects delete of all link peers at once before waiting for reception
-	 * of peer unmap or delete responses
+	struct ath12k_peer_delete_wait *waits __free(kfree) =
+				kzalloc_objs(*waits, IEEE80211_MLD_MAX_NUM_LINKS);
+	if (!waits)
+		return -ENOMEM;
+
+	bitmap_zero(registered, IEEE80211_MLD_MAX_NUM_LINKS);
+
+	/*
+	 * Firmware expects delete of all link peers at once before waiting
+	 * for reception of peer unmap or delete responses. Phase 1 registers
+	 * a per-link stack waiter and sends WMI peer delete for every
+	 * link; the resp_event handler matches each response to its
+	 * (vdev_id, addr) waiter on ar->peer_delete_waits.
 	 */
 	links = ahsta->links_map;
 	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
@@ -318,29 +389,36 @@ int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_st
 					     arvif->vdev_id, arsta->addr,
 					     ar->hw_link_id);
 
+		ath12k_peer_delete_wait_register(ar, &waits[link_id],
+						 arvif->vdev_id, arsta->addr);
+
 		ret = ath12k_peer_delete_send(ar, arvif->vdev_id, arsta->addr);
 		if (ret) {
 			ath12k_warn(ar->ab,
 				    "failed to delete peer vdev_id %d addr %pM ret %d\n",
 				    arvif->vdev_id, arsta->addr, ret);
 			err_ret = ret;
+			ath12k_peer_delete_wait_unregister(ar, &waits[link_id]);
 			continue;
 		}
+
+		set_bit(link_id, registered);
 	}
 
-	/* Ensure all link peers are deleted and unmapped */
+	/*
+	 * Phase 2: wait for unmap + delete_resp on each registered link
+	 * and tear down the waiter.
+	 */
 	links = ahsta->links_map;
 	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
-		arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
-		if (!arvif || !arsta)
+		if (!test_bit(link_id, registered))
 			continue;
 
+		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
 		ar = arvif->ar;
-		if (!ar)
-			continue;
 
-		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id, arsta->addr);
+		ret = ath12k_wait_for_peer_delete_done(ar, &waits[link_id]);
+		ath12k_peer_delete_wait_unregister(ar, &waits[link_id]);
 		if (ret) {
 			err_ret = ret;
 			continue;
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 49d89796bc46..3dc720a3dc12 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -9,13 +9,28 @@
 
 #include "dp_peer.h"
 
+struct ath12k_peer_delete_wait {
+	struct list_head list;
+	u32 vdev_id;
+	u8 addr[ETH_ALEN];
+	struct completion done;
+};
+
+void ath12k_peer_delete_wait_register(struct ath12k *ar,
+				      struct ath12k_peer_delete_wait *wait,
+				      u32 vdev_id, const u8 *addr);
+void ath12k_peer_delete_wait_unregister(struct ath12k *ar,
+					struct ath12k_peer_delete_wait *wait);
+void ath12k_peer_delete_resp_signal(struct ath12k *ar, u32 vdev_id, const u8 *addr);
+void ath12k_peer_delete_wait_flush(struct ath12k *ar);
+
 void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id);
 int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr);
 int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       struct ieee80211_sta *sta,
 		       struct ath12k_wmi_peer_create_arg *arg);
-int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
-				     const u8 *addr);
+int ath12k_wait_for_peer_delete_done(struct ath12k *ar,
+				     struct ath12k_peer_delete_wait *wait);
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
 struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah,
 					   const u8 *addr);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 84a31b953db8..6066ca8d9fc4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7072,25 +7072,29 @@ static void ath12k_peer_delete_resp_event(struct ath12k_base *ab, struct sk_buff
 {
 	struct wmi_peer_delete_resp_event peer_del_resp;
 	struct ath12k *ar;
+	u32 vdev_id;
 
 	if (ath12k_pull_peer_del_resp_ev(ab, skb, &peer_del_resp) != 0) {
-		ath12k_warn(ab, "failed to extract peer delete resp");
+		ath12k_warn(ab, "failed to extract peer delete resp\n");
 		return;
 	}
 
+	vdev_id = le32_to_cpu(peer_del_resp.vdev_id);
+
 	rcu_read_lock();
-	ar = ath12k_mac_get_ar_by_vdev_id(ab, le32_to_cpu(peer_del_resp.vdev_id));
+	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
 	if (!ar) {
-		ath12k_warn(ab, "invalid vdev id in peer delete resp ev %d",
-			    peer_del_resp.vdev_id);
+		ath12k_warn(ab, "invalid vdev id in peer delete resp ev %d\n",
+			    vdev_id);
 		rcu_read_unlock();
 		return;
 	}
 
-	complete(&ar->peer_delete_done);
+	ath12k_peer_delete_resp_signal(ar, vdev_id,
+				       peer_del_resp.peer_macaddr.addr);
 	rcu_read_unlock();
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "peer delete resp for vdev id %d addr %pM\n",
-		   peer_del_resp.vdev_id, peer_del_resp.peer_macaddr.addr);
+		   vdev_id, peer_del_resp.peer_macaddr.addr);
 }
 
 static void ath12k_vdev_delete_resp_event(struct ath12k_base *ab,

-- 
2.25.1


