Return-Path: <linux-wireless+bounces-31336-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hf0FTeRe2nOGAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31336-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:56:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63CB285D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D78B300ACB6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC033A6F6;
	Thu, 29 Jan 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfASyPWb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ENUbmsnL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8D3469F7
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705779; cv=none; b=iPJdHdQFT2fWbgGydy9zQPwiZPk4PiXUTRiS1HPSMhoN0kNqnZvLw1Sdv1hzx9XOFxUh2hQWgoBde51zUQBNXGdrktq8ivz2p+1OBxjJ0syhOh/OgTCIDVYt06TUCtgXLOlA/sRuxpD2z7f34AYgvIsaeeDOa+lCuPiI7IEjLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705779; c=relaxed/simple;
	bh=De4qRhNb6CV+7/dn342RRaZEJB4UWKGLEzndu7rWd34=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q74Pj4s/K0sYNM9y2k1Pl0eK9nPxVibpZGSrCzyutMRbT5HQC8wjhqLXfrz617ACaeyn+8W7gIvd1dIglg2wGy1bw+4cMEgTeWZCMHfLWG/47ulTZ8PYYxFvVRi9tCwvpnMF7XcuxiCY1k7cC2mMz0RKa1UNULEQlamKmCmWCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfASyPWb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ENUbmsnL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAlgD32953194
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Whh2iAFXk8LUkWSgqZOta8bafR4I9xZOlAJZbclFfBA=; b=OfASyPWbHnp2qDoU
	4aLG/yww7Jhh1XpilgJ5Th27uVzSIk1ZZ4n+Zv8hAqoijWfdaaQuch8rfP/BmseU
	rzoW3MWJ8cr17k0nHCGdlstPg+i0+wnZUPY+KWG79oJyzrJ+BGD6xqQogn80K0Fn
	moTcsfeF9yhmXwyxNLiR5Z7ZhvhjJcZF6tp0vbqR3q5t5+4ke2PsuHqpHoCR4F02
	4cw7g/PTRYQIlx5/tP0J6uaXStNnepUYN8VHC715QOk2SFPhPsPvUcQulNLcD5Aq
	cSqsi65NgRpqFrWLr8Zi7INHUOltJe+8hoxpHAARsjDXry7v3uEnndGcO0UL+5Ln
	O9PWCA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0642187p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:56:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f53036ac9so1080723b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769705777; x=1770310577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Whh2iAFXk8LUkWSgqZOta8bafR4I9xZOlAJZbclFfBA=;
        b=ENUbmsnL3Eq12Dbbdo6igOFsw2N5FzaG0auqyh18X6VTUree/3lXReqEpOcRHUH1AR
         yHw5zszpikgETrNqETokkBqolTxWY6W8qk2/FUuqVxXoeHI48hJjb/MoCq7hCTI648n0
         Z/o8b7Ux1ASDCsrZk5u6msWxyDk5z9lvvXS8vfkeKfBSQYkj04zZx+qpAqvDMJRDgeZr
         eJ702hctCMjRA7MirkL1KEEeEFMM9fji0XwaHx5MbXGnoSbwvNzdsr6w5uValmLxRftQ
         9DjVBc3UVwHovKEEWFGSpSnvOBYE9x+qWye3FbvDK/HUP+maC0VT4JIGgkCLWo3zi8Vy
         7ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705777; x=1770310577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Whh2iAFXk8LUkWSgqZOta8bafR4I9xZOlAJZbclFfBA=;
        b=U072s43vWaUemCYVhBvXvaS2qMxEE3jIFjeGIIQf0YHdbJxb1lDl5pfnbwqdwsAUhf
         XNBmpFDUyLY0dVbUBWp+MX5IZLnd4iY3DBKJmUgvbrX3MA5YgXW9w6RUgzXKfmSuD5NU
         jNXJ61f7I2SLA2/dY8tbmusVg+0NEqmhbIs3Y+hioHdPZpNYnkxBL8YbC4bFvm8jjfTr
         rkGRqfURMm6Ow3pe0e7FIcQCZ/ghKbtGZtDj+jtMHXg+Gz8T8PHsJfz03bL4/n4JmXM7
         L9CMuf6myuFQOuJ9+UC3xF1pCphBpq9QGSeiKnWw5y64224Om3oN5tDl7CijuqIIzD/I
         3i3g==
X-Forwarded-Encrypted: i=1; AJvYcCXYLimKzO0iCfky+8BXQIqc1UFmkls1vvpMnRHXuE7o6FpbmmkkYpG3vKR9e+zrA71TAQ1VXJ/2ERK3Ymt9jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhK3u/QIJvaHKr2cEBix5PMfgjQphDpbJRc3fj3j7gFrsGS13S
	XnuAYwliitTTI8nPyJXrb0wPv3nwWvUyHJHWEcITle5If+ML9XCoBExhmD894+C5dHNc9VpUnZ3
	aA+cWVDsW4QP2KNJpjDzCQPCAFSUeN/lKGzx0QOwFgQ6GzOg7o3Rw+00NkRNvIW14jAt9zbdBoB
	WZ+A==
X-Gm-Gg: AZuq6aKtWefuj0IeT5tW9yr7SgDTdg7+2bZF790j3Sedp7lAeiG7472Ft+WmB9TJl4N
	vPxg4b0Dgo9B+kA5raxl3J5kGrzOa1N70iTa1xFa6CVz1BF4K48vTk2EHmZh62UTwKksSXE4OOm
	GkaJDCFxFMRrsds7f49HzzZ0U0KHycSBjg8gCEQUy98+i4k+ZY3API+t+vLAZqnziwIDHPViGP3
	E0jHKFnn2hrAEYC0AJ15wKbjcK+nIg7dAoQssWWMjbZ0QjcAC9CONkfin+kwaO/1G/RneORTCHj
	U+QLgVha6qj4XCXuCQk7GUYmGYfWB/Av5MfU8OuoSzHfxh7cGSo3iTTC7tovFxZYgDDYzYTnjWl
	ty2tLNII/Eea4u/y9mG2zjYRWwGPPrIFP9v2O8HogyTCk1s6w5T8Kn/ywIBzYzgego9PXzqXmJr
	BTUMHJtzDPgW9KbiIpF85KjGUb3UbwN9CRPzcFfg==
X-Received: by 2002:aa7:88c8:0:b0:81f:477d:58db with SMTP id d2e1a72fcca58-823692919a4mr8823088b3a.39.1769705777083;
        Thu, 29 Jan 2026 08:56:17 -0800 (PST)
X-Received: by 2002:aa7:88c8:0:b0:81f:477d:58db with SMTP id d2e1a72fcca58-823692919a4mr8823072b3a.39.1769705776617;
        Thu, 29 Jan 2026 08:56:16 -0800 (PST)
Received: from [10.50.27.148] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcacesm6140115b3a.32.2026.01.29.08.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:56:16 -0800 (PST)
Message-ID: <e3571c65-47ce-4c5d-8228-b255b0698d92@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 22:26:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 1/3] wifi: ieee80211: add some initial
 UHR definitions
To: Johannes Berg <johannes@sipsolutions.net>,
        Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>,
        linux-wireless@vger.kernel.org
References: <20260129134944.a84420ec58d6.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
 <2144630f-6abd-4a97-821a-51cada015867@freebox.fr>
 <587d823b0a900d02f78a552d9cb350ef4fc0766c.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <587d823b0a900d02f78a552d9cb350ef4fc0766c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExOCBTYWx0ZWRfX71FL3PIcREkP
 QfeYGHjIttXt0wYvp2AlBRjYXhKQeugHfnd+cAw1pPIWGyd0A6huDACpy7ylk8ZXelqqr+hSKDN
 KHJUf+N7CugfEUHysqN7gsXtQlmyPIWJgq/8yKDE8ZZUGh142yntUFLHeAIpa1B5S5GkgLDpx12
 ZICyAvqcMIMaLBdu/AYeAtziOUDdZvF4dPcnZTZKABzwGyuW0d0izt52NPxwbLNU6ElO/5Jfsmu
 xoRAnCj4tiX0goNZ7KOzXcOSGBw6gDkU77gYh5YaMfl6LJWLCzE3BNciCGRsmQZMstg4o1ABz7O
 wj18nUacc4YmSs0aVXFxnx4nLCg5i85Bko4tE8x+hGPo4MJNSkVW/i4jNjZv99FJevBvZNMtr0O
 590DwUFgLHvD3atsr+xlwvZzEEotGeEH/JLMIPuLmW+i4b2y3uu2MlwFCAqYcqHWvM/PHIQslOe
 35Uw88x/BgNbDM1kArw==
X-Proofpoint-GUID: Y-sfqCO6F0MDuBzyfgY4m7ojMBtKtJf9
X-Proofpoint-ORIG-GUID: Y-sfqCO6F0MDuBzyfgY4m7ojMBtKtJf9
X-Authority-Analysis: v=2.4 cv=dpTWylg4 c=1 sm=1 tr=0 ts=697b9131 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DKgsIJd2BiUcuHt6N3IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31336-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB63CB285D
X-Rspamd-Action: no action



On 1/29/2026 9:40 PM, Johannes Berg wrote:
> On Thu, 2026-01-29 at 17:03 +0100, Pablo MARTIN-GOMEZ wrote:
>>> +struct ieee80211_uhr_oper {
>>> +	__le16 params;
>>> +	u8 basic_mcs_nss_set[4];
>>> +	u8 variable[];
>>> +} __packed;
>>> +
>>
>> I've just noticed that all the other PHYs have a type name
>> `ieee80211_*PHY*_operation`, it would make sense to keep the same
>> template for UHR.
> 
> Meh. "_operation" makes those names get really long, and everyone
> probably already has a bunch of code depending on this, so I don't think
> I want to change it now.
> 
> As for the _cap vs. _capa, maybe that's a better argument, but it's also
> not _quite_ the same between all the others (e.g. "...vht_cap" but
> "...he_cap_elem"), so... I don't think changing it now is worth the
> cost.
> 
> Qualcomm folks, what do you think?
> 
> johannes
> 
Either way works for us, but I’d lean toward maintaining consistency 
with the existing naming pattern. Developers often search for 
ieee80211_*PHY*_operation when debugging or exploring supported PHY 
types, and using a shortened _oper might make those searches less effective.

