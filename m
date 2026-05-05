Return-Path: <linux-wireless+bounces-35917-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP6VF/kD+ml1HAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35917-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:51:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF54CFC14
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BF17307EC63
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE348033B;
	Tue,  5 May 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/9FEifz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HYfOPbc8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40251480DCA
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777992610; cv=none; b=oSAD8WvtDVQLtIEiCxvr5SjCvDvkQBht3i8IOcgPLXcGKoZvDCOmM32d92C39pT1ENRSGUP/bl71TXIGn+P/l09TFP0JzdsNodizqFTzMqA7zDqYhZZ80LEwVMnuab9IgRTHCmcMS56DZlOAG8END4Oxu8fonwcL/ey8W9CPjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777992610; c=relaxed/simple;
	bh=/ThHF8hJw+I5T6qQTw/Q1CJUS1knLMz9fJpBGnuPP7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCFFP5WTLt3QKr29ICk3WfjbWk8+S7Yr3KtGEDmWFBF/RDbux7w2yIRL6fyQm7FWn0XmdfoeSX7tp9R239ommkYY8iQTX/DAQTwiOyLyKchm3JYSKxPn2txknXF2Z90DrhScX/83DSW2f6aW0ORsisw6Wg98676coJG3h/DjlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l/9FEifz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HYfOPbc8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EJwlr911988
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=; b=l/9FEifzdbjK9Knf
	VYMr3kcwzNNLhbAzkKvw0GYs2OJ7sGEeOZWHWKf0cK+obbOnyvKMJDrIQJ8lgoHV
	XU/JcwvsxKjYVEKjIGZuOVpxLX4NZmGktmosZokNx+YJqslTQBCiGGl9BCYdMXNE
	crE7L0LpAeXm5vmofh7Uggtr3DCHMeTSJtLFDz6DF2o4nJfDx6jsKCqBo1yrq0Jy
	rqamtvs6nhXmQIdnBDGtNhhFEDzHZ0fsjdc6/iAFVW2wmae8RcSCd8kJi5+jxz5F
	c8fmALkBNzOLw+891xaprdQssFDUYsd3Hx7I5HqJ9STd75ldyI54mKNtTm1wzK9E
	wtw6lQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jg4s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 14:50:08 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1309f4ee96dso2949022c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777992607; x=1778597407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=;
        b=HYfOPbc86IkFt32OydKGHNPuFrJhwRBtktawwqQaL7c+EwDKjquwu1Nyfu4zfnyZZ+
         LKuOVbPuGhWk8PkIk4FQLc4XJkqLBiSb/6+oKDCRJO1nUf1rRB3wJRc/v70wBRRgF9DN
         iSVh7qluczutqvfo49cFDgf2Wz1lIfLhGgt7anZasKbS1/LTjTUFjx2jK36v4tmJw6Ez
         37ahNZZYuKLmU1b9fyeb6hZOdAWCo5JJVOTt/emCyUSI1X3RhiKqbN2MymwCQvG1UfTy
         +I0/XzR6GoghJrUAswzo09bzPtargiq16SBaOR8Tm6AIg4rFQc8rullqQrhkI0rRDcDX
         GNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777992607; x=1778597407;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=;
        b=h5ex25EoYoW/iYv+G4ree3rLyXDvC36QyvRgtpIjaHVF3dJH7VyqgrqCuq2CVAmdOx
         0+SFn7LMIayahDJXlT6uPZvsEhcFCJraNPmQQpbjBCX9qgQ157VzM/dgRZccZbp9qpb/
         xW3GMJWKI+bBZaXr1Vdqq6ggOnmzBJUT7Wfqo6LfeznLHKXEtRMRzSTb/wPDygpv4jVV
         hb/PndbTGn+P8lPmV0RgscaQq0v2N3AH+pqwoCOhaoSESaPiLA1sfNSR/uJEwqXRVlbu
         LA6Kiwv+u0WxDcbviDvrrFe89XimXLDDiapml00xwi8fuJarR/D1RRZ8l50epNOf27aD
         po5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8BziGDfMklCCpFwdz26LSszpdA9B+Ii0xOAhkUSLmG8FpLwb09l+Sj3q670xU8RYR+Aju2qKyCpKMlekrXuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCjBIpXpvC16h4VrTXD4kKMJ1I+5XQdN759mg4VhqRP/JPlLC
	pFbGkvWFeAokWL9/eDsdVVrYA9Coi/BlYtGfm0hdtjpZ2n6Jd7HPfUMO+EiWpuIt6AwKXN7zXR/
	kpz+fVRBLw1jK5EK8bYRAfnYzn3H0nQSXOio1F+vda5n/yVM/sfQvxoHDuONhFWqzemGYRg==
X-Gm-Gg: AeBDievP3vvPiee0kHkGzWEE6zC/SICmdEXQcvBzTuvJ698kwJV48hyZLkYY6Z5MezC
	w1KW5uE4kwWQabVrX8I8ydvaC4B5a/dBtDcrXujDUMOKLdf+K+TlYwCRUa1QXO2W8yMdJ0VgFkN
	4frXhapsCUclXmi60gnrzkHxQyThneoXF0z6JAl80AwvNaaZNAH/bvvDYLgRB2a0I2sQ1ljPEe2
	IuAUStFgz1mwYJwOKlSBxXaqRQ9tU7Ek+EMih+dTb2eXK7/FP6rQYq0sDPydh7uyWcMaYcMqZgI
	t5pu/WcTA/8FyvE9ePJ6SrlPJiUiFBodwj+z/UnHinZ2Eh/caod4onAbILA0FQyeyqQQi8EkhTE
	MRsI9GJTAYD7DQn2zl/bRC13uCJr+/Gl4zA/GBdhxbSSL8ZjEFokLUIrb0cQwOhR6LL8iNUFxxX
	pEltstSkz4ErySGa/E
X-Received: by 2002:a05:7022:6628:b0:122:33e:6d41 with SMTP id a92af1059eb24-12dfd84327fmr6504990c88.23.1777992607389;
        Tue, 05 May 2026 07:50:07 -0700 (PDT)
X-Received: by 2002:a05:7022:6628:b0:122:33e:6d41 with SMTP id a92af1059eb24-12dfd84327fmr6504928c88.23.1777992606769;
        Tue, 05 May 2026 07:50:06 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8279e57sm19149584c88.3.2026.05.05.07.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 07:50:05 -0700 (PDT)
Message-ID: <ae68bdb3-d683-4e7a-a27f-739214656ce2@oss.qualcomm.com>
Date: Tue, 5 May 2026 07:50:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
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
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
 <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MSBTYWx0ZWRfX5i1GKV61YCVW
 VhYwFhutzG7pPLawzn8QREzRlHEQbwZivjhuBpSp8O/uZqBDoik0ylcyldnuH3+vhRmsWxYu2By
 rMBWlILzHK3MoHvlizxu+0rXimM81IVBUhH0P6aj5OjPwiMYuNaJRV7VwxUAmS0kxvORMf6CFFD
 Zj91SnrzPqhgtQdk4XI3tULFQq+YsL6BxSrHRpfEJZbxzG2plQG1imlDHWXgtlJUHqU4ReV5UPp
 4iSGXSzs1VfvHHXBB4FHCAS98ehi3/bBvnr34FZXS5w3vKCw/zgEezILPDtbu1P/KVXZbnKM5mC
 yA6/Wu6zH5eNTGYAeZMBfHxgVchCICyX2CGys+51s/Lb6AlklmCOu18kljJbqlW+MtMhdOL/3ZN
 2hSwusE653pbf2VD4pY+QJi4oFiuF/q6UnTLrWerweFZNx67QodvkwTYUAnU5xa5b3EaehGjXCi
 QwB4ZK4/6FvCNY3V2AA==
X-Proofpoint-GUID: 20GCTGbYngo818RJoV3brtHp2LLAPTqt
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fa03a0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VMT16xk1LGalzlQIQqAA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 20GCTGbYngo818RJoV3brtHp2LLAPTqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050141
X-Rspamd-Queue-Id: C5BF54CFC14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35917-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[51];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/5/2026 7:27 AM, Jeff Johnson wrote:
> On 5/4/2026 6:06 AM, Sumit Garg wrote:
>> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>>  			 ATH12K_AHB_UPD_SWID;
>>  		/* Release the firmware */
>> -		ret = qcom_scm_pas_shutdown(pasid);
>> +		ret = qcom_pas_shutdown(pasid);
>>  		if (ret)
>> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
>> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
>>  				   ab_ahb->userpd_id);
> 
> at some point the "ret" param was dropped, and this now generates build warnings
The 'ret' param was dropped by:
8fb66931fe31 ("wifi: ath12k: Enable IPQ5424 WiFi device support")

Not sure if that was on purpose or accidental. Sowmiya?

-       if (ret)
-               ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
-                          ab_ahb->userpd_id, ret);
...
+               if (ret)
+                       ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
+                                  ab_ahb->userpd_id);





