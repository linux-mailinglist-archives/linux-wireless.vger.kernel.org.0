Return-Path: <linux-wireless+bounces-37509-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KVFOFoSgJmpzaAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37509-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:59:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF096556A6
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:59:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=obiN0suf;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BXFb4bsi;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37509-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37509-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1CE13093CC8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5461634D915;
	Mon,  8 Jun 2026 10:51:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D6349AFF
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 10:50:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915860; cv=none; b=camCSQnyUqp4/IxfgLJz16R2xbOSGDxO61eEPqVEMjJX30z2XmDYYEApe/qHbyJ1U4kUSXWEQbBerSDm7sugvtGYprwvgHcQ6AC9dGqfNXTJlIDpjinb8A9+IFrrRzQALES5Md2yAek86Nbr3lhb/vC5+LQuXJr2bfZwgfjLc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915860; c=relaxed/simple;
	bh=/5JSpbZRWY5COHZDhN4gNF7Jnw0iPmpuvearF0ixaPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zanar2D4sOXWSKZZcELPFhGthSeeA8gRtpC1T2dVh+dmtugf4WJ6mA9Uj68UmAB/qJ8wtjixj/F6f1aHyLVQz/b0llLaPJNasmcIgVZk8QqcXQg4YUOsgFq2W8C1+cbX46DbBHrGLkPRzCPWjGdnNHfsXa6XUQkSEIHOiyMoJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obiN0suf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BXFb4bsi; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PLGL2834629
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 10:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=; b=obiN0sufjkJIpbxQ
	8vAJpCWlvQ6AfuEVCWzooX/FKI2cWVAgVgajihPvBG19b2Db7MnD6XFd6oaYulzd
	HhttUgGezEYy3nDqlek/pgr3mhESpR6r89Qrx6Y2GHYo1JpdXrksjyu0bzQcH082
	2tDF3hRcdu3mcZlDs0BCN/a68yp2od1bgw+XXV5+VLXiI12SSyfdVNrzy9ogRs7o
	LE+kmLmZrn0LDN+AkwK0bwz8U+CEa/3uR6JQIFDE69I32B1wF8pheSIeUyejN19b
	5Fn0uxOby9T+pET7rrfrwTM3MkLqsPfCowSflBJl3Js4mOz1E/z2v9g/sVVemFfD
	OBDSZg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmrfhgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:50:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cceb0317b3so48136296d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915857; x=1781520657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=BXFb4bsioTn9DQ5WdCMj70RNo3T5rjnxTNB1NhcekVfgEoP+fFa2mvVfiWOKJWiUrn
         W1CMfuv+Y3SZ/snnsNERzAFvXo8SppSUDku2HFqXUdH5EWOcmhDby/ycYs0mUuP4pZnh
         aiWVDayD8dq9mtrpnuP8jDOoUizdVyXvDgA20qX59KmXsc4yoO4IxQe5txi+lIISpPrH
         MsyB1nOaQ3cO6EISfm8wqwlZ6ZW6H34rvcv6NOYa3pJ+brd3S+X+3CTK6qAPjee/Gxoy
         bt3PRMxScZ+P42BBq2l1GYa3J4m4DECNHwHqmJMXIzqGfk4iCtTMK7wZXfDjgx+BuBd0
         rgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915857; x=1781520657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=AlyA6mCQbNawxXFdg1sm6++RzaukaC2dbDw8XFwJ4CyAfO4u7jOUpQOtXXdDH32XyM
         FSiP9n/ejo1W5epeFBLN+0MbLR/Nfl1f182vuH5XwdWdJkzHaHhXGoc5VlZ30rIJHZ51
         YbwxeW0PO9vhec8yU6B8aOOogEbUG/aCmB5gGTOTs04JwOnK+cfxK2G0yQFHZJWniYuF
         dKcc+rkmyLdnKQw43mZeBuufQEhoiHL+u/zDm0L46UhkzjTU/vyU++G0iDC9eVX7tn23
         uhSzh2b3cNw49K2hfqC7glfO9FN236hpIlh3CQBOWtQARqTFJEJUhw0ueFLZUJ37zHnD
         nf9g==
X-Forwarded-Encrypted: i=1; AFNElJ9oz64qQIsoNWCysbGBPQvy0CpGgrak/+9IevkoH+s80L9k+Xt8+zK8/9zJyBXblcq63nPeerLLgAaHMHNs6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5LcuMa1KVvz5pQXcp+A6NdVLkYYLnVQbsgcB6Nqeq8QWIoDb
	LaW/dl4+B1Phk7v4GKYhemQBskusewInL+2R/boZUeYM23srhronsTU/mr8Go1vtZQnrE7Yt9Z2
	vDlNl9x+RxB8UGeGaFGnPgcti23ad27EknJFDz4AOJtxFKtBZi2VelIFebUmx7rkBY3MVUA==
X-Gm-Gg: Acq92OHUP0P3sTwdXLXsRQJq4sv0ZkKEM240Jxm+7lph/ZbNYz8tQkgiRnBcquLtZr/
	T7Y9bzmDefRmiJufvw8FFWP3JEnQLGB5HAdZm/7+5w3zM8m7ADOYk/Buln4v1fokFZjfF2pKdJo
	6Qq7nM/exkNHndtabD3MDBY7ZmdFJ7trLL9oGwqoFwKdNz1Bf6iGmS+8dWOwA4pT83yLwvY6eQ7
	7T78nU7gJhkuSr+koZdgwEdLsm9Wp7QKm/L8L6LkmUshrJQuqyj4K4GZ2FiS3/JIGDL/U2oUogv
	9ljGkYIi6SN5zOa0O8xcJwUdxBZSxKEH+r2JdYF+T0NlYI4iEsYtsbIIHb9kHcHJHvpiMtpHB6u
	iAUu5QtWExaKKqCbHexBEHQ6qkWlZSHJGgrbMfUXAh1DhDsEuGIWOCS4Kr4jwR44rE0tXkQF0YA
	5B1pVGFpcjaj/QzfNJgp76/8+C5wH/djgFDJDHkZ/ysPA48TfgB5laDlEfu58VDF3pV3jJW3ZYg
	mFoOU3WIG59
X-Received: by 2002:a05:622a:47c3:b0:516:d4b1:48cc with SMTP id d75a77b69052e-51795a4838emr190287161cf.8.1780915856844;
        Mon, 08 Jun 2026 03:50:56 -0700 (PDT)
X-Received: by 2002:a05:622a:47c3:b0:516:d4b1:48cc with SMTP id d75a77b69052e-51795a4838emr190286901cf.8.1780915856424;
        Mon, 08 Jun 2026 03:50:56 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:43 +0200
Subject: [PATCH v3 6/7] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-6-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfXx78aqLqkz9Ji
 h06E2a8MSx6FYzrif5dy7d5nidC7xrh4fdIatGUsGG+Kti5H24+8LvwiS1jGY3aMiUgHhbvGyAi
 2bjzEAnVAUGfOO57K50QfqtvLOjxY2//UEHwaddyYt6Z3cj/of87nwOr66+iIDhm4ljuOUFbs5Y
 wvXmoUI6LqUIPpzHk43iBqAqXgBlsOG60Ntvon1GED5AIv+wYr8GcwdXXNkZdYM1xmSezSktgox
 EfBijLsHUtOiM06r5kEzAPvXjo7TG0GbuNMifeRh+ns1kNlzu63Ccs7kWxYAKHtAYPLVmsLK8No
 8Of+P/p1Dm5Np0v5vz93v+WFa35JA3UrvczHct4RMH/Xggbd7tHfWbtp0Y4ctT/+9v1WQX9kU8l
 xmUtNiodRF76Sb2tJf7KR/gd0avv9gbDngA1Yya6myav9qfW3T+HMcPXtiGzBkdh1MRX276jx/g
 NKfkQhQCk7fL7HrrZAw==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a269e91 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: PAJxaK5bV1oINYARJnR0hviQ6csM9VtB
X-Proofpoint-ORIG-GUID: PAJxaK5bV1oINYARJnR0hviQ6csM9VtB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37509-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: DFF096556A6

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

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


