Return-Path: <linux-wireless+bounces-38785-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xdGMJzo8TmrlJQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38785-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 14:02:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFAD7261C0
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 14:01:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LqvCUEx5;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VPGvyYWB;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38785-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38785-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A53AB302865E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB01436352;
	Wed,  8 Jul 2026 11:59:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D6437864
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 11:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511999; cv=none; b=KK49c7yLAaA0vPFbmtgF9VSSfmHqRKktvL6gPa+9oQut0u8ypbSFGdPG7Fso6ZPT4zOc2FMojGK9qze9T/Z0sH0ZsDKDc2+Ac37m+Xd/C4532bGXyie00mFo8Au+KHa7GmZ1cPlH0KJXuDlPRBg4yc6kWtURb742yyyA/NFWiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511999; c=relaxed/simple;
	bh=C/m2/DbdCHnrhUblL9Kivv0lGj6MVoPArDQSKZ+UMn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ign8/MWZYidl3gmBBP7xaru6w5EJuTeebf5+4I/WPdMSRVIl8bywvnYxfNa/R9BJqpjN8mdYO86oDiaghJlIrNvcrcliv7uRCZ1bSqWRFeT3RL4eO7W0ujoPJf7YXxTEzElZUKC4sYxuoz7mPqI9TIgrZpLSvRwgbcRfI99BkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LqvCUEx5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VPGvyYWB; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668BTKtb2589968
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jul 2026 11:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TcJSnD72t3bjrI67zk7M3+keJ/xu3I6eDgTZ0AvcGpE=; b=LqvCUEx5cZNuz+bM
	1++j4xfPGr7Ff9+DdMQ6+EoQM08KPMo1uWoC06Sh32SRnqvgrrcjPeh4ZYN2PdKL
	xMYEmx26D1DepoIlUCr3hQ5NArAA4vGF+HRXiO7Fl0TGpXqPXN2MuDALmPOgTCda
	0QJQWPvqThMvMcRcWXcHsp7uMl9Y8wuQibRXJ1GtL8l81qr9G85oaIGFCX1Mc82S
	6fW9PwUCxn+9yd8AEsIg+YBGYDBhkNH5LOgoyqQpb4Bfrr7Jm7AyQ0pboPTn70Is
	/Q0VED095sS5hmNXQuc1wv84xKAe3qOOmg9n+djGK9DJvS4t/pZyfMWDBeiw2Cc6
	SQjZ5g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hgu1ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 11:59:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so11770835ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783511994; x=1784116794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TcJSnD72t3bjrI67zk7M3+keJ/xu3I6eDgTZ0AvcGpE=;
        b=VPGvyYWBOTEv/Y0b9SC5ZelOfY2LNZxpPaPpnTIGXxdktWVujLm3TeDXgX35ByQo5z
         BjOBIvoVDN++PNCKIz2KahTu28Jg6fgBzoM7/UqY49IStw8CoUkNhYkSbIqr1pscvb23
         wkJN62J7igfQHbxcRtFrsF11TbGO0FHiiyOZ8OjFEC3fn1ur65Qfj1/OWOd8TmDwDTN/
         gmTY7jW5KQCtUKM4G14wMpDAC/Y0yizgqZX83AMZxRjGdE09rbdDUzTL0j/i+lMr7YyH
         sJgsGmJwB3vXWz6pTxZPso43vswO7zEUqfQAu/DtvNRnf7uS05dutqD9cne55a+1a+Of
         IZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783511994; x=1784116794;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcJSnD72t3bjrI67zk7M3+keJ/xu3I6eDgTZ0AvcGpE=;
        b=MuZRdaLRSy9v6BGY5o4CtQ3XKKZGJ5MliJJjJbq7QrxHF6JuRmdKOwxy/pRGhognAE
         V44Kc9dre7s3XbXjzGfYSSrsGmLmXeiQvWSWCmSMKoK38cW+oytrvK5e2bOTs1lIgJyw
         pf9n1A8XjwUBGF1t7G9ieoDfydcZzcmOpDEfdAc66E74cpHGJuzieYYsKgdf9S+j2WfN
         ppA2vXaEiR0ZRsMLkXT+qJfrMUIXrwCdOBhEWpfR/cF63EOt+OSFxlBEd//JpfRVyacE
         Ibf+hdGLMCBKE1fdG6fYCYVAycr4jiQp1WyzCyZLdZ/vmKKMtPpJ45l6m4q7twcRNVyp
         ytOg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1JeQ6D2BoGFXmO9xnl0CegJV5cQTDRf63D4YuQ18LsZyLg4efxH1WxTwWqml3HYk7Uifk3O2TDG6lrOiMKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzly4wTU4pECms1JfUbP6obG3xnu+beb31OJZp4xWORwnAPzMFY
	YZV9vqiAOcdpqrS32uxKF+j+MtJd+wjX5zpgJP6SqnawbkRnD3fZk6JzjFB6RV/kosuVziCt3PM
	E1KsoGuxVcmNx1q/tsm8I5f/rnkDyFbbqcdgmn6R00YxGwF4IbiJGaJHLdjPLEQN0ARO/pHtqIQ
	9BWg==
X-Gm-Gg: AfdE7cmpscALDRXWali3dV8XfXQ/QhV2AC30s7464nUilN6aTAoJV/BknU2VuxhchHT
	zDEwK+75EThRYsOyp1l/gGRQ8c8nYQVqZpWWNngNwlnZytMSBoifnUI98atiTDWD/ZGmxmbgGpL
	13E7b2f2X0goIVfzOtFIbubEsFhBk8RIK0rkwn3MrK/8L7pB2qMG5xEfkrWIwiKDCsXDB7TJfRX
	4eS6zqgpJaDv8UI5AJXnYAam7gaCGhd/7XNa/JJxRIGTrV7bHAG7oSCfxkg32nMqSIBFRSScWVw
	6SxFnttkXjoDhaMNvKMTTRv7zvrYeQUEVBqf3rtWcI1j2a+bfCrlh1zRnwdkFmbvsqzLjmeZkh7
	Gh6wB40J5/LTqVuL78EYOnqCc+w8cy5anA4QajCVd7+OTU0TA3hLxITjy1gNGMw==
X-Received: by 2002:a17:902:fda5:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2ccea3a8001mr21827865ad.19.1783511994557;
        Wed, 08 Jul 2026 04:59:54 -0700 (PDT)
X-Received: by 2002:a17:902:fda5:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2ccea3a8001mr21827515ad.19.1783511994089;
        Wed, 08 Jul 2026 04:59:54 -0700 (PDT)
Received: from [10.168.91.130] ([223.185.219.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb7e9sm27836995ad.10.2026.07.08.04.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 04:59:53 -0700 (PDT)
Message-ID: <9bea0cef-e6c5-4810-8b79-f90ac731906d@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:29:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: release QMI handle on late init failures
To: Guangshuo Li <lgs201920130244@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260708100924.744386-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260708100924.744386-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iNoqX8GsaDNrSbcH0TkHQWve6on2U3b3
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4e3bbb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ziM92C7oNnnlFgKtw0sKeA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JK7btWPRm8zbeGui-XMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: iNoqX8GsaDNrSbcH0TkHQWve6on2U3b3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExNiBTYWx0ZWRfX+6OweZvR+qGz
 fD42SCzfO83le90Zou0XaG9s5Zly6exx0to7/sx2wCyYz9b9VGgnnDrnn5FccWN32aL99uzZiYV
 ugcA9LUpp2Q19FpiG64dar8MVa8xzKs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExNiBTYWx0ZWRfX9SctD1mc0Wnb
 Pg17kIIinogsDB+Ny+ExLx78lpASaJQhpf9vXTK6BwnTJ1Z6e1FqRMXSvU/VbPKWOoyA+uy92Oy
 Nohz0XKTikJ2vSoPqj2pVjpNSgI0EDrAEkJlb2VXvT4IM5EFNu0eWV8Qols91w4SJ9A2TNh+AR9
 OvQzSYmWjpvu9ph6zDnDavxmqovO/Ws6Wcyzled5GfzyHwXH9rW4GCJYFcvzxmUxLKgeTlwJBCT
 hnWw/dR74CZpWpYJOIL/ngZRIFn/bKEfP5iYLJVqq5qjzm3DjdEDLruLwn8XIr7j/h5aX3+u9v1
 P8jNHBrxV4nKZmiV6cm5L6wsOgQQJlvZDZtU/x0DcXzRruaNT3RcFhcKdFd8vONK6JnnRlEw7w4
 oqMd+8lwAZcSiOmoJ4RCAkT1n0EWkK3hnssyyaoKiapvMCNRpj2SiKq0Eq8QowPSudfVEyAKr4/
 bTSuoDFP1MGNMD2EUPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38785-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oss.qualcomm.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-wireless@vger.kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AFAD7261C0



On 7/8/2026 3:39 PM, Guangshuo Li wrote:
> The change referenced by the Fixes tag makes hardware group creation
> skip the device whose ath12k_core_soc_create() failed, and only destroys
> devices that were created successfully before it.
> 
> That avoids releasing an uninitialized QMI handle when qmi_handle_init()
> fails, but it also means that ath12k_qmi_init_service() must clean up any
> resources it has already acquired before returning an error.
> 
> qmi_handle_init() can succeed before later initialization steps fail. If
> the QMI event workqueue allocation fails, or qmi_add_lookup() fails, the
> function returns an error without releasing the already initialized QMI
> handle. Since the failed device is now skipped by the hardware group
> rollback path, that handle is leaked.
> 
> Release the QMI handle on those late failure paths and clear ab->qmi.ab
> so the failed device is left in the same state as the qmi_handle_init()
> failure path.
> 
> Fixes: 088a099690e4 ("wifi: ath12k: fix error handling in creating hardware group")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

btw, similar leak may be there in ath11k also, care to fix that as well?

