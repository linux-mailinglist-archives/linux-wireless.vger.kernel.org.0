Return-Path: <linux-wireless+bounces-32293-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH1nCKJ5oWkUtgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32293-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:01:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD541B6514
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB8D30097CF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F223126DA;
	Fri, 27 Feb 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VPqY7XiI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sn8MlhNp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F31F5842
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772190093; cv=none; b=niu2coDNZUAeujk1WJlJ4fLCbhmp2NLbyovKBxYr80otRuZFTSw9spjgpZ+xZ0lqkCpivOzBgSpJaghf9sD9Ih4kjDvnkFOyjSwH0qp+cyuOddznjtsF95kOhlCr/5PMfnRsX2Mz+ugtRAr67SX0IBDJs1UpKCKc4CpPyDVq24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772190093; c=relaxed/simple;
	bh=Boid342gEQ8cUXgzn4A0vGGjabUIVpNQWVIFcgTfxqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OQNIFjRU58T6QCGhaWkA7Lp8D+yIWjvZ0hdyd/HX1qcycgUzXiXQuxa3BienzdaL56Ka9ZM8kiWFWBlTy1lYV6yhsPDA2K4PK+i9IcnzlD72dsaKjNujzfPWfCCSexOp3C0uhleaKKHLvDGOmeMd3Nmavqizw5Yvwiei0nYekIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VPqY7XiI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sn8MlhNp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R7fSOL2308428
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 11:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=prqlnNROXOp7LckJ0dWlSLM58OOvbPBFUlf
	Cs8lCkEo=; b=VPqY7XiIy21vmiLgpQ+bSCKvw18VHD1Fc9N1CokJoW2gO7dyMid
	NzQoHolvHn9DZxBRrfA1GS+ftA76lvfwpbA3pXNrs3Ql+qAYBpDY/YiM1NdaT3Kq
	6nPLfu9Jm+dBxQLRtb5oPJ8+qeeOss7gtCA0K7xSTlCxReQZqTVPd+T+W7tPYqhz
	BFNIKB2/f/UHbxWCg3DzR7Ik+dGMQBP8TuBiCODXYxh4tRQrBnFguMiuBxWo5jnv
	bdEgv+q+3JU25VIO6Eelr9wQgYqMI0kIsxTaw/WRTh59q/xmfQTt+D2o+JafjI25
	J8UO+b7Fp4SAnZnvrZlJJC4UfmSIH6SXv1w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck73q0m0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 11:01:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adaa9c4b89so32248765ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772190090; x=1772794890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=prqlnNROXOp7LckJ0dWlSLM58OOvbPBFUlfCs8lCkEo=;
        b=Sn8MlhNpIfPfPzL8W+hg09juLWEA2GCc30K0dYq3cIoddGCDEKZaeKuvPTngIUIr8J
         2k9PpbkTvPQwryCQF2akSWHkPggNpnJVqLb96scECasuaGxacJxSsiWzK9FsQxqMGl1M
         DVDBaT0387TbvoHcpUtSUTfrqEVmwnzowtrNhLAi+b4W35x/SgBd8VbB9cJua/49eeyM
         KMTqrG5oBpbcbjC3cRulRP0Yna71RvOEl2ldZP0n+lfO/6UO/d23rZQpA6wibw5fFoR7
         3AoTx31UMuA+iHNRIxCVFvP/4RC7zicprcZgAZIOltRHMmxAs0gb7nNZRjz88sXZNXZS
         OY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772190090; x=1772794890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prqlnNROXOp7LckJ0dWlSLM58OOvbPBFUlfCs8lCkEo=;
        b=FFsGBNdj2gzK2KtTyXH5jPK9FJrkmw3ECqD65yJKf2RZceQmB/yruzMYm2xp1f4Pb4
         w6xS8X2FLQArcUsMHAuoNu2Vnr5RnVhN14qOorvDZ6msub+p0E39xpyh82hkNn9w6nfy
         5frU5aHCaLtyeX8wVWPyLhUbJm94yH5oL/rnFBprKdMmMThnZUyqI07Af7ByDVCFiV6e
         1DtSKfhEQA5gblwsNUk5ZSBLg4PxN3LMQTDD9Ux4lEVm1VmYkTU7MXAEzu/qRbc8RESq
         kDBQ/hHRmNwwyUTboIjSpftlF3kDOIcKsA4DgGw7erqGPVuFCqFIuvgIfAgFUjbo7Epb
         YYJA==
X-Gm-Message-State: AOJu0Yx21lj8iq4B8PeQoJt/LVtat4loviKQV3aLFuWcb0Eg2uL+4W2x
	kNcOlpEGfqKJVY9GdxPaENAgB8ZeL90tDaFChd80rF1ut9JWpmdAUBYiWxXvSo9V8BCo7tIZeiI
	mZtLcliGwsigJe0ydO7HIKGyxLz1NX/mybOoIDaoImymDglrJBirOhhcpWAF/g6SHzIUwNg==
X-Gm-Gg: ATEYQzwdUQjv3Mw+gvnF6MKhTiar3Bk2LsRlMR9vAofru46gMEv5DixsIpJhzkHC5Y8
	u6MRzplZaWr/pxwEVILK3CqFX1TVinsfwBKptGZByQdMPAqCedULdkzVcG0tSio2+t0E5yfvaoU
	ugpUb+k/uOAUNRXEWpNL2Qk44bQBeqcogAChbsxRXiJYk0m6zuV/4fUdR8R3/JtrsChpy5At1KO
	mp4/5tzA59wU0/RqqZEw93QcrqH4eS2xbKM8xkWFIuyI5nuLRPpmFz3TTeu4IgJFxgMyN49sV6L
	xlAQN8FTKq6Pd6dMm2uv2Fvn/jurCPsFJuaDH9FOW7ZqyTIcX53m1Y9tyosQHuR8ZbNt8k0mFqh
	hwK0CZDP4NtbPHIn0H+zfaBAmO/RakC8V0Rs4l3fdQPM3kXNQ0Y4FjPVptS2b+rnd8uD3S3rPh4
	Biqda2+YoGpVLxptAHno42mu46gfgU9URMwzqXMicYm0ShkA==
X-Received: by 2002:a17:903:1212:b0:2a7:b412:6cc8 with SMTP id d9443c01a7336-2adf78db360mr58835305ad.1.1772190089872;
        Fri, 27 Feb 2026 03:01:29 -0800 (PST)
X-Received: by 2002:a17:903:1212:b0:2a7:b412:6cc8 with SMTP id d9443c01a7336-2adf78db360mr58835055ad.1.1772190089333;
        Fri, 27 Feb 2026 03:01:29 -0800 (PST)
Received: from hu-rrajkuma-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c2e4bsm78671365ad.32.2026.02.27.03.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 03:01:28 -0800 (PST)
From: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Pass the correct value of each TID during a stop AMPDU session
Date: Fri, 27 Feb 2026 16:31:23 +0530
Message-Id: <20260227110123.3726354-1-reshma.rajkumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5NiBTYWx0ZWRfXy0ASs9j0nLoO
 D3gYNSZQDt/eZw4CopembCm7Xu8275Pruk6bsUFcMOOf40w67rtGwDQ1VxrkT9JwMuWokOQ3Lig
 0dy+BbQPwX1+Rxj4sF+4emzX+Suq4Wxnp8sQxx+W6fxB+uJ9kvvvjYkkg82PViY+ckzsl2LV0qr
 XhLGDFVNTzQnK1a4QMU5f6K19ifx2dXToCKgr8FNYlzQxAhoCqWH3+BFOv+8KXK2f0d9CYeUN3f
 NpNy5L+/w/kL4x0GiaFm/Aira7YfixA6fLK4Jd/9NgJQBuhS1GZ7XXiKTR6K/Ack07zOymu2O2N
 AofJlNYTIb9k9siS4r245gu9oYeou5RlDG6NcIS/ZD0/6TRaalZPY8lJN/QXWSMJJJOsvL+R/cn
 AkxxEnmx1WdCi722lY0OHoL8+W5aIIN+0yo0N1WAgz1dFZEm3+Iblc2AJi7fVu3Gzi3QpNsdfnH
 cs/dTo+0CjILWWR2RIQ==
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69a1798a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vkfXM0Oplov9zySb:21 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YS8j5bCp7OpU4X8Xtr0A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 4uAcP7MGjGNhDFnXPCegde7gB7mGiLVi
X-Proofpoint-GUID: 4uAcP7MGjGNhDFnXPCegde7gB7mGiLVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270096
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32293-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[reshma.rajkumar@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4AD541B6514
X-Rspamd-Action: no action

With traffic ongoing for data TID [TID 0], an DELBA request to
stop AMPDU for the BA session was received on management TID [TID 4].
The corresponding TID number was incorrectly passed to stop the BA session,
resulting in the BA session for data TIDs being stopped and the BA size
being reduced to 1, causing an overall dip in TCP throughput.

Fix this issue by passing the correct argument from
ath12k_dp_rx_ampdu_stop() to ath12k_dp_arch_peer_rx_tid_reo_update()
during an AMPDU stop session. Instead of passing peer->dp_peer->rx_tid,
which is the base address of the array, corresponding to TID 0, pass
the value of &peer->dp_peer->rx_tid[params->tid]. With this, the
different TID numbers are accounted for.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
---
v2:
* modify 'ADDBA' to 'DELBA' request in commit message
 drivers/net/wireless/ath/ath12k/dp_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a32ee9f8061a..640f752eaa03 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -735,6 +735,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(params->sta);
+	struct ath12k_dp_rx_tid *rx_tid;
 	struct ath12k_link_sta *arsta;
 	int vdev_id;
 	bool active;
@@ -770,7 +771,8 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 		return 0;
 	}
 
-	ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, peer->dp_peer->rx_tid,
+	rx_tid = &peer->dp_peer->rx_tid[params->tid];
+	ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, rx_tid,
 						    1, 0, false);
 	spin_unlock_bh(&dp->dp_lock);
 	if (ret) {

base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.34.1


