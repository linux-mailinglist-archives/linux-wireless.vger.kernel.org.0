Return-Path: <linux-wireless+bounces-37729-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DzMNDvsILGo1KAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37729-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:26:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD006679C79
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:26:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oaJQapJL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dJk7jie0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37729-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37729-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3294F3026A9B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6933ED5DE;
	Fri, 12 Jun 2026 13:21:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF033ED3C1
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270462; cv=none; b=mJRvdIJ33AgNQuRSUSWcSq9u29VmhrAzcb6s4sGbQKxgOgQLJXXpyFNdMTrI2bWTuR/CtKXuTlVBcHH29NxgYHtfFGhRXWny0yYtmQS0epx4EWPCnC9l4lDzTXp6N66N3w0z20G1J/ly5HZXLogwwDrAKxx7X1JF0a5lQ1lsPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270462; c=relaxed/simple;
	bh=GA2hcEO9oG1ygBpxn2AFU64V+84wXeyP6S4shCbyzro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NzCglyNg57oGkrFdqBDBwC8TSwGPchuLubcrRJSHW0I4OUfBnMPeAxed85/uDECW1oJhdyT7GrnzO8oaew3WLh9SdxHP4ddO9xrC7yvVn5AS6jwCj2syl6d1qkNZgU9ELl1+mBjUMs+IcbDtPcPXkmZf6o4OHg0ekSu8q0FhT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oaJQapJL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dJk7jie0; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCijCc3747567
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N1CimfNGzeKqFKCWpq+lvs
	mNvHBjXLnVmVAB9wSi3oU=; b=oaJQapJLrzpwrAd1P0fqL/Enj+7GGiLmyyIkgE
	IpUoFqTTWP10vsWx/Xg1UOSE4POfkZYqAILg19xsc1JQHg08RGu0ckRWYak2OUMb
	nXwBOKdplLb8F/C7uPC7wofZZy3UwQprLAjDKUasFbS/qoo8VarphtlqwUrI2EWH
	pWOEBWoBfttfxYnl5pXNq7Bu49adNtN9J1QN5d7OhmM/jBmm+cMRQQGaMGP2OkbG
	1/WZp/f4Sf4GUJSB74sJnvoEAYS5Ln5sN+dUd+rZJhuJQeM6uqszs8vy1BTN8xvF
	mH7zIP2wlG4foxVhYPJ5lWR1nWv9+lx2FO8eN0CiR9UgHj9Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ehy6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:20:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6cf9627010bso961522137.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270459; x=1781875259; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1CimfNGzeKqFKCWpq+lvsmNvHBjXLnVmVAB9wSi3oU=;
        b=dJk7jie0ALcDuhuKmQRiZ8I8FdfOfQSIjY168uPfedE2WH7WAr1LVBMgNfjnehE+73
         SLNau3j0jcK77CBa2wJJ3VWyBlgK8y/a0QP1PecuK5Wm97duRo5O8+mlA5W4OIcEk76p
         Urxf3rPngq8wcGSvc5hnJRf79qPfC+dDPPcaUdgBktg/FfYMRAG47gA7Es/nSEo03+xN
         dnRewhXzwMGFBuiZMEiRZl74tmD2HZtItmJTG1/wCg//sNqBsJjAWGFfj25xig21D0f6
         epHCcnlooml8eMqdxkhiz4Fouf/lIxBibfTDAMDw72XR6ixipaMriovaAn8J7dZPQJzR
         J+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270459; x=1781875259;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1CimfNGzeKqFKCWpq+lvsmNvHBjXLnVmVAB9wSi3oU=;
        b=p4KjQRECqPKPNzc6hk9vjSeQYqScHmab+VSfsEqlbhKjxU1B2r2aMPXTHbdRlCWrQp
         rHAa01tZdnSsFeXXCyVEsxDWDRHZfpkbDojCSYxawz91cKWUzJ7zd6PU03o8Fg4QNFun
         TvKWlAby4nXhYwC4iPfSOcmE5OEJCjjKhOFclyBiu15cjEb+4kBK2wDMAoCZhtWDzosi
         zagx1kaxo29/0siTk6bpEFSUS21+cBlicBS05djWy8fcRBu7qQPny4VAWnyUN0NfUT/m
         sh5iBm4VeY3UTc/gH0zUFZx7/QZALT7vdEXb1CHWQFSOwMjKlRXwtMxugMH2IfXMsHYQ
         +TaA==
X-Forwarded-Encrypted: i=1; AFNElJ+3TcONS4mNbMV4+Er2/DILtDQnUF4SSgG0b20zFarhlYGI6uAYU+v8fPFRugK4v5weiNUuSTRVztbsfrgD+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgDZTyvpeLzRXCLAGUK4a4oB51esFSbCj4Y7EMlClqMMR+mfU
	Fq12nbrFtc1Pk/8FlcPumeuOljU7Sx3rw+itz0q2PKKTsmnoyMoc5ldIpxKNKcE2ABuhgvgmxPx
	kE4UrQspvMgAoRVFprlOS6zhGNV1oCfzJ4E5q6cLWJU/Tgvfv8/Ss1qBX7S0vb/UPqohPoQ==
X-Gm-Gg: Acq92OE2jeGtHQRHeMsiPgeOrNqqptT7S7VrKU6nOv3blV7p0NKTgP+/x4SBJ0U7Q84
	PUgSnTjQC89SMl53VTXJFueRCTa/nvap0YHgRZJwSqfkYg4sQYhtMoER7LIDxddb9iviT08ES+l
	96R4yqQpSU1Ly104ETd1+hmohZBeCEPlyUpK0/DCRL1lnmXwV1w0BTtavV4D5uo8E/kQK9K7pZA
	B6qxWsD57APbutuUtslG/n2i1dBmzLJvTQiazWm62628ngVb9qqPplHZ9hV49kcS7cEurqC0TPy
	xPeFZyZFn8xpmbUNhIVqWuVitqZjbIHv6JUCJrj3BwjjMAc7PvGCyuaa2sBVSXcoLOxPeuEXoq7
	gwRMjKT8DJ13yO8fBbjWtaHOiLia6U2egARijDVqF2Wjs+Yy/OYiBNlPt8BhmZ7tdm8v2Bm+6i3
	+OPhCdHWcWKY8cxYN0xZGrRJ/sjj7mdVSvlEg2YUt9KngktVEqGXsERpyqBhqV8pMSVDM+gNU1
X-Received: by 2002:a05:6102:580c:b0:6ef:dc8c:9367 with SMTP id ada2fe7eead31-71e88adcb08mr1374091137.5.1781270458878;
        Fri, 12 Jun 2026 06:20:58 -0700 (PDT)
X-Received: by 2002:a05:6102:580c:b0:6ef:dc8c:9367 with SMTP id ada2fe7eead31-71e88adcb08mr1374007137.5.1781270458425;
        Fri, 12 Jun 2026 06:20:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:20:57 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v5 0/9] Support for block device NVMEM providers
Date: Fri, 12 Jun 2026 15:20:52 +0200
Message-Id: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUHLGoC/3XOzW7CMAzA8VdBOS8ocT6actp7IA5O40I02rAGo
 k2o777AhUmlF0t/S/7Jd5ZpipTZbnNnE5WYYxprmI8N6044HonHUJuBACs0OO7PqfvimPlYBhq
 49ko4cj5gi6weXSbq488T3B9qn2K+pun36Rf52K5SRXLBLQZQ1BjZCvxMOW+/b3ju0jBs62APs
 cBLMaJZKFAV38uGQjBSaVpR1EuxYvmLqooD62RvBKIyK4r+r7QLRVdFm0YCWQ/Q2TfKPM9/L61
 ZOoUBAAA=
X-Change-ID: 20260428-block-as-nvmem-4b308e8bda9a
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c07bb cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=H1RoBJpM21yDxn_SvroA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: OnVQlQHN_uER4p3WPQqy57R4pFvzCrdr
X-Proofpoint-GUID: OnVQlQHN_uER4p3WPQqy57R4pFvzCrdr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX+N0AmXw5L6/0
 jwLUwvsau8CCrVXN4yzo2n+2aW/UPiwO6KfEGoT5KUvzTLnkLURt8KV36ZWYp15Y2thaJGOWB1D
 uBZDQBSWhxPq71nGtNDX1LPt9/COHxK6vyd2SOE0a5U4Kjv/3Kzk23CQJ9wI4F92yD/zcrjzqI1
 atzxeWeRvInvpvpRAHLWg9e65wvf6STdUvKEqyRda367eWP0nXoZHKv+bLfjeOIOL175dPvWaiU
 CTZREmb/9l+sB0Y/Q8zc6kYz1en8Zcs4jFdJLq8n0FlGB0moeEKHTf0DPrXnCrXqJrtGaXk5cc/
 HB8tMg6FdtAv/eEgdKx2uzC6HO25ac79FPfJPHyYCVGiWXlciEl8KnZ+XzgRSTQl8pXqdlh5SVh
 x2MU2gFck9OTLvlzGc/svtSn2U0xfwI7ZYI6MISmz8W1P1Mn8FbtvmnHJwZziyUK8zNp2s720wq
 7KbDrRoBR2q/2lfEaDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXx9n/ahV4pxRq
 lzmkPBzI6rVUGffM/AvNgq3x3vPqpeE5q5C0HxQAJtcU+Sydhw2OrWvYzjwn0udVlJz+HuI+zLR
 c7uD2Afenfdn5RioXVPDdZhhu/xx+Vo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120122
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
	TAGGED_FROM(0.00)[bounces-37729-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.or
 g,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: BD006679C79

On embedded devices, it is common for factory provisioning to store
device-specific information, such as Ethernet or WiFi MAC addresses,
in a dedicated area of an eMMC partition. This avoids the need for
and additional EEPROM/OTP and leverages the persistence of eMMC.

One example is the Arduino UNO-Q, where the WiFi MAC address and the
Bluetooth Device address are stored in the eMMC Boot1 partition.

Until now, accessing this information required a custom bootloader
to read the data and inject it into the Device Tree before handing
control over to the kernel. This approach is fragile and leads to
device-specific workarounds.

Rather than adding a new NVMEM provider specifically to the eMMC
subsystem, the new support operates at the block layer, allowing any
block device to behave like other non-volatile memories such as EEPROM
or OTP.

This series builds on earlier work by Daniel Golle that enables block
devices to act as NVMEM providers:
https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org/

It also introduces an NVMEM layout description for the Arduino UNO-Q,
allowing device-specific data stored in the eMMC Boot1 partition to
be accessed in a standard way.

WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
Bluetooth requires similar support, which is also addressed.

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v5:
- Fixed ath10k binding issue + extended commit message (Krzysztof)
- Moved blk-nvmem handling to block core instead of a class_interface
  This allows correct/robust integration with block device life cycle (Bartosz).
- block: partitions: of: Skip child nodes without reg property (sashiko)
- Link to v4: https://lore.kernel.org/r/20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com

Changes in v4:
- Fix squash issue (dts commit incorrectly squashed) (Konrad)
- Use devres for nvmem resources (Bartosz)
- use __free() destructor helper when possible (Bartosz)
- Fix value return checking for bdev_file_open_by_dev
- Link to v3: https://lore.kernel.org/r/20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com

Changes in v3:
- Fixed missing 'fixed-partitions' compatible in partition (Rob)
- Fixed clashing nvmem cells, document calibration along mac (Sashiko)
- Remove workaround to handle dangling nvmem references after
  unregistering, this is a generic nvmem framework issue handled
  in Bartosz's series:
   https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/
- Validate mac (is_valid_ether_addr) before copying to output buffer
- Link to v2: https://lore.kernel.org/r/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com

Changes in v2:
- Fix example nvmem-layout cells to use compatible = "mac-base"
- Squash WiFi MAC and Bluetooth BD address consumer patches into the nvmem layout patch
- Fix possible use-after-free in blk-nvmem: bnv (nvmem priv) linked to nvmem lifetime
- Simplify nvmem-cell-names from items: - const: to plain const:
- Factor out common NVMEM EUI-48 retrieval logic
- Reorder changes
- Link to v1: https://lore.kernel.org/r/20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com

---
Daniel Golle (1):
      block: implement NVMEM provider

Loic Poulain (8):
      block: partitions: of: Skip child nodes without reg property
      dt-bindings: mmc: Document support for nvmem-layout
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

 .../devicetree/bindings/mmc/mmc-card.yaml          |  29 ++++++
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  39 ++++++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 109 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 block/partitions/of.c                              |  20 ++--
 drivers/bluetooth/btqca.c                          |   5 +-
 include/linux/blk_types.h                          |   3 +
 include/linux/blkdev.h                             |   1 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  39 +++++++-
 net/core/of_net.c                                  |  49 ++++++---
 17 files changed, 345 insertions(+), 21 deletions(-)
---
base-commit: ccb7390d6cdb23b298a6e2a7028ec134dfc4db10
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


