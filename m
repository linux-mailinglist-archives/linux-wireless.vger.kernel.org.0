Return-Path: <linux-wireless+bounces-34513-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPxtIF3w1WmL/gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34513-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 08:06:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1730A3B76E6
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 08:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AECA301C156
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 06:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01514361DB2;
	Wed,  8 Apr 2026 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SCqbc9db";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZv5YBF3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB535CB8B
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628368; cv=none; b=ah8oipqYXbNalUDtLranPs0nx+4NFh5In57AvPdv4ZwwTM6kpTQsjCvMZjq3WR533oog/qrmdmaUpA66yeTN1RIAe5gwIMgTu/PGt4WUZC9aXJ3dy5QUwOattgpb2Rts/kca62QI3bTr56VzTRLs2Ra5cbTYLveFPfOkp48a7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628368; c=relaxed/simple;
	bh=E6KklF2p6JB+pfj0G9dAm/Uj76BZjD5t8kWTwUyC3X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5h83fac+OG74nasy41O36qUxNz5nijzNeVJ/AJ8J5RbPo1ATJjTycBc/LrLEotLEvUebn0nr7T7sAgcoB9WLrLnUrrEUTX0mbxN7XVIgkl8S+tSCB8uaD43Rv78JGma3ERGApSnsqSdmP9xekoXJrIPNQ7Lqc5j7u/D6XRurjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SCqbc9db; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZv5YBF3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637M3JdF1619690
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 06:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v0EWSn6WklXDbV7L1GTeMxyO36jOW5P3v4CqHJu5cpo=; b=SCqbc9dbcvjp9zag
	sXcMrMzInXJcsKcg0+8Xl8KK1RqI6vj4HzVBIQAFpmUQ5sjYObWGhR6ZHQwBqHxn
	XMZnOd8HreqbHjJdpx20WwTwZc9MM6ebnh1NoDdJtxMrLrXFHPpnLFUcmWexMZTY
	Sfg7VeKUk4/zmDJrQNlLPIzE/7mjAqXCzPh6Fy+PIqE089lBV6z9RLtbLHJnlLQU
	dyQ9EhlHAH71NWU3vHo6SUSHnbAdzhtUC5w0yYa11k6haFbcRR9vp729x8WkTsbP
	tPq4apZ0DnGjKtOXpBDUJIw64cmNRMLo2HVpXVudLOIfExcVNRnZaqFlKwhQ2mCz
	pMhoGA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrh902-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 06:06:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso12844111a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775628365; x=1776233165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0EWSn6WklXDbV7L1GTeMxyO36jOW5P3v4CqHJu5cpo=;
        b=fZv5YBF3Uew+u86Ic5YSJvO9fWGyL42q1f7/QA9a0lKZUeiGrdJqTVz4jpjjtcorjC
         lfDsz+3ORJS2FZpQSwvmqRJvTaHDtme+gNc7nAEIybm5I0KJ2M8fNnIky+rDDgTBet7R
         zEmn5qxtBg26WQi940yPIX9Y38iWFsE1UvMgu9hp9K96k24LHbS9bdIw3jLnZjJlGVaf
         0RiQ1kjC0oSB6IscGHbXbxjJeDTC1sSuuVBa06pGotJokheDCgBPBY5/euzNO4/jAEwy
         8NlKTNwh9PACTYHC4gnwtorNxRhrIH+NXVcXtViAgZWMmxyayHcoYANksVANW3BT4oXQ
         eCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775628365; x=1776233165;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0EWSn6WklXDbV7L1GTeMxyO36jOW5P3v4CqHJu5cpo=;
        b=ZC1MsTJD5f2Zqbvf6MiUka5ftjtSLuSFdD++acTmF1jMq+TxuzEhF8Vfy5H0c+w1Cr
         3sUMcnPJzaQwqmT6upxkZIqFNJ3pl8kbp4His9QEbDADXygDjgaJDZLqlLlEKEjl1QpQ
         Ri5Nr9XRrc51gQO79pE2symCDqYTuiwvyvkRsRikeCpisdUjoTLUtoxrTdvbItTE/+i0
         hyeZCBW5Met89A0V3et9KJziFrje7MxD/syri3+fK6sFM8VHG2At5wuAzaXPoWaldM5n
         hxlqL4j9J7Fd4dzFY6hEkguL7saOK/Q/sNirqEZx7LADfbG1fNiZejqmqJatuKmTqA6g
         e+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIrDU9haD5fa0FAcmKeEZXP16dJxclJhIIwFFmrD50Cuu71GYgxVct7c9n/gIdw+ygkeYQ46fUGmkVbcteiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8XTLeMpkwNSaZvJ5HgWNzXqjzTclmIATJQia9eDNj1Fwh07W
	hG5KxUu659mDmp9wsGS4ZX2hgRPXZgz2YGuzx032Nd9xW5XNlGbWdaPlEqFRdWeKzIcbhbnLv1R
	yE5wvd7xMoT3ULh96loGODP+UlxdvI6cKfTkOXSE8Tr8tPO+olenj4D5ytJwSD9VKH1LPVYKVdg
	8h0g==
X-Gm-Gg: AeBDieuhV9elSX0ZkarBQNWqJbieAHT7ZVZfpu3Eh0olmFmX9N3JEVGMz5jQudwEE5+
	3RUHDfCg3ZKHxQ9ST/wj2ekPuZkpHzxLnrJQfWIzV2PfOYlE4x13tp3zFDwOLG1bTt60O2mCcm0
	L0cRx6aBl3l0cCTgFFK8QUTncaYG5nod/TIeagOrfUBWdKOnvsGOEzJaeHiWSpQr1bgIPeGBmnZ
	EWkw6dJGzJ7f1l0T/6cbQhRvzSQMLT4twsD5bAerSIBRXacvcrkeupoFt4ujfpybpKmErMgWmMZ
	Z0+2dpe+W+D5X1iYejlPTYU++qDrJql+2hr3Y/IjpV6wRA2FOglAexXx0K2Jpk2KohXz+/sUETO
	QpxCHSyVgM02wlg7/vXcDPnBmwBlwIpWtat36Tnp78m3T9OKiKyqxz18MOdAe5wKbrw0S+cz97g
	daLdjPdmesIyBuDyBtLUM=
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr18753251a91.28.1775628365491;
        Tue, 07 Apr 2026 23:06:05 -0700 (PDT)
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr18753218a91.28.1775628365004;
        Tue, 07 Apr 2026 23:06:05 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a1d04sm25128122a91.17.2026.04.07.23.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 23:06:04 -0700 (PDT)
Message-ID: <ff11954f-345f-4865-a86e-759aa167768d@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 14:06:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <2fd84ab2-2e3e-4d05-add5-17930a35fedf@oss.qualcomm.com>
 <jnggqxqv3rjzhyevovnnxzplfhl3t6auhhvmoz7wxmsf6awgdx@dusdgxwsxvts>
 <b8277024-f9d4-4f17-946f-c2c390669067@oss.qualcomm.com>
 <exfmj52dqu3uctwsb2gopcjg7744vq5avlkahtmgfw4opw4mfl@t2svrln72u53>
 <f853d9b2-47f8-47b5-a02d-6aa8f12a4283@oss.qualcomm.com>
 <trr5j57vwk2dhoibdgdxnlkftnmfcmjkwmicsiltmhybxanjaf@tzaeeqcyz56l>
 <fasihmiu2szj6m2r3qef5slvzlvdjo2ajhrd6xyqsa5cajrbzq@a5dyulg2dnac>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fasihmiu2szj6m2r3qef5slvzlvdjo2ajhrd6xyqsa5cajrbzq@a5dyulg2dnac>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: g1hmmKL5VkGzPQCZ2sSOQ-WGTCO_Im9A
X-Proofpoint-GUID: g1hmmKL5VkGzPQCZ2sSOQ-WGTCO_Im9A
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d5f04e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=eKx4iS3zDsI69C-aG7AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA1MyBTYWx0ZWRfX9Ix0b6pMlvTv
 vAzBHy94U3U89bL5lAqa6VliO+patIhtpqObDfxtK7yhC+uzrol0iRQdNUsS7tLyCNr04PQC4CU
 W1BMkeJfnQ6uJmvFG9qciR1uJ2U3jsgroZFLL7GMT054hft+zRbLyJPUtlrOCbPp5chuwVzxtcd
 CVn2mACX8Gz/5cAxQ0gDW73pIPMUBMFae2TT1xLd+z3gbNhhAEcVNWcdEqywa/c3o/rA1CnSjOu
 +3bmCQLRonlLHWPHVqbCqsgUdMZ43ZAKhl8RNgH0dbOKOM6xsL5xTPhiAw4wIzeLciHZdkCo+X2
 In4wY0ycWkiWtQEPM8XXjNjDxS880689LchffR3lRNstCRjI6OOmvDPOaidhuivZknOAdm0TM6X
 +hZR/ymzgoP6Es8SD+9hUbBak3TmhwkdK5H1QPfZQn9Yc09a8oCNM/aUYREptmrLRDuOm/Kv0BS
 G7qK0jSqgkm2mX6YXhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080053
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34513-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1730A3B76E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 11/25/2025 5:57 PM, Ernest Van Hoecke wrote:
> On Tue, Nov 18, 2025 at 12:23:20PM +0530, Manivannan Sadhasivam wrote:
>>
>> ath12k doesn't seem to require a calibration variant. But even if the user
>> replaces ath11k chipset with ath10k one, the calibration variant should be the
>> same as it is platform specific except for WSI.
>>
>> - Mani
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்
>>
> 
> Hi all,
> 
> Jumping in on this thread to ask about how we should handle variants.
> 
> We are using the WCN7850 device with the ath12k driver and received three
> board files for this from Silex, signed by Qualcomm. All three support the
> same board (SX-PCEBE), where one is the board file to be used for the
> US/EU/JP and the other two are one for higher emissions in the UK/CA and
> one for lower emissions in the UK/CA.
> 
> Since these are needed for regulatory differences but support the same
> board, we were wondering about your views on how to handle that in
> mainline. I see that there is no support for the board file selection in
> the device tree for ath12k, and that there is some discussion on how to
> handle variants in general. We are using a device tree-based setup and no
> ACPI.

does your machine has different 'model' property for different BDFs ?
does the existing ath11k 'calibration' property based mechanism satisfy your requirement?

> 
> Thanks!
> 
> Kind regards,
> Ernest


