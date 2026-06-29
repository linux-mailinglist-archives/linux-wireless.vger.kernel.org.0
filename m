Return-Path: <linux-wireless+bounces-38274-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gQUVBwUzQmqc1gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38274-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:55:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB126D7B8D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:55:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mqAyC2wx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AKo6XTrd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38274-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38274-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B05300CC27
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B83F86F5;
	Mon, 29 Jun 2026 08:55:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7D3F86E1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723329; cv=none; b=tgGMGqiOXVFzkmClP47rIK9M+v3+KoL6wI7U9SZaGGuQC5XJJHdDojyWS6p0tGok9Rd2dbqJPoh1v1AZjvCvgPJEXmaXE6pWkJejDCVJNiRby1Pjp+Asi9cTsrDjsKFUhIsJQZs+dfgXwSwSo2MBTarxObcFj2rpDMMjvLOCsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723329; c=relaxed/simple;
	bh=kVs08z+XFS2GVHk2vADgl417lrrsJP4YUMF5ujIk3uA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tq2OOtST0m/qhJuMUM6Tbf4Amqmd+M9bHWdLKlL+2L8eKvm8OTODPgPuRQYYqUvUkbcXoaQ11aZ5XOEGRpBRQ/yduAzct05ekDVLBZxXSkENl6/ct9ITKqf2xKcx2VuVOSxxNXVFkeLjvNMx58/T7xPwTgYUM+6IHauVqk3XPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mqAyC2wx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKo6XTrd; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7Dv1l2188859
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ROn9v0tvgRhtd8/CTMTZwI
	APSCSAz0ITaREV9z+qQSM=; b=mqAyC2wxQhZS2ovM9mNJAg7mTkn2NP/ArBRizo
	HorI3yy9cIat3+pLF/BEGIMyk7RxiCKeIkAFd1IUpDthEILE1w9X32KzI1gUY8U1
	Sg31Ttl5stwiNLDI06MFwpS9jge4RxzTjDKBnzt+QAvUd59BDvv4eSEeQeYL331e
	UXa1aivfstgStHG5uUcx3/Lri67wjkG4KhjDRHZAd9KoAAr3NbiAUcZKucR7+HYO
	BqeguYzbMNs4xDq4Pkd8p+ZoJ0HAng+AScYFchvItcFG4wS2Dz54h3fLbe4ERvfU
	teDWyLJSGouV36nyZgxyHLvBJhHEugSbwagYZtnAkbQo9ZGw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trdh7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:55:26 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5a787be4ee9so5186150e0c.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723326; x=1783328126; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROn9v0tvgRhtd8/CTMTZwIAPSCSAz0ITaREV9z+qQSM=;
        b=AKo6XTrdO5+hVuXoo1u8sycAyEeYqkrBW8r5IVVpYyZ7G5oNgUVqq/iA70LnI4zSHJ
         cxwG652mMSUVGbGDHskC186jg/71YLxUWsRGvFdJlradNURXnGoczjhx2WgEkNcppnz/
         uW9PR+QSeNf+gVKDcLpFgRjE6s068cGjdw8bqTd7+MzYsnIf6GDQ2diyIwQBwMdfkzxA
         lDDFHNF2necOJyqlZGH8yTBXWv7YzJJOpCpiFpQw90PXUvcVPUX6kYZ7zta9GKdXTfiK
         oyROBcjST/EXBicV8OfkouStn0sxknCEp77ERXsEBNR5ugZ4Cur00xmrVnfGX1Dx5crr
         NE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723326; x=1783328126;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROn9v0tvgRhtd8/CTMTZwIAPSCSAz0ITaREV9z+qQSM=;
        b=nsFjH3q1MHWyo1Uq5Z711tGI9/y7AcJHuc2hDtacVsL86vR/YTWLSF8mLj3HOQLuYi
         BzrHQwAQqe7uU0RPt1VW0w9I8V3Of9+mATRqP6TqP+zlI3Qpyo84xyGX+zRvngT2JPAf
         0TGZNbyCELpG8HVOSjDvucmTFo6kXppqiTD59y5NtB0bUIw4xqglPMlDjRSO7Z/v6O2T
         COccvnP0+OY3zazZbswvD53nquHoIBpf604Jkw3WMIq3Y9/l0y18dwmlFjRkS6mAOfRT
         VloXXGQgEkabNh7LfXhN9QI9rISVllh2Z2oBhtMP/HXWiiOXyWiZtqk5b20SRVhOo6VK
         h7xA==
X-Forwarded-Encrypted: i=1; AHgh+RrItEiG6qTiV9ONOJugHTcJ+rCqx8A7jQQZo0m9hT51Mmhvjk/dHpTaU/fmt7uRHNtF1rXsQTyRlG0iYeCh2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNqgX/MxlUrLVz/YKCgTZ4XdcFh/TSEU0JOZ3DrKndqhTWi3S
	whBJJukIjGMotn9QVyP6SErAXz0YzcR76Y5cVhZSWhlY0wdkk0hhzO8q9ONZxF00Kq4ENDwpYdv
	DMLfXwndkCrSEys2Tfg1oYKqR382ASmH+iMqqrHOg/8eFIh3v+EugPpJAuJub7IwaOPBmTg==
X-Gm-Gg: AfdE7ckbvg2iHWVsy2BsngO47PYcYQOP1c39p8LSJUBE9WpZOKTRC0dXfH5sI1pOEyu
	mLRiWhVuxE6VAOXVVnmhcLH3WXuQR7aESAudqQn+TABlmHpJtuqhalT1eBoKdBWBxX/rWW4Fq4m
	FJ+7IIhEX9zOJWNBTvagGeR1I255ZwpyAPed/EoW0je4dwIIEOARxE19wv0H0tCGyT1PNDCZtbo
	gK1IE3dzLXLrxKQMGJiprlyBZBDpSlFXjKK/d2ZZ3PX0vmtvhOAKrrVkXV+iKcnptb77nRvNJio
	YMZ5nsn1lKj+Yam+kPEGz0qLqIeXkj36AGEVdqHO6zYbG42tZ0lHwPsyuPlvc8Znea37GYTTDe1
	R9G5oxzHrJHHR+CqqjtNfDUcbXQprAjWQ5SIxk2y55IwM/79Jm8iR8AsZKyYqYvlcQwz3VC0wCM
	oMibT3GdJzNtqm6uwAp0cDEBq6vuwOAYPKUbW0LwlxiM9AO3n7ZRvJy6NmxyTHznbCx4m8GVd2N
	FrSK4MThyiueBkAcxXu
X-Received: by 2002:a05:6122:328b:b0:5bb:d0ab:5ed3 with SMTP id 71dfb90a1353d-5bd69c2f7bemr8037533e0c.1.1782723325749;
        Mon, 29 Jun 2026 01:55:25 -0700 (PDT)
X-Received: by 2002:a05:6122:328b:b0:5bb:d0ab:5ed3 with SMTP id 71dfb90a1353d-5bd69c2f7bemr8037516e0c.1.1782723325270;
        Mon, 29 Jun 2026 01:55:25 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v6 0/9] Support for block device NVMEM providers
Date: Mon, 29 Jun 2026 10:55:19 +0200
Message-Id: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPcyQmoC/3XQTWrDMBAF4KsErasgjX4sZ5V7hC4ka9SIxlZrt
 aIl+O6dZJOA683AG3gfw1xZxTljZYfdlc3Ycs1lomBfdmw4++kNeY6UGQiwQoPj4VKGd+4rn9q
 II9dBCYcuRN97RqWPGVP+uYOnV8rnXL/K/Hv3m7xtN6kmueDWR1DYGdkLfyy17j+//WUo47inw
 W5ig4diRLdSgJSQZIcxGqk0bijqoVixvkWR4sA6mYzwXpkNRT8r/UrRpGjTSUAbAAa7oZgnRcJ
 KMaT0BgW9OqXUi3+UZVn+AO4OA1zLAQAA
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX4nIABXvfW3KW
 FJYqICYwGmOxKG2I95CzHbLbkbb6TAehm1RLSwhiBrebuaj8P6x6pGyudTyTj77tLVJxSLtNbGQ
 8f0waGbpc7wdCKR7ExEX1pJq+Od/74jh7PqsdJTyKthGWFbMFfZ8bc2hZBxNnyWX7l6eYYmXEYC
 A53z4FpRjvKefHBWhf2vH2iqYsD0himvZn9nV/i5yby0idjHZuzYgmelXTMdWYprepd8YJAmQyi
 dyYg8jbGVfipwCGQIe2P3LJzj9s3zxCXI35Foz9QQwlJ8wBEqIr2J8Q/ek3FRDKwph881o5tT2u
 WvMUnM1AC+46M6yCKz0UjgdiBjnUwTleP7fGYH9WVYXthKiZWoi/GmxtIKdGcfBLw9qxbfRON1X
 Bs6iy7saahH7Le1VCISbJE1RCv1WwIyFln+uiq/WanipFGyKVDFoDit96lt6zDzFX1fjxTR5EwQ
 Isa20tggs5PNtcv+WJw==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a4232fe cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=H1RoBJpM21yDxn_SvroA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX/JTTm+iYsriJ
 ZtVfFC/wC63Q6c3vComvSx+SZYZrnOwNknX4iFGJ90N5vTADZBWEoGpKRG1vB3Cv16xgZzb1P7P
 E6Hu8VJFLTPblKdaZdWDvlqAkyuuGRQ=
X-Proofpoint-ORIG-GUID: OhH5YaRIXqODcTjAN2c04USPyGt4uxTa
X-Proofpoint-GUID: OhH5YaRIXqODcTjAN2c04USPyGt4uxTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
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
	TAGGED_FROM(0.00)[bounces-38274-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m
 :konrad.dybcio@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: AFB126D7B8D

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
 block/blk-nvmem.c                                  | 111 +++++++++++++++++++++
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
 17 files changed, 347 insertions(+), 21 deletions(-)
---
base-commit: 47c4835fc0fed583d01d90387b67633950eba2b2
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


