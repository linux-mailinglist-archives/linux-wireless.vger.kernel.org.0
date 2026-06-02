Return-Path: <linux-wireless+bounces-37305-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IivWEhP9HmqybwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37305-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 17:56:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17563003C
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 17:56:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=OMWgcxL4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=L+ekAIv6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37305-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37305-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2AE308E269
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C23EF67B;
	Tue,  2 Jun 2026 15:45:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596EC3EF0A8
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 15:45:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415101; cv=none; b=uGJf1c/T5l94wFvfNRYsQw4aTJcacx21EV6oWa5BUR1FGoZ7Oc2LlCje9aVg1fbhqoYer9RvGO3VQ9m/iRmiyRXg7gdJjgUuG0aPql/Lp4aX2xy6HeHV//T2NZpOdP+0jBEiSekFg9MUkNfale7OZCpLiXHhpE4OsIyojKxtPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415101; c=relaxed/simple;
	bh=xVy+Gl9owsW8sss2D6Noe49W19nFpGI9cP//EwwyS6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCGvqZ2SfEubjZUMAwy3bzX0xmhJca6fDWegm84JgH/0jTdczITThytKP9ekVqxYbmAJHGtgFt1pXK3ahkl1M3AJbDAxhKOOKMwdfxtJ2iYtB1dX1QIBGEdq3WUR3F3UUfYhK2E16BatnM30Q7vCKDhJwKBt/xcjJ6lNGRxDbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OMWgcxL4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L+ekAIv6; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652Expof3429831
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jun 2026 15:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ebe+V2jLydn7Ft5tpoNjy5REqBKoZogMhUeU1hubuHs=; b=OMWgcxL4sCgbBvUI
	i+sN5bUChYwT8drh9ipc2ibOb4d1YbofhUxNSaH39hsgyGdSNB0/nWrfs/cQc0R+
	Um+83tkOroiOW4MSe53O36GlQNDsogMwCCXFLt4KCFRn430V1riiMUNBdQTvz/ZJ
	P0MzQtYG6j7rbbUFOEXugD2f6vRYSGQOl2Wbx7KOKoajYvdQcRIqaTrAs/6suFZO
	lDksH+Z69kdgX74l3EkbBTau40MU7+QEDdxpJxSWzfjo1Iz2bdNBDUpHPIxBpSXH
	Z6EnIVrOh/nP6y3gM/braeaLdrTHHVdH5ziRV4eJ0QiCREFaabxqA+tWFs2ProeC
	REWWVg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mka3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 15:44:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304ea1eea05so13156944eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780415099; x=1781019899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ebe+V2jLydn7Ft5tpoNjy5REqBKoZogMhUeU1hubuHs=;
        b=L+ekAIv6ZZ2C9lDcOXlkOnbENU1mbRqZsUeAP0idJCdZJz6sLzcluV6mjette856Yk
         4SvoMESamOwfKw9tWuR0keG07zmOcmoGVSH8YcNOPNyZstwr8zHzj9ACEEmgwU6WtCq3
         bOzAq4LAFh2EF3ovhdJEi5XX6fSS+p1WOrJaPQovd7jcEr+zjF9NKQScCLNLscvAIrt9
         rfIO6aDfyHPVcUpQ6PyTcha6Xrfa9CxdNZtxaAIBoyL5Q3vXEyUowQyIkZ9HyeLQYgNk
         cMEVc5p3PE7cUY7P78FTYuhup5qLyizmvL9aMllx4ZJKRTgzALv8noiX3kTn1AosErLR
         1pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415099; x=1781019899;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ebe+V2jLydn7Ft5tpoNjy5REqBKoZogMhUeU1hubuHs=;
        b=ZnpYBj9RnnTDaDzZ1/5AdVetrzofhNsK/Hdj0er4lpS38CQ4VWa0KATbJhvJe98ukw
         huDd9rK8vir564y9ebrDqBPsNQOrcx/WW+HsB7Ve/e2LnumzVF/QBal9xbZc1vLwhUvM
         VfQgvB02vW8ZIEUixHKdwQnCDFwq7fu6ya+OgCb8fYI/sh6c7SuLFwe77v2MYYZBrBub
         FFWvsLxx6moz/+kpjCG4dqrmJX7mYZj9BkwV8ZEld//ckFgoVpGfQNQ4UfUuIxg6FQqT
         +zduDhZfGC9lLn5V4N6K7pzhbinnKzO4XM5Qm1u6zhv1f9oEnUMyEQau4KQ8YZgzbjoN
         SpgA==
X-Forwarded-Encrypted: i=1; AFNElJ9TDD7uiDornp0zF8Qq78/vgCZoZVwylwPERwQQF6cuRdlpdNPFVWic8+lgJH5pXHj97LmDClduFQjyLX96FA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0F8XXMVG23PSD8mOQTBkeb2IdcxrdO56x/w8UmRf6N8ElFBao
	+6oz/5a82nQ/cC4FtdP3zzyiIq8sqNfbr1VM9xz/OvB10Z3lp++Xh5jkU3TcWkmoWWW+lt56J7o
	LNE0K2kGpGtrbCWhxJEVrcdNQhJxghtK0Jxnkrvix53kn/113JJ736ft9SucAtFt81/B3Gg==
X-Gm-Gg: Acq92OFKzzskX5lFrxIIUd/3PLjYgr2Hnbo9LH2ePnueYhSG5FsBCz9CwvBlbBCD97j
	Z4kRWy/R2IsC4fvxjdXr2VP0dkkvpnUL9ITreCwN6vtUwsDIL/jDctDU2oQXAmnL4tAQIhuHBhd
	UV0G5GKvEGjE73Yc7n9pmNa7zigdlDTj2JcZh06gJYW730M81QRBT4syZeUgmKVBCNFXqzkVwRq
	gYp+ATNkOBnn1ElPd418XUxFq2Lod1U2oumGmBXrYJfd1wVOhqCEjBbq4No8gUM2wGgfqJV6nMz
	sCcmzAp5hJGl2IbM8EXddKmA2yP/fJD90i2jf4GMzzFRgarmyypEvh0sRADQbEDCWHf1+q+rch5
	bxW3Shj+Qo1L+xX0QPXK3Rh0l3NqtqNfx0G4gVFYdaZ0TkKX+CxW4X77LDDOaP6QixeONPlpN1H
	v5MTScRLhqzTFAj9MI8Ts+GTlU
X-Received: by 2002:a05:7300:2313:b0:2da:4216:7ea3 with SMTP id 5a478bee46e88-304fa5c3061mr8808262eec.14.1780415098976;
        Tue, 02 Jun 2026 08:44:58 -0700 (PDT)
X-Received: by 2002:a05:7300:2313:b0:2da:4216:7ea3 with SMTP id 5a478bee46e88-304fa5c3061mr8808244eec.14.1780415098403;
        Tue, 02 Jun 2026 08:44:58 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm16673956eec.21.2026.06.02.08.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 08:44:57 -0700 (PDT)
Message-ID: <368abbdc-5c13-400e-8e19-5c0be4e3451f@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 08:44:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath9k: improve stability on AR9330/AR9340
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        open list <linux-kernel@vger.kernel.org>
References: <20260521232445.261915-1-rosenp@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521232445.261915-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE1MSBTYWx0ZWRfX+47M28htSekZ
 +qurvgZrHeStoabO4v7iy3TzfqOpYyRi7kmw2iTtf7fGrpP7MMKfWYD0T6pZw16rMhTzxg8v3pk
 JMZTdbH8AyBPnkBnWNmsTa4u79RpACen+95JoORCaVy4co9zOSczNguGBLwKKRdl9tG6gRG94NW
 cRnO7SMdJJ3IXZtNQzes6p+XIWhD6FhCc0rqw+MsyxP5B3l3y+zaRLm9ewyFeTTI0rYSucPRS9C
 CObTxAxONRFB+5Jzdv25fY8RUDhPsf8wZR+UG+7m+1dX/ysAj4MYmIdqxkpbZU00CxbSAJ9Im0i
 OjbyuqJCDQnsRRDO3tKS1Qq1HRp5SfPuioXqLEhIuAsDBcZk3E1QTWBFot4TT+rnkYRfjHcszsh
 ucv+Iu5Jz+VTQQMkVc+c0auX+n4TKoVpMNVFyN0QWkkob6hepAvMWu1bSVmumr6aT4GAueHHGBL
 GGUkZCqnlsoH5bOtWww==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1efa7b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=uMpC628K_nIDzC0RkeYA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: sDyfLyZM0YhwChLCG7JoaPAUN3YRldEb
X-Proofpoint-GUID: sDyfLyZM0YhwChLCG7JoaPAUN3YRldEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020151
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37305-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E17563003C

On 5/21/2026 4:24 PM, Rosen Penev wrote:
> +static inline void ath9k_hw_disable_pll_lock_detect(struct ath_hw *ah)
> +{
> +	/* On AR9330 and AR9340 devices, some PHY registers must be

note that networking code no longer has a different block comment style, so
please follow the common Linux block comment style and have /* on a line by itself


