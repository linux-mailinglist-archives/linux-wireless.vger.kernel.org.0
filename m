Return-Path: <linux-wireless+bounces-38468-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c6q9OVk7RWrY8woAu9opvQ
	(envelope-from <linux-wireless+bounces-38468-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:07:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AA86EF806
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NbIMQfWk;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TTxg5Vyf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38468-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38468-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82926308FEAF
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C57A495508;
	Wed,  1 Jul 2026 16:01:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9564C041F
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 16:01:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921666; cv=none; b=aSe1zU9xwR61ZKTmWMr7gTOTsQmBlfRj24UmWyNKpsK58nvasTElCrP8ohKdbiUMFZfVC5KHi3ltK8OF8J/T3HtWnfd1Ak/lQU4gA+altSpoTMAjexz6vrV3aW6uNEGTQEbwKbXiy2bA/SwzCyAo6/ofjlQUzxinurpgmcjz+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921666; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=du0Uir4ukmjYkVwK6xPiMZYyrhjalSl4lbdHft5dPe4IpjcME75Tk6ZWZFnZu0x/NjOkHMKt+Kj/ecIHIsKQ/SllwIuIVegy3zH1VlYUDd2IjjYnGXLwsW5gI9JlRZG56ZDypopJJUUMSVuw0wGWS4KdSf4HLQRX2y/VOSEKQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbIMQfWk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TTxg5Vyf; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoB4p1468625
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 16:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=NbIMQfWk/M75Jc/m
	JJcsFsiD2oORCimjwwYEEgLE4CCbKa8/jk6TtZTAo2x1Chq82xjvwdmFs4twAiDE
	VmDSeiTYXtYJ39ntpwwchbR4xciMLf94auLLm5dXenL6roE2PUu4b2pcjDlKN9xr
	Tmqt2K6wYY4XM7zkpb8EEBtYVMordmmk8cH//v311NIYAS4Ewqa30tp56XPJEkxp
	NnUVh1GPoJ9JUr24MaNvUObsxb/pYWhBmwiTgocSru7GcYIPCxOqTEcs6tMXN12J
	Yoiz/RgXGsjpYOtHtjdn03/y2bD6I/b9+OrJm8s54ZTFl7pmFxudXQyCt6fIC9on
	tk9Efg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sn18d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 16:00:54 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-44aeefa1c36so382696fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921653; x=1783526453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=TTxg5Vyf8XjsLVhGUFj+aIXod/+Cz1zISEEDCtKz2+OlyqBZOAnDHTZufnpOXNFcs/
         aRUDpWPQBZtBzu82z1BrFLaV81aW4Hb6MUTyzxVsnKeuL0pJGEu3r3etc/f3O8uo6cJ+
         ptqJ4xi2HStQ1KmW97NUc1SAmY/LEIojCjyT/QpgbYqgzhySfnZ3yKPs9BTOxJKMvv51
         /1J042cpfOtCU1NRV6VyjGSE73Rl8Qngt7xMvqXR73CbkY1R5hdPeADQWlVHFOLu1ICF
         8r+DudScjYPh2l2266iPaaFsaHItRQzNtKck0j7v0sDddKZHHRORtEgPS9FIX0Of0A9b
         /wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921653; x=1783526453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=W+6i+If6cSuTXaDDdDZbUfCo/+3qcRlWJcGDS57Iom2uCviiDv8FnOCtALcKubL56R
         GMx0rPYfhhHp0lm4O20LCxGXMvSL4IWlQ1hJted+OcurPyOGotQdmxPmedqdveLUR/jX
         pc8ooT3mm5HpXr72MRsLFlz0ccLO9vGcWK2TJaaZjCqc/8ea/8Wg4GiJVsnav+bHvIkn
         vLdZIQUHO9foX8axPN2vTyQ6rkJg98Rs4jXeJIsMAGBqDTrpec52PlDYtf4BRP4J/UN8
         axe4gKxIh5NKwSCWVmOspVzRpxYsmAj3q8tKyjcfsnRauWlBJ60s+Qi023KJwy9yCs4E
         JUWw==
X-Forwarded-Encrypted: i=1; AFNElJ+jKJYgwu5tbhZBj7ni+Vw+wPeZJoNfkqSJzRF5NCSXZ7C4jb4ktXbh8ZwY9gg6vZBNPQ5dteMZliywlJ/z6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZrbzXDfmPldQjGy8pecnyYir2CKT5kqBxO9KsRs0Avx5spUc
	6RjgmgQhtmwPaUjUkAnVDmQo8P4oCvLS2ggriS13BD3nPGwY4sElbkEMSwBLbXjPwlVzqw9WnAy
	NjqTuzLPeMsonUn5gW3FsHqH4LuVWmjRNKDIHT6EdLsxH2bVEKHGSQpwzEvskyi3jd59URNZFNj
	637xesM2c=
X-Gm-Gg: AfdE7ckeeTpyqF+qIhaI4MWzWPacqFRcjjnYibbNdqLt4DtU5YrWpdecx5N3I2+3YPB
	1xaoc/j29ViWTtwir1vdxPcd1Kdnyx3MAc1lrY9QssJWTqr0WzfZFOVrX7FBDiJSItbfJnnmSXz
	p/0sIbK9QyTW2Uo9gyax49vXa+ZzFGmoX/zQl/BXSL3OAeD2F8PN48OQtAgvm8AyghiKSJF4faN
	lnibU8vJrO6nXb3wSEt0SqbM00hc/o7CeO4AFxtjraDCj0Q4AFaRlIY56SvS9bKjNGCuh/oDgws
	FKm6s8CKZAbWKJuf3r4FqGNvUf87LQBtBMJdyHxymC0FUqY5HPM6dvmIjeRORoBUV5HFuGSEjAT
	TTtQ9rVp8Np6AoC+eR0XgZgeCWHX/8+Z/zdpim+TQvIbFx9HzwXKrvIsU5ofkM8lwoqh3e8q1jV
	1aXPjB3zUwlwrmEa4s3TheX9JxX/plbXFMPYssmO1VpSg5z0sDl0WBdQk1EK+5ql4=
X-Received: by 2002:a05:6820:3082:b0:6a0:f200:253b with SMTP id 006d021491bc7-6a309928219mr1204941eaf.14.1782921653234;
        Wed, 01 Jul 2026 09:00:53 -0700 (PDT)
X-Received: by 2002:a05:620a:6f02:b0:915:afa5:725 with SMTP id af79cd13be357-92e78206c88mr299831085a.6.1782921639993;
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:27 +0200
Subject: [PATCH v7 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-3-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-GUID: ldf8444hEoC1VKRLDT1T5nsN5kxUX3fW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX6r07ZvhziWyC
 sTFh5F2CRUHhJujjbQt7cf+ZzMObZ9xBnPdS6cQybH1q4jQZ/EpCrQ5YFJ0txtrN1Ecj7WvsPRd
 ohshcK9flKADYHTdHR1YCfS2ykkVA7meWOy2qpO9vHWDhTZXyTZFPnxbJL0iC4brB6yqKSV7Ffr
 tHsxYk+oLOYXMsNjLu0UIfIvs/uRoC7lunDY0/PXNIs/BOHcSHHrkg9CzHsGIPeM2/GdRRsstFm
 9+uC25J1WctUYqCS7J3xaCBzmAE16scUzi9ZnJcf+g6FvxKz4WsNLMWDsqoNFchp+ykMAQ7yfyz
 0HZ9460NFYKqoZ281Z7MF3Ze/iVk/7GD7C9KWtCnZxrLbbAkZErKrBhfs5M3lNXPU5+1GM+LKV8
 8XhBAkEhmElZF3on45NL66uyA2Y0wsiCMlxaR62QeMFesDuLEOYcxwipYQBRUB0Ae7Bzq1eXEyv
 MvQ6XArg7ZXLIwwss/g==
X-Proofpoint-ORIG-GUID: ldf8444hEoC1VKRLDT1T5nsN5kxUX3fW
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a4539b6 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXyWIUtYLpGHt4
 bCsOWWh/kN6j/c3y2ZLHEHYH79EfgwwFYjluP1ML4c2s8lE7aO2fQ/rzHLZCuQaU1X7Iw18XmEe
 tg4WCoxW1syn/9kMSg5K1/4HmHMpixY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38468-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 87AA86EF806

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


