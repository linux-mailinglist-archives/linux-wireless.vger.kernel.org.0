Return-Path: <linux-wireless+bounces-32239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO4jK4UZoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:11:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5221B284B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FE47305A4F7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E1341AB1;
	Fri, 27 Feb 2026 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQhoSO/d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJsxeMzL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CA03451AB
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165505; cv=none; b=kc+y0RG9Bu55sFd+P+S9Nv1Ytm3BHGNYQtAqeVC+tZ8GETzwIABgYMAwNFoHWZk4M9NzfBZ/QutJ9N+sO/38NdU4SvxTO/U3a4nkWodtkpcIaKek3V7eoxKzgWoV7IUqhXZl5dEtOiLMIqFcAHWsPmIc8impmT2W9w7pbLx0Lh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165505; c=relaxed/simple;
	bh=X3luo2GRPmUA6X9TQjlE0eONgBbdRg21p8gfPwF6ank=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rx958K7/L/VOZgEBSEDZdbchjT3TXSg/CPU8W5CFiQvu6vniGniKzmmyn4Ep7Ty0U1LRu73xynMqt6mLOxCp4a+R7ucE8mvWlnI2rWbIycYkp5bYWO3JASFHapPvmwaW51Nmtlt9F/qcdP5glbLdHFJwfVWRbWsZY5/pY/SCzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQhoSO/d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bJsxeMzL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K1ol2403203
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=amuOUMcKObHl4pIGcl7k3LNmJEs92Q3SErV
	Eh7dTn+Q=; b=EQhoSO/d9VrDywNaDsjJGZpC52dC/5CYheZLAiM0CGcTgrafOYE
	wsg+7nh5cF73YF45FW9B0XKgh9NIrn6Cwx7+iF5mA9obkpY1JFO7Fu1sD4zoY0jP
	YZbXLAixO4uRsSIHEwJBwFi+5d0sYkB+5IT18IQxeTwVnl+orspM3w2Q49GlPP6R
	LPf70E4PXTwEWmEv+ZcaiPGHu9Iwftbm1dK9pl8g6RsprJEIHMHWOO8TTMeM07yN
	ohZUgL9ELZrqxYSTUZhEsVX+TaKDnC6UdfVIB1IncPmqkQLJa3xX6Ti6clCY7v+s
	yipac/JIaXuztowgKerMHaXFjHC/VSX271w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw2397um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:11:43 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-824a2df507eso5087321b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772165502; x=1772770302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amuOUMcKObHl4pIGcl7k3LNmJEs92Q3SErVEh7dTn+Q=;
        b=bJsxeMzL8aZ2q+biQF2fxOV/fwhVuxrvx0VS3ls+sVZ7xUnr2nE3DBEOXsPMGW3WE5
         f9d0GT/fVCvQNCYzJyzxOWLSg90zRRtPqCaltTcpeJ3cMvApLTaAnQYbItr/YoneRY+z
         JciM2kO1xlO2bqOQaeerLB7MYEvEequBQN6+iVgQPiyUXo2Irij8SHQodYXmTt2UiNF2
         moGyPShDGx644T1xcmHyctc8Ez4Bzdd5CHlhfD039Crgv1l4G0CCUNueyIkvGi39Q/Qb
         mr7oaw8J9biBRIAmqtexOzpwFNVxy+EsX1BFCBvmBBfcr4ITS5ke1aMl7Y5hGX5eN6/L
         VVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165502; x=1772770302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amuOUMcKObHl4pIGcl7k3LNmJEs92Q3SErVEh7dTn+Q=;
        b=FH5oSgj7lPRaqxLqTN75/TMQZi4+9IpaBYw3rr3Bsgl+FZfKI5L7aUY13ot88fpN4E
         HGVBJfkyK+mEG4GdxB7fqC7jolb1WwkURvQLeUB40xnZvv1I+yuG64mKMRyjME7W/fOU
         WqTWPsNLeGvJFm34tAQQlcavmMf1BGuxvH5Eg0qFYy7Fbm/4aT+H8vUR0K9j9MJ8DdXf
         pwdaC3Vio22WfOfdGJUzGKmEMn3NHL6tWBonsfqYviKNY7PsyT4WHlo2GYtXrAMg5XEa
         b5WGmq4/zecYDDy71cGykWopQLwikDY8qQb8l5Xm+terDEh3y5ClSWMPe+2M0cZScoXu
         zPjQ==
X-Gm-Message-State: AOJu0YwIA+sJe64JuCmfOO8VldDtJr9J8hz7+p8IKIIVrtqP+F2WBUEf
	9CuE9LGWQHOxZt42ACGj4eiVVVx/OjDRgWkyOSznq5DkHGBOrBEsxA5l4HQYa6YBnWgOPAXrGPp
	7Tj46HJ2+9SFaparQ6n3mt4paskKU1ElVOUNqOSchR/BrT/+8mAoWerpTNHFZdExdSnoThYfWQw
	vFIA==
X-Gm-Gg: ATEYQzxJ+EmqNpJwFLlmb7sNg54bvkNK9aXN3CmM9cancoDH8PIZsp1EIjVBxp7+bN4
	deXPgeCyfLEhnd8WiXd1/M22I5tn2f3hR2IqPXIcOWVsEOjIBhJaxIiLVeAsgoqZNHjcfKvq3UD
	unA/tSP2a/ddMwcXOrAYySSiSY+nnyNCB7m/LDxN27bvN7ln/7+F9/3jKip1TU1Fxnx6X9Mj2vF
	ZjhF8nHl7EcHbo7Ax97m36KBa0N0BdQrTKEZc0E5gKfe838vr1U/JjpKZaOtP5YtxG6qRRN3wri
	Vgh5uDlzFHEUr73t75fOIgPQC6cezh0hgu7CgyGB/y26uVhcin/6zWhuMxegPuIRG2a9MzIJ3ZG
	Mx9PhK8ok7VQKLBZTYoqEYmjkXtNtFi5MA8Y34PDZDBwrVyO7+Hy2wnF2/KTs/1kINnxrbawbDn
	BJ5QKc95sAWiSWAt/Z16ud8nPuMzDmQGrr+K1LgU1Z+WL/ZkLT
X-Received: by 2002:a05:6a00:4296:b0:81f:3a83:9756 with SMTP id d2e1a72fcca58-8274d9d9937mr1281317b3a.30.1772165501880;
        Thu, 26 Feb 2026 20:11:41 -0800 (PST)
X-Received: by 2002:a05:6a00:4296:b0:81f:3a83:9756 with SMTP id d2e1a72fcca58-8274d9d9937mr1281301b3a.30.1772165501400;
        Thu, 26 Feb 2026 20:11:41 -0800 (PST)
Received: from hu-rdevanat-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3ab8sm3666811b3a.27.2026.02.26.20.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:11:40 -0800 (PST)
From: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Set up MLO after SSR
Date: Fri, 27 Feb 2026 09:41:27 +0530
Message-Id: <20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h7XuEZ1EW8pkZCcispIHaUKEMfIS-kLu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAyOSBTYWx0ZWRfX1iv6Jtue2uFr
 zf09+cy2w8CPm7Ebo1odCBP1Gde5moUfme2vrDZRsPolYuMItoncUJmLkBjAKDVjkRvfCMAWvp/
 tLG6GdqMKrw1yyMz0ujOc+7gTNB4dvJ4FupcGtF6+bwLPsr8u97my0VEQpKt0q+0aySTSgMqSGB
 V+nHV+khOD8CK0FNfZlrGPD5geb98hjMjLRjm3ZM3QxvPAURLvGYRbo2nNBXWGK90sWKu6e7HE8
 gRR0d2GWAQhA+TDRdf2nA/IFjkTuHbiblrQbYzrAi3IjsRnRhPlJ9ON0esc7+w6lQksHCmZ5e2a
 Ti6GZuBGPZ47pVFfsKv5OwnYrAG2ztzuRjTQ1Q4iUpFGZ4+sXw0iDysgKrs0EodOKqtth1FSkcp
 M8uIC7uxdShhpVi+9/y4LaN72k8DqjY/6C1t6Q6gGZ0uQCbWVza2LhbvUfdSkQDVCUTtbLy4hDD
 haEP7c22JERbgyJurnA==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1197f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=p7LCZwjNATuEJ2GLxp4A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: h7XuEZ1EW8pkZCcispIHaUKEMfIS-kLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270029
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32239-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roopni.devanathan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC5221B284B
X-Rspamd-Action: no action

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

During recovery of an MLO setup from a core reset,
ATH12K_GROUP_FLAG_REGISTERED is set because ath12k_mac_unregister is not
called during core reset. So, when an MLO setup is recovering from a core
reset, ath12k_core_mlo_setup() is skipped. Hence, the firmware will not
have information about partner links. This makes MLO association fail
after recovery.

To resolve this, call ath12k_core_mlo_setup() during recovery, to set up
MLO. Also, if MLO setup fails during recovery, call
ath12k_mac_unregister() and ath12k_mac_destroy() to unregister mac and
then tear down the mac structures.

Also, initiate MLO teardown in the hardware group stop sequence to align
with the hardware group start sequence.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 9dca1a0af73e..218c0a0c9699 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1017,6 +1017,8 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 
 	ath12k_mac_unregister(ag);
 
+	ath12k_mac_mlo_teardown(ag);
+
 	for (i = ag->num_devices - 1; i >= 0; i--) {
 		ab = ag->ab[i];
 		if (!ab)
@@ -1134,8 +1136,14 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 
 	lockdep_assert_held(&ag->mutex);
 
-	if (test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags))
+	if (test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags)) {
+		ret = ath12k_core_mlo_setup(ag);
+		if (WARN_ON(ret)) {
+			ath12k_mac_unregister(ag);
+			goto err_mac_destroy;
+		}
 		goto core_pdev_create;
+	}
 
 	ret = ath12k_mac_allocate(ag);
 	if (WARN_ON(ret))

base-commit: 20ad0d58517073b3b683ff786c65dd3142321707
-- 
2.43.0


