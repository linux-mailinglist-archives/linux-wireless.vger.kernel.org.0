Return-Path: <linux-wireless+bounces-37692-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v/71L797K2ql+QMAu9opvQ
	(envelope-from <linux-wireless+bounces-37692-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 05:23:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B246766AF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 05:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Kk6Ik038;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Jf4b8/T8";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37692-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37692-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C13AE3003BD3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 03:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A2D30C368;
	Fri, 12 Jun 2026 03:23:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35210303CAB
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 03:23:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234618; cv=none; b=ql1ahK9sTWA253X82q66emAU2ctoJ8IxB1dnen71sZ9UYgdcjNMp+9w6TEWORTWlsXe1r7quSFuT71o0ebTJj+xd/I+QLJLXhvVKj3sH3t8Mi8vA5afgEhkq3ywLBkpEk0bXRm6tOE8XNgBfybCefTZS9OIqP050l46SosVCCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234618; c=relaxed/simple;
	bh=yOHapdSVMxTQw8PC6cSgbZ0+Mepj6kBZoVH1Ay5SZ54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpB7O9+gPOAj8g9UCESsOMVDZlFZfK5bBCYKap82hTIVfZ+fpNOYf2mNmtMfSagzKrIoS8FAIiMTVg1kZIA9tau7jg2b6Ni7gR90oqyYHu4vt34VITxBWntk2eGyAvOz/UqKGWFw2Gtm1jYE9dIizuwkgJRIqrP1FMRNFQSzlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kk6Ik038; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jf4b8/T8; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39SSO2502681
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 03:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=f/cSaD7TtRbyQmfmeTtYyf4+fdttmjWQdF4
	y83zbGbg=; b=Kk6Ik038wJzIat1xf/GjMxEP0q7gWh6rfKRzPwyuKVF6qYoaGI2
	TyapWql6bqqN+k7m4MFvmvBu7dcQEHSv1HktV5hVV7FJYFg+EFnjxbaU2/GbEnLD
	dHEkZz/XqACpQpfGLn/sGViyBA/C9b/Mj/6ShlkjRkpiCpXZ+FHcd9mVdI6xartp
	HUKsUrpOAgoODh+G/OTAef5XyR2SqQe/wfhft0lxm9bbz5Ck7bqZZR7S0JLXVIe5
	Nlbp6lCM15JZRQahN4necmx7MvVj4huW7sOnz8T+O7CcrWqyWnI6rHLf744ttQve
	F2ZL15p7jKNmA96hXN757V6MpArY2xOFa+g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0xd23vn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 03:23:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304dd917645so1157497eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 20:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781234615; x=1781839415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/cSaD7TtRbyQmfmeTtYyf4+fdttmjWQdF4y83zbGbg=;
        b=Jf4b8/T8BG9fVDDlG+Kcm8LjCIjZRi81+6aYVOJsaQTsyyvAA+XrdtiKwr6dnxG+bR
         8XJqgFGTS6NtafpFb+Kz0nvBe+MORKCo8JS4FDodAyhdqvK+7xZV4dSkrCSD8VRYVgAq
         DjElHx2r7lT9OL6HP33TLFifGaE//H04oYuj8bdSQiacCwNVaNCAGIdSegkwFCqpywPD
         bI1K0CFa2G2egTZTBgZi4686XQnNyu5p7BzjeWv1GXhIhohPMYbumxTF+oJ2qSNhmcPy
         +f/LT+74odSg3Xl/CTNNtLR1Tm3LWiA4ZUzNRVkSNIOBC6FKm+1P/K46mFqim5sRWZ4x
         c9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781234615; x=1781839415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/cSaD7TtRbyQmfmeTtYyf4+fdttmjWQdF4y83zbGbg=;
        b=dsEyAl8pR8r8N2QVbJU7jyUyvTmYiU26i/z+noIYUC1MidUOYvhkOQhkf2iAXrXDQc
         UIHGZZCxb/PwhvGRT201AtRzhcgEqg2ZZ2wVoSebZUNofJ3rxm321FvYuuiJye9LphiK
         Fv9lF2bEWcVFw6ats+S1BeC8n35ic+hZhadoQcnEF+aWTT9OteQA5l/DqkRihS/7L2Bg
         aQ+nTOWyX3RCAxW2DVx5aToWB5kpHAGfV3UfhwaFA9bhTCD/pDKfYbNkjNfYpWP7wHiL
         fFZVbperq1chCcuI3wlKrbT8Udbk+tjWOzjb0DeCLmYhCRk6oGmcukGSCw8yS2g1gAr3
         VnXA==
X-Gm-Message-State: AOJu0Yy8aK9btebKwHbaZdpu13+uJa4RHTmvpnht+qeqMUIud7cvmI+l
	bNSWWW6sOsJi6kbcDbKz9bsCgqBOdnv1HeYjmHHecDNsWifs9IfD2+s/H5hkXtfDE7b+k/QP+C3
	jJWfEYEs0r5OX/uqXR6b/vPxasgVNlq268tI2dLyxaTvA18l594FeWAomqxyKk0p+3T6o1Q==
X-Gm-Gg: Acq92OH4QXS52dyJldZEAxakQjtMU/U8NpL625qt42bxysDe0zQSthSTKngO4XUi9H8
	Isr+05K2PnYC7RL3n+e4k9QJTQrshhZc2/M4ZBnTX8HIE404pP4G3t2qOQ9wWnB8P7SBqPcaanp
	TepdsgLF1FkhKvJln2moBj1KZMCcy3mz27V50Xl6ymviukX0DlorBPPUke463YscnNr3OVhBAr2
	Wjk0o5U3YWsa93KKezfO5WldiPN9cq1ZL4LQ1zT14T3REr9m6H9fBmZ8eq8caU45dOUE88QzbTv
	nOe3vrf4dP3FyyZS0DTdQfHcoX02r/qAXHXH8xCuqEtLXxA1ZL+AjdMrlmDgzqVIkDYBTeu3o5O
	Sd2z+T68jaBgUJQVrc2JITWpXoXoc5oEShxPr3GfMbSbRJ0ucl7xRQ01MFI/HPkB72nADu/H5+h
	s6
X-Received: by 2002:a05:7300:8cab:b0:304:6139:5a3e with SMTP id 5a478bee46e88-308200def3dmr687825eec.34.1781234615456;
        Thu, 11 Jun 2026 20:23:35 -0700 (PDT)
X-Received: by 2002:a05:7300:8cab:b0:304:6139:5a3e with SMTP id 5a478bee46e88-308200def3dmr687807eec.34.1781234614932;
        Thu, 11 Jun 2026 20:23:34 -0700 (PDT)
Received: from hu-yintang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f88bsm1491904eec.16.2026.06.11.20.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:23:34 -0700 (PDT)
From: Yingying Tang <yingying.tang@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com,
        yingying.tang@oss.qualcomm.com
Subject: [PATCH ath-next] Revert "wifi: ath12k: add panic handler"
Date: Thu, 11 Jun 2026 20:23:32 -0700
Message-ID: <20260612032332.2278338-1-yingying.tang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -o0n43hsg8dNi6bXBuGKPai0HgwN9-ED
X-Proofpoint-GUID: -o0n43hsg8dNi6bXBuGKPai0HgwN9-ED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAyOCBTYWx0ZWRfXw2PjPGWLQlR2
 ZtVhYaG9+iBwZo5ODjvinTaTpFgLb0RsEiAxlclyJ4TUqsXuCrCnJ11TgyeNTaKxGUisEFIRsUO
 Kre41yNyIMdKlv8BVeutRt58UsGVft96e8iLEB9Jg7eeZkN3tf2xDmAPZQDmBhYFuvlrK2lomXA
 2eqRRyJdbi2h+nDUvN0RGXXRed/m1pJdgMPENuFJEl2cw1rAJbfTXHrcjc8mrC/hdnOzlWmJNrH
 XXmXcDxO4zzZgRwov34vj2ziPyQnJoVeQDBEMVCmpkZ1aV9fZwQyyGP0rjVLJ0ivmN/xrwT8G5T
 qj8APkRcvzcTFE+5HD3FVMvnkK/TNEy/KkKooOTo0Sp4aVV9YrZzE2foLXIpag+CZKHW7dcQULk
 NydyAkmuAiVkogDW+bW947vBehxE/f1i7h/eS+kXQTe0iZFS1ovoYfDeZMGe9OthTCtP0bSUoU7
 W9Be5u+Muyj0AFCr1IA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAyOCBTYWx0ZWRfX7PMKCcpAM1JM
 kqZo8x8tZ5EWxlYUG8NCw8clo8iCx9/7K3o1X6spNDLMzH6/emnCdmRTYtmF/kJ9z5iz8jRbP6L
 5uhoPUv791WYbL34GPFUD4IgSqH9KX8=
X-Authority-Analysis: v=2.4 cv=O6UJeh9W c=1 sm=1 tr=0 ts=6a2b7bb8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=CAN3Sn-i8mXM1BMfvN0A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120028
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37692-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,m:yingying.tang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yingying.tang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yingying.tang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3B246766AF

This reverts commit 809055628bce824b7fe18331abb65e44d02b0ecf.

Call trace:
rcu_note_context_switch+0x4c4/0x508 (P)
__schedule+0xbc/0x1204
schedule+0x34/0x110
schedule_timeout+0x84/0x11c
__mhi_device_get_sync+0x164/0x228 [mhi]
mhi_device_get_sync+0x1c/0x3c [mhi]
ath12k_wifi7_pci_bus_wake_up+0x20/0x2c [ath12k_wifi7]
ath12k_pci_read32+0x58/0x350 [ath12k]
ath12k_pci_clear_dbg_registers+0x28/0xb8 [ath12k]
ath12k_pci_panic_handler+0x20/0x44 [ath12k] ath12k_core_panic_handler+0x28/0x3c [ath12k]
notifier_call_chain+0x78/0x1c0
atomic_notifier_call_chain+0x3c/0x5c

ath12k_core_panic_handler() is invoked via atomic_notifier_call_chain(),
which runs inside an RCU read-side critical section. The current code calls
ath12k_pci_sw_reset() synchronously from this context, which eventually
reaches mhi_device_get_sync() and schedule_timeout(), triggering a voluntary
context switch within RCU.

Revert change "wifi: ath12k: add panic handler" to avoid this issue.

Tested-on: WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 33 +-------------------------
 drivers/net/wireless/ath/ath12k/core.h |  3 ---
 drivers/net/wireless/ath/ath12k/hif.h  |  9 -------
 drivers/net/wireless/ath/ath12k/pci.c  |  8 -------
 4 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1a9866061f82..6705a8a73de1 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1793,29 +1793,6 @@ int ath12k_core_pre_init(struct ath12k_base *ab)
 	return 0;
 }
 
-static int ath12k_core_panic_handler(struct notifier_block *nb,
-				     unsigned long action, void *data)
-{
-	struct ath12k_base *ab = container_of(nb, struct ath12k_base,
-					      panic_nb);
-
-	return ath12k_hif_panic_handler(ab);
-}
-
-static int ath12k_core_panic_notifier_register(struct ath12k_base *ab)
-{
-	ab->panic_nb.notifier_call = ath12k_core_panic_handler;
-
-	return atomic_notifier_chain_register(&panic_notifier_list,
-					      &ab->panic_nb);
-}
-
-static void ath12k_core_panic_notifier_unregister(struct ath12k_base *ab)
-{
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &ab->panic_nb);
-}
-
 static inline
 bool ath12k_core_hw_group_create_ready(struct ath12k_hw_group *ag)
 {
@@ -2212,18 +2189,13 @@ int ath12k_core_init(struct ath12k_base *ab)
 	struct ath12k_hw_group *ag;
 	int ret;
 
-	ret = ath12k_core_panic_notifier_register(ab);
-	if (ret)
-		ath12k_warn(ab, "failed to register panic handler: %d\n", ret);
-
 	mutex_lock(&ath12k_hw_group_mutex);
 
 	ag = ath12k_core_hw_group_assign(ab);
 	if (!ag) {
 		mutex_unlock(&ath12k_hw_group_mutex);
 		ath12k_warn(ab, "unable to get hw group\n");
-		ret = -ENODEV;
-		goto err_unregister_notifier;
+		return -ENODEV;
 	}
 
 	mutex_unlock(&ath12k_hw_group_mutex);
@@ -2248,8 +2220,6 @@ int ath12k_core_init(struct ath12k_base *ab)
 
 err_unassign_hw_group:
 	ath12k_core_hw_group_unassign(ab);
-err_unregister_notifier:
-	ath12k_core_panic_notifier_unregister(ab);
 
 	return ret;
 }
@@ -2258,7 +2228,6 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 {
 	ath12k_core_hw_group_destroy(ab->ag);
 	ath12k_core_hw_group_unassign(ab);
-	ath12k_core_panic_notifier_unregister(ab);
 }
 
 void ath12k_core_free(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4edc8f4e0cb5..a81cb3032145 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -15,7 +15,6 @@
 #include <linux/ctype.h>
 #include <linux/firmware.h>
 #include <linux/of_reserved_mem.h>
-#include <linux/panic_notifier.h>
 #include <linux/average.h>
 #include <linux/of.h>
 #include <linux/rhashtable.h>
@@ -1121,8 +1120,6 @@ struct ath12k_base {
 
 #endif /* CONFIG_ACPI */
 
-	struct notifier_block panic_nb;
-
 	struct ath12k_hw_group *ag;
 	struct ath12k_wsi_info wsi_info;
 	enum ath12k_firmware_mode fw_mode;
diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
index e8840fab6061..42bb00c13ef3 100644
--- a/drivers/net/wireless/ath/ath12k/hif.h
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -30,7 +30,6 @@ struct ath12k_hif_ops {
 	void (*ce_irq_enable)(struct ath12k_base *ab);
 	void (*ce_irq_disable)(struct ath12k_base *ab);
 	void (*get_ce_msi_idx)(struct ath12k_base *ab, u32 ce_id, u32 *msi_idx);
-	int (*panic_handler)(struct ath12k_base *ab);
 	void (*coredump_download)(struct ath12k_base *ab);
 };
 
@@ -149,14 +148,6 @@ static inline void ath12k_hif_power_down(struct ath12k_base *ab, bool is_suspend
 	ab->hif.ops->power_down(ab, is_suspend);
 }
 
-static inline int ath12k_hif_panic_handler(struct ath12k_base *ab)
-{
-	if (!ab->hif.ops->panic_handler)
-		return NOTIFY_DONE;
-
-	return ab->hif.ops->panic_handler(ab);
-}
-
 static inline void ath12k_hif_coredump_download(struct ath12k_base *ab)
 {
 	if (ab->hif.ops->coredump_download)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 375277ca2b89..65a780e74d01 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1469,13 +1469,6 @@ void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend)
 	ath12k_pci_sw_reset(ab_pci->ab, false);
 }
 
-static int ath12k_pci_panic_handler(struct ath12k_base *ab)
-{
-	ath12k_pci_sw_reset(ab, false);
-
-	return NOTIFY_OK;
-}
-
 static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 	.start = ath12k_pci_start,
 	.stop = ath12k_pci_stop,
@@ -1493,7 +1486,6 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 	.ce_irq_enable = ath12k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath12k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath12k_pci_get_ce_msi_idx,
-	.panic_handler = ath12k_pci_panic_handler,
 #ifdef CONFIG_ATH12K_COREDUMP
 	.coredump_download = ath12k_pci_coredump_download,
 #endif
-- 
base-commit: 54a5b38e4396530e5b2f12b54d3844e860ab6784 

