Return-Path: <linux-wireless+bounces-37858-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p7DVOs5oMmpNzgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37858-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:28:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61424697E95
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:28:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GE3RIJAg;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bYmTVxBN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37858-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37858-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F6F8300AC3D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64339732C;
	Wed, 17 Jun 2026 09:28:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876A39D6E5
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688525; cv=none; b=eseycTfyYXkISrhLx2VTYZ6N8l2+6DS6fBw83em2EjtCItp9YzhyGkNn3uTuqQg/d6Ui/wKJNh99RcEH/lBu2EOBQ4nP9W5879CEXNq4G4yLbyHy2YngtXWFnFeZTEATxuwe513+/7noq+VWGhe3+MVM4sPK8P+JXsnAM2A6SWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688525; c=relaxed/simple;
	bh=73nFN0EWs3US0MTtGwNBNc/x+TdH8h3axx8CCollb+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hY0K1YMYywtSVeWFq3mlsUj8tFR6mB4kCgZiU9ACWS0b3IQA7jbglanY0SBWtiQo82Ye9Z2ZeecERnvCPwBK1evB1ZmF4anJ7oxcndoBYvvNemY4yDzHE4YZoWhcult5M7Ffwz/s1Qe3vKhjI2jCKVYelSBmZbqnKp3d1a9f5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GE3RIJAg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bYmTVxBN; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8V6Cb2291358
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+mj6EtGW47ilBuoLGajfTgpqNgNP9aC7yZx8Af2gl8=; b=GE3RIJAguxvxb2dp
	6U/PxnPu/D6zPA/Y6hXt5WODPOjsJC1OGPH7i7Tc+9JkYJuy5oLxeEGg2jkCiqu/
	ZNVs0KRm+mgGWpGWp1uiGXYHlWlhl5slmrNrQK9KYafuInocVU5ls6xdbFBm560S
	CDEZ8rqVT7IMnAOVt3MpuuZMeMQr8aS7xiyUgxsIsGUAe3tYyf+9RzJ+d+l0vMq6
	JU1deYwFVx+qmVHwyFArID+OAWKpBECFyVCv6eDURPR2TYs2Zq8N/HUsUTXN/WPG
	sC0ZhQGkmkfJT7PWIpN6IM/Hb9k+J2nxC5Y0DijD5JPsDZ/XtFUPYPD9K7nWcGpC
	b+564w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevjfnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c40358e114so65039285ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781688522; x=1782293322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+mj6EtGW47ilBuoLGajfTgpqNgNP9aC7yZx8Af2gl8=;
        b=bYmTVxBNjJZ6jwqYqzLmbrLuTCRgHNgmGxLb2cVUbI9nd1yL537kXRe4lp378U5MiE
         xCAMD9cbaSzpFNsxfAWBpv9AUnisFKzYrwg/pGP2syW4kLBV/xlOBUJfX5QE9BUIX/6f
         +ceyq47NAqa302stswmeIsz2MuCsCAc1Aqq0oCVDS+3tXuDdeyjv4xlLsmVgLH0uOGaZ
         tGXP+bw8p2YwjIIg7UfW0fNX9yrruxyQnrwQFKC8zwRyDvT/uRCrKgjQ9pndoxp3Bbjd
         z3wMIgP4o4F0UUkkwTPOd0i8kwxX30NkLTO58GAkqGM+h3k+bpduYCR6o9Bk2q7BmVrr
         Hj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688522; x=1782293322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+mj6EtGW47ilBuoLGajfTgpqNgNP9aC7yZx8Af2gl8=;
        b=ogCt2eKo5TEIBXH1lTNY97bhmy5qasWRNiy+562eABga447llEBapWJlPGB4kAcLIP
         cm/yZq39qIOx+3sr+n5r4zKPV4/GrQCmJWWLaKbgGG9VjK6AhMum4LSxoghRMwEi/kS7
         OrRsmwM+BB/QRi/sBbUDMIt6G/47aCFepF8SCCqw7lJzAXM9FiuRnII9FUAbsB1wFaF1
         ECqIeoA7pVIZFRqSEjz0XJCau1vIcj6bE2ufSQoLfbW1NUchj44sFEcVqAMs8qHAcbgn
         0Q82fKfEKBmx1BFMusVsC88w6dvL3scC4grWg3I3B2SkNDqIu2oBrsrWCD/sRRTejHme
         6xbA==
X-Gm-Message-State: AOJu0YyPEPMxcYpdANvAb5WKK1ZtSjXFcGlHiBOYLtuJRBTtJhftlNed
	SnBPG8ewQl2peu21+mJKI+YcDF50L5vjQ7ooZPl7ZliXill8iJFUptz7whah0+ZkcXMnQpg2p5q
	LCpjDtPa4/Z5MEwX/EC9C6uLLjxvvCKNN8TMXdqV9noocpd9dzyLQodvoYSSHG5jJ0c+rXw==
X-Gm-Gg: AfdE7ck1hGSycC9PrzgdsDS1fhmZYTzlg0683EmPUDhtsHpdwYC6QaCTL2mqp4wFGMO
	Q5+bGbAn7SyulttWmF3HK+2wqxNYqYCjPR9nUXBJB3sIKjyRnBfhZzKKEMkFHc2SPKCqp8s2iTo
	/00iKANRDnCJ+9pzICwO4QfeLltBFMco2vK7Cc2GLBJoHWVFcES+SeG3+Psp+HFVL5QFEoY0RE3
	TSAAJcIT0r9oxNVb0MBdLQFVzpkhWa4bg4B1jncYVvt/EMudxK1/UrnOtWifxNkLOdMZNidyI4M
	jm7lc0w3LuNHpp3Td+6lBYstKJwZoIojmgjuxfAcsZ4PdrsVl3sg2uYRmE6EjX1kPKTBbe6MZgn
	uMmSb0ShbWv460YD6/BPtU6Pim4oKWyoYrbGRPVTYNiR8MXOQXtUs56rBw/La81i0
X-Received: by 2002:a17:903:b86:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2c6bc0b77c4mr28186985ad.9.1781688521887;
        Wed, 17 Jun 2026 02:28:41 -0700 (PDT)
X-Received: by 2002:a17:903:b86:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2c6bc0b77c4mr28186825ad.9.1781688521449;
        Wed, 17 Jun 2026 02:28:41 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ca31sm157080445ad.55.2026.06.17.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:28:41 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 17:28:19 +0800
Subject: [PATCH ath-next 1/2] wifi: ath12k: fix dp_link_peer dangling
 references on AP vdev rollback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-ath12k-mlo-peer-delete-race-v1-1-ab3c4f455dfb@oss.qualcomm.com>
References: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
In-Reply-To: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA4OSBTYWx0ZWRfX+eXhOf19fapB
 TgzBN/lUPQUJq8jHERuBprr/pttjyloiPE9yyx8QU4mXlBxxeUVTBeRFYJoGL8nDosvPIWDmKon
 tCyiRyNTVRmlBBEankIFiT5HqrLw5VS0zb2M/pplUSrqXSNwCh/PvLRGJPmP2r8gFLAISLErMoC
 oSwAc9URRoIoahTIHC808alZnsh+TlyY2Ftzzhb6HPk3OcRnBJWfNk4MVA8AQUFSYrBnGLl1kG4
 Rlmem8Yd7rbbRs62OjlKmIL0WD/V1pZrZ87pOkL6k87Xndlw/+J2NifqahWCvM8W7/SqJxMnN3C
 PwNtpEh7hNJLvNTy+4b5BMuPjMTxuck61SezOecntZ6XvJgye5TXAe8u+e2Lr+M/w2uuzrpEXGl
 xIHXUrBa9S2U/myj8u53ss8CcBVOCMBd6/Et7lSOgH9u9ucpQTbb0yoRXJsNzAOEC5vDoQ7uFep
 q+oxYtf7mtv+3d1c3wQ==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a3268ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=S8TJSIUMMvVyLKssZ70A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: s5IebCMIgVbQZFI20zp3S77RQ-UdBMwr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA4OSBTYWx0ZWRfX4wMhP/4kimZe
 nBlp/mFzPxjfcRE2cB1Bf7iVGUtevGGjZNH3V8+DWtu06dxuMNL7HZzj8EJ73Wyh58MvVd88peM
 JEsUzJuI99Fuyflm/tfZRxmabpHI8iA=
X-Proofpoint-ORIG-GUID: s5IebCMIgVbQZFI20zp3S77RQ-UdBMwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170089
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
	TAGGED_FROM(0.00)[bounces-37858-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 61424697E95

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


