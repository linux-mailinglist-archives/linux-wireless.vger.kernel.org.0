Return-Path: <linux-wireless+bounces-31451-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKoAEHWBgGnE8wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31451-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 11:50:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FEBCB34D
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97AA7300ECB6
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01AE2BE7C0;
	Mon,  2 Feb 2026 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dregURIr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVtycSxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703C27E054
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029426; cv=none; b=H1F3KL2pQLOIb7CJmlnIGzNBRYDx68uiU2KcBrS2fQM9sqAwG/pohkn3ledJDDpBCB9doV60sIRZiYqEAsYXwJX9FhFa4tsVR3hV8dXf2L4Mnrm2KPjam8vpBtyEwE//PgoeN+wtjuolqWJ284gfax2h8Yvtj0/kS4hxdELgLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029426; c=relaxed/simple;
	bh=VEQhnAO+B98+3I0uZrEiChq85mnbnG/kWsmWAEz5VAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AZDvy5o1uCjntKuwd/QZS3QaYSuXZBDk3vP7NkOersgTKHmUTV4D5aBjrL6N5PCLmoJPJmtRnWUR1N4MZGV4p6b1KjgMWZVQCNHDZNr3M8e3LUbfdNN5m3AaLp4ccepQi0pZiPzQMJXA5vqzUcsXPL1I0ypGDe70yeXQ86udj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dregURIr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZVtycSxB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61286UUf1571988
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 10:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XRPNWQvKbgHq4P+e5FrpuRsDOsbObBxKoSy0T4sUk18=; b=dregURIr9WF/51Jr
	sDD41WRpGiTlSaChKFeoxU5lq48wkUQXeMpGSWOwtnR925AYcHP8rEBEvUdh8KvQ
	t+7VjlbZDY2do2X98u4eXG1+SZRBymTE8oOzHSqe9p55Owjb3N05t5iC/ZUBLjXM
	9bGcnRz2k2S/hia+P5ssvuDi9/FRlhIkokjyEwvMj86SRFNSSaO2iSicxWQl8aOk
	jCITune6PQHMZgDtzWt/nV7AR5lWl2kJuX0y3iidFSWOgKHpJFdpoDEeGt68UErv
	dMI5l55/ltvoL4Akmxt7AwwZjbbkLd20fA8vqOrdx1dBPgTjTwnBb8mjW5qz35S6
	HR0ijA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1au2n3p9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 10:50:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so4594588a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770029424; x=1770634224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRPNWQvKbgHq4P+e5FrpuRsDOsbObBxKoSy0T4sUk18=;
        b=ZVtycSxB2akK62EQy1/DBCgzRPyuIak++SGJDAZOXe84QeY+HjzMoouldwv9r4PACf
         dxSUIovJfC8vpK8WtEiafkxVrtk5ZiKxqozF6zrkmd3OkAcOj3tzxBQPu5dzx0uichjC
         VTGmP6o8Cj37j3UC6nkQFU318aq15+Cgu16rlXuDtrQf7ogKYVXvgRbYsxGVvyB1YFZv
         Lq6iKcXGgCiwGY9AgLPlEImtaPpme+QGkt6H1+ZyVgHvg4t3Ih8DTbPjbEyZefj9Ki8Q
         q7x0eeSIpROV8ZexAXA3ifRHbtPTwTtwP4cUKecF9YafyE0ROcKJKXxLl0KSpXwUGwfa
         541g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770029424; x=1770634224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRPNWQvKbgHq4P+e5FrpuRsDOsbObBxKoSy0T4sUk18=;
        b=ZgsR3+HfhULb1ZtEpLatznN0WiQIKfGXIEACUgeyCOAapW2SzxrdL26UDviC3Z6LNx
         4DXJn+bmbC9Hc/feysHUYkmDmTrbhBo6UoBM0vEg39eljM4racNBI+7KedaIU1wLLyNc
         r1V2ZzTPEkVZhbTy3+v/ljqG2D49JEOoBDBsrMN96XNGbz37eviHphMKexOnaDSgcsq8
         dbVgVE1xKQsx56eG+/8QNdV/6Dpvj22Tt0XtKYid6brcX2Z7uIJY1SG+tBPi2qb2Cinh
         M4xXWB1Rp6xeegdr9mhL0Nf0NxPKImTZBlE4R4LyTMmCwp5dx3Q10GZfyn90XJ3fC0kY
         NcGg==
X-Forwarded-Encrypted: i=1; AJvYcCUF7zCXP2Pc+T58/p9iqVPSZtelrqreRu4mKzFnLsfyI5/YuqGw8Wn3nIG0hHdNpkTUyc7E4E75SvzpMgLRUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNcRRHZ+FVpX41Ha+sxSmCiYmps88ElmMjma8WT9QZNThVMLd
	LVWmw4Ykmjbgy+ASDQjp+En/rpYnqQkKSyepyCeGoeQRAZyqP1Y9j/oE7CYAu27R5fDn9qb2O6w
	3bfMpQcPV1PsEX9VHy8GFyvWUrIryaLphaG5CGT8oMRC00DSeU8h02s2rnqSMj/SbA72gxA==
X-Gm-Gg: AZuq6aIKWDHkoecOj6j6J0vTb98Odlb/KkbzsXDAWw0HYUFydRqCb9OtoD24gNDIQ5Q
	5klmSldcOeuqp8er8XwgB3dK+dvp+vh5I9GjZ9XkwHvAHwCUA87ZzcYvWgg5kfj3+Yhwz9CRTQa
	m86bQBLXdy6Y1ol1T5dT5ucU+Sz1jv0EVSPHfOM0og+TtPGn6Rq2gGT9Tgh6kb2yWYSnkNjnyff
	j9vyEJKQaf1z49o7PhfBdCCPpVKMOX5PhoiHqfh1YNxwmySP/IW8DlCtEW++lW/GcJYm87xExG0
	FXkFSKHkQoLr58/zC2xPntDigyvXFGJfKtGzq8CEbqY+yOqqwvlloMiFfaM7zXZU+2fQ5I8vcXC
	kSGDUHuHVEywJdvFtR5eAK20L0ydwF5SbfLOYPk8qyzi5Va4f2WQ=
X-Received: by 2002:a17:902:c7c4:b0:2a0:81c1:6194 with SMTP id d9443c01a7336-2a8d9939052mr81778165ad.47.1770029424077;
        Mon, 02 Feb 2026 02:50:24 -0800 (PST)
X-Received: by 2002:a17:902:c7c4:b0:2a0:81c1:6194 with SMTP id d9443c01a7336-2a8d9939052mr81778015ad.47.1770029423534;
        Mon, 02 Feb 2026 02:50:23 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e75aasm145545225ad.92.2026.02.02.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:50:23 -0800 (PST)
Message-ID: <98c47cd2-6e90-4a17-a8a3-ea2d2290a72e@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 16:20:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 0/3] wifi: initial UHR support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260130154259.265130-5-johannes@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <20260130154259.265130-5-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KSwaDz3rBUwMG6DLMGvnFuvWlShm-IbG
X-Authority-Analysis: v=2.4 cv=TtfrRTXh c=1 sm=1 tr=0 ts=69808170 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=18VrT_0FzXeENFcG8q4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: KSwaDz3rBUwMG6DLMGvnFuvWlShm-IbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NyBTYWx0ZWRfX/YSar5CSC0eI
 /WUOnMMXwdsh5t1SixtzOxXsX6kPRyoROR1NHy4a8aSwhaGuiRPMVTM4TZxJBOaDn5RVp5AoNIJ
 4ab+YOx/k0M1HDEnLasM7qaW4SQbOLYPIrXtefzHQCCZ5ace2O9RwqLJu368cF3w1szNQ4L/aOg
 rAwki87UG6uhvoTMVgij2Mq695iKAajYbDFOCHQ5dKzspesK76Sf6wVmbs2gUV8DOR7huzgvXwT
 cRPE3+45kwSYQeR+lK3MBfjNqdJEriBu57uvVu7yUyBFVWs4r28PQxSeRmQvKn+6wpgbMPM+hud
 pcZgQXuYsA155vnIGoXvPLDgY0QdQUEDN7dXvqAmGsk3Yrxo1uDaiE0mUEdx7zS3dyIcwXZ3Ob3
 To+KnJN19xWd/JDz+G+5fNQ1PoO0KZ+TeZDneh1P2lnZ2C37oQtvJdMhlocEjm0CVVZOx1avw1j
 IO+2K5hmIH7UPc882DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31451-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A8FEBCB34D
X-Rspamd-Action: no action



On 1/30/2026 8:51 PM, Johannes Berg wrote:
> Should probably just not be trying to do this while I have a fever...
> 
> Maybe this one's going to be the last respin despite that.
> 
> FWIW, I'm also working on further NPCA support, both rudimentary AP
> (just configuration of the NPCA chandef) and non-AP side. But I'm
> not going to post _that_ until I get through my fever ;-)
> 
> johannes
> 
> 
Would like to see your approach of NPCA for AP side, since we are 
working on Enhanced critical update for all UHR operation features(which 
includes NPCA as well).

/KK

