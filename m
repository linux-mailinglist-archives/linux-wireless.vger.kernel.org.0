Return-Path: <linux-wireless+bounces-34896-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH7RLWkN4WnoogAAu9opvQ
	(envelope-from <linux-wireless+bounces-34896-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 18:25:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 572ED411B0B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 18:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB855300C0D8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8DA2EAB6F;
	Thu, 16 Apr 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Su1us1wp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sp98WCwU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B33914E7
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356711; cv=none; b=bsr88mi3pf9y4f2GB0pKUqcEhIFelDYCNlttv6fQTDAG1qd/TjDiuS2e0sQGNHlPfmrkAxGEqIbFEK16Qy1dnViw3hGMTKqqtYahV/NWCC2mPqqvazOVF/XaFtqxpFpDjs0MHNa7e3S7HRjfB7q6GfGth2SwAmY9Za5gedfKKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356711; c=relaxed/simple;
	bh=uXBfuNDPSp5qvFpD8JFY065ven9rDvqQv8tOQ8HIEwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQy5Cr5JQmyDTeysQYTJHDuXQkIVOdKdg/ND08NlUxMW1zh7LSpfvcTtbC2+9fAJnhN3SKfYU2UY7kcI01z2oGV4lapieLfO0cpFzqyjwSNYNHtjJYE6B472RCnEsQh3vpOJHZOn5bx888pLc8Y2kA2CKyt409YVPAcx8Qikrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Su1us1wp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sp98WCwU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GERUuX2575781
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 16:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KJ2CHQ6UDyEUDA3SA9RtLQWGDm9BZFUKaTloKQs1UJQ=; b=Su1us1wp7uISdPRW
	s8R7Oyc7TAsCR7Yuk2eCzXGu4dyjeVycoQHTMYanek0+rAgNZo+id3ElcGGsA+/r
	A16DAjiM7MbFVYbnSp0ZM+Ia86IhAXAXb5bkGM5nOgGvF2tuLoXM31FLXb6mSYiS
	1ODf/IraW31SrUEnyOBEpMfihUIimL0zfxQSSb1+7dtmW4+m8Db2E5Eq/1OC+lga
	vxRAdmdV2CJr5rH0tQ6ie0mKC2qH1q0Z4RY69D5Ceo5CH0yCsuCsbWwIz/GfrEkD
	PTeUinpoIE1jmERuRPhOe8ROm2AC9z/wKyI9aWqUd1oBX0rNYU0Nn1iIOO084awT
	nq95Cg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djv27ht3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 16:25:09 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79a670a5fe9so221677957b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776356709; x=1776961509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJ2CHQ6UDyEUDA3SA9RtLQWGDm9BZFUKaTloKQs1UJQ=;
        b=Sp98WCwUookRShRDUgbh36GzkaA4valioTlpx19RYI2nxX3X2xr7IGyiq9fbA876Cv
         P4WNmmlbGKNZzlEEQnfjfwr/P0Eu2yc53ePVMW0Rw24Z3DqNh3s6KFLLecEzpXNujEj9
         dPZZ27tCKswOynXkxIiajuV578EXRhonI7GGk/JQiBavkoqY/471SahstC3kv5c8z65a
         3fl4OIv/vETY5REPOVP3EVVAD3XuX0g7rEN6cU2DJ/b/01Dkle0eIe2SDur/3YIGHpQS
         jxGfNhrO1yinZSMZ/Zmcl14B7d5wBZmmEH6RxVjI2i7bveTgwTPhCdNA0O8UYXTrzoFh
         pJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776356709; x=1776961509;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJ2CHQ6UDyEUDA3SA9RtLQWGDm9BZFUKaTloKQs1UJQ=;
        b=WzPjAXaWoHPj0XFH9zbm4qNLfXuSwNOS7GC8RsyVzNniHJiQro4G268kniWiDX8iFf
         ihvDCysk8lRlU2CUWGTAYfMNk0E7haXe8XQbn/uQgrCUvaQUWmdg7wZfZlI4YCzhESUX
         npBWJD5ddWWY0D1vrnriw5lJYMcU2JiqA+cL2YnTUAesZnJ3UlP4DGYdmXZm2iZSSUTO
         4wAyGCTXmzT3XJp+T5/egfiLlT5Slr2DYsmYpI1w6vREU0mXlhDkzIIKvww8GeNWw1+x
         F1KZk5Sj1flV0rDEnDKqpEVNx2tBuk+Ek+gVCW4+POhy6Z/GlPrH6XlkZsJURPqhBEcD
         vTtg==
X-Forwarded-Encrypted: i=1; AFNElJ8Z+qLtRGhA9iqZetoj1UpmZuNEr4pxNm/vwUKxthFKm9UMWjvcGtmXL+dQ+bzBdpFSZRF5IULF6Ym8ZKv09A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxckDBfli6i0+s8DUkiRCnYAI76jhzqqU9gJSgJ9w1o6f6LNmPz
	+gOJDvzwndp0tCuCh27pmLvh5MBcgUb9MUDH7itj5DuMVpbfPZ3J/GIgi4TDj+t5uO+qnsfy7sW
	Yw/MGT74GPn1Q7wChO13+lie+HDvhjepSnTaM03p5HD6sJ9qqqXsd7TzOBFVqo8BFP0BXPA==
X-Gm-Gg: AeBDievjBKSAo8uPRhANC98lmBsljNshaIG3mUvDW0psRLEEJ9q4i/u9siXyCYoEr0R
	985lxvsR/g3n2Krh1bQeXmNaNlGBlQEx+zBggQzkCTIZsB9Aqt8DvBHZmnTUtrOXt9ppB7C+2uH
	MFpLDGz6nG1Y8Ts+CIwy5H+4hsJn6tL0o0vFwpJoJuxwxjfHf556rXqTjIVSIF2iUB+etH9Rvz9
	NKErT2fBlF8fvyb00ouuL1nArzP7zFpii68qpep4/aQRpU/pyg6QqFwXbzUBVbn5b1w8O47w8Fz
	s4mCYlevPaUIAr4sW3EGTqjBbBFdIiGBaw2mt7i6h8HKMRiHdan5jh1Ck8GKaWuFTPOKmGWNAz8
	MbMklS0FkrwEQm/u0F5hmjHmQ+yPVgu9Kl1xrLLssOkNyytdXL5sjrkqRTPM90eLH8zKKRePhWV
	WUvRsW9aOaGkWGjrscu95nF3q3
X-Received: by 2002:a05:690e:4841:b0:649:e6de:8f4a with SMTP id 956f58d0204a3-65198b72cdemr17653625d50.42.1776356708602;
        Thu, 16 Apr 2026 09:25:08 -0700 (PDT)
X-Received: by 2002:a05:690e:4841:b0:649:e6de:8f4a with SMTP id 956f58d0204a3-65198b72cdemr17653596d50.42.1776356708207;
        Thu, 16 Apr 2026 09:25:08 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e44c0d68sm2319144d50.2.2026.04.16.09.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 09:25:07 -0700 (PDT)
Message-ID: <9fa651dd-6004-42c6-8c03-95247d5807fd@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 09:25:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow
 from firmware responses
To: Tristan Madani <tristmd@gmail.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20260415223710.1616925-1-tristmd@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260415223710.1616925-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PJQ/P/qC c=1 sm=1 tr=0 ts=69e10d65 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=J_-Nd1mkAAAA:8 a=o-z3T2Ye8H1ov-NE8kIA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: 32Y-qG43GAzajBXehGRfjJdse8MBy2aI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE1NiBTYWx0ZWRfX3VKDAS92x3MC
 mDtEahVTNKZsu7X02pGpd5+cZsD6kCg8c+5f8QZ1/J6AVn6vGKuEC3rw5JiLF3Fon9Wo5C2DHM6
 ZTMthn6k9BXR/i330xCnlLShhMn/Pfzwyn0xVS8mQ2iq3eBpcCDQHK1oPQyuEETD8p+SjJ2F8yu
 C0K7iC65Cx3+bn49l7IWo0bDE0JFK0UfXoaeKSedm5tgEmxog3Yas3tN7PjgrhnsXRBZWKN5EFk
 EQxQR/oUrrVM9mtp/YNwOG//SeeftKmo7mYsn4b3AWHPUdO0nDxe8tWXoovb1EZbDOqQmuLj7m0
 hNZMtcMgl4JcqPHRhXCTUCx6GDbqTQKY+CdQkdKnRqY0vqBjXm9C7Q86+9X20XG5WNcTJxYIZJv
 76x+BHvC9gxnFZuxijNGS/1lZ4gc48r0iZ6XWIsHwjtOjKpDtPjYSxW5bS3MvqYIp/InFZiDCrj
 OgLZUmohbKi+nKgyRZw==
X-Proofpoint-ORIG-GUID: 32Y-qG43GAzajBXehGRfjJdse8MBy2aI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160156
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34896-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 572ED411B0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/2026 3:37 PM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> Hi Loic,
> 
> Note: this is a v2 resubmission. The original was sent via Gmail which
> caused HTML rendering issues. This version uses git send-email for
> proper plain-text formatting.
> 
> Three issues in wcn36xx HAL firmware response handling, including a heap
> overflow in the main response dispatcher:
> 
> Proposed fixes in the following patches.
> 
> Thanks,
> Tristan

Are you able to cause these issues to occur?
My expectation is that this is testing things that firmware will never do, and
hence this adds code and processing with no actual benefit.

/jeff

