Return-Path: <linux-wireless+bounces-29023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61003C63074
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 10:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A5BA4E1892
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4C51F3FED;
	Mon, 17 Nov 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+i6tsE1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="amoCK6gy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019E24BBFD
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370202; cv=none; b=JS2ZiOKDBXzzEo//LMXYoJfPv2clmzMgqZLK96D179xLpSht9Ro+Z7BiFDIevCTpiOwZOrDyz4fyGKB0vTTh3LMqN5lZMQQmJE+1VonV8datqzyolqjIbKlbeXr36DWSKjHk8UxFbq93W6IbVTsTYf8F3LFvYYji/WezIGw+9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370202; c=relaxed/simple;
	bh=iI/uLAuLDiXKC4Y5GAV9MgZncy5q3E68rkYV8yke1eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8k9sGBSMnsPcsLtunaV7W3iZLUzpmf6uGRXqyD8XDGTgbnwKiVYpnnAtxg9jngs3wCJhrP8bR70fv1Y9ecEHBsNQhkmHOU8mdnkbe7BXZakLU2i40ROsbp5s6bPKRjKGSkLTTJOoXEYNP9gtm3q0NC4pEBlbTTqruiDwc5c6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+i6tsE1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=amoCK6gy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH4o5CI2838158
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l654H++wrDIKhs+Oc2+S/1MIjCYK8NtPLyiTdYbJ5eY=; b=g+i6tsE1I3TokNcC
	xoXFTu3nj19oy2f714qq/GoTofyV8Rx3bpt1WU047aU7/WGedHVqZK0cG46xrYUZ
	O1NfU7ixAll4BeOk+Ym4jSiZ9Fe95OJWEuzo8E85KTY/BrS4AXRS9yqKMIrTmG7F
	F0VprbD17e0E1UF29WGFFlHkWqO/I5j9OfMEFU2Q8XgK04+ZI0g94gQFyZOT2O+0
	QK2cNKmn862pjLM+uLW7cWPvNdWzPJk6UDTTGXf96dxt7WI9u/Bro7aZYUbgRoGW
	KaUcXbPaS+IDrWZOrKrn+oHJFYiXc5uQoTWhr2krUr4jVBOwPb7txeSlLMLEJ1/k
	7JVm6w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejmyv047-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:03:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2954d676f9dso32768365ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 01:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763370200; x=1763975000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l654H++wrDIKhs+Oc2+S/1MIjCYK8NtPLyiTdYbJ5eY=;
        b=amoCK6gyVXeFBfKNVXmwlWjdsx0JF22kSX/6WBykBy0pVUNkfATawLH3JYMnrbDk9H
         lfaj87cLMDxJuDKF2C0eRjTnWPFkOvbrK88LD4UCucrLKbvGvngqcStMt5+O60DkhSqU
         WOnwm7O5dY4lsefkhFnV2CmeUNym9peZRGP6KBLCFAbhpigQa0GUoayLA/ApGUb1t+9F
         /axu96Mfl//66ROaVMnNxoyfmBBTKyvUhiKXgghFCK7PHO4vV4Nkq07T1F8aaUOWNiSR
         f3gnPlCk7k0EThBeelIaGxTF1OVmm1yMyNI+Qp+LAzNj78RKmlyxjAOCx+KUqWUOVI3a
         N2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370200; x=1763975000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l654H++wrDIKhs+Oc2+S/1MIjCYK8NtPLyiTdYbJ5eY=;
        b=lsG4S9n7LvmB6s50aYnOTdQHAa/9YtU7F9oGBW20WVRzizzwc9zeBPWMVuvXuhxvzE
         gmmsGo27cZwegTtgrXGwsO03LHgp/azXv9lcQNCg8AiKDX4LwvxLrQOVdkKVWkPdgmgB
         yUDOt5J2a/8bExhXzf7FoTxfua8efSlk/NBJIEnFTAys0EnaJzHWfJgaXiCB4J4/zy9o
         QGGczWij5dDSFFI9OidEExBOq/ame1CKkSRqM0O0gr15rCHZ/9iWQFBVVTfTHVB788Mt
         9LCPehwNnIYtudq0vEKEESIvWMaFSb3iL8U45scA3EpqdsTdDhRN0A2HPeBMc05spWJA
         ScYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7buufLJSDvgw8ztAiilLVlymiEA06eorRANQC5nuF1nkP1HGzlLMHWBC5yvcCvoIsXtUb0zjc+WK2AuR0/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vDukzb1BW5oJ733nhqpkvn9Ciu8ElInX7jFlYs7xT0qOlL5I
	dc7FWFVe90f/DaeAWJMFJOgiIE0JDuSO/lKdmP9NxxyE+SezRCBVUBlcWH+MjUYhKjwP9tIVZOF
	yEZLPimUxUbDHJmf/23rKGI7zHV3lllxHteN+LS13MQDqEZdAMhzpL9NeTYvk+cmHF2A1OA==
X-Gm-Gg: ASbGncutOp7EpSmfI6OtTd2sPL0VKL2+IBIgkG47E9or/SoSiPkMQ3hoVXjjQ3TzIL0
	huU1RL0sljrvTlUIHQd1QpqoOqxCmaYGSMS5weG0e8hh60j04k3gdLTGPO86UT/bia8zIZKsY0h
	07aYN51jGLdigDIlJX6kCyBlX5cdvz03UUVXSePmaIBTfwZQ6Lj1bOOjJyyMi4jTAmM/Sj7dUSx
	pgKe00Effbo5wEHoFBhNpGoaK9sYGZUDiZ9W2Zc3q7jRNCVY+j9R25h8p0F6roWLEekMH6ec8Ep
	OP0Tyg5O29zGK5XPBz8TbOkiyWHY2MmkiHRn9gQn9OEd0P5EsqmLL5FgHSXnRUOsBA0FGEKCTyz
	fhshMtEQdaCfi
X-Received: by 2002:a17:903:2f88:b0:295:8dbb:b3cd with SMTP id d9443c01a7336-2986a6ec9b6mr128086365ad.27.1763370199675;
        Mon, 17 Nov 2025 01:03:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFV/ytKTe+tDWjtXCC5OfPxzLvXpbLuv9zHdmNqMNf952FZHcVn7M15VmQeRSV6ylQ2cAqHw==
X-Received: by 2002:a17:903:2f88:b0:295:8dbb:b3cd with SMTP id d9443c01a7336-2986a6ec9b6mr128086065ad.27.1763370199146;
        Mon, 17 Nov 2025 01:03:19 -0800 (PST)
Received: from work ([120.60.57.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c57sm132940035ad.54.2025.11.17.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:03:18 -0800 (PST)
Date: Mon, 17 Nov 2025 14:33:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] dt-bindings: wireless: ath: Deprecate
 'qcom,calibration-variant' property
Message-ID: <tratduwv3edhhu2wjqorfkahpuwusx7uvr4fdgzo5wwz7rzdnx@iyxp2nc7ksha>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <20251114-ath-variant-tbl-v1-2-a9adfc49e3f3@oss.qualcomm.com>
 <b9b4f1bb-45ef-404e-b75e-962e85a557a2@kernel.org>
 <fmumja63j3xvbvfxlmtnkfubgw4jwo5f43srrpfgqrxyqknrj4@izsqazgbiehp>
 <1703d8d7-5105-4585-b8f0-82bb54809718@kernel.org>
 <kve3f7zkywwsfkylom3jp4e3ejlspnlvnmlkuq77uy6fqsy5dt@gaitvppj2jcw>
 <7757501b-2576-4f5d-a16a-40e06f12cb5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7757501b-2576-4f5d-a16a-40e06f12cb5f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA3NSBTYWx0ZWRfX3/OSRa/cXKbG
 UnIVfM13IDq4zZzotGgtgf/ojpdbQEsb+IH14ALvfZ+xePQ3QXL0WxOk1V2m8WCOw7F88f9P9AI
 2Nf3W9FTdRad75+Efo1UiXsRyAyhA8sD6zDKbq0uDFewRG32pd4OfGQBNfvP4cnUrmngbOpXV9W
 /BNELwTgMbwadS9JAh2BNbtC+ZR6/PaStIm9OMAI4SDpav2Kuq63oTvWmcoE40mzzR2Vow/zcps
 21wt/gdDYSsevqZh6e3CVFY5I59R7Qhyn0bqYx/2PxiT9ItugzK4i1x3j2Mjl9qqXALRB/xZ7N2
 MKmGc7tIzTf8IfC+ZIQ1zc2xVJz2tNiMyvvo0iNxj8BjJi2+xgGalnZszx62kga1eT7/4Q8p5Sr
 cwOUNxzORtj3wuXwrixfAFAcACs2Jg==
X-Authority-Analysis: v=2.4 cv=BPK+bVQG c=1 sm=1 tr=0 ts=691ae4d8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=SvArCPxluHhT4bP621h3eQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cS6S4_kxOddRYArucPIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ncGqgA6Wxe5MymMTcmeyOPrX2pA1SYWo
X-Proofpoint-GUID: ncGqgA6Wxe5MymMTcmeyOPrX2pA1SYWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170075

On Fri, Nov 14, 2025 at 09:29:46AM -0800, Jeff Johnson wrote:
> On 11/14/2025 3:18 AM, Manivannan Sadhasivam wrote:
> > On Fri, Nov 14, 2025 at 12:04:55PM +0100, Krzysztof Kozlowski wrote:
> >> On 14/11/2025 12:02, Manivannan Sadhasivam wrote:
> >>> On Fri, Nov 14, 2025 at 11:47:25AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 14/11/2025 11:22, Manivannan Sadhasivam wrote:
> >>>>> On devicetree platforms, ath{10k/11k} drivers rely on the presence of the
> >>>>> 'qcom,calibration-variant' property to select the correct calibration data
> >>>>> for device variants with colliding IDs.
> >>>>>
> >>>>> But this property based selection has its own downside that it needs to be
> >>>>> added to the devicetree node of the WLAN device, especially for PCI based
> >>>>> devices. Currently, the users/vendors are forced to hardcode this property
> >>>>> in the PCI device node. If a different device need to be attached to the
> >>>>> slot, then the devicetree node also has to be changed. This approach is not
> >>>>> scalable and creates a bad user experience.
> >>>>>
> >>>>> So deprecate this property from WLAN devicetree nodes and let the drivers
> >>>>> do the devicetree model based calibration variant lookup using a static
> >>>>> table.
> >>>>>
> >>>>> This also warrants removing the property from examples in the binding.
> >>>>>
> >>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >>>>> ---
> >>>>
> >>>> The problem - visible in one of the examples here - is that one board
> >>>> has multiple WiFi chips and they use different calibration-variant
> >>>> properties. How do you find the right calibration variant for such case
> >>>> based on board machine match?
> >>>>
> >>>
> >>> I suspect the legitimacy of the example here. I don't understand how a single
> >>> machine can have same devices with 3 different calibration data.
> >>
> >> Me neither but I am not the domain expert here.
> >>
> >>>
> >>> AFAIU, calibration data is specific to the platform design. And I don't see any
> >>> upstream supported devicetree having similar properties.
> >> Deprecating these is fine with me, but I would prefer if we get here
> >> some clear answers that mentioned case cannot happen. If you are sure of
> >> that, please mention it in commit msg.
> >>
> > 
> > I'm pretty sure that this example is wrong. But I will wait for Jeff or other
> > ath developers to confirm.
> 
> As discussed privately this is a valid example. This is a single-band chip. So
> a tri-band router platform will have 3 boards, one that is supporting 2 GHz,
> one supporting 5 GHz, and one supporting 6 GHz, and each frequency range will
> have different calibration data.
> 
> So we still need to support slot-specific configuration in cases where the
> slot to board mapping really is fixed in the platform.
> 

Thanks for letting me know of the multi-band usecase, which I was not aware of.
Yes, this property has to be used for those special usecases, so we cannot
deprecate it. But going forward, for the single calibration data usecase (like
almost all upstream DTS), this static table should be used.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

