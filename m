Return-Path: <linux-wireless+bounces-30984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7CD3BD69
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 03:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2804301897C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C024DCEB;
	Tue, 20 Jan 2026 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgdVRAhv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pj743tqb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB051A238F
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874685; cv=none; b=A3NZvcLJS/5ndNd/OBZWMIrNHP5wGSYAlp1o1hId/xNg4blRy/JC+wLf6MDlsTzZPmm8glrQpZEe0DEMZxOybMa0xD8XDARN6N09UMq8kaWhfrGxjUw1ROzSj+BPS1r+tqYVA9sUozDQJZ5einAZG1K8IR/ldVVyoWPuGhrkV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874685; c=relaxed/simple;
	bh=a27sgIWHUN3LkDpLHH4OkFpXQo8Yv9YEbqRNKHMaOwI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CJ2A5V7XvMtgduGummAfgm1qZ7PpMgF+LBsk3rHhsVd4iVgCA9AaIQyvVtoXCp9C2y4Mj+VOBwzL8bmTz5JoowlblcXWim8KZ6KWc0uqx3ifpvfmIrNV4bRvpHb/QwhBdSNptPC+cyPE55gh5owwo4eVh+sJk+7oYEFSxICn3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EgdVRAhv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pj743tqb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JLT8Na1440842
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YWVrONhNkRKop7EJAMtYhflVVIJSJFtOH6r8DMGCIB4=; b=EgdVRAhvaXXsObwC
	HkpGeOhIO+uPo+YpzfMtgsNmG+MdGHc7KOHSR0WDWAgD9rfOqgKTYhawjeBuslt1
	ENBPAnqd4FcVaDPvbTQId00EnO+gldJh2cN3TNJ8SlmX0fiu2hjh975BbsgRb+zo
	dBJGfe1McGG5vzLZTBXJbmeI+2OTVeFpVxndTKG6aDuHi9LemFfMSYewE29ig0Zl
	FYkLfacjxsozilZ63iXVlcbdvYz0eZ4jYZaW6EcH4rQmZHJYPU1wQTjwl54BP3Ye
	G/fwc9QPt1qGD1/ONDuQF55V6GWPdwl8QMBLLDl/JKvwzlTy+V8PpwWiV7JIRU30
	y46HLg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bskj3j0nc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:04:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81e6ec1da28so3729643b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 18:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768874676; x=1769479476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YWVrONhNkRKop7EJAMtYhflVVIJSJFtOH6r8DMGCIB4=;
        b=Pj743tqb2Rq+Ru/U10maixEmnLCjhzWByiXeO3SDMh0AoDiCqxWp1cpAoOIA1j8V5t
         cr9Pp+Of9EmoWvhNgzGV8Y18B4VJqU/lw/qO3pRNPxtjTj9LGkan8RuXjG0zMIMxIRfd
         PSEpnpyYjBoa+W628TWq5WtILOT89Fzipk6WYqfcGEZXDkJqfSv+LxL+udi+/dCLk3rn
         YNfNaLpBzJe2XL8W8o3WfEGu3YcXjnLex+fYeQyo3DR/XE79Rplf+5j1/Vf2aBQp6sqZ
         4TsVQFvAF+cta3lttcpQvt39JROCFVFW2THcG7+KD2UjPq8Lu/RaYDTtYmrrbOCeIwgW
         YA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874676; x=1769479476;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWVrONhNkRKop7EJAMtYhflVVIJSJFtOH6r8DMGCIB4=;
        b=GbOamCWcEBrkriXcRRQ0hSKR3jqu5gN1M2swjEey/rm5qfpsSrlMjo+5C738hLikEg
         kz+lTLgaYnvpkSKGebC+zP+tOMn8iTwSCTS/rBJ27/MRkpGWfrpBEaFpUxi/Bc0lF30H
         g1DL1Iui9DNkUihDkmZCL1gvTz2+12ekwqK8xFZ94SaHDTEb01qKBp7B+pyHwXQU4iH2
         mroLyceg+ZVSaU8Nge+wBmRdsqM41YcrtigzV3t1xQKlB8HTQLlu3G5v1t2cbjC37/lk
         L6OQkwHQCDmnDRWX9dFy5u0Yv6bj5+QdNvIyVQ6qfYSWvfSd+tSivDikojbHXbbWdGQU
         kT3A==
X-Gm-Message-State: AOJu0YzkvtZ4PkHRYy6irMxCbgNaIddTkaIlv9m/Ae9Zv54ofeXnDMQ8
	nnOF0PV6ZJ0xdwmaCuCqzxhPSP1Y/2HhkxSp6hvkGgqFvoLp6WqPhu38PsZk3cAZiZDNxn7xbiP
	muHPTz1GVZ4yIAWcWlaiAFzREbnaCaT7Odwf5XKUTv45/tnhbPP4tW4N8UsY5RXOQfhhUCseJX6
	j/iw==
X-Gm-Gg: AY/fxX4weyBL2PT6EruDY/hUcWESaeevZHXysgDQgd37Jyet1mLRYwUk+yJwoW0EQMW
	kW4R38nJBFONcrgHr1bQgSq8kU658XNMP8tfC+4rf6Ytz8GxQdrdO+2yT54eLceQuyYBCHl8ZtT
	zvLTbRiV2KlChaxOvVOcVcZVKxL0ZY8nDVoJffY++Rf9LOVYIxhHfZsuOHrm+L0OB2/sMOcMWwL
	jOfWUm/0vGreT42Leszdl9rcDuLWHvgMbPvG/RBq4y3iu1JX08cmVzv1Y8Qe7l+gvC9FUWBAe6F
	PgEN9jd5UtbluSJOAtlEtK5HYCsf+/weufutGc+w5lyz4Hmgvl5BJB7ysbMttg/02O/sWEyMMgX
	v768UWZsT+LRX/5cz5OLIMZjC1UHucZVPi/WvxJx2WMrahZ21v74TDkNZ9njepua7DUA7INDt2d
	gUYg8L6Qw=
X-Received: by 2002:a05:6a00:130f:b0:81e:fb11:96c3 with SMTP id d2e1a72fcca58-81fa184d473mr10532140b3a.52.1768874676483;
        Mon, 19 Jan 2026 18:04:36 -0800 (PST)
X-Received: by 2002:a05:6a00:130f:b0:81e:fb11:96c3 with SMTP id d2e1a72fcca58-81fa184d473mr10532119b3a.52.1768874675994;
        Mon, 19 Jan 2026 18:04:35 -0800 (PST)
Received: from [10.133.33.150] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277971sm10156009b3a.41.2026.01.19.18.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 18:04:35 -0800 (PST)
Message-ID: <11c4a76f-c484-4cc7-ace5-a44f69ff351b@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 10:04:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `ath10k_pci 0000:3a:00.0: not found station for peer
 stats`
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
 <6655c609-2b5b-448c-8cda-cb4a97da64e1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6655c609-2b5b-448c-8cda-cb4a97da64e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ds7Wylg4 c=1 sm=1 tr=0 ts=696ee2b5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=N1rzNnEruoIo7urGDNAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAxNSBTYWx0ZWRfX60Fd4P8yZPN7
 JaMQwhFw1XoFNQ6QXgrvl2wyC7TUljlVailg0nPA4jgbrC/8RRw/+Ga1HlGde6fE11duiYaeOEA
 i5842QQF8Om//y07uu6PkZjfKtmiOAE4DlW+AA9vBd7KYtMH2Ekxa0Y+buMs1yo84oXC17UaVhV
 GGRj13NYOvrVwfZKza9dGzyKvk5hgSPYPiex7pfKjXi69KCCKwY4O4zsJuuZnWGc6ZMuFzTaw2F
 KLoZLbhp/SRz5cQXHrohzFbFNX34UXg8f3TGP7mX0BtlgFx6RMX7alpG9rmnd7YhhdjqcIQumeq
 zNo9t2jcx4+UefEIZJXqIl17EmsYg+oYTW+Fcv+FgcpgUwTTL1w0zI1K7hTvNGEf/dtNpLA7etZ
 apevTP6X3TJG+friDnUwy8j/Cv/HPv/RABTJyrkfiIgFvbNfdDRCNt4Awc0wn37Q/tIKdyjIuNQ
 r8BpcmuBiOUxgDSpwXQ==
X-Proofpoint-ORIG-GUID: 2JEMkdP4apgx2uO4dha70ss-iEx59nNz
X-Proofpoint-GUID: 2JEMkdP4apgx2uO4dha70ss-iEx59nNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200015



On 1/20/2026 10:01 AM, Baochen Qiang wrote:
> 
> 
> On 1/20/2026 12:41 AM, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> Since January 10th, I have started seeing the warning below in my Linux logs, that reach
>> back to September 24th, 2025:
>>
>>     [   37.108902] ath10k_pci 0000:3a:00.0: not found station for peer stats
>>     [   37.108906] ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
>>
>> It started appearing with 6.19.0-rc4-00282-gb6151c4e60e5, the version running before is
>> 6.19.0-rc4-00003-g3609fa95fb0f, but I do not see anything related in the commit list:
>>
>>     git log --oneline 3609fa95fb0f...b6151c4e60e5
>>
>> The warning log from `drivers/net/wireless/ath/ath10k/wmi-tlv.c` has also been there since
>> 2021.
>>
>> Do you have an idea? Please find the output of `dmesg` attached.
> 
> please try
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a203dbeeca15a9b924f0d51f510921f4bae96801

wait, seems I mixed it with another issue. Please ignore my comment, it is not expected to
fix the issue here.

> 
>>
>>
>> Kind regards,
>>
>> Paul
> 


