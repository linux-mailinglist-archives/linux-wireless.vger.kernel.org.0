Return-Path: <linux-wireless+bounces-35923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGdfEW8d+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:40:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A338B4D17AB
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC182309A07C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5A48C8A6;
	Tue,  5 May 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XZP0J8Aj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dxfF5XCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D4235C1A1
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999104; cv=none; b=LNSJcshzpIRdFoHBRyv5zyUERLXzDWe1GoyI4dXFJqdiiRt50LH4ER6mW4lz4WXj4I3Y3S5VC84JVOkVYMNmcP236wBj6NrldV8jRDrUv8u3S4pds21nVNlKhRTvIFDdeqeXYsDDTfjR7W5C58Jmul+e26JKD2k9si0lrGjudcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999104; c=relaxed/simple;
	bh=RU1dJEbPqY7ao4Dn7DNdoDidiGzQeVLI2F1jXl8TWFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASD+nyj5+GHdTq/SWY1q3Ql3UjfTIISKT264V8s/jRaDT/8XPnYX2ueZnERwxu018ASpbfRJyy3hgu443jnjEJ/sjuGPvbFAPerOqiAOmjGj5kEPETcmD03zrcyjrRjKYNnKYj73ZI9aV1HNtTKzfFeGebBfrOBbAAssUxkQe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XZP0J8Aj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dxfF5XCF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EJucR911956
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 16:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mAeT39nlll9G6UuOdWosAUxItvDL2V/3OUKPO+ixxAU=; b=XZP0J8AjqYtxnrR8
	0YXDJGRUWc6XjSKObbgEFZ8y4PDXwlS/m0uvD5UC4FgTkp9FCHQZScQ0AQNOXRtG
	g1rauu4nM1V4wxIoURI0ZQMkhEOvm0ZaO1+ooKDoPsovDcQr6Ui0fD4rDihQyiot
	lmzaKMhAgRuZ4EDZd5wC977nCnur046GchwXa3ZwTwIdVLemQluZy3zWSLq78IfR
	QzbYHKSsMFvONo349qwpL9MM0xTjHEM7N9YClp2En7Qrd1xk4ABUbsBLdkzyDX/s
	HStSICU6MR8GyIRFDZfweFmEblP5yRjMJFmZucdOsuldiSpAsJPocjvP8jwflO3c
	TSNiNQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jgknp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 16:38:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9fe2d6793so53075875ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999101; x=1778603901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAeT39nlll9G6UuOdWosAUxItvDL2V/3OUKPO+ixxAU=;
        b=dxfF5XCF1PR9DHAijDVPrpCiChsq2UHYZwoDlJA5s1q6aG5dn4jKeeUNXGJ/f1R3Xy
         23cJQ+2Thx/rqNaJwJXY78RgaOELeatOu9+KEjqIzReTqeqPHOEyuxjUJdhO3UdCPWO4
         88qMlI2nm6/o9KhSrQV/14YDnuHuJp52McIHCpg7ji+NKc+cmtUve3wrZOBFV3Ok2I+f
         QocHNsEBi9Gbt0+5nizUj+JIrHusuPCb3t+cZ58mLTIRJKrZqRi6WXYfOAuLzSYRfN0L
         Epf2X6I9wI8+1iVQiivgJhB64k5Go9Xjtux9TrOO42oVxQRChqmWpKfz2BCuKBgv7R3I
         g3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999101; x=1778603901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAeT39nlll9G6UuOdWosAUxItvDL2V/3OUKPO+ixxAU=;
        b=GC/LmeVMYhAb48z/e6Mxfws4vq+UDkBbDK2NeWRC9NdTn/MhgKeSgF1O+ugcqUqw9I
         hpyaYD0IeFU7bq3dI4XRS369JtMyBxmxD0o3x3pRB0TxRvlpa+lSO/KTEjHDM7W7zM1k
         1tLxk5xUX18j7XVK9osIHBLAk12GlJr2zqt0td4ecfZE5bV19ZfCp1zgPpapSSQCTetN
         BGPLaKKxbtl9ZbmRrPfnq3fvoyKx3Ay1POiuD9t0uGPs7rZARd485s8L5z6Iuxm8qTmi
         mL9Me9a3bXk4LTUCIqhw2sPAnGOPqium2ZKNk9Z0gIQBmkhb+P9IlTFUVyvcDg+3AXwv
         S1eQ==
X-Gm-Message-State: AOJu0Yzofd2wLVrt7VdHXdgUM1RtUZw4JhBaZnTwPsw6qkuql8CjtXJn
	W1xLRFLxRdjqfKrmFympB4oF9pajGLpFCig1LkLZb5whLGCLhPpFRzOQa8EFWmI+0bvlDWJn0wH
	r/xkEp4gOGqcgYZswtYaa6FDv5mlfLbjh/PMutG5zXbM/Lax8V27GkVgu8ItDhg3420Nv0E1thY
	0e8g==
X-Gm-Gg: AeBDiet8PrG/tt404c/rM3LfMxTtAYnlF7YDPhTbf7xlW9SMLVjHQg2nBinBMYydk0g
	O1TjpyikLrgAZyb0Afe4jPfS17oDLJ1flQEJk3cH2kyuHQxXg2XotnTR3sIV8WtdfX/97wPMK5n
	/Z4r3mhsiYBAk9tDo9oM7Z7lrG8KecXiCatqdMOiMIPRHkDLR5BZvlazqpTZX+mrIb+Of6b7JEv
	QVFPUMLvJSBfCteLj3SEKjPsJ1qru08sTrpBmCGbG6g0DIGckv7a7sYD4vcmBjc8jBdsHF+Qxv0
	yfKmn+XgSbE7ZR6Ect93tI2PeHoQUHdJP8xi5Fi1dnmxu4qhMWN2k7U6q1Yka5SFVUY2etrW9Hs
	D45Jnb10WuplTdblZLERGBLnP6MKKU0Ze0vfDpD1fm+KGumZWv6q6beTFyv1Tg7CxfrtwhMqdKU
	eZ
X-Received: by 2002:a17:903:390d:b0:2ba:7181:7059 with SMTP id d9443c01a7336-2ba7181767dmr8784295ad.27.1777999101234;
        Tue, 05 May 2026 09:38:21 -0700 (PDT)
X-Received: by 2002:a17:903:390d:b0:2ba:7181:7059 with SMTP id d9443c01a7336-2ba7181767dmr8783985ad.27.1777999100611;
        Tue, 05 May 2026 09:38:20 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caab231dsm145884835ad.26.2026.05.05.09.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:38:20 -0700 (PDT)
Message-ID: <7a7d32f8-78e9-48a2-8914-0a7864345d25@oss.qualcomm.com>
Date: Tue, 5 May 2026 22:08:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Willmar Knikker <willmar@met-dubbel-l.nl>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260505143025.234292-1-willmar@met-dubbel-l.nl>
 <7d3c5eae-233a-4c31-b64e-70f0afe74da6@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <7d3c5eae-233a-4c31-b64e-70f0afe74da6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfX91Ub24kcxBtq
 AeUXdv/v4nZkfZtpYoWJ2HwU9B8adYyJ7xTYD7TAnOQnqfjq/ECTJUSUjqXPibIrCb5p2B0RZNt
 8siIk2vEsuyhp9Ya8WyVQNvl7NSF+Y6OupG72SYVFr/TJbvq+FVSX4UtBgLmfnS3QLeVSPSW2UA
 ruczXlF9GVOpoZHSY4QOjLR9YdeUCZiC0mhICq+oc7d4/beMkoLxCANK+vTQWiee5yWYoicKQMk
 3n/mEVvXjvulWjfMOdNH1xJi7QAfvBZESiic5rxuy7YZzNsjrg8VrNXbCu9XgB0qcXeB3Ed7Qda
 rnbAZg/XVLFUdirLxXpXgGM9VMI/qXe0glIPt+4BSeCid4lkBrV3SAp+KyZRJhU0D060sfm9AXd
 tUPo+rUkkrwWg3WaX2kLgPXxlhxDJ2Ft290zEX26iEXOc3BUAjB2KmF75U+zoe1lJMtP9pgWRlJ
 bsZ7nSnqvwBEYPCTFiQ==
X-Proofpoint-GUID: 1yRkf0aUY2jkBikFwMfJ7WgjZPC0qCa0
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fa1cfe cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=9B1uR9gGAAAA:8 a=jibNTVOUyd4WZLb5gSQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=8R3p93Tjo66ouot214C2:22
X-Proofpoint-ORIG-GUID: 1yRkf0aUY2jkBikFwMfJ7WgjZPC0qCa0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050160
X-Rspamd-Queue-Id: A338B4D17AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35923-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,met-dubbel-l.nl:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/5/2026 8:38 PM, Jeff Johnson wrote:
> On 5/5/2026 7:30 AM, Willmar Knikker wrote:
>> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
>> the dev_kfree_skb_any. This can cause a use after free kfence.
>>
>> Move the use after the dev_kfree_skb_any after use of ->is_continuation
>> inline with the while in the while loop above this one.
>>
>> Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>
>> ---
>>   drivers/net/wireless/ath/ath11k/dp_rx.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> index fe79109adc70..02bd9787d6b4 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
>> @@ -1825,11 +1825,12 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
>>   		skb_pull(skb, hal_rx_desc_sz);
>>   		skb_copy_from_linear_data(skb, skb_put(first, buf_len),
>>   					  buf_len);
>> -		dev_kfree_skb_any(skb);
>> -
>>   		rem_len -= buf_len;
>> -		if (!rxcb->is_continuation)
>> +		if (!rxcb->is_continuation) {
>> +			dev_kfree_skb_any(skb);
>>   			break;
>> +		}
>> +		dev_kfree_skb_any(skb);
> 
> rather than repeating code imo it would be "better" to cache the flag before
> freeing and then test the cached flag.
> 
> however as you note this proposed logic matches the logic already present in
> the "Free up all buffers of the MSDU" portion of the function, so from that
> perspective the proposal is consistent with that logic.
> 
> let's see if anyone else has an opinion...


IMO a cached flag is a little easier to read and harder to regress.

Also please add a Fixes tag. This appears to go back to the initial 
ath11k commit.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")


--
Ramesh

