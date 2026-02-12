Return-Path: <linux-wireless+bounces-31775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE2FJU7xjWlw8wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 16:27:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760012EE7F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 16:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AFE53032646
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E758224B0D;
	Thu, 12 Feb 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VXqkHmve";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IVuHXlGc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CC1EEA5F
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909905; cv=none; b=krRxrKI70aF9XzKNmsxgleP4fRfsoJrIx83CezWIeAU+TC7YB4xJjIHFEFT/+rIAyuxXebPK+Okk1OYIZ07rXtQRFL/fcsS/1CkYj3sj6Fy9+V42Y+Epnb/SBwVM6rspd5BlO5vyZ1Me3Op1xb8pJXifyyrZfe3KTgNtss9nnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909905; c=relaxed/simple;
	bh=vZtghbioPEYiah+MoX8gTKaFzFFJ/HaCdDIvxKcc+gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoZWL+QwRiDvIHFmpVxgfhK0QlE9LGlXhGGk1h8eJyf7WkOryJ1Y/BizJa4ypTSvTTkkKT7zBnDCS1bHzrlcfPJMpIbiy7cIfk9RPtZZJD8L6Z3ohz6JqnP+UGhCX1XAQqf4vSkBRKLNYlVna2fi/HdVFBuWJOxIFc4DCUczAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VXqkHmve; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IVuHXlGc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CE6er1652221
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 15:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M0Cmlk/Minp4VG2OAandk7L3RRoq662YgBpDU9gk8pM=; b=VXqkHmverqq1ueY2
	qtjatH82a4s1glaip30Gr85WGgCkBp68ot99Db7oXt59YBqguBLA+nLXHjtzwBpc
	6DPw47fcXX3twuO8cdMJ0EnBp22OokhZm5dzMgWwt1aZnoyq+6KzYXw6WEnvW39k
	IcTuKzwQMHpBQUI8cX27KR3g8y17DA4I5G/ViQQjzuHdOIYMETqHQFzl43sIws6w
	eAZBSAsj1YUZNYjtLPnQyNxiJJ5ZOilieGO8MUjcHy79iKoFC6Y2bnpF00Ui8PAD
	uBhTwm6nSJQUXC4hbtim1juk/ZI3PmUV1DrzzDOLyVBJbTJVL22RitPGGkeZoIM3
	/ERUWg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9gbbg9g3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 15:25:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8954a05270eso13870586d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770909899; x=1771514699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0Cmlk/Minp4VG2OAandk7L3RRoq662YgBpDU9gk8pM=;
        b=IVuHXlGcQ4sOvBCxhbABdmIc+3OJCeSmbcrnVTOejUN8MplfqQMsd7FHAh4I3vp9Jq
         DlV3eaPvP1C7Jy13KMVcDU2EH7beUDalherWZHd9GIgh+FD1LMHV7EH4KxmVcTk1+15J
         QdMW+SqTWryc1nASeiOIO/tazM79KQ7guZiXMIazMsKF54Fd1l53zFiSEQSGtqvkQbBU
         gOuPDFVxZxkMjfHYrE4WFa5eSOednA7l74v7s+NouMdyzSXBUIhgV4OUYv9l+iwM5+LS
         nJ8ZIH4nEoTAQyAMHG+yFKL/nqjwDvdYaviWdpNki3rOXSegN8rlP0LKIeoddWUgMtj2
         Xkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770909899; x=1771514699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0Cmlk/Minp4VG2OAandk7L3RRoq662YgBpDU9gk8pM=;
        b=t2ryDN/fE7b4PtrkXTsbm3lKwWzmjI/jKdeaaj52yZcnj/OzGD/yTA8Byy+X/RX1Gn
         aJpQkq9RJYc5Of/J6/jnY9o89il+fhgp6MTB/k8ez87kbTO4qzMu+/EstswV88bU1l4j
         zwREG0O/MmK0sHN0o1eqj6IhvMzra86XwUNAPWbqFkeu6J+ormtiGrqNLpAazgHc2LRZ
         exohp44vQ6BR6aGIQ+W4rrmfmNSNAy9DgQn+2s22AJTFsHc7uCYZs2cN/OzGFY9R4UXH
         Af6ktUAipJm3y0vvdIIq7GdZ0sdrSft0gcCXDOD6ZOwT3GPC4sB6WHisCjP+BWoc7Eb1
         bkhA==
X-Forwarded-Encrypted: i=1; AJvYcCWICKTlQKebYOnH0G8FFqSD5/TS1WgTNDqUr3R7YuTbdvV70EU4ziR1BxPp13yBs8pIbX0v7AfNlCbmWrqA7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXKt/K4EOypfJtb94DBxYK0aielfoYqlHiMFuS4IDRK4QNt5J
	HfUAP4jcmjbBerwFtHelt1nzK5h5TUMDKhpVG8p3OkooOBtPyGBJZD4rU282+mdHC75ct1mQBhV
	siZZMxJfm3IfOfdkcCuEy4aUNJ97L5RNeJ2ywkIUhe0qReW4Zf1/KSKKNQ5mi4Vet00/Ewg==
X-Gm-Gg: AZuq6aLYWEXVPJABSbF5e/682RoH8MapSyg/VMYbZ9NYL1ZuTBc8XxvrAcuY6VhTmgf
	sHshv7YbBrgLJ+oVGwr4cYfSQYbOKTYyEkOM+69Kbr9a9PRnkTSDwYSHJaSwyRQVErlhRPukofr
	kvrE8pm6AcfEovOrsfa/UZ2cQmV4r8yZhRNjDMAtJwhIN6XKr7BBJE0ZE+hrf9o8de9uPraXE10
	8w+nk1V+iMzWWgTiFcQcVFghFHy56Dpw6QbLXHPsHIbJE39UzNyfSDhbIcbamMR/ML81cRjFVbX
	xqvYZDr2Mz/RnAyioPWwptWoSFInBS4OHOyLe+UsbDMelgP/ISL4h7DrLT8mx2Gh4ni3L6cA8U3
	X8c5U1R+FYYNTnfmZBdZNYJNHcmnx0XmxfrnXPB/xuZm68XGW69wkaYn1ncNJPKIFotwyZCM3z3
	BJkNM=
X-Received: by 2002:a0c:e002:0:b0:897:3f5:6a9a with SMTP id 6a1803df08f44-89727aaaaf6mr34928766d6.6.1770909898770;
        Thu, 12 Feb 2026 07:24:58 -0800 (PST)
X-Received: by 2002:a0c:e002:0:b0:897:3f5:6a9a with SMTP id 6a1803df08f44-89727aaaaf6mr34928366d6.6.1770909898191;
        Thu, 12 Feb 2026 07:24:58 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65a3cf50e38sm1794656a12.33.2026.02.12.07.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:24:57 -0800 (PST)
Message-ID: <6e706170-4dac-48c8-881c-4f244a3db34b@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 16:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Silence remoteproc probe deferral prints
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
 <f028462c-ae31-4fa5-b414-e03d3a73fdf4@oss.qualcomm.com>
 <zpddlyuwrxr2rwjsyzsucgm3irtxmetyhhajptveojnmo7vcni@ntyqoahm6xtq>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <zpddlyuwrxr2rwjsyzsucgm3irtxmetyhhajptveojnmo7vcni@ntyqoahm6xtq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDExNyBTYWx0ZWRfX7MXrjnXxG5z7
 F9w1M8j46Z5Hv1asiGirH+zf782N7Tox4yUjJx2o2Af1aGabFGmQQcNMPmO3ocTuKkBjeJDSxBb
 hsEf0z4Vhxdc/H+Trmr+UsjfZ8B2pfevF43SpNzVi6jQHfr70o715e+SbBEsxJRo6oroseZcWjY
 KHltV2MA8xvrg0rBlbTWlU0vM6eWDOkxhdOTiY+680TRUWNKlDc2I9/sObonyh5FBxoQBPs17//
 QXDFbuxSmquSBxeAUOoUZ60CAAAWFCTOwLnbO/MbL+s9TsEZkMIVYjqB+eHzY1C+xYNEGuzEMaM
 jLZT9F0sNdGFXrSpv8Hgmvntcteey+9p54DIN/d2MesDXDtq63DMw+9Xbzt2Ii+3Dy1m+RFZ0Cj
 KHNphSu25Yn6sAVUB4JwAHYd34KdiJepMPeDz+CRsIPmpCiPSIHwJ1IexTq1tWiKlSQEUF2Dn7P
 AuG9ydKTyr47hxzFSTA==
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=698df0cc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=mOPo6HKdNPmMLqtFk4QA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: JkU3QLwsqz7tiBfGoQaPTPjNU1jGStTT
X-Proofpoint-ORIG-GUID: JkU3QLwsqz7tiBfGoQaPTPjNU1jGStTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120117
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31775-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: 3760012EE7F
X-Rspamd-Action: no action

On 2/12/26 4:16 PM, Bjorn Andersson wrote:
> On Thu, Feb 12, 2026 at 04:01:21PM +0100, Konrad Dybcio wrote:
>> On 2/12/26 3:52 PM, Bjorn Andersson wrote:
>>> Upon failing to resolve the remoteproc phandle one ath11k_dbg() and one
>>> ath11k_err() is used to tell the user about the (presumably) temporary
>>> failure.
>>>
>>> Reduce the log spam by removing the duplicate print and switching to
>>> dev_err_probe(), in line with how ath12k handles this error.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/ahb.c | 10 +++-------
>>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
>>> index 8dfe9b40c12626649639fc1dd9da0e5e0c2dcaf1..08d3a0c8f105b26b1548c5d6006f6ea162fe58ff 100644
>>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>>> @@ -807,10 +807,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
>>>  	}
>>>  
>>>  	prproc = rproc_get_by_phandle(rproc_phandle);
>>> -	if (!prproc) {
>>> -		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
>>> -		return -EPROBE_DEFER;
>>> -	}
>>> +	if (!prproc)
>>> +		return dev_err_probe(&ab->pdev->dev, -EPROBE_DEFER, "failed to get rproc\n");
>>
>> I'd like to think this doesn't really change the behavior, but I'd rather
>> see this that in-house print functions..
>>
> 
> I'm having problems parsing your sentence. Are you saying you rather see
> us keep using the ath11k_* functions?

s/that/than

i.e. "no"

> 
>>
>>>  	ab_ahb->tgt_rproc = prproc;
>>>  
>>>  	return 0;
>>> @@ -1190,10 +1188,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>>>  	ath11k_ahb_init_qmi_ce_config(ab);
>>>  
>>>  	ret = ath11k_core_get_rproc(ab);
>>> -	if (ret) {
>>> -		ath11k_err(ab, "failed to get rproc: %d\n", ret);
>>> +	if (ret)
>>>  		goto err_ce_free;
>>> -	}
>>
>> If the rproc handle is unavailable at this point, we undo quite a bit of work
>> in .probe.. would it make sense to move this check way above?
>>
> 
> Given that devlink doesn't covers this, but presumably cover several of
> the above resources, I think that would make sense. It would be a
> separate patch regardless...

Yeah, I'm simply thinking out loud

For this one:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

