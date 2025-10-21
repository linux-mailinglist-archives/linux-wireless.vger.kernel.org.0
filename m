Return-Path: <linux-wireless+bounces-28124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4D6BF4ABF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 07:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6171899835
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25B525C822;
	Tue, 21 Oct 2025 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8b8exvB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA9AD24
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761026208; cv=none; b=hu+hUn2chRPx+2HVLc8TwO7baVcwBQuqR6miBuzE84NSBivhQVpHQFNx5hiye9Hv+h1E/2JiYOmyvEdtnHNe3oyxKolAZHukkg/TsiFwWIwvuCrwbYhN4vJPNPtfKKpmxT23qtCaE4eQfSzEijCDUCfTuM4LVewcShINYYZ0N5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761026208; c=relaxed/simple;
	bh=u8DYHJMSpMrbvdPe/sFzyth3WWxBIK52tEFjXzsKU/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYEBUru9NngvNP5DBRJBYbeGg0wrYk5pyTl1b77VTY5zFdI+zRSdLpv4AV/eRZVEUASCIdGjHP4e3DzJ0LvpQ0mJpp1PV24WYdCMErFNhXDn20r1TlJ0A7uiZ1Z6lJzs1f2lRvtcSo3fcPHVJBSzCSpgRWwiPAUFtMguSgrkx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8b8exvB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL1AFU002287
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 05:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IrS/pqTBCF+Pif7x1Ny/z7bKzj3uV3/DSsRLVsYq6Nk=; b=M8b8exvBPv93Ir8I
	jJcG61MPsmtyCAgUVxHf1DHrFYGKcugSCH6w4iXMRMBMH1LkBJkuZPq+n5/5Xz4W
	9bzYmSR+P7jqKcNzq3mcsdFg2Cx93yV5q9SRvb4TMM5pxm0NVUFnDmnxdFTwucMA
	JfMihEvj+wlDuSGDg7pi74z9lZyTrjTa7qxX8eSRnuKkFzB31vE8GZwO7Ep/mYjH
	dmgwoC3XeiCwP4NYGoy4HO8VQNBrnc3iCvzzQAY0ubLEMTtewXyzJWO8ZPTxwC28
	S2tcl/ru2UItGO2yinWXFUZyJLCD7WHNqZh+wffwe8Lc3XC4cNDr3d0SvdKOFZ/9
	LPBWzw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w4vqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 05:56:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6325a95e44so4373479a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 22:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761026205; x=1761631005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrS/pqTBCF+Pif7x1Ny/z7bKzj3uV3/DSsRLVsYq6Nk=;
        b=AUtVaDNSxUQWo2ayc4AD5N0nIYWfiT5q73cgJlj14mI8DqSI+T++AECFIUroUpN36U
         aKpYrFWNPRkdb1mC1p2cIm42yMba3xzNqkQk8vlI1wj/VTtSPxdVUe1F8tVadhNEY05o
         HjCMLzHiD8Pgsoez0saFKUc8WLV02H6yt59buRmWteNONTyk7UCRCLzjB5SxqOGoPp1e
         LKniDlYXTPTsXV7iECcuFBr1zynqMEFhnzN2XPSIp7AGc8g7esFE4k+Fw7kCfEF0X1BF
         +2O/eojEC+dkqTqghh2T8UO32UD0gocc0h441nmglRA+yOJXGmDzYWZO6Ge2M7jp27Tn
         XDMQ==
X-Gm-Message-State: AOJu0Yx5gdonEngMmCr19cAWgEaGwFwU25K83eMRuZv9Z9gRFISHaX+R
	7NH0LdnEd8FcMWannmQnrvRWfJaIqBTUCBjwx6HHt9qPJXnrG43O+lkc2D7vtJtIVhe7lOvnd/Q
	WapJHPw95upw1qzlCPOZcPaLi6Z/q71RHYDQKIk88IlXfPiWPAe6BrcQhhsePU5R0ZtGvnRRc1P
	zUjw==
X-Gm-Gg: ASbGncuOe4ctXJDPyg7UggxQkaUbSIBd/8C6zUM2WfKrkI0Tm1f0TYrqIWPo8M1aj8W
	PX63gqEGtLxRX2Tx2y68u+Vw4v/yXmadSrQ9A0mOoGxkXhuAIuSD3viuXymH5RzT9Zpx/1dN5++
	Chqii4l1E+I0fCX5OTUCT/8+O2K3qgfq5knJGbJwEt7ru5e7cXHbjBZ2PfhwHyiGdfvahYx63Pq
	OiPjlT2ezWKPbzRfof1jzD3EWaMKk/a/C67K0uZAxVyzWNw1HLSBkuESYjqXT/pABFvo2x7pU84
	0goSpZ7ib0O56ux8XULLnrX1+fPjhrCwI0POiALRl+ApHOFbxUfMeOITTOwvYbqJosNTNSEFEg5
	uHGlzrzZTeiusSGdiB87KGu8zC0X/1NJVA9M=
X-Received: by 2002:a05:6a20:939d:b0:327:957:f915 with SMTP id adf61e73a8af0-334a7930a37mr19195453637.24.1761026205595;
        Mon, 20 Oct 2025 22:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1GEYVk9ZmIggP1CN6LfI1euxvj6RfnyqtN4yr3HxRtHXhMW0D2MVeUDQoVSixJwVcAWq+mg==
X-Received: by 2002:a05:6a20:939d:b0:327:957:f915 with SMTP id adf61e73a8af0-334a7930a37mr19195427637.24.1761026205132;
        Mon, 20 Oct 2025 22:56:45 -0700 (PDT)
Received: from [192.168.1.9] ([182.65.65.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf086bsm9865639a91.2.2025.10.20.22.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 22:56:44 -0700 (PDT)
Message-ID: <8eaadd1e-793c-4931-bee9-599fd333ab04@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:26:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: advertise puncturing
 feature support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017-hwsim_set_punct_feature_bit-v1-1-3be1bb3450c0@oss.qualcomm.com>
 <e0ce9b89f0e0a6379070e9e135c53722a2d0a19f.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <e0ce9b89f0e0a6379070e9e135c53722a2d0a19f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E3L8IwULYPtSGW4gPuRAtgodbQkXwBd5
X-Proofpoint-GUID: E3L8IwULYPtSGW4gPuRAtgodbQkXwBd5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX5t5diGOmTjDd
 PEVg0NaicYYNJ1zMoC/d6MCxenQXur9sRNaSVS4s/f2CxyvB1BmCkZbKENDpFUR3aVQZYIjwZV6
 +zM8VapTY5Rp5rKeD2oRpQxK47il342JNsLuLJpiWwgX2oHWka84My9Sft10M54SSrDsqx5wDT6
 1FfsfoLNVTvzuoBkN4bVUJSG6TmGZAohvpymTwE1+ue/nJnzNs5DIz7mrfGiDr8siE0UrW0xSfd
 gykKKaSyzciGrM7LcCKjgLaDZh6HVWlLuLeloAuAIctSDTzPtH4LYh19od42FJ0eXFPzmTZY1OO
 IHf8X0XjFUZyPfUmcGFW9/YIpLFMYtlI66Urnmq6fVtaXD+wGPu7zQZuocaNj8qztE1WE0o/x2U
 PRwcteWBZeH7/EQon6fRtjfkX3nN0g==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f7209e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=pYoUJYacPP78anNlNKsc4A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CYPn88_h1FTXjLuN7IgA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/20/2025 7:55 PM, Johannes Berg wrote:
> On Fri, 2025-10-17 at 09:32 +0530, Aditya Kumar Singh wrote:
>> If userspace provides a puncturing bitmap via the NL80211_ATTR_PUNCT_BITMAP
>> attribute, the kernel with mac80211_hwsim driver currently rejects the
>> command with the error: "driver doesn't support puncturing", because the
>> driver does not advertise support for this feature.
>>
>> At present, the following hwsim test cases utilize puncturing, but the
>> bitmap is not sent to the kernel. Instead, the puncturing information is
>> conveyed only through the beacon data:
>>   * eht_5ghz_80mhz_puncturing_override_1
>>   * eht_5ghz_80mhz_puncturing_override_2
>>   * eht_5ghz_80mhz_puncturing_override_3
>>
>> A future change in hostapd will begin configuring the puncturing bitmap
>> explicitly, which will cause these test cases to fail unless the driver
>> advertises support.
>>
>> To address this, update mac80211_hwsim driver to advertise puncturing
>> feature support.
> 
> This might be a good time to introduce better checks vs. what we have
> now in hwsim_chans_compat(), which just uses the control channel rather
> than any actual bandwidth/puncturing/etc.

Comparing those will be equivalent to comparing chandefs instead of 
control channel right? And we already have a helper 
cfg80211_chandef_compatible() to do that. So we just need to pass 
chandefs and call that helper? Or hwsim should be more stricter and just 
use cfg80211_chandef_identical() (this helper is not exported yet!) ?
  >
> It'd also make the tests actually test more. What do you think?

That's true. You want those changes also along with this patch or you'd 
take this one as it is and take those separately?



-- 
Aditya

