Return-Path: <linux-wireless+bounces-37733-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z54lAEkILGoAKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37733-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:23:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F110679C02
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=V0ajMPkg;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MXmJpS4M;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37733-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37733-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A436F3009F0F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B23FADE8;
	Fri, 12 Jun 2026 13:21:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BA3F5BCB
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270476; cv=none; b=QEtdy6CadsoZkKq7qjmUAMDxChCyF9VdEVDHYMr9r3w6NTZfsmVBJo5wNW9VADEJPqP9nGLGyGQod21Zp2e9qqdntnfZB+4fLWBEg+2NPpVgnn+4TNv/LNNgmGx5lc1FK3EEBA2HORpNX4OlzawTvDqCgdH06zvmcILzk3FYzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270476; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNwSRvnFgoUqns/KODnb6LksYdK0cO/yuRxhwSdcMJ63zTKzE4W+xqPdJDbG/tVjcWQ5KvjwOTZVCzbuxfGeZUsZOa2xnApoKW91Z8WGNLyO23IBwCJWg2PGUgdPjJKxPIMUN3ivcUnCroS6lR3pZlG1EZNXiFDzwwEV2nqBZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0ajMPkg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXmJpS4M; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCixQX3716158
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=V0ajMPkgVJ7WbuHW
	I9TlAHw7olRDXvBREzCOJY+47G2/2sELBRvv3TzcVzlAfc9MOM4WhBUsBa7V52Ae
	TMU1y+/PAqFWntHUT453BmMdQLJQvUe5A23KHWzxScFUiGlfrzKA7bXBVVQDuLx7
	S0w0mfTBqJ2kMs0gN1NPXUtmsdVIVpUlUGvSwwaif2IlmU/y6Yym+nX+XKkq2J1Q
	CicRK2ovRrFlTN82spPVbkzbYMIIzr345jYykfUgHUHxfwrKkVvewsj3wb8tzzlA
	r/oHgyqUuGgRHHoOvIj6ATBEAMLtp2ry5rTpj7P0I4Y3ozHQkn0VvHEzqaHTDF1a
	TdbIkA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0xd3j5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:12 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c152655acfso19710137.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270472; x=1781875272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=MXmJpS4MDZ8yW2C1lySmFn4os85x0KqJs+F0EHHPa52WDcHdLSy0aLfZN/KUUJCRUr
         T0LWPlfynV4RybWXU7QtZr2eMqIMi7OIxB+FC2oqZ82gJcuiiY8Rk9jw8c8IrRYyWvGk
         Mt94tHmsIAMh5VpeQfLZzWTvZlqzHQGXY28vI7PTkF6mtEfZwBZNtmyFhQMup84ETDHS
         GzoF/XUuKem1Io10arjV7yEIDA953xOpbwbeMsA4GwsU7kWYqRI5vw7pfLzGrZjm9tJf
         xp5iWeK0DIsYeCgf4ebEZucDrDmxRPML5LGziwtv40FBGCEaSVLvsKTabKEeMGDp2D46
         zy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270472; x=1781875272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=h4hg7q12Y1XmCg5el7mgktW0FPAYP+SEnxLpFMBDSIiD//9gG7pZnNgAZcuDuqUGLd
         RdP/UdXQIQeSfI5FhLYo+/FB1WuOxl7O/Suo3xZcGQ07k2oYYWxEIAoUFe+TprmTdtTk
         ejqmFBQflzMQx4KGSn+LI8gNzNllvWo7SLfyFc3KZOFpvk104n1rEPCAgfpry24tk833
         X6jNWGgH4MvqPkWomh2V6fSBr2vwcD/15PBBoE+vGhUp3pxDxrW0SrzxSCNdMV8Vj40Q
         fuUBvkVrOSDG96YIwyGWgKTJeS92/u5ROzafmlFpZeAlKJQWoD+L8mOIxp44tKt57Uy0
         nm4A==
X-Forwarded-Encrypted: i=1; AFNElJ862FA+MLmjomsPOt89luLc/494BglNIKufzwm0QVzH2d1x0RyrqzqnRlyuKWXpcZmC3+08i3pNghg+nQvkEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCny1eza0g3gx440GkF4NrmPKyRI6xQrdYgoh39pxgpU5Chjpg
	PfB1P+e7JbiYRlBy6vyOJOQDO9VtmKU3aXuXfW7Pqt05MaewDGJDew7gUa94ClxL7p6jwIJfnfV
	U60zm2AXLi0jAKs7dPvi8u35CCetG5V5hH9Qg3VYQqfGR+5Y2BpOI+k6MH3v3KbY+v2/rrg==
X-Gm-Gg: Acq92OE4cfvx2Xr8OZdOOOqMXXLfoNmuwBkmF8R8gGkvLQvRpFL3iGGbSRqIUtHD7dG
	e82GAIH7JVW1MjBa+bfa+G5ky6G2UyNzo1muG0+oH7u2B6d8fzOiubLxHiLkCRCJexXW8/x3vgT
	5nZ6VEB6EgytKNFXu0WGb5RpLybIKHBCdqIj1NUsIxrAXQ5skep87j+IlM+WQFyLeaWX+Bnyy3n
	7TRFJ0OuD+q+6Ro9LZOsvKh+KGZamDlah6VskU7cl5DkNsmvzjh66We/xW1aLhRMotAVbmO5BET
	cPcmJxhtf8d2Vs9dxQITltSxHFmfYQ+WTHfEzp5ObNM+Q6PF845mSXdxvguO5lEIt4VwWYrQTA3
	pifhFNMTMpgS8C01uFI6rHGJs/VaLjQjMxusnKa2OUvja9OfqbGJ0bTDbA9vgetj7rR8GgfPLRf
	uPijCQ6GlPQEJPs8uZ5gcocAYGnghlVGmPYQnkVZnR6KLzzI5O0HAGqQJtl3z1/zyOJD3sdh2q
X-Received: by 2002:a05:6102:dc6:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-71e88dc1bffmr1060543137.22.1781270471612;
        Fri, 12 Jun 2026 06:21:11 -0700 (PDT)
X-Received: by 2002:a05:6102:dc6:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-71e88dc1bffmr1060437137.22.1781270470888;
        Fri, 12 Jun 2026 06:21:10 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:10 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:56 +0200
Subject: [PATCH v5 4/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-4-95e0b30fff90@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: pdup8maqol--UYMKVE_MLPJ6lBd97NBj
X-Proofpoint-GUID: pdup8maqol--UYMKVE_MLPJ6lBd97NBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXyOv/psEUoZGi
 3tImAKZjxKZnfaaMQTfyGDcrIivSq9IQd2Oy8PCz8QYV1hM/DUW1j6rti/5aa6nIJyJiLUectk+
 0nBayXtP7fqW89RQBLOJU4jZ9Qfv8Ka9w87wN92vkBP1jwDFGREk9LKNcwYwDl30v5zQCwk4k/T
 8HECCDw2qJvrPmE6MSNymecpRd/uUPzyt/sHKikcX9WYxhj507UwP/p4gTPZKC9SJN74e82Wyrg
 vUN7FOgk4rv2kwHZD0dGF3UOsGif+drV6BPEfhjmj3VsDUtRbjF6Ql8Ub7HHg572joswXP03Te5
 3bxhupYqFco26/XWWO/qFsT15BYd54E20KX1wDtdQUMOuuZLhz8JVPfcsqWPoewVm46Gwp73Tyg
 R7yhzWa4R0JuqRF7lMxYBKyxDA9Mx5NR610g27uYNTHZcK+PGgm5zkIjlZFZKUPPXvIq55me823
 3T9fQ4K9GGKsgttIelQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXySeWh54DCAWn
 +zCp6nyjdtI0hmjQCZpkt03OfOkIESUT3YlJVHwDlqThj75OGGEOHPSkCUDRm8qkdmnYs14qn6s
 Um/NpP1pCLkvuzgFiofP6A2/8f/5U7Q=
X-Authority-Analysis: v=2.4 cv=O6UJeh9W c=1 sm=1 tr=0 ts=6a2c07c8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122
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
	TAGGED_FROM(0.00)[bounces-37733-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
X-Rspamd-Queue-Id: 3F110679C02

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


