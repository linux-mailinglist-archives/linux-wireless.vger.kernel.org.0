Return-Path: <linux-wireless+bounces-35495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLlvBYnD8GnMYQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:26:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24A486E76
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB5303037CFC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500BB351C2E;
	Tue, 28 Apr 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pV6jaFMt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AnTC8ue9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916344508E5
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386206; cv=none; b=L+4cdpUIaMwOiEI5YNZ5b81gZuhW8zKvhHm5KdN3y+zUli/0uU+XWXSQ/MROXUAFbjRGZonNCWvmpzjtxjVNLyEqn2SMRlqmqhEuOko25Alz1L+54ceD8r7VkLT3K6etwBurv569gumPlIlOAqX75rOZ5mazb8OTE1nox/C+C3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386206; c=relaxed/simple;
	bh=cAnljmIAnY0RgmqbpHx3i/y6lGT992IHdJ79dMHjCc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jd76PXK6ibryPuZM/5Bz71rL0yHg3rO7FwQjCaKjuZb63MbIaCXsim9AQGyvY6eqm7nwy9h9NfAdf4bX67jwSRnyVUGxFVBDNfGjkSZzppHsh/4w2U79Lou5a7A7vJrXNcWXWulY3LNHtO9iuPnfXd0nPxY7r5LNQinCoPOqkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pV6jaFMt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AnTC8ue9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S8qXkW662982
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0EtjVuK8tfVE6lW6LjScpaxrDNQ+sqkyAA5l5tfy/xI=; b=pV6jaFMtwD5NMekP
	nZgGZJa9bXjPxtiaCr3uI+//DV6UjSWPh0Ypf0f3UhJ+BlPYQ4HFT0U5Quh/yDYr
	V/aKdxN5iEj9NS95plMyA8u1V2vutmcvrpa7BL2JKvTXhw7ARLp9Sm0X7Pe94vJR
	U3SAm4VnBGjaBrBuPp9P/phSMyJS/yrNsJqcKGHH2BVOyBc1mdHkMG+Y3jCJJKmi
	I+LGPClg/nEkiiTtCBcacVkYHsOG0zuLfH07Q3u3OB5BaC406zg2RxOEZ1uam+ta
	siRy78avZU1ZRgTIOGLWuaPy+Yfu9ffQ3Ec131pVTWxFPLP9IPqwsyCIRBiPqUeT
	92h/FQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n4bp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:23 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56d9f191b6eso19432117e0c.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386203; x=1777991003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EtjVuK8tfVE6lW6LjScpaxrDNQ+sqkyAA5l5tfy/xI=;
        b=AnTC8ue9hT0r6hTBiEKhc4aQnaHQqa106TIND4E5d4v0ZlJFzDX/AUsgSnRTDd289T
         m1fDS3OKBvkRIDlkYSE8O/4OaptigXVkemqvFh3HQBftLFh3+vTkMr057LDEOpDNyCGz
         ahdOw4DhV+BoX2OZf6w+TVf1nK8hJ8TG1gKTRQ+yQB4697/ShXBycBXz6vJy3oAvjRmO
         Vb9KDA4+//nGL8FD+72ePty2IJwIe8tVGNb3TFC49/WlJRdrw3aD/G/QogMgc33ZEtbc
         ZoBClIZRdKB74mN2TxeoGKJ8BQcFzBWeFLuCyytzdiovjAHdIe2a/i21h/0Ppzs8G08j
         KB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386203; x=1777991003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0EtjVuK8tfVE6lW6LjScpaxrDNQ+sqkyAA5l5tfy/xI=;
        b=X8aS/Un4QkeoBypYU9fmVGLqbsA/HOOurpCfju/HA3tG47s3DXmKCIy4dIdGm/I8iR
         /xe/qkE1LyFIDgVe+ndT7DjdTZ58f66mnEjky4byIRwX6dcdgoC0MizzGPdFzsQ5MaFT
         sE7Hf3Grou8USpKJ1ivsIoyHjPpgkag6lXz22nvX5uqORd3n3CcWpFpzJVM3llj/XAXm
         7OG6/zK+WOzpvIeoL3CtLYaZuvlvDjXvx8yfhuXlNtMfONleGux7tdBCR4xNBIv9q9It
         P4hq8bRYqXWUH34I3zZU3tkc7wC1M/8nYbCmh5ellydlV0zYIJlcu97I00AsiX5vtC4p
         Hz3A==
X-Forwarded-Encrypted: i=1; AFNElJ/PRrJfnkeftKQWnXomBoSYQDFxallNy1vFKhlGgivba4b4+wGsSOWGcEsgsxVQXqgnVwJ7owUjgBGX2xLLhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpl+X5PabaeKTtfTWT15LcuHqoy1NBf7B3l+y5rjA1QhfhUEf
	AlHy2bkRZTY+jMUNTBucSDEBS0K5RUs/85dLcshfAfUrdOYzPrTC4/eGsc8O8gXxmsVhn1qWT1y
	CEqG6QKrUbKBzZ03siIQGCM5xW/ONcDAr75/UpMP24e+U9jT2y3hI58yq8/9nmJmDrlZaFw==
X-Gm-Gg: AeBDiet2/M549MlGhU4FZGDjewfbbdVVHzKbQ3OQAUUBycfe0gY4r0L7kQRRvia3aZZ
	tsYt9CyBHuwz056bgtezHLwQdViqRsBF34NAoozRURt3FCz3C8Fbr0a7Gv3+Tj0SmP+L2VJqMpl
	ieAfAzP+zYW76Ua+kQgpjVm38ytiQbWhukcf/CykmfpCThxiIgkYVFpne9O7R2D5h+IhBjl0kgD
	TCzleaUtxzH6MH6M/V4rwAOENKP9uORoXGN9oMETyPM63ZJaujCbHslepsczL/aTW67fgKQqLUl
	uw/qhh9zcHhmSeB2YARhz1Cbignphl/cRKXeaRNHlG/UoYuWDi3iqvtkKsd+98TjJ1afrHSJCFl
	/S2fod0YqBqaqdSLlZc6jGg2tdLlZ0yjM8kmKr3B/CJe9J9Jq+j6ZawUlVaKwfyrMAEVxu3eBuh
	2gsPJnwwa4gACvvyyY5T191tkYk4k=
X-Received: by 2002:a05:6122:3781:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-573a56a12ecmr1637583e0c.12.1777386202703;
        Tue, 28 Apr 2026 07:23:22 -0700 (PDT)
X-Received: by 2002:a05:6122:3781:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-573a56a12ecmr1637518e0c.12.1777386202261;
        Tue, 28 Apr 2026 07:23:22 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:20 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:09 +0200
Subject: [PATCH 4/9] dt-bindings: net: wireless: qcom,ath10k: Add NVMEM MAC
 address cell
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX8M5osFYtv5Bc
 19xNy6QXJ1hYJtBkx5OJR429clvCC+e961SBC5GUbCFn0lNBDEIn3tm0s9rVFfh8EuW8XOOhdha
 RX08juXaPqJWnNt2DRxFVcYAoXz6CBOlc2x5ujWNisPpYsVCTbbT17Jun8MUNQPmoGoqXBjwhUY
 2RQvCsKn9uItGAsfvqJoz8Q2N0UQthW3hByt5l1B0CX2EMlF9ec4fg/Kl1edUVhHQedkKHOO/M/
 7rO+F+Elj+Y00hTg0W+WCtNPBSptz2e00MlOy2rd4GvXNt7q3YllqRGaYhn3oMmD0kw2x97fzfn
 qP5H4xV2r86eFsepAzQX20kaBISzuUTe4YXBhieeEgmZIZtObBKr3QLWhlzetfZXnMawx0LyD96
 RmCgXICwkoprUTeD5ZMxOBQ/sirxkBczmMitMOiKpa1pqljvNKB+QLQGVCSBzRBuPfehOmtaCZD
 ltAbe2SXyymuAidonjg==
X-Proofpoint-GUID: ckYHI9_dBMG2HIpm7OOkLkygSEoqXnrs
X-Proofpoint-ORIG-GUID: ckYHI9_dBMG2HIpm7OOkLkygSEoqXnrs
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f0c2db cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136
X-Rspamd-Queue-Id: AC24A486E76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35495-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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

Add support for an NVMEM cell provider with the standard "mac-address"
cell name. This allows the ath10k device to retrieve its MAC address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7155d8b15cc145c3a7d703db0c9c3e056a54c07e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,16 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte MAC address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    items:
+      - const: mac-address
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


