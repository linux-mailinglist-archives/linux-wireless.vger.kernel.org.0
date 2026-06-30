Return-Path: <linux-wireless+bounces-38405-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ADoSFi81RGooqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38405-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:29:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 987CE6E825A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=VePcXhA7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=SQwzuNLU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38405-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38405-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB4B302E909
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414892F6918;
	Tue, 30 Jun 2026 21:26:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F992D5C7A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854781; cv=none; b=urAE/f+Zx3pQ2aPU7DUN2qPTyzvpys5hSsmhXjWQK18jBFQvppt76Xv53JSHIJfXUeKeCv+R8K8aaUxBNB3XUkcIqlUupWJ6wqIpqE/UT7hPvPn4WEBmNLMvXrM7tpy0AeS/8W2S9t4+/h5vScxVJ9pfCu/8GhF+2ipqlJDs5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854781; c=relaxed/simple;
	bh=1pqk3L2WY+uODSZiUulQGxMNryZE3Qx766dgTdyg6tM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TeN/iIWttBOrnOKDMWguOXaXvdNfiQcIeTYbWmHqWrKwCpGGPoDakPfMedxWvJqvTjcViZQza0KWJKeR8a2BEtgq9iqlplwYXmkpG34En8yrqeL3urpYGJA1REoJCOVi8Sp94V2KR8RvoHqxzWFKrQAIg2t0MnlhwBiA8z6rxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VePcXhA7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQwzuNLU; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDjLM2879936
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fv6pA3vNYZKLjwqhVP/KU778A/Sy7FvGxJvop3xJ8aU=; b=VePcXhA7rTOqI4Fw
	hfJ2TZxrHv5FAMjWvogqvarjFkcJAsaFI6gP2oH2apwmJ47aZHxUBbArGVdTW1Ek
	nTG5/otaNpA/EqrtglPrERHiGqgRvHXtvYQan39wU7Di68o9d75NIqYKsSU2Wp2e
	mJjbvGWvBXH1J9Qxc+opseNIJajYmLlsffAmqEIj2AKrgxrW6NHyQK9Sbnwg5+y6
	SDbuKC1mRomeFb5XaHXMV7KJh+Q0hhreXeqnc1bfN6m7JiozHuzWLs18LC9D1K1S
	YR0ARIbUj66ErMAi4bMnKLLIehmhJnLifY2Bl+xnAlWtp4HAL+ZNDbVdiIlrWJ/j
	9La9xw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfy98yj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ca3374c6aso578344eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854778; x=1783459578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv6pA3vNYZKLjwqhVP/KU778A/Sy7FvGxJvop3xJ8aU=;
        b=SQwzuNLUVPuHaQrUbA2pMim5TnutXHJrWl+nU9FO4Vvol6DMvnq0yAKWfS7yLTOgo7
         0ud9dDOgL9FDbzNd7fQ7Fo/KBqR54w4DBh4zIuj5pYqmM1N6Yx1IKNy904GPDc+xFt4X
         KgzRVeWamtNW7brlE9m/mnBOyC5MfKmEPOupG3JPQT2iSjJPoZeFYgcTb8g3L4KuXEDp
         AIGkPpU2yc1okVOz1oMfnHl0D85fjXAkKc9h1a5cJKV6AS40r5NUckg8I78JYBWZT/MX
         p28yVhb7pSzYfdLke1Nvmt9KbYZs3f/uc0rCVSINhbd3109Z6ek8cBC+DOclLY9SU4yg
         IXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854778; x=1783459578;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fv6pA3vNYZKLjwqhVP/KU778A/Sy7FvGxJvop3xJ8aU=;
        b=HAzO2fP2MBhT8usFNUAi/w1546rKuUt4tRXHTF5WEQ9vbwPQOcXRZx9tbRIOvtWIX4
         FTY8a6PVM/LPIj0aw06CN4HDNiljtzkKZ4+vH1oZRLiI4ZTZRJFR8Xfk/H5SqCg+o2in
         QV2uaTQm/Fc326hpSL7bVzLg/bVXpPEAqyrh8+yCp2QWy0jETei2q3plvlh9x8sRWuyN
         2YvBXjJTYaNnza/v6E2Y+brjTq1aB43zzVwBOpDtcjvireH3s/Bvf2Ci7J8D9OhNH1Lg
         JqYAA5148Fx/XBzBiAmtdgnDziOZAJJ/1pfXXQ4hosZ4Eow+TwwfXb52FmnEujq5DGKa
         EbAw==
X-Gm-Message-State: AOJu0YwfexxfD48g6GdCIEuVOZRQAtJdwMJH/3tKX0etAgxx3WecSDQd
	/jETR6oXGMfHkfz7jd8krFqTq2oCqXbRoLpqtYCPuOWU0J4OSsTil1/HZQ9HknxP5Bq5lKy+NNN
	ZdzxP0rteLsN1dEeeYbPpqQW2K3nfFo6nOX4bVzRzWoUGehY8u86AwD3eUZ1sfks/Hkhoew==
X-Gm-Gg: AfdE7cmiSWy6HbO5LcSobdgt8hqjI1xBl1SoGsKeiF7itm+SKyrV+INSraa36fZdXHm
	1+YHvj0fUO6N0XH8mdjRV3PfHS5bVxq3ILTNolMVl8GbSQHGItzZAbBfTX1pB5fS/U5rQ5YR3Em
	FV9XjFQzD4j3SZVcJN2hx/Ligsi4tS6cZ08LwywLNtbKIJkZJ1cfhD1hjXLkboJAE3/H17n5JQm
	RcWAmjseh8x9exlRhOP4OqOvymymZdQtQFoaNiK7h7ZhX7bQZ0aStCmljcWYOYS/nHNXtEUkCXH
	7vjLFWYvyFq7DpGXqMDGw6hb17iWGp9bSQJlhP00D0NzG3stCH3sUZoz3wRx4cmVJKQCpmRSjhT
	BRBBzpdponI8M3Tbp6Wri4JGAhCy6iuBT2Sk9kFzZjaffx4A3WLWCBIpRO+OKAZP/rA==
X-Received: by 2002:a05:7300:2325:b0:30e:d236:57b5 with SMTP id 5a478bee46e88-30ee128cd0fmr4512368eec.16.1782854777914;
        Tue, 30 Jun 2026 14:26:17 -0700 (PDT)
X-Received: by 2002:a05:7300:2325:b0:30e:d236:57b5 with SMTP id 5a478bee46e88-30ee128cd0fmr4512346eec.16.1782854777388;
        Tue, 30 Jun 2026 14:26:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:16 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
References: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 0/2] genirq/ath12k: fallback to threaded NAPI
 when IRQ affinity is unavailable
Message-Id: <178285477658.1590147.549685497846838720.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a44347a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=9_3RmCN_obsrxBC78ikA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: vMdGaCd3jfZi6gKXBByt9dIRpOON0hs8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX3LHik1/IRkdm
 mWd42D85Q/3tOCSLo4Jnspr++Ubg5wBgG4hvf+VjQe3FsbI82JRzB/I5T+/Neoc9RICHSouhi4x
 Zrg8278vasC0kwQ+QWaGE3DkxTsVKj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX5GK3mpAG9XVw
 m/BW6GNuyLxrqn5CdlvC6nVLEejSoNe/VOVpLVaxLLooj5f1jgXkAH0lxAKPkTDBwih9JrvcNMT
 /Gb3OGMX7XHcL9Ytasn9DH8ht6t0ErvslWSZGCNl+DcfN1ZcKSUdJtqcphV4/mfKy+5mALW9HGQ
 lslRcxskTtEYfREMTf8qLwDvSHHict49Gz2AGfbYQ4qGMef/LnUsCJE1+v1GMwHC3l7lOCrZfwx
 6dhuiFGEsld0gOyYP50ajNp8z5sY1EIAjKfmglKotrRco+Oq07Ob1TQTvJuXV0kcirHckWdfG73
 FWye+jzRRCp+RSVac40td2MQAbB5ewHQZdWsK4kTQoRXHlIZZ6cU/fOMQGMnaD+V30SSezaOBOP
 vkTcxpw+ba4lYm+YJauuspxUDTsR3u60+IoG49PMRC4X3IqQRX70I8VxYWgZ1MouO9HX3c9ERlv
 mbP9HgnP1eImGywn+DQ==
X-Proofpoint-GUID: vMdGaCd3jfZi6gKXBByt9dIRpOON0hs8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38405-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:jjohnson@kernel.org,m:hangtian.zhu@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 987CE6E825A


On Tue, 19 May 2026 09:16:25 +0800, Hangtian Zhu wrote:
> This series improves ath12k datapath behavior on platforms where the
> effective IRQ path for WLAN MSI interrupts does not support affinity
> setting.
> 
> In such setups, DP processing cannot be distributed as intended and can
> become CPU-constrained. The ath12k change switches to threaded NAPI when
> runtime IRQ capability indicates affinity is unavailable.
> 
> [...]

Applied, thanks!

[1/2] genirq: export irq_can_set_affinity() for module drivers
      commit: 25e638447e329f08febae2b64c7f85b3bb95e998
[2/2] wifi: ath12k: enable threaded NAPI when DP IRQ affinity is unavailable
      commit: 74e1a4762c79a2d6879495d83f22b83acc4dae33

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


