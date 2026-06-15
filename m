Return-Path: <linux-wireless+bounces-37812-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wjF3NQPHL2oaGQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37812-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 11:33:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF3B685161
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 11:33:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=S2dbtiXl;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=KZbDlHZF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37812-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37812-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C57E3021986
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735473DB319;
	Mon, 15 Jun 2026 09:33:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3433C194
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 09:33:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516017; cv=pass; b=YjLyLM7cAukhVWYkWHqf+rUdDr5Kld8epoztK/U0pQjxvqD/rWl4zPoguRTWh6J36j6JNbmTkLpDWhVKKnf1F59AU/V+5OKqHllyK/ZgC90glddBaS6RJUZAoUyGl05zhRGhQygKOy6vRtY5rzThQQytLaJ3cdoZ0c/zjXec06o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516017; c=relaxed/simple;
	bh=yQb4i7L4fkVtRHJ4+idKS19SbRqmGMMEdBwmSWp+lmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD8G1/zAk3+blEqpEWJzZoHe18NnitByEkz+4woCWSTPNdu8HM/XgH6lgsPlzezgcIzlX5K8qN+M60Tze5HkAsMxvIeYee0pp1w+80VN552SLw+Q4/qlzhweWgwVFQLQ1+1NIgJJ4FjIdTqDSGBISd+TQsvWytcgkpJ3vD1jGTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2dbtiXl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KZbDlHZF; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6L1gs3888509
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 09:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qG8HgDUNc/nKERmMalYGQVa0Hi+SFVzgKt5xGaQIVIs=; b=S2dbtiXldx5Ql60C
	J7+12nSh5fUda9jkhJjD1zB/MbY8XFMoMFuoTOt78NWoMxcqh72cUpHdrxV7Yktt
	KFwL3N2eypVQk1A/hiyvis9/9GDToStZGj99eBd4eCs501gdrYCA42VZJiqISlAf
	kimP9DEFi9+SIdGt/RszZyKLAwlr1Uy03s5P8f65WSHRCsctKGbrKS1yzf953eBW
	BXJek1dzt3vzZAXUa5HcUvQEI8qgxSo+3ravTy2cmkag0jh1WiiB5HpNenyRpYK1
	9jtAZyLRbdlYrfSgb+LJyM63II7SYVpS1iF5m5XNGPsAXKQKC0AIfzDDPt7F23CA
	lVpyeg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wxppr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 09:33:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9157d38ab37so305513085a.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 02:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781516014; cv=none;
        d=google.com; s=arc-20240605;
        b=abPTe9lYbhkMwFRvqoLdVoy6IAU+am5eI1ZhiRmnzrw+vZuIoPQgR3ICntQtBKUbBR
         AO8idIUatMULKjL0wyWPPVUwZtcF/7oCYUrgAq6l4btn4+eZX2TahJWfWSGd9I6DWZ/a
         iCuIrsBpYWr2thg8o707WvCcVkVGnthfKbsohFxulz6+JiXB9tS1vRaZJMIeqEnw+GKg
         uTiZYOPjDGIesd65tdwWE9EYGjeax3qAOtgbGMuST4vrHFU5bU2bkqCDDvP/Vq+UBBeF
         7Z9EGcM7Px3wXs3yjC9aAd6gQssAUasfmsWCP2ealUgrv2X5iZ3WtVEWnNiHj/gJLcyx
         K28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qG8HgDUNc/nKERmMalYGQVa0Hi+SFVzgKt5xGaQIVIs=;
        fh=z32wUOWV2SBHnQxts3qJgvgGayc2Ayd4vzuWDQ7vTec=;
        b=MuXm+BAeiv4MRtLQAvu4JUSH6Oof29ETIRxcOdI/ebWhRR8yuwnVSSr5Dd3ZrQ3DNn
         I2O05g6y20i3mxedIdtMqWE/jethavCGRxCaEk8VTGaWM1sQzupvHOPNxLRfOlOg+c/7
         w5dAKm6fqjLhAkg3XdH1YiVQWxPRvz2+6COIXelMlsrmYN/veOZrkDt2VwE1OM4TfISD
         WMnAk7jMdqqkEuuUP22tKUdP9yNtFiVnxOU+BWShLIukuLgCOelIUQyTp4hUPxJEktAg
         S36+FptCem0DDw0HBQQCBpf87tU/Q/69zDI9BJA1NB7EJSnLPCKs7tGUYXJbWEoPVAyA
         q6mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781516014; x=1782120814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG8HgDUNc/nKERmMalYGQVa0Hi+SFVzgKt5xGaQIVIs=;
        b=KZbDlHZF3WPK8z6uUZg+Qpt4T4MM6I93LOSGpAq2i5ykdy28IBDsWM7GWAI9WiPxs3
         tg0Do0SBS+G4OMwfUN0CR2EwnyZKHkDR8DeICRIuDiI2jCU8hdR1oseuR37yhuu0RquP
         aZPx55z2sCmWAFF0iFA1wSLqWw9Mk56z9Ol1b1XwXTgTXi5cOIHB3O7AJM3U+3/WC6ey
         LPYU9iE2PmFuxXFPOr15+eW841thomXgiUG9eYl25YZr5eDLnPoEPfy8MeDM17hODaGY
         XG7N10rDjOAqQTRI0UsX9VkJ2B9/1kxxq1BAd6CnKw4hdtq0x/DeJvwNpXan2Og1ECBI
         hF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516014; x=1782120814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qG8HgDUNc/nKERmMalYGQVa0Hi+SFVzgKt5xGaQIVIs=;
        b=AdDORFXzdcHp7fZFCFR/VWxelJw76wbHGdS6SagSQUEkFp/+vyyiXl4b3fS3NYnaLB
         akx/k+BApsaIfNODruhf/B+dOMGvKrpeBdH/mtzYM32f1wLPPcy13Ek/KAMio/aLExb8
         sWNn7WKutiiu/ELEsg+sn9PJJjrMgnJCh5lD8/nnjoX3cfE7ohUIKPLnBlo/MmYOd33/
         tzYwdDPXc2YsAG6vh0diHqeiZjCTPlnBClWmHrPciPwg6LayjRZYJrMzdOFcKE5SYxvh
         UypHuhGPNFXwRSsj/ZgDPcmryVt6oXNMBJnMETkjzjQ9Qh3X6KvRfJpT0aBBFiD6JqfC
         Lbnw==
X-Forwarded-Encrypted: i=1; AFNElJ+ANQkorQk0dvWlY7YpMM/aeJbfQF/i2VrUcfJWx04YY6SkOAjy5Jmkcr7Ia2w7JA7TGn7gh/3vcs4UIponRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgJURYTEWiK6WQ7fbTJvX6tp8WIAbwj2/pfIrh8z0CcT4J6wa
	lZQ3GqCZRZCRkZnrBCg5uSF0Oi08Ffia6u4UIa8ghA46u5x6Hkxd4VLAu8/e/P9ujs0JnJG2eBH
	nfjbmBIdvaAgg3KDyTUg60M9JT6Kn95naC8UZvrOFF8eVr0xwb76jI9vIiYpluJQHyXxkzjdINN
	lsk8a3JtJAEAwYcY4gt6vTlZPfB+CMxiKeFHEnKkFHPCNV
X-Gm-Gg: Acq92OH8LUgKGIBduskRAc7qypPcNQSS4FxKLWfi2IQ+dU4FZaO0J5CrCRM+Stc0cfx
	2R7PFchfy4E9Qy87RXk8xyLkOTPlj+xcEcRskeUJSDAsFTGVajtevqGehuFiiEP8O+ABF8K0chn
	3BzJ3URI473bdoLtySHSZX4XgItv5CkbfBUU5W+f6QjjjDBjkmy4RuPKm/v29kei6e16aR7k6GJ
	1GbyxB732W9MOGHtPrFKx8hFNA44qHTKePzDiDSTNHdDhNlf7SkCBBkM+bSc0ox//wONQi0AbZ9
	N8U/B6MUp8YGcJf9urZK
X-Received: by 2002:a05:620a:4552:b0:916:1726:4893 with SMTP id af79cd13be357-9161bbfd132mr2043633385a.16.1781516013854;
        Mon, 15 Jun 2026 02:33:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4552:b0:916:1726:4893 with SMTP id
 af79cd13be357-9161bbfd132mr2043628485a.16.1781516013345; Mon, 15 Jun 2026
 02:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
 <20260612-block-as-nvmem-v5-5-95e0b30fff90@oss.qualcomm.com>
 <CAMRc=McQkLnz2OS2RREAbcrsp47cL-W3bCduq8LwPBBUcVNyJw@mail.gmail.com> <CAFEp6-0qsqhcwnSjm3=bG21jsCktzn5-L5sk2pNTZcGuVXaiNA@mail.gmail.com>
In-Reply-To: <CAFEp6-0qsqhcwnSjm3=bG21jsCktzn5-L5sk2pNTZcGuVXaiNA@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 11:33:22 +0200
X-Gm-Features: AVVi8CfBRys-DXFI5wrB8yqdywy7X_kfmKpyDKlwYIcwcR0i_tSHWZVN9l-o_rA
Message-ID: <CAFEp6-0oxBEdfH-fqhdM18pt4JewLwrMOON9qpQgLFh8KS0hDg@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] block: implement NVMEM provider
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
X-Proofpoint-ORIG-GUID: V62QTn7bPSmivhYR8ltSvyyxT-Xih8pp
X-Proofpoint-GUID: V62QTn7bPSmivhYR8ltSvyyxT-Xih8pp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEwMCBTYWx0ZWRfX/1wU+dUo8CWC
 T090zwC10aoGqg4AC8iA9oF+vxx2ByFn9Lz8D1qyE3XVIp7k16Shbo1faHq9D6w2iT2HcGAOVnk
 U1u5SqMj0MJtxX2R5+Alu0mfE9HBLGI=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2fc6ee cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8
 a=NvFwrZXXSFNSu_oYZZQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEwMCBTYWx0ZWRfXyk8sZiomzog+
 HGqSzsmcdXYgeR8+Gi9LwvP7ReaR1vU6dh9f3vfZZd1hXYgSROvx7MCH9m8NfppnM91YVTPYfzJ
 3P7/vJIRPKyld+5xlhwDXSnMnNvmzBUvAxRjgwqsGH4hD0HPrq5xX+Y+3PYfzxazz1IjqLoykEn
 oc4g4ekdh6CUKKfhErX/8CDelECmT/poWquqpomN9PMWRc6AsmV2H+5A8gbLh+RzwHMO8taoKV4
 UuyCPA9OG2/Dqm0/eijBQPO12y4GV4/5LScSUSVyTxMFB2NXuZA+lyzHlFo9nzrH7EwewgaGzIS
 xD20Ozv8mu5VhCgrVoAaBeWf5gdHLKfILzHeJgQi7EUkwyYHw+vzcZlQrlI0XZeOXFeM+sYkWGY
 lEHLtJNrMaqby3f3ha8480ekiwMDoDh9huAsL7lGrHqm41w+HYzmTvdi/ZwcLsrJeIP6V/q5k1g
 Qm3CDSv/neAIKPbOTxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150100
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37812-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.name:url,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,makrotopia.org:email,qualcomm.com:dkim,qualcomm.com:email,config.id:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,config.dev:url,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FF3B685161

On Mon, Jun 15, 2026 at 11:28=E2=80=AFAM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> On Mon, Jun 15, 2026 at 10:53=E2=80=AFAM Bartosz Golaszewski <brgl@kernel=
.org> wrote:
> >
> > On Fri, 12 Jun 2026 15:20:57 +0200, Loic Poulain
> > <loic.poulain@oss.qualcomm.com> said:
> > > From: Daniel Golle <daniel@makrotopia.org>
> > >
> > > On embedded devices using an eMMC it is common that one or more parti=
tions
> > > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEP=
ROM
> > > data. Allow referencing the partition in device tree for the kernel a=
nd
> > > Wi-Fi drivers accessing it via the NVMEM layer.
> > >
> > > For now, NVMEM is only registered for the whole disk block device, as=
 the
> > > OF node is currently only associated to it.
> > >
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> > >  block/Kconfig             |   9 ++++
> > >  block/Makefile            |   1 +
> > >  block/blk-nvmem.c         | 109 ++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  block/blk.h               |   8 ++++
> > >  block/genhd.c             |   4 ++
> > >  include/linux/blk_types.h |   3 ++
> > >  include/linux/blkdev.h    |   1 +
> > >  7 files changed, 135 insertions(+)
> > >
> > > diff --git a/block/Kconfig b/block/Kconfig
> > > index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc334736837=
06f75c92bdf8b648f7c 100644
> > > --- a/block/Kconfig
> > > +++ b/block/Kconfig
> > > @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
> > >         by falling back to the kernel crypto API when inline
> > >         encryption hardware is not present.
> > >
> > > +config BLK_NVMEM
> > > +     bool "Block device NVMEM provider"
> > > +     depends on OF
> > > +     depends on NVMEM
> > > +     help
> > > +       Allow block devices (or partitions) to act as NVMEM providers=
,
> > > +       typically used with eMMC to store MAC addresses or Wi-Fi
> > > +       calibration data on embedded devices.
> > > +
> > >  source "block/partitions/Kconfig"
> > >
> > >  config BLK_PM
> > > diff --git a/block/Makefile b/block/Makefile
> > > index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a88=
00ea266190a43b3e63d 100644
> > > --- a/block/Makefile
> > > +++ b/block/Makefile
> > > @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION) +=3D blk-crypto=
.o blk-crypto-profile.o \
> > >                                          blk-crypto-sysfs.o
> > >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) +=3D blk-crypto-fallbac=
k.o
> > >  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)        +=3D holder.o
> > > +obj-$(CONFIG_BLK_NVMEM)                +=3D blk-nvmem.o
> > > diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..c005f059d9fe56242ebae=
f9905673dff902b5686
> > > --- /dev/null
> > > +++ b/block/blk-nvmem.c
> > > @@ -0,0 +1,109 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * block device NVMEM provider
> > > + *
> > > + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.
> > > + *
> > > + * Useful on devices using a partition on an eMMC for MAC addresses =
or
> > > + * Wi-Fi calibration EEPROM data.
> > > + */
> > > +
> > > +#include <linux/file.h>
> > > +#include <linux/nvmem-provider.h>
> > > +#include <linux/nvmem-consumer.h>
> > > +#include <linux/of.h>
> > > +#include <linux/pagemap.h>
> > > +#include <linux/property.h>
> > > +
> > > +#include "blk.h"
> > > +
> > > +static int blk_nvmem_reg_read(void *priv, unsigned int from, void *v=
al, size_t bytes)
> > > +{
> > > +     blk_mode_t mode =3D BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> > > +     dev_t devt =3D (dev_t)(uintptr_t)priv;
> > > +     size_t bytes_left =3D bytes;
> > > +     loff_t pos =3D from;
> > > +     int ret =3D 0;
> > > +
> > > +     struct file *bdev_file __free(fput) =3D bdev_file_open_by_dev(d=
evt, mode, priv, NULL);
> > > +     if (IS_ERR(bdev_file))
> > > +             return PTR_ERR(bdev_file);
> > > +
> > > +     while (bytes_left) {
> > > +             pgoff_t f_index =3D pos >> PAGE_SHIFT;
> > > +             struct folio *folio;
> > > +             size_t folio_off;
> > > +             size_t to_read;
> > > +
> > > +             folio =3D read_mapping_folio(bdev_file->f_mapping, f_in=
dex, NULL);
> > > +             if (IS_ERR(folio)) {
> > > +                     ret =3D PTR_ERR(folio);
> > > +                     break;
> > > +             }
> > > +
> > > +             folio_off =3D offset_in_folio(folio, pos);
> > > +             to_read =3D min(bytes_left, folio_size(folio) - folio_o=
ff);
> > > +             memcpy_from_folio(val, folio, folio_off, to_read);
> > > +             pos +=3D to_read;
> > > +             bytes_left -=3D to_read;
> > > +             val +=3D to_read;
> > > +             folio_put(folio);
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +void blk_nvmem_add(struct block_device *bdev)
> > > +{
> > > +     struct device *dev =3D &bdev->bd_device;
> > > +     struct nvmem_config config =3D {};
> > > +
> > > +     /* skip devices which do not have a device tree node */
> > > +     if (!dev_of_node(dev))
> > > +             return;
> > > +
> > > +     /* skip devices without an nvmem layout defined */
> > > +     struct device_node *child __free(device_node) =3D
> > > +             of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
> > > +     if (!child)
> > > +             return;
> > > +
> > > +     /*
> > > +      * skip block device too large to be represented as NVMEM devic=
es,
> > > +      * the NVMEM reg_read callback uses an unsigned int offset
> > > +      */
> > > +     if (bdev_nr_bytes(bdev) > UINT_MAX) {
> > > +             dev_warn(dev, "block device too large to be an NVMEM pr=
ovider\n");
> > > +             return;
> > > +     }
> > > +
> > > +     config.id =3D NVMEM_DEVID_NONE;
> > > +     config.dev =3D dev;
> > > +     config.name =3D dev_name(dev);
> > > +     config.owner =3D THIS_MODULE;
> > > +     config.priv =3D (void *)(uintptr_t)dev->devt;
> > > +     config.reg_read =3D blk_nvmem_reg_read;
> > > +     config.size =3D bdev_nr_bytes(bdev);
> > > +     config.word_size =3D 1;
> > > +     config.stride =3D 1;
> > > +     config.read_only =3D true;
> > > +     config.root_only =3D true;
> > > +     config.ignore_wp =3D true;
> > > +     config.of_node =3D to_of_node(dev->fwnode);
> > > +
> > > +     bdev->bd_nvmem =3D nvmem_register(&config);
> > > +     if (IS_ERR(bdev->bd_nvmem)) {
> > > +             dev_err_probe(dev, PTR_ERR(bdev->bd_nvmem),
> > > +                           "Failed to register NVMEM device\n");
> >
> > Using dev_err_probe() only makes sense with a return value. Which makes=
 me
> > think: we won't retry this after a probe deferral. I think we should re=
turn
>
> Yes, so here with the nvmem fixed-layout, there is no way to get a
> deferred probe error, but better to be ready to handle this anyway.
>
> > int from this function just for this use-case. Also: if we *do* have
> > a layout, shouldn't we treat a failure to register the nvmem provider a=
s
> > a an error and propagate it up the stack?
>
> From an API perspective we should indeed return the error. From block
> core, Do we want to fail the entire disk addition just because the
> 'companion' NVMEM provider couldn't be registered, or should we only
> abort/return in case of EPROBE_DEFER?

Also we cannot safely return -EPROBE_DEFER from add_disk_final()
either. The NVMEM registration point is late in the sequence, too much
has already happened to easily unwind. The easiest is that the NVMEM
simply won't be available if registration fails, which looks
acceptable?

>
> >
> > > +             bdev->bd_nvmem =3D NULL;
> > > +     }
> > > +}
> > > +
> > > +void blk_nvmem_del(struct block_device *bdev)
> > > +{
> > > +     if (bdev->bd_nvmem)
> >
> > Nvmem core already performs a NULL check.
>
> Ok, thanks!
>
>
> >
> > > +             nvmem_unregister(bdev->bd_nvmem);
> > > +
> > > +     bdev->bd_nvmem =3D NULL;
> > > +}
> > > diff --git a/block/blk.h b/block/blk.h
> > > index ec4674cdf2ead4fd259ff5fc42401f591e684ee9..cd3c7ca723391c40be56f=
1dd4810e641b7c8a2b3 100644
> > > --- a/block/blk.h
> > > +++ b/block/blk.h
> > > @@ -757,4 +757,12 @@ static inline void blk_debugfs_unlock(struct req=
uest_queue *q,
> > >       memalloc_noio_restore(memflags);
> > >  }
> > >
> > > +#ifdef CONFIG_BLK_NVMEM
> > > +void blk_nvmem_add(struct block_device *bdev);
> > > +void blk_nvmem_del(struct block_device *bdev);
> > > +#else
> > > +static inline void blk_nvmem_add(struct block_device *bdev) {}
> > > +static inline void blk_nvmem_del(struct block_device *bdev) {}
> > > +#endif
> > > +
> > >  #endif /* BLK_INTERNAL_H */
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index 7d6854fd28e95ae9134309679a7c6a937f5b7db8..1b2382de6fb30c1e5f60f=
45c04dc03ed3bf5d5f2 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -421,6 +421,8 @@ static void add_disk_final(struct gendisk *disk)
> > >                */
> > >               dev_set_uevent_suppress(ddev, 0);
> > >               disk_uevent(disk, KOBJ_ADD);
> > > +
> > > +             blk_nvmem_add(disk->part0);
> > >       }
> > >
> > >       blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
> > > @@ -704,6 +706,8 @@ static void __del_gendisk(struct gendisk *disk)
> > >
> > >       disk_del_events(disk);
> > >
> > > +     blk_nvmem_del(disk->part0);
> > > +
> > >       /*
> > >        * Prevent new openers by unlinked the bdev inode.
> > >        */
> > > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > > index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..ace6f59b860d0813665b2=
f62a1c03a1f4be94059 100644
> > > --- a/include/linux/blk_types.h
> > > +++ b/include/linux/blk_types.h
> > > @@ -73,6 +73,9 @@ struct block_device {
> > >       int                     bd_writers;
> > >  #ifdef CONFIG_SECURITY
> > >       void                    *bd_security;
> > > +#endif
> > > +#ifdef CONFIG_BLK_NVMEM
> > > +     struct nvmem_device     *bd_nvmem;
> > >  #endif
> > >       /*
> > >        * keep this out-of-line as it's both big and not needed in the=
 fast
> > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > index 890128cdea1ce66863c5baa36f3b336ec4550807..f15d2b5bf9e4fd2368b8a=
70416a978e22c0d4333 100644
> > > --- a/include/linux/blkdev.h
> > > +++ b/include/linux/blkdev.h
> > > @@ -30,6 +30,7 @@
> > >
> > >  struct module;
> > >  struct request_queue;
> > > +struct nvmem_device;
> > >  struct elevator_queue;
> > >  struct blk_trace;
> > >  struct request;
> > >
> > > --
> > > 2.34.1
> > >
> > >
> >
> > I like this approach better than the previous one.
> >
> > Thanks,
> > Bartosz

