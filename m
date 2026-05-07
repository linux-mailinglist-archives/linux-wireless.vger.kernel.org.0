Return-Path: <linux-wireless+bounces-36070-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEtvGCOv/GnlSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36070-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:26:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E274EAFD4
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03A603054CF0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80979451069;
	Thu,  7 May 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2LhJinX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RrFaubmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438144DB61
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167494; cv=none; b=S4c82KwXplN+lKrrzF4rY1z7FahdaBAbojl04vh+OkBm+aBbCOH4o/8Z3hINuKOVaGv16EV1UNEqM2VHhUAVjdOFRJqTCqpLLGiwgOWJ7Yyf/OJNNG+jygHXVStAqFBM78IahEwz+5KEgcLOjxH2/jI5AxEniEn2huZippU8ajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167494; c=relaxed/simple;
	bh=aWIeQEdmSLhgx88ywuNXkmaIu8+4RM4LnE64b4MEZHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILl4i1aiK1W4cWwqKbkeKg/M3bibQuYeWyQ40BB5a+j3SBFWyERtxnfudJkOI/zQGge3VzAL9Wd7HQB5J6rARQXrdWb2XUwYcsVFkbyLBIy2AKyWb0Ft20swAgNd52cBBGd9eULDdTOgxNYomPI6A5I17hRqCh2+7pZqNfcy3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A2LhJinX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RrFaubmw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64795pmb3463973
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 15:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BmKkWNysoQOkzQVu0/HpO6GRxwgi9ndXDewfJyYIvjs=; b=A2LhJinXkxFI/S96
	9vte8eeCRxFZ/E3ZYfrJQhuW21ihoIaeeqWVGUT9ZnEWt1g9Nqjg0us2pQSDCU8o
	puKLgB8ksgjnhr+8qycY2wZEqtnKH/wo64eSLK/DgtapCF9gGyZr9Yhp3EEZqXFX
	AOFJ0tp4dfPdwVx6xtbBZfSxwIRsO9nzFdFO2ewf9zbsaanbhqgC8AM9eWRPGm2n
	4K4k+eogj+kc+t2F5nNkwR9xmaMXKzfNi2t0wdIAw6RVTViVO5T8DfxVaqIr9qWK
	na8BUQmp9zy6TMKuJ1pgBd2WFa3Q0sgXHSdsRyFv8baE99MiF4vyAAK78VuqhYAN
	Q5COHg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hvn2s8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 15:24:51 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95d1fd7dce7so481262241.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167491; x=1778772291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmKkWNysoQOkzQVu0/HpO6GRxwgi9ndXDewfJyYIvjs=;
        b=RrFaubmwROjA0/q3REU/Ya8LjAcSHqVNS8tqLWl2fn9aGRsh6kJltcPlu3d5TCO2SU
         InSOo3lCgM6FWgR/KViqx2MvnzpPCfPWy+YNGS00xWhKLHad5jj+W8tZWn9JqTBRAnmx
         C0qbyQ+0pFUBL6GFJ/Xzyp+Ajy39Q2rOSNzJeVCuAOgTOxxBKu5HEO7+rwVHahfmI1/0
         A1YA3Z1yLAguddzwIVuvpPIE3FEjrGiP46pizFAPbM8mw5I7wUS58cESJF0gnR63kDzP
         ivJUq+eRetKEIJC+Zeyq2+y52eMK5zhoJZaA04odHMwHB0XAmsHogpXnbEU1JrPo/eAg
         H/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167491; x=1778772291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BmKkWNysoQOkzQVu0/HpO6GRxwgi9ndXDewfJyYIvjs=;
        b=Gljd9ZT8QjB4xFyemg3XPuTybw9NpBSHx3bxCaul7z7tgBFM3fLZQGZ8Dj9pyLwPp4
         9+Br3jU6V3igPaq2hWouOhp0ACDmUyugYIe4aLpjCVV39PtGUQHJtyapMU2YIwn3SIkA
         +/faDlfJFvIuIQiHjZx+shiug8vE0WIpo0zQoSgqiIfH54cGMYIpsRgFskHLCNdyv08i
         0jphFK46z/RZHMBsYs0+R4kzbpucTFlPu/+eR2rjDsW1wU8cYoX4KoEj1E6U/sXBlveW
         2hGMvt35Ox7GBWIRsmhjS4rewvoK/wFfflt0R/BDW316mGotVy7huQtuCDAVVCZ9+HjY
         0nFA==
X-Forwarded-Encrypted: i=1; AFNElJ8SRteocnRMHDiYvKogtDHU7KAZh8BY09+fes9S1Evrtxsm9GCTU6EbmeXPM3oeBuO0WEpNH7NKmdPm5ypQ2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAkfO8MOyVKlXDVAWNY1Zzg2iOtJFXogkv3K9Kdq2HmsmkESH
	ZNU3y4A0D3KiZNztvrMK8GnbZauhvjsdbTJSEIR6yTRmp1Dht0ZzsJttYEjBh3o29D921byjHJ7
	ELu8NnADaeikyrfcwmwN+VSyffpTOM1T46R5vtCbQDB+z25SntyGmz96zK4rxNzpm3+/mSw==
X-Gm-Gg: AeBDietIdnn0zYmUNi0W8W6NJ6IffuzR0pTqyy1glw+4mHWf1yfwcmCqU/LYZJh4ED4
	tjJ93+tZMROAnneOA6lu/hYipJ3UtM38DemglBD+JgcQ3Y+nZTHrCi08Q67UVDsRsIH9zlJBhGo
	46lUsg9v6JIngN9PdD0rSDkNU4YeJ8u353s4XRwhqr35Q6uHCuKzsyks1diQJCmmy05TpwZQHEB
	bb60ahk23cMbbu+KVrwvQ+K2Xic0eA+0kY1Cy4aznUiruem7Ir1C8v/mrrB4TDJLg3t7SJ0jahw
	EBnLG38U2P0LpZBBpheyCJRcogVm0KRNLWJGN+yQrN1d4GN65wmBUS3qPU1QH2+DKPNXI1EUKBW
	XycTaAsssckg0a7h82mljdHzDExzssZNU9M5GYz4XHTPA3yqsL2lYgwt9rYp5KYNiMH1vMp84GR
	08pOJOQj4yWkYFCy4Ex/Skf2r4BlE=
X-Received: by 2002:a05:6122:3a06:b0:56b:8e1c:582d with SMTP id 71dfb90a1353d-5755974b78emr4681421e0c.14.1778167490315;
        Thu, 07 May 2026 08:24:50 -0700 (PDT)
X-Received: by 2002:a05:6122:3a06:b0:56b:8e1c:582d with SMTP id 71dfb90a1353d-5755974b78emr4681359e0c.14.1778167489785;
        Thu, 07 May 2026 08:24:49 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:37 +0200
Subject: [PATCH v2 2/8] dt-bindings: net: wireless: qcom,ath10k: Add NVMEM
 MAC address cell
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-2-bf17edd5134e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX2ZSMWoDicuIi
 A99grG63KubC7WWVXCOHL3praj54ONMJzbEXbRuKSDc4T0MTAhQSkeS8RhtwLGCB8LB0EN+YfKI
 9VCD2o6R+eD/Aor+NCxYMS84X4fiBdqPwdCfsIoblyhhbTTeeqcKWjTHPIujTaUpbLRcOcCwT8h
 p+/QTLgCehXXIuj2GcO2N70p7ii9ih6pmIR3LPLtvW3qkgKHmH2RR5n3JEqYUU2eEb8VkRyyq5W
 gNiYtOl/V6ILrfptFubdU2LL5h924j3z+ERG1TDdmMylirXldhzanoiHYS9GYjTZQbNxbymBtYM
 F1GrbiC61RjdTcXY8PDB5/kdZwDYwHuAMNQTu+tDKj/EgBBS75pMbl083SWl69GO1pn1P2rLnTN
 4fraGxSJSIJeG+D17GgkSGmONWMNwB/Q/gzHk1iKVsw4wpVa8rfdCsU+A7IE/Qlk+VaHmr/pT99
 Wd1h3krd0LWSbqLiZjg==
X-Proofpoint-ORIG-GUID: t28d8ylkF-yitr2v6XXvnUssT7Ptol0f
X-Proofpoint-GUID: t28d8ylkF-yitr2v6XXvnUssT7Ptol0f
X-Authority-Analysis: v=2.4 cv=ZZ4t8MVA c=1 sm=1 tr=0 ts=69fcaec3 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: F1E274EAFD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36070-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

Add support for an NVMEM cell provider with the standard "mac-address"
cell name. This allows the ath10k device to retrieve its MAC address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..96e025cd1e3acacf3da270ed43955b0d6acdb7de 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,15 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte MAC address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: mac-address
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


