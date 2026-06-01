Return-Path: <linux-wireless+bounces-37278-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKL9G5O7HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37278-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:04:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A2622FDC
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C110D309003A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23A3DC4CD;
	Mon,  1 Jun 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oIncV8m6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijF4qkc7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAB3DC87B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333246; cv=none; b=lW8Qmy+YmscmG4daJ+788V9efnDkoAZEba7SBbKFmEHM5MbfINVF278vigRh8hWY8eXOpX0sHXMKzlNM3PaP9k0ZkzDh/8lvEQGqVg4zd0wHYMHZ82WFUvGHUP0ALm3GecG2sh0FlfNJV7timncZggRZ9AKBp9E/1CCLq4rFqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333246; c=relaxed/simple;
	bh=RmuZu27Gr/YeewShsAyXVe+rVaA6Lj3GL7/OzkOJSqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Irsf8WqbB3B7dtLhhH15lv2ANZD9bsb1ThthOoIq4n+uFE/FgRM17Oxd0Mro1eI7kRZfr4+E2SLdtEJCjgD7h9tZRdKU9xWdc9JGxHzbwwe7ecvbeAKThpCd9V1XP9SqDeAmLg9NIvzLGyPWBNpfFLIGFg8CF9ju48tqT3iHhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oIncV8m6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ijF4qkc7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Cc2QH599934
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FAOgfTX0ZXEg/9rO//hmM7gg/rhaqzOrUYfPhNUPPOc=; b=oIncV8m60L7rIa2r
	IwN+m8ywEJFnNEMtscAL20hVb4KXQSKTaM/YoXIYoPT9fsJUOofdpJeDrtyrJBpj
	9fyhe7pDsE5kjiNfb4P/RmZ/O/5/VFfixpISS33mIFoaGYGEvjzCOQpJmAzVB1gD
	ixFjUQFcSVQHrE/DIrmt3PKP3ogMJs5gM7ABJSecvt9vtAvoym3An7vztnFEBmKI
	LEaCuLvq6+ssw6vUcKhGKeTZQIBEejVfxLVo1s52MutYy4mAsB/ppDNAgbOaj2u5
	EvzJTCh7crhw2yP7f9PcHNiUih1FRjs4BDGRz8V7ebWjayyDTGtn0N9wnlfKD+3G
	EtGS6g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eha8r9567-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:41 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-135de949041so18176761c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333241; x=1780938041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAOgfTX0ZXEg/9rO//hmM7gg/rhaqzOrUYfPhNUPPOc=;
        b=ijF4qkc78fpTNbCLHOS5Q/XURPkoVjf6Ylhh+CV6Px5Nd8r9bESUnYBTrsnxOhngta
         GCUnUYFgWDEeH5iEqTr+q+8wOp59eyZ9Y4HZc11nzY4f1ycW3H4uKYkVIwqZAtXEQZ8P
         oKzwAaYnWfgltKucrUpK2lJsOQiG3hq6wsMjjDIGue5GBNl7gfvCyo8rjSMmrh37RHzb
         D5NmJPtLtEESqXrOCs49ZcuKT1OJd3IuA6q3I6I2/B4ri22okMVmmhastbtLbbpvbR6F
         xrGiOo9idPStEtTdFtO9bMYw9uoCbrfGKZRjrtJll4OjxopSfPHUYt/3mRH9+8WU7Txu
         h5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333241; x=1780938041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAOgfTX0ZXEg/9rO//hmM7gg/rhaqzOrUYfPhNUPPOc=;
        b=kfMXf2+F0hfwcRA1kZQx9ynLT7fpyJejpXx+CStg5KhlFhdcxW2GF0y2DhpPwsZpLy
         j+zelwRzz5D0yny0A8rxA2fsmB+BV8TZlHJ0QRi/yF9hnO1BJoSPFkxTbk4nib96rpLg
         MXnOcmbJmacXpx1hYeJfR9mwSwf6h0qkQTctnGmgA69djXcCuA50EH6J/PSXs5zaiQ2z
         TU6pJjkOXRddA1p5/ePhF7a1tpK7YRhoz/fYZfHmqosNAUcweDfsp/SeYLbpyC0eXRS2
         673X5ICzY2pTyiJAkVJWA2ZDY0Nll9Kdeg89kz/zHu/d1UGZlfNKFIak0ZNBouLLYPN8
         FIvQ==
X-Gm-Message-State: AOJu0YxulrI9XSLqso1Z7oWHVNJbSVl9Hl+5++I0tfi9kvzvcVyXqvNc
	h5Oz0nN/Dq5+xZeNlwf70lLROdnJTBy0VU/6JpEpbizmOlJvlpbrwYmz3YHXIVzv6MaiYZvKXwt
	n1V4gFzHMXTTQa6GLYCapBU4mTPy7cCDeRLM0YmODf0tgCcMKRyg53Qa44lSNccj5p3E1pSuYBX
	NEDg==
X-Gm-Gg: Acq92OHXVpkr7pbgNkVXeMKrKZDrIMClAQwnA+Ij+ZJ22vKP775YosH+auCK6XCBRJL
	Tr7eUOvlxyipCYlgo0kwXfhzH5G76fY64BAmURJYpfjvdl96suRkJOTqYEsE+4Owt2cHUkM9byF
	TI/u/BxrtVRLpvhg8TD/1tvKGtHs5yd33eyqcb2b7dlocTZgFeBxi6BCoGOeOHh0eM66b+2RrM2
	cpOF0Q530E/6ctsxNFR/0gqxb3IXezdKAu+uPD1ougYqOnLbzGv3PF6J8MWMGFxOASlGbHP3gvb
	EyQK1XWP27MSJCvxLZhgHG5txDJSluAkUtaKae/ekfubYl+gx/ebyNJtEhLDlMnVyrmxYjj+ifk
	nO0Xi4ZPViRZLp8gE5MOvo7nVSvykbMGpZE2cVii0x5m2+Au3jdS9hVAS6ubppRr6JvIf07i3Cs
	5lF0b4zsD5/AY=
X-Received: by 2002:a05:7022:1283:b0:135:5d4b:2096 with SMTP id a92af1059eb24-137d4248a37mr4367924c88.36.1780333239593;
        Mon, 01 Jun 2026 10:00:39 -0700 (PDT)
X-Received: by 2002:a05:7022:1283:b0:135:5d4b:2096 with SMTP id a92af1059eb24-137d4248a37mr4367889c88.36.1780333238725;
        Mon, 01 Jun 2026 10:00:38 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:37 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260515030909.3312511-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260515030909.3312511-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: add hardware parameters for
 maximum supported clients
Message-Id: <178033323771.2045173.15638151631566522553.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=aKnAb79m c=1 sm=1 tr=0 ts=6a1dbab9 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7rVGOa9o2cc1vntXQDUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: Ie8q8YuFr4bNP6TQuP0bxIfGI7MKSDy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfX3qOfraGtIG4u
 JUl8cvvZdtQ/bX6lxsQTCN7puSoOvRloDCQhu0Yru1SzKhkQMrXGzTS+JmA3CZV8cbGBXm0RrSV
 C5XaFi2Z6xex7EAIQ0ykKaPtMPXVQpIDF1ALIdRA5Jmezu9Gq6W0dUDPldz5AYb2oPgx59w2fI9
 4K/wvxINEN26bTQb7EgfvAddpOyMNVQlfHbF6/qWWP1aBqToypTrfNPYpr2J3G0qp5IITFFNe4c
 HmHZPpMXnAWv3fqUD4p9lKQ4JOIE9oik8kgGFe4P3t+r3LM2opO+D9Rd/hL9eVrzLLmKU5+zoUX
 QPhSLR2t3ktd7BcSPtA1yPGCkYCxTY1V2VnZW1EiIg1e1Fy9DBgLXID/FM94fLZsuGelM4Pwpvv
 G41o9szTOc/LmGOjNy+eb6qu2Uquq4Y1BNUs5VdpK0m6kyouATpUIq5coAm9hDWB49CvBjuN66s
 AD/Cb1sjufHDgVQJBEg==
X-Proofpoint-ORIG-GUID: Ie8q8YuFr4bNP6TQuP0bxIfGI7MKSDy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37278-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E02A2622FDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 15 May 2026 08:39:09 +0530, Aaradhana Sahu wrote:
> Currently, the driver uses memory profile parameters to determine the
> maximum number of supported clients, with a default limit of 512 for
> single-radio and 128 for DBS and DBS+SBS configurations. However,
> some devices have lower hardware limits depending on the radio
> configuration. Exceeding these hardware-specific limits can lead to
> firmware crashes.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add hardware parameters for maximum supported clients
      commit: 05337d0b9c5a7ab3b60473490705ebe90d5316aa

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


