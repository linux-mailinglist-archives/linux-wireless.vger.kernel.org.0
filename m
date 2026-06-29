Return-Path: <linux-wireless+bounces-38276-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3xMgO9czQmrx1gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38276-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:59:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F686D7C7F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:59:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BrG4Ljmj;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HpNdqjNL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38276-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38276-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56723304FA4D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746543E0C4D;
	Mon, 29 Jun 2026 08:55:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972263F88B9
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723336; cv=none; b=siVB5l59hmM53oyci66YHqeH58Wfhu13rvPRXLEnqsxJqeCPttu3gktnWCk80+UCS9MEcVMAX1mSWMSS7EF8+UNJeGSPnon3c2shaR3UKCK0I4xyoWkoH5F2Tdt7C+SZMj+khFZ52Z+upzxj83ku/FEYFYqZPSMV5bsmXBCtnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723336; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4XOczbjrdo9D5H9qCQri7HpElw8WlPFUk7S+uwkg6MHfokXrer99Gle35QESOJtkGev7F/7YKEidP5yK6F10tmL18C6+SYpzw/x0ir36btUQS+7eHJ9YA+bTCWikr/3zRGZAkfWl207ebfc/NXLJFxk9k5yrOOC22v3QfJrl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrG4Ljmj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpNdqjNL; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rFM92076627
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=BrG4LjmjGlraKZJg
	7YKOa0KPU+pIo/CUftVNyjvA96wuJtSToedDs5k0ML4/LgiRf5bzfPoIbWoG+ttL
	tKPkDMJxtZkpphNjlpCtYZ+aBtw0f0cbysEv5RTaOAEnmEd8USGoF+cwHwuu7yT1
	W4cCy0PIl6XRB+8XT7U7HMV8HAq4A8DoQb1G1msThkkDHOuLY32DGXbhX+w4o80w
	KTOGCZCHr6KcbK3i2NdQDSpcdblbUaAgu7g1DImozCazwvJ7LXeKhLi8vWpMyMHq
	S6f0XFSK9TdHYUCEH2K3h6SSwE3fvyyCcfz533343tjR052P1NxwkiGXASXSWpjv
	HGpZGg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7ggyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:31 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-966a617821aso1484826241.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723330; x=1783328130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=HpNdqjNLTTSixap7i45I7gMoPy1jFNr74jBZp/Q88EMcbR18fqrselDfHoX7UMkAM4
         1yhTZHqOa1y7mY4mD7PlSxgAKcy2KOaUGp7132GIz3dAbHQgGmwXmyEC26vHOS4B64ce
         K8MIOScj6gHZuAkuudivEapkJvLONgaUi9VJDBZXvJDt0fcH5iXeADn1A0DkPWjSQWSw
         r0QCAJylTbxKQokQ3leVFC8gVCWNx//jFTBN335+c8nbsPLRXcV9ilgp66un4i2fFPe6
         eXUTwdy90yZxoddlKT2x8cG4xTPhP1aCNFT8OQ4a66/TcrYBdNWyHrLF7gziKA4ZX6Zd
         XESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723330; x=1783328130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=Gi36vW01yWN/WIjt1SQ2kGtUq3fFvwIQSARFtTwPMonXW4zBUqAVKaxpwx6QkrILsV
         BFpLlsFkRgwOqxz7ykkPc571Tjz/WOqgMU4G6PimB5zD69c2aUwOQN7k+9mHRvFrLz+L
         z2Pi7Yk2Zf16jtikw6SWYeMpj8izRQ7zm8PRqCuIfOacodvHkg51kc3RxheRNvUM9M4c
         byzT/CdMGpBQ4j+KGEB6j4HeNJbuUwCFNFcWnWARjCSq5lbXX06q0pvStVRxEOvjcc/B
         4VRqbcYzFzeoU9YIvfySGwfns1/A5gUFiLmiirqmzU9VhJGwH6g2jaW7DypD4Wy7wHE0
         wkuw==
X-Forwarded-Encrypted: i=1; AHgh+RqQmcTkQSqbkpR8qHGg95ZMNpzubCTreCD+Xr/JgbiSQ1p/ODzKfSqLX+f5tYGXPp0hG+o4ZPL41/xKgy3JlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7A3so/tW+gDrIDfj7PvVdKLJcW0ESAn9IIMVcZiU0qjgyH+u
	0VJ8Ryol9kFYrAnVFllIFXHSREcAd3nvAd4SAfNAf7QBHfUunmsgh1tBZWsTQ5JjXhkD6678Bmt
	88Sk1jU6Y99oLhxHJMXiEt0iYR/3BKwxj583T7nsLUWco1UAQfuUaDTFjunDBSihYTD8TcQ==
X-Gm-Gg: AfdE7cmtbvz8JTEAXIPdQXqNRM19GGbVPRmhJC3L8cAh6JuGp/Y8IKn609EBM2Kzf+3
	DNM02S+b9XPlMZaCJcRwz47jlE4Upgyt8D5jJbajbJfFCi/4+HeBdKI6McbbpsAdROWovqiar70
	p69aCy0GwYisd8VaV8q4fph46z3KFlXKfXfgps5xyiIdK8emjxPpV+FR6ILISPR7gxU5ag8LW0+
	eSW4dy/ZyhN9rmfq9NpL1w0ZPzRf81iP884Ul27Ol+Rwf19d7x3Pn9SjSVZBQkRMdNZePpDCsGH
	IHjBbsGxsVUJmSyD4J3pdj2mX2xuMkU27PTNrIIHxI+5BeWcfb/l+ytMUOjqWPpBikK2Ig+baJA
	h/RASRRlflroTPOwQVExsPxwr0jqOPWF8kJmwbhQz2cYZJLWAxPXMc9N3bWgC15UvNzWE+UZFBv
	F3o3dZ0/WwqL120Wj073sM2w7sJV/PcMxXkK5SLNGSyeL6IQ+zzkUUsedT5aWbMH6abGmaSVAiN
	QnEFPMy6eG847inoOXC
X-Received: by 2002:a05:6122:d09:b0:5bd:a7e6:10d0 with SMTP id 71dfb90a1353d-5bda7e616b7mr934641e0c.2.1782723330658;
        Mon, 29 Jun 2026 01:55:30 -0700 (PDT)
X-Received: by 2002:a05:6122:d09:b0:5bd:a7e6:10d0 with SMTP id 71dfb90a1353d-5bda7e616b7mr934595e0c.2.1782723329904;
        Mon, 29 Jun 2026 01:55:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:21 +0200
Subject: [PATCH v6 2/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-2-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX0dG3bfl2vXdp
 CoNcry+H9SiK7Qsa9fCK8O2He0fNYheaqGhSeZGW+jmjunlA4TyB0zLJ+CFjtunx9KzdaFnYXRe
 zQTGlRzx0/5knMlAe84p79yM9sWdP2k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX+qLEFJ4k9DR8
 zpgMr/dfjP639xL2EMeEnkIsFJkjWCLethv3KxhN1rFmJQcY5rYjwlteDy5iWqqRt1xtw/W88HM
 0o+C3mjfX1ZVY5XyimE2WeRxRhl+u9uIf3JMR1nogIP8fwEhBQALAj9QR1e3+8r7TYXMq2pfeeB
 AGmsFjQRPSuN2qw1cyI3Quaqu155wEzumCDIvsloi8XyNu3btPNb6y0o031SVzV4aa7s4D78QIR
 aMLWXqnHG1NaXSzAGZytXraAloUjQbHo8M/P7OOqZb0sYPdcovmPqDJ/cYeKnvjrWX8syGLW2rA
 PjG/DaDHcx4UbaKJAB2Z/esUmsEvnIU25L8VGZi/wkk6wkhNjGBexpxjqFD2x1o7aZy3rWHYV3R
 Phw+WFuG9RIIkBGuevsTtCyWFIsj8cUiXBwmMJrVT5s4tBXKkTttKChDWzLYBbIHJjA7UWJBVfd
 vTPl7i6HDr71Y7Rl4vQ==
X-Proofpoint-ORIG-GUID: 1ypYQHZLi03_QpzpjKpLDiGrrtCvdAzO
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423303 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: 1ypYQHZLi03_QpzpjKpLDiGrrtCvdAzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
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
	TAGGED_FROM(0.00)[bounces-38276-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: 41F686D7C7F

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


