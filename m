Return-Path: <linux-wireless+bounces-37576-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C8nSHj7qJ2o/4wIAu9opvQ
	(envelope-from <linux-wireless+bounces-37576-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:26:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD865EDBD
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:26:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NvAGqPmo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iWK+kStr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37576-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37576-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33C0630D1211
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C47B3FA5F3;
	Tue,  9 Jun 2026 10:13:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BB3F20EE
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 10:13:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000005; cv=pass; b=p8jXYYHVwpPkIKkNm1gMEItnMLqMqh0bsmC9wt1sCagPD8j+FpV3djhO74Jh7UJj8l0KN0+Id4TAFU/WpSTWangT24FTncRMAbhemtmp7QY3xsfwz29sW2c3CKHnH/94WdH249eHG+JZ4ZvXio7SiLj3In/WApknaAIL5jIOodU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000005; c=relaxed/simple;
	bh=7fiix6VpPjrNUF1iRnoDxKJD/gPxlaVYBSZo5W2eAfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrw8icYYfQOcJujqidtEHADmlJ0aLN+SiMd1qSd8T/4GrZT7/sjthFXbDXAqBA29jh/NFMdS3+f5M6crnDrQ+APF59BAl1Y9NjI0aPC9pTveIHdhlof+GrPP2gqylZ4djFrbG+dO/qlCFuh5nOwVkclAMjuhhBEGv5l+7rCRmmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NvAGqPmo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iWK+kStr; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vmjO1908523
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 10:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rK5tl4HTNEDD0xETjFdof30J5AtGjM0BvzmgQZhcMUo=; b=NvAGqPmoWex3EasH
	EHg/9kr+o6cOMRvupu32I4sJwrVclhFU9WJdr4EtMFVruOHd3xOZe8OBdowA78VL
	iYhUUUl212l1hgQumD6iwgsEC5QwEoKYMUtDbht2jilg9DCHGEH4QWwNkpsnToWo
	i6AvzzlFu1h2H/+LxA+Mh1amFb8NZkfia71dSsETUrjIjKzf+8g7QuYNqynOaDrn
	BcbNOs+ZbUBsy2k5ggc73JOmeGSARvC+5wPX5hWC0qveY65EnFUNJ6/4UE4gNv/c
	7ESdXfUIKQqoWIDhhZjJzCq9Z/LGIBqvzXmpN5z6rzqR2whl4Z367Q8Ri3tW4uYa
	V29G8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jr7y2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 10:13:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91598ab3a1aso797822685a.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 03:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781000002; cv=none;
        d=google.com; s=arc-20240605;
        b=FXMLWe25csdhyHQPPaVJ5ivzm6qcU22BWHYkUlojjszJ2aw9UmIMT/+gJ4Z9+qAZio
         oj37ee/D9hVXJNyBldzBqqAqVZxpzZsQU49thA0cabKt1Y0mvf6VirgTCHU2Xey2dwcV
         IXqQyF4RVj/6UhzaqsfhmZDnikPEvbADyrRaO0we24edaZ/1mh4eBIWoCTuvZPhh/Qvi
         uJZ433YnNtGZjXPsmRO7G7ooL/jWOJwlHWmpWFSGjYx1/PW3RYNGAKRdIiq0F7Obr7rg
         Aab0L9mpBshHmnT3zsp1Zuczq2Z5m1OIS+i33VEiacSzmHl0rwyJPeWHwD6DmZhL93OJ
         LHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rK5tl4HTNEDD0xETjFdof30J5AtGjM0BvzmgQZhcMUo=;
        fh=YV1fcXbp2LHlXyAmfpYPdA9Ji5HKfnZCfnnwhOyjjUQ=;
        b=WmugJvmAKpeC3jEKWqZG57U5EYIJPNpbu8K5eKNgIClhrSbGgDqZLf8RNlyvvXbKeg
         anMw+hwHpiCYz3qAo6f1xFUQMOwV/PQvwoTqpCIFKT/Wm6lVTvSOLtkAktccWpJSyQrB
         TfS1lzLBPkNFMgRMvy9DKipoXZnx1w6PKNG79f4dKgvTKGYw2ET790BEzWZmq6I9cy6c
         UOJz1j5q/Bqu805bmxYsCHtLLsq3/3hma+stHFRqGrx5pnjQlSVbe6xeOPu9NlVHXdPc
         UozZQzgBnxvMKYV/ZBJoBK5si5ODJndRJ+RvOUZKP5ZEDbk01rO6SBEd0fAFxHJpoWg2
         s3hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781000002; x=1781604802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK5tl4HTNEDD0xETjFdof30J5AtGjM0BvzmgQZhcMUo=;
        b=iWK+kStr7xI15uKM6ROQDl8PIPwGP2XSjpxNgeLsw74VTGFJiIN38sZYwCNaf5Tftq
         h1UEx2g+JM5TXs0G/l7ZxYVZXIUH158II4eU2ZR5q7KYTRA9qAVu05b7zZqs+fZQgUUs
         ovi6kLmI4Dits4fb/7tKXfiuozMujE/qUcBiPIu+al90ekpiaqH/a1iFY5jYnO2OSSFC
         yCLRQKu3kz4IQt8q+6k5/FGHclWg7XYlwQsJv9odL/rICmCue+5xdaDfm4l9DcgPCvhQ
         ZCWbBiyhNlxZH/mm02nsZfkA41e2JDnvb2Iv0xHv3lelht+UGTQO6y9LPZU7G8R67VKC
         x9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000002; x=1781604802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rK5tl4HTNEDD0xETjFdof30J5AtGjM0BvzmgQZhcMUo=;
        b=I5xSWgyYUR/W50JmG9oeQxRsgb8YHi4pTyv0vFfKMgFt644TF6NsDMU1XdS/RnG1wL
         vflfGbOoWcRaPVfp76Rnk24GZ2xaHawoJqXMZo9spmLRyUcUCUXw8TuaE59apVTUug+6
         732eYOPKfzlXToF2ByH2uraWmg78XQlIrJx3honTavDnSz0+lJ/yPI6KGKR63aYRkCn8
         P+Rls2C6DefmQOeyhGE1KZvkMMfUmLxZtTP/fX0n5Yp2MKj1rflkpTXwjUrbfvm9iIxd
         JyD/dfnMGP4QisXgnU4zyhPZghbFwgVU99AryVphi/MQqckia9WVtmy11xCG4HQBeMHk
         LFng==
X-Forwarded-Encrypted: i=1; AFNElJ+7HKpcd027wWHAncF+NhjWMjXkDbDWQZsJUxxf2tXiMAzPN/xalV72JMh5LIxrv3nMZFn+5fzl1MAcon0lIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTcRxYgnbXYPhhcXasDBuQMKVBd3TfeATLdx3JBmn2N06ZlC3
	4t5tQSppQHaFEgaMWvLOxjOkYOFVe0bsOFx3nCBzUbGjKGIcENB2GCYkKa3jdwYOC/dXsmTBx2S
	cum0HnZaoA7GeuCQMvFH74p4hLrLsxGfgRyl2vTmCgVIdouEX4gvm0xyt7kKRktXEfErpEv3B2r
	HjZafF7780By1pCD1SUFQ1wvdPxibJFUDM983cejBuEtuu
X-Gm-Gg: Acq92OFXfJER3K83KQYHGEv3LcQHmfHLtGpo31jpXWYuFbtKFtnwxcwSiHUE0jKmOh0
	QwU12PGgMujfQa7u3D6wd4G1i8Km55Os7goYE1289ZugwbJg8gk0k6G9QUNOOoERKj5vLHVV3mT
	Dul5/r8qe7DueANGjNdwUKBrS5jg5/GWMVryN+R5b+89Vt+TLNXIh6FuDL3aMMhYYoeXOtBJOnG
	SsymQh8sioRXHlpd/b35h4Ntb2/vY3dp876N3f40//9g5DpTdtg8EgRo5bxUQAOZHkaGei4ayan
	YwOBFzWUpchVt7DasNn0nw07aSZGHb/i
X-Received: by 2002:a05:620a:28d1:b0:915:89d4:df16 with SMTP id af79cd13be357-915a9c2921emr3077668385a.7.1781000001847;
        Tue, 09 Jun 2026 03:13:21 -0700 (PDT)
X-Received: by 2002:a05:620a:28d1:b0:915:89d4:df16 with SMTP id
 af79cd13be357-915a9c2921emr3077666685a.7.1781000001380; Tue, 09 Jun 2026
 03:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-4-45712e6b22c6@oss.qualcomm.com> <CAMRc=MfuiPMkSm=-G6VEJpqKhos0TD_pf0ScBGqfwLHT0uk8yQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfuiPMkSm=-G6VEJpqKhos0TD_pf0ScBGqfwLHT0uk8yQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 12:13:08 +0200
X-Gm-Features: AVVi8CdO5YI5NAWSbFzNXGbYum69_nA2LQfVjrd4CKqvNbC45JuBlK0C2ABm878
Message-ID: <CAFEp6-1syMQsvuQ+dLU39bnDeL5Ok7vK1mA7CS0v1m7cjhyMQw@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] block: implement NVMEM provider
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: IL91uqqLERgzZ0_HHKDBV8MIpWYta56z
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a27e742 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VT4XjZGOAAAA:8
 a=nTbZda4seY50gyMA9OkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NSBTYWx0ZWRfXwJoWN9Q65r9i
 2hVw3paaR8dVfU7A36LINoHBKTMm96mf5/ajcJ8vYvG93OSNxv2wLuT034tUuuf2467DLqbkN4S
 haYbb+6ltRhwj1RPQm+ClsMFI6bpQ5j6BGcqNzbXipHIrJ4myKolciUrAIxB2fIk2USn2tuBsag
 8oQmD1PzqheOtEp2q5v6NVlb3tzFCCWI+wVlMUpRxmdv1ogNletlehGRMVW13tahxZLWHH0myZd
 UNVeqHaY47m6TBzq7mJtVQBGBkNKyYpSXhPeN0VHByiqyxc5Y4wooYBIp+Q+X22PeWfUGsW/PNr
 TfrfBAPsbjVrN9XJ4t+puioZXTYWaCEycKiq9Lp03pSilMji0A4Q8/HM2nsrtv4rrV8zPTcY9ZX
 pwfea624+LQzJBXAVsBz87/ou6fSdJXtiM23exjivAdpZac7qw0UwyPWRgQDD2G6xj+3SMVvcf6
 lyURSnMsERJ6fXlZkog==
X-Proofpoint-ORIG-GUID: IL91uqqLERgzZ0_HHKDBV8MIpWYta56z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37576-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,config.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9BD865EDBD

Hi bartosz,

On Tue, Jun 9, 2026 at 10:52=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Tue, 9 Jun 2026 09:52:29 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > From: Daniel Golle <daniel@makrotopia.org>
> >
> > On embedded devices using an eMMC it is common that one or more partiti=
ons
> > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPRO=
M
> > data. Allow referencing the partition in device tree for the kernel and
> > Wi-Fi drivers accessing it via the NVMEM layer.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  block/Kconfig     |   9 +++++
> >  block/Makefile    |   1 +
> >  block/blk-nvmem.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 124 insertions(+)
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706=
f75c92bdf8b648f7c 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
> >         by falling back to the kernel crypto API when inline
> >         encryption hardware is not present.
> >
> > +config BLK_NVMEM
> > +     bool "Block device NVMEM provider"
> > +     depends on OF
> > +     depends on NVMEM
> > +     help
> > +       Allow block devices (or partitions) to act as NVMEM providers,
> > +       typically used with eMMC to store MAC addresses or Wi-Fi
> > +       calibration data on embedded devices.
> > +
> >  source "block/partitions/Kconfig"
> >
> >  config BLK_PM
> > diff --git a/block/Makefile b/block/Makefile
> > index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800=
ea266190a43b3e63d 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION) +=3D blk-crypto.o=
 blk-crypto-profile.o \
> >                                          blk-crypto-sysfs.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) +=3D blk-crypto-fallback.=
o
> >  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)        +=3D holder.o
> > +obj-$(CONFIG_BLK_NVMEM)                +=3D blk-nvmem.o
> > diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..a6e62fa98675ee9bcb9c703=
5a611b5a573ab9091
> > --- /dev/null
> > +++ b/block/blk-nvmem.c
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * block device NVMEM provider
> > + *
> > + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * Useful on devices using a partition on an eMMC for MAC addresses or
> > + * Wi-Fi calibration EEPROM data.
> > + */
> > +
> > +#include <linux/file.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/property.h>
> > +
> > +#include "blk.h"
> > +
> > +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> > +                           void *val, size_t bytes)
> > +{
> > +     blk_mode_t mode =3D BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> > +     dev_t devt =3D (dev_t)(uintptr_t)priv;
> > +     size_t bytes_left =3D bytes;
> > +     loff_t pos =3D from;
> > +     int ret =3D 0;
> > +
> > +     struct file *bdev_file __free(fput) =3D bdev_file_open_by_dev(dev=
t, mode, priv, NULL);
> > +     if (IS_ERR(bdev_file))
> > +             return PTR_ERR(bdev_file);
> > +
> > +     while (bytes_left) {
> > +             pgoff_t f_index =3D pos >> PAGE_SHIFT;
> > +             struct folio *folio;
> > +             size_t folio_off;
> > +             size_t to_read;
> > +
> > +             folio =3D read_mapping_folio(bdev_file->f_mapping, f_inde=
x, NULL);
> > +             if (IS_ERR(folio)) {
> > +                     ret =3D PTR_ERR(folio);
> > +                     break;
> > +             }
> > +
> > +             folio_off =3D offset_in_folio(folio, pos);
> > +             to_read =3D min(bytes_left, folio_size(folio) - folio_off=
);
> > +             memcpy_from_folio(val, folio, folio_off, to_read);
> > +             pos +=3D to_read;
> > +             bytes_left -=3D to_read;
> > +             val +=3D to_read;
> > +             folio_put(folio);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int blk_nvmem_register(struct device *dev)
> > +{
> > +     struct block_device *bdev =3D dev_to_bdev(dev);
> > +     struct nvmem_config config =3D {};
> > +
> > +     /* skip devices which do not have a device tree node */
> > +     if (!dev_of_node(dev))
> > +             return 0;
> > +
> > +     /* skip devices without an nvmem layout defined */
> > +     struct device_node *child __free(device_node) =3D
> > +             of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
> > +     if (!child)
> > +             return 0;
> > +
> > +     /*
> > +      * skip block device too large to be represented as NVMEM devices=
,
> > +      * the NVMEM reg_read callback uses an unsigned int offset
> > +      */
> > +     if (bdev_nr_bytes(bdev) > UINT_MAX) {
> > +             dev_warn(dev, "block device too large to be an NVMEM prov=
ider\n");
> > +             return -ENODEV;
>
> Wait, I must have suggested -ENODEV here on too little coffee. This callb=
ack
> is called from device_add(), not when the device is bound so it's not the=
 same
> thing as returning -ENODEV from probe().
>
> On the other hand, we don't want to not provide the block device just bec=
ause
> someone added a DT property on one that's too big. I'd say: warn, but ret=
urn 0.
> Does it make sense?

It=E2=80=99s still technically an error in the sense that we cannot provide
the required nvmem feature. However, it only becomes a real issue if a
consumer actually attempts to use it.
Also, the block device should still be added, since the return code
from add_dev is not checked. In any case, I=E2=80=99m fine with either
approach, as long as we emit a warning message.

>
> > +     }
> > +
> > +     config.id =3D NVMEM_DEVID_NONE;
> > +     config.dev =3D dev;
> > +     config.name =3D dev_name(dev);
> > +     config.owner =3D THIS_MODULE;
> > +     config.priv =3D (void *)(uintptr_t)dev->devt;
> > +     config.reg_read =3D blk_nvmem_reg_read;
> > +     config.size =3D bdev_nr_bytes(bdev);
> > +     config.word_size =3D 1;
> > +     config.stride =3D 1;
> > +     config.read_only =3D true;
> > +     config.root_only =3D true;
> > +     config.ignore_wp =3D true;
> > +     config.of_node =3D to_of_node(dev->fwnode);
> > +
> > +     return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
>
> And that was a wrong suggestion on my part too because I was under the
> impression that we're in the probe() path, not device_add(). You can't us=
e
> devres here as the device at this point is not yet bound and may never be=
.

So I understand The bd_device is purely a class device with no bus, no driv=
er.
For driverless devices, devres_release_all() is called explicitly
within device_del() .

>
> Which leads me to the second point: this is not the moment to add the nvm=
em
> provider. This should happen at or after probe(). Once nvmem_register()
> returns, you have a visible nvmem resource but nothing backing it in the =
block
> layer.

There is a short window during which a read attempt will 'properly'
fail, but this does seem somewhat fragile indeed.

> Either do this in block core when registering a new device or schedule
> a notifier here for the BUS_NOTIFY_BOUND_DRIVER event and do it in the no=
tifier
> callback.

So in the end, it seems that the simpler and more robust approach is
probably to move away from the class_interface driver and instead
register/unregister the nvmem directly in add_disk/del_gendisk.
If that's ok I will move to this approach in the next version.

Regards,
Loic

