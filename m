Return-Path: <linux-wireless+bounces-35567-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFGOIWOq8WkAjgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35567-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:51:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D218248FFA9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73833300B9EE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8563803D3;
	Wed, 29 Apr 2026 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RI2QVmwp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cMwQfn8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172035A381
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445471; cv=none; b=rsZWP6ziAOkNLF47bMJbYm4l4T4rddgGi1ScKlniY16cSYk5THRqWWhP0HdHYE7Q51dXg9HJsaqajEWzIZN3kHd1R7UZfg6ia5YiBmbv7F+iuncqY97x6Pf69bPxW8yN8x6ySLokjTbdpjGHnMYzLL/rCaDTMRrZ4SXp4nFBipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445471; c=relaxed/simple;
	bh=mmP7QiW4d1bssgkwur3RJ8wod5EVKfMTJtnt/jWz9/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJKawIn9DJNNW73hXhlXH5sanzLdl4dIjhtKEFys1L9W2c2UYvjwGYkRO8M91bOVis9mJvRkUBIVSE9m4cSOkdkXsLpwSJTNMWipmidDrrXNuqhpqjvRgL39R6ejHtrIfdBddLa5LO4DoxvisV9aOO1YbuTJ/tPTd4uU2n6as4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RI2QVmwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cMwQfn8n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T390Tl2984311
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H0sJQxmiELhuOgvoZF2ADMqtFQSUXgp1xtx/C9muUvI=; b=RI2QVmwpG5pUbcOD
	cV35R9GH0hiLvqCuB56EAlUW0tZ8QVmEZ1fA/zg+iIMz7lXWhoWwb+Dr16/FP32S
	BRlBG8garMniWwIcR02qn0B+BlhAzdkWhJzLin/EI0Sg7dYc2VWzn/g2JwqoIGrQ
	YSJh2IVWNb7OadMipM+e2by+jGb7J1yvmNJ4LNHKPPTG/R/d1KaOMH0TffxRDMsl
	kbbJAG0osOGbtCoExQBgHcBUS9psJWEokNwjQk0oGukOm2P4bZ4vUZMMLw5F/4XQ
	MHtGCaBl53byzdx5MYoSQtthmEVUckBtbn7ZJGNglaZK+89Hd6beICJYDuF9rJ8U
	3hIOqw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0u1tghw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:51:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so6294080b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777445468; x=1778050268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0sJQxmiELhuOgvoZF2ADMqtFQSUXgp1xtx/C9muUvI=;
        b=cMwQfn8nEhC8X/mwYtIG5Cj2wbYCH6hzGFxFA5B8ZdQEvLZTXe5CdnnjYIPQ9s0HX9
         EkLy/IUMnVGA7503Co++xRAa/pCMI+0+Dlyy7ibRQcSvhyr9L65hByfyrsRraHRoYs9M
         s2R3KpyYHi1Ru4D+/YdzV2DLDXqfwKk/cOkY4r6QILLEjvr65kzYWb71nn9JGS+Wu7GF
         3aPByOwxyQaN36ewN9HEU6uM+/S0mgC5gjDgOf0UCWAGS1ALqA6DqJp4t17oV93vq6HE
         HfLaMPiS02TnJP0utFCY/kcAebTf1mlLQ6Y6Hk/Et0KomxWTr3jca+j1RunQRcbd82ME
         sdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445468; x=1778050268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0sJQxmiELhuOgvoZF2ADMqtFQSUXgp1xtx/C9muUvI=;
        b=hYfct2phGMXvlWIt2ABzoUHVGdV8A7++dcgiG+yoNu+jDAdTPRYyuj3ZgLZMZ9ny7F
         D1MBcdGljhJMaV26rIAlB5yvTamvLjg4ESTOdYmm16P8g9UmLJmSDcQ+O5ZJtmKBFq2b
         EkYh+6JyU+mHZYTpjflieL9qfrpoxCq0maXm3HfsimArXxn/EY37SGd7xUIp7yNZBJXG
         A8PnvdD0XGApevz+Lj79xfHHv7twePvRHIjaGgPjFR1Tm4DKja2SobFT3JJBEozHVJru
         KoiC/Ga7wb62mRvmmKkHra9QqrFm0aKOc3XYMVKM6PcywOlMrPbax8ThGir9KcMAmMRm
         eO/Q==
X-Gm-Message-State: AOJu0Yxv8wVE+yBrz7kigno/JrIDlQzurFQu/kw7pANeI4kzmR6ArnGI
	Jvnd1qaxOcvodlQbP7NtO5jwo9+kuSde9nuYUiiqFFp67q+PYx27sJq1b8YWXzTD9HEd/WN17Xp
	FMg7lLHbYuNoeoS1NcrLzU2jTxFpf5eVnh3ol+9POQryl2VjbE0YxAK8BNzbEGug1CqeZNfEwVW
	Ri8g==
X-Gm-Gg: AeBDietQoKAgb9BzxnbGbrtHYuDZwhHTcEhcy1ppSG1PfdOb0IkzxPBdheZ0NAQcFeT
	qLG0EKAZpBgpo7T32m/oZjsBOWBnZjaIglL1P1ZM2fTak4t/9PUScRFI3o/zOY/P/615UEVc6U/
	Dasz7nbU/GMVnFHHjQ919L66lXdJ9jVzx/BLLnYXOvCwwkXzzUIDz02WKSr2d37J9CLJeTLZChZ
	KyJEiycSkAcWCQVhT15ttoeKPoac13IMQh/eH+RCKrtD4Fo7MYFQflyg48kDcSRhT1DN+HjuaNA
	XZT5uqIXY8zdNKTP7BvcpvsJvCNoqJjZkTV+LzWsR4gDprhuCdsNV9Ud1gF78riujkfWb3UYL6y
	BEZX0VyHkjSMhBXd4h3ahQAm8CEh6t7I1AKB1YckOvnYt+Yjl2XS/sPy3ywadN0Ql
X-Received: by 2002:a05:6a00:1252:b0:82a:5e9a:922e with SMTP id d2e1a72fcca58-834ddc5aea6mr6341060b3a.42.1777445468472;
        Tue, 28 Apr 2026 23:51:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:1252:b0:82a:5e9a:922e with SMTP id d2e1a72fcca58-834ddc5aea6mr6341032b3a.42.1777445467974;
        Tue, 28 Apr 2026 23:51:07 -0700 (PDT)
Received: from [10.206.105.147] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd3aasm1059829b3a.18.2026.04.28.23.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 23:51:07 -0700 (PDT)
Message-ID: <77a8e304-e173-4387-8f8d-77bb6f3140d3@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:21:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: extend
 cfg80211_rx_assoc_resp_data() for assoc encryption
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
 <20260427150735.2391680-3-kavita.kavita@oss.qualcomm.com>
 <e3fa97dc1d0bc69477d3a2d2b2bfec6ff0ddff4e.camel@sipsolutions.net>
 <d5932baa-7770-4de9-aee0-c51c59294d83@oss.qualcomm.com>
 <a894a1e0b556ba910e7fad040210f9d531dcf99a.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <a894a1e0b556ba910e7fad040210f9d531dcf99a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oQARSVx9KJc-nA0eU8hVu7dI36rhAtTr
X-Proofpoint-ORIG-GUID: oQARSVx9KJc-nA0eU8hVu7dI36rhAtTr
X-Authority-Analysis: v=2.4 cv=aPPAb79m c=1 sm=1 tr=0 ts=69f1aa5d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=fpCgLw27Jt1RAFyqosAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NSBTYWx0ZWRfX99Rgbdj2u7Y9
 WcycIZ0WP9BJyY2gpOyUJU9BvX0EP69w/Cxe2vS1oAmSnqRnN20xTyWR96RAH4UbR2S7DUMxNQW
 JlmfRMBBuaRFEQPByD2DbG/UUcF2cvZlecaztuzs95tt/+2GOwT5zQnHdyVNhGT+RS1odc1Ae5P
 0dZ3oqLnGF2qzf2OKjfhCNPlTLHKvtXt/HvnGLmT1pWkPA3Nld5ybVLmvhLjqCsOWFGj8pGITSP
 ZlcphZXadgFZepikM4BopCmyvbgD7xmBavn40Pw22geDr+iuhFbbIjeHAIGVzHBLxtmvNVn+Pxu
 UN/e9+/Qxmv1BCJnVJ9L9hwaXI6FwAx51gUQLXeLCgeUii/uBsB0FQm8yvWTXtRDaXmn+L9Mn6Z
 QYN5GJTZYdPcKUKh168pwq7ow2Dj/i/gDjHZp32DVayuF/mSSetEnWhXVbJoBj3uf8ryvjKUD5+
 5aZB9BFMmwmlD1HO2CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290065
X-Rspamd-Queue-Id: D218248FFA9
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35567-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/29/2026 11:59 AM, Johannes Berg wrote:
> Hi,
> 
> Sorry I didn't get back to this yesterday. I see you now just sent
> another patch.



It's fine. Thank you for the review. 



> 
>> The attribute is intended to indicate that the entire exchange was encrypted,
>> not just the Response. For the Response frame, checking ieee80211_has_protected()
>> is possible since the full frame is available in data->buf, but for the Request
>> frame only IEs are stored in ifmgd->assoc_req_ies, the MAC header is not preserved,
>> so I cannot check the Protected bit for the Request.
> 
> I guess that makes sense, fair enough.
> 
>> While an unencrypted Request paired with an encrypted Response is unlikely in practice,
>> we did not want to leave that gap, so I used the epp_peer flag. That said, if you think
>> checking the Protected bit on the Response frame alone is sufficient, we are fine with
>> that approach too.
> 
> It's actually also something wpa_s could check, but I suppose it's
> plausible that non-wpa_s observers of these events might be interested.
> 
>> In the wireless-next tip, there are already commits that combine both cfg80211
>> and mac80211 changes together, 
> 
> True, but that's usually if the whole thing is small enough I guess?



Yes, it's usually for small changes. This patch is also small.



> 
>> so since the assoc_encrypted field addition in
>> cfg80211 and the mac80211 epp_peer lookup that sets it are tightly dependent on
>> each other, I kept them in the same commit. If you prefer them split into two
>> separate commits, I can do that. Will update the commit as well.
> 
> I think in this case I might have just preferred to have the first
> commit add *all* the infrastructure, and indicate that it's done for
> assoc for the reasons above, and then have the second just be mac80211
> to fill it?



Well, I have already dropped this patch. I was thinking from a wpa_supplicant perspective,
where NL80211_CMD_ASSOCIATE will be preferred over NL80211_CMD_CONNECT when both are available,
so the assoc_encrypted field in the mac80211 case seemed redundant. However, if there are use
cases with non-wpa_supplicant applications that might prefer NL80211_CMD_CONNECT even when both
events are sent, then there might be value in keeping this patch.

I am not entirely sure about such use cases. Do you think this patch really matters?
If yes, I can bring it back. I think we can keep it as a single patch. Thank you.



> 
> Not super important though I guess.
> 
> johannes


