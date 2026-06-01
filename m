Return-Path: <linux-wireless+bounces-37244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEMaLRVYHWpLZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:59:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1660261CF18
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5993018D7C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AAE39C002;
	Mon,  1 Jun 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4Lwew6B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePt4/70q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707F39891D
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307234; cv=none; b=XDdVzqtDSPnEcJu6GL/grQ0uEqgLjoXbOlyrBnNTnsU5NpAw68hjVBZpsX+hrNUVuQgL/V2Xg4+TL8/mxUiuxA/a8lUqPKW9LiqHBvjGBZXS+mUBy9K/dDzn9zkTRhKW9oH2aPCeLh8Y6CIZxp/3PF0sx+hnD1AelIftebcLzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307234; c=relaxed/simple;
	bh=PJL7aaDGxCG7o8iXjt5pBDebjiba9LJ5/Sp6HGBrv0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epT0bgPwBJbKnqRttPfzqCbqZJw5UYPGMzVzjmBY5a35ixeTVb0ehhplAQJMIm3MeknHx59xVH7coIwH2NsJ+QaKpjlmhwyv2jWKrYO7MQGJe6+t/bwOQQFbsa3fkgG6vzZ9pylgyKv4wSEu31ADSI9w4CEmblQ88sMC5grg21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4Lwew6B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePt4/70q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6516r8RD1073320
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 09:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=; b=L4Lwew6BYmpAZpET
	uHq4mtGVCxQZUNjMnxV3CC4hzBtfhrmfd7igLZjjj0sidERPJ898KZaVPkAeu83f
	OxAZw/BKROk7Sj2YkW8Jts6KslZOTurqlZWSA5vqYrWjKkHS6SnXTzHYevzAMu3R
	qnNl3BS9aO79MHakyoXmfhz9hQtdwiCvldtNOZU1TB2z3tjofliUELawBCusx/bR
	n0ZjRKAVHXg06cWceKTJozqjeWY3AZLdJSqbYysjsxRKlBmj0udfC2JospiXICUM
	6PGjTCT50C5qGrghFHU4NyDkbarxyb76y8JFl+H4isQvysTcN1hUmb0nyvXpfQov
	D9IzSQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efpw7q22k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:47:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51736a08ce6so39046781cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307222; x=1780912022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=;
        b=ePt4/70qEtUbzziph4ordQaO8Cr0dcXiB0CGxKBuAup4Tc7Sw/v+RQZ9Q/eir8Hr2I
         RrZYZx1xkNvDLjQ8QDVg5CTRc7WESceukMHy0f4r3F2TPmgmq+2QN3kMZPbLWdOD3Cf/
         3HylN5wJnNYlBAUNnSaKeqFGn8KVLJ5hJe/jrcdcTk3geI1WWkyYQhB/GzKwRA9Xe5D1
         fo4yNRjxc/CAB/UQ/VUw0l+tJeKXqvvDndpGCYM7iLrgJFARTv4aw97IXfwrhO0/2fUQ
         sPmKR7cGkIsDZA71hDxs92Y5tXOIryD3KXaga4WmOatKcG7wq5f8SuzjqlKWqm6tm4sJ
         bcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307222; x=1780912022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=;
        b=HJJ7yE7v+Og13YHa2NEhrA6/bLFbG3+HaFRcaSFYVlmWF0+VZy0LSy7PaL+ziaKpTi
         4NQ5ISJDShlmhbCqNy9dgYBx8RI8E6+rqoAeHR2xpauBvoz827MSnGRbGoZpAzFfI7Wo
         CnXXxe/C8A0DH1wygti+ngd6uxFlulq8PJLQ/S0vxHXkrs4oy51+SgcJPW7eF3a1DbE1
         /BTxZVeHotoVDUlAPwDeUEEUwqdR6rzgGrZ5B+Yken3TigT9COP2R+6Bmaolsb+73qqS
         6qopQngP4DW6zrTxT8gd3rceAgCAZlW4BRo4pocbVkGXjcN0mLsSj+A7EnR5V9pLKh/P
         qYmg==
X-Forwarded-Encrypted: i=1; AFNElJ+s/NJqgIRNu3fk/x6Asq4sf46E25Ji6rymHXjtBiq8tJBQ36gboorZ9IGS0mwSiuHRO8Y6MOTZ5fXbjZTkCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2DvgGiDjPldOivOQm9BrR5XecNHn4GxuCQOox5Vm3a1K7oIFo
	hzG0KBNB2E6UUED88I30OpiNOIHvf5s1+v3kR4jGCcSDhQfHmOJU3582Fz2AliX1/ywtdjjJF7V
	lq74q+Hu1cAMYV1Pc32lQpsTUcyg6wptMF7Lktsmo/ciddC2v4NUHW3tAtXjM08YjuSVcAg==
X-Gm-Gg: Acq92OFh3E+mZ7siJRZf2xvjfrg4LAdXRF4rp/ZlHtXUirXKa2ZbJUahXBf7u0uWliG
	weR6QKBUU5gvrHOjWozhq/UVmr+KPVFea6+ClvbHd/MoPk/YFJu8e2dpkGKuTAkCh/S6Xy1WPJF
	lr14hN/K2T0l4afI2vxJNq73+Jv0Wm6s8mNxlBYleQ+OyDZrqljMVBbetdGx4g77fnTv5VZmB1R
	qDnfMIKeNSi0WQGou3jfLRAFyWDFQsmj3NkJDXLeRqfgcVK3KXLOwuk3MeIcF94yBsQx66q0Ffj
	MUyw4GkpzN2zRZja5AoYDoihGnf57zuBpy9oW3N3pc9xDzI3hO3VFgeBvId3btC4yq7xPEe4sEt
	11CviBT8oIb/RYbPWwPR3Gg5G3qkkJgDIvPtq2nvN22fjuI8mQ8oldrfwV/OhZ7oUoZcsoCoiEc
	AF5GOScpRRCVj5dSp+iPgYx1SRWb1fEoC2dbKA9d6xQWGlfg==
X-Received: by 2002:a05:622a:1dc4:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5175e1efa52mr8691641cf.28.1780307221792;
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
X-Received: by 2002:a05:622a:1dc4:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5175e1efa52mr8691441cf.28.1780307221405;
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:52 +0300
Subject: [PATCH 4/7] dt-bindings: bluetooth: qcom,wcn6855-bt: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-4-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PJL7aaDGxCG7o8iXjt5pBDebjiba9LJ5/Sp6HGBrv0I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVUKFzA2GWzfnPbRBNnS53Q+2DwhhafI85JAG
 lkifT4EHP6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCgAKCRCLPIo+Aiko
 1TRLCACzFCWDg8vta0kl/Q/xGa4mRMzH/xV5T9QwD5QgcFB6m/mbqBfpwArl2qrB7+QImIHy6ky
 RJo19vvWTsrpy/+sirk4YeZAQUWPh8VcZDHbHc8Pb5eps096styxqBgKh7bLK4YqBw17Tb26H9A
 XP9BNsdX91u6ESQLUeMCDyrtrzNRZqu9EvZ4w3jaYtrn/egKh8Kqe1NcaJUgWwsXxKZlWuCV46A
 K5OOz2knudfmQxcsf94iP4X21eov3JvZadH1H/Sq190qQO/nxHoxk9XIn+VPnVEBM8AExGcP5LH
 c7Jp1/RdMTRgcnzWPbINBFsPk6VDwXdh+4KRhhs10LRk+rhh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: zuU-15JFpqpqONHI6kCVzB5qtE63mQUx
X-Proofpoint-ORIG-GUID: zuU-15JFpqpqONHI6kCVzB5qtE63mQUx
X-Authority-Analysis: v=2.4 cv=bNIm5v+Z c=1 sm=1 tr=0 ts=6a1d5516 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CPtQq55eJxPKLu9fJ8AA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfXykTOYl8fouWb
 CbhCCwO2B0rA98DThV6yLTDbIMjtxTGDK0DR4O8m8RaspqCrVny1BmgntWarhVOGHtI00ppAFWh
 sZBHTh/MFRnpSfO2S+GP9xeRogEVwOnXbjV2DpINVKpZfJw0h/WZad0CkKl4sn+GSRF4Yl7Agz3
 XMWxm/9/6BmB8Mg5NuGSUOlesQVwPM4bSoBrFdqkea3MF2Ym9QCMdu8btKgT8RB/mqwZXptf5CU
 NbbnS4bDvQXY/DALCmtz1t2M1y3/RvUdGtvoupzxqkmvaym7alQpaIGiG8fWmyLmBRG/SL5E02D
 y9fMvIneDRMfS/2SGjw9AhrnJn3LNvqAy6zhA5n4bogBkxQ6dEZLtBhEsbHr7AOfadxoOSdfdIE
 0e15loiZ97MLil/hbn2mfpRt1tPvWFjjeE7caeVNOoq6I8TPFxP9EmQKIMxIc3Ke0AvTWumoHKb
 o4wIxjt4QaqvUeIgU3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37244-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1660261CF18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml        | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
index 0beda26ae8bb..ec766f40a042 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -13,8 +13,12 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,wcn6855-bt
+    oneOf:
+      - items:
+          - const: qcom,wcn6851-bt
+          - const: qcom,wcn6855-bt
+      - enum:
+          - qcom,wcn6855-bt
 
   enable-gpios:
     maxItems: 1

-- 
2.47.3


