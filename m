Return-Path: <linux-wireless+bounces-38260-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DwEGCrkcQmq70QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38260-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:20:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D81D6D6EBA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:20:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nJNTmC7E;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gII9tFXP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38260-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38260-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 300EE30C2A89
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8A37C0F7;
	Mon, 29 Jun 2026 07:01:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702538AC80
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716496; cv=none; b=RENm9Vgg2te8m1IvctaId2a5ExvqUTolVamK17LHHCZbrpG+j+eZRfREa6OHUCgnjB5A1u4NHOvYcOiH8qpgY+qkRBRAXn5PxRwz+g3yy5B84crymZ7Te5zVwUQiibppwLPBq3I8m4/X8yGNce5pcc0N9p9iZuFePKS27woucQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716496; c=relaxed/simple;
	bh=73nFN0EWs3US0MTtGwNBNc/x+TdH8h3axx8CCollb+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HztGeLWifuaERq9tFb55zkIt7I3vDWFtdOP9uWz0tw7o15NdfPANcDLJqFPvHINlwRi1Qm2Hd9tIRACdrwiWkxtQFFt2JnT/EY6lUNtz5rg3vTEDWH7aEBBTk1O0lCM/Sdz1dvTBabvQQLJa9f7UUFw4A1Ud4gVk6tY6VykdlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJNTmC7E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gII9tFXP; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rTqo2124901
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+mj6EtGW47ilBuoLGajfTgpqNgNP9aC7yZx8Af2gl8=; b=nJNTmC7E6jZhFhE8
	QglFQKDgppWXHa52JQTQe/BcX9Zh5YJ123qAeXCBXgqQsagQCCXyjv6sNLcmysLB
	/PkF0ekE4lSuqdrKGmymUQyVHViPXssBKANelhZOkcMR2ThNXGR3MlSLEURbjrgQ
	x09yS26u4enbRjOnP8lvKzbw4qh/F5uHFqgbrXM1EATZnJuwuUwlyoW1R8y+V3Tx
	ARUQfuZJiw7juBSNzS8NUP1Ug1/WPfYjqgOJ1BL2alEBUHVApco3EeasIUEn8I9B
	LZ4m0rRDLD6gFXRxPG3HCLAyqpaP+VgLiQsByO2udE1K3vDjnhOhj58zVmtMWdZR
	tgwnsQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f273356j7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fc0aaa94cso1109280a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782716493; x=1783321293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+mj6EtGW47ilBuoLGajfTgpqNgNP9aC7yZx8Af2gl8=;
        b=gII9tFXPAifhL4tIYQe14UcBeMlsJrhElIq0TgH3kppZ6T/SbXeorZ0s7zE84k6eSi
         3t7FCPeoipqoI9OOMs3hZQo/BKVfPRUF8S+Z5QkCUG+kKttA9Q9csaYt3Gls+ssdRAPP
         xBrVNr76RteepC2PAa0ksyKabRa+ioY0NN9vkJYFsNTOK+t/CLqta70+Cx8NApKPoDU3
         oSU0r3ycfqiv9G474WSQFW6Rc/C+ngHtHULMZtcmTMRT9X1Szbpx11Ko9HgPixV7YFJU
         g3AUbt/t2DrzN5+j9AyvCK+hQ7usPR4FCKGQPltX6RozvgUqefwdOFaI2NkoWHSxdiYB
         yqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716493; x=1783321293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+mj6EtGW47ilBuoLGajfTgpqNgNP9aC7yZx8Af2gl8=;
        b=OuLk2UVGOFrDosjYYCpsjEmZKg9e41ctaU75FFufv7rKTq1I4Zk0V8mRKd5uq6MpQC
         KdA0OQefuRqIJxkMg8L+LJ5qWHGO7Lf85/ufhgCKGBjTDIa9Uf8aio32JxyUOFHDR5R4
         EpUL/xwajYK6gV/CC8NDgB9LC3cRDFuFAsM0CLuW5Ep4Ns4adj1dAOrvAJ43AW6zZcjJ
         uMfwmFYpjZ3rmm2UBsk6kkTvyt0oMaBl4wP2lPObVXj1mr598kxz3wg5X/y3+8WW8YwJ
         i1DErRMT7k0z+4xaXhjvBsJuqoYO4JUST66rRTRNuMof7+ni4eOMAtZMj2vfxBaOkWet
         yL3A==
X-Gm-Message-State: AOJu0Yy3SnnVZ9dwiRMIZbU0sYhNNpbBhOoDbIhoB7iHabhPXA6co0w/
	aqaU73+XH19P8z1U6kMPlG0Sh+83TL7HTXcpDtoYCwaPifB2JcUknIfZzOI13wddfcfrLNfcW8P
	rz7LYyy9RdxV4GsdAzi6HlgpMwN0JPhTvYM43V1EJGjywUur4ijko43+/SUn5XAuKfcf+8Q==
X-Gm-Gg: AfdE7cmhc4S1cpQRlqEfNewo5ryvo+Liio7FN0jTn//ZWImqDCfcER0gPgiPqmjwYFy
	OU8VsCIrEOcuMJ1rugmDair/veUnUL2nn0sygeDmoaIvILAGKZkxyLHwMo8Zwf4gqhPzFvdGAgi
	N6yW3HTn7LzWA+so0YDJzClrEClCwRhFNZ72/jT2X3NfzR16WdXRF+gs+O82xuDau06/BH8eEaF
	VdpY0iFXYDIOVkBg9aQ8w3hbkLOMDH71buCkfwZLQyEFyhBX0Qh44fpxGrnfiUf58PZxIzj9Xa9
	/hjzCzbKTleILNdQ4ZRLUr4MV7tkPuZT76oQnidgsOPnSX2OGmH+Avt8Q1x6XmwCqgxi8GA/pAM
	efwa8+WThNDNvnA5WlCeRj3xyTgbbOlZeYpVr3ZXySK1gMdls326oLSs9EYnNBCbP
X-Received: by 2002:a17:90b:5287:b0:37f:9cdf:f0ab with SMTP id 98e67ed59e1d1-37f9cdff81amr7272540a91.26.1782716492900;
        Mon, 29 Jun 2026 00:01:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5287:b0:37f:9cdf:f0ab with SMTP id 98e67ed59e1d1-37f9cdff81amr7272513a91.26.1782716492431;
        Mon, 29 Jun 2026 00:01:32 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e2048ffdbsm5276706a91.17.2026.06.29.00.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:01:32 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:01:17 +0800
Subject: [PATCH ath-next v2 1/2] wifi: ath12k: fix dp_link_peer dangling
 references on AP vdev rollback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-ath12k-mlo-peer-delete-race-v2-1-362b25590d19@oss.qualcomm.com>
References: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
In-Reply-To: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a42184e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=S8TJSIUMMvVyLKssZ70A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: bBu9r85qu-O4qlCZtAEmoor8vBgvslqZ
X-Proofpoint-ORIG-GUID: bBu9r85qu-O4qlCZtAEmoor8vBgvslqZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfX0yZjDxqHUabP
 Bhgp85286qWya9oAlvT2rO2GsQwlJccRQfa+Gssbnw0bfTFqZYn4pZ9w9k8CCMJ/y3zrHNdv5g3
 R/8qUkqQnfNeNlrCX0AsBquPNOfLLoOVb4FHTAPkInYk+a7uMFGD+hUW4wpvr+wl6PXgkf5sg1C
 BU9AQkF5b4O9N8LHGMbwHd4dcKRUbVCUzpVfEEgxsgvh7DmIrtldsjIUSUBl0DIO7ddnwiBDq9Y
 kGH9wVaOD18/b4FH2L3zIDgsurCOYkbTXI/K3IBcUHPX71Uzg8lDYWso3KiHcu4TBFdmZdfG7Oa
 XNYKhS0inqFvuEWjfl8mPtx2O4luwrA9Y9nXEAa538RyCoFhmplN1P8EWXMfJ2e0Ff7GcqBDiuW
 I+aFwY0x/IUB+XItYPp4VsWOFo5xvEtbGLiHXELodsd1zBvRS1XHxH0FJhD6rcDNQbJWh3rNBBF
 8RdtQI+kJ4PZ/8DnBPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfXxovtK+GOkOKo
 EDjLVZGJ+AcWNrudLYmCfwlPmBdRJPi0n43SdO6+Ny8gwYtr1lXQwIBZqdoA4KtA/3joZc/Rtsv
 Fi+6qoZmPJkRTkIZUPpxw92x+odR2UQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290058
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
	TAGGED_FROM(0.00)[bounces-38260-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
X-Rspamd-Queue-Id: 1D81D6D6EBA

ath12k_mac_vdev_create() for an AP vdev creates the bss self-peer via
ath12k_peer_create(), which finishes by calling
ath12k_dp_link_peer_assign() to publish the dp_link_peer in the
dp_hw->dp_peers[peerid_index] RCU table, in the dp_peer's
link_peers[] array, and in the per-addr rhashtable.

If a step after ath12k_peer_create() fails the function jumps to
err_peer_del, which open-codes a WMI peer_delete and waits for the
unmap / delete_resp events. The wait_for_peer_delete_done() path
relies on ath12k_dp_link_peer_unmap_event() freeing the dp_link_peer
when the unmap arrives, but err_peer_del never calls
ath12k_dp_link_peer_unassign() first. The published references in
the dp_hw RCU table, dp_peer->link_peers[] and the rhashtable are
left pointing at the dp_link_peer that unmap_event then frees,
producing dangling pointers and use-after-free on subsequent
lookups.

Replace the open-coded sequence with a call to ath12k_peer_delete(),
which already does ath12k_dp_link_peer_unassign() before sending the
WMI command. This drops the published references before the
dp_link_peer is freed, in the same order as the normal teardown path
in ath12k_mac_remove_link_interface().

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

Fixes: 5525f12fa671 ("wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index af354bef5c0d..2e5a075191ae 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10564,22 +10564,8 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 err_peer_del:
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
-		reinit_completion(&ar->peer_delete_done);
-
-		ret = ath12k_wmi_send_peer_delete_cmd(ar, arvif->bssid,
-						      arvif->vdev_id);
-		if (ret) {
-			ath12k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
-				    arvif->vdev_id, arvif->bssid);
-			goto err_dp_peer_del;
-		}
-
-		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
-						       arvif->bssid);
-		if (ret)
-			goto err_dp_peer_del;
-
-		ar->num_peers--;
+		/* ignore return value: propagate the original error */
+		ath12k_peer_delete(ar, arvif->vdev_id, arvif->bssid);
 	}
 
 err_dp_peer_del:

-- 
2.25.1


