Return-Path: <linux-wireless+bounces-35919-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM2PG6MJ+mlsIgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35919-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 17:15:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE154D013E
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 17:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A8743065242
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98CA481643;
	Tue,  5 May 2026 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Of5DWpmU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZaJ4b5wy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69924480974
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994012; cv=none; b=lFb/KHKj0LKyXvwZ5Ws3Nck4Xltoh/p7WXyd5pl9268E7V+Cy6grtfCnujNl7FAgUkXVmC0GjxhdgZugZ5JBtyrViBGWKZHBOwqXuTrR2f7oMGB+F4mpIFP6/waCY3GmBTSOT4XcNkE93M4uISKCyvUZ6FIoWe4hdWvI3ZU4JIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994012; c=relaxed/simple;
	bh=hBGq+iSeOOoyUIc/hruo2J+FTWAdTuqwVVIYM/toYeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ope0jHyN/9aDrTewvnuP6SCrnFangMIX/45YFAZZAmtN8SKOcAW68cfveavxScweNs2kb3TDYz6M30dzvjjrlgCHX6dUuLGIwcLxD4J68BFwm3NLQFuefj7j9uTEe6EVqtVEQUsyr1o1e3CoNKxn/a0pWfudNPantb1TBNQWJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Of5DWpmU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZaJ4b5wy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645B6cte3091579
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 15:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ME+2IvQ93Wmyp8JC+wtfoAQTygt6CnvvUExOdXpk9s4=; b=Of5DWpmUHuzUUhQ5
	WahggQvtbEdvtgJBO7dEdVI/+ut5/N3BrEpQitYJHZ+iBfsDSi25RR/hpKjpkV75
	aeTqdgCicIKDvPEyJIpwzUFLM/Wvd7Y1KcuSWqJ+ibtSSov3deMZjzUogUbRGUIe
	wdWSnqpPUpLhsCVuNtFCnrtC0mt7E+poOPAjf3m0fSV+DdjdBcxOosYhk4/yIE6n
	yFUBkytfR6b6aUydFimUJFnkXHvWpngZ+b9miGtSAtvAl4OZBrGPoIFiIF7ERp6S
	TTurndtwQtNk/magap/0V9UMnmg70fByNXB7zNibcVc8f7gi4B8jbPV4SfZRh3yV
	0roYaw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyfct0wqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 15:13:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12dfdde7ce7so18591572c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777994009; x=1778598809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ME+2IvQ93Wmyp8JC+wtfoAQTygt6CnvvUExOdXpk9s4=;
        b=ZaJ4b5wyQVwbJRCwTNkvjyYgA91Ntr1P28HbBvl9rICZwS6vJKJANYBfAbGUbjvqEv
         LD/xtkzzRbOzfrCFbX8qSaEhkbXRGXKdyAIkVNu+7X69e13gxlVvum2egqZVdJA9WBSe
         UCVj5LeAO/yVqhj3DJCXh0+802WepIvFeQNXz6uaXxATDvYHOP5GL7zkA/VmeWVQwSIQ
         xD+8pQiQs2JRHoTWMSNSDsHym231wwLGOFUr4E4FZCLTf0+s5qiYhS/5DtZqs68Fq57S
         b0h8VwjD8XvlfGlvuAjqrs8QO1ZeAjpBV+OCwlaXG3TRW5nls5roH2xxSMG0F9rOdytO
         Fp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777994009; x=1778598809;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ME+2IvQ93Wmyp8JC+wtfoAQTygt6CnvvUExOdXpk9s4=;
        b=m91gf0t5tTM0yyqUS69Et+XgRTNGTA+PQUeR7O/xrbfUmrIt0fI1pTQDJE2sRfBsUj
         LOagc2caMjdEFurh+fPYU7rrTeE1U2jn2IN7eg7+u0gZEkOXgdEkQPobugN4yT/xz6v2
         r+zTxXnkgpTrSTZijuFOxtJGQFh03OwrSysFfhqCIjxVdVWFXJc0D1MdP+Kd3oCXcckS
         6hB323NFP0byvlOLKQ2dkA6JOWksAFLvSYpDYOF6JD2UTqELwmct8HGnmM5fw15UY2Uj
         aMflRnH1TFH77W2OZgw0PacpzEIzc7TDJAPvRJv8c0jtWgdDKaxB5+yJtdoJyxSoe9q3
         TxZQ==
X-Gm-Message-State: AOJu0YwPB4HZJ7PfcZ6/R96BUY/amEX2FwBFG5zd+35zY6bNM4LnLdiI
	z9esr51QwY7g9ErJEaEiBLBvtcLmKJ2MAWAf2rMR/J2w283rjubYP9ZvOUtiTPf1FMkrNidJ9Dh
	28+lE6vskfZBxs3GA1QBxN9w4KZr/7hraKVDwUIt9g2qfpup1j37PGqZDjQnlu0UX13+E5g==
X-Gm-Gg: AeBDievmeVTNuwajGYI90LdOf2zbnoUXN7ewmrZgXebnqxsiZC80ltNI7j7/jHtzM5j
	SCiYbrgink8kQDOkZyVufjvBSySYVg+x5tGunsV328Ip6tae7PekSpO04LMWJHzUbVxnzfJutzt
	xmWm5JdyYzzNVJPeCCqm6GIUIxhiJvJ4MtqncChBa8Nr1oGca94E2MUJrNO8Uc2WmmkRoa2grcv
	69wX2g+FR7zDYINUpB0OHvcSacACUKeWjLW54GRN4AaNec1njsKOdHaJguiCjTU+ExUKK/WCEri
	CBhDhUf0ot3N+A5a28RsahjmCn5vofOo6/54g0po+xHXiL0MvIL2X1nmbqyXbp3MQqL/6pL5BIN
	ZlKSQeNI80z/D/WSxswBA1HebJB5TfZqx2M8wKDvYHZ4MTNQQsuxeDtOe2CaQDYRCQ7YTJgDbbQ
	5rG/CShzcl/PxcgBHZ
X-Received: by 2002:a05:7022:41a1:b0:12c:14df:a510 with SMTP id a92af1059eb24-12dfd849895mr6057472c88.28.1777994008498;
        Tue, 05 May 2026 08:13:28 -0700 (PDT)
X-Received: by 2002:a05:7022:41a1:b0:12c:14df:a510 with SMTP id a92af1059eb24-12dfd849895mr6057450c88.28.1777994007948;
        Tue, 05 May 2026 08:13:27 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8288c07sm21714530c88.6.2026.05.05.08.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 08:13:26 -0700 (PDT)
Message-ID: <693b4d59-d92f-4c07-b060-1c520419e181@oss.qualcomm.com>
Date: Tue, 5 May 2026 08:13:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
To: Willmar Knikker <willmar@met-dubbel-l.nl>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260505143025.234292-1-willmar@met-dubbel-l.nl>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505143025.234292-1-willmar@met-dubbel-l.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9vzFaF1zDv-BWnHcwvBJ_JuoBCOctHzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0NiBTYWx0ZWRfX5gWcBge4UqZE
 +K7PDxTMYT3y9xv1ik0ZRFYpfbLJXHYymwuuR6JZjmc82P2nuD1KvUbBZ9q3/rn8Srah27/sOib
 tMxjZeKg1iA4yyKOp5DjVh5WBuZB0BLFAZeUd9Ek/5MLTQiEJq8fRzw/PHvHKPpiZBmu70LAsrn
 lgV9bYFZ8BeSmZku7E/SXcLVj9rp8yqTF8yn71Otbe4e73qvTAvwI7wcyfk+xOO6XCcte9GCfU4
 lswGfCpPx43RIly8aluygVFRQNWwgrPak++j7dFtUhbnJFg3nVALeBXfsRtV+z7FcL1GJsE2rd4
 zt+hNlA/MxAst4xa+QUX0LFm8poqEweLXC6qQbBF2nGtbBBSXvMXrod+KpMqG8BoL89f6xz2Gp1
 pCo1bF5bfEXlsGxIgDvQpUMV4GZyhGhkFtz41lpLGDkWNnFLiKM2oF9Nu2Q+yIbV0rAQTL2Mhfv
 AD8pDCGSVNYs10N1fyg==
X-Proofpoint-ORIG-GUID: 9vzFaF1zDv-BWnHcwvBJ_JuoBCOctHzf
X-Authority-Analysis: v=2.4 cv=NtXhtcdJ c=1 sm=1 tr=0 ts=69fa0919 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=9B1uR9gGAAAA:8 a=ZjWAlqguhnwxBXe5j8wA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=8R3p93Tjo66ouot214C2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050146
X-Rspamd-Queue-Id: DCE154D013E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35919-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,met-dubbel-l.nl:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/5/2026 7:30 AM, Willmar Knikker wrote:
> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
> the dev_kfree_skb_any. This can cause a use after free kfence.
> 
> Move the use after the dev_kfree_skb_any after use of ->is_continuation
> inline with the while in the while loop above this one.
> 
> Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>

This issue is present since day 1...

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")


