Return-Path: <linux-wireless+bounces-37648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qzrtOYwsKmpXjgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F466DFE1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Ll+i/Dyw";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=WYxJWqt1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37648-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37648-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E8D930B73EC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 03:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495E305E28;
	Thu, 11 Jun 2026 03:33:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC782BDC05
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148805; cv=none; b=Ni6X+DFeqbQvQEU4GBNlGLrg/NR9fGN7hLm19Lx51kY5LNs0+CFa5+mZtAE+lgbAYJHnEFk0VGNIVgFQy1mi11z6xhP/cFl0jfCrtEN+fL9GSq2fd+0z15THT6aBaEmSMS/5wnLLMtc9VH+GNufv7wST3N8Av5XmUaRl/xxtxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148805; c=relaxed/simple;
	bh=TBKpTBUlRxp16u+JjXGypy8HC6nOXsYEMWBbV585Odk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0cCBh7aPOybE9Kxcgy60kag5bf1wBZfytruNPND+LOcZMtKlcAd4lDH4Zw1IuXT6TSpkQdwQ3+p9BrvGXkzaEaHrhXsJJbn5TRTVHrTjPCkYctGOCMyu49cfXN+baNWZGybQJQmWRz2zjzESpSK3wvzrtVSnil+Kvl/AgD39og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ll+i/Dyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WYxJWqt1; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0NXrF3233191
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eAi/cH55ITa
	xLHzNN6NVJATn9sydmgbMVi5O/Jv7r6w=; b=Ll+i/DywpyGYjwdKlM/bL1PH3lv
	/RyOIL4Ioi/VE5XETjJIXV4F2neR704cqs5Y7h16qUKog8qWQV80svO1Xl/UFs0h
	Dd1JuwZGqNPCuJztbqCBq73Vke7OydiFiIRNh3ADvCDPQaZ0Tc9+vxKGkwZXVpoO
	lyA4wu+lnNp9ijWMcE4UNRuaVIOkAANU0vuITjGF+9UAJyCUK2TktARY8DxLQU2u
	gUTNEIlWbZZfmwVjaxEXm1AmyJKiWAlIrjp/BCtuoge85r10Vtq+9rkVCljPG55F
	2mScMNM/mmfwXUrjlfO+LKwTszIqKpEF5oIJrnJHhT9H3ncfkMbf4XdjHcg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6shfs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c2da7fa311so5588525ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 20:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781148801; x=1781753601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAi/cH55ITaxLHzNN6NVJATn9sydmgbMVi5O/Jv7r6w=;
        b=WYxJWqt1G8l1wsX+peTz4a59wAlBMyEz9DnwlQNEsb+GL4AVts1rIAkr00D+sU1dno
         i8pbBklCixhdJsizPUlgxHm0uXXj53fuMgGxavQ0UpuLlxCsOQuDKKm+urEgJQKMvIa7
         GDhLpvN0z73D8Fqy3mKyaH2OzTuyzK5dX5Z3N2Rd43csAh8SaEaiYgmKfzSn5ZYFDxFY
         2Vdg+/MdNI7UQPHgDXamOIYPwWM7Wp8uL1c0x537oOm/tQ9D1tJ+Sr5Jb4QT7/DzpOdj
         ZhlyT1CMC1WzpvHHogVzJkcoEv2idoqea4Y6B3WFEskyYlDFpUIK7XPo5OJViPxZqT2C
         tMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781148801; x=1781753601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAi/cH55ITaxLHzNN6NVJATn9sydmgbMVi5O/Jv7r6w=;
        b=rG900kGzyhX7jOu6sP5F4SCfPI5PGfYoc56hCgnUDx5vGOuJVSskznNqMKtZeHAZ29
         M02SE+G8iZvZyhBR1mcJJ0gpw5klqFljVEbvCamQ+i4iSjYL8Qq2vmbIFeJ2hC9sBpKR
         rO+HqvJWU1/r5YWHErbKytjjw4tSnkSuXnfAWh0f4XhVN8RRn8pwbhSnpmnmT7MQMcsT
         ygQ2PJxGXySSptDgtcvo1BUN5um/FOBTWigj1B8oEbDwX19BxrEx8nMfxATngrKKoiwQ
         GXWjm9OwpOTjcS0rUheVmwtk/sIqfyhqYHhohx89zL5lRNaVdhUaBFhJM94qj21vFXT/
         ZrzQ==
X-Gm-Message-State: AOJu0Yzt1i2Rud0vDvKHD98SZ34thVPuo8zj+H6bC5Dfaqq6wQPv4N4P
	6hX/ySgXYj0v4VlB4TSItZ3kLOmGV8ca1rCU4LXWG4a/DfyMz//V1pimP3z1olsYXQ10OapgqSE
	UsPb8pasLGilODbs0o9HgKsS/xeaajX9pERdxQffaZZ9mDg4ToGHc5XCOCFWLJ3jJFmQ4+g==
X-Gm-Gg: Acq92OGETcpLYryRiBRBxkQs2zfyNRA2QkkRRIZC3Gw7drkIS56Rag+esFUYrlDGX4r
	VLL2nTgW+y1inNMT+p8WqTKDdTTzIlLsPx9p5bzAqAL7lLu/pDf5h5Bry2UatBpMSPUN3PNAOBt
	Hxv3xvdyy59+fJvwIehzEZdeo3Ygdhno71xHgU6YStllkYvEYezVttSmamNaHZvv2dFXL5iOb1P
	nv26VA4H0wFJ4/NGNHypmWmMLNDD1Mf5gaRoBZ40nVMEM/0d778+8DdAAYhxho5mc25t9DLeubU
	1CJOfqDAiWYm9sm5lQ9+0ejkkElRMzJSb4M3QpRvyEb6EejD2IfB+Kg1/A3U41PIrenkelO5qWY
	AKsTvKGRjg+0ULJ4Pifo/6EH6JUfs8hiLOLr7ES4hRFzMnAwY5S3VrD46DObgxJzsHJEKFeDfGg
	e6Ih1H4uMdA/KX+RIvD1bKnL9/tBia530eeWoGtdS7F9FTp653Re7Katk=
X-Received: by 2002:a17:90b:33c1:b0:36a:aa9:eea0 with SMTP id 98e67ed59e1d1-3779cb2617fmr1024653a91.4.1781148801435;
        Wed, 10 Jun 2026 20:33:21 -0700 (PDT)
X-Received: by 2002:a17:90b:33c1:b0:36a:aa9:eea0 with SMTP id 98e67ed59e1d1-3779cb2617fmr1024636a91.4.1781148800891;
        Wed, 10 Jun 2026 20:33:20 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775287186dsm896041a91.6.2026.06.10.20.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:33:20 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 1/3] wifi: ath12k: switch to name-based reserved memory lookup
Date: Thu, 11 Jun 2026 09:03:12 +0530
Message-Id: <20260611033314.2330-2-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eeXpNQBam0VfZzUmLc9WD0bd364WDg18
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfX8STJLsTxBCk7
 60TOJP4hft8KYlll34O5xf2aFqotBOeG7yWCnaT4i7N1iojubACpKDS83zi1j9x7r57db2WHB5B
 qQctVf5tIYaHD89rXuGAdbVNVsExuAw=
X-Proofpoint-ORIG-GUID: eeXpNQBam0VfZzUmLc9WD0bd364WDg18
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a2a2c82 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jmRftXr0Aczi6AUq4NEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfX/NJ5oL3+oolD
 av096B0c3P6QQyCVRGOV6rH9yD5SezOLeGhS+ywihwz7PrtD0axPFzLuhaXlqrwXQpm14DU41/M
 WirQPgFuZAZB311mYjSME2zocC/5Or3v/IIDQJrtqe2l45E/cIOyXPx9JktZRtzWlt57EJYWBr0
 bF4VOlVD54NH1T4E9ZLbk8K70BV5g6ekbOnFTh8fXkBTp1AaG8OU30j+VLnmOq2EoWOa2chdK1B
 A17lTtgOccmcMyKhWQ9VdpmDdgPlAdNE0jXrqpZqrAylUrRjQaca+a8uf5n5KWWSO8bnqNl0wmu
 798WVzzqnpeskLDJgXVGhQ9TNTUeQwnw+j1oNhOXc6+bJvJZeudwJEufyJwzu6EPCi2H+AZqjYa
 S80pbwsKWXGHuz30c9TiopOnJz7Qfnh5EeoAcPk4pvQ+3j4ebg4tpwcFxi+4/VgswuR4SWJ4wFs
 Y+E4Dy5t2e2pAB5VYxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37648-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C5F466DFE1

The driver currently retrieves reserved memory regions using index-based
lookup, which depends on the ordering of reserved-memory nodes in the
device tree. Since different platforms define these regions in varying
orders and combinations, this approach is not compatible and can result
in incorrect memory region access.

Switch to looking up memory regions by name instead of index so it does
not depend on node order.

Use names already defined in qcom,ipq5332-wifi.yaml, so there are no
backward compatibility issues.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c  | 18 ++++++------
 drivers/net/wireless/ath/ath12k/core.c | 25 -----------------
 drivers/net/wireless/ath/ath12k/core.h |  2 --
 drivers/net/wireless/ath/ath12k/qmi.c  | 38 +++++++++++++-------------
 4 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 30733a244454..695b605a92fd 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -15,6 +15,7 @@
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
+#include <linux/of_reserved_mem.h>
 
 #define ATH12K_IRQ_CE0_OFFSET 4
 #define ATH12K_MAX_UPDS 1
@@ -338,24 +339,25 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
 	struct device *dev = ab->dev;
 	const struct firmware *fw, *fw2;
-	struct reserved_mem *rmem = NULL;
 	unsigned long time_left;
 	phys_addr_t mem_phys;
+	struct resource res;
 	void *mem_region;
 	size_t mem_size;
 	u32 pasid;
 	int ret;
 
-	rmem = ath12k_core_get_reserved_mem(ab, 0);
-	if (!rmem)
-		return -ENODEV;
+	ret = of_reserved_mem_region_to_resource_byname(dev->of_node, "q6-region",
+							&res);
+	if (ret)
+		return ret;
 
-	mem_phys = rmem->base;
-	mem_size = rmem->size;
+	mem_phys = res.start;
+	mem_size = resource_size(&res);
 	mem_region = devm_memremap(dev, mem_phys, mem_size, MEMREMAP_WC);
 	if (IS_ERR(mem_region)) {
-		ath12k_err(ab, "unable to map memory region: %pa+%pa\n",
-			   &rmem->base, &rmem->size);
+		ath12k_err(ab, "unable to map memory region: %pa+%zx\n",
+			   &res.start, mem_size);
 		return PTR_ERR(mem_region);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 742d4fd1b598..617d039b9237 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -637,31 +637,6 @@ u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab)
 }
 EXPORT_SYMBOL(ath12k_core_get_max_peers_per_radio);
 
-struct reserved_mem *ath12k_core_get_reserved_mem(struct ath12k_base *ab,
-						  int index)
-{
-	struct device *dev = ab->dev;
-	struct reserved_mem *rmem;
-	struct device_node *node;
-
-	node = of_parse_phandle(dev->of_node, "memory-region", index);
-	if (!node) {
-		ath12k_dbg(ab, ATH12K_DBG_BOOT,
-			   "failed to parse memory-region for index %d\n", index);
-		return NULL;
-	}
-
-	rmem = of_reserved_mem_lookup(node);
-	of_node_put(node);
-	if (!rmem) {
-		ath12k_dbg(ab, ATH12K_DBG_BOOT,
-			   "unable to get memory-region for index %d\n", index);
-		return NULL;
-	}
-
-	return rmem;
-}
-
 static inline
 void ath12k_core_to_group_ref_get(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fc5127b5c1a3..ba2f617d8e5f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1294,8 +1294,6 @@ void ath12k_fw_stats_init(struct ath12k *ar);
 void ath12k_fw_stats_bcn_free(struct list_head *head);
 void ath12k_fw_stats_free(struct ath12k_fw_stats *stats);
 void ath12k_fw_stats_reset(struct ath12k *ar);
-struct reserved_mem *ath12k_core_get_reserved_mem(struct ath12k_base *ab,
-						  int index);
 enum ath12k_qmi_mem_mode ath12k_core_get_memory_mode(struct ath12k_base *ab);
 
 static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..0176d6a4bf8c 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -13,6 +13,7 @@
 #include <linux/firmware.h>
 #include <linux/of_address.h>
 #include <linux/ioport.h>
+#include <linux/of_reserved_mem.h>
 
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
@@ -2727,20 +2728,20 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 
 static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 {
-	struct reserved_mem *rmem;
+	struct device_node *np = ab->dev->of_node;
 	size_t avail_rmem_size;
+	struct resource res;
 	int i, idx, ret;
 
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		switch (ab->qmi.target_mem[i].type) {
 		case HOST_DDR_REGION_TYPE:
-			rmem = ath12k_core_get_reserved_mem(ab, 0);
-			if (!rmem) {
-				ret = -ENODEV;
+			ret = of_reserved_mem_region_to_resource_byname(np, "q6-region",
+									&res);
+			if (ret)
 				goto out;
-			}
 
-			avail_rmem_size = rmem->size;
+			avail_rmem_size = resource_size(&res);
 			if (avail_rmem_size < ab->qmi.target_mem[i].size) {
 				ath12k_dbg(ab, ATH12K_DBG_QMI,
 					   "failed to assign mem type %u req size %u avail size %zu\n",
@@ -2751,7 +2752,7 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 				goto out;
 			}
 
-			ab->qmi.target_mem[idx].paddr = rmem->base;
+			ab->qmi.target_mem[idx].paddr = res.start;
 			ab->qmi.target_mem[idx].v.ioaddr =
 				ioremap(ab->qmi.target_mem[idx].paddr,
 					ab->qmi.target_mem[i].size);
@@ -2764,13 +2765,13 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 			idx++;
 			break;
 		case BDF_MEM_REGION_TYPE:
-			rmem = ath12k_core_get_reserved_mem(ab, 0);
-			if (!rmem) {
-				ret = -ENODEV;
+			ret = of_reserved_mem_region_to_resource_byname(np, "q6-region",
+									&res);
+			if (ret)
 				goto out;
-			}
 
-			avail_rmem_size = rmem->size - ab->hw_params->bdf_addr_offset;
+			avail_rmem_size = resource_size(&res) -
+					  ab->hw_params->bdf_addr_offset;
 			if (avail_rmem_size < ab->qmi.target_mem[i].size) {
 				ath12k_dbg(ab, ATH12K_DBG_QMI,
 					   "failed to assign mem type %u req size %u avail size %zu\n",
@@ -2781,7 +2782,7 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 				goto out;
 			}
 			ab->qmi.target_mem[idx].paddr =
-				rmem->base + ab->hw_params->bdf_addr_offset;
+				res.start + ab->hw_params->bdf_addr_offset;
 			ab->qmi.target_mem[idx].v.ioaddr =
 				ioremap(ab->qmi.target_mem[idx].paddr,
 					ab->qmi.target_mem[i].size);
@@ -2806,13 +2807,12 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 			idx++;
 			break;
 		case M3_DUMP_REGION_TYPE:
-			rmem = ath12k_core_get_reserved_mem(ab, 1);
-			if (!rmem) {
-				ret = -EINVAL;
+			ret = of_reserved_mem_region_to_resource_byname(np, "m3-dump",
+									&res);
+			if (ret)
 				goto out;
-			}
 
-			avail_rmem_size = rmem->size;
+			avail_rmem_size = resource_size(&res);
 			if (avail_rmem_size < ab->qmi.target_mem[i].size) {
 				ath12k_dbg(ab, ATH12K_DBG_QMI,
 					   "failed to assign mem type %u req size %u avail size %zu\n",
@@ -2823,7 +2823,7 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
 				goto out;
 			}
 
-			ab->qmi.target_mem[idx].paddr = rmem->base;
+			ab->qmi.target_mem[idx].paddr = res.start;
 			ab->qmi.target_mem[idx].v.ioaddr =
 				ioremap(ab->qmi.target_mem[idx].paddr,
 					ab->qmi.target_mem[i].size);
-- 
2.34.1


