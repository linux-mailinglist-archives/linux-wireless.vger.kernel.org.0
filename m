Return-Path: <linux-wireless+bounces-32824-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHqnNAXrr2nkdAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32824-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 10:57:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8135C248F1A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 10:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9C33045AB0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0BB428489;
	Tue, 10 Mar 2026 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bM29PPBA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArEKpWJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9840B6F2
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136637; cv=none; b=Uy3ty8DIiDlJvo03FY1STI8kZI7RULwIf1S+ol7DHAq6QxdOB2pllI8qJRNFHbOo9KRzCFTpBs0xVATs9IMEvED6rsDE4GYO6JBa2YBU2qg8XQfr07fqGcARpH9JbdZOvdbKLXRwRLLxr5c5+rgbOqXdvE7965TrWdIC4WvGvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136637; c=relaxed/simple;
	bh=CbrtszZqY4+hGNS2oDyG5DABGwPuACbTE4Q/fV3gqfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dry0AYRHlLflOBeSX1fK8bZuLaQywI9GcKUuq4XuJhHxIzQSrHcWmhKWWKeWZ2X9rAoiPYEUaHpvbyBkF99x2c5ZUgQ1+YU8xCz53rgDnykyunt8BYavSMSJg5LaEL+pVNmt1na8NQXAYEFvFgpPoCMBHmbbPHvtCRpFMi0RtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bM29PPBA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ArEKpWJy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A8tmdO246492
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 09:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6oJ8QQt604h4CfSsQepU3v+GHYIoK3WGwrJxaSWp0RU=; b=bM29PPBAOfK0D3uO
	ml3hIfgefl30u0LjMXnpy4nUYL85G/cEds2e5/kBbiqC9ctGt0Rg9xewFlv+bowf
	xpYjgzSj4Dy9TPBlCmBXYexZkzHfOvRwjBz2rV8i+Mt4PStfAt7DZC/nAmt9Nw15
	/IGuGCecOGf3hN8IV17tfwr8mgJTSUIyftSW31id2pZu+r6nMd6ce/24ppxrZZqs
	r5rxs9J+VWOU3l0Jo8Yb7aWIKqF9nwiw5pdXy6MM24RTUDYRr+jGa2UskUuovWFO
	AA0dky8LS14sXa2uBNrJhVIdFUgWK3jNdtKlMooKWWw3+2tx11hsreyrcc0kXql3
	/YvAFA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct8801vmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 09:57:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899f6011df3so54449086d6.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773136634; x=1773741434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oJ8QQt604h4CfSsQepU3v+GHYIoK3WGwrJxaSWp0RU=;
        b=ArEKpWJyFDPARN2QSllZaqbY9HWAmwd/3Cg3SnODpsC72CEut8/KCY73tsNcL+csxu
         kDsjVGVXEMGWs2GqAHPmtLwiMdcy9bRCfw+SG7OLJT9/GPYyjNdot9WtqOL1RfhvV7SD
         WYoxZw91Lg68k6XRWkriBQYdVKwOz9FnSeBP0EHq/46dZDEpS4EGJrAhm1ZYEpPR62w7
         kXd086gX+qftHKlI8zZB9w43vZlQLTbcGQK8jAD7ENr+Tf9ZgE3oU8FW6kFfcxljubcr
         Z3Ua7ttZH78jZlZ+KC/OtTL/TcLUPx3YzFasX8sqhBFhsNDMjQ6LgA8iNTc1iTx+q9qy
         FTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136634; x=1773741434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oJ8QQt604h4CfSsQepU3v+GHYIoK3WGwrJxaSWp0RU=;
        b=NgwUlNOMJGk1DWSoOw9sfNx3DXhVoNBhzddwruDoPwfqOzix3Ecn9kqQUeLulNTxW5
         iKnt0lLOCuFCIwZEljcTqqM7KUniMENly+7YehZ7/OonRVaWYl5Tw6iDU7VWww5DqUrE
         YTHFP7aB5mDfvihOiXn9L3zyd97A/SFvY99OJJacPYBfxslaXWoYAHKGO6r0LtnE6dYa
         rIinMKq6GqA+vj8ChKic8TuQ7Iki+CApvBsLsAiB4P7Ui83jfF0h1cSxF3Lh5wR6XPjG
         Xu08QSKRdiYCxsXDTSyS34C5DOOtrPmUDDz4e/VdfeNLsjY4tccxC5rvRh8y6dCNsOE1
         dTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVktQcCEwM2W9wPZUVkK1jkUffoZqDa+M+N2N6X+vbG7DSQbb19HEIzesgHQaWxXVKxKZkkfKK+DU1mIOtXFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoU9Ix7ezE/Q3I71syf/nqqNBnJRYfE6lMHHqMw+JJeDtXFAm0
	+ABLVwvtVZMlgkGnOyTBKpy4HOjLLyl2j6fmqrC+2jetvpM2cg1mO6/gDvOziEm9okEQWvondvg
	U9Z4QuHgbuL3AOrJjrD/ca/X/Ez9lyav3kRy9LOegY1aMWyw6432aILKRkM5KzJcNWQb4PQ==
X-Gm-Gg: ATEYQzw/Qk8XlRJf7S0PPrxgik4mZJa3gdijKipeIbBqJvkSeH12IHjCpELXj80qZNY
	SFRQyARbC2aTbPz0huylwubn5gFoYJFq6nrEtSo5akv0OwtIUMQg8pRu249p5IywKc68cv063NA
	o9WfVzD8kCNzdAQw1ji6JtAFDCGi0wGjDtf6Fnb8xG0mznbATcprKb63sfZu9nAafJopAIOimvV
	bNJKVd2u1KTYtVaCxF2UOwV0Y5QWHKxKEvYBRfnHB6Hw1f3YPKELOOFLFqAtYoRMF6rDrERFz82
	xU8TgYT12bRDdWe3nKwTbcaY1MusoUC2mKRPAaJ5Xwz5mHJKoRbErUwVU70QuMYV5Tji+OblqHr
	KVMYMV8U687J75YY5FOr4ALx85IMQiCFWoYjPEqfhI7CE//IaNXQrWT2yVTNE/JjoyeHQQincSG
	2rlR4=
X-Received: by 2002:a05:6214:4e1b:b0:89a:49ba:b58a with SMTP id 6a1803df08f44-89a49bab894mr82170286d6.6.1773136633824;
        Tue, 10 Mar 2026 02:57:13 -0700 (PDT)
X-Received: by 2002:a05:6214:4e1b:b0:89a:49ba:b58a with SMTP id 6a1803df08f44-89a49bab894mr82169946d6.6.1773136633432;
        Tue, 10 Mar 2026 02:57:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef483f3sm447860466b.9.2026.03.10.02.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:57:11 -0700 (PDT)
Message-ID: <7d036c96-e257-460c-a91b-deee0b9c348b@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 10:57:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] soc: qcom: qmi: Enumerate the service IDs of QMI
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, konradybcio@kernel.org,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260309230346.3584252-2-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4NSBTYWx0ZWRfX8GSfHTPlzO3k
 4pm8wZLDIaGCa3M+ox7ZqBmHSupY9d7GbBFl4iE0NY9uLjDWNfw+a4LmazNPyLEE/7wujCzcjOD
 3OfZLEQO0Ltot1gaeZBDBt4v0xxECR5O6Q86l5g1c35eJrtKm3bqwT7zRYgGg8LzpsChb7YhsRa
 d2f1IxQ8nSA2bhZpYIiB4v3qiq+JUKRkd22PEVtayE4RtJ6CGys0LdwMvkXz1Zv8O0ikgBm0rmg
 kSBy280nd0ABphvLbUt3ca6LdoBYW56WcLbj8hnKktUaa5DUVBKqQOt3Nkxmvp7GOx2FxMmkFXN
 KAYYE/wwtoHVkB7fFZJ3jXCYjBfdj4pi7I1EC+W2Wa1uEdYY1qC8llsZNBaCLlbR0r35/OTuSvq
 0dlNgdORy4zuRzI4jj6LkBhF75ZQW6iKWNtlMGk72u8fRrpLfCtQzIRGTwZg9rtD06CxVeiVXvu
 Mbphfntu/lSkuCHQZVQ==
X-Proofpoint-GUID: v82dH3Cs8hR8590aqK-odADdRgotIVlN
X-Authority-Analysis: v=2.4 cv=Jtf8bc4C c=1 sm=1 tr=0 ts=69afeafa cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7MBKnE05AAAA:20 a=EUspDBNiAAAA:8 a=Lti85_ANQs6YWTYAGLkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: v82dH3Cs8hR8590aqK-odADdRgotIVlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100085
X-Rspamd-Queue-Id: 8135C248F1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32824-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/10/26 12:03 AM, Daniel Lezcano wrote:
> The QMI framework proposes a set of services which are defined by an
> integer identifier. The different QMI client lookup for the services
> via this identifier. Moreover, the function qmi_add_lookup() and
> qmi_add_server() must match the service ID but the code in different
> places set the same value but with a different macro name. These
> macros are spreaded across the different subsystems implementing the
> protocols associated with a service. It would make more sense to
> define them in the QMI header for the sake of consistency and clarity.
> 
> This change use an unified naming for the services and enumerate the
> ones implemented in the Linux kernel. More services can come later and
> put the service ID in this same header.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  include/linux/soc/qcom/qmi.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
> index 291cdc7ef49c..b8d07f2c07e7 100644
> --- a/include/linux/soc/qcom/qmi.h
> +++ b/include/linux/soc/qcom/qmi.h
> @@ -92,6 +92,18 @@ struct qmi_elem_info {
>  #define QMI_ERR_INCOMPATIBLE_STATE_V01		90
>  #define QMI_ERR_NOT_SUPPORTED_V01		94
>  
> +/*
> + * Enumerate the IDs of the QMI services

In case that's useful:

https://github.com/linux-msm/qrtr/blob/master/src/lookup.c#L23

Konrad

