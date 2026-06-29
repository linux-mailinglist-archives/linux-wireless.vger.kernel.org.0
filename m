Return-Path: <linux-wireless+bounces-38275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SUxoDXozQmrM1gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:57:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C416D7C18
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:57:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gtV2aL4F;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=KAcVGx79;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38275-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38275-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 535DF303FA9C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31CB3F927B;
	Mon, 29 Jun 2026 08:55:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AA3F889E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723332; cv=none; b=RsxjWRyK/CT1DPOn4g/DbFPHA42mGjSDpNpv7PLYJSwi0RoCtp4KlRX0XO8ZDHvmq4dsuWDQ32f1yAPjMYdW2p5Gta/QXesLXznxGvtRt2x62l3/NihuuxRt4EDBGZIh8OIMLs/eSS6JN1oe0mpvWYuUDvFOk/tRV4k9oZZ+UTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723332; c=relaxed/simple;
	bh=Q5Wxi0COcXv/gy+y0D0pXiE5Pb3m9E8JU2uB4atickw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AByGTPelR7x50EPt5ZtyV/q6jBuEhFRCSiRVnilRaIBnJNm9j+PiiNZfGhac1xUebQDETvjkKDYA9eIQJQ35QTaSZqH/iVq28lIZUU4Sn+vWfSugZ+gB+PkBawh2npoy2o8IDQGJjvPbbfCjnOWcLjwV/PU0LCOTvavVF1CEgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gtV2aL4F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAcVGx79; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rcSb2134910
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=; b=gtV2aL4Fz4LX+hTN
	/6NwxrnCWdM+NDO0SF1lVC8rX50YHMG7SNeEQckNKu96PogiLC3h9k3LukSLeYpj
	cX+KIGUoQbqroZCojs52V87NEE5uP28/DtA75oDUqLuqgsSovEONCnRPclFqQNFy
	q8S89vFDTM8gdUPATfPSUXiXIgsfxkBKO3txBVDtCcVKLCcfNpzeCNR4OGjvDLBK
	e6O9jqYaEX0088rI3JAgwT7Ztw6C+yd1Qib3ibfIAIV+/cVt77+BA4k5vz1SKM/g
	xPP2NSZ/AHjSrOYPeHB1bsQQvD31SIsxa4+4qh5R0ZE6ryuH0BDBnNVzEgxLwlGe
	31j9kA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a5mmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5a83b662fb8so5082000e0c.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723328; x=1783328128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=;
        b=KAcVGx79T7ZUy4531wrr1DA/Td5xk61qZEVGVKjhE9OCfO1Iv6He881v93sUvvY4Dq
         hxO0EMUSbBYPpVPd8OdLIZHYbJxpJQ3vq7ZA3y+UnsVw0FyfrAWpXJWVkI44Pu8oX8Qy
         pg0ow4N9ynHsh10szYPCLuH5qdNeWyi6KX2/VzBhXO9XbqshMbfb+qGRBZtRqJpLdYHR
         20zWYvrLfUWuDBIKYYpy+HZkF1HkhIrBpIV7THG+5FoKMYAJmSv2xYZbSl0KVXyIN7qc
         +SLZLiOhrCGmW28z/vqp3khifRVrzUdgR2bKmd9HPKAwxO4w1iQqFlYMpqYvaR/2i5wZ
         KqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723328; x=1783328128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=;
        b=BT9acsnt8NL6WSuPEiw6cqYSMOwVr6W669UQq4uI8Az1JfpC4nNmsZZkIi6ge7oDSB
         OTw0zwD+siBCup62RrPKJPOIYNmUHy13DWzWwXiGfLteF4DylEFXBgFmPWvv0Xc01pvw
         gdC/8kQy4KTLcobfYiYVq/OACBFwMjsq1a+fUojRwo4H+pbeIrVsXXkfdSCenhzY9x+D
         bIXo99JqwmCxyYII8d5LZdHoUK+oNmlnEasJvlbXO76DR13qQ7fd+293ZbIyL0JYtd7k
         ecJMPzFsnyVFEJ6W9HriB5NSqqNzPQ4AB4d+zDG6Te1wDWEaviLaFznBoBTyy1Vidbaw
         wTEw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5dgon7/eZck+sMoNcet+OT4aWSSwSg3IJt7wJyNsDjhn9L/DlhTVk7YnR2GjWWjhVALrPu32iG3gzpXAJPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweBKBxJz8jITgf805pXcjuBXHWres4UWjKnr3aqvwD5d6ToHRd
	YC2IMgY0oDUc/kl/6tozTkBSMX1mfyfMnebMDbaTpO5yl1LrnHqBPJh83py7JKWRqTM36ajqBe1
	TA3I5TMtRWqUqWnxfH20o573lzBYgOuQxG3oL8UKmr8j8abOhncseI/hZZeF8wWBbicYFLQ==
X-Gm-Gg: AfdE7ckzwJ8+sKmZ5cGzDiZTLsRQP7ii1PZYkssLmfMG7in9/v2Mi5iHOuiaabKbijV
	yi00eF+3o/U3c5ALRVUiGkjcqtCrySFHgmGWkysv/2amWL0KVLvCZWsSs10Z5A6xg96GUomxyxN
	8L7uzgFZlOIzG75VlEn0oI9yV9g5xYp9ZBUYns36kIcwGyiYi+jkAybMw2mhPfZiOnpoOwbgwL/
	eVMImU7HE5JPfwwwN7e7MM/KTXMpr0kajBvz/SyfdD4zm/J1RItXHbtaf1GekdZhwUrwiY+QX00
	DzlZvQw7btpBV23ebKkp3KLAh5ArSwyYMFCr6KJq2VMvoLpAvM6ENfW1gQc5ZnyX/8V/SKNbJ6K
	6d/DTTYDyog8cZakW4Rg31UUbCECZOAGdYERCk4wS/z9MHYs+88MuRPe3nWSF8gHsFZ0FnvvNUg
	hfSki1nKaDR2fkZFWLLpjYJFUlgLHZSLbGH3I7JNJTGHeWajiukni2gT4/isgDchgMgFDEUPbdN
	6tSDeWdVOzV/EGJwwzk
X-Received: by 2002:a05:6122:d12:b0:5bd:9d27:1ded with SMTP id 71dfb90a1353d-5bd9d271febmr1874513e0c.3.1782723328048;
        Mon, 29 Jun 2026 01:55:28 -0700 (PDT)
X-Received: by 2002:a05:6122:d12:b0:5bd:9d27:1ded with SMTP id 71dfb90a1353d-5bd9d271febmr1874507e0c.3.1782723327621;
        Mon, 29 Jun 2026 01:55:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:20 +0200
Subject: [PATCH v6 1/9] block: partitions: of: Skip child nodes without reg
 property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXzq4Qa04V46Vp
 4Y0VSYsU0+nwyC4uksS9njQ64uWw5BHRUo3gFYSq6yhRDbP0ZwYWIcRn2uokz+YslTPSEF43kvp
 5rJiD3nWDENfyHi31Z0ZQ0q2dDJMhvO1nQv9iqybIPvoc70eUqFW+0w+CIg6gSYVdTeNs8tUxC4
 kn3x+dvOSX1ksOED95h3mJxJUvQ+6ZQ/mjdQu2Na+7Rf+HtPAcg/hrSQ3T3GbFzS77KMbShGZ3L
 n5U3Elbfos78wlMPRLRyzucgS/C444neUj1wGTZ7EVXQ4m1nct81fumrofA2V7CzYk93s2VmeZ2
 dZ/KBZekbg14M+CsCTvYo6GgMC/aLyNJL9oDhQq+8y8qc9xUWv521FVN040hCW04RlfuLewQ3iC
 jVj/8D22eBq+oMGj0mL0Snsc3n2f5Yp8g9BRKL1hkrnsMvWfqP94bqruoooRRFK3E1xxZlxuD0h
 tIoiM4GAkFQkF0Vuxew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX3IA6Y7rFsMLa
 HsLL48N3fOpkygTxJl5yeLL65wO8t1LNKxr4W3JIvV3hZE8PvfXBZZkEIB+LBlRhm1xmrWpIONW
 6XuJPd9VZFYux3lg6mc6ev+XguQaHI4=
X-Proofpoint-GUID: k77Agmo7EwZYrU_7tWylBRFqZtDBb3lW
X-Proofpoint-ORIG-GUID: k77Agmo7EwZYrU_7tWylBRFqZtDBb3lW
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a423301 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Wp80rbrglrcOpQJs44cA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
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
	TAGGED_FROM(0.00)[bounces-38275-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:l
 uizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: 81C416D7C18

Child nodes of a fixed-partitions node are not necessarily partition
entries, for example an nvmem-layout node has no reg property. The
current code passes a NULL reg pointer and uninitialized len to the
length check, which can result in a kernel panic or silent failure to
register any partitions.

Fix validate_of_partition() to return a skip indicator when no reg
property is present. Guard add_of_partition() with a reg property
check for the same reason.

Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
Cc: stable@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b6066109819c71568f73e8db8833d196b1cf6..534e02a9d85f62611d880af9b302d9fd49aa4d46 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,10 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	/* Skip nodes without a reg property (e.g. nvmem-layout) */
+	if (!reg)
+		return 1;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;
@@ -80,14 +84,15 @@ int of_partition(struct parsed_partitions *state)
 	slot = 1;
 	/* Validate parition offset and size */
 	for_each_child_of_node(partitions_np, np) {
-		if (validate_of_partition(np, slot)) {
+		int err = validate_of_partition(np, slot);
+
+		if (err < 0) {
 			of_node_put(np);
 			of_node_put(partitions_np);
-
 			return -1;
 		}
-
-		slot++;
+		if (!err)
+			slot++;
 	}
 
 	slot = 1;
@@ -97,9 +102,10 @@ int of_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		add_of_partition(state, slot, np);
-
-		slot++;
+		if (of_property_present(np, "reg")) {
+			add_of_partition(state, slot, np);
+			slot++;
+		}
 	}
 
 	seq_buf_puts(&state->pp_buf, "\n");

-- 
2.34.1


