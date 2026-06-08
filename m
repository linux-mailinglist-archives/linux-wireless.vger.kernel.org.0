Return-Path: <linux-wireless+bounces-37504-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 50HMKNyfJmotaAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37504-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:56:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B45DD655605
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:56:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=duqs7ePV;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ib1PHrpC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37504-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37504-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A552D302BC8F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8849733B951;
	Mon,  8 Jun 2026 10:50:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48332720C
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 10:50:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915847; cv=none; b=dzNGVukS2eXl/Vw+N0O3IqHGjR5pVSFbH1dec7ezTtGatGFHfyi/LF5XQmAKMUUdpGK0DXUDBNxNurcXFV37yQeGM2zDs5wnAgKFl8QAkaBUcJxNQUi/egpUS0N3BZZG6qKdSpd0M2COoxVEgBnUA6Co6RlI8WlfQq77z/Vo+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915847; c=relaxed/simple;
	bh=0UCJVzorof5nrjL5gUJKlIsdVzG9DO/UXG+s7ukNm/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShAQF8z02+6dD4vCjWohaL3Kpwqg9O0q/GpgzoS6itWpWTdrV+ATMTg4c/D5hW64jlN2xRw12S8SmDPNKpA2NAzTjM03AZIH+C5mmOyrjsS7CmzM/W4lpXrM4Hv6bgz9aJIDGynzNIbfVeR148uOS05JJF7Oi71vYiJoinLTyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duqs7ePV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ib1PHrpC; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PjXh2733091
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 10:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qWJbmuTRttn/XpwzU/tvQ/1KKugFbudRhbcfvqo/7DA=; b=duqs7ePVjQYUBxv7
	8kevIzWJNFV/IDiVetmiSOwcEHeYmpb+rToxrVBkH7jYyiFehWLS3zXFpeIrPzgH
	j2rnIT4Tk59sIcoFlBUU1x1rAsp3r+AfPw1z3qz9MqRXDxPWeFRWca7rwGghpKak
	PYj1dfHaC2drlFgzmbmv4T+TrvzTpQEVDgG2W1FrWEuyHDD5RlrnxuiY+phpKmuv
	nKnXpjnjykPfRW9LRvaptOphCVPSN/SWObDKBb8SHZrw22vZfg8RHr2CxZiHAbX8
	pncTphi8Cq6+oZ9GMUHcssCtZdFtriQBDIpAY23EtHvwWFBW/vPfM4oKe/W0vy7X
	uXmCjg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf7j4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:50:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ccd5491db4so30304506d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915844; x=1781520644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWJbmuTRttn/XpwzU/tvQ/1KKugFbudRhbcfvqo/7DA=;
        b=ib1PHrpCF0XV/LV4vyvLqwxO3AHD2nzHjHX8KMBCirqUesl0r1Ci/es227zCiwBCSJ
         XNrMzXuvJYPi7PfwFIHOm/36lv49whKMleVt2vpbhjoG4fgEYDJ5FMsomKUw8bcK/JgL
         OKMcQBYwzIf9gdkqIfH7buFa5SS/rz8LwA5Qnx+Rsu80TWkZBGSw9Xb9Ga5xshpmPMrr
         wUUuyOsNJSwbmCh7NA3bdK8JowB+4QJYUPIIWTAcTuWtSsqdkf7k0T3GWftNaPbpRhUy
         QBpYBD8nPmj3HumH3BjaC3G6zi7PO2rEUnUP8T+wZSCgXK6mqapmZFEOb4dKoBI/ge3O
         WvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915844; x=1781520644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWJbmuTRttn/XpwzU/tvQ/1KKugFbudRhbcfvqo/7DA=;
        b=AVdk4hIaXout8y1xKswJ8FSC4U7BbE46M5nt6bVhhkACov4nkbOj3fwHMLWTiOzNrH
         cZ1cycTsbDB424DBFypvLNm8UmxxKjJrzRKyTb5t97XcMo48T3TChbs5jDDy5+gcECTL
         NxJONpkW7XD7pGqPBqJ5CzJwO/t6tYssTO1Yed/y6vzd/2gL+KcnbJBnSFfgeIaFco4l
         mafvHd7OF6W5pOKX28NwTP8mZNCwgqcxjerP9X+7kk1/neMDHYmWl1kOcNJOF5iz9eR9
         uSPS0j6a7TG9q4/zx2cvLDGlvgDqTZljvmOgEbdZCuhq1AOb4Yf4s/3w9/XO6buTH3Iy
         NseA==
X-Forwarded-Encrypted: i=1; AFNElJ9hPnsGSiNVW28dLBblSlIZmtj2Ha1M9vZ7wCYJquKEQGnQ0jn/RnvgnNgjCZfL9ACfD2o22f+QWkNvQStwcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYZ+8oQw2GWZFL5jEZs8FlRlDQefAd3Ny5A7o8aNuhYwymI6o
	xAqKLtL58GJuwhei9qHSoO0GnxqI/FbQJZinCi8DEOi887fS3ENcV0z+KpmGPRcc05SouvfVf1w
	p2MV10iMJ7r2GwNhbn4eyisuzvppGFk8M3YvWyN9jMa061z3+02BuZfUow/JpkE5PAOZm9A==
X-Gm-Gg: Acq92OHRTZ8XM+W/Rvl7IcWRr/Jt2KTRpmi7REWtYRFetPBxbUwkKw2LkDIdhCq2yM5
	pnH3VMmhcOfA1BigJp0RjiqNv7Jaf1F1ZaE93I7aBDWqpxkXGwcVqwKo4iEMP4UbgTYaMA1+yZu
	Zf6SEtLRYWufYjtU9JTGIHo/JOzUFiumeQ5J3/eS2oUdsDkfx4sYKRUrhqAXYaJjDiV033VYia3
	QRmbE66zeEcxZ1B6njIBcHQCP659GCPmhcaRT54r9rzQOQfhIJUAdmGWOq2tqP27fsualRyLmF4
	Jw1ZkuiFMmPRsViNSC7hN/gGfhHKMToaE51h/fBIunkPXZaD41/L3sbgPIAlDZrCcWf559diHJ2
	BJLDnpscAeMRijdZQybaIAG5IsDWID5roA/W0J68rBPFru9o1A3E7iqLab+IsQ1WIaQ1zjmydVU
	xiTmcZfi9wyWk8KmxODV2rWKiVrbM8XaRKWjdN+DRFFmx/MKWsG/qAoilBWsJLG31Gq/y4jBxl1
	U78mkFDEdta
X-Received: by 2002:ac8:73ce:0:b0:517:8f52:2724 with SMTP id d75a77b69052e-51796953373mr158456351cf.43.1780915844244;
        Mon, 08 Jun 2026 03:50:44 -0700 (PDT)
X-Received: by 2002:ac8:73ce:0:b0:517:8f52:2724 with SMTP id d75a77b69052e-51796953373mr158455891cf.43.1780915843813;
        Mon, 08 Jun 2026 03:50:43 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:38 +0200
Subject: [PATCH v3 1/7] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-1-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a269e84 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hFPe-bIbDLvfECHHD4sA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: TDC0ZaEAA4cbQXwNhj8PTxSQWBq_dHJF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX0S8hi5zWM0xr
 ArP8eqBXPM6KmAQJVq2JeLNQrfJsvzx5+PZJleW0FrTu3QZu3PS8ysh+/h7pEG6UkeCT8jQ/wEj
 BIwBGo2XLXISF+WABzmih/On3t9sPQuPPlNgfEm2ysnm5Zy5iAGEhLOo4dMgzA04IqO+uHAB3be
 W5zpJubG2++1WA6yYym0/yl9D3NL4JxLFB9AxrFxvKNWqXc09HCmV1jp8Imr+jucnC1yvg3qkWe
 Zsob+OQshKmjTrLVmUJK+h8jYBcGWEjaq/XfLlpkRvhUG9zZLIIBGXXLejQiPKLCavlpDwsL+fs
 nyE15ITyE7CkM6jj2mvf7LldWoqyAbZEHSyfavm5XMfSHrh/xN5tqcHq0u2Ew4YWURbv+Ctj1Sw
 ETtMIeo33Jj0u4xchzl0EfvHiTwrlODGydWbtXF7iW5JlDwbGRw6yGiNkViHx9Q4N6b8wcbO7gs
 BPaMbbhgVyh4Wctb4CQ==
X-Proofpoint-GUID: TDC0ZaEAA4cbQXwNhj8PTxSQWBq_dHJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37504-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B45DD655605

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..ca907ad73095925b234b119948f94ae81e698c86 100644
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
@@ -86,6 +89,32 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
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


