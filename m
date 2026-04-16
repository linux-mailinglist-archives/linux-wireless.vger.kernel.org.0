Return-Path: <linux-wireless+bounces-34907-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKBsKktB4WmaqgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34907-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 22:06:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3906414745
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 607D0300D962
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5B38C400;
	Thu, 16 Apr 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SlwsJOWc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IpTNJdIc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C0370D7D
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369777; cv=none; b=GZWQRxE8tM3iFPp+QOvQSOVGLqQVUYX4HAd8N334J3yLaZnom8XYe/IznvwsaZSJf9zMn2qJG4WALCMEWo+XHkhLhumhudjJbTKT15+zkYK5QXGfxGegpRS9mr5ZbjjHlHso68itnGK7dVZyQvglSCzE64PagRYK4++gjHUSg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369777; c=relaxed/simple;
	bh=JTK2rx40oYBsb11ahmYGRnQ/NIpRJwzV7uGRYphsJAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VN/2kbC50tA5IBZTW5RoC6F3IlA4mqhQRsT+4UEwATtkSoxC0g7S1elvIE6g8ix9VHHZ+r0mZ+Gk/fXxu7ZuHY6FtnVaUFtHzbdVkm1A/wAl7L1lQYP4TVW5115vWO6h4LBt/TW4oBG1i6aVWP4m/VzYFA4K4sTTLmXB4DYSkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SlwsJOWc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IpTNJdIc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GGRiLl3197503
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 20:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iQiSDyR+7IR6z4B1Cctk+F
	+qGlI2kN06paw0xf4+Y9o=; b=SlwsJOWcs7VAcMTXjBrylGhosmaY833fw/KHe4
	SNGY4y0NVLnD5VtrHAM4KNF82VpRkaLFJ8Gf2fSCcKW1p7zUX6a8KRI0x3IUJquc
	GNnQ+zgrRQKSBvarXnKjiU58hCzzLCz9KSRjaH9SI9Xz+xLvpSZazMfl8RScQopy
	2ATg+sbLyeegGse5/EAAFHoGXo5h8nOWyHXf8uhzOZOR46HPq+yOUa4QSjW9euFe
	QNrQw77mv/5zMBN+1Wb7yFxMoQ7SAWcA56Eor+H4HP0CGsj/5zHl5z1xQlJzCsp6
	AETsflGnpaHL1UVQFY4QHRIe+hRpPaAnKX9dOMX04CHBp+ZA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk3af0rfa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 20:02:49 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12c7169f3a9so3295840c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776369769; x=1776974569; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQiSDyR+7IR6z4B1Cctk+F+qGlI2kN06paw0xf4+Y9o=;
        b=IpTNJdIcU00ERAH+PoKUuR6HQwlFtSSnnk+otbFuzLJtsFEiVD7bBLfLP82LunhZiw
         6fsxjUQUhM84jvZ10uPFLhC21iXHkDorZ5hCiMsLnHoiNVp1f5S+F/MO4lFCByGu+PC8
         7eL0vm5zjshds6hb9d41+J2kC2puCt3EcHKtdlYViXimcIKiiBF1FrqT2Y7X6luY50rK
         yqpHNgnFzWFTIJzBtCBiIt4JjXZDTIVMUF66PiilFW6PXwnXyXKIxFNsQxThI+eKbrSS
         e+DHR5yrqhds4J28BoWaZq8WwaQdBapnCrkspl84kNeTP0xZ0SiG8VAWcHAKjBUBSmaM
         A7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369769; x=1776974569;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQiSDyR+7IR6z4B1Cctk+F+qGlI2kN06paw0xf4+Y9o=;
        b=PRoeH3iAeyvTLOTEBvDhrHuHIgyHE9b0uByfHVM2G1vCJN/cAzf3nAoHEhYWZoYnyr
         Tq9zgItGkE1wixDZDBAcbWdLIrM1Ir8k33MQpQlvShrZlu4j6Svd4+FoR09HUthzcSK5
         sIK/PYS5HnjkAwAEzdvPmV6eKE+iCN0lIROuNivHdzCzRBbXCdKk/gR9KbVwb6uKh28r
         cqUzeKnlxUZaoHSjWipZ4KmuLxIPubjbUIRnJHBF+FXklInaYotdz7V10vdirX/sEQd+
         XcUd6HPli6ZqWfrADaKC3+FHMlSnS6MyGPHisWVsfDJfVjW8KfKMKZXhmTlAztH+jgnT
         WPbA==
X-Gm-Message-State: AOJu0YzVls+21lQW2L2u7ulXv0U4Q6E/OAsjF3CVS5sqbDBKLda/RCNE
	+m51B4TqiF0Oa69aNDJRdmfVVrU9zilVkDZ8QEwinQhuT7TPIKjWmCA1XntHa9OwhPYl9krp6AV
	VnmFfALVGWLf0btqDPvzsq1994eySCtkY45IAywqrCjHcJ7I2fJIi44Yr/A9lqmuJDPZIPA==
X-Gm-Gg: AeBDietySGDXqz8iLoIrJm8Teuxmsg5KCZ4gOzYBKzWnT958dQqQiN9q7k0EiNpnMzw
	V15QimyrWx8a+obVvTuhWjl0bIW6fQXyAGaZRXGLqHSTlZUQeiAwSQoviCnVD5fFcQOssmIwNOK
	+C0U/7Kp1fAuWvysyVYxM4Ioe9a7Hy2b7YkkgRsFgxgWP5FRIxAbEQcXaSrEeMHt3hBi6sZPuCH
	hX0s1/pCxUnyq2Wk2VExj8xbgbKLrYfqekaPhIZyaHpf98R8luMb+VQ7SZAsHSwvINt0XSfL3QM
	5uH+6L2+bx98d4aOFR1D5bDGp8Kzhd+09EWoMMJ/NdDElq9bq9oz/me6BYB2nxgV5DnfeQqQr/4
	Z7yrKEIYl/0Eglk+aYbQgriJA29xRAYbF3IFhJpTWLD+mGfJSUwRaraYm+oKN/8ghzO/aOiSq2l
	AcHcJ7GDshw14=
X-Received: by 2002:a05:7022:660b:b0:128:bae0:e03c with SMTP id a92af1059eb24-12c7287c16amr312416c88.30.1776369769316;
        Thu, 16 Apr 2026 13:02:49 -0700 (PDT)
X-Received: by 2002:a05:7022:660b:b0:128:bae0:e03c with SMTP id a92af1059eb24-12c7287c16amr312381c88.30.1776369768743;
        Thu, 16 Apr 2026 13:02:48 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e630143sm10389841c88.6.2026.04.16.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:02:48 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 13:02:46 -0700
Subject: [PATCH ath-next] wifi: ath12k: Remove macro
 HAL_RX_EHT_SIG_OFDMA_EB2_MCS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-hal_rx_eht_sig_ofdma_eb2_mcs-v1-1-c44a3177deab@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGZA4WkC/43NQQqDMBQE0KtI1o34v0ZrV71HKeGr0QTUtIkVi
 3j3pq66KLSbgWHgzcq8ckZ5dopW5tRsvLFjKHCIWK1p7BQ3TegME8yTLBFcUy/dIpWepDedtG0
 zkFQVyqH2nBAJi7YUoqpYIG5OtWbZ+QujSfNRLRO7hkUbP1n33H9n2Pf/LmbgwIuSRJqLPANIz
 9b7+P6gvrbDEIfY/Rk/TMh+mPg2ocVjBTkk9M3ctu0F18EITC0BAAA=
X-Change-ID: 20260405-hal_rx_eht_sig_ofdma_eb2_mcs-a22a27f955bb
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE5MCBTYWx0ZWRfXysxSwcAV3xfl
 wd9NlCBmwo60xZXqFe2GDkYbu2A8yyLKPhheoNZLCTnPk0mxpuN1F81u5HxDuw6+wv/ty97JKbf
 hDlDgiWXwMhb4CXmd4F1cdHfb8hVce4GuUgkBqXnR7cP0WO6qs/zq4tPuADE6Ne55/YqJGsYfUH
 N5LExQW6xcRLU+Vm+SbNgSX277Ea6Zea520tzF5A3opwgUnCJszgcA9to1ImBUgRrn+VaFXwSDp
 gwih29FsPgPEm1QeopV+ca0liP1YeCZR6PlmasXsf8eW9/m/Qwe6ttvddpoEXlOpgdAeccYyAdx
 upiA93zG8d+EyK2MtQrFrk+5EYBwC/V3CByXpx54rttQqzgO7+kcIDqU2FlNrS+SuWYEjdDA6j3
 tmUkC5Ybq0m9hmUrgcrj8Zqsg2sXz6CJGxLiHVxO+H70lPVUDilGyOtQDoRFJ/U/nQXirTXFqQ6
 4W/p1ESqiUZjki9iSgA==
X-Proofpoint-ORIG-GUID: QJgUP5n5U1Dr1C7ybYbn0eA_ILEavFpA
X-Proofpoint-GUID: QJgUP5n5U1Dr1C7ybYbn0eA_ILEavFpA
X-Authority-Analysis: v=2.4 cv=DfInbPtW c=1 sm=1 tr=0 ts=69e1406a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Ty_28zkbBMK94FpjrpcA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160190
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34907-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3906414745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Macro HAL_RX_EHT_SIG_OFDMA_EB2_MCS unused, so remove it.

No functional change, compile Tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
This issue was highlighted by AI review which noted that the
HAL_RX_EHT_SIG_OFDMA_EB2_MCS macro misspelled GENMASK_ULL().
However, rather than fix an unused macro, it seems "better" to just
remove it.
---
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index ac2a8ac03288..dd60626b3240 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -559,7 +559,6 @@ struct hal_eht_sig_ofdma_cmn_eb1 {
 #define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_4		GENMASK_ULL(35, 27)
 #define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_5		GENMASK_ULL(44, 36)
 #define HAL_RX_EHT_SIG_OFDMA_EB2_RU_ALLOC_2_6		GENMASK_ULL(53, 45)
-#define HAL_RX_EHT_SIG_OFDMA_EB2_MCS			GNEMASK_ULL(57, 54)
 
 struct hal_eht_sig_ofdma_cmn_eb2 {
 	__le64 info0;

---
base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
change-id: 20260405-hal_rx_eht_sig_ofdma_eb2_mcs-a22a27f955bb


