Return-Path: <linux-wireless+bounces-35833-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCJEO7SI+GkZwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35833-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 13:53:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5504BCA67
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 13:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81E8B30162A0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF94E3C13E9;
	Mon,  4 May 2026 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWLzZfQs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqvoFhOK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A336604E
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895594; cv=none; b=cNlFj9vg6ZCIJUECGeMbDKalY9SrvksFOzzLpXCbE1mMc0PlbUQfHJ/MtOlhM42k7R9zVPburwEAD7i1469fp1UlrJMYTXsH1sQxB8A1mqguVCYxxsPCSPT4OhLc1lKVrrBvut8M7pHA8lKD9sl6fO93TnAhZP40KeJUUxCDAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895594; c=relaxed/simple;
	bh=h+f4WvNTMiPEVbnZUsHfPHPq+L80RhcaNVi5YLbSxL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBY8KZp2mDXURiDLz9dLWCseTGcePUU7jKHavPL14Cek/myorLVXutWXErPlleaLMzKA2CzVUbKkTsngWbe3GTfwbfiCgALQEvta4gcxRgXoPeTj61YFY0edGXxZ19uvimAUa2lb+f2g4zy0iqXAmDOOu2r1fFEQwf77sm86tHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWLzZfQs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqvoFhOK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B4FO74138293
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 11:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=; b=NWLzZfQs1QlELHxn
	Y1ouGGR/3tqN8ojHkqnjfLgF1IK/OIqHS5RHdcpzFyKtdwoP5X5r/DCZUZc7krRo
	TrF6mHKpb+/bJSBB9lQ75B6mueu3BTq7z5yc+c0NwZz++6Pg9yjDbFLpXpQ6Lyqf
	r3Kw9FxVBslB7ggKcIkMB5xb+WUTynpy2x7FvKofWwRAWl3/GRlbBxbZe+GgePjT
	Mbt09jiAlfiu3vQQoWVZl7M6t0MRbDk++4xk6Ve2bL7nSUXvzNszozWKA76jxQLc
	4dWBFjc97K98NkzUZTIsO2Gr4ad7xNfm6OJuVZfCAGgLHQ4pp/lKwlVCHumQ9jp0
	40+4dw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9g3nhv5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 11:53:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-362eb03240bso4926237a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777895591; x=1778500391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=;
        b=UqvoFhOKQfwM2AEeQKrZi/oe/GyXoN3E3PpEGufpqmNoqbGMTgPx8sVHrxowrAjVic
         WAx3W+SZe2seGi8KuRB01FivhYqtU7oe2182dAKqWrlp8wLsgjmJ9ERq3G7FHgYU82vA
         NjQmqsTdhc1qLET0HeGW2NyE5YEShNxGdmPToUAOdVdiJORXxu+2/pmOIWRd1VO8vX8R
         QyHohR/19GuhkkWEj7HfJdjhmUWnQIquC+zX8MX/5doOw9/So3VcKelOxQ6afHgqnNKS
         zWdY3NA9DaYvC+WoT/nlSEHegK5tpopELhy4XUcB/LWFHQLixS9fbeDhwcnKqDRZ6cvc
         dwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777895591; x=1778500391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=;
        b=Qz3As/fq2hvbcqX1/QBxgcxAG1hKC/dT+jN7cxBBacnY8AlTtcWdk68nTNDDU/fFBu
         tqWfi4b1d0yR8/VGMOqY357CTonhor8As0sirUTt6hl0iBTvfP9eX9SaqqMB8KeRRL/f
         ZS8uXnMZDQJKPu4dtnZoBud01PE04PtO9NCJpB4Wz1Sb2+PtQ9M1jvCUPNrvs+ZDeHzM
         r2xcgukU9jw7KEUFrhgKeKDTTlnJ8beanGYhGgI8QdlSrOqweA/VZLE9jufyjegQwiV4
         uNVDoL+I+w3yQSR8oaEw2IIBpJkpy4PbcUJgNpN3GDHir1MEuVSqt66LbulP99I0bIAb
         9yjA==
X-Forwarded-Encrypted: i=1; AFNElJ+gAsIQTWSdPAdoeqGq9btfdmfOTgeJOXSHUDStrkXgoPxKIG6eiE1ZqsF5Ayv0j9pWKmweADMwnv3tzxJzcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWn/2oK/Ptq7E7Lr8Rc5UMABrbLGC/lS9T/DIN8MZEqsZbIYR
	HKSngshXGQwNz5/FfW7HSQNnLQY8gOkcZC7/EezbFQGoE5kof9mpOvr30VnmXRMeO46jsKHucKU
	MdUfZJ6SxzPV4IslrFqMV7Q/cCD4aQihXIw7I6m5MjR5Jh3fcb+CgRwUxafIzeZ/BLZxmGg==
X-Gm-Gg: AeBDiespn8Fixdar29jSTt855sqct9AEnkkOiLmACpGyhYCtL3M9cN10GVpBhjkn+Qd
	WEL41Kp4YfN4PHAwBgv01csbXvNlfg6NE9y+0X+i/cf4KJyjYGsQVy0T7JdizY5UvrOKJUODgfe
	tiXyVNlTzCEP+KIDlQYrVu+F/B4k4qg/pxuQqWiw47AuZuqWSg/bahkCACaZzjkzietaLo+hwvs
	1hBY4erUPZ+57tVgHrBOS589l1CfN77Rd4M4BD91lYdbw8DIqR6mv9RbGWOzDxUUbxLx/5R0A/D
	P2VsDbpAXDsJM5RWNB0BuHvsTKUhqMBX2STjXKTlz9VMu97ZgCSKPzrXFrliofiq+2LFBK/N/yQ
	dpJLnkcT9LkXKVjW7/VFoEFzLc/L7kxJMK8W91ggPQlmPf64hPTh7o+s8/xegyDY=
X-Received: by 2002:a17:90b:4b90:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-3650ce4793fmr9409755a91.22.1777895591031;
        Mon, 04 May 2026 04:53:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4b90:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-3650ce4793fmr9409732a91.22.1777895590521;
        Mon, 04 May 2026 04:53:10 -0700 (PDT)
Received: from [192.168.29.116] ([49.37.150.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec02ab2fsm11431599a91.14.2026.05.04.04.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 04:53:10 -0700 (PDT)
Message-ID: <6515558f-99c5-43c4-9141-4bd4a2be6317@oss.qualcomm.com>
Date: Mon, 4 May 2026 17:22:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
        apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
 <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
 <afiCrIYSm8AK9xn9@sumit-xelite>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <afiCrIYSm8AK9xn9@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyNiBTYWx0ZWRfX2mecj4ACnKRc
 BuazN/hLWsZJS7IKqZtZEzT8g/xcdPyQsvX9q92Vi8qfRgYlmKIuGuWO2/JNHtcnrsVHahkhKBl
 01vvLOOwopcWlISLSw8grF1infsxwqSzlqrEqJ4i0lFi9/5q5/ureCz9afIrCHUgrDxRwlL0eFh
 vNHCL+muCAz2f00mlsE3a2qNVLwWDUO0ebiigdLY27xkluKFsV9KO4oWUikHW8aNFSX7qOvITYz
 RaI2ApHuk+BcjAy42/H8Ot0UPoev5ZhDAsZNyX8dCpu5VVaI3XSkQmuYQcmgUtW1kQyxZ5j2TMu
 u91GuXgTpN2nl6NyC5+3KBF2o6ByhslMiYeHW7qcBxBiyj41cXGtJNarvSA3DBVSeufbRAjqbZs
 WCYBVLSRJf/9LJolkoqp4QsrK1US/dOaN0ZlyObdzoO08nWchcF+8iBTUdUqSzLd+S5AbhBvonR
 lIOrm0fHaKQ8OsZyrWA==
X-Proofpoint-GUID: _rxH9gJ66Jh0_KCIDm9GOxneHoWaqvw-
X-Authority-Analysis: v=2.4 cv=Ge4nWwXL c=1 sm=1 tr=0 ts=69f888a7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fKl8XJY0368M7tBUixYpxw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=w6fE4RYvq4DoGGcOsJAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: _rxH9gJ66Jh0_KCIDm9GOxneHoWaqvw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040126
X-Rspamd-Queue-Id: 6C5504BCA67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-35833-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshal.dev@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 5/4/2026 4:57 PM, Sumit Garg wrote:
> On Mon, May 04, 2026 at 03:33:06PM +0530, Harshal Dev wrote:
>> Hi Sumit,
>>
>> On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Add support for Peripheral Authentication Service (PAS) driver based
>>> on TEE bus with OP-TEE providing the backend PAS service implementation.
>>>
>>> The TEE PAS service ABI is designed to be extensible with additional API
>>> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
>>> extensions of the PAS service needed while still maintaining backwards
>>> compatibility.
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> ---
>>>  drivers/firmware/qcom/Kconfig        |  10 +
>>>  drivers/firmware/qcom/Makefile       |   1 +
>>>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>>>  3 files changed, 490 insertions(+)
>>>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>>
>> [...]
>>
>>> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
>>
>>> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
>>> +				  phys_addr_t addr, phys_addr_t size)
>>> +{
>>
>> [...]
>>
>>> +
>>> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
>>> +	if (ret < 0 || inv_arg.ret != 0) {
>>> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
>>> +			pas_id, ret, inv_arg.ret);
>>> +		return ret ?: -EINVAL;
>>
>> Following the example from qcom_scm_pas_mem_setup() here:
>> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778
>>
>> I think it should be:
>> return ret ?: inv_arg.ret;
> 
> inv_arg.ret return a GP TEE error code which doesn't map 1:1 to kernel
> error codes. The client drivers won't benefit without having a way to
> decode those errors. So just printing here can help the user to debug
> any issues.
> 
>>
>> This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
>> I can see that is tries to print this error:
>> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286
>>
>> With that,
>> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>
> 
> Thanks, I hope with above I can keep your tag.
> 

Alright sure, makes sense. Please keep the tag.

Regards,
Harshal

> -Sumit


