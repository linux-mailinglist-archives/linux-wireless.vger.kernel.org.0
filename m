Return-Path: <linux-wireless+bounces-38320-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i4bsK79gQ2p/XgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38320-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:22:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58F6E0B6D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:22:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=V1txEdHQ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=a3VKOfZS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38320-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38320-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FEE630329A0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDD272803;
	Tue, 30 Jun 2026 06:21:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC319CD1D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:20:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800461; cv=none; b=cqZFWAsZ9nmVC0C72m0072E4+1jCWN4AGYsL/xgwBorhN8tnHq1+Ojfegws9A35s4AAhZheGI8jqHNliH9tmf1hBKLWkXLRC6LpqAvf3pJqF8UvO8jwFl3vMCtpp5it2TRc1IOYmG6MLGzjloy30vHzJNpHaEGKHRLnq4ys40rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800461; c=relaxed/simple;
	bh=F5QHcA6nl26n3u0yS9lh+xKbfvpU7BaURFp1U08na1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n51+b0Zxdx/bvM8xJOB6qel6AE2se2P/1E2w3p+TfKK+CX7/PNNdkN6YA/7V9SC5iXAHOexQi/xNWoaziYjHbutsaTgq9v6iWjVgxMJhtDg9kMQv18G0MSyyILPZEpS82C3EcB42b3cNQUE5jLbiNZN39qrCbX6aaY7BaX8ShvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V1txEdHQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a3VKOfZS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CQtT1056212
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1sew3R7z0Wl
	crCJ3IJSLd4KUPosf5U1/TQ1P+NsWe0U=; b=V1txEdHQFvw6gU9wsCSUHguK7xI
	PyEX3ayEezm33M+iozWwn1Z6dj7etE8YH4LCV8/cH74qe7HPQgXAQn1RBQDaf7ls
	O33oeX2LA+tOrOONCPfUpJUV/6C/aWh3zSBZBT08lAP1dNjD9amhPaokTBC/OwWs
	LC/iAyG/gpB1z0axuM/ur67QXAgevho84rjiIuybVDDBRAA1khOFyrEwcshbgarc
	FInj854B/D9Ee8ZJ3nEjzCZQyOBMOZchOV4iL9QJuIXl/lmHAXEQ+cq7zJqhPl9K
	5cNbcJSRsTk84WZHXcpBFTh6m9jUAUP/QrqXAWOw5//wUu6ZPDxkoFMre9g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f46860geh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 06:20:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9d85160caso3078995ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782800458; x=1783405258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sew3R7z0WlcrCJ3IJSLd4KUPosf5U1/TQ1P+NsWe0U=;
        b=a3VKOfZSlM/FZoQBzwGxs3oomKdMXoVvGWM6gwGZIcCA2Iqh4Omxg/xM5EmUDIah/e
         ePfoX9t0X3+Wzn+vuuoihVxqVd25yQxBQN0Wf4Uu+U076o/n0JJS8htGDI5F4Uymagts
         3mpGPsiChf0Qx4yV+M5cusFo64igpkdR6jCIQFEzXfwEo7+VoZY273fduGdh8r5dT67c
         Silq8LGxUKZVAJ6iCLi85dCbSpfnimK90TuiU2sFGgJ0oe0PLdICuKaWHpLvwBa3MX5P
         PRqp+CgE7XQVTIXQfiCksi6ERge8vFWcZnosik97K5sGBz7KiO6iX1OwwKm4cwUTmFLV
         pkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800458; x=1783405258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sew3R7z0WlcrCJ3IJSLd4KUPosf5U1/TQ1P+NsWe0U=;
        b=JPw6pd9oWsW6A/MdFLySPBCcJM8w6caFfEj6ujGSRgXtVoei0ROiEGUFZ+9vT+1cgF
         OgKauNGT5u8S2PNSePEF+N2CklkcNlo7IhqHwRXC07jxctyRcFeMruWZ7vK4Z6MLZhYy
         5LnuihdDHJgRomeT2QbiiFbzKzMXW87AI+FemNbl4U9rxkzXOE1MCuHUdNCTRmOcsdmP
         RfpZIaXwsPSe3BnpgxFJ5CHOaDml5xBZgGLn3A6nAC5OeBAlZKR3YVBguTJelfRZ719f
         tRoqH6JP24i2Gw8OZhBhn18PIwquqQQOMiyZIZMGjQgG/kO0JUacejc0GV/YMYzDuOPs
         8svw==
X-Gm-Message-State: AOJu0YwfwHuYXE3CijobsKUTXjpK9BjFfpoiaKuQ4FTw69++vUBaLPe8
	hUTT6H3B6XULxsq1HK3Ucz2AtRXkyGZLCy6DkYkbYk8buk3S9xQbYQotlRuxDikuaQAlsatLnha
	uWUg8lCE6kYvU+C3aGJZCERqNA2ZYmPBog8/LAjURBwcQlZkdCZMSjMF0mFX08rP62f+04g==
X-Gm-Gg: AfdE7clGMxNAlokqV+AcTdhyFRicRSvLklSQJua/qLfQppGfg3ASCLP+Mg6qFhFn9nV
	M0G8cqDvz9+wDi68eeq02XPizMH29Wo0XqP1qfoB6UTO1ghalqNW0QZxam5z9NUICpVYIL7CVEy
	l+ilvDJRPchEonU07BdJqbCaaXyXHiBjzDJUkPRz4YxfklGd/I3lL++M5eS9mjzXpXsncs9i0TE
	n7sC0je3bZrUvYqittip89PUryMiy6QR2MN0H7LWBsDcXdnSE39S+7BRXJQQLDGtIzvMFp/hozu
	Oel0ARKnpF3PYwVi58csmPBQ7WqUzOA3C1MEDpehZO+uW92PuGn5YegpxGoB5Mvl+PVTbb8e4Ay
	zrQiAeST5oouJstJp/2cWir5LhLZzGEz+1C6A3qa3QpID/tpZf/gx6o55SO/cEkJxwouc/d6Tsp
	zxABVu9n3DaCS0FIivKLmJYLfjdlqfb5yrFQ==
X-Received: by 2002:a17:902:e5c8:b0:2c9:d27b:af11 with SMTP id d9443c01a7336-2ca44897d0dmr3792055ad.11.1782800457566;
        Mon, 29 Jun 2026 23:20:57 -0700 (PDT)
X-Received: by 2002:a17:902:e5c8:b0:2c9:d27b:af11 with SMTP id d9443c01a7336-2ca44897d0dmr3791855ad.11.1782800457051;
        Mon, 29 Jun 2026 23:20:57 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382d0d22sm6413835ad.80.2026.06.29.23.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:20:56 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next v2 1/3] wifi: ath12k: switch to name-based reserved memory lookup
Date: Tue, 30 Jun 2026 11:50:46 +0530
Message-Id: <20260630062048.1615178-2-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630062048.1615178-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260630062048.1615178-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: do9n6AYHagyilJNWuSyC8wNW0xNPPN1M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX5hfufpcU4NaI
 trBk6lfOG6kRwJYQuK3j29xeCurfYQlrZ+aMHS1RCA/9m2LdTfp3O65QT3JWl4YXrbOmHH35fl+
 RYNXwgQW/DP0fOiI4ZXIFvPdmKLw3png0FTPcqOtwGnBin7vT0nptg263NvhUvzP9jh3D8RqD23
 omhB3DFAF85UxfN2Ygq+/490Z6C2TVi9Xv1Ujg+S1BRHHbdjAGKqaUo+g5NIF0yIHABCXUPCk/U
 XXEEvLefdf+iVkR88vV9wdL8cqz11zl5hlpUyWQQaDuWj9Htnj6SfFOP/ZpFB2UxaETJDa8pBx4
 ywZLPmZvhHMuiW6QIDyXfzPPWstTR3RHqUMFfpM0jLus7w+tf8Z/9GmQrhiTr/zW1v04c5y0NXt
 61ps9H6uPakDGnAYkkFDYdsGI6XK40DSFHlky26UnU7hZl6B1NNoeQkYjfWMulgnYRhS1mep6mH
 75LFcvYs3e+daGdHhCQ==
X-Proofpoint-GUID: do9n6AYHagyilJNWuSyC8wNW0xNPPN1M
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43604a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jmRftXr0Aczi6AUq4NEA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfXwlWk0chtCZqb
 aTQH3L/yi+r2BM8MdXdE3Fcd6wpnsQPU0Z8wrJZWjA3gPHW5P6M/yydvXAAMJk3UFtmSiIq3ynC
 5HWRPCdVqFYlXHwAqz/rT6QdjUhDuus=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38320-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E58F6E0B6D

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

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c  | 18 ++++++------
 drivers/net/wireless/ath/ath12k/core.c | 25 -----------------
 drivers/net/wireless/ath/ath12k/core.h |  2 --
 drivers/net/wireless/ath/ath12k/qmi.c  | 38 +++++++++++++-------------
 4 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 30733a244454..6df3b775a214 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -12,6 +12,7 @@
 #include <linux/remoteproc.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <linux/of_reserved_mem.h>
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
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


