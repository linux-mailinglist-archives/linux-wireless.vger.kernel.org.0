Return-Path: <linux-wireless+bounces-31545-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLn2NjJ2g2mFmwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31545-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:39:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92238EA5F0
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4C09300DF70
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98348312815;
	Wed,  4 Feb 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B4jOanNw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DC+BTzSl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B103112B0
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223142; cv=none; b=AVQDCglkYLzTHMUa6Jgw36ED3/cf5jNAHZEn5xlZ9boYrRkVJa/hdLpyxB4gxnGQgpqllZxRbFXulRRAisSwHwNj2C22wXXoBFNta9d9gmgnBo9OFRaxCPoS6SzS+qkB9LIgB8aOG3e18b4KtoWxNPLW4jEBsdvJWtfHyGPxa84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223142; c=relaxed/simple;
	bh=wWI5AJlNAnvfz/taRLPRAZ7YALDyt2HLN/WrF2WY00A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGBzPuwgDsXCbbVGKz2togod29HxIbguRo1ugmnqBj0ul18lEZQy9ogtVL1wCfXhy7gVmgWGoXYkSHtfA9Tkj9aecJ4n0V9J04FHkjoCcZ2e0jUqan+RUdDBE58mBMUPkJlsyXp3rmY3hIlYU2hfxb3wmuKcoWUt9HUzp7AFO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4jOanNw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DC+BTzSl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CJ5Fm1033018
	for <linux-wireless@vger.kernel.org>; Wed, 4 Feb 2026 16:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWI5AJlNAnvfz/taRLPRAZ7YALDyt2HLN/WrF2WY00A=; b=B4jOanNwl41ERyxi
	fLnrU0piXao1XvKAxV9/HD5bZnyMofzj0isIFHDS27d/Bd1N+8/zGzSN8bDUmPRv
	OPW0uw1H6ekLbUQ7io9qQLbVyJkayXl+ZXQmBMg/eFhXWr/d+4PSerHxYgHMmnVW
	N5awcjA4Yd8tzctNv1pioVKX7eE2fuX6vYZxfxFBxHdJ/J3Iw1sPwFHt1+vcthFo
	J9GAN41sR81CEtLmsto05E+ZN4LnXV0v10Nwg0hd8UyRybEbnaA9Y4/fWN1xNKLf
	DUMwv/7f1HG6A2rkCbnZuff6Y7n1TMyibZTwFF2Q/WPdF22t5gAxkTAl4cydJQnG
	0KGeuQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ne7v2cx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 16:39:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b8295e5703so11165465eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770223139; x=1770827939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWI5AJlNAnvfz/taRLPRAZ7YALDyt2HLN/WrF2WY00A=;
        b=DC+BTzSlq9fU7ldwio5inbthuZh3kzWTKH0S1/2ImhlDAmLsPs9YYf3A7wlSEk0Oh6
         yhJXEw+cXWEjgp7Y/w6kPEWruWhEQG4UqtWGy7Iql3ht//2cYf1EiR17UnHlXp2wj4bl
         /KbTWljh2OyXudQwSnk/ESFz64rxkWIoif5E3FO1+qrALrJYJHEg2uuA99N33BDqsKZc
         uqFuNkbyT+yMgCRAk1Zm8MuOcP2LownKy9aWYwYhzkd2RU2YzxQGcLPaGrgkG+MeYQ9+
         Blu3hrKLCdRtTtS4fkAhBqxjbPzl/4j6UGBGP/iwtLrfYZouLrV9+4zUAw/WGykawyie
         0uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223139; x=1770827939;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWI5AJlNAnvfz/taRLPRAZ7YALDyt2HLN/WrF2WY00A=;
        b=AyRRwWWtb8fvke+rq91jv79n2lZW+USByAfb0W8Jd+RSapPUpvlGGmTDLjYysEaZ3T
         WMoDnDwv6LqzQ83/b8UzkaCrDUvsQORHhZNQqqnu4nY8Zf4NiiLqfiX050W4nWKKOpmp
         9h7tSRh4yB+jFdFx/DmNJc8ZxWJFiGZ0fFLOT8IkTNgw6an5UmFag8sXCsk2iBRJxtBB
         dBVcpzovvS+JgfVN3dDwUMGsfL/yEi1r1bBg34tqMBgJuCszW55UiluTOvvX4mt/bLNl
         6CH4uaTQ4lEkEuqKZWLXNgSD+rsQAVg0ysbLVAJH9yQqxe25ZQ4Y3fv1TdwpOa3/at3c
         UhkA==
X-Gm-Message-State: AOJu0YyJen+sKjZxtkbsdaCtkwTKEQLDIo7ebDuBriyhKZXqrCZUZXba
	4clMIeB1oZ14VVKL4J3B2xlCGtREAHd/IEse/0aP4ZX16b81ie64AG7JlGorcF/QKAeb8rtv/vY
	l9f7dAHwNcDG/Q1tZkU3u9cgx9qg97KO9m+v8oEk6lz0ypMz1WZqp4ApE0sFH7NIQQreh6i4c24
	ptSw==
X-Gm-Gg: AZuq6aKTVquvXvdIFm8Ajjlf+Dtc68X+lKZPiqxj7gJuIAYA1f/7rtzGC53flsKCW9H
	s6sc2fWdpzDxtFqKCGh56ZdP1Nc0499KpSvKkGcOj5U42QsTcJBDupm1+Nlbr0o1VTFwsT30RQB
	Sqy0EMtWGmCWlQFqFvqX/f/LpjF1sC6w6qGahtCyyCOe53pNV/S8WzcMZEr2bQ12AzpMQubJc0z
	YU2ciyNxdS2Be1UsTfKqqPGJgwndSUg2+dgODwoCTkCp1rhzvhUWh19IxegIbFBMNi2807F4S48
	dGmpFkYSW0jZLz9wFfdpRCmpxF3yJk99MHJCRZWLNaRoWxICeOkv7YVeiG+Evzicwx+aZ5ayAJA
	/DmqDB+5BSWdOh3ATTbEhhsGQKzq+3gODhUGcGYHzRVRGh7LGHf5uzEBDJ8DeA/+GqrQzug==
X-Received: by 2002:a05:7300:e613:b0:2ae:5a13:97d8 with SMTP id 5a478bee46e88-2b8329901e3mr1478769eec.14.1770223139384;
        Wed, 04 Feb 2026 08:38:59 -0800 (PST)
X-Received: by 2002:a05:7300:e613:b0:2ae:5a13:97d8 with SMTP id 5a478bee46e88-2b8329901e3mr1478753eec.14.1770223138807;
        Wed, 04 Feb 2026 08:38:58 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832faea55sm1849503eec.23.2026.02.04.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:38:58 -0800 (PST)
Message-ID: <876f4ba1-7bee-422a-8f5a-b9ea56dddbcd@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 08:38:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential firmware selection issue with QCNFA765 on ThinkPad P14s
 Gen 5
To: Mohamed Sallam <sallamx99@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <CALOnm7APGpVWcx45O78fa4hOCUGDc0-ywGoqicr51YtpxNueLg@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CALOnm7APGpVWcx45O78fa4hOCUGDc0-ywGoqicr51YtpxNueLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R3uyMZe_7-iZSUnpauit8N0suCXbrNiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfX0jjqUNv7/rkU
 wUb3ZCCtVcLSQzvwjCYq3rMb2y9YpbWsv3DYoviSBbrHvjjRps9hI0RPkMDIVtq6UNCr+sP3QMP
 7+qUq6tSArbxlJP3XLMX6f8FtqifNQ2ajxSDeB6z4gZX1E7jtB4u7SNAFkcwVksy8apevxEK0w9
 r2wyjWPaMo+SMUjmMqkChyBSxlZfKwGaqVSlfEUrTBT8EZsnaNb0hyBJleKSDDQhbZeYYWRZKFw
 +mWXMFRK6Mruc/BHmH8MG+ml5q3ZCPq+YwPWl4csQfYnln8SBbTy0i1XpFrE+WIFvt80GzpmDHu
 OFPcxuczts8EyzZrLfppCdQwNNZChmurvpKGM6SRnKZidQUXjyOtVYtVhjAaI5jQ9PY4XZ/VbOu
 GJKm4HY59CZFhD16ceWsAjjn/ufmg6MUWk4dVs+DhuiQWv0Cvwsz6frxaFZlgU0VHKCjfMux42b
 pPcfy+Uxn4iqEP0niZQ==
X-Authority-Analysis: v=2.4 cv=TZmbdBQh c=1 sm=1 tr=0 ts=69837625 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=B7CBbNVz23hr-bkFT78A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: R3uyMZe_7-iZSUnpauit8N0suCXbrNiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31545-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 92238EA5F0
X-Rspamd-Action: no action

On 2/3/2026 10:54 AM, Mohamed Sallam wrote:
> While trying to understand why this happens, I discovered that the
> linux-firmware package contains two different firmware files:
> - Generic: ath11k/WCN6855/hw2.0/amss.bin
> - Card-specific: ath11k/WCN6855/hw2.0/nfa765/amss.bin

In addition to what Baochen already said, I just want to point out that this
NFA765-specific firmware is meant for Internet of Everything (IOE) devices.
This can be observed by the firmware version containing
QCAHSPSWPL_V1_V2_SILICONZ_IOE vs QCAHSPSWPL_V1_V2_SILICONZ_LITE.

The generic firmware is the correct firmware for your device, and Baochen and
team and working to fix that firmware for your issue.

/jeff

