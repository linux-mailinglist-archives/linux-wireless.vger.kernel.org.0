Return-Path: <linux-wireless+bounces-34429-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAf8JdmV1GknvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34429-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:27:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 552CC3A9F16
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89AEE30211AB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB137AA66;
	Tue,  7 Apr 2026 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNcxkF8n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JnHrx03Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0A379EF5
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539624; cv=none; b=mf/X0u9XMMsHO2spHo2O+Kv1hcZZ+vKcJNGkDgzZXeyFzowwqwcKcmwEvtHuRpZrAP8GtwQnzdfIqfHmwKF38zFGMia+m0MueJR8FZs1V6S8YJkZ9vi2mW5I4E8Wxq55J8CEMajuKsbhO1O7EhNx9ZgRsiKOgvBY4Bl9WkRNlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539624; c=relaxed/simple;
	bh=+62ITycpRP89Kf0YNZjOTsjg6cJ+xvcqSfE20qdx4sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQHuQa4EkQU7m/pICP/Jld91yJvCzLkL6gfSdEvOqzaCb6pF5lVXsSvt1J3ne2rbcQah/nBQbJqLNJ76DR1v+KHIYvv9VNUDbWBHGCeGac12xf86zmYR6hDVS+jSmuFU7EJ0H4aTEq1ri93dB8WzLrs0OSfefkfODlQJROlm1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GNcxkF8n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JnHrx03Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LRle12009327
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 05:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TFU+VhBzRJeenl+VRPF3v3N81A+uPDq1V4VHj9wAE7U=; b=GNcxkF8noMHRludh
	nWfTqDUoJq/yoGzuQq2o5/RH4ISv7h7h9c/ghCn4oLhV3xAM6NGn1MjMkUYgQEnS
	+DqwZ0mKcPHN36hxt7p4ZPCRZMPhEKaHYXWBE3ckFiMl2j/PcVTCIKs2WJLT+/l4
	zfE7xdsZv4s0Xn4779TGojhhFRLaonHxKqbC+7tc010RRn6iIbdKovQIJw9bWFTV
	mQ4fMYUA4L/jGeCbj0O10qc9znHWF2IBIHbuTNlEJrBNHiHuq6BFWjvaWXDEyfqM
	x5xFqO0/mJcpifu2W6JAd5SkPs71wgVRCiRoowzsOOdNxJME1TFEnowRgxrw51TR
	IIVmww==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrs55c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:27:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a855dc82aso2767871b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539621; x=1776144421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFU+VhBzRJeenl+VRPF3v3N81A+uPDq1V4VHj9wAE7U=;
        b=JnHrx03Zr+B1/nTt2B8XmQ4iymGS2rty0Fvf58VHxpPnY8TEe55gwXrJ2Ut85nJFhu
         mQmiuBw0oXEaI308ff0varCsSRajX050mzKKESfl7JmtYgNsFRBglUtT7Op0iPbFjRl5
         FO5aqyLsjyNnlSEQJA4w8W2Y2ElHr+trGEpLX68kwKT0x5am0zdz+3MYfDnkwVgvm4D7
         VMVIPA0owAPgwnjHmS1vtoo2rVWYtRtl0c7bdE8f+Wdo7hczYCvF7do04WoZ04SGE4dS
         ZwZID9pBuvA0XBRN5iSNWC/TMkNDogg0zT+wyIYppoxFqwJfYyRsaqRO3QmwBKfQ2Hd4
         5bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539621; x=1776144421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TFU+VhBzRJeenl+VRPF3v3N81A+uPDq1V4VHj9wAE7U=;
        b=lbd+CHzBT7u8Fv1oZHwUJy5DB3LsfwLM3n7+AYWMmyh9U33GPwl2viq8PwHuM36tqc
         FZLRGjFgNlkdlYQR3K95NscIT7neaZM5kPmJpRfES/5NAeN/PitW+yd7w7cI3+drQ5tH
         Cr5GdDiYWyrmp2V/z27tT5nTP4zZHic9CIGblFVALL/eA5VdfX9WBfGvLNF2LEi7Q+lX
         sv7qaqnEJFZeNLM8++Am5r2hpZz5hVD3m1mJ7tYk12dlP0zeDMYeLJ3q6v+QF5V7yt5X
         qh9dSAMXH5hYeKNMgiCJcA3nF2ww/Sel8TwcxCKE/Gf0QpsFLmp0Wh/0IPdZ7EW4hBfb
         sTHA==
X-Gm-Message-State: AOJu0YwLi9SZ/l2q5L+qd7eq4HLk/3MDMrgk1o7nJdcPDJUwhi/k5Vkt
	rhMCizPaxDaXo/b8tWW29uB0v4+NZ/RPTn4Bq95/14pGGHINKTqZI3ZGjMMnowowwhQUOVn4t1Y
	WdmJz9aKIqy31J0Lnq7YC2tmjruhphncraJVriZWPkUSLHjb/Uu7GkCnQSNR1rCRUNIcKGfBRxK
	DEIQ==
X-Gm-Gg: AeBDiev9fd4x3zNhQejwdh3Dk90DeBVPELoWMKmCzU26RY2QrnfaboPP5nLr68TN8g1
	5yFAiIC4Oc4YrRWbWKMzt4gz2ajfK5xA/dMOvL97JDAQXWyvcGX/0unOdXRh8jMQAp/36kbQJBb
	TydIGzewCwx98S4aMpAwdUz+yxOYbQmkDhYt+MkfSeAayA2t6GN9Ekc8G8LY3hNosLHCkcvIwJZ
	rXHg0vTqYYI3yY4Bw3aREW58daUvsnQPGum0s0fzfrmF1xwkkac+8WheVvI0LtsdI2BMc5/CIR5
	McF6lztVyErTrkcJAqZYG99nfLjOMM2IRtmbcnPgFNOA+Z0ySaIXWDXCDqdJc4/7l2R05L75IiK
	DMB05HoDz8Dd/seYA5qNSoug69Ya8xVo6wedzM8VT664nwv6t6QYowcB4LHidMlIrvcOCopOPYA
	Ac87/X6iA0agJZhxuCDlceC7VcTp2raFBbE9CNHQM=
X-Received: by 2002:a05:6a00:3cd5:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-82d0da33ed3mr15584050b3a.9.1775539620511;
        Mon, 06 Apr 2026 22:27:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cd5:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-82d0da33ed3mr15584015b3a.9.1775539620001;
        Mon, 06 Apr 2026 22:27:00 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm19897219b3a.41.2026.04.06.22.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:26:59 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 10:56:33 +0530
Subject: [PATCH ath-next v5 6/6] wifi: ath12k: Enable IPQ5424 WiFi device
 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ath12k-ipq5424-v5-6-8e96aa660ec4@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfX+qa3D7P+dYNd
 Qi6AJZbxcv/iWz28hCTnp+ZX+qh1b48T+Y7eZop5KjIaVueMI/FYls6a0tCb5sdXngy6+klJo5J
 MV65dV/mGtKvqDnvucc5BBD9kCOA83bkIvjbSY5UFd/5VXORRw4uiNwtR024oMxtPg7s6bElih/
 +Yzwj/L7zqQx1WNT5I8Mjomht7Mgd01GdEDrkB/hQMrNUC81gNV4T20nYMy0wvXziAZNoKvOtG1
 nMnxah9gOZwqdnpl1F+tBxJ3xZM29S6FxGht/lEEFGx7sTM6WtJETRV2u6EUUlXMd4DPaVSkF2H
 2fpcj99uwOHZyjdCTx143zgoTTUgkg/RyLSFW7T7ruzzQUCxr61Pqgbp2iSavubPWwKGTjPsyGk
 /6irHKJatDR8Ct1acMo1hnkIvz2QyNXgGWyQfJgXUBpJE3Jb4XcRWy3Sz1ARm6b/kl6Th8Phvy4
 Clm3WZksmMW3L36YZ3A==
X-Proofpoint-GUID: _myLFgqy_ds6osoEOMAIZN3tYmzzHkgN
X-Proofpoint-ORIG-GUID: _myLFgqy_ds6osoEOMAIZN3tYmzzHkgN
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d495a5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=x73wdjvOoWb_6dWcbhYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070049
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34429-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quicinc.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 552CC3A9F16
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
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
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


