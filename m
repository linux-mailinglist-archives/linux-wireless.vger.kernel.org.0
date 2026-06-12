Return-Path: <linux-wireless+bounces-37722-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ppEQLXHOK2qfFQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37722-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 11:16:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DED67829E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 11:16:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jFNQOBw0;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=drLPnYJ5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37722-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37722-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7744C31E7B05
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D33A5E9E;
	Fri, 12 Jun 2026 09:12:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13E3A6B77
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 09:12:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255557; cv=none; b=RGGZYmwZBnhERFyH6Fh0yoZkKhEQKH9xSTIxufGyAFUlngBozv7MuUpCp1XJUTC+24tE5eEGDKqlbkp4KTXOsUgagaUnh3HpCvB67YjKHjtGUxFnUGZLbxggDpfFojH/HP83ZEh3PH5KZH5EurDDc26+hy5+YFcGwiYmzWIQV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255557; c=relaxed/simple;
	bh=J1AFntJO8yn66Ges7ZIJc4qYkwhNSJYwQcAxHEZv4U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2WvgCpVMZT7weuGaKR9ZklfyCEeEtn25jJtR6l3Ij/dQIYLe6Tc4KCVrYRGE8m/6mqZuvi6WqQD7b0E+3lbZ5lDeWr0ZAMFb7djV8SYSrZ7oFgLTiPGOunHlh0dttATJHGBubZarx0KuRFR6jFUghvJ8qbh6RxJQki/8aDTbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFNQOBw0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drLPnYJ5; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3A25t2412227
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 09:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fQHHtK59LcboT6pjvqkOS+sy
	sywNj2Fo6GwGmNW3Glg=; b=jFNQOBw0YkLzDcDJnKXoiojTKiEGuD6hPTR+kfeE
	2ss4OSCbPpXkPqcf78P9LgzYKAqxaVmcPlAGqnC4mH8u2xP+ivX8Z1JKJgYJEiuu
	tFZy4jkbxlMuHM8OS5TEILW7PcEy6XJ+vVd8MXZaQ873NJ+HB+Ao1D4o1bO/TyIV
	VgTKANxBx0aZTaKWlh9+1fxOJPmQWkduGpSZMoSm+IRWKyDvfkHt0jY1Y3IgaWBK
	15jG+1HAywMpEhomeAzvahK6xEPIWgg+hnoa6czhQ64d/fuNWtlXMgaVvJnAfehT
	+9DqgRSqF6u6zfiAclJrVi8a4I0g7mc3Ush60MbZ8QcBMw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er165av87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 09:12:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517c65e497eso13447221cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781255552; x=1781860352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=drLPnYJ5yqlmaM0EM6PNqUTJ6HiVq+kvG/T1wFAH2kUnZ2tVnif0r5RKLShknjLTUc
         bKZve+jU8sSnJCorzQyzrYbhN8Yv1KORbXN2eQKnyx+y+wWtqZGsQPoD6l5MF6pnvsrJ
         TAIOM6tJwIvZolezRdba8WH5CFfV4SJqrUhpqkhcqVJXdMaEUHPRosyXntGIATOfogyq
         2Gf4DQ/29JlYoVxSPUF2CmhMm1Dnh7n2qzG5lJ7JW2pMMGBmDu62Yuh/A3E0MXjb2T2i
         OPZ4OI7ZBIafLfSb1iCV23fA7uXN7Rs+gNMUNF7P4w/LEsMZ1g7xF45TAn/NB4WCWrQn
         qv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255552; x=1781860352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=RpgQEjjMUVGA37JaLe7G6m6eExtPmqyG9JUrMSvDsRBgeUhY4mcY3SyjG7oJ2g/byt
         JqtBSqovJQe0+NJIiMLDJ80/S2veXpgR14tfIkncE4AnwgX1gDwbiPoV9YUh7M1+mQEd
         OuLaFge+vSPvszsqueDRd0FFW7smxB9MZEZHSexubivzCIVLXGDp0aFUVbCZaisDAAPX
         h3fAZ7TX9gAIpF5wD0aSfv7rVc1Kte1AO8h1wWLfXRmL5sjHZaHfxZXQJjuhvjMfBGuC
         xSxH+BRaBN2X4SG0cp9PrEthZ0PQYHc0RtznxPvPwOs5tNosGWU/7/uMHE04OtIiwdVP
         W+5g==
X-Forwarded-Encrypted: i=1; AFNElJ+ugUJ6BowUQLzLGmWI/kxWK7FYhEKF3ANM/Gan+XtfcJZoJBKRV8T8qr6wi4+U/jZ+vY8RoH8NWnL8tTnHEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzObgZntURpqxd2aO08LeclFdzZRBsOtxSOtty+TzC8Sq6CT/MH
	K8N0p/Tzd/mYWsKEVTyI9yQ5YFIohBBCN9vUOVLEetd6F5Fk3ojqbQVkjOgmb+rGLa1UQRZh5wo
	Frw/0dD6YwXW+4WEGIJoOFUNR9E942Bu2d50AAEEU47hwStyAhzy6GwlpxvYCVuY8ano2AA==
X-Gm-Gg: Acq92OEKY9OF4oM7qKAlJu6Z25Q/th0QbXNNayWuu0o54JmfZ+Hj6SEZacqMhQKwBHk
	3fJly+2R83crybtPfmNLvMAxIArBoPonAqAZb/mm272Sbk0Q0+iE+B63pxhXhEHrRyfGrQcW5vy
	VUyoQfouCX2UOpuSrmOhOKs7jUi8zcK3RHAghYcZRw4B9Cq2XkGhgdJn35Va2LmO7pN9W8QGdqA
	k8R7V2i++/IFbgfmiRPdw4lszHDWrUCL5oWOgR9DsapHr6u2qUwpYHppgQbBQQEnv5nVQ3iJrQo
	9/rFb+69XU7AWxviQG5CYHo/3BbShT1hL/XBvcj5R3ClCA7unPleRjennanIrI10tMYIGfM3zC+
	g77RXgQDqE33muTKMXeVzF/Tfg38uq26KuCq5+T+Qq2mXt2QclFXE4MyECItIRKG0D9TfONSik+
	0lpe1ks1Qy6KyC1GmKROvYC2+z3GnpVrK09q4=
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24249401cf.52.1781255551625;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24248931cf.52.1781255551221;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7357sm381663e87.42.2026.06.12.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:12:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:12:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Message-ID: <uybyiffu2czpzhycp6x7w2pptzmhajxlx3ogglshamppo66kqn@izztlisgr2xc>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfX6zgvfB56cc3P
 rx09a+EFr3Dsd9rtyhIuCgoRzgYTf00E9hih54un71guM/dhBRlnk7aR0LP9ZvLwH8ycwXUU3uL
 Lgs68IDj5GHpdTUKKf5EYVKGhATWOK6A9cmbtunpoenVMfehbzccNvDjvB01wih9LTYk5dx2UCb
 UgXuaxR5kyOd4+nTZESmasgRGtdBJcPcAzOomj1OhLPbDj8Bv6ovKga3vIzK1O/3O2x7Zi5ly4q
 oa6LOzbp2iUW9ZlxaiUMmmg8zPkhbOeAdhDe1hY9WwzHqgjcLFbrvieVWlhwrFnFqz6hxvkLHBT
 KvV+qUHxMwX2jL5jVi3D09dxXNX9vbNWbt6yKf+c9m4IEkreHazoo0WQ7shRu8MagwUoIjEr+zJ
 vcdFHNcoRCY92TdnGM546ceUELlyLvss9j5zMyHL0jO6NlLQL339evCWI1kvZzfSCBHmQ9Oej6f
 oDpsRzLoTxHo9MySumg==
X-Authority-Analysis: v=2.4 cv=LNpWhpW9 c=1 sm=1 tr=0 ts=6a2bcd80 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=m9cM9ScjmTDVYK95jDAA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: JIR1mpkaBiQ6GiKXLUb1Rnjb5vyEFfQ6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfX/JLXXFCQcSAr
 gQ3mq8xTpQJ1LuaaU2C79b7QQZdLRfFYYC9ypqDVwFSktIHcTYOAfChd7l00X1imS1ZAzFRnej7
 QNMFmS2O+6Q42coc23BQCwUL8KNANws=
X-Proofpoint-GUID: JIR1mpkaBiQ6GiKXLUb1Rnjb5vyEFfQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37722-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,izztlisgr2xc:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30DED67829E

On Tue, Jun 09, 2026 at 09:52:32AM +0200, Loic Poulain wrote:
> When the controller BD address is invalid (zero or default),
> set the NVMEM quirks to allow retrieving the address from a
> 'local-bd-address' NVMEM cell. The BD address is often stored
> alongside the WiFi MAC address in big-endian format, so also
> set the big-endian quirk.

Okay, this answers my question to the previous patch. We need to support
BE addresses.

> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry

