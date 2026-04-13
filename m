Return-Path: <linux-wireless+bounces-34704-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H1kLwIM3WkZZAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34704-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:30:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2B43EDF51
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D6413004D09
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D729392823;
	Mon, 13 Apr 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5gc9r61";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DgkZnHcS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA193CCFD9
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094205; cv=none; b=hzOY1E0Y8x5w00kOyZeDIgH1eDg3AOPdk8r9f6verFHGyheygkU27zfts4XggEu9ZTJqLI4MQSm/B8uDvIXDv85LL2uI0vos0EPGI05aO809u1L6x8YRBb89eEDp6NdjmQvZuBJlKmiYS1x/5V0xGw3CGiJ6GnLrmrIEJakagHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094205; c=relaxed/simple;
	bh=hVSOI1QAA5tLK2nUoQnc5KPdyXGswaUlDt5gkQg9bUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5LyCNKZ5hNl8z0YcVQDUbZh/FPWqEOOHrf43i4u5JtCAOeQVcmfO+JmHnqtVvvzcCqdeu8TMcFmMv+/VwlRzsgkWdrzw49CjotTu9Pu0bKmUv5gowi+7S2/DKqlFVi/LXqyufEEfS6LMetuI6lxtwUk+Yq5cvvEMYPx7H4S8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L5gc9r61; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DgkZnHcS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DDxnS5479862
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XsBZdzMgUZ1Ovc49Jq1ZuQrmf8Pz1UqW5hXCPZ7ghig=; b=L5gc9r61mJFDtKk9
	T8/YFXIeg4zvO7QRN0AnnA1q99N35pFhSu5YWDoKrJhAldtGskpJJ96A2bSJHD1P
	DVH/mpAzSDuJXL49jXmQRqgA8QYtbwqmzgGS125IqaqceJpxsf+UqvHSmjoCeo61
	WDGyDe3iv/btnyY8LwVWu4YB11q+xYxTX0EyC+BrNcWv08q4X/PbjWB3qg7h1x7a
	NAKI/th+gy/Fy6f+DKDs3EYsVdUpOP8A6Iopi2k61dx2N9t871qzNg+ER/he08zl
	mdp5Y1WxpwCyOvIQl1vD2D2C64R5cbhanrCYuOo/iab410D9BF7Br89jNgVUd+mN
	UFjf2Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dguuj9sey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:30:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso15212335ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776094203; x=1776699003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsBZdzMgUZ1Ovc49Jq1ZuQrmf8Pz1UqW5hXCPZ7ghig=;
        b=DgkZnHcSc0QSAAZEWJfgoXCk/L9N5Pg2RSHnH6BqC0xG9/7/P2DlladtaT9XKdwez9
         wWCXMtY5BF0H8PYe6cv4RUq8AxLs7lFndy8onOWHVaq9fnTg1Lps/or2oIsfQ/MO7SVt
         DmqI3ewbmXPb1qvuNSem/BbOGnoBFa6ExMZMmnHZTZcJVPgwZ8y3PkWCfK8CfZtuZjLu
         3yYZNkDVPY+XZr1UcktKdsM6reZ5FvjP3MuBoa0WYLtoMQelnpXdiQIYD9mkpXsD9IqT
         wGRuLGqvTcVNnofp+doCGBaFJiLDURVU/7IGe34SYevIM51lHmXUN9JKFxwHejcNjqxR
         nFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094203; x=1776699003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsBZdzMgUZ1Ovc49Jq1ZuQrmf8Pz1UqW5hXCPZ7ghig=;
        b=XyR+wlS4Uvw6Q0i/HueawGTMbks6yFvozwtg8auIE/N7oCge9kfiOixpPly79gMsWC
         +kH1uJL/q5jlpSc1UCIqH+UTm/u5PQSkHfG0kOOmM3YReZM0KIpg17dglKB/pTyecROS
         4GHF3vrVeygNlphATm2SamTTEwVrRcL47lau3M627KkWLsWLSK06bw2gyL8zVchpld+9
         XI0CQyUcGGoVY6iSWuZfnnLXM5RvwS6A30xDloL9gXjpx9YMCrMnke8k+gg0CrCYTK0j
         GHOcVIFBbTypZKW0DNdalvOE/NXW0PK23C4nGRiYAGGmrPYyjamReJTAHXUFpPefSvq7
         KGuA==
X-Gm-Message-State: AOJu0Yxk9uL83dWw21zEKF93KYcigv341tde0gVWhLc1sxQHCTorYCQD
	YDw14a4ZkgfgfhQ2vd7pJPO2GaXhXyciXD+B9E4fg2DnXtdLcPeCBb8B2qiM8dT42TLoAql4Amz
	GG/vtO7Zrd6hmrJpRkTPCM3jNS4QZ0J7qOK9O7rJOKyUPeLRJux7oursbN31xaEN0GQwfnA==
X-Gm-Gg: AeBDiet9j4Dy24B96taFKxXl2LkeqTFWhugk1lkvDP1odWxc+bPewq1ZkFVS38A9ECl
	dfdKxIWJMuLJ3+YFEBIOyoTOIsOSQdLvuKem3ZnXmoUk5qL4zMDKbiljqWoo/VU5pHZhyczPncI
	b0aHDU/q6TFYL0Pv9vMH8UGK+bmFPeYsQV5AJ4Uwjg+eGk9L55kNZ0H73GjJ3Yse0riSMr6wJD3
	HGdHD+BezjkhwcaxaT1LZJPADMayc3Gi6l6IXmKBGy9GlJqY7Z8LfAUcde3ugRHIw4/W3Rn/Mbt
	lE+VohYUqr+ZWXr+UX4ppAwAc6h1K8Hw92iv/aw1rG6BBZbdfky3aR9PZYjnXD7UHRJQHAArR0I
	fROGwAUf0cBYIH2oDTDzJAKaYNrzTDk9MlwAgLhhFrFEahH1mlmmqEPgfRbDdaJY=
X-Received: by 2002:a17:903:292:b0:2b4:5cea:f619 with SMTP id d9443c01a7336-2b45ceaf903mr43676065ad.22.1776094202649;
        Mon, 13 Apr 2026 08:30:02 -0700 (PDT)
X-Received: by 2002:a17:903:292:b0:2b4:5cea:f619 with SMTP id d9443c01a7336-2b45ceaf903mr43675795ad.22.1776094202095;
        Mon, 13 Apr 2026 08:30:02 -0700 (PDT)
Received: from [192.168.0.2] ([183.82.204.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45e949464sm49024015ad.24.2026.04.13.08.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 08:30:01 -0700 (PDT)
Message-ID: <2e8dab9d-dbab-47ff-9b2a-d245b9ba064a@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 20:59:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/5] wifi: ath12k: handle thermal throttle stats
 WMI event
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <20260331142446.2951809-2-maharaja.kennadyrajan@oss.qualcomm.com>
 <bb391f8d-e385-42b6-adec-171c21c67246@oss.qualcomm.com>
Content-Language: en-US
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
In-Reply-To: <bb391f8d-e385-42b6-adec-171c21c67246@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MiBTYWx0ZWRfXztMalT3cTTbf
 eGEA7pK3Ik/f1eH2bMMRzKNwXV0k8xpAETrejie+vzvIKnOhvTN3Vej+xRPsvV3gCZwwkgtBFv4
 lh6VTFFJ/dQGUa+xLK1wu94ltCn+v41Lla1y8O1R55bvgIQVS9Si5oyTTqd/kINGspzzFIOgR24
 DWWo19aif906ADxCRhRImmlQp/dgMlFg7R8+Y6KVxrDuxnFaHI5AGiC60bWPRKwJR+DCrLTWAXg
 mkRcEBRaF8z14cc+g9Sx2p324Y5FmjjfZPV7iojf8bf3BJWk9c0pkiXDTx9Jza9yZjPV5VAjocV
 STZ8suWUN7E1vE5nKNidm2oNU2e/Pc1jM0GJMClx9J3SgML/I47wWFQkOLYcyoqUzZ0HYcSP6ha
 8106XeY4kImGix4v11AEq+UABkfP6uantiDJXHDJG6O42TgVIBV3gRrBDY8LXlWBrTYS0GMSQe8
 uIKrNMRaXrIAj1/NtpA==
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=69dd0bfb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=YJTfi758wS+jUHW9EIh7Fg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=WdzAzTw8HI4wpw2Cg8EA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: gigKul_uKZw9Umgpq4C1xPmumOyTzFoS
X-Proofpoint-ORIG-GUID: gigKul_uKZw9Umgpq4C1xPmumOyTzFoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130152
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34704-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA2B43EDF51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 10-04-2026 10:54 pm, Jeff Johnson wrote:
> On 3/31/2026 7:24 AM, Maharaja Kennadyrajan wrote:
>> +static void ath12k_wmi_thermal_throt_stats_event(struct ath12k_base *ab,
>> +						 struct sk_buff *skb)
>> +{
>> +	const struct wmi_therm_throt_stats_event *ev;
>> +	struct ath12k *ar;
>> +
>> +	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> please rebase on current ath-main, this interface changed with:
> https://msgid.link/20260407095426.3285574-1-nico.escande@gmail.com

sure, I will rebase on latest TOT with new interface and send the next 
version.

> /jeff

