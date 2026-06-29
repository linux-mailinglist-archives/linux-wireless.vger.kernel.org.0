Return-Path: <linux-wireless+bounces-38261-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u3M7C1MbQmpS0QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38261-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:14:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5526D6D81
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nMpRwyWi;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EgSzlJQ9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38261-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38261-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32F33304B253
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813983B52F0;
	Mon, 29 Jun 2026 07:01:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3B3B42D7
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716498; cv=none; b=JjBq8B8KHUCYiUfkPp1UBt7VvPAaf0ugggj/KX+/Rgay++Q1S2t1cOBTSODbqT0ch8oFO3LtueYITLQOGLEurxnY+6VIyZ99tj+/PhlfrTBzwQnL7uH62723JzWAyly3/pfrG1ZDBSsp1kOqwH3U2qriXBlwTZ6MKiGxCsVntI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716498; c=relaxed/simple;
	bh=P3VvBM0YKof4tbEyx1wtrOO10xT2C05KaGbqLBZYkDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdUCu3+W6zkOy23aIz24OQ7IGBM1tEurlP7Bh5YYNNZSbNJM6elC6MaVJvoThcpi77eqa83ykiPoCAv+N2f36t3UVkubhSB2+5RCbaDOHhbKZu3BiSTAnBoP9FZd+IS8AwuZBk1mspx9jwNB8d93ZEn1boQhbFCLHuZBUEt4ieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nMpRwyWi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EgSzlJQ9; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rHrV2097140
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i+ibs0BXtdFZyrd+Y8jWE14DhKLfJywF8YZWUNeuBxg=; b=nMpRwyWiiUOfIP99
	Me6vWw5b1Nf2D+wBqhsbiyf97vuwCSwsZrb00KU2ZQ0hROhMtr8hmW1jCKOCkIci
	jJAGwsSrv1HOEU3m8ioP6678DA+FsOnWy/KbGxmjNNBK8ZTVgRA2Ql33tQobBHe9
	ojG+pOhI1VIIs4RLb4aUKOYHPQVduRVSHdRxIRfcUsSzLGIIY6nJ19MfaaOx6aGj
	zQpuI9KC2q0wERjLRt2h+KablgcSX68IrDY7RMUQXdkrKU+jJPmQt7bX3ibmChGe
	wZsKcgPFD0POZx2c3BpicCe5JlJaQrjy+5J21jKBuGvTgH/kKorBGf5AqCec4Su3
	7cZOQQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7w0ga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so1454981a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782716495; x=1783321295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+ibs0BXtdFZyrd+Y8jWE14DhKLfJywF8YZWUNeuBxg=;
        b=EgSzlJQ96ExwN49ehAiXzxaajHBm0pDi2a8byY+RsZmqxD9YFOKE6jSkJVLBZAvF8v
         EuNL2ssV/Smco5gZ+n4ONOlumNdvFbORfe23yu/DgodRTqJZ+9J8bO9DvlySls502MON
         0w+Rj7SKssCxufQwwsVcAEQjqPDTpmGRxZGuzHw3ewearbUUkb9f8cp2/o/5jC5QtNOR
         ZpfQkhWUCWecRTh9vGN3mgSo5aLMpSTKl8EGztOlJRq0Gc5GRRc1Bi+KELwrl/aNrsQw
         nmD9uKzlSc34UJyBgExxdSAmwtwBTf+8rl5hYfOk7v00H1yf0eFi78mkkHz1eAZTY6CK
         aUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716495; x=1783321295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i+ibs0BXtdFZyrd+Y8jWE14DhKLfJywF8YZWUNeuBxg=;
        b=R0jKGVgoK0Sif/IYI3UAZPCyT2h6kj7DfkUH3+dyKtxm6h2Nt3WER1LH7pe7qb6PH+
         IYLUS5p6TBSFAFlBcZpxdb1Hr8xSP3ccxN8CTiIgVy/HOybxdpuJBECS8xJTId2Jc22h
         aPq01MQQivaDPkFTAbU7rw0v7M17//5qRjT85VQtW5nwmeg1o54rqBqmDgGDYcURXKph
         A+eCp3WsxGEwLhRsDrcWbtuBF71cuhr3BkjYecDNSWCyZsNROdS3RycBgBFeimYE6891
         n9I36nPajXxu34+GD47qUBffq33J0ew+yBdDIRprG1sSfRh3LLlkmK5/4DshqozrSSB2
         PfeQ==
X-Gm-Message-State: AOJu0YzEl6XBk0BkOq8h76IOORpu/GRiOBmm8tCUtDC9Ons5MK+EZmIe
	b6Oov2slR4XLTjuYk6iwJRE+Z+l0fLHXO6d00I4nuUW7jksxplzX0hSyJMz4P9GOqQDqXxx9PtG
	d3LKBt6b7Xr9k7APDqu3NVpo1GGBWQC1ryFtBZscbBmre04Wn1h2HEQOFjiOQE13vRf8o4A==
X-Gm-Gg: AfdE7cld9B6lEFA3ki9q85PCIwLMs13PtXLoUU/nsSwY1v9oPXbi+3/sB55Gf9WEwKt
	vtG7GnmBqqwbPiE4mW2N14FqUXUihHI6IgKRBqXWT+u0CFgQAXqwGgPujA4bnulOSZXHiXc7b4i
	QTnVcJMnLV9Vp12SJBrURL4FXlgmhRRWf7q+egVM8mz7rVKl2LuMun07DcpAS22jRtO380GBC/A
	ZSTDO5TyybWHHrbil5yE0ImVSFyJk6HqkULuQIMyu5e8bskwvQPXQ8MDWW+0T3iA0ZXj/Ry8+zS
	wA+7bZuhAqP79o78C+hnHWP1UxsghfTFGBi69/uZG56mQfNwN2cG/RDARrIMBJwiKf5zc7Etgj6
	PRUKNYtl+nWnUd6FXM1ogOWCJCL+ug6AFs0L+k8XI5JsNgQVA62DtOvBzQZvrYURU
X-Received: by 2002:a17:90b:5906:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-37ffb1d6759mr2458409a91.15.1782716495113;
        Mon, 29 Jun 2026 00:01:35 -0700 (PDT)
X-Received: by 2002:a17:90b:5906:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-37ffb1d6759mr2458390a91.15.1782716494537;
        Mon, 29 Jun 2026 00:01:34 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e2048ffdbsm5276706a91.17.2026.06.29.00.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:01:34 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:01:18 +0800
Subject: [PATCH ath-next v2 2/2] wifi: ath12k: fix MLO peer delete race
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-ath12k-mlo-peer-delete-race-v2-2-362b25590d19@oss.qualcomm.com>
References: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
In-Reply-To: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfX/QmOLrkNpC24
 VEB96gfZwq/y/gmjLqDu8Kz9iwXp2ZsPo8+Xa0yuifhqfyGQ1cryoENDJWKLaBaNb3q6nC15DD+
 h0zZTkv69fr82hIiZjhjCM9uukmuSpKhlZ1YP9aWrk3i8Tcudcsg0Sl4OC2oFI6J7Y2nzHRadTB
 ceTE9adC5zjDS/nX71oJtGgbj1ePYyrA750UMxJxJ4ryY0hiD/qs3E6zS3t6EgaNmfL548sjiIo
 1f2zWB56DT+dDbHxyh/KGrbplflSaTzQQsHVXRTiT3e4QfhdAkHgC9/6jTpxeobsjB0W66D4KN0
 ew9HZHFrHfFFCMVTXCv7fqlfbQLuBwEAGXw88z/6iHNvPvBOI2pkEvcDrJV30YgRqu/SITZAB1U
 V7/RqFbO3ZQ7tHM6GD1uFGJ5SG2LQJZn2FvqrtUEl9QuQ0JqWYZ8Ifx9wFdJXWA1dN8UWmsOuf2
 Y6dBGW1qldk2CKZF9eg==
X-Proofpoint-GUID: z9BGutKZRRRvFBkwfA7mXY589MRLxTtC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfXwPIFDoo6H+sX
 qbHqYUb6JQsDq9P9V/iCM8hxtvXk3/13hoTQVUloDysXBpqU8UlQTJKwksbKWbMeMji4+tl6iTu
 VcaSvY7kOHLDGjFZI/RmIc40ala7mpc=
X-Proofpoint-ORIG-GUID: z9BGutKZRRRvFBkwfA7mXY589MRLxTtC
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a421850 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MeHltSpte_P3IK7tgeMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290058
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
	TAGGED_FROM(0.00)[bounces-38261-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C5526D6D81

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
 drivers/net/wireless/ath/ath12k/peer.h |  14 +++-
 drivers/net/wireless/ath/ath12k/wmi.c  |  16 ++--
 6 files changed, 131 insertions(+), 38 deletions(-)

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
index c222bdaa333c..5084e8c42a3f 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -9,6 +9,55 @@
 #include "debug.h"
 #include "debugfs.h"
 
+static void ath12k_peer_delete_wait_register(struct ath12k *ar,
+					     struct ath12k_peer_delete_wait *wait,
+					     u32 vdev_id, const u8 *addr)
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
+static void ath12k_peer_delete_wait_unregister(struct ath12k *ar,
+					       struct ath12k_peer_delete_wait *wait)
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
index 49d89796bc46..9343944c2b8e 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -9,13 +9,23 @@
 
 #include "dp_peer.h"
 
+struct ath12k_peer_delete_wait {
+	struct list_head list;
+	u32 vdev_id;
+	u8 addr[ETH_ALEN];
+	struct completion done;
+};
+
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


