Return-Path: <linux-wireless+bounces-34199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA60BIvhymnEAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:48:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0F36123E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AAF3302EEAB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F00396B73;
	Mon, 30 Mar 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETAEACna";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXu5PYUM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6E3A6F1E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903184; cv=none; b=d2tKQFD2sYwKTKEQ4ZCwZgegFkBusbIXF433HKQIpIsg0t2Aa3JAIG6sJE+fRJDjLiZzwZwHXG8JyS6R+wWpBT4GF0VFSoLSQFPogZO7kfmObQKBHs/d3hqBS/koBmayD8F6znGauwn92JduAB1iYSuXW9R0rFCJpPSuHdxqEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903184; c=relaxed/simple;
	bh=nrvVvbe04rz89echh+gNgVl/hbrlbKXffD7YlpyqvWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvkpv0AOtg5xOJxCc6SmMtni5Fi4L4+VHLdxJsk8e6J/ca++jTsqkyS2pU7ec9b5ytz8RvzLMznElEILBCe4rx7NgEIWuqzmsJmJaKYt1JhTq4OwYcO2uk5ixX8r14GZzEi4S+OAc9X2DsWz1sYlpIRh+OGYRG4HRMYcTQWgyhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETAEACna; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXu5PYUM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UEOKrl1557463
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i/MVEIY36FHTkZc/aDnAH9tjdCOidmJdEoxNpNn+WXI=; b=ETAEACnauPpy6SGw
	6GjCMXQ4lCkR4iR2zQwYAg4wbKOLuSHa0+i7sPhr+gVYR4hbEQIMD62ZQlLsU7s8
	MK7I1Aq7fC++yavzQFAisOxdgNcydIYBieS8IfUeAyOuKLnS7zAl/bBJkvQbVD/8
	OHhfDG0ODfb1P7aLjsCZEh9AEfVR12ZZ9mU3+9yFJ1jzChABzg2u5XHDRYrUJSVc
	labKCTAMNzbwSLI7JFdO5FEf9YEToEWB1XtkXOu5NTapkirW9wFdXqjMr7i0+RSZ
	L8ersC3y8RitliWZvqeSEDtyL0DoVO+2WEct6ISM8kXBUFSVv5J9CKYbzgNvLQ5q
	1eKiog==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7twm1e4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0b339b8dbso67356915ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774903180; x=1775507980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/MVEIY36FHTkZc/aDnAH9tjdCOidmJdEoxNpNn+WXI=;
        b=LXu5PYUMnqMi8par/3ZMPsu/QigyOo8GjUfs4hKLXLZOhMCOH7mCKR22zTRTizdRLZ
         38mFItaCul/inNwh0OdFxpPr2wKfWB0eGVxHPTQp6RWiByjeKecY0yE/tRW84pGGclYA
         CSz3l0xhvfY/P963qJdPiGYlG6WYO6YCGQ6IMJufymCshKpdIK0UIUD8Mv1r3fY/RAHM
         +kPiaelWH96iFOaHEImA2AMfO9RNRw82FbrL2Af3l3rTPft9GUjiL/QqaMlm9InFcG+S
         lcx50QOiOPf8/gIw/GJ39CCQP3IfOxI/pvRt/RKhLOB6Il338rnRIIgdPKDsOkefhTtM
         Punw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903180; x=1775507980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/MVEIY36FHTkZc/aDnAH9tjdCOidmJdEoxNpNn+WXI=;
        b=AAWLoVs+SugaHcNfRJvxK9nGzQnSUTK4Jl36IgjP92okyg7C9MQir6sChsdVydno47
         PSQWFxTlUiOjdYVmXbOBc1BCt66ClP6RMhh7XsIB0YTR0D5ff41mOku0c4AZILoomiP4
         0pVnt6iF6KU8HyNOVoe0E3R2s9xq2asnJYGHIsx6RH21lJ4mKFHms0DuOr9JauXIl2kz
         SudR/R8wbrSgnD7HUPunZvRwtU4Q/chE5Nm5l+b5q5E84mgRty2772IWFtysdQ/Dsvp7
         sj0nrtHVX7YnoxDUlvkG5B94zLbbqh/CpIV5+2CjsITSISaFB5DWBYOBosIECtXys34H
         6BSA==
X-Gm-Message-State: AOJu0Yx4B6dkqDufyu95grcI7KE35Fv+2YYQuA47vsU3Kb6oTvG/rLC2
	opse60aWoCRJgm2BPHYX0sDGw6Gtau3i40kJqLSuWQNSXat3qNN357b0LbKSMB89fvoUvZZwizl
	OefORLuFbfS3U28veYTv2YumRZWMdjG+UMhQccHRibEWCFdyluOkZ2Oo9Y4CkwCIlQwYVjA==
X-Gm-Gg: ATEYQzwRZvR45FuvlsvHf0t9DVsSduKQ7ySM5PQ64g+fnigwrhL7FMTQ9HZiKl4joGC
	+4gImQuHkqkDQdyp1kno3DN2rWijichzB3NnaYZseaIkUDp0v9f0rPtKodQ8cc9pNwPiTUrjulv
	LtGSGwsbiPE7ql8BqX3nYReX2E/qs2qqw9HYzhaG6mwTr5tY16zZQKX/NAxKPs2Fv/Bosyzvm5z
	y1pHu01hs8UlQzK50tK1WHJ7VBRRdlWeoWJjQYw12nLofhQarzPrmM/g2SJlARLah02zp6GJuRC
	QuJBcdDkdXTcYqENimU28AnKHaHgjACydnX9a3OscJzkAxjkeKVL9aTXP3sN5DNCU6lJz9jOpNK
	gQeyYZo9HOJuELr4rn1svfNoHxACQNumfahB8w0sFnxbcwe2aIUAjvOjoCYD3yE4gpSsdgXGdBO
	XFagaw8jrgRCTiov5tfgmchYoFqP6jwezOPd2ZLlE=
X-Received: by 2002:a17:903:3d0f:b0:2b0:49e6:9622 with SMTP id d9443c01a7336-2b0cdcde5ecmr136744715ad.37.1774903179982;
        Mon, 30 Mar 2026 13:39:39 -0700 (PDT)
X-Received: by 2002:a17:903:3d0f:b0:2b0:49e6:9622 with SMTP id d9443c01a7336-2b0cdcde5ecmr136744345ad.37.1774903179465;
        Mon, 30 Mar 2026 13:39:39 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm113517195ad.78.2026.03.30.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:39:39 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:09:11 +0530
Subject: [PATCH ath-next v3 6/6] wifi: ath12k: Enable IPQ5424 WiFi device
 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ath12k-ipq5424-v3-6-1455b9cae29c@oss.qualcomm.com>
References: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
In-Reply-To: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=IJoPywvG c=1 sm=1 tr=0 ts=69cadf8d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=x73wdjvOoWb_6dWcbhYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VvnL1lW1ryG8tEOuKl9mitveFiLhxxKi
X-Proofpoint-ORIG-GUID: VvnL1lW1ryG8tEOuKl9mitveFiLhxxKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfX8j7ACAoM0DFb
 tlZeBtvdeaVccz/RudCwmPNwq1ybdtLlRlGySPgkmgAPbe/TBYGCw9zL8ZcwFTzN77LJy0RoZN0
 Qd+oRYuqgAD1GOnh3iWEadEVERHc1jR70xRlWNorcGr7Ef+gXkA7JoOzUGxqI9ToDba+k2lmGS/
 gwt2bCJHRx4qIoRe29RXoz7a8YMSafLeCdKMiXjJ4RmD+gYzCmUKdm1LLReW5CGJUYfzsDa59Ia
 oMw/S3LdrLSCgqLYEzgfNPZLXyVqBdKASlHEs0ykRnLMf00DSFwB/tMK2S25v1muMTqOnJKpogf
 k7Gsh0oDZkAUGUA3D5EHVpELztyxWKNhAV2FKAL6qw1p5vn0xm/OIBV5XVnw1KcEh36A0rst18a
 b329OMLkpTu4CguwPN7iz2TZMyG79pqqFcwo2TDMJCvX+vDi5ENFoMt9e4ZztIouvwLeTM5R3gu
 M53NwbPsae6ddd9NQlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300174
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34199-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,quicinc.com:email,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7CD0F36123E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>

Currently, ath12k AHB (in IPQ5332) uses SCM calls to authenticate the
firmware image to bring up userpd. From IPQ5424 onwards, Q6 firmware can
directly communicate with the Trusted Management Engine - Lite (TME-L),
eliminating the need for SCM calls for userpd bring-up.

Hence, to enable IPQ5424 device support, use qcom_mdt_load_no_init() and
skip the SCM call as Q6 will directly authenticate the userpd firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
Co-developed-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c       | 36 ++++++++++++++++++-----------
 drivers/net/wireless/ath/ath12k/ahb.h       |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c |  8 +++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 9a4d34e49104..2dcf0a52e4c1 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -382,8 +382,12 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		ATH12K_AHB_UPD_SWID;
 
 	/* Load FW image to a reserved memory location */
-	ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region, mem_phys, mem_size,
-			    &mem_phys);
+	if (ab_ahb->scm_auth_enabled)
+		ret = qcom_mdt_load(dev, fw, fw_name, pasid, mem_region,
+				    mem_phys, mem_size, &mem_phys);
+	else
+		ret = qcom_mdt_load_no_init(dev, fw, fw_name, mem_region,
+					    mem_phys, mem_size, &mem_phys);
 	if (ret) {
 		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
 		goto err_fw;
@@ -414,11 +418,13 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 		goto err_fw2;
 	}
 
-	/* Authenticate FW image using peripheral ID */
-	ret = qcom_scm_pas_auth_and_reset(pasid);
-	if (ret) {
-		ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
-		goto err_fw2;
+	if (ab_ahb->scm_auth_enabled) {
+		/* Authenticate FW image using peripheral ID */
+		ret = qcom_scm_pas_auth_and_reset(pasid);
+		if (ret) {
+			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
+			goto err_fw2;
+		}
 	}
 
 	/* Instruct Q6 to spawn userPD thread */
@@ -475,13 +481,15 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
 
 	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit), 0);
 
-	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
-		ATH12K_AHB_UPD_SWID;
-	/* Release the firmware */
-	ret = qcom_scm_pas_shutdown(pasid);
-	if (ret)
-		ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
-			   ab_ahb->userpd_id, ret);
+	if (ab_ahb->scm_auth_enabled) {
+		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
+			 ATH12K_AHB_UPD_SWID;
+		/* Release the firmware */
+		ret = qcom_scm_pas_shutdown(pasid);
+		if (ret)
+			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
+				   ab_ahb->userpd_id);
+	}
 }
 
 static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index be9e31b3682d..0fa15daaa3e6 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -68,6 +68,7 @@ struct ath12k_ahb {
 	int userpd_irq_num[ATH12K_USERPD_MAX_IRQ];
 	const struct ath12k_ahb_ops *ahb_ops;
 	const struct ath12k_ahb_device_family_ops *device_family_ops;
+	bool scm_auth_enabled;
 };
 
 struct ath12k_ahb_driver {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/ahb.c b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
index a6c5f7689edd..6a8b8b2a56f9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/ahb.c
@@ -19,6 +19,9 @@ static const struct of_device_id ath12k_wifi7_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq5332-wifi",
 	  .data = (void *)ATH12K_HW_IPQ5332_HW10,
 	},
+	{ .compatible = "qcom,ipq5424-wifi",
+	  .data = (void *)ATH12K_HW_IPQ5424_HW10,
+	},
 	{ }
 };
 
@@ -38,6 +41,11 @@ static int ath12k_wifi7_ahb_probe(struct platform_device *pdev)
 	switch (hw_rev) {
 	case ATH12K_HW_IPQ5332_HW10:
 		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
+		ab_ahb->scm_auth_enabled = true;
+		break;
+	case ATH12K_HW_IPQ5424_HW10:
+		ab_ahb->userpd_id = ATH12K_IPQ5332_USERPD_ID;
+		ab_ahb->scm_auth_enabled = false;
 		break;
 	default:
 		return -EOPNOTSUPP;

-- 
2.34.1


