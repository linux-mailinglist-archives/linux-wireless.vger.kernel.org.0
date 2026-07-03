Return-Path: <linux-wireless+bounces-38584-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8z8OHdTAR2oTewAAu9opvQ
	(envelope-from <linux-wireless+bounces-38584-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:01:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1718703348
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:01:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gK54V1c4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=a0wDD9nT;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38584-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38584-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E5C30234D4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDC3D9544;
	Fri,  3 Jul 2026 13:45:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D783D9556
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 13:45:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086323; cv=none; b=GHOawSF+yqDS2CuhTEMQf9w52Y5H7GHTX5tXpfM+MqO13aA9LCUfEHOkPo/4HgJW280TwMPwAfu8h+M43hnwF3WhIjPjOFYUmTEctvr9zcOfSNbp2zrVrFV/mDZ9ELnshSDVUD7Zgq4pyXPdgr982lQK7Doy35k2iZr9I7DiZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086323; c=relaxed/simple;
	bh=7eReWioRb+Q+/KfAGRVYTSy1rse7P0q70/gtXocnlCo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GDtZtnukERuC1nvpQgbQZBzb4k0GtWFIiStAFZx6hp2+sYOFCxdmcWzgNoxLt2CQfiEfxG8BohAMjhq8Jt9Lr7luZXCY4WDfLzFm1e8MkjV2kn6hTWR14qCdrlxeCHjX7FiMLC48ZaGJs1HeLf9h8a9TvMHKABk0FfMQ2lSKq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gK54V1c4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a0wDD9nT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D1CeN054001
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 13:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YZQ9i8ECl/iEEdcBdY078g
	6tJYsRn3VFW0APH0rESAY=; b=gK54V1c4g+ZP7nyCcFy/pshCNy9BgG6htW+8fu
	v1V+om4aFOmwVa/nJTniffCMLFHpCU5q4rNM7Me1+7/9bQH3CwDw3tRqF5uu1A0I
	1zC/mczKB9DS+2ezT8PvxD3kWSFNuUKmm+wjvsoNiufs/NAAh1HtGZM5nFMydVHU
	Zbtf1JUbtn4ddoBqhhFdduy/exsttKWpt+n24Q6OUHi84meCGo6yRGEaTCPKBgzA
	QX1H0bqT1XGkwXaf4pMTLS/pTVDluvKHJ5c6cDIj+fVmpVxCoGHVQA0NQiPZN32t
	HJby9+Vg8KP5Xym+yi57LlroU8bK6DC9iOnQGOGYuGKIX5ig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkg4ma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 13:45:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915f6ff639aso106935885a.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086320; x=1783691120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YZQ9i8ECl/iEEdcBdY078g6tJYsRn3VFW0APH0rESAY=;
        b=a0wDD9nTcd6v0q0DxmUn3OVSh4PoGMgPimmMfYj0zgxuMFI0MjLMylhtgK7dsF7OMX
         pvcqKWUPE6Nf70fZvrjjcZWsbPihMmdrJ/qoEewG1ERsy//StUUfTzJ6XC62XYFBEY9Z
         ivx6plEQtJal/o/F1dAU/fWidH3Zyz1xYmQ94gEVWa4dCwIKCru3wMo4t0KSRLobJFwJ
         Wd6Xcmv6g8P9xq82L4QwkL57Br0RtrsL1xtxwPaeYNEeAm8zGDMyctq/wsYBLcZ/kbAS
         mK7gtRlN/4oBdQ8V9CuB0OBLoiEqr1rkLADqY8vgy/ajxjkUGdKEVxCRVpzPyTjIgZLr
         ZCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086320; x=1783691120;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YZQ9i8ECl/iEEdcBdY078g6tJYsRn3VFW0APH0rESAY=;
        b=IDFRwYOswyTjyJrtdSCEztgDhCsg7zrk69IoYGzef1oucNxZnhzcRKJyskLSHTtfN7
         My37DEx/uCWO3vsAX7/FKWMGqMZ3pFRgal/X30nAWKErA66JYhzp87nOCMYG2wMkdRFI
         oCA4rdbGH42CknyxaMsT+gkemCTifjJLZwO9E6nGGP9y09X5PRtKbxsRoA2Gbld5aQQm
         6aqoRSLz+9vN3ENJayLpUrQnIbCU7yaDQBFxavGFu5PxMABfTvxKf1k6YBSD3yrDfhS/
         zjDB3Vsdci+tCenNMZ9BE+Kw+NA7mrEa0dmu6/OBkpBpSK+7aIVhHk4rUhj8uNgiSYpv
         Hnog==
X-Forwarded-Encrypted: i=1; AFNElJ/C42Ir3Z1dja0A3yPV0/kpbZsEreADxes2gPPaj+lyf7gRKxgQXyrlaBhsgHZBKkt3jJFDaFurxw3fMmda1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7B1FYZmPIwL1m7JxdoMgSTutcfCk14XKAcRGyrn8B3e1Ooq5X
	92Huakv8h9YnKHcfZb5RXSLM9xexzk6Ri8cXNXxoLPMeKOhezqmnkkRqHj4qIc2V1g2ULPcJxPA
	jC9sYGA2FkDpfPbyaMW/SSGZwylbZ8GDBEtAGiqaq3OfdNJPZV8Ub9w6BC3QXM0Z7hL2lXg==
X-Gm-Gg: AfdE7cmFQaQEga3g4hLPeV3EBT5GtxPAmrCQ0TXjRm5HeAOk81ztCb3noM4nvFyEKnZ
	4Zx3y1PuwLP7SkixWMxNsxFAbrhog/MLJCgnOSNKD9abN4K7OxKUfxvZGcxsPLhf7yoItYd73zB
	n3kIvF71boFLYrDJV3HKqnGh+RU+5nl1J3ielaSK6oUd0oLVkrcjGaCBmGqeEvoQ/8lZPhO2f/m
	D5G74aqqvYa208Izc3SUjaHMuHjAsjOg7OY7s3IYD8TcfoeepQ8e4JZBsFiKjkh/ZfpGlgITiQg
	auypD5ejEN69wDbgxUP8OGZDmH28gERrAi5oeA7AzxpPSBoPrRDExRq6hUZznvs+QG6PfSP/6IH
	40vSWngpX3zFXKEHtPXmnqoNeQoxhtEeX3KSLnc0mZsCXZZ9PF2li6ICr975g/wobCOlgb5Pqde
	Pi4EZui4dBZEUjYCM/X5luR8Mi8yU+cOAu/xCp7OF2FnJrzMry6C76JD2dLeBVPvw=
X-Received: by 2002:a05:620a:4149:b0:925:eb05:d194 with SMTP id af79cd13be357-92e78500b33mr1373515485a.57.1783086318869;
        Fri, 03 Jul 2026 06:45:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4149:b0:925:eb05:d194 with SMTP id af79cd13be357-92e78500b33mr1373500085a.57.1783086318132;
        Fri, 03 Jul 2026 06:45:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:17 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v8 0/9] Support for block device NVMEM providers
Date: Fri, 03 Jul 2026 15:45:13 +0200
Message-Id: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOm8R2oC/3XQz2rDMAwG8FcpPs9Flv+mp73H2MGJ5TWsSbZ4C
 xsl7z61lxS8XASfQD/EdxWF5p6KOB2uYqalL/00cghPB9Gd4/hGsk+cBQI6MBhke5m6dxmLHJe
 BBmlaDYFCm2ITBR99zJT7nzv48sr53Jevaf69+4u6bXepRUmQLibU5K1qID5PpRw/v+Olm4bhy
 EPcxAU3xYKvFGSlzcpTSlZpQzuK3hQH9S+alYAuqGwhRm13FPOoNJViWDHWKyTXInZuR7EPisJ
 Ksaw0loCrzjk3sKO4BwXrXxwrGZA7SV0yLu0oflM8qErxrOhMAcFShhj+UdZ1/QMEu6ZwVwIAA
 A==
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX/vxKZF053I1c
 trN7BoREPeLTVV+cXLNyq0Z6FulFqaxnnf10OZV2+O8mjd/RIwlXmVAI8IOPiIkHSCirF3c92zj
 wcB2kwqY4HdMx1XWFlPGwaL9yNtDKEDDLe4E0Dvb5aD0CTtyvOPRCQHjComUeYCl4DAlqEiZ6sP
 Mh1NvKQ9TFAZTpfOC5Ib7DHDbTrRFnHE1MTBtgKyuM9xUkPTcZmziw8ZjVv42+LUWts5zEgD9+V
 oSvpfDT9dLNzIqgn3QaYa9Ir86KEgm8zj6IgpOdWITQXg6oHaDxTJw55xJk9wNq1WvyIhPlpy/F
 9Av0annGi/iQrPHHcTPwETNN8edtnQKf7cAJqqq1PnQjjZQZmSmn6e2BEr2bP594XfLyMedYdFq
 axKOZNK0VzLJK1HvUpPtsEBqDOjaGB/uiR9UaEV86e6s7M9yKmo3ZsDY3tXL1RebTFo3jhJQKjt
 fzFoVBFIQHO6PqZ/UUA==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47bcf0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=0GYAYOgpis-UCnD6-MAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: akNmYs9kVBCvpneaWN59rEgwnqmmR0nh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX2Gyt1hLD8zgJ
 +x1yTTVKD7CnR46rco2pPN5s/yjz6ilA7mrQ+7ytuaEjZT28NGCxuqtXKFUKsENuFqf3ZBSqQL8
 a86rdTFyw3FZZHUoIe7JqjpTMToMUMc=
X-Proofpoint-GUID: akNmYs9kVBCvpneaWN59rEgwnqmmR0nh
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38584-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:piotr.kwapulinski@intel.
 com,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: A1718703348

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
Changes in v8:
- block: Fix bdev->bd_nvmem on registering failure (sashiko)
- net: of_net: of_get_nvmem_eui48() now also rejects all-ones cells (sashiko)
- Bluetooth: mgmt: account for HCI_QUIRK_USE_BDADDR_NVMEM in
  is_configured() and get_missing_options() (sashiko)
- Reword blk-nvmem KCONFIG help text to satisfy checkpatch
- Link to v7: https://lore.kernel.org/r/20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com

Changes in v7:
- Rework bindings/dts so that the eMMC boot partition can be a nvmem fixed-layout
  and not a child of fixed-partition. (Rob)
- Add Support for fixed-layout as the nvmem device node itself
- Remove "block: partitions: of: Skip child nodes without reg property"
  This is no more required in this series and will be submitted separately (Rob)
- Add missing linux/cleanup.h and linux/device.h includes (Bartosz)
- simplify nvmem_register() error path using dev_err_probe() (Bartosz)
- nvmem_device forward declaration to blk_types.h (Bartosz)
- Add hci_dev_get_bd_addr_from_nvmem() kernel-doc for return value (Piotr)
- Link to v6: https://lore.kernel.org/r/20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com

Changes in v6:
- blk_nvmem_add() returns int, error properly propagated (Bartosz)
- Redundant if (bdev->bd_nvmem) guard removed in blk_nvmem_del() (Bartosz)
- Size guard changed from UINT_MAX → INT_MAX to avoid signed overflow in config.size (sashiko)
- BLK_OPEN_RESTRICT_WRITES removed from blk_nvmem_reg_read() (sashiko)
- Link to v5: https://lore.kernel.org/r/20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com

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
      dt-bindings: mmc: Document fixed-layout NVMEM provider support
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      nvmem: layouts: Support fixed-layout as the nvmem device node itself
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

 .../devicetree/bindings/mmc/mmc-card.yaml          |  23 ++++-
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  32 ++++++
 block/Kconfig                                      |  11 +++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 110 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/layouts.c                            |  13 ++-
 include/linux/blk_types.h                          |   4 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  41 +++++++-
 net/bluetooth/mgmt.c                               |   6 +-
 net/core/of_net.c                                  |  52 +++++++---
 17 files changed, 342 insertions(+), 18 deletions(-)
---
base-commit: dffcfe75c722be66aa2669fb335528edb0590671
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


