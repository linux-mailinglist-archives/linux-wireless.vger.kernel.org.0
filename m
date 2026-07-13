Return-Path: <linux-wireless+bounces-38993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nPjfF9I6VWrulgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 21:21:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED174EADD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 21:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=fKrvpY4u;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=cvnEZyGW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38993-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38993-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77584301BA70
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFB353A92;
	Mon, 13 Jul 2026 19:21:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14792145B11
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 19:21:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970511; cv=none; b=ej/hYoBG8UmQrLkP3LY2OD5YrE5/z1wIY4oZgZSjyMh5+HF8Ht7KTtNV7jG+5QtTF6s+r7Tz3jBECVZ4YBSpJCkNPrgnc4LnRaDwA3uULjcjSkYfkwtUQCV7Ot9zBROfRaQ/CMvYwdaYfZJSaoNbf71YFwqliHSGicOdsiWxEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970511; c=relaxed/simple;
	bh=6LhmMs6hd+KSZYCGAq/TMAbEdTqYXcrYq1DH/orpYdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndhoSQ2aWmfOHo9GSaOwQzWw7w34vWvsgJ65Y0OFhpJ7xyzKWeZyjesMEf9pbcE6pkaKTPtQX8c+mdut9icZ7yaECG4qTQs10MXDUmdG7SeBxhkpO63O78PS+2M6zP7iCb2tmlwt/3SQsrz1ryD/bL4FcOullLfyf+a6QAk/0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fKrvpY4u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvnEZyGW; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9d9I2460889
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 19:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gv0EQ18+ZmfZit6oXwIeJv6aQcSqfBZoI0pZMq+t6LE=; b=fKrvpY4umBBDZcYc
	LnpopDJ4yAtfDAx/r8fwdN2y41K+ntfE6biQocPvdCDTjewXd7phctPYfB9dyECj
	quTxy7q2mSAogXu0sG9oAGUE1vo7ciRlLx2i00DxAuKd71lFxM4wWCFhSzaMfz7P
	G290R1F1eWf6Rygb9MM23yXV+aSIdf5Lc21012vNQxjRwMxTr0yo05mZokUjXqYF
	EJpgbWO4PK3OHUVrKYTAjF+Qyx9HJHlCn9v+VMpdjzhgP6z0rMEeyrF1AVEWITFA
	OCMHLckPX/XT/Ac4GNLcP7ffz9hisEK7oPKrjXh2oiqLc2S4p7uCLv/WorC5KoEC
	2Iet1Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda2bbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 19:21:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc73f47bdcso60011455ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783970508; x=1784575308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gv0EQ18+ZmfZit6oXwIeJv6aQcSqfBZoI0pZMq+t6LE=;
        b=cvnEZyGWL+OlbM84Fabx5tWefvDdgE2JMjlGj8W72/wZ95jXpF/KH6syjtcDWSPWEn
         UpJraua4h87GpzHwNaqQ8fB9T9dt1VfNgukmdGYKXA6wxrg2P9jXHvvIHSY7C5v2yZiD
         EY9Ok/YvWsvplGBwrZHkBaBtXkqgoYYrHOYaR/RwHz8W/OymgKi7/IAKTEwDo3GM5wFM
         uhsexK3DzZImTWtPIrpF474HAZJVv/zw6Z0zvKSm9lLWqPhGEQm4DvJYU+nxgm96yqtN
         zROJQWcGlhYeOeAz8lW4VV1dZQjnuhgmK6Z4gukJESe1QR5cuJnbTgN9iHqgNPKiJOYY
         wE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970508; x=1784575308;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gv0EQ18+ZmfZit6oXwIeJv6aQcSqfBZoI0pZMq+t6LE=;
        b=EFUHbJmambecdRAdbzQLqQOiZZS1rwT/JTdIev7tMmRURHjhqSzqK22ilefCM5uZo0
         DEqCqMS2nkLVYorraL2FumZxr0CxQqALJUliYbVlMZ2ZRotm6dEqkyGB1WMWVvdvuPN/
         PmqWZgHjFyLwBqDvqOtVzAhqp1Ue9YmOSsS5yykOzhcsF/iOoK9fXWAMv5aq/ea0+eT0
         qPxK4eDMcKVHpmee5Bdj72QdqxP4vImRE9Z0Gk/9UKSgW1ADeJARm7TtXgf7lwyBZWDe
         m8dclKrXKwzTUNSLKwGq3c4SGfSipQ+WBjf1UAa3uW/rgqdEf9Pam7+LZZ5DGn13aQ9W
         fHFg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7hvaXC1x8vL/ueCt32/iW7WTcEPxV5lR8za6wuPHqoWM66P50oH6fAtBOOGa9g14VCjkUxdf/npE/QfMOcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Mpkd7OYnYo97dYsm6y/W7hu/62S9gWrX6RYt2IZ0zhcYQh55
	O9q35mIbKaJ7hllvE9F4TQYK0uLZdchNTteRF8X6ygGEvLHr9+El6M5hn0WMI56P7HD52FPtZJP
	K+NIh4106rp7ESw/bFmGYJg7k/O9YA2lVftI70EmWxMiaHmqtxay6Rt/LSaaNaoRzPQOO0g==
X-Gm-Gg: AfdE7cnXnm0XDfc0FKnRyPDpgbQPZAfVGd7MdjUcg1CY0ATVH1UXTxIckBGdZDj4VF9
	Lhoafm7CkipXN9p+/kNOrYCs91I2bqG5tSnwybm1IyY4efJMqn7FEUYUt2xajDr/fBP3123qAjV
	ft6sJCmiZas3OF1LVSvjtuBZGBEB7NCCpLG31TIxIjUyeapag6klIFLEWK2jhhL9+4MXaTL8jfW
	IQ/tHVBDRPPtMTDJgDTBK8dUkOL+ZXmxUN5C74cgf6zDW0rs1rEhVhzDZ6BX8UUYiu99J+3aVu8
	RL9SjYIkjZ0olkajyDAum0JvGgAQzbiYkwbPyX7d96FEqJ85BqsjF3iSOma90GAqpsEZJynd3bM
	zpNq3kqbH/jHSlSqpR5AwKMLufathdJZmoKeVq1dJl0gVKVk4g11ouIUxzNPWdt9WRywX
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr9489009a91.38.1783970507912;
        Mon, 13 Jul 2026 12:21:47 -0700 (PDT)
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr9488989a91.38.1783970507346;
        Mon, 13 Jul 2026 12:21:47 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm55950750eec.22.2026.07.13.12.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:21:46 -0700 (PDT)
Message-ID: <b1d96a25-e2d7-488e-b8f1-6452f4d83bf7@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:21:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: validate assoc info lengths in the WMI
 connect event
To: "Doruk (0sec)" <doruk@0sec.ai>, linux-wireless@vger.kernel.org
Cc: tristmd@gmail.com, johannes@sipsolutions.net,
        peddolla.reddy@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260711071336.58324-1-doruk@0sec.ai>
 <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
 <CAPdMp1okStu9UiWn-Kb4xrTEdGj1POT4t+moh77JHpLSzD-pZQ@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAPdMp1okStu9UiWn-Kb4xrTEdGj1POT4t+moh77JHpLSzD-pZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMCBTYWx0ZWRfX1mjt/R2XAdnS
 pKLJJaz52O3K0lWxmZNVHAcW3jrytsTEkyBCr21x5dwOXQxS0VymMa0wv4FMLb/oH8kvTJszE2J
 W/zzzu6DjxZBPyXCt8f2ZqbXZPE0Pgk=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a553acd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=PVemK8KFIP-Ydl4GPKYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 0T6Vy23LdJhFj-WUeqUZqVfwC1oxFO4f
X-Proofpoint-ORIG-GUID: 0T6Vy23LdJhFj-WUeqUZqVfwC1oxFO4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMCBTYWx0ZWRfXxv3fCd+r007k
 YXfBWgVxM/gX0rTqrDL8FM+kOFt5rBC8I+QYol+RHV5vqKR+QntG1DgBXyN5odE7Js/cBuGjAIU
 oRF1Bs5vzavLqeMjgJfT2g2wKyy6Cx3jHLUHixxfzgnMr7tOjcSIwlr05gB4vgev8zJclFmxDPj
 ise8aa9c65XDOYHk4k5Enarizd+ci/OKNxX/Ie3AEqHyUqUfgY4G0/qMVUFmy25mxmwFEFSetwy
 JyLOzXnbWOraZSDWLyyH7ImZNGR7iYEVivpRe3x6pBGk+u3BgTqmRnA2FWZKeXAlWxIrj71mWP1
 98xlAH7o+A54121iKVgnvRhvyRLaz5XURE6F9RDDktDczdxCIN4UofIMSyoM2thjWyzMJY9V/6S
 trprstMb+qrpS5aqtCM9VuVXujuynUkQC66D70bNAuVgNqJINtWsBmpc3q/VRInpv+1333tT+Pc
 V/dWsnxt+ztBG38255Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,oss.qualcomm.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38993-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:linux-wireless@vger.kernel.org,m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:peddolla.reddy@oss.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1ED174EADD

On 7/13/2026 11:18 AM, Doruk (0sec) wrote:
> On 7/11/2026, Jeff Johnson wrote:
>> Some aspects of your patch are already addressed by:
>> https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com
>> So you will need to rebase once that lands.
> 
> Thanks for the heads up! One thing that looks like it may remain after
> Tristan's patch, in case it's useful: the aggregate check bounds the case
> where the declared lengths are too large, but ath6kl_cfg80211_connect_event()
> still underflows when a length is too small. It does, on u8 values
> with no lower bound:
> 
> assoc_req_len -= assoc_req_ie_offset; /* -= 4 */
> assoc_resp_len -= assoc_resp_ie_offset; /* -= 6 */
> 
> so an assoc request/response shorter than the fixed offset wraps to ~250, and
> cfg80211_connect_result()/cfg80211_roamed() then treat that as the IE length and
> copy that many bytes out of the small assoc_info buffer to user space. That path
> is separate from the aggregate over-read Tristan's check covers.
> 
> Happy to send a small follow-on clamping those two subtractions on top of
> Tristan's series once it lands -- or Tristan, please feel free to fold it into
> your series if you'd rather keep it together. Whatever's easiest for you both.

I've already landed Tristan's series in ath-current, so you can base a new
patch upon that.


