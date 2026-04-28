Return-Path: <linux-wireless+bounces-35463-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIOFL9p88GkaUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35463-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:24:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227148151E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25363301B8FA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CF3537F5;
	Tue, 28 Apr 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lL8uHo6X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U5V571rf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E8374160
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367897; cv=none; b=bwgHwbF0Mk7nh4bZt5yFYF52ueKOUxs98c3pX1sBNUcTM872FG0P+wfYorB40Pu1kDTPtcb+6utef1HYnoCKLZYh1ZQRQkNLZNRBiUqe6xMmTP722vwsECVY6nzXL2MG3aTGGy9LyfHJ0nkV1RLfyPVBoXBvg1Xg7GQ0yfroDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367897; c=relaxed/simple;
	bh=G08mjMHO46ofZTKCtmH/c+hWgQpK2cOjJS/HP7NBaMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkAThSz8odSKPRi/UatiSWUxwJ60Zh5TtwLGRWsZsiaqUdmeQAm2q7SpQax0xEbY6w4IcM3G+PPVciLmgnUZX4NHdESUSrRU7LHqsdYqRb4ZxtvFxHwvu20VpeuFKWyrWgOW4kM/0PZfR8v/uEA2p0YD9rAKIsQrxQtGHgSF2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lL8uHo6X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U5V571rf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S42xup1329658
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Otls/h4K7uSfBFsrPqmiaV3P4P9zQt0i0q0HdjhzTP8=; b=lL8uHo6XdMjh7NIZ
	TtkZPDnSEC4a+Ktv8gLicDs4RkEJu/CiXeaJxJeGUH4v7NetHoJ+YSmsj4Xi3+89
	v4EwLJca3E52a6Ea1BvlZyLalF0XRv38kQgsl0RI0o6R9vIDflXVlh8hB+rnRosY
	X2ogkDj3Q84FG5onagHE4pTyT+aD9/bEfEU2tZygxHraemAnW4idJVQcBR71ADS5
	j4j2tCTVwGrPEeyaw2USf1MoGiecug6mt5frD2XPUJeZXhsrIM4M4Bt4Bh3x7j01
	RNGrgTYZeA4dDcFti/zP9BxWSgUjXtReE13qYJjNaHYnE1+CYyGmg7JgLd2ERM1m
	BR2Rug==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhah46q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:18:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so5910576a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777367894; x=1777972694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Otls/h4K7uSfBFsrPqmiaV3P4P9zQt0i0q0HdjhzTP8=;
        b=U5V571rfDTVz9mmLJYp4Bo0Zh7yB6UARwzirlbMAPrqax8xz13b/9d2/7qp1EOnqsf
         0PbX9ZrDAOZ/XtlntOqjlupoJiTu8+7JZCpxQaz9qRyJI6mMLlja3PTBIQGlGl1kajZl
         +35mSEvJ6ZPnTyjA39tnDXdCPqrFtZwAUxmQJvdD7ZkCs095qrnbpbU/hxt4Bw7gSVg8
         ZWlV0xyK7pqtEnZhmmOV878/atYa4/haqipfw2wc84mkVbbPz0+pn1k4Y3k5TUC3+amr
         vS26Va1Wk9mifCVKHCxZaUhN7yMrOimSttw8AjZFlPHX6DtQAkVxz2uDAV98MfVInmhi
         aBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367894; x=1777972694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Otls/h4K7uSfBFsrPqmiaV3P4P9zQt0i0q0HdjhzTP8=;
        b=O7E9mU2N8lBRnbyssVuyvtrV1r8/BhsC+SqMz6Q7TPMOp06Cwh8op/mTsg9KyIqKOT
         cihLlCtvRSXduS9FM0XqoM/Q4cWD6jdbNlZDHNzSEl5uyqS/CYn1rxY8F8Hw+6GW2L4O
         hQLsddeygXT3GEO58Iw6qGwi0MzybiQvN5orSXcyV1eRLcmvQ76sfatTK1z/Fcb9xyZb
         yLZ/wVlOuMeP0pLlkUGatmgvKfU/cBqYnlmCzfNJ58jWPeIibt7owi0/TTgc/aeyvpY4
         4F/YADRI0Rmuz004vcHH2I5E+qq9yHx7/tQX7ILd7rJQ9wCvCWOIDahR1lBIoN3LV3EW
         hC1A==
X-Gm-Message-State: AOJu0Yy+tT37vW2T+fKwV6GQ4u04A6rDP6MpGdCzhVPbFDei3cY2N+VF
	nHT6VVyB3DZNmsXSVrIMhfiW/H7m/Y1fzBb33LK7/W7ivln7JntUhzTMdih4xbg03bMP8t3+aK8
	TFtmxEA5HA8N2TGGOUHm6k7ZtiVtK2y+Buwgku9C7FWpRzU8fdflNxWEwSj5THSVbzTT92bjyBH
	gvDw==
X-Gm-Gg: AeBDieu5FcuTXZwrRFlQG7AEkWZvQEIjeQKSLZZRuxZn1Q9/EgpQhOZaX+1tpJR/lRw
	2JW9bHLhRbLoQDswhpfniuukVSw39g8IcRUYrUUc9TWn20XpY9mgT7Gx1Kry4EwTRfE27iy/cR3
	zcKlGndGKd+BDptPQ3XuQDouBDi+Mjmx18oV7G8sBEvqNgYJATbKEOWknVV+XjSUgOGevk14/O4
	9EoybTQfC2zgmbMGu3nVe1FkH6U1/1k76ppcHiTCa5BB0bW9RCtERNbgxzaAO+OtWpmJ4I1hn4X
	SVWV8Jkm7MbvYuEdp8eEMgPc4dc0lmuu6N4iExB8xDDRrbj4uK1e7IkoPgltNFgTlnVONXXelNn
	kcR0byD4f+APEZa1W0vFoJKo1vXWgYaXBoBKKGIeWGO5yMeuU6pgu92xF1FdG04it
X-Received: by 2002:a05:6a00:9506:b0:82f:3e9:7bec with SMTP id d2e1a72fcca58-834dd3b2766mr2398580b3a.12.1777367893651;
        Tue, 28 Apr 2026 02:18:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:9506:b0:82f:3e9:7bec with SMTP id d2e1a72fcca58-834dd3b2766mr2398549b3a.12.1777367893168;
        Tue, 28 Apr 2026 02:18:13 -0700 (PDT)
Received: from [10.204.116.209] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae00d13sm2062091b3a.8.2026.04.28.02.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:18:12 -0700 (PDT)
Message-ID: <d5932baa-7770-4de9-aee0-c51c59294d83@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 14:48:09 +0530
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
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <e3fa97dc1d0bc69477d3a2d2b2bfec6ff0ddff4e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfX5iEkfgzQ6Gpc
 kkgj2zW+xtDkzyRP9YrlxHzVcNCdQZJP+g5K/SgFjXBR1YIfphPDOkPImuk/rYTjThV1R/W5B5R
 xx4/gwS2coKJYeqOfJYbDHrVIZm3wel0ATTxDsUcQaRtCwG8VWhh2J5E9RAO0QS2WVNVb9ThjCh
 sJJfl3jV+m57ittI3OQdZaopdfgUZGzdmszdFnnp5h3P4t2/T1B/AAAO6Bqql0L8BnFBH/l/s1r
 vuA/i1WNJ+A9Q+kQ91exbeS10zL+KuZV9AN5sVqPdgfyZemE8dtiVs3cG44CHboQYg1oqVekZ30
 HXBmJoj1PbP0A7Hw9nG7GCMtzRNJhLSqgy2Ut3KTLcqQDvXLU6nmmXDTrt7HzzdecvY305vl0AZ
 yk0JDy8D+BMcL2mvzDcNWmR0GvHFXEZMq1gU9cBkbcVEWbEpERRhQm59t5usFiNlv0/aT0g9Ci4
 JHzUwwmILUQBdJc39VQ==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f07b57 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Vcrv7xyrgljIippMtdoA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: ll7brlo1BmnaDPpJwkZu-YWEDfchmvcN
X-Proofpoint-ORIG-GUID: ll7brlo1BmnaDPpJwkZu-YWEDfchmvcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280082
X-Rspamd-Queue-Id: 6227148151E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35463-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/28/2026 1:08 PM, Johannes Berg wrote:
> On Mon, 2026-04-27 at 20:37 +0530, Kavita Kavita wrote:
>> Extend cfg80211_rx_assoc_resp_data with a new assoc_encrypted field to
>> indicate if the (re)association exchange is encrypted.
>>
>> Currently, when epp_peer flag is set, unprotected (Re)Association
>> Request/Response frames are dropped. This ensures that by the time
>> the (Re)Association Response is processed, the entire association
>> exchange is encrypted over the air.
>>
>> Set assoc_encrypted in cfg80211_rx_assoc_resp_data based on epp_peer
>> flag when processing the (Re)Association Response.
> 
> I don't quite see how this is necessary, even in nl80211_send_rx_assoc()
> the whole frame, including header and protected bit, is available. Why
> does this need mac80211 involvement? One could ask why it's needed *at
> all* when userspace already gets the frame and should probably process
> the frame RX preferably over the connect result indication...
> 



The NL80211_ATTR_ASSOC_ENCRYPTED attribute targets NL80211_CMD_CONNECT, not
NL80211_CMD_ASSOCIATE, both are sent from cfg80211_rx_assoc_resp(), but
NL80211_CMD_CONNECT carries only IEs with no MAC frame headers for either
Request or Response.

The attribute is intended to indicate that the entire exchange was encrypted,
not just the Response. For the Response frame, checking ieee80211_has_protected()
is possible since the full frame is available in data->buf, but for the Request
frame only IEs are stored in ifmgd->assoc_req_ies, the MAC header is not preserved,
so I cannot check the Protected bit for the Request.

While an unencrypted Request paired with an encrypted Response is unlikely in practice,
we did not want to leave that gap, so I used the epp_peer flag. That said, if you think
checking the Protected bit on the Response frame alone is sufficient, we are fine with
that approach too.


> If this is needed for some reason please outline it in the commit
> message, and reshuffle the code to properly split between cfg80211 and
> mac80211 in the commits.



In the wireless-next tip, there are already commits that combine both cfg80211
and mac80211 changes together, so since the assoc_encrypted field addition in
cfg80211 and the mac80211 epp_peer lookup that sets it are tightly dependent on
each other, I kept them in the same commit. If you prefer them split into two
separate commits, I can do that. Will update the commit as well.



> 
> johannes


