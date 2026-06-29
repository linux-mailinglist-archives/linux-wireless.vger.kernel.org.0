Return-Path: <linux-wireless+bounces-38282-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NXKJOtMzQmru1gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38282-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:58:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5833F6D7C74
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=czdkQeM5;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hkfs9oRp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38282-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38282-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACC153038109
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC03FB7E1;
	Mon, 29 Jun 2026 08:55:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCC3F99FB
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723353; cv=none; b=BFMfWsIjnLkg1JGdqRK883TpRsGzesJWB1G903j/jox72PknMslR73ARIgYVIlfVjCVlBOyrrY5y9TQDrEWyHH8pI+f1h4AweldQgi1FGrS83oU44+YyVRw+rUiazPJ84n7h4+dhSUsecLv6WaxKFbPvaSF6GxbQLvVqeFsXRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723353; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxM1XQQdso+9OYE6tKnPwrXYzIxB6T1vi/EcO00JnmxDz14PqrD5+4Poxr0AUcoQlQrWQ7izV6Q03o3UlbzzsryBLF6OyF8JPOXVNNKtNjuDbf/nyMMpr2AkXWFrpt4zgYcGVhLuwNvG9RXCnyfpwTg+iSb4F4e6WljwYDATVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=czdkQeM5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hkfs9oRp; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8O7Dw2348325
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=czdkQeM5XH12mExK
	rQBsqBTVulz05q+nbLZ/hDzVsMaEjL1c4QwPswA294pcy5d4tcPszTVQCbRi8HFP
	dtuBQ1P+Bref1rX/fKTpVD1kLVqSOt3e/EB800H1TnmQgUGmPM4PlepUhLErNW44
	9L2MaE6m38IyfAfaUllVU0PMbM1o0ZbvVaKFeuDqb8+sTN7qkI/nJskmKo3OhiY4
	tE1bJ4viyymvwTGiUg56tQ+T6nrlqNQAmrSjp0I/1d8xds94EULEkD3nhT0qa8He
	Cmo0MKo0h+oEXuMSPN5Fdcd+wH1BMYPzLzqKIB8xXhQE2auXmxUYLIPsNsKbMDfA
	Ws2w2g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s04q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:51 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ab02fb3054so2539479e0c.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723350; x=1783328150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=hkfs9oRp3EkTiD0y3RURDU85z1IrmGDRZs/H7j5Nbl3Z7NIzUBzDqYdjxHeS4IQkOb
         xsaSv35oNia++HvBgKgwpuFGQ0axmUkrlitxAXcxXNxkZ+2m24QtddrtJodn5hiSF7/Q
         b/eI/xz+Y3Rp/wbumSrNT4OYnVWll0mlgbPdGAAJbqUHzPdGs6DJXFH33eFgiS6AecZN
         eBXq55GeczZjD9Flmfvz8QCNtf/4ZSLuZHfLQzn/g6+xmg/ubsLW0CHbkfZXSRkqIfV1
         IWyoj5Qw2e95QFYazLDAZBiygEzO4rC0qE00yQVlMvu9zj15uiq2ceq8h7E01QCimpB3
         A4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723350; x=1783328150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=HnTNhDwbhrzaBNHYVKT+bCuDnykRQDFOM9Bxz2+KuYxy2rAQJOeN1dUE/ENbGZcfBY
         0MSArzRzxkeexR/+7nZwNdfQ2K0oLaFYGRbQq+zAyGHeT9bhSg6tCo+c4VqELEACl7sb
         8ZdKZ1d85WML3g32KeaHKyr6PYgzCZIh3+Cj7JTCm5qBNlmXgGPe9zvxX8RUDf6NgGnF
         hAJ5xlDOQfScPRZiLpVmeasRHyQmQva91Bh8tKSQgOBHGFN2gxU6iZ6qXDDcVlbcMfNj
         hSRP7hiqOAO4Bp3ZEbx5287Yaq3DWHNY+8MqOPnJLGw+k1Qcrv6N0GuqVjcKbymatgBc
         /Wcg==
X-Forwarded-Encrypted: i=1; AHgh+RpQOulwQv5KrYskxiogP5qT3Ozt6YEO0oTmaO12IO9jnuDqFspTlIi9vuMXbydjWvXBJlCk62zWrjRkMWpneQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJUS9FEFrhxuZUwR98FLj/X8zY+cE4r4PnKcvjgG8uP0GXuG6
	V0S8VnhWHNn4T8Ljzw2+82q/VAVMhqgOI8xiDSkwlu8v89xYzO2EF+hrKWpv4iE5wPPFJQxNQ+K
	5DmeMutEysA3l0a7bdRfYOKuVQvYZx9LahhYaLapIzFy0RF7xYfwePTskxZ2oyzereufZqA==
X-Gm-Gg: AfdE7clpU4lRm6rBlW0j9L2ANtENFGbck64bf2K2H/KoEqJzl4wCzvEgqaD69zO4oSC
	8RPrmc7klR/7qm3jkH+HocQsgLjoTTrGWmbp/Xg04nU8AvQOnQJDPJ10Bq+0nzMk3vaz3IqRcKy
	MIWbZBtvAcGvUGK5NRkkBGoq/vFP2aAxXLOp2r8GXC8XrEMKmjW1pDT1EntRKlcnjXxnn90QHRs
	EkBOjvD5pRjVfbkf1DgZzY5PDJYnpJ5P2yFR16g/vxLXtQSWARWNyhjVPsbIlu6JdL+goWCd3Hk
	4qI5TQSsuuZK6IgJQ3Iv++eWu0Shb8+V+O/SejaXQTQ7DiZBkxnPJAmakxkhorzx7ipldDdV6dZ
	kdQrXSFNP8MIWrdda/ZeVLTOtTbVkk0xmscTUIA92rgD0F8MacJt2Qe8GdjiqbtVEhhphkQ/Tpa
	gILLTltT+7VfVoQ6D7QmC1jjM/JjYOsdtk2TnMKrETf4x7EsAU+M9n/g9JEijy+3ojixM4FVqR7
	s8f+Qnt7CDdSzb8du6/
X-Received: by 2002:a05:6122:6588:b0:5bd:ac45:5b04 with SMTP id 71dfb90a1353d-5bdac455e68mr794009e0c.9.1782723350171;
        Mon, 29 Jun 2026 01:55:50 -0700 (PDT)
X-Received: by 2002:a05:6122:6588:b0:5bd:ac45:5b04 with SMTP id 71dfb90a1353d-5bdac455e68mr794004e0c.9.1782723349679;
        Mon, 29 Jun 2026 01:55:49 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:27 +0200
Subject: [PATCH v6 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-8-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX1aeJnb7AlYMY
 yG8lGFG1E90tC54H1QMHQ7VsMRfOtAkCHqyCm+J4187JFofpcZ+kHIq9wUPGXtMPOWL5vwVvgbo
 ZoRPTfG4F3jsHPRXW8MklM/lPh5XkUk=
X-Proofpoint-ORIG-GUID: SzBkosoo7_psF4LnWGDox7j94_dLFtzp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX1m1tQvFUwj/e
 PLLaHrsacV/0nN0G5TWhI64Kv58+6oawMrVgAed6EojwYtLyS1ca7GRXKp5SXRw9taxA2m4tpq3
 /BV9WftvkPh0cSGMoGaLevcL9ii0mg3XAo0V6rhsbLVqsHii2FpApeFM+6yPoyQ1rtU3SZY2C/e
 +L2uD5G3wU17pNXNTWkPTO0SgB3BpEUSaO7L6Bz6kuD8z4mOUt7ztbdkS4tSELHo51twtOiL7eJ
 gVGCqkDDNnhUdAgHqfu5+YxgnWOAs2FJaUHjLZgzXT80uJWEL2HEhoLSrJ7TrHKUqy8KycD9kMJ
 cXdQqs+DSjnKSwVYxpuqzSn8xTQT2kYPYHY/xoADddwAdyeQSv3z7gq5xaQr3zHFL9S82DFOsKr
 APcbZnuuaLBg/GxP0B0wzGgpasW5fMqN6RKKfqilf54dGxk2jZU6jvgOiovw0x0ookJErDESJjo
 tXHZtCMT2ExdjY8ywLA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423317 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: SzBkosoo7_psF4LnWGDox7j94_dLFtzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38282-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 5833F6D7C74

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1


