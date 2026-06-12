Return-Path: <linux-wireless+bounces-37731-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9bk0GbgILGooKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37731-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:25:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC469679C52
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:25:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ewQgfnCL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=P9Xl72Qz;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37731-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37731-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80705324AD58
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672D3F44E9;
	Fri, 12 Jun 2026 13:21:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8D3F4107
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270469; cv=none; b=dcAQQykM1QQet6pE+joHUZOSEEchE/uaojvH0eU5xNaKUWIwew7iTa9hTT508hud5tZVTEMw0Owd7X0yLJfUB4FeG/7wJsgnxO0ilsBo5ZZr5z00BE94OKTzrNQTb9BrDuRv5vtxugIyMMb1OOc0E/dlm9iDHm140dftz0WNjUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270469; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qi9D/Q5IQ0MnRGjpkIh9Z8RlDfGuJebWvQNJAuvfvH7gF6uMmlXQ5i44qxHnZ/jy71QkwbcSAro5/8R+HkXCKCwjmESCArAUJ76GAqdxmvdhd5SBNQ3bRbQG70nkrynfD95jGIZShpYfR2u9UEstSmTWthZMkNKEMYyCTHFUCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ewQgfnCL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P9Xl72Qz; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCj4Sd3714719
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=ewQgfnCLI68ej6Qo
	9OvW3Hi1cjrVzZolpkfEcfXgnbQl6gVVUQe/0Yp0LuwgvD0Qsc5IdUDcrmpsOF7V
	Z/vHzjH/RTaUpBynaPr3gFnmOdDpnUNPNDzQPhYR+o99ADjRTwBodu9jeRTtmWvz
	te2fZaZFzkN4i1pVF6a9pk9+tSgxqW+YMd+WkNoL7CrS0KCHdRVFHbfvKF7kvEZi
	wgOgDbXctH61qgfVv8uE9WrR9AZtA6dq0Dc9JuSq3QgoIBeREWczdf+29NpOtvH/
	dZPxZfyuZezJJmJ7EZ7SwhXPEK3ThzjcIIOlzKvyJhxy9QkoLOOJ1VYlLWUX/Yrz
	NCLHdQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7kgu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:06 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69e35fef6bdso739426eaf.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270466; x=1781875266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=P9Xl72QzhYLQXH/GBjYt6pTxXaZxUAwgL5u7OR3qDUVugoEEJtZftcymlbbYBGp/cE
         po5pwnoP9UU3t/Pq2SD679RUS5fifmLbihW06h7c72WZF1vKC04YXaQzNuB0oQkb1ReP
         y/AE8ZKaEYUx7Ns/ZAg67tHRAsP1BpN8c148s1F4iQC4rlNInUuYRQfjTSezvaKy2UqC
         k3j/kgDoAgcxhKLAJ4XVdlO51caiRh/AfVz4+P3PGenuM0/3Iv9+BTRB23XIq9X0m9TN
         vj3U1Y5//t8nGLTuTTx2yeQLLX3HOwteqBpKqkJOKFPOvlUoWZEPQb14J46uXbnZM8AE
         Thhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270466; x=1781875266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=ToUa/s5hzA6j+GPzYSQdR2ssrllI3W+0sRAOcyoQampMvukdnyoxP+YJGdQ8281z56
         OaSthr/AUz4slT1wdxhS+Y6gQIOjGX+hWiaYkHt2qt1aqkEkEIdo4rwUlti7KaMkxdMw
         Zdjk2NQ9qCynauWB9kcyGGNpGH7jzO1KKHURm5+cFi508+UZp0OdAYLFSeg1wcrSg1K2
         vCyEAWtF/3+Lr9h1G/ILnoasct7Ib9v/w9hdb1Tc0gELpum64bbRZ4RRAxNIc1qqmPtH
         NY1DbmR2r3pzzXwFZkkyYiGIPXVeqE9Fiq4Fw2yYt5zvWSMTBZ6Af3IwRuemltFOTkm/
         TVVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yPi2uufbh1naLjFXi3fKE+H3ZHzYZHsT7JTczqgPiWnnUD6rdFfuHux/1bnq4+kU9LxQHNpYoEkjWy0m4Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOitlK5pZuU37JW95vOECLSh4VkyHzZXeBgOIf2vfCQ7G/J+I
	zyYEVHlKTj9KdX1vxv1SOSjW1YOzQ1Y1ynpqk/QRTkFIxCpylXj3Smp8kHFtoZoeK3vGss5u4eX
	kyzVp7g6508KB3KqOlepqWberwNMe1pKGlAncUxsCLYEAqtbQeXswLZ87EMsXIxkJKUD6Kw==
X-Gm-Gg: Acq92OFWYP6SeYtG3Ye+/mj+30Us5Ug0mzQm91hpxCa4LMTi9tjzAntGfV7LrVDdeF+
	BTTJLxVU9YG0RGQjQgkQXNbmfqd7IXKVpiZx1+iWGO7UhafuNIZR2gb6vs74dq7Cz5LTdzpFMIB
	PF/gmsVCl0yBtRtw6LPH2wRh02gNLMLcMtJFoqG8i85pzSpQV0xtx1SZHhFWfYDGArPnTc85LhW
	tNmKaPxuVfr0/gX0M02GbpSgJScsTKiWTEQPVcNZpnYysBQJp25TDLA5YRd2OEs9M8W8k6rhRE+
	J4KbSO9bUzLN/eTSQd/P2xACCwfyHjRLgZykuautETyOFQ1d04S566jQ3dK8VV3wVOb3UkNHWv4
	Mhu07uDYVFjVHf2bpjEn0GaT0iPs2QT7jzfvmJONp/VcnYjNaWj69c4KcRYMFYeSICduFeoyPCa
	WwPTBaqxLzznepoC8+cSoSzOhfsYiQxnXny7Nczp4unwcAL+Ou4qegNUr9IRr6wDI2vyCxXyxE
X-Received: by 2002:a05:6820:6ac5:b0:69b:196a:de67 with SMTP id 006d021491bc7-69edc38e930mr1694308eaf.0.1781270466074;
        Fri, 12 Jun 2026 06:21:06 -0700 (PDT)
X-Received: by 2002:a05:6820:6ac5:b0:69b:196a:de67 with SMTP id 006d021491bc7-69edc38e930mr1694292eaf.0.1781270465641;
        Fri, 12 Jun 2026 06:21:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:54 +0200
Subject: [PATCH v5 2/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-2-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: xxKvvW5xyaHGSmrPCREsUh7xmVxMRkMJ
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2c07c2 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX05XXpn4UzRaP
 RHEAd4fwVVHqU//9wBqnsEJlhjwc+RB/M6sesOBcH963D/8gVoP3sOt5IZn+Dc3I2M/TwWJDxIY
 NTldZjof5pH9ENEaXfolxzoA2SlJRxSHJUIzJLrMtlwgLyxNXNqTEudXlRcZ0bRDjWecatv4WKv
 VxTrSqwbxu2UmSBvZ+82390TzuensbA/wxk5xLcrXI2YnK7xq0r7WZZX1VUsJ4/TFdMWJibUcCw
 fNjmZxJZ7WBkyHKh6/uZ+zOz0FxAV3r431VdOxEQgwFb9a0zSmyWivgbyMLrX99b+W6UhWg+OdM
 e3mE2kPYnKxFAi/UUVohcNg5ziIiHAu958w2YqlWBjCHGmRW+0TTe2hGes4eDEqQ2OSnY9hISah
 TK2SZ7ZUDEnaL6zNnjRXJvlsiIaZuuf8rPTPvn2GwoN3xy76gDygk1k3LFg23xbzoEZD+pVDU/2
 quMfA5t1WEbdaD6jODw==
X-Proofpoint-ORIG-GUID: xxKvvW5xyaHGSmrPCREsUh7xmVxMRkMJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX37QiM7dkp9dh
 YuWfxgvs0Dcg37X+8Ltp9eXQRX5+8XVnKtsiQWiDi+p9twsgjv6vnK9zjPHpU9pBiEw+lHkOJim
 HDDCvIXo9izw4yN/I0oeXstqUmNT5Ao=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37731-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: CC469679C52

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


