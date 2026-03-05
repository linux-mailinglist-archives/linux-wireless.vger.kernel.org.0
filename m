Return-Path: <linux-wireless+bounces-32499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBGmLPtBqWkZ3gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 09:42:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2D20D9F0
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 09:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67AA6303B4C8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F8373C19;
	Thu,  5 Mar 2026 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PV1zd67S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vy5xhRy7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B663372ED1
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700070; cv=none; b=aOsatEwY8jk6cTJkTMbzZ+HwSbWlD7uMYyHJfOQqQqXEINBIsHEYtXUNZ8YVukO8IAZQA1uu56BYSpnOBqLb3XrXQwCwEsz2VNakt9ooO35KAuku58QxbtLgkr3cg+gx/DTHlKRdIjRiHal6BfSYzIkkTc19jijdz87CvdFPwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700070; c=relaxed/simple;
	bh=2XfN1IUdVDHXRnPcZX29DDqK+fygGtG7P2u+RJeGQZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUi/1HLq0k9u7Gbt+/XfAE5lfDjUE6JuSlRZW6pkLu3duKktnE/B8NaLu/70QO5xX3x+BMPgT37OqJDX1Htk971XCTft1jaLz2+g4+qInY6HwrlMe2489hUL5UrR7aTTlglmyslIGU9oBSRvmBcCAz8vYkZSUbkFLJ0nWCeibOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PV1zd67S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vy5xhRy7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BmS73604211
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 08:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	piRd4pArnPlFES3z5bGfGAc7MxY7XKet73f1XaOJtCE=; b=PV1zd67SOSKF+UZR
	V5fdwqbyUucXumd06BZ/oAA37dUEl5vML5IHmI3mnn4Bmki8QO3evnkI46yjxxGS
	m45CAGu5eBDMw2YB/8jIWojxuj4hFNgf0+OtRvrgxln0h4SEUJdTQ/aCob5K6Yy2
	yldtosQxZLDKpCc9FgtsieLz7R7I4Tsoz3rcYZinQF78wsrB238y/92ii5jn51JZ
	AwdA78m4ieR/9zsGxFByvyfoHc/1zatdcLsswZYA8mS6Zh9fYsgTO7KlJNmfRS3/
	p0NvKqVEk2wjuYVZ4VzeLo6dqMWQINNS4A0/DL8PndXOf5bZqmgVdZBfNE0dCkLb
	DG+FPg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wafvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:41:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb38a5dc3cso577942285a.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772700067; x=1773304867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piRd4pArnPlFES3z5bGfGAc7MxY7XKet73f1XaOJtCE=;
        b=Vy5xhRy7bGCsAxkL6xDNmBcZCOneb/heiYu08Yt/RUuYJpyRSLkqUQeuqVrri1+1rN
         jDhMM4jyRBd0XNu38oYDVu8cfbT8fu7cOxLSnKWjmdvN8ArlUQ+qEe+c/G/opUtft5o+
         9R9OQgqE5X/Q66smF9EHQB7TXoPeXrezfWGe4NQqAPptSNSNQ25s04EP727kKT1nstIQ
         LvQ7VXDCriqoVD1R6d8iA5pQiHKBDvXzN/AuBTzoKiXYoH+LoHyDGQrzRDJTJk9TMSVj
         kTgO3EwbbjKHB9Bh1D9Y5ben/T6ncPXRKXkl5+QOB+CzyDvr+QG9W5x43TWdyDt+pvDg
         OTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700067; x=1773304867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piRd4pArnPlFES3z5bGfGAc7MxY7XKet73f1XaOJtCE=;
        b=pn00NjNtX/lo8WSE4U7iEx8BKCzW8sxrs+4cP6Nc++WqjO4glITn2HuLQTcYVWfzOG
         q8H8LYlKsyydemUAU9r7i0rERaonS+ApZfWqqVxB0ZF/zZXlOL+IF5qTKEalWU2Sfjwg
         ntHZYyKT+DslVHyhh0U+rkHxhYasIabpijey26Dg+txMHTd0W/3ZuOJrosNdSRc1Apm7
         z4BFSGwPXL8fBlIWRuKmz2kQ+8uO9f2Gan6J454R5KTgnchH7oue27rDCZSqX0BYvDCB
         4oDLhdqgHEqH5kypxLWCrHqzDYw0zcepP7IvgJ9Br2ogJcXQKAv0mKqJ+P7TL8cDT+1w
         Apwg==
X-Forwarded-Encrypted: i=1; AJvYcCVoYTN9rwRJeAfdp50a09awNNv69L6XQ4QillNkQyXXgmmUaEVIeY2L8OzP8y822ovRapQBwB9VPNaZtgmhRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPzS9NCrq3JixFocEiMVTx7xjBCl7EGL3IqLfrnpFuvpcJn/6
	U7k8N+jUl5v4LqAyMs/J25/gdhKtsXNgy+uRsQeXjQjnoiYFvYpRJCKIyz3+pSwSyg1bLlXClER
	frmeSS3B1csPj1Whu+gvNVTsyr1eRJgoJ10ynW/6KVztJ1OHOwrXDoIphlT6TVI6vpBijHw==
X-Gm-Gg: ATEYQzzmWmH8wzpRE/oHFjnGJvPcS2DK5jL5G0PKq6KMx3JD8RZ1f/E/UyJrZl32Bhb
	+zthyM2NaJkOqBcaLAcAw4E2HbLWrqKSY5p5qeEHOcBpKFSG5xyNpO6FzbtD8oARYDpeqP3OFPE
	TfYhOuqjroF+6jU6CTRDOYRKLvqT9NHFXo95QwoYBjuwGt08SqOWQ2yU/g09g8a1zG+qyPw9Mkv
	BB+NubdBrWV69pc0GJRS/ZmhTk24OvxyFv8+AyySLDJjjalidZM0P+RNj21HqGG7CRGILJB+f+J
	7jhPAPjyAuiUB5IfvnHZS/3Ac0BsGr1YSjHyhWAXxpAPPG/id7eIQyctCZ591Slzif3toS9fgit
	XgJFS5PirmBf6rhnGx6W924NZY4ci63e6pzECF/hq2thsxtDbLYhVah8GiJICSOGuhfFEwG8Dmt
	R1+4A=
X-Received: by 2002:a05:620a:28c7:b0:8cb:3872:bd62 with SMTP id af79cd13be357-8cd5aee64f2mr442982085a.1.1772700067629;
        Thu, 05 Mar 2026 00:41:07 -0800 (PST)
X-Received: by 2002:a05:620a:28c7:b0:8cb:3872:bd62 with SMTP id af79cd13be357-8cd5aee64f2mr442980385a.1.1772700067211;
        Thu, 05 Mar 2026 00:41:07 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66157d35cfcsm394173a12.22.2026.03.05.00.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:41:05 -0800 (PST)
Message-ID: <dea45e4e-aebc-46e4-a245-3603da1779f3@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 09:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] wifi: wcn36xx: add support for WCN3610
To: Kerigan Creighton <kerigancreighton@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com, wcn36xx@lists.infradead.org,
        andersson@kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260305003253.1022386-1-kerigancreighton@gmail.com>
 <20260305003253.1022386-4-kerigancreighton@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260305003253.1022386-4-kerigancreighton@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ctu-X3ffew3bFw4DC6QKTpb9SJalBT1B
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a941a4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=teg4DUnw7xCSCHTInWMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA2OCBTYWx0ZWRfX3fS+ngjfy2Eg
 mmSL478LV3JErJ6pZHoBklqsReg/ZyqPPjFurAxA0MNw3VLQ45v8YOfl4N/8C2RHE26S5hTrJd9
 3er/EcN9yrbfEwQfTv3HdKNR17jJNSiMkPJ4Qj8iCLUgaCzWNES05uWfhUVuxR81VUlGpXb9/cd
 EDa37vUsS4Ini4LZ1uoXqRRpEQm5O9fPnLklu/BjtV2sHsgD3s0FjHM0QbyupK7AUzUouel2DHW
 hJj7ac018Rzf0u9zSXwLy3ekjDQd0ONCB0M4ho8tsL+vCAPBmOZwbIzumK8ZBK8UKKJxpoIOMVN
 4F+WtBPls8Ysolv4hF8JQp+Ab94HT4NOGySzG40iR8mmU2C1p2FvaMxisjYm1G6wmtQlSzS760m
 q7rNnNMUimfilVAKVrvPPoW7apbZp3Mf4dkhTn+qSCGjlQMVp7azqlq+vFcCidCDnvMXM6hY3n/
 43rAnuCLn+1oQ/N8SMw==
X-Proofpoint-ORIG-GUID: ctu-X3ffew3bFw4DC6QKTpb9SJalBT1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050068
X-Rspamd-Queue-Id: 69B2D20D9F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32499-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/5/26 1:32 AM, Kerigan Creighton wrote:
> The WCN3610 has a lot in common with the WCN3620, so much
> of that code was reused.
> 
> Tested on an Anki Vector 1.0 and 2.0 robot. Support for other
> WCN36xx chips has not been affected.
> 
> The WCN3610 requires specific BTC configuration values for
> stable Wi-Fi. Without these values, there's some packet loss.
> An extra CFG table was made so other chips are not affected.
> 
> STA_POWERSAVE causes firmware bugs (long hangs) with the
> WCN3610, thus it has been disabled just for this chip.

Is that something you've observed, or does the downstream kernel
mention these issues?

Konrad

