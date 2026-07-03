Return-Path: <linux-wireless+bounces-38590-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l4CPDe3AR2oYewAAu9opvQ
	(envelope-from <linux-wireless+bounces-38590-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:02:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3AD70335E
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:02:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mx9N6cZC;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bLjsTZkG;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38590-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38590-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 370D6319637D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30973E557B;
	Fri,  3 Jul 2026 13:45:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C43E3D91
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 13:45:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086341; cv=none; b=beF1bd6pllci6ay4DmJ1eyauplSYh4up9RPU9/2CkAyUbT/nFyt3Omef5Y1bcJlZ7wOAqcmA0b0mzqd0mG6hxatPsdxubyNFp6hTh8egw6SSpuv+KZTphCmOqtfrQtjLJtUpn9RVk76fGAmymbARWpjjhpo3VbTWWVUuGgxZzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086341; c=relaxed/simple;
	bh=L92wgefYXvtbzOMdFEhUTkLwtCR1yYb0ZcvRRGDMuNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APwpEEK8vlZkSOSjFObEfYaYuabZhe1OxmfVuiq5GkUpTHldtHgS1FsfG26dSzGsmw3lu++pPBeZWH5PXT8ubhfYqNwsFe6+Vmj0eL5ve5i0CLSdGt2oYtWeoFlFfksnimq37S2WsMLnOn9/RH5b/tiYgoLRRmce+Zva8OFwJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mx9N6cZC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bLjsTZkG; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BPHF13135212
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 13:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=; b=mx9N6cZCjTfJfSzZ
	9gakVHWhyhkHoDOoSuJLbiWGbmKKrj3BG4vyT9i3RPwvsZinQaPETFtRLyFPy9+g
	tHYfOMQD0dMpC50r8YHvwKhtLUuz7v3Ahz2BNcI8ICN5zQFhVhHXpTfQ1/x5oFUA
	FCLodfzhAmGzhE1WJy+vQA7YldYmWFeHBvb18VM/1z42Xetg8B/fZ8fTR1STF6gO
	9g6PjI4pXr0+QxgJUNW0q6YOmJzh3OEcQABYMaY2fZ28Be0tf0OuT4H8V1RufejG
	5Aob4BYMQYEY8O6nHg1PsE0IyyTL6we8VuGNOXGZWJDtlpjFL+RCKW3NmKDE4xi2
	5MF8pw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjb40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 13:45:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e66f9e2baso59820485a.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086338; x=1783691138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=bLjsTZkGedKKvAeMiqnGFtVt2B6H45ezDVqyMkQHw/Se2sMtF+JTnum0qXY1hiTiQu
         D17nT6u2TtV+pEgd05zWqZqsOQRD3i380wLQlyz5/wQsiUYQ0eJzYa0CuklHmAinEDKS
         Kc99LitKlureDZ7baptZoZAwbJgSPmt3KXNpRY0uur4d7+lPqQQwaDmk7xa29c5vNpxS
         mgXxKoQxGmubJNzBBHZrswVdpbsFOTCfqtNXTmB9MZJ23+m64xHbPgbuKAbJ+GBxhzWM
         aI0wrOSFIDc5dlnVRk34PC/5+5/C6Krhfu1Uc6AnNu7RbPAHGiUOHLwzH5BowbK7gA9X
         zZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086338; x=1783691138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=IEXjYSNJ/nXlayJeW22lNo6yWORzuwtrKMfjWteOBYhOLPD7F8GF8Wqjk86VfkfjNR
         y2WDHcMl4eX1cxlLKHbUJjRhQmGKMkcMNuss4G2lV4YOTW4gA23NyW/QbJ8gKXkKrCYy
         hamEvNDLUeXibj35N6IOIkiYYz3tfNIXb3JsLdINbhILXK5K6S/mW4cAJxLf8y7P01GU
         ytLajm3IajHBX3NcFXGw4SZnaBhVeppwAz6E+H3hga92m1oYhMFYKwvhYyFGCL79leok
         MHEhEZPlqCq24LAJj5DmgUWsRCnUORm+PXzKfoAp+kw1l08E69XkJjpPS8KYj3znkTHt
         LwGw==
X-Forwarded-Encrypted: i=1; AFNElJ9X+IovbWx8b8CdWF6iyw2wIurfkGPTHjK5Z493sLN8kp1rRvPj/+l7g5pjyWEtIbrTIsZ319SDFDqBz32ljQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVU2siqTlflkE7rNKg4rYzyEXEVoSm3sLayQIxGFLAl65/mb3l
	+efch28enjwJmg3fLKaQAnjVciUWHpYyccimNtcpgDETMlrxeBaqOgOjPiv49TsH+A8Zmu4Fe/p
	3+v4I5aO+Uq3d5AoDbtHa+d+4LAWuV0n2cvYsh/QuTiE+AEx7YXQUo8h4/1Wfqj1AP45wqw==
X-Gm-Gg: AfdE7ckHr8SLZCHALyWgRXHZqF25F8/IKr1IAJravC1YCPBC9XPjh1Yr2bJV1LlPHNR
	7QOwiY1sQJaCTlkkETTzkiu7LxIrmWkOL4u2JI0xU7viPlHA8z4d/Xx6EPzwzT4c56b6Ffkai4a
	JVQt/RP8GAXigsb3HADVDkQRARx6C+1OY2cwk7bOsboHkqpwcQDuXUXZ2XiiKC79yzM1ifYPAZD
	28kotKOxLuqDOeCrn7Fbzj5xuuYv8z1VjjB/tbUkOINJVQ4LpnTrmXJhBvbbZsLux4w5aj0pMjk
	kKowgwEpG+ZDTKWWjIFZR18RrNjLw0TtEi1qxQss1OHOYnuXHKi9b3WVcCQhalSYfprUHwrNFKr
	FJo7ZI9emXmQ/EHCkzLfkGQoEhSWLefexL0YQrlVfoQLL5GIgfgqJR6Wx0HsUO03/rrcc1GiOKA
	lQA+QnDXJRAsbLCZAR/Wp5XcwMO/xQTJ5nIWgUhYf5sNlPtEbZLa1MLmbPiZ+izMw=
X-Received: by 2002:a05:620a:43a7:b0:92e:7068:1de6 with SMTP id af79cd13be357-92e7b43e16dmr1225937785a.56.1783086337629;
        Fri, 03 Jul 2026 06:45:37 -0700 (PDT)
X-Received: by 2002:a05:620a:43a7:b0:92e:7068:1de6 with SMTP id af79cd13be357-92e7b43e16dmr1225929785a.56.1783086337116;
        Fri, 03 Jul 2026 06:45:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:19 +0200
Subject: [PATCH v8 6/9] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-6-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 25xgRRJv8rjMzPuJ9RsV_Wudm9TR-jeo
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47bd02 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 25xgRRJv8rjMzPuJ9RsV_Wudm9TR-jeo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX6oLBLaIhdm0W
 qDkqFeKBsGIDnMSrdh6Wprc3VvXWTEpy12+XWMUwx4ZGTJM5HpTv/UAb9CXb/xEXZSRExDJH6cd
 RtsOjzNXI3OXncSWun+LzkYEDuFLuLpKvI9WIbbjr4QMxce+pfp3bedfkGBuLar5p7v00LJPTCN
 woRxz/jlGINU2nqS5+AH3xtjGa1oCFzfi3EfmujO5SP2G9xeHJevobjxRuS1btqrU4SaY6TSEgu
 JeFwbzMjBvNHM/TDcWJqT9hmyuyyibSE8NIcBDOi5Ay80sPU3fyTHvm3dFHItui0hINR3hMtBff
 5nltpCKIOVsLd3HxRiCm3d9LLST1pUeaI0K/V3suCbgUsC8HT/Ksw+pk1twFzdJzAn5m75inTUV
 lq7MckSrojNkisdUo+ZQ0rYJPjp5FGk+1+IhJHGcTkGwN7JOHY7rwNKOSWuZlZ2voYGL4kzRKF3
 cFEzbjSQKUeShEOoEGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX1ABhwAA3EvAg
 2zIhGM/BUU+CJ6oA4odkpZxM+Vp0eHhSGeaYbHsHidAh6+JOFTl/iipCFWeBROECq+6BM1vOLWN
 g7E1r9g1iZGIGYcZBwVKXIld6uAv46Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38590-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: CE3AD70335E

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 52 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 12 deletions(-)

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
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..999ca0e9258c41580823b80e0ef6db26617bc968 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN] __aligned(sizeof(u16));
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,57 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", mac);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(mac))
+		return -EINVAL;
+
+	memcpy(addr, mac, ETH_ALEN);
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
+	/* Reject unprogrammed cells that read as all-zeroes or all-ones */
+	if (len != ETH_ALEN ||
+	    !memchr_inv(eui48, 0x00, ETH_ALEN) ||
+	    !memchr_inv(eui48, 0xff, ETH_ALEN)) {
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


