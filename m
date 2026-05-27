Return-Path: <linux-wireless+bounces-37023-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKRFLj9NF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37023-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:59:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159995E9D55
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 124D6310C305
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E23B3C1B;
	Wed, 27 May 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azbXpwa5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4PL811o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F63B27DF
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911526; cv=none; b=J9lEW4EM3O3bORAVfFwccqvZiG/DMTbtaqUKhlwcZbhZQw0W+zHm8faXYY1Sb7zBMBqiy7aVoc+B+1hwP3eBzTsFOQJSYJ7WexY314OJuGmYKiF+GrCX/Dje1usRkz30ygbSoPyRhhz9EgGA212OSdgHoVRpDcaIspUoJTgCSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911526; c=relaxed/simple;
	bh=qAIUo/4v6Wk2IxOgZvpMGagyTAV1+Ca8gIbzJJy9iqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+InT3Rr6CEAAliNoZJflw1HrbtpF+Iz+cBBmylEsUvgk1jU8nyYlZQi9gTHCWG+WD/Mj+4NpBtDgzZ0n3cg+ZC1ktyuRmYyekHm8BUwRcaKdzwmy7hC2JxDVc3/TDX+Y9hJGlxc6VEspOL5bM77GQrUEea4ou0UfWUdzEy4CYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azbXpwa5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4PL811o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RJgicR1478000
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rZO3fziTBuxbAv6/WgS4fmu/DgnKomzs/QOcLDB/MF4=; b=azbXpwa5dJ/EV6fw
	us1A+oRKB7oi9C4PCZ00DfpG/apj5eX275oZuW473rQiGzH4arAMiW/axqV0ZoXt
	pRwjVulzHq1DTfYd2YAViGyccI5c9ghhSwkUyv+aEAt3K3iHGOyCGbDh75/jMDen
	pRt5ogDojxN8PfsIRdW4IXvUybw47cpIE+4h92jrrUmPgVYXsRiYwvTSv7iy/Jdv
	z6WuFfGvv1jDSyvVRZcEhcv4LRkyGpmRZrmSqas7+mujlJ8if8ZadPJwmbhHU49l
	uJnZNjWzliP9IfkW/t9l7e6/hl69w0r5tFAK0jsPLq7BP4u9Vz+n5+qJxUczneq2
	rkGzTw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee0a89rv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:52:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f2d983d109so6809985eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779911523; x=1780516323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZO3fziTBuxbAv6/WgS4fmu/DgnKomzs/QOcLDB/MF4=;
        b=Q4PL811oWuAkibR5dyX1XCaAeJlapMfc3GzC9Upucm7zbFHbDRUb2fZK3AXLezftf2
         WQznq1t0LKf79FYsijGEmPg/aHiVeCjycTYq1pcZgR/08DSvaEMH/eL+s7c2nTCnJk7H
         2fdh2bCqjzyTuNZbBrJ5VNJKUbbx3fHH7LElkfqg0xvm8MyTh4VLCObpPdmLDr5bVjyH
         /u/zUTJcA/1Nper0mNEaSmj7X3Ip3JBd3AcZCifAFKMRgIbichploBoBfro1C7O16/NR
         XyYO7jDM1DmYU44gu3G1i1OPz9QNzPrQE2oCNyL047lOkYzAsx0JdUJclGO8gA5+IckU
         ALWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911523; x=1780516323;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZO3fziTBuxbAv6/WgS4fmu/DgnKomzs/QOcLDB/MF4=;
        b=nuFscJPbA/O57KuhhB631zSicFCBRyawEifwsGN+e6JeNRd9//FNhKLyDm6oYABXKs
         p7al5npGgUmmGwGcpXxwJhiLzcyDnz2w7XBYJnx+LpLWJK98tr6IBmV1ztI6D7oRduiy
         bs+slSEcjDsWOLfjMrpdRcDew633jRhWcEeJXJnRDl6NxhqlnQxQVsSQReoeaZ/VQZAL
         TIahgYsfWfZNqAkucTEQPO6tME7TeoIcSIs9RLi3+xdd7kC0vXJupfklp3grI2aFT6UN
         KfyUiw8uIeQhrRdRQqyUzZcfapRqHi8u3/tf8XdaWXkcWctsfNiyCY/WzBSDkuwiAmzX
         xDmQ==
X-Gm-Message-State: AOJu0Yxi6DUqNrri3BDX1VRodTp2xW3NryfB2XpEx6a5PaA9b8WwZQCF
	5jWLh8pkxfpl0lH7pkve62oPKvK7cW1yzq+rUki0Wq96EfWAWaNdUpSwzncn9XPni3oM98XkUYF
	ysY6Oi3/VVEGBmVQpX058nNNyqh9hN8U5tjqGV6ij0A/0lHYgShl/axjbyYDFI5DNImtaIw==
X-Gm-Gg: Acq92OF6qoq2kkBH3446v8HMUEB0qkH4X+bl9AzxgeH9t4e6AXJvNjZBL/ipVRtDhgg
	yUJZT/T+8C8FFN2Mk5GlLV/XedHp4rwROZJdp/NkXObS22Sick/HNQhNOxlQwTZicfFSB8qw0oU
	cy4o5u06EBy7WkFmjbn3KXt7uMXjKYx8VzvyyXpWz28rG+FBLnG+Up0ji4g1iynO1JTV3cm16Sm
	R2T84AAUbABaFvk53LP+P9xNUhdBpMZ02zsLY4uic9iGe0Na3Y/C+JHtjvslw6021tT+ECGDW75
	Zrnnqs8nhj48zF1ikusaXeiwSQv1al3KWQGi9UQBDbysZSDcsaiOKedA+olO06QPuQ+n4UGzTT+
	YS51slPoL0yj3DiT6Q/9CCCWAOq6uCzZ7OvVYoSQLLLNcwg8BTGsPl6OW9kYsf1NEumJEPsbldw
	xG7Brqyx0aLdjkdQu3HwmMh6hg
X-Received: by 2002:a05:7301:9bc8:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-30449187ebdmr12061317eec.26.1779911522698;
        Wed, 27 May 2026 12:52:02 -0700 (PDT)
X-Received: by 2002:a05:7301:9bc8:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-30449187ebdmr12061295eec.26.1779911522174;
        Wed, 27 May 2026 12:52:02 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304524610f7sm13536204eec.29.2026.05.27.12.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 12:52:01 -0700 (PDT)
Message-ID: <dc8c9c9c-dc85-40dd-9313-845a808a35f4@oss.qualcomm.com>
Date: Wed, 27 May 2026 12:52:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: ath12k: support calibration-variant from device
 tree
To: Andrew LaMarche <andrewjlamarche@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
 <A2E3AAE1-1A80-4265-9497-0C95C3308CD7@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <A2E3AAE1-1A80-4265-9497-0C95C3308CD7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XrrK/1F9 c=1 sm=1 tr=0 ts=6a174b63 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=HgE-MqBRfio-cNNWzu0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: C9kNTwQKk0ZsHAWH8DMyJOeuIU5sq0vI
X-Proofpoint-ORIG-GUID: C9kNTwQKk0ZsHAWH8DMyJOeuIU5sq0vI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE5OSBTYWx0ZWRfXwYLeOFRWz/wu
 YLZG7Wtmkr+OgPrsDab46U1Wisn7kxtj/n8WkRkGhJ9JBpFeVx/No084wHftVpjd2EMK1t9/OwF
 fxkhLN5BgKvkGk9zDhzzCg2fV8wZ7quqF6aIm+l2ltR0U+F/wznk3h2F/5yHR+WTk04MzvEf0vT
 bx2ggd80yFTjITJLL8p3eB5dEPsRrDbxIycJDFmWAVu0w+4qLHTtsABq32ot3XuGyRwrqvNmRVF
 b1l3YMDYjstoSxMzceg2Fv1iGF6qksNNRXEPzPMC+4BUvco6XkfwnNNGD1OEtqWC5yZz5QR4bc3
 nL/3fByrvNh+kiQBThmhgjyLGzh5j8JAurWTeM4/3zJ4hOBWVnBYz/rzP0eYz06Pj+UbwEcSHQK
 fUfF6Q5MIRqQEtx9CSg5rSmz7aBExun8GEhGnzDs1Up3RXLGgI93rz8ehEKrt9LvmUKOEo18Sz/
 iCd4lAfL4dt2d9vS6Eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270199
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37023-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 159995E9D55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/2026 9:12 AM, Andrew LaMarche wrote:
> Hi,
> 
> A kind ping here. I’m not sure why this functionality is missing in the first place, but it is needed for loading caldata from the device tree.

Your patch duplicates functionality in the Qualcomm authored series:
https://msgid.link/20250228184214.337119-1-quic_rajkbhag@quicinc.com

And note the upstream device bindings for ath10k and ath11k only support the
generic binding qcom,calibration-variant.

There are no longer any generation-specific bindings, see:
https://msgid.link/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org

/jeff

