Return-Path: <linux-wireless+bounces-36071-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF7SHUuv/GnlSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36071-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:27:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B745F4EB01D
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EC163024109
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80F4611EE;
	Thu,  7 May 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pngJchIU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jxI+G6b3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A39450909
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167497; cv=none; b=ZALtaBK8BHA+W3/WmdLPL2+AqXq1OlcfGZrC7+AbVR0Dl7STfMTuM2IOh1m5h7nppDqnULNnnKkphw/IHc+qAFiFdUmL1bKbhmu/+w4q9MgAfU+FrvAYXvNyUvckoyvBWF0DEJy4xyMUrizRbH85wzhtK3kLZDLDujrRP2coofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167497; c=relaxed/simple;
	bh=RjAXLDtyeqYajrszhA7+nXfORAO+2o+t2+Lsa/IoOi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGCA8t8XoEmC+iUCvbu7U0R4Int+A9UdeDe/KZBHwotKXIP5n7PY4RP7zbbZn7jU8mausyKpb4dY7H9D3rumyHJRafAme5ACuGKJU62pVM0asDYUWpE0xT4drZZYNdGLdHLAEimnTjs7ELgJO5kmh2Za3qve2fqnGletjzli09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pngJchIU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxI+G6b3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647A6EEM151176
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=; b=pngJchIUuTR6hnjQ
	lUECzDHVo3pz1dlhpiqmaq1DuAFQv80gbFnsc430vvYvth4mo1bwdyR6UWKw5WdL
	WOpcq2EHSqx0x7SuRWqWe2LCyY625A/6sKNH2CPBz1+ERlw6lSn9VmVhjg3m2AjE
	9xjqaSAc6WqXXEOq/Srh54PIvF9/IBE1T0VyqUIqyRFa90B/3Dgo/n+591Morvba
	unefJ2L0hLpbQtFvm9AZTpw+nb43cU0FWeITrCo5GCw5BvFhhlt8ia+b3JuFJtgM
	lcihyLA5QdlvrdltBs6JtiQmmkeQ7kGuSsh/wQ29S1Y3j4W5t0tX7JFr9FIvJpJx
	E+BCeQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kcttg4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 15:24:53 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-575590529a0so1935907e0c.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167493; x=1778772293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=jxI+G6b3mTV3gazoiC4aUSTNbP5wqPMTene2mNpHXaXsW7p1Onp1Cp3VYHxEi1ACdj
         NGv6mZSC2cl5w5ZkYaK0AFfSCz7XzDMNjVk2soWHW58RUjNSwPaSofUssRXD7uUc7oIZ
         5Ww61+6zHtUUvujAIqaCTRHRtvyY0Mmw6BKQM31G6jgDY3j7jcaOgfnhRD9MRi2LDDeN
         6we13Oe2MnNANU2vhdnpgfbs/keHR9uTU8W2gxxLgDa/G+Nh4YGn8e3U05OyID3+ycJ4
         mIqAjVk52B85l6VQmIuxOo1jlKVt8PV7oTAZflvmlMBOjlki5XwhZrkqHWjcDDU0QDP7
         FXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167493; x=1778772293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=QmuNexyhyQhTxBGhEim/ZwitKmSAE9ZfsmsP1KUV/7OYoh5dYXEGwrtFRueZOF8RrU
         dzqTlytnuOaF3RvrGEXzbLvP5kHhyFh+2FWCO0+cSszjy9FGggYO+kigZQb0TFhdS27L
         W/ckrMJFHND2QeW+SFyzO+m6l9xKVCDRTnUQJLTgdB6mdi2R/+xI4U3rnBGG15r17mmm
         0i/hu/0a1UNwglCTIrC/UmmW9xOF44CH9Bjc07cJJTayM65bWaYTyoAELp23Bo2g4A96
         tRP8Plvtfkc9mpc7lp7u2xUqEpV/qIHuSL/2asIt+vwG8n4F94ieI57L34UgLgdq0Nqo
         n73g==
X-Forwarded-Encrypted: i=1; AFNElJ81Z+WFccz82YVG1hUa3bppHiYoK9ueaTXDg6y8FAKApHKE/OzwQksePHDbD6JWSI5WgWTTIU8Y8a9o6QqPTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfnz9xyhwK4UllZjUY1PdGFIwM9UeJX/vciFCpGbITHfpW+Y2M
	FepKIPHRafVpsFfM2POEZqp6RYwCcyZzU/pDC7P2O80qFcFhYhVCFDcXsU+aYcSMPrO7Z4NWVsU
	Ud8cBA28ygsW2RlA3sPhWGCAESgUbLzsj56Y+Evp89WN5B27K+wLC6VdsqptTTnAjXULuLg==
X-Gm-Gg: AeBDieueDktWfg1W7XNDiT44oTPXIK6pEQQSYUSErML1gXzQlhHuGTvOsnim8ikwv14
	ITLQEv4kPSfhFcQwVdlBoMdVi7CENnXhtpXdDfO0IP3CACPcACVQdAfDyOqiGr86aD3J+x9x9w0
	oj+7P7+1fapSrKx3QS6Cy5b+JdD7Zt37hZUIMQQjJqS22ihGpKLkfO4JYsG9jZ91WSjZfbqbyqk
	scAZPiqhHP71BpmTjJQX/JpaCshuM9B9eqx6t3TLHRfDcNLFRNa285EpycYX9GonuNp4hPLaJ82
	A7Vgnty7Y1Ivl77/JdejahKqam5vuz/fZmjhnTcT8UZUnYYiDymxtvJV1gy5nzPk5oEZrbJ5f5w
	KimGjx5CqJvijDcKa7CWiY6Nb9v931vzfb2OBcOvH/oE4Lb82I0/R6nsN50mGQQwDfpQfX/Jh/v
	hYtSFRr8R1wVQ4L3uTjaEGPasob0g=
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5439018e0c.0.1778167492609;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5438965e0c.0.1778167492169;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:38 +0200
Subject: [PATCH v2 3/8] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-3-bf17edd5134e@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fcaec5 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: uSAqXVB3mZnoqi1lv_VZZrHDHBMH2nbY
X-Proofpoint-ORIG-GUID: uSAqXVB3mZnoqi1lv_VZZrHDHBMH2nbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX/SOA1dBCG+fe
 IioGv/HlVmHoGyOiPn9oKi+sR5Ydz4ox695SuHmP3pJrFJT36P/3zhaahWcy8sc/kTbby8dKLaz
 yLg1w88Nsw3nX03lwrhPs2kVD5j1hLH6y5etJ6Trgt+rav+7qH1DUMR/ALqXzZwhDpKl2yH9WDF
 suLUDwGNimcKh7W/T5/d6oT/CaL5JIdoTPEYdxiSrl+d2H40YdSyt4qKvPcHBelBXzFfaBrmf2a
 2Qeb1IoIdtkXBC1oJz8VxMeYQc9vtj6P/7dyEFZDP0nGc3j1+nw6D4dZ/Qvzdxhkw+S2hE9OXE0
 QF9MJiUCjM7m9i741p02if5yR5UhSEK8to/8hVqlgpvSxhnBHaJ4m6brYI9tWUS2sVKDtz1NYzX
 H0xlo6yyiiu6o03MqrQj+29dh2gtKstIiNVh5EKi3HAgaY7OUgVC6plLyam/5tmmya60LPwId8u
 53hGiJv9pGihkabQzaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: B745F4EB01D
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
	TAGGED_FROM(0.00)[bounces-36071-lists,linux-wireless=lfdr.de];
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

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


