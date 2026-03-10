Return-Path: <linux-wireless+bounces-32924-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEEtColcsGloigIAu9opvQ
	(envelope-from <linux-wireless+bounces-32924-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 19:01:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B10125616E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC04E31CEAB4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562933C344C;
	Tue, 10 Mar 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4L78VtF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFBtqoOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A423D5666
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165343; cv=none; b=GDcMENdtpQtw40R81r6Log6wSy5Y8KhDnENMJg6hHi+P9RiUKf/YAOM0DFVn5WF+G33B1/GPgaq8lIPKyIcYsU9VZa8MKgnKHT+nqE2SzFFHrxCi+onGErvcJrmnjLMulo/TCQz7fwbJShW6JxJTCd6+gADBuqeLrd8ZxinBnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165343; c=relaxed/simple;
	bh=1U/MXZgzYo36oXoS3nhXWlNwLYBqSXrPA38k2vw+XTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZk3dO/L8aPyz45LifRpi9Zuw+AKn0Icw5wdbe/Spdho3ic5swdgqqT4f0xoxDnOzYQS9HUQf73ioscd2xLqv+etqTbcD6eMdTqSzZKCCXEGGgcD4FdIRAHuruarwaCgRjjTf0VOnzVMT7Z1lX70sSPPyFpxCKQvWF/opJsRf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4L78VtF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFBtqoOt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaUnU303881
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uivpYYPu728tHmFs9Lf4h3GhDtM5MMCXZhENiZzX/Eg=; b=g4L78VtFmmtBGHDj
	v+SJZMx1SRfAqDfqUdoMbRb5LEm7ZWDgd0eMEfPNSnD16juztp9WylU2vTYyG/Rm
	HxDnghmUHK8LTQ5gR/Xq2kY6h9yvZJs1CUVePkolIiMCoIZruoP1XCewG9ZbxZEq
	TUfBBVPt8HCjny0xd8CHmIPWHMXcpyIk0wjxZZGwrZdnBw0V46u8Y3+P/xGnBXO8
	GiNGFNO3UO70iOGkgRN8i+I6DhrXPhywgV9zrJlI7NxsHQQdQEALpoL4VmWANFvY
	JoCzvXzf/2qUnIzcc5zH1u26ijr98AcE0H9DCsmmHvJe5eA3wmsgFsmjseL7tt4W
	8TRYsw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf1ss0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:55:41 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-415583a6862so1163306fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773165340; x=1773770140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uivpYYPu728tHmFs9Lf4h3GhDtM5MMCXZhENiZzX/Eg=;
        b=UFBtqoOtXPsiPfewOci3S+91ePSL9d46oD1oR8maR7nOnjiNw4MLRNO4TSPhwqN6JN
         9bToSR+67BynNbTs3fXR0yMLlMzhc11L8QcPDAUWChv7gSjZyb6SkddsXJz8Qm7mVMLx
         pHxLoKAtF3Usgs3yx+aQq/m2HxQJ5r2dkWhcIDwg/lt5q9ldecbgbSX1to3wGIFsLrNO
         C+/PfH1rqwJk1JzPV5ubRbrNnUPzzakd11G7Wwi1cF1sWOYr1ue3Fz6ZTrOtdsXLkwLl
         tffbZYzxtP4fEPQLgK0EXnCnmWuKjQ0quPbrhMpPHsTLXmdHyYLGiZ8l5iOmoBX4+EmX
         p0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165340; x=1773770140;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uivpYYPu728tHmFs9Lf4h3GhDtM5MMCXZhENiZzX/Eg=;
        b=G8BdiKFx91+YYO5oPaseV82W/r16TYMJv0qGdZbh74/aP5fnOhBBX2Gq7ELkOteivP
         dzUsKBGCf77VupC2RjCawhDq7i0FKwn2A5QlPTspbM35NTAWIKtNWxbRrHMq3pE2MvpF
         cv8qvpsGzExkb4pkZIbTWICO12O5HVNO+WAin7JO6Wl+FAgtEedS3qfZ0p7KOxJK9V8R
         CrNOh6GnGbBB/gc22Zinu2r1qDYjMtNIlPoBKlD29f+QbXYOFtPpC96CHuQQdl/Ev57a
         gz+cyG7epxb4xqk+bNKzUpQOuWSWejmkeIpkqI5UVXrw8lREIjR32U2k1j6Toh6jRjPs
         EK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXnHJokh2cIL8UriMnuIJlhTx4wRZptvlFteSt/mvuOOa0GW0p0hAaZjdkJKlpvpD5y09+U9uGARyBib/BpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzdQT8gIM71Ow+mZsuVOFSwwgCmC2iHc7hdQa5qbNBbNfv8Bj
	cQZ8tmdeMdIuOFu9IUg8jWoV5uqsf1ELIdZl2eMVwMiZtpBXau55f1mM17yRuh4RD8ghpqC2VC9
	3LHoEooj3gZ7gYHaRSMGnv4RmA8ol4hVpyX+nWRwhFMkIawD1vcQDNcZfdfwvACNXe75UzA==
X-Gm-Gg: ATEYQzwem56Vo9rIDM6D0OzFQ9mJAT9KsTdgukwLqEqiBmGP/0UUV26TTEtEQQ/+SUp
	HrTJ4xtzLW3PYXQkytvz/v6WBEClxDFU+XRyNN5wEM/5Radg0MssHFUvgrxS3ZmXuc8SaKJYUO9
	hqCN9sgkH8n4xns7TU1MVRinJ09Bgg3QajhJ1J6Psa/S4KLve+u7pYhCJ+63MjLvuuc9H9VLRYA
	riQ6sTsl3IDwthyqGX3ti3MAqK6PxXsfedNzkmLY/FXiQ6lXv0N1nJRxQhEkpkvU//9eP4uPUxy
	GZbDp1JntcVfZXEdLJT+XDRq4A0XnnKmCbSFkxVpALPx3XsrTU0FtoDcaQGkdSnR7bLi8VZvgHp
	mmFvuuoaxkN8m0JjQRXIIKUZS0BPIGWxYFYnCi7OzQAJH4UGiSkqhGEGvd1rDnvHxx5mHXyFpQT
	U+NmpySg==
X-Received: by 2002:a05:6870:178c:b0:417:3ee0:59e4 with SMTP id 586e51a60fabf-41756808056mr2464508fac.5.1773165340149;
        Tue, 10 Mar 2026 10:55:40 -0700 (PDT)
X-Received: by 2002:a05:6870:178c:b0:417:3ee0:59e4 with SMTP id 586e51a60fabf-41756808056mr2464489fac.5.1773165339655;
        Tue, 10 Mar 2026 10:55:39 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756dcb1e8sm3402971fac.16.2026.03.10.10.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 10:55:38 -0700 (PDT)
Message-ID: <8aaacbb2-8ce6-42b4-923d-78491df6d31a@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 10:55:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260119073923.764245-1-alexander.wilhelm@westermo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260119073923.764245-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UCMCpnZlKQSeIQIxmEfXlark8INJhNpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE1NiBTYWx0ZWRfXy/QD8VB1ghAb
 621UeXqnzagHkWy4bbEaYUMhdOnPR55viuLj5/baWHVZ3p/X0aY6J4/g4MQxLPZIQi//eR4uCzo
 mxwHlKDBI5LhvVesKYH6TUf9Ycc05dM3g+0ISZjQFcyp0NOg8qlD8DhVsHwNbtYob4orx6pfTj0
 CMmKS35IHT7YmmPDzpJ2nL0b/dsfIkEPJQX+d+oC42METfd4b6gyEY2ZHHXt8rgncL8urkXIz6L
 EC25+nnD8RJe1nKVHal4w8580ZahCcC3nTkmbE26N4NkWfvJqfB7UXB6QVIllXN6ERzlav40cOP
 c9f/3arrpyU1qnBsT4jJk3MLBeqdArag0fOYxNW6oEDdf1rYs80zJVKqPYK6Gp+6Bv8jvHSTEZP
 1hy8Inz4CtJt6RI4+MZaD17DMgLn7L/vkU0NRfxOKW/IFM8SGtFFD+WW5gW4wmmm1CR1YpiUdJQ
 qpNAeRcAarQ95Wg7NIA==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b05b1d cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=N9GNhs4bAAAA:8 a=x4LiasA2zIWtCAHPNq4A:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: UCMCpnZlKQSeIQIxmEfXlark8INJhNpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100156
X-Rspamd-Queue-Id: 7B10125616E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32924-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,westermo.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 1/18/2026 11:39 PM, Alexander Wilhelm wrote:
> The SRNG head and tail ring pointers are stored in device memory as
> little-endian values. On big-endian systems, direct dereferencing of these
> pointers leads to incorrect values being read or written, causing ring
> management issues and potentially breaking data flow.
> 
> This patch ensures all accesses to SRNG ring pointers use the appropriate
> endianness conversions. This affects both read and write paths for source
> and destination rings, as well as debug output. The changes guarantee
> correct operation on both little- and big-endian architectures.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> ---
> Changes in v3:
> - Rebase on latest 'ath' master
> - Use always 'le32_to_cpu()' macro for conversions
> 
> Changes in v2:
> - Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 37 +++++++++++++++------------
>  drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
>  2 files changed, 25 insertions(+), 20 deletions(-)

I really hope to get your changes in.

With your changes sparse reports:
drivers/net/wireless/ath/ath12k/wifi7/hal.c:322:50: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wifi7/hal.c:322:50:    expected restricted __le32 [usertype] *hp_addr
drivers/net/wireless/ath/ath12k/wifi7/hal.c:322:50:    got unsigned int [usertype] *
drivers/net/wireless/ath/ath12k/wifi7/hal.c:333:50: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wifi7/hal.c:333:50:    expected restricted __le32 [usertype] *tp_addr
drivers/net/wireless/ath/ath12k/wifi7/hal.c:333:50:    got unsigned int [usertype] *
drivers/net/wireless/ath/ath12k/wifi7/hal.c:387:42: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wifi7/hal.c:387:42:    expected restricted __le32 [usertype] *tp_addr
drivers/net/wireless/ath/ath12k/wifi7/hal.c:387:42:    got unsigned int [usertype] *
drivers/net/wireless/ath/ath12k/wifi7/hal.c:390:42: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wifi7/hal.c:390:42:    expected restricted __le32 [usertype] *hp_addr
drivers/net/wireless/ath/ath12k/wifi7/hal.c:390:42:    got unsigned int [usertype] *

I'm also getting checkpatch issues:
drivers/net/wireless/ath/ath12k/hal.c:503: Lines should not end with a '('
drivers/net/wireless/ath/ath12k/hal.c:531: Lines should not end with a '('
drivers/net/wireless/ath/ath12k/hal.c:551: Lines should not end with a '('

Can you address these issues?

/jeff

