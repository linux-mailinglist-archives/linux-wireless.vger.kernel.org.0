Return-Path: <linux-wireless+bounces-38280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jvs6BfY0QmpR1wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:03:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69D6D7D66
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:03:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Qnlt2Mnx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=IEZ47822;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38280-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38280-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04063031039
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696643F8898;
	Mon, 29 Jun 2026 08:55:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE03F8882
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723348; cv=none; b=TibyGxLq75jrHilG41O7jGrPE4M0f8TnGMppGG7Ov5hbL6lY2gp2t3sEbZ8blU/geRg61khD8+H5apaXVTVjTM1XTWGyBnxxOJApLEjRvv523HJHQ0zt8YCdLx1AdDAbZQamjbTIjoGIR0AYdwPsnQKVvzj6H9TVlwtAa5oJvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723348; c=relaxed/simple;
	bh=6b0Jqnu0CGr/aHLEgYJK9A+WdSx4puE7YgV7L+bka1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYyyhFJSnezn+zt1ioSV/guAbczDklqlGiaIHvSTKvE1xP5CDz/VLzNQ5LNymywuS54nXqDmHBI7qdFgInqF798DpDtWZ7E7R/uFjqcrGKirOwxSWTljjQWaoIIfgCTG47bOTih1iTh1Zg4AootH3yd1FYbxJXGoIQjw3MOEPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qnlt2Mnx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEZ47822; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rI0i2097155
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=; b=Qnlt2MnxJR4rdAYN
	d+Ia4snWxrKPjUuSfEHA/c3vFeaUCLaJMMFwzHEPUvufZIirCkLTWZOR+Jcp7HAN
	S478oMv16icAgozsNwGSbvqAF27wTya3Rm6xtcxK8v7rs5TapvdzRP2p5mvSv852
	/vX4LGRHUqE85OxsMRUNzG5hmeGLiIfk7+RColCxhDRryqDCtENTBn4A1hzRSzA9
	rYKGlQKvFV1fZyF35Lc+hM6lexwkPwFQPyUroMV3mZwtri7AakkaPGbGrP4olV7l
	EQEr5lM1kMnQsYDYb/pylqZ8F+VNBADwUa8SuuSdrHA3FP/WSuJ+3d1nQOCp4fwO
	W0hwwA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7wfdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:45 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-969289fca9dso671334241.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723344; x=1783328144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=;
        b=IEZ47822Hu4poQSZK1FaPyQdJZvdGssGqpqL/hyJWlzPCl8owtJMC8j6MTp8AWQSf4
         5EUQ3m4v6VIFcVNE7niy0riPy7wRanY23euPqwf5YhTLVvU8xeib7iMADjjq7idV2tgs
         9I0RBmGAi9Ogw2a6axo4FIh7Bxkc5Fw1a5SqbmzrIinK6Y3+Q/DsIUM8Nd/nzy3LkdBb
         oQglSgPicND1YYu5Hk6w2gJujM9dzxkgDkaT6Q7rQeQn0OFKx/dCqx9S04xciCSurv66
         QibqOMa9zOx3bxcJnzSWu9dOarXbWWl9VjLraUgCjsSB4ZQTCfm8/2FDUGZHj3tv6lb8
         kbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723344; x=1783328144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=;
        b=j25ZcFP++ydimVHxFd00XvUg4M6fuOXbdup60UKmb3cQd53WjF3rnE7n6m6MdciHJw
         XHTGP7Ltywq9qqFjGRh130BrUz3mcP1MesH5v+NgfvjYd0BFgMr/SxiW2e7sAg/7TpsP
         XHiMo0GiTj3xpUcaMUdGoP2EFqq15Wg6Wmx0acoYww5fk/4cje6FdM9P4/w+kqEzoXJw
         TFGDgKpa5r6/Jv0q+2njqMmlRmRbyVh1iMPY9ZbYRbr9AA+FzQ7gQcbSfCdFfT2TMA6a
         uL+6B6xcPtXegyypPz6h9bv6M1NpFvSBtwnq3k7KxodY67SQpwq1VGlLeQT+n5oBcHCF
         F7cw==
X-Forwarded-Encrypted: i=1; AHgh+RoBbfzqvr0QUHjSI7HjTlybzt3lL4gxw0h4RPaCe8RyZLiuoBxlLSFhyCI7LTM5X7Il23fSPfxAyiSW3SynPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5Zd0CnuLgExPLRru/ECymaJjNvfXNypz7pdbzj1uJV8KaJV8
	IjooeG3vP8qumVY67W7iaMLMfen3YvfsJ5NjVPJTIJXbafWQtFwp8XSMnbfu5NQnl+SVOsmWV6s
	o+hCsQljV3Xgt7WthUBxoLY7cl6rWklBc4Su2/NqzvihGH5f3PNSzZWPTsAKL+7G4s5dNDg==
X-Gm-Gg: AfdE7ckU9bp4vK1w0jnPbT/2TDqRK2edrj9S6ay2DNrxPSxC1TME112s44bdlsr5ypn
	n34maD/SjycxnWRDzm91M3s0WaIYVxKktiWBvT31FXMqIfNdeDxf5VoupcUhVHqvfuRRbGOT82D
	MPGNDPcKs5Zj2u8KggTmAOk1EhIaUWY1NwY4dZY0sKGCkUX3iHvtl4x4I47BO7tcAJz+eDviO8A
	TKvshHVcZbF9nyar00cbfdLrUDa30PKpQO+ru/lhgdLVq9/2yGC5p4HM7hjOxDxv2OcJd8Jjrfk
	Ee/xoHrOkEKo4c0ks6dCT6Ctd2vcnSmM+JZ1Tj8TjMbEm5mpLHv8Y6Mq9EvD+pXK0+F3LeL2sKx
	O38+FTrp5wSN3xtwIPnVuMUnYmPN+kN4k4JuEC2Ig9FRwUzzmFFVz7w/6zkiFPlynf860ORTkF5
	0kFgjGAhTMXQ+f1rjJ/3V06viFAH/FFBd/Af/wXf1Y5zjAvoABxDxk92aU3ArX5kS2hjc5jJ1zS
	TZxyrbXMnI9TEH0cBs0
X-Received: by 2002:a05:6122:6b1c:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5bd71b1d988mr5371481e0c.4.1782723344124;
        Mon, 29 Jun 2026 01:55:44 -0700 (PDT)
X-Received: by 2002:a05:6122:6b1c:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5bd71b1d988mr5371442e0c.4.1782723343668;
        Mon, 29 Jun 2026 01:55:43 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:40 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:25 +0200
Subject: [PATCH v6 6/9] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-6-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX8UDgODlVn5zd
 C04jzKGwnwNBzGFcQ7x5fs52mWaV9Qz/i+7xztOATdLySzGyT2/37DBi/gjQmCk1d9uhkXIDChK
 vfnSjkFS092+PrB386RZocRERvuCTVeRSgaQ7+F3iKbrCnEVswjxnipzs0ZMeZrAdifO3ylUV+K
 r4ELeF5R2I8+HyeLdtzFBifp/gkMIT1OFvbEDFUPfG3GjPUfDcz3lhHEzGB6vvVDDUCRoJRX8+2
 oZE6skB/3+vKwILpY4j354vqnyMFzY3S8aHacpFkCy9+4yL64b90N10F+Q7YjFxvrb6eJfqljVx
 m+PiNKzNeyzauEr7IHyrP4d9oS757kUNL/LnFWY/YEYL/ErPpTFQSWj9SO97EqeYNBadUnCFGv+
 4Mk6n13khJkNc2izUigshcGJCrp1aeqTDXPtFSgPbAkEEc5zQ+qz0h8y/ORwKVIetNvWgYkvYtQ
 0L4Za1JJdqGCuZZqobg==
X-Proofpoint-GUID: XEoc0OGq2kCSd1DMW7Qe61hyaS7Sv2Nl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXw+GCysjcyNUc
 6Fs++6ElOSoudDNrzYEtv/BEHVIW8X91/ujPlB3WH5+r6xON8dy22uOzGKDPJVp7IpWHDpx1JWg
 G6ir7bIzHM8HruhfXOEzk3D6HRj5urM=
X-Proofpoint-ORIG-GUID: XEoc0OGq2kCSd1DMW7Qe61hyaS7Sv2Nl
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a423311 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071
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
	TAGGED_FROM(0.00)[bounces-38280-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: 5A69D6D7D66

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
 net/core/of_net.c      | 49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 12 deletions(-)

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
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..11c1acca151266ac9287457b4050a54b08e2b5f5 100644
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
@@ -75,27 +73,54 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
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
+	ether_addr_copy(addr, mac);
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
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
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


