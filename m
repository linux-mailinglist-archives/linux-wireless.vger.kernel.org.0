Return-Path: <linux-wireless+bounces-38463-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oR6PI7U6RWq18woAu9opvQ
	(envelope-from <linux-wireless+bounces-38463-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:05:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F76EF7B4
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:05:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=eLRgeEjC;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=irhSKQkn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38463-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38463-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 554A9306CA29
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67B4A1387;
	Wed,  1 Jul 2026 16:00:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76B49251A
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 16:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921646; cv=none; b=SwUASB6uApUdgH2RZaRhu/P74NyqwX14degT/AW0OHz+cNudWo1V7O8gJnlqNj6DN4vAtUgaYa4qV7xYSvwl06mBoS7CcRmY9eSl3NCMt+kAdMAMLlTxPK9JMCRSdXtgbJibsIB5zC/3Z0Rio4i628g/1GQ9SOvKL5+J0rkHsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921646; c=relaxed/simple;
	bh=NJn2c31lUH7/D4D288VRl32/NWMVhF4Gt9cu63zJMps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hPfOCY+gZL9wKfCIaAsW0pvUgAGBIE52NtXGOUTFL5Tx2fd8Kh+bd4mQP7jFElC+KqNOufNMhiZflewpZ57p6PdtYC6yr2faaytoyL+Yg4NdeCo3GGG00NfEdFHPVK/uLrxKK72WdaSaJWqodmcY5AdH00Na4OAOBf3bn3zOLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eLRgeEjC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=irhSKQkn; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoJpR1547294
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 16:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h6kqBe/1HqC093rRFcLnOq
	y3nv640MGtvfx3ayZFRYw=; b=eLRgeEjCy31rzy9tZarhmF5RzLaGbFh22koYq8
	lnRDUX7UJO8DMuxeaspcWJObEChEuWWBXlCZmcMHWa3r3L7BnTnVkXbN/+3dcej5
	TOqAFnF5ZayUzTxPDjCspYi1ZFjqCx56CCYyPc4PgZCcwnYhx4VPE7bd8ZmvlV5F
	zX8jYx6CzMWPsLM5JytL7MLbAz0LiIdNcCJ41t3x3d4SU5sNKUe4ISRQuyNjm2o+
	oTgWOf0ItSsdXQeWJClRR+1ANT5kKplRAO48ogqA7kHL8pQqHvclLBjj8V113eJu
	+URP6/d/0sdAvLIq07glcUNxxfYuCzoxayTai3hvkC2AuiBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy3n2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 16:00:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92aea0d801dso103390785a.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921634; x=1783526434; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6kqBe/1HqC093rRFcLnOqy3nv640MGtvfx3ayZFRYw=;
        b=irhSKQkn44IJTWyqmJMALId/xkaHBZ4FQbwEsa4PptKe+e9ywNmhspmZcI+Om+0EhU
         HrwhGJ52SB0VZW4UgrC+jtziVUrgOae5zLkH9RcATZWAyGnXyB91bjCjApf/KhnGptTG
         Pq6613i0PPkFnUP/OMfQdV60j8qsKYm++ro2pG69phsw+kzKfaS4o3fDTdwGykf8Wpew
         tnXugBjbfJi52Qyp9L4pFTlGQZOtkCiRHzw6p1zUzTDX/KA28MU/ggm4iodh077d5cv2
         n4rmlB4C90QxOt65xB7szpUcPu1mx12a+coEcQstgyuPnc30l5XDymWy70qBi9t9lalK
         fGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921634; x=1783526434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6kqBe/1HqC093rRFcLnOqy3nv640MGtvfx3ayZFRYw=;
        b=VIOANmqXIB9+J2WFCRju84wIUdWOTDwuOHbQueeSsnn8wpuEZJwz+9sNzpkS6Yto8+
         HVZ6+gJxYiuuVrmC+/kQDQ4QZDXzAk3cRc4kakFx55IS1HtlHhqpfhViviE5tSOxEEz2
         boEvhTF31Dk7vgHyshsJ9iDuu8n48+kosGnw5Th6QVpeaOzrrd6++mDrEX7kxtQL0hZ3
         zVQILwajoXeD5A6C6q4XadUcpJAfXPsDQmMV/BCAlCoCsGs+CAxC+OaET2hwLQH/RCmx
         7W5tNiQqhbkKqae849BoamYKuyagCZJBxenoiYhLKAmy4w7CrXzll/z0BhygkJB/+sjE
         p5Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+jqZ8yPWrmXMTb1/ERjG8ul6mhGA07Snhwvd/ZDONXZbHeNWqSrW1R+k5gHI+jN1DVY8sXm16qndPVOlefLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVoaizS08Xc4u+m2+8YqxikGVRZB8ABYjZDrABH8VY8dByiYz
	x1xHfefXguQ9iXkYdm7MbGFBJXl0WWuTUVXI0FdZAmTDz8n0ezgjWsxEAE9e2chdHeFCisQItNa
	Bh0qz/+mmdWIthIpcjMMwaOnAHyDafa4kgApitUk1pqFBcvQjJ/7HRvEn+DLHDTiZuAaqxw==
X-Gm-Gg: AfdE7cnkjdHhsGWa8JUJOwrG3hHYyKCbkrBDk6FbFQYSU2E1z3U1Ikp97huwjjwUFnz
	YvPHEv8IADEsayVq2KHmfd8laq7kOCq31yTSHFmDs5NnFKxKSStqShqrJWo9ZGJ29RjmwHKhOcf
	eX75u8NDMo+gYC4PxSF8G1Fgk0/y0+qwFsKnJIwinmdw3kHvmHD1w0pU8/gcr1cqBkJ989HPn4l
	9WimUJ86MRjSSUpr1scK1UzoYB3LKXDXsKNB25h46Ky9SvOCz6v6QUBmGVNlwTrCBbKAbwb0vRV
	HGUo4urVpD2bTaAV9IKeu0Jwz5HurmvL4kYmJT3gaK38QKUXelcRZnMUBIVa3B5wjRkLdxFV7O3
	4WP7SM4I4d1k7AdzsqVlR+mQUcdLhSQxFWohdD9k4QjabKTyPLnze+pGd5nk5+UHH/UD/tyHfSr
	wVZHF1sCTcsHcrsz6+p7J4yK++QKnS65jSNE0mqmegbiQGPzYZpv0cNd0TZK16Zp0=
X-Received: by 2002:a05:620a:4549:b0:925:4655:a89b with SMTP id af79cd13be357-92e7b056666mr210576285a.27.1782921632892;
        Wed, 01 Jul 2026 09:00:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4549:b0:925:4655:a89b with SMTP id af79cd13be357-92e7b056666mr210536885a.27.1782921630809;
        Wed, 01 Jul 2026 09:00:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v7 0/9] Support for block device NVMEM providers
Date: Wed, 01 Jul 2026 18:00:24 +0200
Message-Id: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJg5RWoC/3XQz2rDMAwG8FcpPs9Flv8k6WnvMXawY3k1a5It3
 sJGybtP7aWBzBfBJ9AP8V1FoTlTEafDVcy05JKnkUPzdBD92Y9vJHPkLBDQgcFWhsvUv0tf5Lg
 MNEgTNLTUhug7L/joY6aUf+7gyyvncy5f0/x79xd121apRUmQzkfU1FjVgX+eSjl+fvtLPw3Dk
 Ye4iQs+FAvNTkFWQlINxWiVNlRR9ENxsP9Fs9Kia1Wy4L22FcVslW6nGFaMbRSSC4i9qyh2oyj
 cKZaVzhJw1SmlDiqK2yi4/8WxkgC5k9hH4+I/yrqufw3z5J8RAgAA
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
X-Proofpoint-GUID: ADYbL4114y5ywuOa15Lv5yL8Eby9aluy
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a4539a3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=0GYAYOgpis-UCnD6-MAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX04JmHVaGQTWM
 4c9/5IT+9NlvoDQerRjkiQSYFmxJj5vCR7zsoWJoKfIMWbXG5juoCw5mOlloBsZKb7ypl2XMYio
 LSpdmbVoYZkk65Cv8KNWn02QdVULtLnI/FhFkn+dGDtT+HviOe0KPMJJ6lT/4jx6J2ooLjfvmwn
 /Fjyiq45u6KDa3pPuzGPv08gqWM37N4TZYuGMq1Vl+W7wx1TXghxmuXJzNG2dV8+ptXvPpihcpD
 mqvLFNTsncw/0/2wOi+mF0fPpzAN8a17RQJlUUJHgVCJwVucf/cd8KSBfme3/FNiQtUcA7eKwts
 1oJtsukd5y9uGCEq+NPkmw6VNYQBIymHC76z1Qio/fP+cgiQa4VKD6Canq8z2ZxRog6eyeoEVxH
 8Z9rU0GArqQkCh3/tMDkK/FW1pZqH0bYeVTa19B67vBN54D0hTAmnu1s/Ti2gxDWnmGCLkfB9Tc
 43nzi3pAKSegORGYWOg==
X-Proofpoint-ORIG-GUID: ADYbL4114y5ywuOa15Lv5yL8Eby9aluy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX39MtTJnimORJ
 49Qp0JalY7hVcM8gAlSXKstsX6KASbIRWyK34/pX650V3XxZ5i6hYLKrh2q7clEItWodfnecvWa
 6+pUID3mE6O3HtXyps6psGixYzSDR1w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38463-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:piotr.kwapulinski@intel.
 com,m:konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 513F76EF7B4

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
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 109 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/layouts.c                            |  13 ++-
 include/linux/blk_types.h                          |   4 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  41 +++++++-
 net/core/of_net.c                                  |  49 ++++++---
 16 files changed, 332 insertions(+), 16 deletions(-)
---
base-commit: c58ba8c7e9ab26b5e8d91f8ca0e0a16c2ae318e9
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


