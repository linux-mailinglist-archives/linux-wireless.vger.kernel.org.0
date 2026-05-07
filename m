Return-Path: <linux-wireless+bounces-36069-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNycEgev/GnlSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36069-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:25:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3AE4EAFAF
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DEF23016D0E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E244D034;
	Thu,  7 May 2026 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHIaw8lj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqyYzGxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15E44BC87
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167491; cv=none; b=GRPhCqp2NlZ6FFR5cQFOrcg9guz7r80wGI6xBAR88XYidHxBWdclztIVoY3mKcB1iDc85/oANQvY5Sx2FUNmEhFhVinStq8ymuXIKX8tLARMtyeakZDqgMU98ePEvjWujF96IkM4SOTV1iOlM88K87HTgLsmCxnuSTlVhZBvA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167491; c=relaxed/simple;
	bh=Yq9eZWlTIDpBT1jqRXA1YcQ7jewB4Li4nESrsfqdqxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aeba4KmNKjHOTeyIHJnhCpkTSTSAHzmth4WEJNO00GDfmw2zMwKNVGO2XguKiIabxIUYV9mmlIXKopXcH4ajjtSvBXNOXfD2wz63MjFdckDQd6qgLjpLtr2xBs76owE2BUyenqzC75bhDTPCTIxUPgJQX0qsdWobsNLtLCmvx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHIaw8lj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqyYzGxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64795pmY3463973
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=; b=PHIaw8ljGKMKOyXW
	JOMO0FrKk7092/z3zBfZ51Z0eshaRXz/CQjQi3MqCNsDNbb1qyI6e1z8L6NOHnkr
	a1T9wEdg+HlOXoTK3j8BvpPkfYpIYnQpUUdIHv3nEYEtQ6QuuHUsOFBNOYnw/w5k
	G2dlYAXt7ffweosKr94E6p9uMOyUBDLi6BeLLgIrCIfN6eB3m4+vWiIyvLUwJqUL
	IeNMZtKS/iDJbuF36Egxpn6xYoL4qBCCYwivxpddkuSgwv+10CSYj8MbKhHJIe0U
	Vg0yh/yatuoRZzZWNG2qQ3C7Gm1F+6hc4NFRkzcjcFx6rUa0Rh0SVRfIm84CrLFu
	IbJ5LA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hvn2s8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 15:24:49 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-62ea6ff1ca6so709449137.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167488; x=1778772288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=;
        b=UqyYzGxtw4RaQzs+Lh7p3NAX+TfIazBHUHl3Tt9PoIe22UEUWSag0zGZPWXj6nFdoa
         US9Pn74G3mNcsuuFo+X/XgxXikIOYw7eFIBrj8S9FZfN+nS2vLJ6YvI4fHxY5uJlQVUp
         crYdIPHBbNbwuzxZ1im8QrBxY/KxQg0B/eULb9Wh+WUNMUboYLovphyOOjUL9Zw3fI9r
         vcvXH6fmR6WE094U3VU8efcdFEL3jwtRYslld5EKDupMG10t5Xvd7TP3Fyb4+9XJ8Fd2
         GIdUdFy1918mpYnHZwwBLB/0/YJNh/IJD552BSffi8RHc4Swpis0f4CYLisf+w/SU+S8
         SFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167488; x=1778772288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=;
        b=Lk6918+wmdbswED9MbYNun8l5oXWp/oLSW6eJvSffvgRu9hyj83e4TbNJH/Da6MUm7
         cuHky/WjWzoI8Rw2twBPAN39S2setkDhdn8rMdRxj2HN75jOX1w7MJ5M6rCa5HAkdY0v
         Z/nZd6UWeJmhaIGMVvzhfn3JN0qvcJ/XxkzZ/jxEyMFyTqUlMNvVD0da5TNbWB4/VmcN
         ii/A5Xt2Fm5Y8INuigeY+qxs5IQfOC6P1MegTgooKTR482+4g89+gGNlHef5ws9QCvcC
         QK2Jb8Nj0ynaI3NLrry8IUNRKuXzLgIGRnBTEl1GLOmE52JtBezku1JOtRTsVEXyOnYU
         CgPA==
X-Forwarded-Encrypted: i=1; AFNElJ9mzZWEyTY/FYUO7sWvMN2fzQhGOHQmao05E+Hio1xZNL49Jgct+U9xsd8sFvu0kv3IUNWV9DB+zTPSUi648w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3xsPZJxQogPKUMG1qZaUNgWoHK9/uYyHSZarnfwRVqmxY2Qo
	bjoW8AhoXD8V4ZcNFsdy2xX8R8mZaewS7L5Wgr13K0zx8G54OmKBhMXo3HYmDdJec3xm0cojq9h
	S1EXCW3k9oBdooeJTRxSrEBOHmeqEPT6H7SgMwZUxvdfKAhoGPoMPajigkE0WiHXKqcY6aQ==
X-Gm-Gg: AeBDietUAUbSQWsC0cundkwg3SuDoO/dPayJidcWutufSgHk6bLobza1KjWm6/NmRgn
	9gqHb7v5wEmbCNHHj+D/ooO3y9/2DVB59dTyDSLSlih3oVZHWRLxUH8nbXeHdQeVCLyKA2PSyKh
	/zxiAJnpxdJ9SY7Xcsyq2GBzVJm3eRCirxnpgfZDcEoQha2vkpEvhxT4eSkvF4x/9ASGOoKn2bM
	pPExx293D41/oXDwabWFfKtHMpEiiRI/mAGdPo5Aqug1ETKUr3uAz+BBCr05KeG7eIq9DA3Y+hJ
	dPrXUhR7DlUPHgWKFDvyddiV1ENV2i5JCmQdKUmwISapL6iK6t413UPRN8T7lKOueuTu2E1jZ7P
	HNLKvqSwWr258AalnnR9+Yv4sPatCJdXU6irjbbvwRZrL8yzr3Wx8B+acGSOphMWX8y/HdnugR5
	2Eo56kgqNLz0XN2mHjnYuNuxfzr5g=
X-Received: by 2002:a05:6102:1614:b0:62f:c97f:aec4 with SMTP id ada2fe7eead31-630f927f4fbmr3735585137.27.1778167487901;
        Thu, 07 May 2026 08:24:47 -0700 (PDT)
X-Received: by 2002:a05:6102:1614:b0:62f:c97f:aec4 with SMTP id ada2fe7eead31-630f927f4fbmr3735537137.27.1778167487442;
        Thu, 07 May 2026 08:24:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:36 +0200
Subject: [PATCH v2 1/8] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-1-bf17edd5134e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfXxD3aicWEzxsV
 fZHreHmoG0Q2WyFprsVLSnaX6Og5oMIMOtsdmDPT3rgXj9qt8w5Iv5AlMJDLeL7S/pY21lrP+Ti
 HD4yg8UJ/BJ1RHLnly4LebkMEyouHMn3i6dh32WZAitsUbQD3KM2BOP/XAYTTWlJB2aIAFXpyGw
 YNZ3O7cf0swCeYydvJAlBrgPVQquNLnvYgVZcJnXnEQ449Zs53rmlrmGY3BkzZ4gCVqNWqy1SfG
 Fq9v1wlwBP2P8W1jj6d6b3ZZvPOTpgGaYNJ6uO0c9iirF4ZcIf162zkyc3ugTS1QWnbjItpuu+9
 AwKZoSRegjzXdNY9tlJ/msz7LPGh9wpjcbct5dcm7k7+LySx1SO0xE+Q43kARawfwbqZp0e2QGK
 I25pdJXJozh52QDo+8npj/iuPXpK9s6mWOq2Gq6qjy4LMMllfau8QDFNJ1YAh8CfQ+R/T6l4dFG
 vuBU7ojucP1ATVNFWFQ==
X-Proofpoint-ORIG-GUID: Mc4fierimC0HLqK-P68nE1xhto9THeHC
X-Proofpoint-GUID: Mc4fierimC0HLqK-P68nE1xhto9THeHC
X-Authority-Analysis: v=2.4 cv=ZZ4t8MVA c=1 sm=1 tr=0 ts=69fcaec1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=hFPe-bIbDLvfECHHD4sA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: 3E3AE4EAFAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36069-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,0.0.17.48:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.21.24:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..b21426a49cf1d9aae5b4e8e447b5be11b08c96bf 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -40,6 +40,9 @@ patternProperties:
         contains:
           const: fixed-partitions
 
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 required:
   - compatible
   - reg
@@ -86,6 +89,27 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                nvmem-layout {
+                    compatible = "fixed-layout";
+
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    mac-addr@4400 {
+                        compatible = "mac-base";
+                        reg = <0x4400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+
+                    bd-addr@5400 {
+                        compatible = "mac-base";
+                        reg = <0x5400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1


