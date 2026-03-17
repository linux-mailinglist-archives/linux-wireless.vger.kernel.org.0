Return-Path: <linux-wireless+bounces-33339-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG5wLcghuWkrrwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33339-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:41:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 974AA2A7077
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EB42309324C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08700375F7D;
	Tue, 17 Mar 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0028KqX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BEvPHZHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3665371884
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740257; cv=none; b=Y/x5VNZ8YRUgwROZhMGJSbrQ7/3oCDrE+1SfgLfABXMPqGNCti9pCTBgqMc9ThJAs+Mfy8BPzCR7uUSsAKQ+UXrdhOiSMzL/F1MFbDmbxerNOufxAwL4IjY/ggPpqfSxJIWeaT6b3tgroQW75OdcGVZwGUQjy+KTdOlVwW+OFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740257; c=relaxed/simple;
	bh=jVZYIYYu5NR2kUW827DS2lDNFxhHlkq/RhwYjreU5TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtivbZJTMxaEfY4JVzeOzoqQS9V4i6gr08gaONXEqqswPfzIgZiGf7u+f0wnmpUQd0I/iKtLpOWRNtEr8VFcnt8BuJa/LSeg56G53hS1g03MqRaYZDpV2dPQBfNleyLzETxfSKvOrjACtx844J638guqePhn9Io9c5PLnJTqJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0028KqX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BEvPHZHk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H48fUn1428845
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q4LiO/KWyB0NlyXq+QE2s63PD+DYwoW6khx52RDakjA=; b=U0028KqXKvwf6SWU
	C7xG0NhalfELkLxjnlY0jMUkk/Sa7dX27XKQdENvxt/FgMDmZz4ygjw1+VVNZJXX
	Ugbj9gC1dADoAXhut/GKm3gdJnS7WHa78d2Ghj00V/SQI51Zxvor3fRPZ9/JSeZJ
	h9/Ov8Qud++CaLO7cD8t4RzzqOxumIX56xhzbNH/GVM4Egbk1L+U+wCFsyNAJ31q
	xg4XOE+3jp785PrF3zYAuPqjeUQcGjMpo3QSpgYVVjXpYC1b1mISG8TCRiIsRHcN
	efGJYzc7mrQPt6+ySZSMU/IEHSX/xTm0mPMrejpZ2Y7aDOcQXWZXtE1SU4NiVOe3
	NATj5g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxh99c6b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:37:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7de0e161so3785202685a.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773740255; x=1774345055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4LiO/KWyB0NlyXq+QE2s63PD+DYwoW6khx52RDakjA=;
        b=BEvPHZHk9j6CasUYw+A2J2fj+Uu8kiGh6xQMcTw8wLhURHfLiLtrIpx8zlzWvcpkB4
         DDOTRn2W8mLwxs8w5HRKrUozydzHduL0cAggdJsvT/v8ZcoMX5f5IprOna+hJoB1vFMr
         S3Fja1srsPfXk4yrYU93snX2xolPZiSM8Jyq5k510puJijCpne6ekZxOkZ56zxPf88vQ
         JoKlL2OOMcmiMEfwIhIzO1XVCikog3e03HhMDTp8kFzSLs3fcp5QH5rLX3nSewYlt/dJ
         ImKPhzfqhHJvCeWmbUtvEdmY4tFZD8CqqhQapdYrWR2ogGKLhm9Pt7sgZ/FUrn822jpv
         SGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740255; x=1774345055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4LiO/KWyB0NlyXq+QE2s63PD+DYwoW6khx52RDakjA=;
        b=mI2e9PBB9W9n9rTyT4w3+ipd2l/ac/1UlM1LZzTC518F++SAnA7s6uAqh1Wsvlq9Q7
         WB12tBfS7TVK1COPbmhd5lBRJ8LDns5wMD5R9J0LRJgvlib7pImHwYdpS3tL2Gel+agP
         plVHpDj6M1otgyHn5zElJtS0iB4rTFS5DYhY3BtnEZtLAlFun81jcHPkRAG8XazvG5w/
         YfOffE8yL2Qp1Le+doIW/AuUZgS+y4pWiyf23+zht2ShQoqrxHMPHTMTFa6V1ImwwQky
         Ur/BwfyEnfIMljnPSx/WbzKJvPb7k8i4AVkrrllDxOEDf3EHU97+mCQ9jRbZghDUQq1E
         6okg==
X-Forwarded-Encrypted: i=1; AJvYcCXruqamEUsmrB4DzDfmUa+QQxYH++bHTWw4Ajvo+VxorSKKTNihJo8kLgvx1WZO+g+CSglMWTrgdXjrlWBUbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx7TKpoSxncuPuK09Dxxvn2gGaBSxqps7grpMTAEbtJDpp+rg
	lV0WqmgIOMlfVpcKJqowa6yAy9BU5hOR+Cn9PfPM/4549uw9LeWscpstV1iwlhQmT+MGrI3Bq9y
	KNcMkkDxpll7UchYReRLKTIbPucJ3HAPmUdQvzzgeFX6yeKoi2fqZLDFHFVNawZncDxY9FdyTfL
	th1Q==
X-Gm-Gg: ATEYQzzaKjtbeXj4Z+ujJA2nJ1bIZCRDJSl1LmapPKxxpJg5sx/7modjFyQIiN+uSJF
	atraBwtUjgyPB9gPnd21uzWhwB/JPw0kTLksYz24TUi3bNESv0SkL16aieerAQ/4oLpWlLXX1Jr
	klMg7H2riW0a1qG4oEIaOGrlWg1iCED27CK4odnC62oVc74XaKB1pUQ43TCEbUiX6LVXu6TBhq4
	dsqWQTHTej0iYJurDVBlfNWx+S8fjte+28Je/kvjfjokYRuXDxt/vg1fndi1bVYzHw5MdpG4Gqq
	zxDpglMxltodI2wYrCckM4UBpELGPj6ng+pw69REiKBFZ0hB43kTidbMarCh14WUnanZ+BlLOiU
	/VcmHd2ygEGP42QWbKQLg75x4y4x86Y8wWNKn1X09o+kMnKNB8+epJj9KOu2nQpcqGdgPQbMPpR
	eEvTyJRULJ
X-Received: by 2002:a05:620a:29d5:b0:8cd:b317:a0b4 with SMTP id af79cd13be357-8cdb5a6ea0emr1991591485a.27.1773740254714;
        Tue, 17 Mar 2026 02:37:34 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:8cd:b317:a0b4 with SMTP id af79cd13be357-8cdb5a6ea0emr1991586485a.27.1773740254241;
        Tue, 17 Mar 2026 02:37:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:67fb:53f6:20ba:ff45? ([2a05:6e02:1041:c10:67fb:53f6:20ba:ff45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b42bd696dsm16981086f8f.37.2026.03.17.02.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 02:37:33 -0700 (PDT)
Message-ID: <e25754a0-edd2-48a0-abc4-9b45d119ede5@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 10:37:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Use the QMI service IDs from the QMI header
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, konradybcio@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
 <20260316172251.2d57d0aa@kernel.org>
 <8757aec7-8c36-446a-9a34-f0717f64202a@oss.qualcomm.com>
 <2026031717-ethanol-zoning-80b5@gregkh>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <2026031717-ethanol-zoning-80b5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RJ++3oi+ c=1 sm=1 tr=0 ts=69b920df cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6xCDiqM1XSE8sYu1eLsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4NCBTYWx0ZWRfX3yXbdJEPDy6S
 8nioyOcOgYw36db9oU5MFE1acQrPTPUHgbnzFSrHfgrbK96sJYlJAmMUq8BBwM3Y61w1b4o1C+h
 169WXnmpmdWAYvEmz/7kRbVS/GFRbJ0Rbpj37ESYA7v2pTrtgosA8b35QDvgbFm+K5j8AJfjjUP
 1GoMJz93BDD+lf9DfyeAyJJVFX5rWI4tt1f59Oi2Up+8sFGcV16p8C+n5r8BGdMVTdkYSnHeLhL
 p2UbuIiM1qehDFWjcDMHKLLbC52xqh9zTEG71FyH8BN7b6+jEEccuMdQ8HazvaAk9vkrcJil8ic
 9j+hIf9LH9RYbIfH5Qm25ElA5v2jp7VJu7AtBv+iS6Ui0NE3fPImaPT/Wivtt85I3cgzDP9G2Ti
 6sx/uunlH/ndS/IF7ZwG8gVM9Ylj25an5GupQeIemP0+NgQkBUcZ7W362L75n4M1PGj/bNf2v9n
 2BOPCHv2XO+YcWp2sRQ==
X-Proofpoint-ORIG-GUID: Ab27cEFvyOsFYvrmx9OT0dssheiLsb2-
X-Proofpoint-GUID: Ab27cEFvyOsFYvrmx9OT0dssheiLsb2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170084
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33339-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 974AA2A7077
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Greg,

On 3/17/26 10:07, Greg Kroah-Hartman wrote:
> On Tue, Mar 17, 2026 at 09:51:32AM +0100, Daniel Lezcano wrote:
>> On 3/17/26 01:22, Jakub Kicinski wrote:
>>> On Mon, 16 Mar 2026 18:14:10 +0100 Daniel Lezcano wrote:
>>>> This series is based on the immutable branch [1] containing the QMI
>>>> service id definitions along with some drivers using them.
>>>>
>>>> How a patch can be merged ?
>>>
>>> Wait for the dependency to appear in respective trees after the merge
>>> window then repost the patches individually. I'm starting to get
>>> annoyed with all this cross-tree QMI/MHI noise.
>>
>> An ack is simpler for everyone, especially when they are trivial
> 
> Why isn't this 4 different patches, all for different branches/trees as
> there does not seem to be any dependencies here?
> 
> confused,

The dependency is on the definitions posted in v1 in patch1/8 [1]

The first version of this series was bigger. The definitions were in the 
first patch of the initial series. It has been picked up by Bjorn in the 
corresponding tree along with 4 other patches for subsystems he is in 
charge of and let the other patches left.

He put in place an immutable branch for those who want to pick the 
corresponding patch in their tree [2]

I sent this v2 with a subject prefix fixed and a pointer to the 
immutable branch. So people can just ack the patch or use the branch if 
they want to pick it through their tree.

   -- Daniel

[1] 
https://lore.kernel.org/all/20260309230346.3584252-2-daniel.lezcano@oss.qualcomm.com/

[2] https://lore.kernel.org/all/abdkE2qWX5Amf5Jo@baldur/



