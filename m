Return-Path: <linux-wireless+bounces-34221-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J/ZFiX0y2lwMwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34221-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:19:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7B36C7D0
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E024E31071D6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8D41B372;
	Tue, 31 Mar 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="anS9yjmU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ib8uqUBa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B30402BBC
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973200; cv=none; b=YOX+Wq8WJLOfsj8Yiw0pT1xuinSXFWNH36hvHl3grLDx1LBA9aPiqUcNlUJbpvj3oqqPAOUprTgNAcceFxvkbB7OKnuF5W2sewTqLDbWk+YszkC7G8keyPe3+/d/M/Ts+EKH7Mp+JoLBRLdN2zkRWadl30zWxTklBUMOLLw1KVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973200; c=relaxed/simple;
	bh=pi0dDbHJXEJVbZJ6ZG5ypkoytcd3rnY23wb7RUCjHYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEuRz3AHlgIBFbE2UKZy5ybX006BB+/LdKi7P5N7K4ZMywh5PB2AXE0TJ4nRaNGs8brc7eT1+LpOLQQhYHqFZ2t9X4Pq8iL0XIr8ajsYYLzB/hj/1boAKV3MOWVUfRMIfG6h4Sx/UP8qwqwUPPCt3iRo+GKMBM4bKzDescQPyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=anS9yjmU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ib8uqUBa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VFFRRg4053772
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 16:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pSWb3pTaeY95vdPxjX7UY7rGaPSlAV+QyyhLsGlJC9U=; b=anS9yjmUXJ5FvfR4
	6JeklTNPPU5LPXvy3e3FMSrPqN9si7uIUzTuBAMNeK40EZSeR/Z/0ajVMn+ioIWE
	PjSAePKV5018ajkbs+LMRLuudMch+v7uWIFchBf74zrymrStIqCRqc+wj/F7VH0V
	5j3yVgKltiFxio1cxRX0iifjFEdZ7ZOnZdlkSb7j7XJg3W/4Ns9dNcQ8T/xf45PM
	3/JhFFKV2dU3qr60NR5wgzuvtgGq5aOaI8zlD6+DN9HoXDl/x4ajnlgugx0AHS/l
	EJdEw0ZkSbL3cdJ7UBBzYrTbleWZbDE6n7Tl6U033LpsIXxQlTR9l9cBL5SvmXBY
	iaWmhQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7xx3cpjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 16:06:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso6825828a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774973198; x=1775577998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSWb3pTaeY95vdPxjX7UY7rGaPSlAV+QyyhLsGlJC9U=;
        b=Ib8uqUBaQ2+k/XEHrunDHa/hYfkGcHLYTZVblVy5UHc0muJLIDaBivFjzlhM5ZheX8
         GcMqyvaHKiUI+C2lbHmExRju9EvuuDwUm7ArmmmV/RY7hq59S8SmxSCRY6ZmwoVG1qYj
         lngS/N9tSl8lae8B7M1JEZKlerJtlODf47ldt1MDnQPX7XHxS5usGsNQa66dDeWEKrwI
         JQKeN9vRQR+jnMSurYrF9u1n5Jaeh1dAFZnGQovWe+OcMxzFE1dMf4j1l5afsYDvgY3L
         /07sKshHi3rU5dvzyp4snwP3vJgte9NQzg0p8OscK39CRXqorZmErAQF4FoM+F1ROttc
         ZefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973198; x=1775577998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSWb3pTaeY95vdPxjX7UY7rGaPSlAV+QyyhLsGlJC9U=;
        b=U8XlimUK7Y6j6Xr+VJi+qYS8Lp+9EwcZt8Tmj5jJ9S4TD18H9tUZTn+ICA3PooTzRr
         pGP6AgZT5029Cd+QsFY2KHspqFeWL75HhWjw0egMt7MVCOMzW29GRuztQNIvb4CAgh3O
         tlJlIkOh1zp3dBw5/Oxc9Elm87zZML4AKNRC3O3v8Vg2AxfRdAzLiTUG61Aeqo/O0iAz
         Ftd+u5odWvaVYP+s7H9ckOcJueVSPbxOGYKALw+oZpRDwq3G5CD6H4lO6GYfOwPf+Ece
         Ip46rMS5dYo/9nughOyb0I/NaI01RBYdxx0uQocrWnGOeGod67iVj2FuPLB+/pcVB3M6
         ziqw==
X-Forwarded-Encrypted: i=1; AJvYcCUZvF4zQeBgjz2JG3YjG/f/eBdJxUO1UIdJz1XN8IkC2sP/hAC8UOL9IoEHam4N2XnxC4ipmyM4S+hjLcyXfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7HBMor1nEe1FvzKMVLgzoHbiCOow3mgi7PXQwCmIV88RDA/q
	tzD0xlQge0kWnsRIsdUkYxFQkAkDzZwJwoseE5ySpz5bYuonQFIV+ZpUFDGVO4QDMiCx/N6VEfM
	ryfenZ9Ri/YqbT2hNsPLjC94V8UONwXO+4DDcdrr2cvMVMBh6IABdYH1HDICucqp7F9Z3Og==
X-Gm-Gg: ATEYQzyXH2liQdcQjeSJCiBx6yS4E++9TwRzz1Pyl5CB8R9d6xo4FQKLFLp8HWrk1kI
	PBb8z8XBanHf35ZGY+mCzpxKRTBVEMRlfQy8ybOGRLmeUeN+VAXG6Anj/Zlz+xusAPzHR2Iq1lS
	zJA0jUrkA6iOJflyZ15IX0hsH8sz2ERuhbEimZKkc1hpnuxMRwawTtaIa5YyKsyzk1ud2v+vJKq
	cFkLtquQhzFdadY+WEOak0ih+S3ht6FcOUw2PLFGw61TJd6XVTylsksY0V6xRl9YT8YU+Aw4ESx
	P7UvdUg3Q/FNJt1qPLil2KOdj4RJK+hEq6YXk+2j53w60aajjXUpx8aM/+1IxOV4YKzrV8MTRhs
	MG+yCXO7qY/Cpb4A1xHti01/vEP6tT+XsUGB0KFA4n86516P+Rut4Pgf6cdp2ZuCqF/+bxjRi
X-Received: by 2002:a17:90a:d404:b0:35d:9d6b:9d8a with SMTP id 98e67ed59e1d1-35d9d6b9fbemr9871486a91.15.1774973197867;
        Tue, 31 Mar 2026 09:06:37 -0700 (PDT)
X-Received: by 2002:a17:90a:d404:b0:35d:9d6b:9d8a with SMTP id 98e67ed59e1d1-35d9d6b9fbemr9871430a91.15.1774973197319;
        Tue, 31 Mar 2026 09:06:37 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.193.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe66f7b7sm2094541a91.10.2026.03.31.09.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 09:06:36 -0700 (PDT)
Message-ID: <1dc85067-df11-4236-bfdc-e2117da493c9@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 21:36:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] ath10k: Add device-tree quirk to skip host cap QMI
 requests
To: david@ixit.cz, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
 <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ErbfbCcA c=1 sm=1 tr=0 ts=69cbf10e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fHzH9zTiDFanLkNeTzv53w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Jr6ivFuIO4VC9FIHmAQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: N6QmkwmWyK1RkyrQHNr_xGM_wz7fd-4J
X-Proofpoint-GUID: N6QmkwmWyK1RkyrQHNr_xGM_wz7fd-4J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX2l94YHa+s2GV
 VFnAR7oV031KgrZG0eB/rI2pPKR+fOqb0W2jd//daDbhZ0vvfW1ACcw1tL5OALOI6s4QzIJXn4b
 6t5NvVb3FGpQ4hzwIw3Q1vy6caGF3KcX7ESNYPtdTjffdKNlhtc1NMRzfqVm4IX+6kY29A8bDLF
 PcySuqZfhWQYvd47eH7xA72eNq9FAstKZ8wxgawazQTeJ9IqPVSm25ezrHHFA9Lb0QFkli36CKq
 C68crVxQMOsT+95H5/C78L2juHqSyObQUHWo3pd3rVi03G06Jwu/fetykb8kSv8QLb3pE167nNN
 4+MWe6dyn7Jal9/M5o/xqqlnmpIoK4BdCLj5wekDvRQMPNsLZPTeGH2lx0wJ0U5FRC/xzWSZ7rJ
 i4z8QvoortK19g/N3SoYrcj82CTzq++JInNuZjarEKJWL63Y/VKJ4ctEFWassRaNRyyNXvxp2Nb
 Z0yiMEYK1CrsTfuHVRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310154
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34221-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C7A7B36C7D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/2026 11:27 PM, David Heidelberg via B4 Relay wrote:
> From: Amit Pundir <amit.pundir@linaro.org>
> 
> Some firmware versions do not support the host capability QMI request.
> Since this request occurs before firmware-N.bin and board-M.bin are
> loaded, the quirk cannot be expressed in the firmware itself.
> 
> The root cause is unclear, but there appears to be a generation of
> firmware that lacks host capability support.
> 
> Without this quirk, ath10k_qmi_host_cap_send_sync() returns
> QMI_ERR_MALFORMED_MSG_V01 before loading the firmware. This error is not
> fatal - Wi-Fi services still come up successfully if the request is simply
> skipped.
> 
> Add a device-tree quirk to skip the host capability QMI request on devices
> whose firmware does not support it.
> 
> For example, firmware build
> "QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1"
> on Xiaomi Poco F1 phone requires this quirk.
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

