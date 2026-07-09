Return-Path: <linux-wireless+bounces-38830-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CUMOJU+5T2pXnQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38830-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 17:07:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD66732A44
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 17:07:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=evaVopnI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TFsz+OX3;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38830-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38830-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B226431BBB4C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3453ECBC7;
	Thu,  9 Jul 2026 14:49:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972B3B14D3
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 14:49:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608596; cv=none; b=hiej3dyCCD3q7JhG4k9DeUv94njhhd6zaf0+zdC8/YMevtP6y9zMBKxpLcECUUwgXjRp1Zi4SEimSAM4fW0c1vFG6PuXKQZW0arkQ/cjnHXRWCdVA7839UHJGFFndISDCinLXaTmvglrHD/lfrc9QIl4w51wbjX0CS/4ynfBXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608596; c=relaxed/simple;
	bh=xjlOmzHN0GfF3tGvOD8NpCrKYbRGI5NF7iSKFD5Sc14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OtOaGsnAuOQHVm0UYflVOy1uALY+9tcpiW8ecjkgEA4SAlxheuNlQVUQp7SnrDh89T0LrvtD6L443wTBVVFN1oH4QrlXOezcP8tsNFGNB8eWGWTbooyxJ1Ch6Qd4be8Q1+s6l0BKzqGGdu6Btec8kePzRQ1ctXamH2l0oC3nQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evaVopnI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFsz+OX3; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669DwIn12019002
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jul 2026 14:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4C0rBF8eoOikPGKXr1eu52DTy3xRy33I6NKD14j5lOg=; b=evaVopnIYdtIrxlE
	srq5IuYeqWHxBUDcUV3oioLeZrvgX9crPa0W7ctGEoaShFxlYVt5dd3GOQ0TjE0T
	sDDV04DITc26MtBtwHgv44sZdBT7Aqe0Tn8oh7Xz6UaEZJ8Ksqiv+xWw+zGDl1UO
	PQzMMpAUIfVKhAJz7ijdSSYWie2ut0rnzu29Nk1EGDhb4E8ZRlFORi1G2NL3vZQ/
	U1Ezp/E8JrsBK2bk/vg8xkBYXSFOb6zpgNQNOFzQcXDjpbDUAMbvl1lKOS55tT7N
	IIF7XlaTS5p4CJmyJ/NG2DwnEDH4hecPtrdpUAgn36LaKw0LG1cmnPxCauH0a2Je
	ewJxSQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqscvc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 14:49:54 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e6abfca68so21405477b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608594; x=1784213394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4C0rBF8eoOikPGKXr1eu52DTy3xRy33I6NKD14j5lOg=;
        b=TFsz+OX3lV6ClMH9APyhvTQdVjGfnH6LZNY6TOe5OC5Lj1Zyw6l8rBLfDNqf8Uv2VY
         usbE3L4RGdDus+7/C7cVkZOPHK1g3RYg7mlELKCLBK3A7s/0ChpCIhuWsW0ZJ4p2zCiC
         HgmOnZlyA9JT7+6qWrv0m8BLlQ7r0cqKDwihmiV5+fhqfknUhH+e1UuF0JKNHyjwpPvn
         KEJc/TU/GSD20JDl7GMMZa98oZ9HQS6p0CMC3qrJ9faqWi+sAekFWYnrcfbXArjbth+k
         DhsHf9KUh8Sa+bUjrccmX3dnwoWR+sYcc5uvF4ZEaSorINyI7VjRGh3NreKnFahLkocr
         CMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608594; x=1784213394;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4C0rBF8eoOikPGKXr1eu52DTy3xRy33I6NKD14j5lOg=;
        b=iQDWGg5zYivO9leuTxJqUkmTQ3vHbocdwTf67PKvmkADnZ0sCtKy0dzAHKmo2NgxNY
         boK62nN/kL/78Ipwye6FNJv2sGfCyW1pNs5ma1aEV65guUwRvtf7du+IJuXmDYH1HnJW
         5IDbq6k49/0Njb2oxVKPf31jQUFsl4xeX/f13u9B8qAuo5mk1Zvt9PUtfQRoPEIUiF5c
         4Uks7fLbovRb8bafyZEDjIjmzKh5qvuAgMJKmuVA0/KVx9S1EL2mBIYBYR1i++GbwD2+
         YM8sx3p5NVsn5TzvQBe40ZafHJJl5Ok+V6M2WSADV1uEUYvDtee85PqizhcgR0sgge0/
         mKcA==
X-Gm-Message-State: AOJu0YyxspjYHIcJBOY79hSNO2vOF14yntvcussFmHhQKx4SRvF2IIlB
	S/frfANET/f6ll13VpesCC+QTxzHku5odRAGzrp9ifwwRzUMLn0CiZWUy+0DYwJNdJtHEHQ161g
	qh0q9siShyli51hP+nNCnwPobSisDfaKStakEYni8jmGfLjesduzG6GdkqpP1EtyE4RqekA==
X-Gm-Gg: AfdE7clGgPrz6vq/D1SDnPL5JuaH1DlY8Q2KCIGFPUcurGwtN+bJzWK+LZcNyn8dgfj
	YWppu6y8V35DbgQuCxQjHmBDDZvQbQH7OTFx5LLlTdDNPVlIXsdAuKQPVQzTsyNT1IcoFnmZVyf
	s4z3Sfx8FRRidMP30LEKMvFiHT3fB8QdnaVvizq6dDDrC2srpZHrMk0bI1QHbPiFGnV8DUweNGg
	TR/cg4UTZVRVRv3ZXbCy5uAhqXHAQq3I/YxmyTVT24G/S+6tXCqIit2nI+wpevealMG1gYQ9QAz
	WqPH8IdhaNmbRPqERUN/Aju8k4KTK+q7VpO6PCzoVGnWyfjx855OmatJwaFhopzkaM1Mtr2XDQK
	ej0HTsubSn4AEwg2hyt4vSjncCBRdABTvN0laxXA8VLMnoP1pnYLDfMfUwdkCSEZjRA==
X-Received: by 2002:a05:690c:6c07:b0:7ff:1a06:472 with SMTP id 00721157ae682-81dbbe3759dmr63673657b3.4.1783608593588;
        Thu, 09 Jul 2026 07:49:53 -0700 (PDT)
X-Received: by 2002:a05:690c:6c07:b0:7ff:1a06:472 with SMTP id 00721157ae682-81dbbe3759dmr63673477b3.4.1783608593194;
        Thu, 09 Jul 2026 07:49:53 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7795988dsm4989277b3.26.2026.07.09.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:51 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Dmitry Morgun <d.morgun@ispras.ru>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
In-Reply-To: <20260530114252.42615-1-d.morgun@ispras.ru>
References: <20260530114252.42615-1-d.morgun@ispras.ru>
Subject: Re: [PATCH] wifi: ath11k: fix potential buffer underflow in
 ath11k_hal_rx_msdu_list_get()
Message-Id: <178360859072.1031194.307534761156277733.b4-ty@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 07:49:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX14Gy6QTS1+LZ
 eXb27FraWmGN1+8KPuOt7PtQqfD2C0uztrIXPHgV1Ah4aVxgaQ+LWpXwxTGFAX1n4zH5QGrr28/
 spy4am+FeY4JhM/ELMGsPSS8GmoEVbE=
X-Proofpoint-GUID: CDjqLQM84Bjf3vAjEjv5-KAO-rsrJ95A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXwIRLN7IWtRy6
 v1IBqqtwfKn0wrVa1OqADhg4/WiD0ieJSGBMoV8x61DX4t4k2iTywkI52dqP6ZY/upTqooS6fuV
 BJO/kyvJEzejj8YJN4hB0mVJN8lIejtEcLBmQoOkYm7VOCYsS/OLnuI2GnXTh2LCCKaUNr2ENbm
 TLsC6ZA4ZHSxQ+Ay0bc+wM4u5tmQZ+7HRM8HQmaQtMns7ttRxBN8n/xKNG6bFTuUEQqnNkOXx0l
 Rj58ECph5hANmqWcQWzlz1OAGcmf3HQqF6Lrrtdsn3QhLwJKw6H7Lei7P3Oct365acLZEUnn0CE
 XN06VZl1h6WKQnZdqRNQyUEin2AQjLXvk4V2P2tTst+4Tnopze3kNV0sOqEBvMVutXmC5oOPulM
 0lmqQu3U+9N92zraDqtlpLIYSINZdHB0DZ/f8E/GAW+n/gz9L1WRwiKPvNtV+AamHH00VG+8oB3
 DAxnrTivJTTo2ptkkyg==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4fb512 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=R6p_8CvzZLfSnjKUPdYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: CDjqLQM84Bjf3vAjEjv5-KAO-rsrJ95A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38830-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:d.morgun@ispras.ru,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAD66732A44


On Sat, 30 May 2026 11:42:52 +0000, Dmitry Morgun wrote:
> When the first entry in msdu_details has a zero buffer address,
> the code accesses msdu_details[i - 1] with i == 0, causing a
> buffer underflow.
> 
> Fix similarly to ath12k_wifi7_hal_rx_msdu_list_get() by adding
> a separate check for i == 0 before the main condition to prevent
> the out-of-bounds access.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()
      commit: 7f11e70629650ff6ea140984e5ce188b775b2683

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


