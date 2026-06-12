Return-Path: <linux-wireless+bounces-37736-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2um6Ed8JLGqWKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37736-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:30:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 922AC679D59
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:30:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="V2Cv/JFe";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ClIbo6xT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37736-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37736-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44BE73299AD9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE53FE348;
	Fri, 12 Jun 2026 13:21:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1F3FE657
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270486; cv=none; b=BJ108m32BMpFvKAlMTOhgAcKzKLfoHdRjF1JLqwofzpfOKczROUTSaPqyHnSv+aMSHTmV3wOpu/Rr39yfnT0orHA7jRniVYr4X3PJK0aD3kDSZaccuD9HptOIYMq470dxFdN5jC2GDHKnWWrHse9RFzMTtC7yvqX6uH8mBHr0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270486; c=relaxed/simple;
	bh=DhpKvk+qKi33tdqHXBdyBn+qHlFJWo7f2LRbmA/QYF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjeP2t8snpAcGEALysBB6STNgnf6HFSL4nlsCd4Gng2+a0yqKAvDRFs63UfN1A+08hbfbcMePVy928J3s8n3NPdRJDyyuJ8U6YugQFSL8IXhHXzaB46ucRaazE5hPhDrwcEWUezwewo3t+hExkJSRWmqsQQkgy8iJnudv0l9WCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V2Cv/JFe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ClIbo6xT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCjmGi3752201
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=; b=V2Cv/JFe4AaVKnXN
	5SHFfRRmkZthJcnQ77krCOWPD8LYZDGipdVZicvw6WB3JHNXAuttbEK/5FX/x8Tf
	Gk3si35te1+j/J5Od+9N7puqwPrSfEmysFJL4Keqji4YrXEvlpotbY4nTCXjXlx0
	9i0bAmE22kWQDNL13yDYbyDOgWjWTGxSgughOOLFmNocxDpSMxakjcYhMJ4slj2l
	hnTc+whwWG2E4YXnhDQduOMOTuBlAOhkP9A0KTC8ipH5sZhhNx1EvIrvochc6Ji0
	M7djkelH6RmSfvKYMDjaaOD0/OqnSETlFlGjYUwYOwJEkMpGEx7B6G3XOXD8e2Nd
	7UCxvw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2u42vs2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:23 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e7624e584dso1713145a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270482; x=1781875282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=ClIbo6xTCffncm4lDxxIQOzKT15F6uM2vHT6J94KVnxKFIXA6aUpb8fgFQ2AfVv4Ji
         701uSu5f6yHlCA6mcyzfxXH3Fh1r6v6JQqy/pvH2FPTuwp339RHAoxtd7elp65xWQznW
         O3xVCgO67oyUfgnhLzuT3UPvYqFCunuFLuqcgCyJl1TDHn5tZvfA5DICDrl9pjqZkPnC
         hR2wV8bqJzhyB+UoG4RNAQWMP4JRc2jUheQVFxYVWk835OFoqd6pkc/fzb5VXzuApWih
         X/nll2XiqjbFgZuTCGGdXhaG1l5Hx0exK44FukEY7SLhdHfZd7ab9OOEt4c/+rGiFotC
         AX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270482; x=1781875282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=EuMQiDcHpOxdekCK57QT/vaAexODvkqnbg2j3C0VpStidkE5LOSIrl0C+/Z9+z8VVo
         fon15h/HZ11+fGctcALBxbZssN07uM22hEnb7J3dcHFjBi/TS+wFcJ6N8Ph79ELF5iRi
         Lz3resyJRnMC3y1MYro3qXQROZPewVZ+UCfi9hlq9KXFfqScv1cc+fLvlJci33/kwo8Z
         4pBcBw8XEAeMO1f2qE/sPEHG2uU04FLQANyHKGqhV67WnkBV/xuMtLHh4opelK5um8dX
         2Z6soPXzJ4kvqPJZ3eAz88Yq3BttuCQk2oPLvUiSwF/Izp2nIOn0sXZ4+faxP6qS0yol
         mzgw==
X-Forwarded-Encrypted: i=1; AFNElJ9CbybmFjXP6iAQysi6oKnNrTHjziFyOVKR161dLDRZCm7yceaoYTIKwvQ/7/d7C5JG+A5glWuaJYem90BqAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMc3SdFcYty3i6XxhNnr0xZ4kaH7C4499gMCbJte4h+9tHRg1
	l0jzY1bSCNcnzKZ9SMb1qcnqWVQOX7jWFjy8kJmoQsqe98EusAebxcbykoA4foYqR1N1+yOKy/J
	te0BaNOa/y35qMh2hGnjhXLrZrQcDYQ2tRYh/Zi0WQrQAM4oCE7deWLrhPzbBZYFyEst8yQ==
X-Gm-Gg: Acq92OE+5d0IeTHVn1sbBmS1zDvg5oiZvBBv8dMvFpSJA6+MsbwHNRBCX1TtUARR/bm
	zHUiRMR3nOg2sEBXsecjrvA5TsX3SPD2I/hOm0lp4LVDqTRDYzpxP4oIVCCFMcml3BpsAcunstv
	BXioNxKCv/XtF+RvN0ostPDl0JxYK1qDh79rBqwoEHSA9BtH1F2wHEUtHuKpjKt5M2T4yjMBCGi
	Ti1BBxmgJUrp2cln7FVMO5qUyQT9wWHPtAN//iO4CG9uvAtT6WOQYW9IvUGyT/2zw89p78Jw4va
	XpMzt+MhaAKMSvluTOw5Dp9ulVy7rr6tDiVhY9CCP1Xv4ZbRaSGomZgYt6IYXTbnbi0Ktm/rykR
	INzLOpZZoEmiDZ60oa/8Bo97DMvBnD5EtmqMJoYQf2YeJT3qjwUKB+yKnSDOBrOpaavf4/u+lTq
	7Iusv307JMZz0YkfjG2ut85T0RPgK2dAddQMK+SdmXiPlQPZ0P8cSMLkFjkNAFhZ31MAprvDR+
X-Received: by 2002:a05:6820:6ae8:b0:69d:5b59:2414 with SMTP id 006d021491bc7-69edc798a18mr1609525eaf.42.1781270482354;
        Fri, 12 Jun 2026 06:21:22 -0700 (PDT)
X-Received: by 2002:a05:6820:6ae8:b0:69d:5b59:2414 with SMTP id 006d021491bc7-69edc798a18mr1609484eaf.42.1781270481928;
        Fri, 12 Jun 2026 06:21:21 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:20 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:59 +0200
Subject: [PATCH v5 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-7-95e0b30fff90@oss.qualcomm.com>
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
X-Proofpoint-GUID: __zxGp0bxW9EipgJjBAXbtgQjgIcKAVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX0zFy9Wu8lFvt
 v6Q2QyEnOlkJgehywExRsfis8WUiuDC4QNvzyLnbrbHT4UWuAHdgTl2Y7WjNPzjaWJLMnuzZyuq
 6XQqvT/WaTQMlleRd9hKkoPj2tkZmnk=
X-Proofpoint-ORIG-GUID: __zxGp0bxW9EipgJjBAXbtgQjgIcKAVZ
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a2c07d3 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX4glRqIWrii31
 vg8MCAOY4XoldNXtkIjCFMr0I/ztrbEF/lk/TW78mWMXydHcf6QIHWrLVBOX3BInLhKjn4dKo8B
 TGTcU4BNaXPY7tnePDQor3B9HTQX1YKUfe9rZpiv2j7gCZKbQpX/1dSu2BHtYJ92tlBi8Q77Spn
 OlJ9nNCzzWN8cTvq5KGqTr+yJ9WaeJuXaCnpMtxYE83lSD8tE8+JWeLhFQVrnhRZHHsD35R6Xk+
 s4M4Q/j+14BASoVWUFRcEwy6ANk5mWt4jrt9N+Q4FTVeBdrmSRcVb1NUn7NCURDYctSR7c7cMvS
 PouacXx90WJlyCo9TdaDJqVyd7OJeiZC5WXdj3O5eBAgWAb+lRqzzcxSFW8XM+zNQSv8QBvnCkV
 mOP7sVrv4zQTUXQjMRs0Wkn12IWJrOeArCX8RFMmMbfHSuufBnfYfSqXZpF7hVAlzYbHeJtNBlf
 l51RtcZun3JPN8Mc2tQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
	TAGGED_FROM(0.00)[bounces-37736-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
X-Rspamd-Queue-Id: 922AC679D59

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


