Return-Path: <linux-wireless+bounces-32825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HAVBDXtr2nkdAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:06:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0182249164
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D683302369E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3744D010;
	Tue, 10 Mar 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxFLJaPz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="blWS/qYp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492836EAA4
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137189; cv=none; b=Z67XezxZPBK95uTKWW1gKcjmMXFpqKad8j5GPNVuVeYdd5SagBUwZh3UaO1ezGGDl/Tsm4uQ/mW3OJgH/o4p8CsXSW5/Lr7w5Qk5M2IPHUoLAWo0ajUbA1LUre9ysZVZRVSL2EulB6puJUVVcTftsI9m2NiDEJZ5zJJYWccH/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137189; c=relaxed/simple;
	bh=g2XUM9dvvm8cVk5OWuSpx7/gOYlOEWshlkLBJaa0vAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOLTRTysYet2crEmwe1DmPHMRI1m+Ge3sJEQVPFDlakvi2bu14alGnXO/G/EiZFQTqU299m+xT9hhbPbQMet7hSTNOQvOxSFF7W8YdEiEF3YQ0m4+sJ8ZOqR82NFHE+Z/a0cJC1Ag+sJ5vljKnAyg6ZihWhhoSvbbWW+/c6tVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxFLJaPz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=blWS/qYp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A8h7Xt2754160
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 10:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zym8eQRUnoxy0/BAjJ8cuqc0CkUIHWRkqrzGNeSb23c=; b=hxFLJaPzisZZN+jE
	+7Pri14DDd7KUEvIaQZDPIXFcX+wCQndBf/2rnxMD3KjDF2LSRo56TcYutc88uU/
	vRgGWaD4jQRkDk3jG+MV1j1IkaYJZp3VdS8bRHr7bSXu6B3yME9iAtPKWgcFTrPC
	YHCjdpoIoEpVEDbNd+XQ8QpXs/d7MJcLwMQKH7hJabjPmitf2vkM5quy3YlwPx3f
	NEHENaRFEFR8Aom5OuVVbSZ82XJUu8R6EcvuTeoRmkjdHj9Cw1u9kfyqyX2cNsLY
	Hvj+bMa4eU1F7DnjQrK5jiyHp48hiSndNP4UqB7+sVMSKIZnTDilIS0OpDBWzNPf
	Th8iDA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1mraj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 10:06:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd83cfb36cso1576172085a.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773137184; x=1773741984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zym8eQRUnoxy0/BAjJ8cuqc0CkUIHWRkqrzGNeSb23c=;
        b=blWS/qYppNAmudHj5Uj16q4jA1HzAbdaWt2z13KrwkOxRlY+ntAi7v4dOTI8tbCOLg
         cVUWmiTRJov3m95ENWw78LeKWQfU7rsY0djPphO4T6B3/YSwe+edTJP792M28k/nPOvm
         LfyC5iqaS0usNyAci2kpB7gv2B6lRR504V2I+AfiaBxa8DZMQEf356+X8yeEVcepXcOO
         YUWlHdT3q0GB6GlG6azKyu3lcxYBgDgH0yS7YW558HaU2OL1mr1mB4jgdQAi8GEqSkTA
         OkVLNolfYey4QSbBOt410ehitdd06KJ63TLskNM8LOcvXGYG5z0HPzUwQNiL04WUOA7a
         eGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137184; x=1773741984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zym8eQRUnoxy0/BAjJ8cuqc0CkUIHWRkqrzGNeSb23c=;
        b=W2WviWo1XQH7rJupvOjhSauDMn8AN34kSsI/gwTLy1fwh/6OXUqdue33wkopgYMe9V
         Gxe+YqJFiHz7IjViJt4GKtdBiJ6pvttGGbBSRE13/jPf6aqrTbE89ohF7U3uo9Z5rk/4
         HF/HbF1S2EFhl7p9BXfWJsyvWKQzwi4M4sw0qzF18RtVfuu8lMrpmiAI2XZ47BKc2cAa
         CpDNUoanUkN8FAKWzE7wduPjLCTb8B6K1CAndIsewC0a3OMlPBlQGjQckoJK4ajs+qPA
         ojurdQ9ZATlu0DxmdS4t2e3QuJ/C5etwvQYNOSNTsfzdah2rIbM7ArqNaTrc3ZYwP+jM
         T7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW+aZ5EegUGLqK17w/wmqpoU+rEoGz6TZFxnkm9+Pk0h31MW6d6kxi/QlkR7hr5mex3nKCFAfN8BQWzH1nMzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytzRIem1yUM/f4/HPP/Y04Ery4sb24wFdThUHaTikqSWvOl0ow
	WgOkE6012v8GfPg0gQDW2r1Y/OBHonjfFJ7lAh3yrz4LGC6Kx77ajUSF2iGeBNR2kXBOyb0Okg6
	/AYO2F0S5SAPvCOfNAvWEEMIQun5pJng9S0zlkAEuT1ThMsZJDTasOKfYLyIHW0FWqhD6aw==
X-Gm-Gg: ATEYQzzG6IDoxxlwXYVSYo4vVed7ph6pzJnXkB5fsW0lX3+EcLOrmPgCuDS3Loxaz9c
	6rn7rQCcaIU6AgeCxi1DeG5tELj4x0/iA9W4zUKaXH6nzzilEMlfJEhOLLNKkV7lZWECRnAe4F9
	bkY0rWtdCj3B/Tp40hznN4UdkDEH8vLBnMltPXrsq3xpSjklP4qggH6HjTX2QYzmMN9q6bek5cU
	/QB0Mzbtv/Ukw0uGuwkG6sI4/ZpiNhLOPl51mtiUiOgyfk7ZdL8C0kegN5hvWA0ZEu/Vb+pfEaB
	8hn9QixPJ+DbGldcpmNyE/yF2I3AK1uv18ATJtsRfSauqirx3eIoo6Itd1BtqWnJQlJkhOPA9nB
	jU/yt6Mnin5XdRS7yuvNRWnDWW7BNMNLqgkCkMsSNlugIG0cVq1mmf/HtlpR/II/iZZJMqIwVc1
	Rblegj/Fe1
X-Received: by 2002:a05:620a:3943:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8cd6d429895mr1705195685a.42.1773137183856;
        Tue, 10 Mar 2026 03:06:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3943:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8cd6d429895mr1705192185a.42.1773137183406;
        Tue, 10 Mar 2026 03:06:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm32447848f8f.3.2026.03.10.03.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:06:22 -0700 (PDT)
Message-ID: <58f49fb8-75ee-4dea-b7c5-28e89711f9f6@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:06:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] soc: qcom: qmi: Enumerate the service IDs of QMI
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, konradybcio@kernel.org,
        andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-2-daniel.lezcano@oss.qualcomm.com>
 <7d036c96-e257-460c-a91b-deee0b9c348b@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <7d036c96-e257-460c-a91b-deee0b9c348b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69afed20 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=7MBKnE05AAAA:20
 a=EUspDBNiAAAA:8 a=M45qCTXPNjoLw3xkhRYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: mF-_pfMMwq7B0tfLckVkar4CtZza96a-
X-Proofpoint-GUID: mF-_pfMMwq7B0tfLckVkar4CtZza96a-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4NiBTYWx0ZWRfX6uQnZMILbPM8
 bF447oQLAR60q4AyXqiLjJ1SSQ0Bs3SZtYumzct17zVHtXDiY3W6QNMWfi4COqkGkNqPJJ9+MW3
 HXBfEY4mQAExSTwn4najm8hJxhFs1Pn0gIhyykzb3HGtFX52lx9Uj+xh6Dm++VkytIqO2W64Spg
 9BNgzN2hiTcRECFvtR3QrG8kCzCsaU7T9r/AMxrWik1YmybTlIzHzVw06INkb/cjOGI9O1pmmOW
 2kE1wtD0C0SQtk7m4bR+m19wwrbIPJBrIyyaYOzpnnH2QbWFyrNv+tzIc+sG5lgGsbQpOHEoRR/
 cczysKmEgXuWltAfgxnDRhMGBF7k6YxDhwViETKAdVRPf4EBPjFgUK8Zup6EagwhR/cxF8rOPbN
 DCXDS7GBhQslUxT7reow3yTwM+I3ixmzRT1hl1TyhBubgb+CwMpuY6VCNl26jh2xitgkqJNQo98
 TB9ifjOAOKBLjPfEA2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100086
X-Rspamd-Queue-Id: E0182249164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32825-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/10/26 10:57, Konrad Dybcio wrote:
> On 3/10/26 12:03 AM, Daniel Lezcano wrote:
>> The QMI framework proposes a set of services which are defined by an
>> integer identifier. The different QMI client lookup for the services
>> via this identifier. Moreover, the function qmi_add_lookup() and
>> qmi_add_server() must match the service ID but the code in different
>> places set the same value but with a different macro name. These
>> macros are spreaded across the different subsystems implementing the
>> protocols associated with a service. It would make more sense to
>> define them in the QMI header for the sake of consistency and clarity.
>>
>> This change use an unified naming for the services and enumerate the
>> ones implemented in the Linux kernel. More services can come later and
>> put the service ID in this same header.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> ---
>>   include/linux/soc/qcom/qmi.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
>> index 291cdc7ef49c..b8d07f2c07e7 100644
>> --- a/include/linux/soc/qcom/qmi.h
>> +++ b/include/linux/soc/qcom/qmi.h
>> @@ -92,6 +92,18 @@ struct qmi_elem_info {
>>   #define QMI_ERR_INCOMPATIBLE_STATE_V01		90
>>   #define QMI_ERR_NOT_SUPPORTED_V01		94
>>   
>> +/*
>> + * Enumerate the IDs of the QMI services
> 
> In case that's useful:
> 
> https://github.com/linux-msm/qrtr/blob/master/src/lookup.c#L23

Thanks !

