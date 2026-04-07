Return-Path: <linux-wireless+bounces-34426-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yChwOrOV1GknvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34426-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:27:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFC03A9EF5
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2610301B054
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CF3793BD;
	Tue,  7 Apr 2026 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+oWCMi/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4ENXPRo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B503793B1
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539611; cv=none; b=dgn9H7O8UarZMOVB757rg2gOt9W5hrWA+UyifP01uzgFMwAkZ5b77Pf/M07IZEPjTJlTR7+JeOUz/rm+DwB0GKX30elSBicPvjm8midgUh4LnC8+gwhWOzFkDLjbtFT6K/ldWVwsFRQTitMp/zRynx7LXT21BGkzP2q/2bm4acg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539611; c=relaxed/simple;
	bh=XepUZxNH6MlR7YZKqwI1oLm+PWLU0WlCfqE2MzQ3H9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GvBMscM8aot1EOaU4AHt5VPDo5chKec/6vR5h+34SpFc19PY9opQqYzO7CAsc1kBwBKYeiJ6E6CyBs9ZAOBi6TGvdz8XloopVbYRcQ89naVtSFneTpuKlG6qNVualAg5Hu8gAV9gwTge4khXQEh6Khq+Dw8km4IFPpOXBW8HgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+oWCMi/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4ENXPRo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LSeH62580027
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 05:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7xE/DwUx8zoNoD4YdMr3h9T8/DSL7UDdeXKwIFE3LG0=; b=P+oWCMi/jcpIhvZn
	Ll1Msh5a0E/SXHocZTW72KYK2onXTsqpTi42OjgETvbKarbTOpGiVvk0MvX702N7
	dbCzTB4/xEuuXi41FEHBbqW8Sp6QYPUolvNznaAis6Swn4bMYH34XOzqNmGhQ1Nq
	wMFH5xwbpmZfQ6jHXC6sGDDc/0oClacwoO3oDOh2gzoA7xjWIZ9GkMF1wAei4lhR
	AH/IKkz6YF/VYE5i8MQ7qqrQXW8DetScO9Ly4CSqldu1fmfkZdgkiUYEE7maW91n
	NicqsOn11Qfhgqea8DxHmAgKvLwD0EemQvSFUCfAqLv8TjKLBBhcv/QFw0xO6/+u
	/HtA8Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf159b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:26:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82cd9fa608bso8090585b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539608; x=1776144408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xE/DwUx8zoNoD4YdMr3h9T8/DSL7UDdeXKwIFE3LG0=;
        b=a4ENXPRojwRFa8+wxzIFCgFi1WrbGNX2vKXWyQ4OzQRfNtq8aSKxMjdLboFUEcv1E0
         XIakA6StPvNP6hOg1Eylwa5+TN4Oa987SKUOqPaCwA4pGjmFlrzJ+0b0nPRh9crfptbu
         DWOw/hPHDQafYCG3KqSwlOq3FV/DBrAflUr1eirDERbx5+P8h5+jgnYDzE8e+YlA5p2f
         3nP4Kt7vs/sWaZC/JVQJaroI2/b/kRO1h63RGv9qlEubQ8FlhJXpgP9Po7fMI5E01k6P
         Mi+2fj500tzOqlK58cZJSCNIPygiOA5CIBVOU/VjUuipqyPoIY9ywaFQiz+aXQZjHzTM
         4qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539608; x=1776144408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7xE/DwUx8zoNoD4YdMr3h9T8/DSL7UDdeXKwIFE3LG0=;
        b=J/DqK1g9IVt009YfvXLr+8NlBFJZ4HBdOLsGp4v6aB9uw1Ew3SgkSAuA9/vICC4JRF
         xy9jJU4cSSpDCnt8A/eK47+qpq0RAR/9nRwTIXWzyHS957V484T4Ygfdn31TVv8iottr
         QQG6+mQnXILkmdHTzt3PVRzTinvw2eicBYkbiB5gqdFVVrW0relqWuacbseu42TTN172
         N98vtVKQzy71OfK1GZJWhEVTqfYQpXRghuM6nrqSbb1r4P2TSeBB77fzJc2hhbcpMIyK
         9k/b/76Qm1hkBA3a2a/IpapDnB/kLR9etMi+L8Jb2ISVuPRA7OgwVBH2FEjM1vtxonf1
         Y1tQ==
X-Gm-Message-State: AOJu0YxRTG3OHG8sCa/iZbxbAPJkpKqUVIcQpuNab1BL/RfBc8PHFpHB
	PDbgk0qcB4RC3wdg9fkyjxKpiSPBNQTw8V8rUYJ8W4HKbOoUJ3CXxSNVJdY7Jr5hoM4gsiowVDG
	aMPacPJw0nmptBxINnMjSyJG80uDctYKR8zRBr3LFLuxch2B3VB9KsmiBy/uU0fL2km+cm2l3Qk
	bzzw==
X-Gm-Gg: AeBDiesuftAT8F1hH4NLFmcfLMnGNTGk2KIvrsmjGg9YPR4Djny55+nE7CnOvROx8uf
	q0T0zljuXxzttRGcpevq5w1ChZhwv5pAifdbdBfZ264G/MDhv+8131JnZN0GOIbdH3d3I8pf8QG
	QZXRMMhn8VKa+y0ZzQcUph44uHDc1gkhjGHWYHFjgEeolkaMhUYhBx7McqiU5GBGYJFINpxuXmu
	zOnrorij+h0B1UIS+PaRZ8CpcXk/WvuXHYvdBkEB/b+MCEAZbhGMTPDp8knI/tNei8S2UqCg89G
	fV2Xq1qvFxULdVdzpnEAxm9C8fXCEFlapZ9s0LqDWBVcXyDvajYFWZR3MoqkDaOGh+0QlyeyYhu
	zBWe4VbuuvZ0Hbzp5g0l6urfNinQbWWKDpRfPcK29/lW+UtExeknzTug0xH4ieSpX69AyKYm7bd
	flILXuPJ6cuDhGNfnpJw3wNq3jhRzPogMQyrFFVIY=
X-Received: by 2002:a05:6a00:451b:b0:82c:24a6:1de3 with SMTP id d2e1a72fcca58-82d0dbdf0e6mr15003653b3a.54.1775539607601;
        Mon, 06 Apr 2026 22:26:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:451b:b0:82c:24a6:1de3 with SMTP id d2e1a72fcca58-82d0dbdf0e6mr15003622b3a.54.1775539607118;
        Mon, 06 Apr 2026 22:26:47 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm19897219b3a.41.2026.04.06.22.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:26:46 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 10:56:30 +0530
Subject: [PATCH ath-next v5 3/6] wifi: ath12k: add ath12k_hw_version_map
 entry for IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ath12k-ipq5424-v5-3-8e96aa660ec4@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfX5fTqEFkcwBJI
 oYUnU45sDe+sHCP/ZGTHmC5qpZfXMGWPfYyEMIAmLaoJD2YPy8DfQBd9QjNES6mjrH2BaAmEE9F
 JxNv/BYqqC2ERGP5JKNif5yykc7gdHkhaBn3B1kWNXS35Cdsux+200vZzI8UPEtrOxoDzMlBSVn
 qy7fMce8jFdPOAOckuQDRCu6RxXw9Qew0Y2tvoHrkPdV44BXE8IGAnVWhKZNYlhgxWB8b6osfxb
 md31hhh2kCAXjvad5ahfICRKEjqVZvhz/B3B+ZGD50ELI9pp1c/7kDo1uGUBzgUgg+NpXt7PuZF
 HdQxQ0dSATjzP/N7y54T5/UcJ9BzECjBDxkR1mkowX/Ftcp7aybFTyL69sU1fny3YX1v6eangpI
 Irflf8po9vDW70GwG2131SR+45Y0YLx9HOo0gLB97EfQstrAbPt9KkmC7cBi3MutQzUWX43C8Jj
 2hIGi3I2V0Kao7KAw1w==
X-Proofpoint-ORIG-GUID: 6-ZD6CMfLXDHMvqrztHjoA6GcvDBwM1E
X-Proofpoint-GUID: 6-ZD6CMfLXDHMvqrztHjoA6GcvDBwM1E
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d49598 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=V2VgLR5doq-8DBhT5hEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070049
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34426-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ADFC03A9EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new ath12k_hw_version_map entry for the AHB based WiFi 7 device
IPQ5424.

Reuse most of the ath12k_hw_version_map fields such as hal_ops,
hal_desc_sz, tcl_to_wbm_rbm_map, and hal_params from IPQ5332. The
register addresses differ on IPQ5424, hence set hw_regs temporarily
to NULL and populated it in a subsequent patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index bd1753ca0db6..c2cc99a83f09 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -50,6 +50,13 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 		.hal_params = &ath12k_hw_hal_params_wcn7850,
 		.hw_regs = &qcc2072_regs,
 	},
+	[ATH12K_HW_IPQ5424_HW10] = {
+		.hal_ops = &hal_qcn9274_ops,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
+		.hal_params = &ath12k_hw_hal_params_ipq5332,
+		.hw_regs = NULL,
+	},
 };
 
 int ath12k_wifi7_hal_init(struct ath12k_base *ab)

-- 
2.34.1


