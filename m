Return-Path: <linux-wireless+bounces-37549-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MJTFFIB3J2q9xgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37549-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 04:16:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B07FC65BD44
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 04:16:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=AcU+wiyU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=guGbr2MG;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37549-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37549-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75FA03048AC1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392C318B9D;
	Tue,  9 Jun 2026 02:11:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A99355055
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 02:11:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971069; cv=none; b=dsqqnRwWh1VX4gcDJWtb6F8jpYfxfKUFhWWYIhURmcnwDPFA8TCBbzOKtJGR3aSnNwkqXzkwzo/LqHEff4okoEX0VR/SRwnE1J0iWebGZmJ+2pgExD6Oh1IrVBodB2PBqOQcwELHd+XkLxvOJfCw6G2RAE3zd+1XBmeBYXAk0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971069; c=relaxed/simple;
	bh=OrIUEIqP9mygD60miaQMiBSmfcfGQTJbJcw9skXlE1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m08D/aO0gFhBnAWLLUJJO471CIhEcD/uJcD715LnpBSejU0wRjGgzcFxCJHSUo7uq+ULZtTDT5acB94aV5SeXVeXsA3pi1RpHeMmuDFh41b3ayxyiS8hyC3RhIgt/TH5MfiTOaAy61PKuUxwYStKLrKjaxY2Wj4rO2ApoEWG3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AcU+wiyU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=guGbr2MG; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6590sALm659904
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 02:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uwrSuIMmbqrknpXMqXOsdq
	382dCBhvSP7g6NvTXH1oo=; b=AcU+wiyUyXb0b3m6IplOcPwV5jrmbrV+eas+mb
	lwQ7NMX/GcKiTvgvD8WZR60GQCXQLJr6k7qMHN0LLT+vXvjL1PzOoL5Urtj5zff7
	AMQxXuCeajW4kWo3ABRQr1cKEwJdttdW1jGsgs7OSDoIk03L+ZXV3Zdec2jSQNsd
	Bx7II4C5ofuioJDCU8XU2JXDLRFlB7wrwYcq2okijDNZZ6Pb7JeeqOvEYF5288eE
	A6R8WiJqpdjbypt5lsEoAp4HHN5Bnqu46TUGvIbgNuQ4c2pZjh0CwvJoc3ZA1nwW
	uQfhNXhs9P2GdwpwZ4b64wgdmlE3UX8b85HpWyQ1DdcdDxHg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envajbn11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 02:11:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0bf6904a6so70733235ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 19:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780971067; x=1781575867; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uwrSuIMmbqrknpXMqXOsdq382dCBhvSP7g6NvTXH1oo=;
        b=guGbr2MG1TtLxw/P4tUN1xrMlMLs7X1VnQN+/nDtwx6rvx4pttJcGRohhQcLh+lgTh
         OrwWy5vWMORzCR8R3Fzj/0iBh4bXDtnT8fHXmPXosoaLA4LAgDccSJXy4pjZFaKqVURK
         Ht0s+O+lnPH+Ir2dM5y/L9RAwkkz/RxpauhWlzKG/fkSXlBTbE9qp2metPsT4CRlr7hJ
         E1doyXxeEgsLKLZjfScDf829b1aD9W0LovraGugHWwgc/kLx8rAOA9TZlLwH9Nh2U2Ra
         Pf//BJGay7AOcXG5ScU2jt8HnaX/Qvh5SH3JiIThCAq2JynXp5vLhmyQSIO+Ku7aTztT
         pPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780971067; x=1781575867;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwrSuIMmbqrknpXMqXOsdq382dCBhvSP7g6NvTXH1oo=;
        b=FmOpuGYusgG5NA2kokZ5FSagNLI4AUZ2BMykcLSWfoX2JgE9XgU9Y4fV59GPd2JqJ+
         ab3wQM6QrmW2Y2ydoyF0GwTb2QXam/eCNPM3T1TRAkpjLKxeujZZnQGmfk9Pc6mUDVxx
         g5VbpVp4UiRIeqLuosY9SsQYX66r4I2T4MG/gTw/PV6nFeHL0CzyMOoeu9LLT3tL+HdE
         K5xPWYthuVVkO6PyDnijiCv6pOwFixfQD6hR7glJf1PBwSxwTJuQJtXx0x8IDOegbbMI
         t40J3KySSdWW2BiYKDv7XzPZg+aJMKqcIJdUrlICNqjAqVL7fCW1734mnGy0iSj30drU
         3xew==
X-Gm-Message-State: AOJu0YyaZLZcFFyhn1QVWg/rWXniXiG9nwinyZBdhABb8rU7S2KeS7wQ
	LMzlXLOJRAfQmssSVmbiIl9IQQy7hfM0wDI5T2dI11tmF+gv6Ii9urABvBkI4dllP4nrg6MJzSg
	ZayePir4pki8SZIHzcHIf/74ziYw7y4yyn3SKLOkM8V3T7jcFWNrF2WvztdtVEplSoTZSyWD8Dp
	Ui/A==
X-Gm-Gg: Acq92OHkfcwNB2e1K8jP5RYvuE6UXPc/ayfLLrBW9FXS19pZG1CS7kecCo8vWenERwS
	S6Zz9m9rAiusj+MO4QVikQ68N3jwCYMXLNC08KPBHITuKz1wRU7BzfG9aF/QHv4nUk4cwXYH1wW
	GSAkV5hGVQeGhg/m3GtWPHRyL25V2bCozSE95dl3+xiro8nTKN/ZBKTqMYZl15uLouRyPPSf2ba
	hdxbP0MSliSxpkJF8PkycT7KoEyuL8iRQa5fkTOa2wqHcZU24ZPxR+mpDVcfNChkFpOVSbYe/lf
	Bi61YYbbyjVw1YBUfPbs+mAva1YVgliAqf7+00D5QWREHKSZh4dI1krvNP8sJTcVP/9fP+vYOGc
	Axi0Vw748Jn3hicNwwkWK9PvimywPpKx9GfsSY34C4Bf+8A5VfSTIrnzrSIhSUUzIgajjzzI2DH
	1kfewGt/aAOw==
X-Received: by 2002:a05:6a20:244c:b0:3b2:924c:567d with SMTP id adf61e73a8af0-3b4cd0a5175mr20765090637.46.1780971067250;
        Mon, 08 Jun 2026 19:11:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:244c:b0:3b2:924c:567d with SMTP id adf61e73a8af0-3b4cd0a5175mr20765048637.46.1780971066678;
        Mon, 08 Jun 2026 19:11:06 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b374fsm16507525a12.25.2026.06.08.19.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:11:06 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 10:10:47 +0800
Subject: [PATCH ath-current] wifi: ath12k: fix EAPOL TX failure caused by
 stale tcl_metadata bits
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ath12k-fix-eapol-tcl-metadata-v1-1-d47e6f90d4ee@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACZ2J2oC/42NSw6DMBBDr4Jm3UEk5VdWvUfFYgiTEhUITQJqh
 bh7I07QjSXLz/YOnp1hD02yg+PNeGPnaMQlATXQ/GQ0ffQgM1lmhayRwiDkC7X5INNiRwxqxIk
 D9RQIO+p0dSuqrJRXiBuL40ie+w+IVVSrczwHaGM4GB+s+57fmziRP282gQIrVlrnORdl3d+t9
 +l7pVHZaUqjQHscxw8c6O073gAAAA==
X-Change-ID: 20260528-ath12k-fix-eapol-tcl-metadata-babf79570623
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: OBdIbIaQ8XzJ3e6lFx0ntlYzomEGnyYX
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a27763b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cCjBz35ZmROaddx3XiUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: OBdIbIaQ8XzJ3e6lFx0ntlYzomEGnyYX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAxOCBTYWx0ZWRfX+49z25xACV2O
 mXKR2cEp3x1FEmRk1fhpnJ03V4KwVtXpO8kkBtSMKmmQR+CzaOuTGDJf/wb/CDs9QBdulDeOjYZ
 HCOVszo6gENiw7fLMRx+3a6z1gR9g1S/0wPIUjjz/QuPpduzHgxKE355f+Be4ru021am+pS4j78
 sqfwgVWCEMr2mIDVau1IiuNxHiEGQzpw7/bdZDLhs38/8x7twRxsu3RHk1fzHdjDFb9fDPv1bmL
 Kji4OupsNs7obnhf4SJoGfVdAgQkaxlwxsCxi1iT2+ifG2JvVOpRpKh7643MmwOBazeBRBAqmpA
 68Ubfuub9gVTeOr0k2XHP9sS58JnJP4OZE/C/jpiii0m4T59fgZ7wMUPjXCKGRajX4MY2NuGCXL
 O3ZXMCxyM5PTBOw15tpxrunhl9Wv/q1q+tJHdt/brj/lq2FkmJs82D/xLD98n9LMIfuUuhb8H5i
 T8jMTQtp6b4iXo3C/7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090018
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37549-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B07FC65BD44

On WCN7850, after the following sequence:

  1. load ath12k and connect to a non-MLO AP
  2. disconnect and connect to an MLO AP
  3. disconnect and reconnect to the non-MLO AP

the third connection always fails with a 4-Way handshake timeout. The
supplicant transmits message 2 of 4 four times in response to AP
retries of message 1, but the AP never sees any of them.

ath12k_dp_vdev_tx_attach() composes dp_link_vif->tcl_metadata using |=,
but dp_link_vif is embedded in struct ath12k_dp_vif and its slots are
reused across vif/peer teardown and setup. Since tcl_metadata is never
cleared on detach, vdev_id bits from a previous attach remain set when
the same link slot is reused with a different vdev_id. In this specific
issue, the same link slot is used for vdev_id 0, then vdev_id 1, then
vdev_id 0 again, the OR yields tcl_metadata == 0x9, which encodes
vdev_id 1 in the HTT_TCL_META_DATA_VDEV_ID field even though
ti.vdev_id is 0. Firmware then routes the EAPOL frame to the wrong
vdev and the AP never receives message 2.

Use plain assignment instead of |= so the field is fully recomputed
from the current arvif on every attach.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

Fixes: af66c7640cf9 ("wifi: ath12k: Refactor ath12k_vif structure")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 90802ed1aa59..af5f11fc1d84 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -943,11 +943,11 @@ void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(&ahvif->dp_vif, link_id);
 
-	dp_link_vif->tcl_metadata |= u32_encode_bits(1, HTT_TCL_META_DATA_TYPE) |
-				     u32_encode_bits(arvif->vdev_id,
-						     HTT_TCL_META_DATA_VDEV_ID) |
-				     u32_encode_bits(ar->pdev->pdev_id,
-						     HTT_TCL_META_DATA_PDEV_ID);
+	dp_link_vif->tcl_metadata = u32_encode_bits(1, HTT_TCL_META_DATA_TYPE) |
+				    u32_encode_bits(arvif->vdev_id,
+						    HTT_TCL_META_DATA_VDEV_ID) |
+				    u32_encode_bits(ar->pdev->pdev_id,
+						    HTT_TCL_META_DATA_PDEV_ID);
 
 	/* set HTT extension valid bit to 0 by default */
 	dp_link_vif->tcl_metadata &= ~HTT_TCL_META_DATA_VALID_HTT;

---
base-commit: 2e9422a6a2d8bf4036287c2fd3b034392af64048
change-id: 20260528-ath12k-fix-eapol-tcl-metadata-babf79570623

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


