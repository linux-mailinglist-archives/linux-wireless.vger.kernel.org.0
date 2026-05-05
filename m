Return-Path: <linux-wireless+bounces-35951-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFy4KGMr+mkhKgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35951-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:39:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB99A4D22F8
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8726301A261
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24049251F;
	Tue,  5 May 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bf0ZZO7C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xpko1dWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD848BD5C
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002758; cv=none; b=Ic+jHgBFIP+zxc3AUfZEB6G2aYviZG0nU9Iv5NPNFZ8epOR5NkdGI5Wn7z01HUaSM8Ega985y3dCF/p3hOOvT0TAaweIQlJ7pgH5mMQlokbXZMU+DTeuMWroV4ezrjLFbXgeenrxQ9mujHWC2awoSlEQ6d2QtYGKpjVr1gM4/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002758; c=relaxed/simple;
	bh=AleSzrLxMQYxYtj0PtmXzNycxD3OgNdmjPwicCb8V4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMBR5UBxIzNby0+fXlN5a+p97Njh6K+pxl9mkqcNx7JVYEdUk55K+5NqMDU2AKaRo5i3JBm4hBUJ2mgYYGWNcwLFZROErNK85n/wcdjgOjhRZRjUNGpoPMaEQ20HIiZnj95mjuN5FEtxZ0kIM6LeE/kxXD+or/LK43U7Kp6RGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bf0ZZO7C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xpko1dWo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Do00x3475631
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 17:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GzxSg+UtAUbvfzs6wPQ/BzwuEGq1hArc6XVcSmErUxA=; b=Bf0ZZO7CTp5xKJlS
	pYfdIxDieFusiEU3vNbzw5qHKI/h9usn0hncJ4XvFgyC2sMH7rgT+vborKSIqt/t
	aIL1SDUJJBRHFoYaMk1EP/heKKDmX6olo1T5eNUdrXANqRAZBl/OGe6cuLLxSx22
	Ac45DqbtF2AgaZZWTPxXx7XMsTPbwWjRGR7lPUAg7BHPu8cOCEQF/a2c4jEjgbZt
	aA12eI/W/3PJmevc97dt5G07CHjpSvB2fZrgE4TWFV2/LZqo77Z6FPXuAnbAiXRi
	C8sQiuUmlk5wU1vui9g+gimxAgRD1PztsGH5b3aUxx5zemiQSH+kn/lrl18xLubY
	V2HCdA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgs16t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 17:39:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a6b13826so107826915ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778002756; x=1778607556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzxSg+UtAUbvfzs6wPQ/BzwuEGq1hArc6XVcSmErUxA=;
        b=Xpko1dWo/yurLCEHb2sBlsmsIf6HyNrfgZW6VVi9awJzdhobMdfD7Tb0nIcLxnY3AX
         251lSpQRMIAFGyywe02I2KOj+WeTIMv27xHlBwuhXT81++YzyTUVyvcsjM8MqqENxIl2
         5xgPxfxuamqoK4Yew8oXWGnz3sb9Wuw06REcysRcDVow7HklM7t9W5YrlOFravf4rpfG
         7bCvdP0/X8+t+4IuzlIHdfQpssrlfPjjBt3CBPaQzZbYaFn62/EgR04rn1wDJj9YFmdV
         J4dlLmRWAwrzPsPuGNsrlhc9DIRKG/AuFJpBe7yGxTBzzxcQjiPC83QVSMa0psooLwfD
         zaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002756; x=1778607556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzxSg+UtAUbvfzs6wPQ/BzwuEGq1hArc6XVcSmErUxA=;
        b=OiyyaGe/Yba005kp22H5TiLX82nv0uFDNtgVpuXVa+FOEYAJn8JPP1uoBpaXsz6NqS
         nijcVvbAn4R+8n+x2dIfhikpNll7UkYVGMEn8c1Nb9eOMYtxkDK4KgG8HW/ePTw99wrS
         Tt4dOBXMX1aQBF7fP1Gex+i11CyvRb3BIW9x6QiAwxhaF7rrZCPxG/vEwS1ZlNAt0fbH
         HJKTryo8sKaxdrr1555g7AE55wwEOIJxlANQwMqwbwxWxkQWSeCoGoCyP8Z5MCNRZHVb
         S49wfp+tP3xDtkolbJqp0wBZ8ShZ1nbXCRch/gZ2Okd30Y0ukRbvf+R5bMMP+n3ECVOo
         kumQ==
X-Forwarded-Encrypted: i=1; AFNElJ84DwkUg1fwngvsmq3gUCRwoelGo4TUbSOfyh3kZLkkXgLSRyjevuOcZNoVjqXNv8VYtvCVkLNXgipV0T2dfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCxJEO46lyLWtuB+dNNet0Kz4hcyqwF0Wq3KwJ7nYj2Q6XgYT
	V9p2pvQr1oiHF7hg2eAVzchZnNZQJCk1X92SMma5Z0UsORHHzDatG8uCUTydoCHbIrISCPeD/6C
	hBSVJFOYh6m0qNPRnSW6rf6U4TVqz2tyeHUrGfmgXKS7hJ0+2AU/suNCWHrAJFBsq9XYBdg==
X-Gm-Gg: AeBDievjOTxz6KFbuQfzxdfrgyGDpdLKMvhE2EJv8s/eTNGX966OWX7Iwng+WPMENTN
	ol8h5vJA3BC8MbFI+9Ba08hOO3fqURBlDBS5Y0SdB56KtLLBV0iQmwfU8jR7DUA8WA3s/PVY0Yg
	GJTurIdyKDh/+UNpS4L1j2+iE8hMCy+6X8Z74/lmtwyqtm2UqHS8TxG4O5nWKMQyXr33hDdp/Wu
	vMLnvrW22MWSPlb+eiZkwU4UUyEqCeJe446rstJr/de6Q8Q6m0jYORAfMcWE//sXoPXhlk6iW21
	xJWFLLwMQ2xoX+G1AE0WKcG7ubQuzJBsWwnrATwa4O21lfmIi/ATqR+atCLztCNcCsiPyBZLXOY
	YwfNTs1fzAvoL1HL+45lZmPj6rWaZZ7Rm6qMkF4KSWPPjVNbzuzWUFFeO9YWDWU1SwZ4fFsg=
X-Received: by 2002:a17:902:db07:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2ba53709d78mr34506285ad.16.1778002755741;
        Tue, 05 May 2026 10:39:15 -0700 (PDT)
X-Received: by 2002:a17:902:db07:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2ba53709d78mr34506035ad.16.1778002755165;
        Tue, 05 May 2026 10:39:15 -0700 (PDT)
Received: from [192.168.1.11] ([122.167.103.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae36885sm149689165ad.59.2026.05.05.10.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:39:14 -0700 (PDT)
Message-ID: <b2232118-9117-4ead-94ba-7c5435844079@oss.qualcomm.com>
Date: Tue, 5 May 2026 23:09:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] Adding NO_STA flag and reworking RX link
 resolution
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni.malinen@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
 <01295135-6bcf-4567-869b-75597649d11c@oss.qualcomm.com>
 <640192308052e60589455505d31732cf2e00b1aa.camel@sipsolutions.net>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <640192308052e60589455505d31732cf2e00b1aa.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1MXyz3I_apZRJHZ9soETqSoKziot-m3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfX+RelpUq0X29m
 toEpAvko3xHz+YA/Gbx5vSGPj1VpgekhbXB2yu0USUKfwk+T9rTWc4I/ON25YbhNkYIt0w791x9
 PuHKTCaEQ6HFo45C64KtB8H46KGu7ttUIpVDemjE4IEVzcQcHdAVGtDrXWvHb36rETejHaW/Ww5
 ip+HXFtYE+mduuf0D09mrKvkGSF+OSvAwpMe7NKcbCjkQV6eBaRrVWvckCYDGE0Xf/NIef5zPGL
 TdmZ/+OpJvYO40Vqr+2pYZQ1I1AjWPIQc8GsPdNjorbX+4SQeYmev9pZ7zn/rQ5Kh3OTOzxNqWi
 cLfNPl9z/Xf0dwwzrOSNysUpukk1wGltAlEoQUVdPFv1RPx0uFw/ChblS7u9rNTxdtRVnxwTUGA
 1rq33WsVr+IJHVO0DP/0TanTT7BHvynEtYrxrc/iEOLk0T/HV6hq5xCnr+yiJoWghhpJgily6V+
 FKsErrwcRDMfp+lsciA==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69fa2b44 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=dT6tsT/IwG+zFlEliMOpYg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=q8k5l0R3oBWqmF24FgcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 1MXyz3I_apZRJHZ9soETqSoKziot-m3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050171
X-Rspamd-Queue-Id: AB99A4D22F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35951-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramasamy.kaliappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/27/2026 4:43 PM, Benjamin Berg wrote:
> I believe that hostapd will need a bit of refactoring, including
> improved tracking to know whether a STA has been inserted into the
> driver and whether to TX the AUTH frames using the link address and
> NO_STA flag or using the MLD Address.
I agree with this design. Refactoring hostapd to handle all STA 
consistently both in the driver and in hostapd in scenarios where a STA 
roams with MLD and link address swaps occurs, in both legacy and MLO cases.

Additionally, the design should help accommodate upcoming requirements 
such as Wi‑Fi 8 (802.11bi). In particular, it can address scenarios 
where a non‑AP ML STA link address needs to be translated to a DS 
address in the STA mode, while on the AP mode the link address 
translated to the MLD address. I believe these aspects can be handled as 
part of this design.

Thanks,
Ramasamy.

