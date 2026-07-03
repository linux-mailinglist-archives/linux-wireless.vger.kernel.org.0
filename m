Return-Path: <linux-wireless+bounces-38587-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m3IGEljDR2qwewAAu9opvQ
	(envelope-from <linux-wireless+bounces-38587-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:12:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F87034C7
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:12:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Z3c7nV1P;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=YG86y5To;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38587-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38587-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF6030EBAD7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BD3D966A;
	Fri,  3 Jul 2026 13:45:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0D3D4119
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 13:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086333; cv=none; b=B34scs9S3l14Biu8oK2D2AH2BsYWeLssSOkK6qtyqM3TwDVgwfSaOpGRCsC0YPxpDkU/m/1yQoRsqLt15Rctw/Z3Pw0VLaNVZmbrnBbtZ5TbUtZqV5NJCYp3Yckj+do1WzNJQjjd4YLe9T/rz55S6KVOWygEyR/RuxN+ilc5/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086333; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0tv+Eqcw7r+2nRfA2cSNS76FlZdteTOSAOJt/bfRRktYFYNCfnRrfUEFA2BJ7XBZbP1Rvog46jpO0Vzh70Jm6SkFxaWv9yQekTOiBQBqBlY6/RLQNpofXvdED2BG1FemYqd6gkG+99E7qpLECvooqwSG/1jAOKLFmn+ql7NFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3c7nV1P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YG86y5To; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D1Bpr053996
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 13:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=Z3c7nV1PTRoHjP9Y
	N8NDqCV0gtQJFr0W6O1wUDef4OW1eTa7rUWJcI+L3YuZPAYrKIcWudhVKzTJqrJZ
	eb8HX8BJlDfPhqHG2jSC/hXQilE0PXXKmZ/EXQukwgOqzO7ShYU5tnZ9sGpb5/lD
	7nQTCQR4TcNLAguTL9DWCbTEh0LP/73+RhvONYTPVoYavquvmBeDzrHwrI6hcJqC
	GmOV22R4aAteWaxzLt8ZOebOd031WA5/81BkzbBNFt/yQnXsvV37lXp+vd7Dc9me
	M/Bixtazx6p0hww+H1DWI4pq7M76d95uIY0eGBfVH2w/mfeJPD8nzdIBx4LRNVld
	RJCFBQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkg4qt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 13:45:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e63df032bso153992285a.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086331; x=1783691131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=YG86y5To+FO2Rv/VMacw7djrQ/2lb8pPNYpBbtK4IEjIK8N3JHJ5JXQlA1eTK1SNuO
         7NQzEY58U9JJmpZcQqipAVNQKGdWr5JaOEZkfu48PKhB6xW5Sc6ICmMrITEzK0KHrZbK
         RpRpZBM/4E/gbCXt+c80sxg/yQKn9VhFc0LUWPHJKMQFo1DtINl2Wt2bL0DVj5KXMfpq
         HtwducqowYCKv+repivOuhGH//2k5c4C6ufuQzu+AD7vFmaWYbjY21xDyV7kKeKl8V/U
         uC1syAzQ9gVEbsYDBhYpf4K3hf1OiVrphM3yMaUSGBcAGxAfac0rA6xGMKMaZ3vWGVTE
         JqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086331; x=1783691131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=gEbmk0JSbFH7MJhbHj5HN6nxgDH9hng8iEExae40+2A5hA5Lme/oLW9CugxfMe39Bo
         9+cDEExyzLGAObdnF1U/4mD3f4pSh3451sVIx0cKJm+etakZVQkRawqsN/uiJW+V+JLl
         PzB75/EwoxKMbYFgO+u1j4S0H7DG8qaN31K98ujKAC0bt5GNnzqm3PeMA6IdHHZtL9Uy
         dxxI5i5RAbVbSe5tcXp7Lj9wdG7P0XLIQoptBK2qHVqiJPa3mc6T8HyTdD9Q2wuezaWx
         g7qMwX3aUzfqrwJoK+35EuP9K/bwjK2zDQhsVvcz0gM1pW441f3i6DmkDULCv+Wjxf6R
         aYMw==
X-Forwarded-Encrypted: i=1; AFNElJ8WeadVEncGW9QPjFBGAZyRPI2Qr9okaomOI5s3qaQgvKQoyqYLSJgFQXnGE65g3yVcZzdvl7A6IQ7CxvcHog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVVleWIQR1Rj0rqtlN0cDI6obA8BvIjCWvFT+DGy1N77fgYW1
	BJ4o7JQje0AGpdbtcZxTFLiInzrtEMiWaCQjwvepogcPgwQiMRSzqKiB90qqG4zzRyTaJz1qEcY
	qnt4BwkF2/PqUFMNxk6pBOJi/jjfmCSKihW7xwlgEeHKuJSN3ORZzZq9QR/25okxPWz7/MA==
X-Gm-Gg: AfdE7cn864KsuMq/u6jQ7btBlxoSx8C1VJuAj3bZ2xAOSkwu5V71radWeigQDgwm9+g
	3Tc/pdatdW0eMN1Q4RSGYKc0J0+PpEfF8M+lRr6Vd26w+o502AHzrgY9xSsE1wzWtWyxFhXyB53
	mfPjW9nlbQD2+z8VIb+JF+HiBEVtDoM1ymeuc6rfQt77yC0VyuvOPvDrimaVZn/ICQ2VX9/KURZ
	Te2hb3UqfMapLake2OV0E7cRYNxtWjA7tPDjXCAdwWMx4S0gZluT42awxD5kj9hxDHA2lnUre59
	ItPUHwvxuXuB6JFLizOlVcSQj9cbypau/9pe/0wcA5ighb+ZdPfPny9AN49PZpw3ns0ngi73Mqn
	PHVUHq2Vilg+GfkOYaRjFVqcJKKBU/dcYAqwMpfXDerDXrF5KaIxOVf+QsRW3jszQM4mbpYHWeS
	Nwk5GG8PTlqGJkb2KeOGcbZv8FAF9KbKmpM/8/Nw+IvfzC0BmKEmSyM79dkYhHAnI=
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485345885a.12.1783086330477;
        Fri, 03 Jul 2026 06:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485340685a.12.1783086329977;
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:17 +0200
Subject: [PATCH v8 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-4-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX+3EBYGZ+RNcd
 ukFJ+bveCTfSioXyg20xGyaVIc1ufLlPVnPohEaJiVYPijT24cFQ+LbYxJg2U55z00pKMmnTh/8
 s6iTL2Mb6DsuFAdZOIC7awbxSjmuoPihx1HWiN472Q0AaEiVgILc1YJeqp6Z+0HHiG2JnPT24Si
 xU+iugvUSvynvkcvgh+X73ENhfyifPwwbC9ZlhP5Kc0jY1Mdaq6EDspOOKOIlAai7ebQHAMb/nA
 uAMWsrjHi2gO8SDkUwPH1Oiwt4+EoAvq50EwwYcBmhvUL3fXn1o6cNOfwxQq6dkIgrqt2JJVcr/
 4DFUyyAarOhpu7W8AdXuB4gq6ZUUEkgAzRB+PTYwy5eyg28Xa5Iou7BCR9ohx16EYn1NVR5qfxg
 j5m7WFA9qC/Sle/PCCkLGnr6vjnfc9R6LcGr/TAI5PdezcnxuPPZ57iiR9GXrNlpQE5lVgXn1K5
 y+xHSvGYMQD7YI/1pvA==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47bcfb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: rDWWUs_w1F6_95_ZajAXwrTfEIwyAZKW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX0Fpyd71NquyG
 J5fDwQXHq6M42zUVUm2X7xVEmRCi8okBto41XX1CO7tUVfPtW47EccE3vfEaddA5LwlioWnuv9U
 U7gCjO58AsFMPgNO9b5Lqcv7dl97XL8=
X-Proofpoint-GUID: rDWWUs_w1F6_95_ZajAXwrTfEIwyAZKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38587-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 979F87034C7

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1


