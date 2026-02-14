Return-Path: <linux-wireless+bounces-31827-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lwKHKPQlkGkvWgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31827-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 08:36:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E787E13B503
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 08:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B9A3028EFB
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B426738D;
	Sat, 14 Feb 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJuCy37m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eUkD9X41"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0D1EA84
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771054577; cv=none; b=nnwxpC5M81kJS1T81EtrdW35wDhh1NO1Z+9pLiHiKprnel56KgleTRSnu1JHn10cxbGpxkfMityVqc3RpCGgO5pNyEDgJUdJNUu0pVOdcBiE4d3ZoxabvlpqqncHBuCslm3vizPX5CqfrfPUndcMBDTw8Pl1ZSwtjdZTl1jMJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771054577; c=relaxed/simple;
	bh=Kv1+k8fTK33R1yTSx0gqvGM15Rfgunie668w7KFxu2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqcykGDeYzZBd7aTt9VaaMb98HnPQPqzOf9ijNYf50jB2cxZFRSQw2pejSvLCXpZmZSjbKefOyoonE6QLmEGf4p/zn1ttxcqsrZUhniNIazhi7BeSkVfgFbaHtWSwxVmj4vJXn4xKUk1NjCWvpzOstEvX2b7M4ymLPQLGQ+VBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJuCy37m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eUkD9X41; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61E4dpVb2752559
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 07:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7GrEu4FZKDb40GLC/47eDgjXD/urZmD3CDrE9EMiUPY=; b=JJuCy37mtoYi52NT
	/9VMzwtXye9bCDpp9Z7BzM6LydO3rK4teWpMbOMhMKmNhZM/6tlVUenhReLm1FQ0
	iEG50h8EgM5qj8ShkEmF+afEnjcI6ErPID+ZdoLedAycD++g4zhtghtklSDNvzUf
	wO+AaCRKrMSRMj5fUs1LtX2MWyJdKTsq9vSojmfQeU8se0YVwwznSTKTTLmkPjnE
	FWniETFNL99iz5PDYz2ZZY6PWvW/FK2I0wIJT4qACQUL9AyxqUUdjPBHrumZbEBp
	i3f/7J7bDat2IyHSN/DOIuuWUgYHGDi8UWMdg1ejatnZU6t/EPKS5+5HCV/OpeEN
	6m3Xhw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4caj7j87pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 07:36:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354490889b6so4718405a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 23:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771054575; x=1771659375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GrEu4FZKDb40GLC/47eDgjXD/urZmD3CDrE9EMiUPY=;
        b=eUkD9X41dfYwJNt3SyxRh9Jc1Y398DmZMsBTF5/icQ6b5+K8vuB770lCLo2gP7JVBw
         /yCeAAmumXPwAKEX5U7/MDiPIwfzwzz18gnj++2LmQnojlFYsKtBW601JIpJBE0GfVoJ
         u04ArVmO+ORCzAJEyNz6YN3/ERV5S4gl9GGXIHGCO4k4iefnq2zEyYCxMnyZ8z7rqT9Y
         +Dd8lzvfeKA+i1f+fk+w3ZE8N7qlgkrq4bx8iJJD6UsDdQdxPRKf+e8JmazYBFF50+bK
         Ekq6reMWbcRbu549go3dWX+dW02otTqChK+lTDT638/fR4rdoF+iqwU/xxVfzlIYiNkz
         k+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771054575; x=1771659375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GrEu4FZKDb40GLC/47eDgjXD/urZmD3CDrE9EMiUPY=;
        b=ASR6o/zMfWB6JBGZ4yaf9+3NpPj6YoQJngn8lz+zZ0+cLvdHUVzALg5b1qW9s07Osp
         jXN7Fh3wJ1ASHUIw3BkIfci/Cy07awgF8MVjdUO3isBSBDl8EMQb15BL9ujokk/XYDy8
         EW7lOSqiNcyltNhHDTpNPhKwgbd9UyhUtZe2vVk0X7Je6UIJbab6uHlH/fgLpJmMTLjj
         jP3euDwVOw9EQ7NxP/PNdOizXF72tC5GOg9245iITJuqY+iTVNeugrIU6Cz2YrtOPew5
         tKT5k5nGXLj7l2/ZQaxFhdQkzAPjzpyxEonHHt4B/+BSekwYW3MfptRD37LVFsxHZLRF
         OCDA==
X-Gm-Message-State: AOJu0YyL5tAy50wTHw4tpFSFBZgJhSl0Duqify1SZZic6CBRA/KrWyjZ
	KSXFMm0HrDpRD20wxY4DkkcTKpstXge0fv21NUeSvdRSiGWMCZF+IfBcLRhBfY5qbP2W2i+JkBo
	MBTiX3A9Zfq5pBm9R7cbsG18axFqhFCSVzTkaO0vHkj51ZLnZGxGNHRysqHh/wnq+eg4g5BQ334
	SO5A==
X-Gm-Gg: AZuq6aK43OiO5hOmNTe4tU6TXdFiuvE5dGJF3UgWUjqT4IqV/0lyCK5GqjNaXnkxQZr
	YSWGmVvUAmfUvvwqpbEn6d2flxg1aFtv/aED9AAsB4luPmyOSyKArqpCrXdPhWWyg6NYDfKBwNk
	4kC1MKA+H0hQ8WfpFylEZheIV9p0gDuVkd9fWRD/4VJHbYEQqI3lwiUQinefKnrXadKUSL9WSN8
	IvDrjeUqAxomy4VkamKwP5UCAXcdGR333pC9dPbCkkBkDKxVTCary8UzfguF0aXX+VrZEmiFCd0
	LFvgzeML7i6z0GSWXGfNtfz8jdPQDON4McF1NahFG+lS61p11BzLUaTWuQszuiJTF5YjJMJY0VZ
	H03TVbnq05maAnqnhCvtilYDi/K5h9ZZLhty8xWc2xGkNu0cAIS7A8/QWR6IU
X-Received: by 2002:a17:90b:28c4:b0:356:24f0:aef6 with SMTP id 98e67ed59e1d1-356a7a4315cmr4239309a91.22.1771054574575;
        Fri, 13 Feb 2026 23:36:14 -0800 (PST)
X-Received: by 2002:a17:90b:28c4:b0:356:24f0:aef6 with SMTP id 98e67ed59e1d1-356a7a4315cmr4239295a91.22.1771054574123;
        Fri, 13 Feb 2026 23:36:14 -0800 (PST)
Received: from [192.168.29.35] ([49.37.217.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a810b38asm3093207a91.1.2026.02.13.23.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 23:36:13 -0800 (PST)
Message-ID: <92638760-553a-47cf-8d7e-e020c82c35fd@oss.qualcomm.com>
Date: Sat, 14 Feb 2026 13:06:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: set band information
 for NULL packets only for non-MLO stations
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
 <20251127140555.472327-2-suraj.kizhakkethil@oss.qualcomm.com>
 <67b8cc599e923433eec6c8baff72583c47a53cfd.camel@sipsolutions.net>
Content-Language: en-US
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
In-Reply-To: <67b8cc599e923433eec6c8baff72583c47a53cfd.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dIurWeZb c=1 sm=1 tr=0 ts=699025ef cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Tm7PKa9qPvAg+GBNAN2/+A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=cE4WD7f32z0Ik2piKU8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDA1OCBTYWx0ZWRfX2cW/WAmazg3j
 yjBVEp+ZB1YLwg2Wn8z2DRfZ6bO23DFIpuFN8RRbj/S+1xqEbHwkReg1TloRyFgxG4XQK1877CG
 6ayfvm5r10cwgJbhthMA9DQaZWLu3EUhuwXIK/1YnNUdI7ly++sUjhtRM0JGktwS0pny41kK11U
 nQu11lX6QEXyefckhkl92QJattBJCuujH1aiiY8TzGlnUCzS8WDUD2fb5Rwg6uxrGWeLs6i4wQp
 zwmrTgTSHYVT2qwmXJmUvrNGPK7ooxu7DODrNGgjGFiyqCG/Y6gVSLqbfV3xls87347Zqwt1RND
 K+FiDyqMq90UAlSrw8jSqoxEs6AVDqFQc8uvRGxBvLQ3vUpdv7UAgCmtCp48noVGUYGYmu9fsWU
 D4I4BrZCgMYCog5k94YIlQsajKn8LJNvOpccGo7R5Pa971kgl53ZG5Itk7xcUaSYbfUa8R+xsbu
 3ND1gF19S2v5eEg/Mvw==
X-Proofpoint-GUID: 9JI4XdT6gIIit9h8J7d3dNdR9p6tLzmS
X-Proofpoint-ORIG-GUID: 9JI4XdT6gIIit9h8J7d3dNdR9p6tLzmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602140058
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31827-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.kizhakkethil@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E787E13B503
X-Rspamd-Action: no action

On 08-Jan-26 5:49 PM, Johannes Berg wrote:
> Technically "AP MLD" ;)


Sure, Johannes. I have updated and sent out the next version.


>
> But I was more wondering about the use of "MLD connections", which seems
> odd to me (vs. "MLO connections")? Connections between MLDs? MLD is an
> entity, MLO is the mode of operation?
>
>> +	if (ieee80211_vif_is_mld(&sdata->vif))
>> +		info->control.flags |= IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
> I don't see why it should be set conditionally, it should be ignored
> anyway by non-MLO drivers? Or maybe if you'd want it zero for t hose
> then do that explicitly?
>
> I'm really commenting here because it gets messy in the next patch, see
> also there.
>
> johannes


Thanks for the reply, Johannes. I have made the changes and sent out the 
next version. Sorry for the delayed response.



