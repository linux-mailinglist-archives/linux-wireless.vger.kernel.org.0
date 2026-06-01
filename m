Return-Path: <linux-wireless+bounces-37226-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDb8BaH7HGrsUgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37226-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:25:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E56192FF
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2191D3027690
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 03:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB3C2376FD;
	Mon,  1 Jun 2026 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QH8QI07D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PW/ATQIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496A1F0E29
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284305; cv=none; b=I9KBH0/igSr1IhHiYTSJvPE4mSmww1Jen0Jv2g5uf2oM0W2aituYzj1AyuwOdbfHJMI2fSeFNFPAyAtVZXX1rzLwI/zze+hFWEcfPGJmG6WekFOXfthGCVQgds0HKXrhK3SGvN+QWpEypD8z6XkQiY8T+Z0Q51ldTQHl+f/j9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284305; c=relaxed/simple;
	bh=VP6sauZMZwXn4wNr4p0+pZ01/o15I4fRoix/G1TpgKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tfkes4EcEkIlTSZ+1/bEy5N+KDh4MRVer7v4qyoSUnn1sPzHgJ1giZlPogE35hQAQHuI0YK2qiv3pGfFTC73yN42xBsX0ARA95MDGaKnvtbFBZRSYcyp/btRBUxYzBa4W8E3lJ22R2MA6KIOBG1JDQFLIaDZqSe590Ybj/bGyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QH8QI07D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PW/ATQIa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VHFNiO2164759
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 03:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/JZ5XV2N5cB097839qKqC08HOp1yb7LqFEmLdGxS4dU=; b=QH8QI07DCs4ZZAJb
	AjC9H1rpICoohuuDzltFQCgTkh9khJo9+XOOIwU8iuWlYzAF4cS7UXFTxoG3ikPM
	kr7dWcOQuayaiTwvkUJJgN+BVOIJzEAK/Z+hwPdj/LROPEf5z3mtoNFjLvc3ui/3
	7J0bf92+YYvZrFLRseDYCnJy0AhgB8hDQ5yQdAP31evdRTTod4u4cnIbQB0pS3Q6
	MJIcq5IsOZa/N/C9cPMKcmyTH8lC8ArHZQYkZ75lC/HWyFDyeVAWTOasaKfoJ3rd
	KL3INfwklejBNxmAzOsyupb5ZzANPEst9pbltPRtGuiWo5uxsskJVCpdykqMxNWF
	s008aA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efxy7vq03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:25:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85a2bf5388so421573a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780284303; x=1780889103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JZ5XV2N5cB097839qKqC08HOp1yb7LqFEmLdGxS4dU=;
        b=PW/ATQIaPQwU0M1zYEN4y8rusr9ko9YS5//c1InT5PBQR3BZNfoyuoa5NMnTNeCACm
         xc0EpE/Egizd265lM+KeHQnxL8lMJjd5sjjQ8LkVGy/ZOvsyk2b3uMP6kqw9gnwa1cyz
         oBmEtgRV80Z27Tz2dCpLPZ/nUxaOSgD/7SGHT1h4MpRJWB3yRjBMbdSsh6z7mE4YgX4q
         JSQGsIvbiSHfomQbkLkz07vbPJKKhtlm0ryOsEK7x5rCFLEQjksYbrrR3mco/Vz/WoXz
         oh+NygQjvveGDFar/2Y3a2SWsm5+8j1fNplK2Zb4d5OTipg/mvqz1idQERS1VHIDBPjh
         rBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780284303; x=1780889103;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JZ5XV2N5cB097839qKqC08HOp1yb7LqFEmLdGxS4dU=;
        b=blenDwWH4VWVp2Y+iPJutJ/mY9fwT0VG/1POVixBgE/h/AJQQjy5ZdXEzyIqiaPbPd
         fjDURlJRIrTaBkiZgxAw0FbI06vCn5FasqgFFjv2yGF0BMGs5TfvNR11rcjiTygVRujl
         BOxQ1FY4WWNMYtej2b9eNHIYWYnQpmzVZVDAgwJIwCUxHeusnyQBB4afGgCcIMEMzUjK
         lBn4HrlDMkhQvdRM3wvyfQIUCnDYVZg7BKjTw5iD7iKkwialmiogCMTWbr2RP5lCrK8Z
         QAZEmWKr5VbXmLbhUTUIS/js9EYSPaH6Wbi2R3dvOfjk+BwZOB3TGWaE6Bu+YT47ZvPr
         94mw==
X-Forwarded-Encrypted: i=1; AFNElJ/7XcO+AFEddbrZyy/nMCikRE1+NfkPEN0llhV93jI1dekTeGk2DHi7MzXuQ68zP71wzEACR3SJ7YuJ4pXe3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAK3Z3JX+yvegRZzJhy2e8pN7/QKVILvgr78ohLBStjl+6nFqG
	ywiFArqNtUEj+svxdUhdR3FLebzWGybOcXyJBWzohtgpTyB+i8ULkdJUp4dvoRqq9htIprrG0ly
	Cuc+arTay8l1cQq0XIwpWV6VszapsumHAALMIpdkYjTF59726H16UdXBAkuPq6BN1OKyJeA==
X-Gm-Gg: Acq92OF0rq0AcN/O3NDWh+a7kPxnvGfkZQO69SwvT08rdGAXI8LVpT3p3E54qMVXk/h
	2NZppX0HBgsaSAcvlAd01Oq2rUZpZt0L2Fykw0wHr0VYhs5dkL+TH8lKr/Ap5mC//EafLKTU1L7
	emlMqrjjlYXltXdB/U1Fi4OE2mR0FplKaBnuAeOpcheyKYfh+Ce8Lk1D2bz1UuvKHzdT3uTAtkA
	mY0ZO8JiIItX9r5wUcW3FnlyMlc+yd1QekrOjCw9Or6me/OyxGeJCPFDCbLwVAakVx6NksglCOS
	tW16jU7u2lZA92SvD0HOlReWpX0FmBoLCnkOQgOyLNks6lHmQbtJ6T+0jOuriWci8v9BTLO6PUT
	cAvJ+uiZiIchtGJnNcu5vefIOdvTqzX9HdZ0jR7TAVceWsyMCh3vHAecgIX8ChBVjmYhGK/8LD8
	sNAtC2a5XNM/6z9utQaQo7rA4gk7rr
X-Received: by 2002:a05:6a00:1598:b0:842:3373:f65c with SMTP id d2e1a72fcca58-84233741221mr4676274b3a.15.1780284302910;
        Sun, 31 May 2026 20:25:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:1598:b0:842:3373:f65c with SMTP id d2e1a72fcca58-84233741221mr4676250b3a.15.1780284302455;
        Sun, 31 May 2026 20:25:02 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842263539a3sm6960360b3a.44.2026.05.31.20.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:25:02 -0700 (PDT)
Message-ID: <0c3a4a00-8d6d-4432-bc11-12d0c5742286@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:24:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260428205017.26288-1-rosenp@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428205017.26288-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POg/P/qC c=1 sm=1 tr=0 ts=6a1cfb8f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzMiBTYWx0ZWRfX9dsQZExuU8z3
 0foXGlwIs8usW0AASxYpHpcB/eVdaV/p7IKKCWucvLtJZ9U3dQbKOSMDQZ3mOl0droqDIUhn0ZO
 ac7gEcVRa8dnN/JyC6xD9/gYJrJbv0N9uC424Nt51FsPwBViKJhjB2jcHJR+qK/Q7tTl/KRRZLD
 M8qiJZAX3mLtzJYHQzZGqEGl6jyeXQ0qxqSvXsHMlWnB54SelhwmOkObj1MMtkuK+YjnftsEgTp
 YGTb+CLNm/6LbXKXBKVca98k+ITfZKwkuq7jptZd1DOu/93183FC6UC7QdGaf1lTOSe8BYwIe90
 Ur/7cE8JVXon0zqrrm5I8qODT6YCpCoIWZGOCIsPw/wyT79BVXXRQQhqk4QSu88S8Xfh9XKQMb8
 f6xdDxtWt5rAc3ANVduMtGljlwDhQrphmXgYiT9MFHGrPLqaw9P8WN7rr56wqA95RieSzS6kD15
 UDcdmqrFgB9rKgODlmA==
X-Proofpoint-ORIG-GUID: 67GRkmUqaGFY6YLaaWLaIsOb1jCzled1
X-Proofpoint-GUID: 67GRkmUqaGFY6YLaaWLaIsOb1jCzled1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010032
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-37226-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 604E56192FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/29/2026 4:50 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

