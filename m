Return-Path: <linux-wireless+bounces-32413-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MolAbwNp2k0cwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32413-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 17:35:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 068301F3E3E
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 17:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 743FC300B461
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5447B4CA26B;
	Tue,  3 Mar 2026 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OL5/z4+M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EqmsLkdS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D637B3F3
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555670; cv=none; b=OjtTsfQoN8gRyXG9C9giwF/QWkCtRCIAf+jrwS4lBrAD+TVGBIk7Ecnb5XM1xNPZ5DCjktOOUYk9W20e6NrCGONO6eflpqhMTqmV6YZyrPrjj7bZ2oim8LjhnoIeTxJSsMiskJJmYDiauv5FzdwIq/vBKpaEKSQNdKSrPS7P+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555670; c=relaxed/simple;
	bh=tu03KBBEI/ErRwPwB5xiABIEqOf4vyUDkIaqJbPnvPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0QK/wE5hrPjMPs49kcNdmFav7xOpjk2E2Qxe3p2xuZDNrHVZtriGiyOPTX+VEvK1Owan9SkdMygyK1Z/3GcGZzuZXOSjLrPZk0mYf137a8bEozvhshAkxfEG42gX0sNjlFPZ4dqc79R3QzQfVb8SQc1CobkNSCgwsL5AoAJbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OL5/z4+M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EqmsLkdS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239nHQJ3349616
	for <linux-wireless@vger.kernel.org>; Tue, 3 Mar 2026 16:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ozu+ynKxNhmAJ+fjkxyOdNKsSDbe2FYxe9s9wL43s0=; b=OL5/z4+MaekloUrv
	6/v6WhZ7htE2ZNpto848kkr2H4vZamgPyYWdUg1+Uc+qOOJVHqzCTseLi7u/xnoQ
	e3GBUL5K19oEQbbiu4lF0tW6Av3JVlESa0ICyxwzq/ybrznxKB5gubwnZL5yfCV+
	VwLaIiQfmsijX+DYafHbbfthMWCHg24lfUr9BRQEdU7hr48+RwoE2cgHECHXH1dM
	sclBUQdwbcZnOMGer1uDWPRn+Ov9ha1CPh/77wBWYoU63kwJJ+S/j04VttGrfd3J
	tZn4H4wtfNjezSyk06uBcvlmmNmT+cCPeuPk3IarjNBlEK6qOBKm24+YHk/oLBFT
	FXWA8g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhxsbhvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 16:34:28 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1276e71652fso10237002c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 08:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772555667; x=1773160467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ozu+ynKxNhmAJ+fjkxyOdNKsSDbe2FYxe9s9wL43s0=;
        b=EqmsLkdSb40TowwShDQh+kfAv5xg9J3k0HqKD74VldiZAR9VJZojNWjmYVG2ynSbyC
         0IOcsuncPAOtWwqrohjHFZsbEo2CQRBLIYauLg+y4gRycObKfwkh8u91XxO5nuPOEFK8
         2gxg1cAVhRw5EWBnU3WZ/8MxHprkVn4w9wqZJkWoRfEmA+esLtYdjzsW98PRAVDafcc9
         BHl3WLgF48OTp1CABqIaaHmF71n52huTZRsnn76hiwspUMRmrb0GoOyhL41VLcfCZltb
         OVD/y7AwR2f4UpwBySDw8wWWqn/vIKx7sNSTWTmhmk3GF1i4YueZzxxMlPrhFRFyL0ZB
         o41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772555667; x=1773160467;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ozu+ynKxNhmAJ+fjkxyOdNKsSDbe2FYxe9s9wL43s0=;
        b=G5PVvOf/sTpOOMFuvslhusbtOqTJ2P89L60lPsosUEMk1UURZ83cOzEDHnO/rPc7wS
         ifCgn3OHOEjMoTRukn4ZQYoQywM8hFr1YvF/wMFz7xMCCjkmgr5ZAEyKRTVKzURCxsfZ
         ZljlYW1+8znZapUnuadRIBcT/Sl/bzdi16aYpPCqTl22qKm5LLLQTo2ez1SHN3rnum/w
         Td/7eBYzX9fkS0LTSZvS2NLP1rNCY8SeowEtsBIZajtMoUF5Hm0NNr28K43734bBhb19
         sgC7aJyi5dyzDTdpALjvU3F6ELyqjTYqw8IpLVXqGDkW2d5Xkov02vlMskWo9MVjxKRN
         WVnA==
X-Gm-Message-State: AOJu0Yx5z3T8el9rfcqNaU0ZJXWQPhCix1X5qurpirAITLXZzICkORvP
	t0GSpFQfQe4fIGFhq9ksjCLIe/e7oI84NHLhFiPad2lvXEU9QIpCYSFtjYaJvLv412Vzs5zutxS
	zKWP3Il7SpdsUdtaulRt9vZLdYHrIwiFavHAp6vC5IjsdKpbVkL2t6q8cH+oXd/0a+19VXJ2Y+O
	g/Tg==
X-Gm-Gg: ATEYQzzNrmlf1NWd6y/tf59LbnJugAUFzWwI6F9htj+TfUxluH3mTvbmgWZW5TViNoB
	ZpN9vmL5JhtuA+q3glJBcn3pEaxTVIqcPkn5XgyrOV43+YRn9NQ2hEPcLASfFDOrmR4zSWYfYZ6
	KNLbwNXFiT44DqbSOVqdIl+z7EQatoh07KUS4sAT19z3g55giCEhFZpqYaA2VaDFIXhSuZ7jV5z
	i6mxbcqUTPe+D6pkBMiv9xl1GGXv2q/2ylc8K3Dg9Z0Yu1yLAqC2zAthPv20Q/Ji0mh54QLSznd
	m2TXoNf13hWgAR/X6fIETvy4T+liX6CxLgPhbzp1NpVXkx4eK7nucxnohkexQYZgFptrvXqomSf
	g4C+DS7Py3pzHUB+0S564oY1SI665Pexh/IMmSc7HCGaZzlXBeVxLi/3s4zQ+JcBCcQ9gXlTXhu
	uqlFI36w==
X-Received: by 2002:a05:7022:48d:b0:119:e569:f61b with SMTP id a92af1059eb24-1278fb93eb2mr6524425c88.20.1772555667346;
        Tue, 03 Mar 2026 08:34:27 -0800 (PST)
X-Received: by 2002:a05:7022:48d:b0:119:e569:f61b with SMTP id a92af1059eb24-1278fb93eb2mr6524403c88.20.1772555666616;
        Tue, 03 Mar 2026 08:34:26 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cefd7esm14988669eec.9.2026.03.03.08.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 08:34:26 -0800 (PST)
Message-ID: <18112483-1280-4ede-bd59-10cac700404e@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 08:34:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-next-20260303
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
References: <79e82568-e951-43f4-ac87-2319245a5490@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <79e82568-e951-43f4-ac87-2319245a5490@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5NUix6fErkx4wRiQmdbwiA4Cb3diPFOr
X-Authority-Analysis: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69a70d94 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pHSWX4R2Rjnc2m2XtLIA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: 5NUix6fErkx4wRiQmdbwiA4Cb3diPFOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEzMiBTYWx0ZWRfX89U53LYinK3q
 oZMjBsEWzwQSVsaYz4eikA7YiZi/Yl1/B8hCxOCUK8hAavO00R9XG4UIemAnJHwkSC/zr88ZRTu
 ondmQZ+Ff9hUO7zLYzX9osP+ITR/QrKBS0BY/U6FWeLYGj7IsKFKOq42dpzJog92MBR5L6xmX8N
 Q68k/t2RWxA/ZS24otb7mnneHFMElVxLkQnZ9pP2IAJURqr8lBHoTvISIZUNe1j9g9b+G+fFtY9
 9/YbTzD3Jdlh4H6jxPXGiIwNS4dXLq5DItFYpZaHMM8Qyi04Z4cIZjZavgyJmIMS4Xm6kLidtnb
 bXQ9Y3QIpYfjOx7lHVG55VPEzUiSQXSXdBDqur5/JMow9OtG8JoxY4XpyPVnZLDrSPh3LHgIwxl
 EO45SQjptIWF0Tu/Fnt46ckG8+PqvxeqCq1kGXny1QohpS5XKb+5zYaGS0BLqN/Dplu1xJ/qEVa
 SCS8dhquca2Ujxmti6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030132
X-Rspamd-Queue-Id: 068301F3E3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32413-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/3/2026 8:27 AM, Jeff Johnson wrote:
> The following changes since commit 8bf22c33e7a172fbc72464f4cc484d23a6b412ba:
> 
>   Merge tag 'net-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-19 10:39:08 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260303
> 
> for you to fetch changes up to cf7cbf97c630c3414302945617b8ac405e2b0dd7:
> 
>   wifi: ath12k: Remove the unused argument from the Rx data path (2026-03-02 13:02:05 -0800)
> 
> ----------------------------------------------------------------
> ath.git patches for v7.1 (PR #1)
> 
> For ath12k:
> Add basic hwmon temperature reporting.
> Enable monitor mode on IPQ5332.
> 
> Also a few small cleanups and bug fixes across ath drivers.

FYI the reason for the early PR is that I made the mistake of pulling some
patches into ath-next before I realized that Kees & Linux had applied the
treewide kmalloc_obj() feature, so now I need to merge so I can then fast
forward to wireless-next/main to pick that up. I don't want to take any more
ath-next changes until that is in place.

/jeff

