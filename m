Return-Path: <linux-wireless+bounces-34569-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yISvJoyk2GnegAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34569-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 09:19:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4733D3435
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 09:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3B1A3008697
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A5038C401;
	Fri, 10 Apr 2026 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dRxnfUzu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kUjzIPAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A61C2BE056
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775805201; cv=none; b=ue3VeKW9Bl74Maic385LHVbhdtUrnY1PJSLM81R1ohgXoS0ReIigVBUORxeVRmzPx4bAICRjgoLHeDAaTR6PiOJSWDGdglY6ru/rcDUh3HxrZhyjvMcC2z57tMfPFaBbXVr6/9Uh70A6+8FEwNoBwNP5cRq58Mf0oW3rDGkY0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775805201; c=relaxed/simple;
	bh=OTC7h2HFRKxNwbOoEigYsgd4gJo62Eo/vn5gp+KZIts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U7eVa8X8f1hECfvmqEIMTAzFchmqK9k0JFApgKcRJgNW9vNQQSjrxbvgXP3tuJlz7JLNsToI8RiH+3g/UMcq91wuUMwnbWaIamV4Q7uizk+me7LjDAbc362pdRb8/ZrcCXrmo+tg6mdxJ8BJFZHjIdNNispXhTsf3LtI6bDJa8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dRxnfUzu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kUjzIPAX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639NE6kO3934613
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 07:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fmEXD1qIyUmzxQdrW7wk7qeou2259gvsDVS
	fQeAi2mk=; b=dRxnfUzuXm5S0XPt8IA5+lcUqUP+bY3Lu0cIXNa6nwm4NXDqmnY
	H48OXrmvAM8SYZcNHD2c2zw8krYt0ZwWT8shYUpS0Zf6i7mMjzN2zSQn32+0EwfR
	A70X/zLJ5qJ63acOSrfJ8KPwHiQOR2EllostIylWVMxDc8HsA56OW/8aWjNJHNL7
	TEsU8z/yDbXkpgzIluft9E1WYXo7X/DTxbFgtf+e97ZRm1PeT0YsL4BLIE30irhI
	sa9MMWay+BRtZauCkzttX77xT2g0SBvJHCXAU0q1Sgkexbs1iZhqh9LoTzVXyxP/
	PDmi9DOyTt5SX+IqG7Ee15XLN92FSIRiWhw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5sayg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 07:13:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso2233518a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775805198; x=1776409998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmEXD1qIyUmzxQdrW7wk7qeou2259gvsDVSfQeAi2mk=;
        b=kUjzIPAXqZ3DVxfhLCArmuO3/ss6s5/m3uxZFKCGlbmNjjeLwe0Ry9BdFaR9+sNzug
         4SYYJ5jZoB8yClJN9oNY9M7zMebpaxMc3e2rqNoruhWkzBWZMmJTvFRNQsormGMBtc0b
         kWTnXSyvccZoWi0s8KJCQUD4NI3mAfInJQSqtTeXKEBpUuNveLHyNYCKM1+wBrU/zuiv
         eUvX+eB7UXIX6ZCu7795tGOYJVXrT+mkm5RIKZH57XG/fG42e87DLNmHVGcoqMq+5rE1
         KCYoojgd0u1b0KMwdYb67XA3RPU1Wl1Y1CzsfKPPUd6KzCB+2nmqx6EePnDLcvfXqpiw
         JnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775805198; x=1776409998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmEXD1qIyUmzxQdrW7wk7qeou2259gvsDVSfQeAi2mk=;
        b=J/igtLhjBR6vbGJZruVzloIIle9paSRdLvIcma1rZMoBDR0yp2trYG7C0cobA88IyT
         t7ZWFFH0NYaE/SZMrS38DXDw7WrME2iSlkbfy1icjHMhRG+jgndJEc+duj2ukgrZKQdl
         EitBPWr+PvjwEZrnJ8fsMMXMsrO4AIi16hOvwwdXnFkQYPsiFq13RuQcG0mTGZXA7wyM
         uwLT+kcsZNfixZ7q52/8QJ5Em7kVuhKBEylCWaMUdRw2Z2SmxNEws4ANr7eP90YF/Gly
         889Zmukn1obWtw/twKC4bGPUn4XjzNcJI8pNpZ8zqEFo7Q4Ja3OHoOaqEd0tCa5N7mil
         0LTQ==
X-Gm-Message-State: AOJu0YwN8Q5tI4rQwsfxMFDRTsZGHsJgeAw0EfRVKmbFd7xENDhkr5hn
	/wtr3sDLhmNfrqWD9wYRewjfWq3kUDt5BNvRo7wIAG4m9wx+P7Db2jefZu5d9mNRws0/A8mbiWv
	gsAWeDRZ903mWPKKBA2+SAi0NSzJ95RdJhvbYPObb2wR28IJyNb7MKOp6nRMffpwxmmrLQQ==
X-Gm-Gg: AeBDietWiULtsWVrZ8wFbVQhWNFHnb8EcCjqVownucQfnWpoZUv0Ch3vew+NA1214i+
	ZO2RBQwhJZSz+qxSWMifoubh3OX6OBEa13Povr3/l7qMWHOBli4s0lPt+jezubVOA/9XIlROJf+
	c4dTmk9aE4JDnrOb3H+/mKmpY//moXC9E7zUk2hOfX3zpXu3C6ttHp5IUBNDW1vRPHC/aSpD/o9
	COFO/yyLnaueqDRyglaGqKIG4EiH7xWIkmHUHQqNcrmSxtt4MQH13dQR6Y8uL92NrYNC187JCop
	Zd+t2TynBk2PCy9UMlOANobSx7vlUHfZLrJCDqMPlUmtXaXZXEQ8RQWYPSROouO/v3jOCzCgIYk
	j1q0DHiwtYVXueIE7MaauIw8zDWQ6miEwb1Z3ebjYIgqpA6Av6xgo6lL9cXr2HoZ+lqzZtIRHHj
	C+phbNp9e7fP72qP+Z5GX5YkbtCJCbQ1zasxhxbT8UygZB
X-Received: by 2002:a17:90a:c2c3:b0:35b:9d97:63ac with SMTP id 98e67ed59e1d1-35e427c925amr2264157a91.7.1775805198176;
        Fri, 10 Apr 2026 00:13:18 -0700 (PDT)
X-Received: by 2002:a17:90a:c2c3:b0:35b:9d97:63ac with SMTP id 98e67ed59e1d1-35e427c925amr2264111a91.7.1775805197482;
        Fri, 10 Apr 2026 00:13:17 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4131cfacsm2070459a91.10.2026.04.10.00.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:13:17 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: fix OF node refcount imbalance in WSI graph traversal
Date: Fri, 10 Apr 2026 12:43:00 +0530
Message-Id: <20260410071300.2323603-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RUdMZSqz9ZCxYrugWn30_jD0fErtPzHu
X-Proofpoint-GUID: RUdMZSqz9ZCxYrugWn30_jD0fErtPzHu
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d8a30f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=cJ7lEyrx1ZesTjHcJmMA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2NSBTYWx0ZWRfX6w5nHvmBQDFB
 0HfNv+KBAe9Bnotxa0eCIx8eH4wbwh7qqfkqTR8SqPzCfwEIK3qwvtUSNRnsFFVTcBVJ5D8WFq9
 fL0h9DRNMkF+RYvk2aUyeFnahwBi7bhL4KBdbc0bf4vYRSmeytZjg716p+rEja4Z7IuQyd1DxhT
 MdBEvPXEJvhoPtGMv73q48lxQlB1Qf1GB3xKknO7B6nPDuZqjZiWvKtQxkQ7j14TD+ufObPpvC1
 dtKaU8G71ka+/INI27ytgBpGy0pNdDoyJb+F8owkLpj6FGK/OYyjj6OXjiUYyPgcJ7mDufvhwFf
 XqyM3kvUGWnw7UsATl6Pw3Cye/g2InackVeVsSMipd0xLurXYddgH7TSTZcr0sGCeenvi/1Q/jD
 ItsYsGXCCY8T9EooVPHt46jwiVpYO1PbXflVHcq/UmU9wBLRMSWFmopCz+QfOtRndL/ZdhHXa/s
 mgCuZkfDLxBw7i2fPHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100065
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-34569-lists,linux-wireless=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_SPAM(0.00)[0.322];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,c000000:email,0.0.0.0:email,qualcomm.com:dkim,qualcomm.com:email];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F4733D3435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ath12k_core_get_wsi_info() traverses the WSI (Wired Serial Interface)
device graph starting from dev->of_node. The current code uses
dev->of_node directly as the local traversal pointer and calls
of_node_put() on error.

Since the driver does not own a reference to dev->of_node, dropping it
during traversal results in the following OF refcount underflow:

OF: ERROR: of_node_release() detected bad of_node_put() on /soc@0/wifi@c000000
CPU: 1 UID: 0 PID: 210 Comm: insmod Not tainted 6.19.0-rc4-next-20260109-00023-g797dd36dc178 #26 PREEMPT
Hardware name: Qualcomm Technologies, Inc. IPQ5332 MI01.2 (DT)
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x60/0x80
 dump_stack+0x18/0x24
 of_node_release+0x164/0x1a0
 kobject_put+0xb4/0x278
 of_node_put+0x18/0x28
 ath12k_core_init+0x29c/0x5d4 [ath12k]
 ath12k_ahb_probe+0x950/0xc14 [ath12k]
 platform_probe+0x5c/0xa4
 really_probe+0xc0/0x3ec
 __driver_probe_device+0x80/0x170
 driver_probe_device+0x3c/0x120
 __driver_attach+0xc4/0x218
OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'

Fix this by explicitly acquiring a reference to the starting node
using of_node_get() and attaching automatic cleanup via
__free(device_node).

Each discovered WSI node is stored in ag->wsi_node[] with its own
of_node_get() reference. These references are later released in
ath12k_core_free_wsi_info() during driver teardown.

Also remove unnecessary memset() of wsi_node array since cleanup now
explicitly sets pointers to NULL.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Fixes: 908c10c860e0 ("wifi: ath12k: parse multiple device information from Device Tree")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 77 ++++++++++++++++----------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 2519e2400d58..980a12fb2c6e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1838,10 +1838,22 @@ static struct ath12k_hw_group *ath12k_core_hw_group_alloc(struct ath12k_base *ab
 	return ag;
 }
 
+static void ath12k_core_free_wsi_info(struct ath12k_hw_group *ag)
+{
+	int i;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		of_node_put(ag->wsi_node[i]);
+		ag->wsi_node[i] = NULL;
+	}
+	ag->num_devices = 0;
+}
+
 static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
 {
 	mutex_lock(&ath12k_hw_group_mutex);
 
+	ath12k_core_free_wsi_info(ag);
 	list_del(&ag->list);
 	kfree(ag);
 
@@ -1867,52 +1879,59 @@ static struct ath12k_hw_group *ath12k_core_hw_group_find_by_dt(struct ath12k_bas
 static int ath12k_core_get_wsi_info(struct ath12k_hw_group *ag,
 				    struct ath12k_base *ab)
 {
-	struct device_node *wsi_dev = ab->dev->of_node, *next_wsi_dev;
-	struct device_node *tx_endpoint, *next_rx_endpoint;
-	int device_count = 0;
-
-	next_wsi_dev = wsi_dev;
+	struct device_node *next_wsi_dev;
+	int device_count = 0, ret = 0;
+	struct device_node *wsi_dev;
 
-	if (!next_wsi_dev)
+	wsi_dev = of_node_get(ab->dev->of_node);
+	if (!wsi_dev)
 		return -ENODEV;
 
 	do {
-		ag->wsi_node[device_count] = next_wsi_dev;
+		if (device_count >= ATH12K_MAX_DEVICES) {
+			ath12k_warn(ab, "device count in DT %d is more than limit %d\n",
+				    device_count, ATH12K_MAX_DEVICES);
+			ret = -EINVAL;
+			break;
+		}
+
+		ag->wsi_node[device_count++] = of_node_get(wsi_dev);
 
-		tx_endpoint = of_graph_get_endpoint_by_regs(next_wsi_dev, 0, -1);
+		struct device_node *tx_endpoint __free(device_node) =
+					of_graph_get_endpoint_by_regs(wsi_dev, 0, -1);
 		if (!tx_endpoint) {
-			of_node_put(next_wsi_dev);
-			return -ENODEV;
+			ret = -ENODEV;
+			break;
 		}
 
-		next_rx_endpoint = of_graph_get_remote_endpoint(tx_endpoint);
+		struct device_node *next_rx_endpoint __free(device_node) =
+					of_graph_get_remote_endpoint(tx_endpoint);
 		if (!next_rx_endpoint) {
-			of_node_put(next_wsi_dev);
-			of_node_put(tx_endpoint);
-			return -ENODEV;
+			ret = -ENODEV;
+			break;
 		}
 
-		of_node_put(tx_endpoint);
-		of_node_put(next_wsi_dev);
-
 		next_wsi_dev = of_graph_get_port_parent(next_rx_endpoint);
 		if (!next_wsi_dev) {
-			of_node_put(next_rx_endpoint);
-			return -ENODEV;
+			ret = -ENODEV;
+			break;
 		}
 
-		of_node_put(next_rx_endpoint);
+		of_node_put(wsi_dev);
+		wsi_dev = next_wsi_dev;
+	} while (ab->dev->of_node != wsi_dev);
 
-		device_count++;
-		if (device_count > ATH12K_MAX_DEVICES) {
-			ath12k_warn(ab, "device count in DT %d is more than limit %d\n",
-				    device_count, ATH12K_MAX_DEVICES);
-			of_node_put(next_wsi_dev);
-			return -EINVAL;
+	if (ret) {
+		while (--device_count >= 0) {
+			of_node_put(ag->wsi_node[device_count]);
+			ag->wsi_node[device_count] = NULL;
 		}
-	} while (wsi_dev != next_wsi_dev);
 
-	of_node_put(next_wsi_dev);
+		of_node_put(wsi_dev);
+		return ret;
+	}
+
+	of_node_put(wsi_dev);
 	ag->num_devices = device_count;
 
 	return 0;
@@ -1983,9 +2002,9 @@ static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *a
 		    ath12k_core_get_wsi_index(ag, ab)) {
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "unable to get wsi info from dt, grouping single device");
+			ath12k_core_free_wsi_info(ag);
 			ag->id = ATH12K_INVALID_GROUP_ID;
 			ag->num_devices = 1;
-			memset(ag->wsi_node, 0, sizeof(ag->wsi_node));
 			wsi->index = 0;
 		}
 

base-commit: ae530e0b135102c5fc08e64c39e7a18564a52b3e
-- 
2.34.1


