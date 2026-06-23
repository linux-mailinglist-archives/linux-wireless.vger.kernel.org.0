Return-Path: <linux-wireless+bounces-38015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +2IlIXeVOmoWAwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:17:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 502DB6B7CBE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:17:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BlPW4rey;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=G4pAmpP1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38015-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38015-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 534603012C67
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDA33845C4;
	Tue, 23 Jun 2026 14:17:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D838423F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:17:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224240; cv=none; b=W+I3nRHgQHxa148yn23VWHi2C4B+8usezc6JmMoq3EFNr7l6Jci15XpH+zU1c8KxZ+LZ4ZymKbmfFIOiPlgPDtoDej958HRXCiRyXaB3gjIG2fWC4Nl9qSv2IMTHPguWqmKyNuEoCSS8UDyT4EKBxolIjb+xcLtVG/DPyB+/iWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224240; c=relaxed/simple;
	bh=2uWojJjq1CYe8mK2ZrsSkqmegGYSDU7cjGBxVkT2NPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVDEGhoFkIoK63j6+TSsyU68kHjvXzUShgO9pPXH3THPc+942EppwRA+ZvUh8gdnz3eLzl/0LFym8gr0xS9TQsEy9HW12UgS4FPl01hSBzj9+6cpm2KuwLbt9qB47JwuM69lPY8HLTU2htEgCTH3cRFgbjCETVPWWuoJ9l/OEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BlPW4rey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4pAmpP1; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXcXc3752890
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ViNuCLfK+fFW0U/eEAsK3rYml2n+gN9k9b6
	JwUIS9lw=; b=BlPW4reykkzhCcTaouJHKL40SI3XmaatmqOQiNPkm5HHY4Og/6j
	Coev/dt5js1torALL33PL9p74RoJCak/BC9ldI2D1C/uZgbatHEZBgm1fOW1Zs31
	M1lRi9pbXffMhH65omXEms5Cb2YGnHY4UWPXLKD9oImOrQw97Tu5kb2hg3F/zaNy
	aRDWgDOB+IK6aH0StpaadQLpuu7AX94i+UVbKuoaNb6YhSxSx5rhWkULKVHZ0t/1
	4IzGwh3rc4/ILMV0SJPAvZDNMtsHzbcpsq1e+Jm/67G8KnSX5FzIzreLa6JIahpj
	GCpeUeYtrzBD8xMF9B5lnPMhsrlkJ0xgkeQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29hk69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:17:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37dc9b82e55so1282659a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782224238; x=1782829038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViNuCLfK+fFW0U/eEAsK3rYml2n+gN9k9b6JwUIS9lw=;
        b=G4pAmpP1Wk9aVt+qIFJV5d6mzkkjHh6TyEJuSMhgru+2h68/BCVWPvm999QoFEsC71
         AlOlUDmFBWLZltIPrxxUJalF1P6982yEBdvMFb4/Ra0akEYKFIaRF3n0iQxMjGjTNQJE
         +juRkTDejRBSs9Lj9odCrkyzDJfi/uO/zliuwT4uLPs22YihS4uNuXZtWZWHq5G4DA5W
         blGB5UuWna3bIWWWM5RXzYjU0NUdztjoXwix3EcOyAllG1knic7m0qYvRHlKThEZLszh
         7U4LQ/9+QVo/DcjYTqiaR72TTcwpbFMoMN2ZPfO+jMLcIDwKgdpMKC8ccRc4ZK/jx4M9
         kxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224238; x=1782829038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViNuCLfK+fFW0U/eEAsK3rYml2n+gN9k9b6JwUIS9lw=;
        b=ohYXOGnhkMeGTPT6w3V2TDti9gLaJaeVoF2W6DFw0fO+ZITQt7wFKwJfbD2ea5VAyu
         xT8sSEWkVDvv7+VrPn0z0CSN8lIDpVmSZxPWmiVzANF+arJsoJDQtYPttXlN3v3riX6R
         sQ7k/3UONnUWFiAVrtKBwbmryiwLIMYihP7nl3L6i+Tvbf9QIp+Mm/zoiQ/kpuk3vkXB
         T4CP/LpXH30kJx6EWp6Ax5MI+eS4rqlDYjn6pEpBgWysV+13G6teDgsWC5YrGmMBlfiT
         rtaNXzMQsOq8SpPcVJbnlmSurxqDCVO+UrT20fqKDvwEEZiUG+VBmI3Uz8gZIUaK0slL
         kTKg==
X-Gm-Message-State: AOJu0YxHRxFN/72KQdCDV0fj7YHusd8msk1fYLIKl5GQbaTNKAlCfUdI
	aVoYpoFpBzYoQrt3aYC80UInuSijU6orKlRO1ZH/onv3zUwR5SDb36Gb6Y9zUJrbs4ynNLBcSpv
	SL3nAPEmW4woSJX3UzmPPuKo1EnBmTNf/7HjcxabCoUaq2efWPOq7Lm/60d5mDwN5oGhlkg==
X-Gm-Gg: AfdE7ckowXtY33hqkFBIy6OqzYay8m15oajR1PZQs80LJnXqZlkp7ezUcGAZpGeixRF
	4+T+1EzzlcHf4ad5kkAew4jLS7Ak1p43yujt42hOPcBeZLBmMM5s5EYqHHyGq2tpsv5ElWsWHwO
	bbt213SClQfiqjimah0+ob6khbux0CEViiJG6nZtc3dDvs95JqYPSlmMyUR1x0U+tGf8ZULGj72
	ncfKws0FtnrszmE3H3kmnIMYT+cLIKwJaolfKZ0yjQCzaOBelVvTgf2bNt8Vlfx49IX78A+upSO
	c2Yms4tnao3FSwzh4erEq2Kfl6c2MDm/UtMm2IIVQx+/xRmM/HQDpF3/HvZ6rIAQCwXQhF8Q8wG
	JlvX72VkfVZhzg6x2zxjmrsYuzf6dVT0Tt8WWn76OkQs5AK2PHfDB6Mh+f/Pp
X-Received: by 2002:a17:90b:1f91:b0:37c:83ec:1641 with SMTP id 98e67ed59e1d1-37d4d71d7d0mr14541718a91.5.1782224237750;
        Tue, 23 Jun 2026 07:17:17 -0700 (PDT)
X-Received: by 2002:a17:90b:1f91:b0:37c:83ec:1641 with SMTP id 98e67ed59e1d1-37d4d71d7d0mr14541655a91.5.1782224237179;
        Tue, 23 Jun 2026 07:17:17 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.56.199.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f315842sm10094199a91.17.2026.06.23.07.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:17:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Alex Williamson <alex@shazbot.org>
Subject: [PATCH 1/2] wifi: ath11k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
Date: Tue, 23 Jun 2026 16:16:48 +0200
Message-ID: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a956e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Alb0JCXUjTgUeOUvUsHAUA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=EUspDBNiAAAA:8 a=b6JBSybIbF9IxaTxWo8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: Uvd5ssu-99IUHrD5CzkuKvJaGEIgLOgu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX3huj4S+BAGTL
 cEru3Zyc7d/cfdESQZhESc/Iu63KwGOlgyRGUe0UAbCIAN5qZLmE5yP5o50g03wq5HWl/WuV4eA
 uMvbKlcexb1DACgraAgDpZAD59j8x1M=
X-Proofpoint-ORIG-GUID: Uvd5ssu-99IUHrD5CzkuKvJaGEIgLOgu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX2J2WMrbESlOh
 /8CwrwRY4aHDrq3DEHFLtjDzDw3LjRUbcqRC4GT1C2vkx9aK51SeMPgkK8jXD/NsVgDglD2jnQj
 sQHRYQWEVNz74tt8woo+s39pOQzjTgzmozdJPd8zKhWlNR3WzpGZHl6ZjS2e26XiP6K1LdH7+RP
 G1eDZuic/vHH5uTTTszcY6WlOydJF61/mtznLIdLOXOsvRwuTBEhZWoJmHsc8xEMOyy7mCZMxw5
 JHJM0hkjKBL+f1iakQUY8gqbBkdJVMiUw3A7yskwOn1EGH8R3fLkDNkhZaqzP4o1YAh84HRpPsC
 QhYEK9dv2iKCuN95sNB3IomIlEOhjbFF4hYI+gVmWwU9f71vZQkt/86J+WFWFHus4G5mogSGRua
 5kv8qHn5AEGUoyH6XcXfItk8KBJT4M6IuGRNi2LPT9A3+46yElO1I2u6NRPUcoiNUU9KPtTAPWi
 +sACs1YmVpYVw7XWi0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230117
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
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38015-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,shazbot.org:email,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 502DB6B7CBE

ath11k_pci_soc_global_reset() tries to reset the device by writing to the
PCIE_SOC_GLOBAL_RESET register. But it doesn't do a read-back to ensure
that the write gets flushed to the device before the delay.

This may lead to the delay on the host to be insufficient, if the posted
write doesn't reach the device before the delay.

So add a read-back after writing to the PCIE_SOC_GLOBAL_RESET register and
before the delay.

Compile tested only.

Fixes: f3c603d412b3 ("ath11k: reset MHI during power down and power up")
Reported-by: Alex Williamson <alex@shazbot.org>
Closes: https://lore.kernel.org/linux-pci/20260622160822.09350246@shazbot.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 35bb9e7a63a2..a163168f3617 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -199,6 +199,8 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 	val |= PCIE_SOC_GLOBAL_RESET_V;
 
 	ath11k_pcic_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
+	/* Flush the posted write to the device */
+	ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
 
 	/* TODO: exact time to sleep is uncertain */
 	delay = 10;
@@ -208,6 +210,8 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 	val &= ~PCIE_SOC_GLOBAL_RESET_V;
 
 	ath11k_pcic_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
+	/* Flush the posted write to the device */
+	ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
 
 	mdelay(delay);
 
-- 
2.43.0


