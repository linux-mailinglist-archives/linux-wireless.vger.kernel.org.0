Return-Path: <linux-wireless+bounces-33316-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEyGERCMuGkhfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33316-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 00:02:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CE2A1CD8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 00:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E0C43023A45
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 23:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B53242D6;
	Mon, 16 Mar 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M9KT9F9e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MqvaL92/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DE1427A
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702158; cv=none; b=Sn/SxIlKZJPGcXkPCdRrUW8BqldBSwNSgj/RC6ufjalQNAr5oIqX/IKmBkoS+KjX9SwTDbENVzA3GcaleyX9FCh654AmGVJzklvpJ608YNgR/Z5kDVHasYHBGWZzsdHwX0gd0Q6O6YoXjWyd1/NF8cC57eUbBIkEoNDRgwK7Lho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702158; c=relaxed/simple;
	bh=mfzcGstDrFyFY2Sl2/fGkhRvhr57tmO4LPQdDoY0lXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjImiImAWci/UyrFVvAYUYc0T2gwui7KzQrfnoV+VTWpfIFfNI/6kPFT1Fhk8bmH9pP1IzwgHJ5U2cTT/ZdYH8HKEr5WKfxPAdl/1Ne39vUqtEuSc5RsRue6R8RE95HVuEsl+/AKrGXxisL1cP5Jp7EfxQTfagtubz67WFOit+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M9KT9F9e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MqvaL92/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFMpqr2314569
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 23:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=; b=M9KT9F9ewLJ/9dch
	etaL+nfEl6Ie44a0dNC5UrgWkq/vzzUcnI2g7lXs6rShD5R8IQMxzZIfgk8RY0DT
	IPjTjn8inkoF61vGENpB/n08ate0ITMtWwRGjjsUS/0qKseDdwum2Cg8BYLjGM/F
	Nq6y2sJoXlA1OwPyS1HbRgUmhl8SOUSVtJSAzMjCGjdBRJmax5gnLMMtC2XYytuM
	7zc+F6Tby7aAbkJ6vPNWLYM59K4rvn69Q31Fxcxa+fYKyaqLoOSsOPb4rDDTG73V
	zZVM3UBFpN8WgSxgNn5x9QhdoxcV3wMfgLSk+RfM/vGGCMe+TDKykn47Yq7tgSMP
	gIH4jA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxmf29bub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 23:02:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so4216068eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773702155; x=1774306955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=;
        b=MqvaL92/EhWQiuQUo4VMDUYa9jHMJrtemrtwcFjpAGHq+ZUZcPdSKWtCaGmwjLoDZb
         KFh2X04MxlFd2X3QGlRS/yBzbfmg7XWabkNtzvRBQRXLE7/8Pm5OXwIe9baLsPzoWTJW
         879HyfphWEwwEyN0QP8XtMp4DSEWnPn2z+vb5psoHg7u3SxRyiEwCU5z+dgcANy61rrn
         ZAmKY8DZmSdFGjq2dfjHfv0U0k6aKz79R81qOgY204gpbdIgCoLpz3Cp2jy1o9bLwo5Z
         /dFA9iyRUy3TtofyMxvJGTnDzV+/ug9dQFd/lY4eRwPrSPw14JtBvWpdDq51oeCvoHs5
         xhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702155; x=1774306955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=;
        b=Cy8SJLDJKxQ7OmmA9Btvnd20v6cWGqaNSMn+Ww7CiLiAD37t0EPf1JZ7/mS9ltemjl
         Uztyz2NTTy1V/xQiD4AYeAzIOlKIfK/yAvMypPvojw/PoMVp93VgXhtTJus+DrbH+yIy
         AXvx2+ZIfEHNAsehzCnviV0EotNYBfe+4GezYBMrYvlFt5qHbjp4vM3tWC1lY2IOpDNc
         vGEjSzldQgjfq+PTkOZumnCyX8a4HRg2pJlL9d0XfIY+SKHhW8IOgpjiN4PTCspNAgSG
         sfMvmaBRmX2W7M7/HIa7By4SoXbQToul0LUUXogLw/KyTLu19g3SJ9v/4deCheGLaPjc
         ZrGw==
X-Forwarded-Encrypted: i=1; AJvYcCVy9uEeU67o0yq5hzmkGmynVBkLRjGun7D+T2svbECIog+o6u2nlA5RY7kIjcmDJNWTN8pRaF2A1eTIRBfcww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yRUM5924dgpoWk7ZOQQvlW3+joO5VFsvkAZ+NZHIkYbeicPk
	ZhTkbuFK97xegO9XoyFuZc2RRUgP+e3yf9oR5oGFJBqxO0/uogFNZnFViX4oVZ+Nh+S/xFLE+0V
	EdC/Hh/P/wsZR0tzceMnbAAq7VtX0QNokoo3hdPv0WslWRm0Agl7gCd6of3+dULGXu5MNww==
X-Gm-Gg: ATEYQzwkdNosC27dYVnbo2xJDYX1AUHdfFBSNo2tUYhOdwsAZDfyucsxMTXMNL0k0gA
	kgm420VXEaS6/9N+I+/tsbRGgUer+gfxDoP3zMlzCLiSnNqsENTNvBOMGzDfisobEqDXS15+Z33
	nL2rG2RsT+FNr6RHmr5iix/p/CBTuVwXseN62VtdaLb8eVvi1Y582ikt0+C2l7PJDbCUAdhbUrm
	6sKjCP5GZUTAniXj/y4XJ4Tgf2l5QDjNKLpSWYoODNhuW0G+UZUaXmZ45qII268K4Cf8K4IcEzs
	qPyEqAzYIkt1UDfZdWHg0LJ9Ru3VZARew7xQQ7r585hnd8wnX0+HeM5n/NDTW6VtsTxSTG09/UY
	B9kNHwb+PCubf0kjEiW9kg/2V+OScMthuiCoZezf+p8sQzfonbJIRsKa1zV4Vyu+ryBzMzJcDjP
	89bC61
X-Received: by 2002:a05:7300:6ca0:b0:2be:1779:3289 with SMTP id 5a478bee46e88-2bea573d146mr6203966eec.35.1773702154714;
        Mon, 16 Mar 2026 16:02:34 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca0:b0:2be:1779:3289 with SMTP id 5a478bee46e88-2bea573d146mr6203932eec.35.1773702153972;
        Mon, 16 Mar 2026 16:02:33 -0700 (PDT)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0bbe04304sm9795623eec.23.2026.03.16.16.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 16:02:33 -0700 (PDT)
Message-ID: <3934e17f-a2fa-423f-898b-a0d89e69f564@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 16:02:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
To: Krzysztof Kozlowski <krzk@kernel.org>, Sumit Garg
 <sumit.garg@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
 <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 812qj9dqsQC7n3CBVaUfWGwR78PtN3Ce
X-Proofpoint-GUID: 812qj9dqsQC7n3CBVaUfWGwR78PtN3Ce
X-Authority-Analysis: v=2.4 cv=FvcIPmrq c=1 sm=1 tr=0 ts=69b88c0b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_eXaltnX1kRmSEBu75cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5MSBTYWx0ZWRfXz6VXY9N6bAgO
 TKOdHbM+V3RWy46QhusIkFT+QlS0U8USQMB2jh9bdKaKaAsAbTEq41aQ8/XuBFiC8AwPZWVlUSx
 cbYLR5PrdJ4dF55IItTi/fkgJXyTg/kWvsqXBfPqZNg45FbbBEM69+s4jdBYeOZs5zRgX1i9pmK
 sJW6FZhb89gmkoJjRQMOccyi24nUhyB/YAow3/PlV/LRs1G3gtICOLjJAJ7YJmWQmr4qAL4Xmku
 PddgkWbCC0kTOwh4aQJKbbqwHqwfwZBGBOWs20RILD76ztQyRUE+0lbh3Bu21qFVrOXw/04vw5y
 J7kCsLXIeneVgoi5otvflQ5lGwnYikEwc+XQrxsqCLCTcGrgb5pvn36mDdWKex/QOHFmxNFLe/g
 dNFhhLXDk1lL9Wk1gncZHbpN0Kbnlw5IZ5Z9mLvmc4JJpbH1iNU2D+31OAfiqFBI9KtwdVKFGUG
 znX1Lz2GMOf1hGv1Zrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160191
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-33316-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilokkumar.soni@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B52CE2A1CD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/2026 12:51 AM, Krzysztof Kozlowski wrote:
> On 12/03/2026 07:27, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> Qcom platforms has the legacy of using non-standard SCM calls
>> splintered over the various kernel drivers. These SCM calls aren't
>> compliant with the standard SMC calling conventions which is a
>> prerequisite to enable migration to the FF-A specifications from Arm.
>>
>> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
>> support these non-standard SCM calls. And even for newer architectures
>> with S-EL2 and Hafnium support, QTEE won't be able to support SCM
>> calls either with FF-A requirements coming in. And with both OP-TEE
>> and QTEE drivers well integrated in the TEE subsystem, it makes further
>> sense to reuse the TEE bus client drivers infrastructure.
>>
>> The added benefit of TEE bus infrastructure is that there is support
>> for discoverable/enumerable services. With that client drivers don't
>> have to manually invoke a special SCM call to know the service status.
>>
>> So enable the generic Peripheral Authentication Service (PAS) provided
>> by the firmware. It acts as the common layer with different TZ
>> backends plugged in whether it's an SCM implementation or a proper
>> TEE bus based PAS service implementation.
>>
>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> ---
>>  drivers/firmware/qcom/Kconfig          |   8 +
>>  drivers/firmware/qcom/Makefile         |   1 +
>>  drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
>>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>>  5 files changed, 401 insertions(+)
>>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
>>
>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
>> index b477d54b495a..8653639d06db 100644
>> --- a/drivers/firmware/qcom/Kconfig
>> +++ b/drivers/firmware/qcom/Kconfig
>> @@ -6,6 +6,14 @@
>>  
>>  menu "Qualcomm firmware drivers"
>>  
>> +config QCOM_PAS
>> +	tristate
>> +	help
>> +	  Enable the generic Peripheral Authentication Service (PAS) provided
>> +	  by the firmware. It acts as the common layer with different TZ
>> +	  backends plugged in whether it's an SCM implementation or a proper
>> +	  TEE bus based PAS service implementation.
>> +
>>  config QCOM_SCM
>>  	select QCOM_TZMEM
>>  	tristate
>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
>> index 0be40a1abc13..dc5ab45f906a 100644
>> --- a/drivers/firmware/qcom/Makefile
>> +++ b/drivers/firmware/qcom/Makefile
>> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
>> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
>> new file mode 100644
>> index 000000000000..beb1bae55546
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_pas.c
>> @@ -0,0 +1,298 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/device/devres.h>
>> +#include <linux/firmware/qcom/qcom_pas.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#include "qcom_pas.h"
>> +
>> +struct qcom_pas_ops *ops_ptr;
> 
> Same comment as before. Don't create singletons. And for sure not global
> ones.

I agree, no globals here please. 

> 
> Best regards,
> Krzysztof


