Return-Path: <linux-wireless+bounces-32898-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOziJwkpsGn/ggIAu9opvQ
	(envelope-from <linux-wireless+bounces-32898-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:22:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7F251CD9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5249E3214E6C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E52A391E71;
	Tue, 10 Mar 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pVrXf5o/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MhzLaODu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987238B129
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149030; cv=none; b=Rq/bRI0lH2OhSLysqqZR36LoFe5oSnFsTGtIBuRZojgdkXohl+aPN15HUb7TK5RP2/2aN6b5oDmr7F+YIfmAOe9K5Nv+pizqmea10POAJ+gJ5++1RgRnX/byU243OIsFyzoZVWDQAIKnpTlNKgnTHSorFxnc0XrT6inA/0Qzqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149030; c=relaxed/simple;
	bh=YD2z3hHvCix7UCDpbM2li1t6vWmITYSKd1Ek8SNEmIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kp8fyYnpCqwNjHPmOKQYKYio14BJBcY8TjIbxcD3x9jAz+It1gnIPyfLQnQyw4+OqheJqUrSR4YDsQmzFuIZ70niJH63eBKojE+jRiKpB8VUhMxg9zZxDWlWXWZWfozGbKWDukTCNl+CzXwMQSGoIf1SRV5MfUf+u9VkBX45Bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pVrXf5o/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MhzLaODu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaYMT3759633
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 13:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	orEohHfy7GJzc6faGQD96uNhCW1mOo5TuHLKgf3TG6c=; b=pVrXf5o/EVBmE+wg
	BT73Rsn6SpKJ5wq+G76Ylf7BWahcXxLYD+eUmWPFXcaWhkwUpobx5lK3xRmxITXS
	bC+3ReO12w5lG0ypF9by+SDzV7dKvczmi4V1ObY+HulYNow/9x+coIgQOc0FDR5z
	tqh/NwxX4y8wUkQqnAe2Ol0tx6qnoYrTNmZo3PQbWnPYlAZ96o/M5CShmfzCT3Q4
	AKPsiGpksVlygVdcqY4yPVfjY54SOoGDSeJUIxOABYkWnjdZlzq8wUrR88zzeQ8x
	0ey8qW+7bpHy0Tuk5wPV+wlDXL8O9vInB7v/+JNZUUTfdiow3BeHh16CYZpK3pDP
	/hjuyw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8ug6jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 13:23:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso1682196685a.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773149027; x=1773753827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orEohHfy7GJzc6faGQD96uNhCW1mOo5TuHLKgf3TG6c=;
        b=MhzLaODur5HaDKKfAJolC2toMukyCS8FTIcQbyyR1Mc84kOuPeh6mWLUb40RuqL895
         XSSrHeB1lpaj/qModOAGdNMQLa6GQx3DvspoTWxCYVUDlqpu0guLPhIy9i3R7JUgpLlB
         1T18TITDjSlSq/jNfn08f4mIrBAM0TVmlffrCnz0Q4yUtu1/18+4/Ia/9SDM7ZY4oU3y
         jmPTuvfO992/34Y1bZdZwr0EI50jdGAB3XplUbKLWKzQsdBs+k4B3qhmniQ6qI7ux8WH
         fS0MMpnt1oLrYeh2+EFlIDweXiOp8u54n6IWkfjwWcuaLe2BjTEjnsdHEAntOBgu6oKg
         pxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149027; x=1773753827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orEohHfy7GJzc6faGQD96uNhCW1mOo5TuHLKgf3TG6c=;
        b=SrJWCvCwUx4QKPj+lmCxyGQTKP8gxdRFRoY5OATrM/1sSJtsQklzOtxpFqK+JZIDiI
         pOf6eCcqcz3KasrPaLrFGdtLgc9ohhvN7B2+fqkmiuiLbUfmrpIlOIyXr7323EG8WxwQ
         qZLP9mXRijssUjfZ2TPHjzleKBL5uzh2vMgMGhO71jfod+gxnHp+9oJYB9v6kwz6swwj
         dvevx2PtC4BmwrZ09Glw5LIorcPWq5wcujVJBsei/XQCvffJLvdFgUOIc4qt2ctPO0hB
         5wYmR5PwP1iy9rC00GiUA9yJzPV1hSS4+sjSCxvQTv0TofRx9MBUgFZb0zVERrurBMK0
         8KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuJOBAIVFcMjam3zH6hl/YSTu8eGvXH12fI1MK9We4DOnpmER8/gJ0bB/UhdtQKhNWq1TFgH/2Hw0k7y7u/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YweqxUun7oedIQ0rC4o2LqHw5csmWjDOglZdmg3vgd+FEh085x7
	r8ThUcUhl+gIO9wz9VM3bVUjEZfTzddaX0LTCJTcP4MTr6evk4cdrfBmVTU2YFvHPkmiHGwX/DN
	/bWPN/hK58Vacw7i+QwKAkX56zFEwxqjccqPUxnNAAWJx4ZJFsK1Z7qr5lGROVhB4nt4f1w==
X-Gm-Gg: ATEYQzzAR9M5rcWJE183AUZtpQsW+7YvNV9edIMSovmHvDV8cFjiD41iZUMbOtp6g4T
	jrqbt5Hmgqe3LTLwqX2fbtB0lqxFJNWWtp/8ZbOLPDH5OD3BMBc7aicEWb4AiXcu72hZba0Z+jH
	JX4tTw6CnXrrW0TMwPNBYoK7dAD/Ou5CjE4+6MIkszT2TgcfUEPAMvV3uhGvg0PYLz6aRbWvY55
	ZfN4qXYvtePv+GJAuitp0rGk0ycIqPiQSI9QBFBygg+d9lvk745zNfiUkCt2P9NIYfipYJyuF0B
	8mFHCjD6PkDq20r76yzYfCy4orS2/ESRMl4hvI0tqQc8dIc32BB8x8900+CWYHqaokQejKYyXDE
	/DCuxPI1URJ0EITPVgrMQQQ9bLi/ElVu4zj2IgWWes051QAtZdXwb9+ib6whLcQE7l91SDMGcRW
	X6aXo+mL3D
X-Received: by 2002:a05:620a:4507:b0:8cd:9938:9809 with SMTP id af79cd13be357-8cd99389e77mr147057385a.26.1773149025761;
        Tue, 10 Mar 2026 06:23:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4507:b0:8cd:9938:9809 with SMTP id af79cd13be357-8cd99389e77mr147048985a.26.1773149025121;
        Tue, 10 Mar 2026 06:23:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8da01sm37186097f8f.1.2026.03.10.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 06:23:44 -0700 (PDT)
Message-ID: <8ad5ecc5-ddd9-4d79-acca-41b3797f0f3c@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 14:23:43 +0100
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
X-Proofpoint-ORIG-GUID: PaToPF-CHQOk4tFVuo7B0Uq6fORiomF2
X-Proofpoint-GUID: PaToPF-CHQOk4tFVuo7B0Uq6fORiomF2
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b01b64 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=M45qCTXPNjoLw3xkhRYA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExNyBTYWx0ZWRfX/bJZfxGclpd6
 ZGH//SWQ3imZo0bIe3MwODviZwCucaIUzYMWvkKAnde7bOv51emNn5JQdeWbLenTmCqYc8Quf1A
 dcqHlXBbF+WuBQBQcMsqK3kwcO1ESvGwvP1MO7787ptSeD+p0ex43Xmj/Ip2DYqg459BJpQUiPz
 aBbhB2BE5dMP73A4j1dVVoKyC3Umnp7vZ9WBhB5pFAo11N2zTjuP3LaN7eEkTykEgyWzmeFbflk
 t2NLTH1wJk5f+meJgSuDP3+F2NlZ2fd7/g+6R91lK65tfiynAU7+2grcy6howr6MG3VPgZ3sAz0
 vpqMpiwNU4XIqAHLYu2URvBHDlhMqPM1Wx3xiWuuV9uXda3NOBVsjEVWnKUhyjmZ9VLRIEmnJ3t
 dx7vO/sLojtEsCe2TJPW6//r1g+OGQJCiWn3as7rjSITF3G3ewFH29bj1tMbIEEKmU6rc/3zt6c
 2PWHA4kdtMWbDhTRf8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100117
X-Rspamd-Queue-Id: B4E7F251CD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32898-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

I've the same number of patches fixing the copyright for each patch 
touched in this series. Shall I post the series separately and fold them 
with the corresponding patch ? (IMO the former is cleaner)

