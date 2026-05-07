Return-Path: <linux-wireless+bounces-36073-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPKKJYSv/GnlSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36073-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:28:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C214EB091
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84FBE302CFD4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D846AF36;
	Thu,  7 May 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQGKmWwP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BoiEoIEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85C44D6BB
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167506; cv=none; b=VcOZoAUzV8t3YCU4n3Js5RXAkMnxR41aEUcX8DnouIL3Nsfo75HXg+E+sUYBN9GzP3hzF+uwFybQv6p6rGyiCCRUJNvgwMKjBZIoVEARgFn4NVSym2JDEgSrAb9mrIGz4sEhvZDK9oU6ClghF0zj2d6Z9SkgkN90QkBUwUkQpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167506; c=relaxed/simple;
	bh=PTkmvq/Q7QJ06WLt1N+U7YrHr9PbicR5yuKr0MktND8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaPR7To4Fh0bPcbsIb8FiMtTbwty8jGdRbsJcwUvybE/3CaDUTP54Td9o9OGq64il2M4t+pJ1UAXwadnJS6jSl0sTxzCb+DPunOvZzY50/vxdJ5rDgiPZzzWt2o6a2D+m9OyZJL/cnKWRtX8OEbbXpacXRre0BNUtrRjUrtF8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GQGKmWwP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BoiEoIEG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BUL4s3156931
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 15:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uk7Oe1xq0TlLuceyYysifE8TQzhLGFxXPLlz8g3T7ak=; b=GQGKmWwPpcYT7z52
	bh2TBhD3xN2aVw+NnsWrysEnuoLLqDCOscuj7MW+9REwKMoW7mY5/4nq9ouPjv/g
	thwhVWE3ViIlDkCt1ycf1AQFZ1cGZ6NmEpXCVrtcQnVpGRxU3RQxdHtKryWF6KTx
	K+xYI7lTzBNnoOWbnW+5KGwx1fJchODrvLFvjUD14mh/H0p4TxPqRr84WwFrh27f
	8N9KTX/ztpP9EOfYjCzV1eoVEbr61V9zen0za/2MVIw/iZ5PXTf+/ZK+7484+EIw
	Cm7l3M9dBPTFL56gluoApthPugAaLSFg/qxw+RHO+JWjyxvQoRxJcadQFKuQf+xk
	3Wj1hw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhf28g3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 15:24:59 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56ae34d6738so2126989e0c.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167499; x=1778772299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk7Oe1xq0TlLuceyYysifE8TQzhLGFxXPLlz8g3T7ak=;
        b=BoiEoIEGSFg2nLyqYhoAS3ipSziX+Bf0RWodsXs3iufy/Qa5PRuz7MUHqznU+dHm0/
         CqCfhVboEOvao6bgt8qedh76exBuQnXexVSN5oyVY0J4XngL5MWXWqxuvqrvcovefsDi
         38NyygRbYNg08ggM+KVxvhyMY5loN1lk8prlnui30qmnvBnG6GaXU/Pbd1pGWh68BpnP
         NtLiMrx8YmEkEXBoTRuvWGd9nYVoXNbJreQ6RAP6DvEk7RJMf6wb40CF1bFe2tUeiOvK
         Vd2epm1UVYz5f9qY8KAc/0Qxe0AHlFmHw6+TE4xzWYAUVsZjhDAlx7bHp74J0vDwYHOm
         Wb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167499; x=1778772299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uk7Oe1xq0TlLuceyYysifE8TQzhLGFxXPLlz8g3T7ak=;
        b=plsLdbVetVAhaybTG4n8/2wzCoRqTSUVMhtsNOUSppUswtmcg7lEkdMVVFJhL5Ss8u
         y+HbfDruA0zd1oaVtfoEhGJCt6SUyrO/MikaR2yEqec5GAv363Eb2fPaL/0KVHCYAMno
         8kgDsvfO98u4UviQE9T5cP06HQ/3aRUlQVpcbz5derdI99u2b7JNFu3JyI3FaNaWDKeT
         YicUYgk5z6lr1XkIRu/2D+JQU4UhTiCWJ12ZI8dtaQgc5O6o0KjwwBayyG+qrg13RYVP
         eL/rQt7H+hnrkQE3M/9f7MZ3NuamBea5EnegzDHRjoAS3ccp2hT0e2eJHA1N9OVbZC0b
         vN1A==
X-Forwarded-Encrypted: i=1; AFNElJ+/BTiVZvF5jY1j03nJZZ5BGhZ+84o2Qbd3h1SdbBDsk3v24dvqpyTDcIZavDL0fgJs9Y1oCwyhSqRinN+6yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQp6U9ERs6gOywNwTGY25GFhvj8M0A3uiuI6B9YAYfi7Fm7d7
	vVr4Y5yu4wQdCo5ML/rth62sw82B63HOcSK5kSlzjb7S5++Wc3GJFdFkd528GHw98hLvJc7GX+8
	lTZsa0Aj6BxF4VuyJQHC4ZD1fNJvl33WBRrEngzhhqHVyRAUK5W0sCsZkvS2CobN5Sl63kA==
X-Gm-Gg: AeBDieuPBcOtR8ph5djZGK1kkYOgb6tRZWPi6p1Uppf5CfImSxyeI9XDi8JlW8+/b39
	sAXGvYp/LSC9dlVQV0L2onhAWCra3gkD9QFyqzZDuqSPo8nbmxxXXUTn67S7vPK9WTzFh4LxLVo
	ocZCLqBaldoLWFu1aDnL0+8LQB9W5ivBpFopSLqb1DWrDul1bdae5eE4P+168NoJ2qO6OnCDH5K
	eGGeNUtkQV4lMb2BCzY5N4WHleQrqSOj4VIWqgZvfiXJW8TkiJwusgYw4CSzcixXSkTn1Gtpdbi
	iK4oRTSGGtiSXqGgV/PUZyjYkMvRp+TwrKkntymQdfBYGn/F4yQy+D/NzsEg3pmBtmwU77s2XAG
	C4WL6J8k3bKCdFtPLOmFiDZX4wid8UcyRhN7/qRl6EMe7hK5vXqOc5YvwwPBCLUuTfHhii/V1Qq
	srqieT/6x4yEi7lj5IFccqoxP9Ccg=
X-Received: by 2002:a05:6122:1822:b0:56f:6add:9029 with SMTP id 71dfb90a1353d-575593aea76mr5335434e0c.1.1778167498708;
        Thu, 07 May 2026 08:24:58 -0700 (PDT)
X-Received: by 2002:a05:6122:1822:b0:56f:6add:9029 with SMTP id 71dfb90a1353d-575593aea76mr5335377e0c.1.1778167498276;
        Thu, 07 May 2026 08:24:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:40 +0200
Subject: [PATCH v2 5/8] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-5-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX9wd6mNR9MKgF
 oFDVRZwb9zmNCjjd4fuirC3QD5/5WrubwOEX2EBdp6MqI8X4dk5TONgyLTgBS0Sexrxe7Q5NFg+
 RdPXmpjUymw4WBI2ztE1dJzjCZIF3Ht8zvm0sUSs8gsZI5KdVS+B8CrtCS1shUCkK+cPifOdCwf
 Veh0+krpSTD+tVL65CtnjxILCTI3wTtaJUbzjmRPH8dOTyr76f9pnWZDWYlFnBahlrP4oZTM3T+
 NCUmepUC9E6+IAY4qTIXDet1ZPk3va6gdMYgABVyn+o5dWf/N31S5SuqeXd4oF5ziGjHCoK6t7A
 lGboIMvHZUcmv4mIANQmBbrFr061f64wgLb/c87IFeM3rb+C86tazm2wsZ4c2c1obJkhfWMsdHz
 twtX9yvn+RVjeog0frsLXXyK/EmN8DJ1RFOV453W1TsT1JumQle/2oJGpbxlbWXUj9i2EyBesEV
 IHByl6P9aPk7WXcoTxg==
X-Proofpoint-ORIG-GUID: S6D35lS9jbwFSIfgbRwHUopJqicOcLrT
X-Authority-Analysis: v=2.4 cv=SuagLvO0 c=1 sm=1 tr=0 ts=69fcaecb cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=C98JESGoZJZpJ7w8-ywA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: S6D35lS9jbwFSIfgbRwHUopJqicOcLrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: B0C214EB091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36073-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 47 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index d88715a0b3a52f87af23d47791bea3baf5be5200..7854ba555d9a55f3d020a37fe00a27ae52e0e5dc 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -15,6 +15,7 @@ struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
 extern int of_get_mac_address_nvmem(struct device_node *np, u8 *mac);
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr);
 int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
@@ -34,6 +35,12 @@ static inline int of_get_mac_address_nvmem(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_nvmem_eui48(struct device_node *np,
+				      const char *cell_name, u8 *addr)
+{
+	return -ENODEV;
+}
+
 static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
 {
 	return -ENODEV;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..79b289de0f16aa5f8724e84d6f2300648c25b6c4 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,6 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +72,53 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", addr);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(addr))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mac_address_nvmem);
+
+/**
+ * of_get_nvmem_eui48 - Read a 6-byte EUI-48 address from a named NVMEM cell.
+ * @np:		Device node to look up the NVMEM cell from.
+ * @cell_name:	Name of the NVMEM cell (e.g. "mac-address", "local-bd-address").
+ * @addr:	Output buffer for the 6-byte address.
+ *
+ * Reads the named NVMEM cell and validates that it contains a non-zero 6-byte
+ * address. Returns 0 on success, negative errno on failure.
+ */
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr)
+{
+	struct nvmem_cell *cell;
+	const void *eui48;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-	mac = nvmem_cell_read(cell, &len);
+	eui48 = nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
+	if (IS_ERR(eui48))
+		return PTR_ERR(eui48);
 
-	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-		kfree(mac);
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
+		kfree(eui48);
 		return -EINVAL;
 	}
 
-	memcpy(addr, mac, ETH_ALEN);
-	kfree(mac);
+	memcpy(addr, eui48, ETH_ALEN);
+	kfree(eui48);
 
 	return 0;
 }
-EXPORT_SYMBOL(of_get_mac_address_nvmem);
+EXPORT_SYMBOL_GPL(of_get_nvmem_eui48);
 
 /**
  * of_get_mac_address()

-- 
2.34.1


