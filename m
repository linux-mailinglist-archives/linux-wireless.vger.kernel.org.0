Return-Path: <linux-wireless+bounces-39121-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SPk9HIfqVmqlCwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39121-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 04:03:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB8759FFF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 04:03:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FL0BpXOH;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Sk3xChSJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39121-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39121-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A12EC3018282
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E023A7F4A;
	Wed, 15 Jul 2026 02:03:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297739D6FA
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 02:03:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081027; cv=none; b=QDqTmQ4qZ1323UGaVO5imOephPC6A/i5WIHMHG/HuD6AqOWXMeZdzEfxes1T8SkVGUyO6z+iB9cO/JcJUxcNJoi2ThqlngazDgCNZhIwzn6sCTZzS/XvI68UVQeG5j4I6PsfL6hdehg8nCpOlWMrrrA4WifLDBshCKphGnsTrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081027; c=relaxed/simple;
	bh=DOizCFycxSE4gaw75Ag9W7ZrA9Bqh3jtlIBueFWxsvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJTED0NP7G1PaQO7Zo0devTSo78FMS/Jv1ShuL+h4h60U5lY11zoXYQici72eWR02r2aH58h2FaMSkI/yOdYhEtdR1bC1HH0nrlxppBjOTpoczQKkanb5CFhBmjxNB+huwBxUbrs+Qu3tHglLePH5gCTzI5O/4q9LDPtuuZQEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FL0BpXOH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sk3xChSJ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F0HwNh1921430
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 02:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t8fS1BDRuzXXVA2bJ29egzRQIfylg5yjs+J7PoBFZO4=; b=FL0BpXOHuXsC5spq
	8iRCBZXopVQXW2LLhZtikxlZ+ZZoY5v41pgoW/hIFaf/hQV0zYLFg53I1sSlV6pa
	clr5gVO72MuPt20IQ0P95QVcLOCOMDHGjoJsQnLGST0iiNMc7YTp5FP430QWYaaM
	jAlRfO2ha6ZOPU8ClVffI4Hngpif+onM12PAAxJYUzGGHjF/ZAe27ZN4ihb/nqzT
	OhZ3cmsQssIhALu/kptc2P3xs12pCc5XcuyB6IjvoiGQ3gu3Ivkkbx1Cq6P1mXAE
	Xfs1LZV5oa+Nqqt48jVyadjyC2aHf0VSp7cMG6YNIKHKtjat5Q4vldTGiVQvcI6/
	jJ7jzA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk2uur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 02:03:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848452dd146so4092999b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 19:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784081025; x=1784685825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8fS1BDRuzXXVA2bJ29egzRQIfylg5yjs+J7PoBFZO4=;
        b=Sk3xChSJjx7+19Y1DRN0sxwbFh6404Rpzz9izGkxfNkuOF0/6BhsGm0S2mZbmVocCB
         2t7acinpe1p+hIFV4qAhMxsbEn8FKnmfAA/mcQPa/WLVmP+nPfjPaH2ChSDFPRlfNaZG
         SIqJINcPhl67Pa4Iw/QqIuSs1kulr/WgJ6EcwzpC/q9S1E02hSfruxthSJV14ByGEtZV
         FkylKscJZb+rFvIW72Okp3Cc1e8q9XYoC9xiAjXpI9LNm83pFfdSR+X9LhqygUcWJHjg
         xFZCUy30emoI1M0MEWi8mTzm05/J+V5zhKhbpdgYA7KuNpzoW4BQoquUYTIFjC4ianU9
         eI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784081025; x=1784685825;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8fS1BDRuzXXVA2bJ29egzRQIfylg5yjs+J7PoBFZO4=;
        b=WEjhQ8h1gBxa1hf94bob0YnOUkQebPoPLIZxkHQ0WD+pvfz8rODYvQZsJevVaMp/gR
         dVXz+ZbN1glkvxQQEbhmfA7kVph/VE9NJxd0JVPhHqt4RQfzW003490YaGDLXo+u8ITD
         R4OWCZfnnd2NMjMfAVKac86F1m8o8IhHwQIrH6YvgnwqWNHzSx+UxoRP4XMMeIX7UcPZ
         VNMrmzxdGmiPPQeNOO95ITd/na2055KxZ/U6Nre4aeNf6vvLtp2an8Jrl7RGowa3xYPz
         lmkOcvbx6M7BjSLQhIcscUeDXz6du/Gfi0uGxQi2hIFy/C5pDr9Z39VuvKxga8LR7z0I
         /exw==
X-Forwarded-Encrypted: i=1; AHgh+RrSKRbDuXG3TSwgZY9cpwcVT9TvN4CRKRuHv3NyfLkqecnOBNp+DfO7w3VTRHA0WtgZq7zufwJkuJbaSDQM8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFow1ISZdsxKIZie3dHrfwwad9wsVN+8TkuUg+LrwzZNXF2qU
	7U56L2p8utn4FnuTPPRMwPNzRLzOfQ+lTHkRh3CtRe+oPaKX4k5bLVzlqv+tCgkMVoF8P3PKsh4
	MQo+rt8meamUtK6jT9W2KzSFgHcZaVjw+NPeBMdOrk5x+extZt8FCI3y56724uxc1tIs0ng==
X-Gm-Gg: AfdE7cnGzI5p/PUC4FHpM0wo1zhnUHRqjyP7cPStq/Lw2TNGrOzmrlmriIGSdKBuc7F
	O096ldG8zrx17tMeEov7oy9ZpJ/TWSpPzKcs8IKrRV1wSwA7hR8W19scm+BEG9lEvSw8MUo+kTo
	KSLpyJpR1pzYy42RHg4bygCWrjqRMfXi0owH/SchgC5O0PE3Y6/Za7XK86TL3MIZ/zARrG8L86g
	n9QoZ9r+pokbhzSQW02lKjzKm50snpGoKHDmv2j6jlSy9rxFtl61P3ROgZfyWk6LB0OqfqqhhO+
	IJ1gtfsTqQAv390ZpyxgHIMjZpajOFghZLdDAEq0R2D5X1pMu+l66nptciuVQjxIm13AmpnS5a2
	ERKungKci0MjLr2Pf66pW4QSmFr5XZM7Chp8762zm+RS7rEvcCmBnd60MHS9I+FzMGOLKfWcG9b
	TKtB7psDo=
X-Received: by 2002:a05:6a00:22ce:b0:847:8f0d:cc09 with SMTP id d2e1a72fcca58-8488970ab05mr14510495b3a.44.1784081024583;
        Tue, 14 Jul 2026 19:03:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:22ce:b0:847:8f0d:cc09 with SMTP id d2e1a72fcca58-8488970ab05mr14510481b3a.44.1784081024190;
        Tue, 14 Jul 2026 19:03:44 -0700 (PDT)
Received: from [10.133.33.98] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a5f3sm2224727b3a.5.2026.07.14.19.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 19:03:43 -0700 (PDT)
Message-ID: <5dc0bcac-82bc-4ab3-9b56-f8b670c250e3@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 10:03:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: Constify struct ath12k_dp_arch_ops
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <969d732e2c6f169e1aa5e89c7e01743a1adb55df.1784010931.git.christophe.jaillet@wanadoo.fr>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <969d732e2c6f169e1aa5e89c7e01743a1adb55df.1784010931.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8RJHIM-giNtcazp3nrfHlR3_2K924Jd5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxNyBTYWx0ZWRfX7GXA2Y4lTvr3
 mYbOL/ih4NabP2lZsqAKhe6qR9QG5cdq0XqUXwZMs/KMZMqoTkvo8fccfalGxBGttJ2V5X6q9hX
 m/nkK+DxbFA9oaaQ7bx7AL3+FGVj4YagIfTVNCG0tIe0YbIOpqEcGTVL0zoBI5lQL/ramBV6lj2
 B9zyIES3lxdramuH/SI68Q+qz0ecZlj+7s+UICQs2/jitpWE1esrS43LZUQEry/elEXR+zgZnch
 Uhy6B0ouPVICjBV0qW+GbGudfKdoDjCX7+aUXgd5kGj5Hyx64q3d5EenDqV0VqHPDt8uED+8gxt
 BRn07I4wwOMbK95vpiPzXVsiSXBJOofD4qRQLmchDiWbd6RxHEe9nxg6NMCTryQ7fCmlz/+lj0E
 JFA6qbwv0UvhxXSr2TPzAgm5nr/eWAMBi0qT+gFhgKZ7i5GlokUSjF24TjPq4qrUjpFaOaUIOyn
 OKRYH1QQCospOPGP2gA==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a56ea81 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=riUHQTvyFV0r_oIck2EA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 8RJHIM-giNtcazp3nrfHlR3_2K924Jd5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxNyBTYWx0ZWRfX1TkDstZX4qXY
 FvrQ5EZ136ZWe0kzTJp8iyzZosW3GSG++c6A/o9jz+AwloWossO+xlB8eU4yCHvXCICPr2UNHph
 OI8ktWDpJHbsQNXd3TUjmqJXczk6tmk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150017
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39121-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christophe.jaillet@wanadoo.fr,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1BB8759FFF



On 7/14/2026 4:39 PM, Christophe JAILLET wrote:
> 'struct ath12k_dp_arch_ops' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    6318	   3384	      0	   9702	   25e6	drivers/net/wireless/ath/ath12k/wifi7/dp.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    6478	   3224	      0	   9702	   25e6	drivers/net/wireless/ath/ath12k/wifi7/dp.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

