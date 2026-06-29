Return-Path: <linux-wireless+bounces-38281-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gXQfJAA1QmpU1wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38281-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:04:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCAD6D7D73
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=lfDvGzah;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=WyrvYIAU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38281-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38281-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C0B13035245
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF73FADFC;
	Mon, 29 Jun 2026 08:55:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830A3F99E9
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723352; cv=none; b=phpBURKXcl4DtW4qeTIaxmNWZ9VnWveaKvj/Z3nnU+D3gZr3emIVAFS/UZST97vqC/6dEStQ030X2Hde2Ulm4gLO9tOZ1X5nosyfRSpD1blllacg0gzOU2w8ipAUeK8Rceq3j9bGxctQP6+k0ondXFVqjN+c9aU1KH4s5wkXxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723352; c=relaxed/simple;
	bh=DhpKvk+qKi33tdqHXBdyBn+qHlFJWo7f2LRbmA/QYF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWYhdUnrUQt/XoeteCUqD7suf5dnYJfcSxScgrbyKQ4GT/qmkQJ2bc3pEp4u6xviO4iPMw6iivZOCtdPojX54OOjhWwXgcRcj8UBtBFmknckICZjK5+jp2F5oujpuqH3S1rmwcAwVmFVFvGtSojF4vacQFqgWNavhhMBemifbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfDvGzah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WyrvYIAU; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7Dnwp2188700
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=; b=lfDvGzahDOgYX5Ff
	CC0oUo4cAzW/QEmUxZrtk2fhPOP2lXAP9AD1ydUq3wZVe+kIJvPZd4keEeW7Srm+
	xAtIIasA4rAn7fdL0ErRC8xPfgZtQYiZJDgf/mPwog9Z+uvH8YmCjFRXUGdmE2nf
	J66c2Rgkld707x/0ZdocfsHcX+bKh5RAqrgSdkCLI/R0zAJ/BsaDGUxfB0V6NEjU
	he9RfcUkfK135U9WYtfobF8EAynA2buZdpGfW5vEHy3Elfoxp32GP9Hk6yGonbv4
	sfooxxl5Do+mhZNh3Kj1QFPfl6ZzZMRPG7DkQ98SxWQgp2nY4PoSfnD/P3rpAoxR
	wmzfUQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trdks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bbd4255f46so639737e0c.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723347; x=1783328147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=WyrvYIAU+ZqJPtr/1psR3gvEHv8Mm/dD31TxPdeSphY3+5OvpW/CbfqGtrAsVB8x/g
         TPNycD//BJ2YmmDcAw9GEvS66tqBJaJruWP+zZS/t1OegE3jAtSy0XURPsdtBx3YpwEn
         +fyv3MVJdvbnZ9BpqfeqSG8gmNrJBY7iAevEaAOkYHVxeOhkeii+E1LRWay+3Ya40SA5
         0nQU0jOi8rEqOXdTSMpTM4bWwiVgnd+zpI236Ml10r4/IAjyG2dRQm5Pgy/t9V/FCS8o
         jvtwwJcnuBPMlnseljZ+1FN2PxTR1BSXAZ3Z7hUlretUduSuexvwjApCpqcRpwxlfvg6
         PAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723347; x=1783328147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=nmFUp6p5fUq5/LJWjm0YQ7+5Rov83VAer0+FQx5bbbtzaLhp79uQCIWD/9vjRO56Cs
         xw9c2sv5Mx338XpYZf0/OPU0bztiPyD9GlU+0AOP3pSqaF8WLiuWQuTk8NgC4sEMUmGP
         xNKC8sLb94/ahhvXXfjluZdz9hdAd+PfhuA/3omZGfIkcZPJocH0IwpZxQVi765MysBz
         ndKhKz/cZtfz0Cj/uYmAl1cmDHshMggqYOCam9JhxnWC+GhNoaDrKm7quIcZy4KDTm3d
         WtihN9XXXcs9fZ5nc5/ujH7s3s3sQecSNeRZIU0+ZEUuVMml8HPih2Y+vH0HCLtPTvKU
         /veQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrezv2dc7f4BrPgB8RG8tXvYxiK01fA91ZcJLusZjzRnKmGMd+Xr69o4A5WseFjEuw0M0vpkZ6jdMBBN/wOcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4s3Vt0kq3Z1kF2qp/BTcbJlRu6Vc+H8kbut8d0UDJxQU8H2ES
	xvjYSZzOL/vnPeenvMvzB210PBzpHCKytIXGlpCmB5pdoN8GnIAcZ8bSDOl7GM78OGTYa++ndqM
	kqhSQjt0EAYVlYtkBLd3sDtDccxUKSx00jU6JLKR2bpR/zqoaKDtfBznd2rbqNxse0dRKgw==
X-Gm-Gg: AfdE7cmFrMOEVx7+l0eZUkFssaI4XpK8r08ufXRrO55pBTGYx8JS5eKXbx7DLJibah9
	UpHsTiqwxl5Y1QB3ZDQ2wgM3w+WkQ8ahnlh+NcMlAEUSkmzFM4gG0brtElSx3igeF2sya/x6rPT
	8WhLQ3GEWjJjDR3leg6mxHIuFjciLagCKGBBMEURhcLoap9A3KNb5+gyBYHU/zUiV07Q49sACAt
	wC/Uuft6V71B0IjII8aWUzNwZUTW6t+59f8MyVS6JcsYQ+Dzb32ioq7mBXTTykfC6KXxFZMHjfz
	9zJhHhWxnamb/6sDfjipDYsm06hfjl+r7Bs57GFOgMBjTqVCtwYjtN69EqJAwY0xM2XJhabPZNP
	6SaUBGfAo+F0iuI3ny+BoPwmns1Ls5th5CUUquBNcK8D8pupEp+a5ljBMbs1BCvXCfxARwgwD+7
	6QVDp4cu8mcIlfaxwAj8x7c/nC/dMJKdX4zhtP2WQSR3Tk96LT2fRj9RcgOHHy8YEZ9NEYpc4AV
	diD0kU2PwFLFoJJ/8eZ
X-Received: by 2002:a05:6122:f05:b0:5bd:9f23:a74b with SMTP id 71dfb90a1353d-5bd9f23abbbmr1750193e0c.9.1782723347123;
        Mon, 29 Jun 2026 01:55:47 -0700 (PDT)
X-Received: by 2002:a05:6122:f05:b0:5bd:9f23:a74b with SMTP id 71dfb90a1353d-5bd9f23abbbmr1750189e0c.9.1782723346638;
        Mon, 29 Jun 2026 01:55:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:26 +0200
Subject: [PATCH v6 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-7-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX7pIEmnDm4yme
 03lX5LgzsqN27SbCprJqvkBdO4X7AckxAdhu9FmpsimseK7iNInXrv0Ahjo4QhjdMaHdvh49sE4
 yFsR/9UHfKNDsfjpB1I+oHb3MR5fRDI2mDt0ucjC1dvVuccncDOertt5vdusWzjjIPvWBHtAq14
 ooL0pc52811O082/0hAvmTcM1S4oprbwwerXN6Xt18TFaAAmL6jWMWqW4lOfIlYpcVs6REQ82X+
 ksSTPWC3ulcYofDTaziGLkmqkVTPKsucKl4kUZsZPtyP5v2minBsNbyehohGpt+frKxljBYB4sl
 M/tRs5r+dod3SoOQNvK/Orn++Bfo2g9fLF/9YPuRSCq6S2Qd5DiAj843PSUjh2kRAsIu+OPoqao
 5Zd66AM6WphwPAjPu6CKTXhdY5aA6SRgKSAbJao2dB5FavjwTRIZPJQanZdhChITcucN/JLRUUu
 ebkmeIUuWrri2AVKgfw==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a423314 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX1NVOYF4fnNFv
 KVWuKO8HaqxAkttr7DaSiDqL6mb0dNX76TM/xDUHOXCMdiI7WWgOG21qMWyxLLgv7YO7MUOcvI8
 Fv+mL6bFK1Bi/g6B1Zvo50aVrxB+DVQ=
X-Proofpoint-ORIG-GUID: VrFwfbDBpfhyRlrrPhbruqycCnB37l_w
X-Proofpoint-GUID: VrFwfbDBpfhyRlrrPhbruqycCnB37l_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071
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
	TAGGED_FROM(0.00)[bounces-38281-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: EFCAD6D7D73

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..589ccdfa26c1281d6eb979370523fff0d7920302 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,37 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5074,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);

-- 
2.34.1


