Return-Path: <linux-wireless+bounces-37846-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ODogIGFDMmqdxgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37846-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:49:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBFD696F14
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:49:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Oqhca9Np;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BFGVty9T;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37846-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37846-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9584B301E58E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A13B0AF3;
	Wed, 17 Jun 2026 06:49:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC063064AE
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 06:49:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678942; cv=none; b=jMvqYLJrSfc933xUm3VcH6N/YqIOXUJSzlnU4VcAPwe+NpnNNdt7jaAGKvmyEOYXw0ZwccUsP/iSX/0py31cZrRsXteKJ9e3dTWz25XWG7MZsvb408NN688so3uWGku+E5Gv6pFafmf8UkS633wqEds7oFTHOkoBsCTcjH6sFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678942; c=relaxed/simple;
	bh=gehxnEUlAEitIyHk+F3HDOJvsUcQMfztMee+yoBNui4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uamMt4Ucj4neEmfvLer/OUq7lHNlbHomzqzvi+xImceYatA+OZEMPB4u2q82DW/ZndS+5qe+sYir/4G4QkYfCW9t/eVTeweL5oLODrxFPxhCyyx9eGKRmK5IflxaFN8t8B1OeXC9C3JYauDkepiD/hEWcwnJvr9QOecwe0WgCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oqhca9Np; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BFGVty9T; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H62Duq736993
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 06:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l8sXKAn7NodoWIBzkzU7p7jMP8ZjJV9xJRxBLf7gKME=; b=Oqhca9NpkNjoPHrU
	OyBHDR/7YOx0lJO1pRj+NfNiZJFzHic4mFFuIxYlexNnb36t9GO+xgFSiWsShLJ2
	KV/5PdY9KkoSsnCzIJ19LeCPHFzndI5JffqT+3fIrNTjKOZ97tV5hG+SOa5G+AjU
	NOWvxZ5LHyff07USDUogk50XVSz6tLKs2CiD6oFZihPkLJcKYG/xGOkSbFxCPYSo
	sRyZUgFtz7Fy86+7RBya76+eoSQmWixCzhjVCGsQg8O8tY9U1io6OQ9oqW9xrr0U
	nJlS3c9Sab8aoNvA55nGl3N5NOSsD/4SkFXhzN7z4dtIiQ+9NtavhzBfo/xKOkiD
	W91wGw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueeshuw5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 06:49:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a2bf5388so2550329a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781678939; x=1782283739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8sXKAn7NodoWIBzkzU7p7jMP8ZjJV9xJRxBLf7gKME=;
        b=BFGVty9TAVl66C3/zF/ks+jCFJg6WJTPWqa6NzqrNNZDPR/A82X7yzBzuV3W/TR/Vy
         deVAzIDI2KXEI9SX277JQrzd/txzmR3Y6VM3feDVJ80LX1uhFHn7O1dnwYId9GrmX7lY
         YNdeGubDLQs+ork7uSsubRIG/yBK6EwCzG5l1rBUi3pA6LLeqvrE+Ayxl3uwz7R0Hm1q
         /7mXJf1H/ibCWrAZZEu1uy/suTC6OAHkIaB178icZ1IFLIno4/XfAJovVazVK3YWZm1N
         VhupCtswluOFzzsn1EbZl8/MF65qcabjFqeTokFIRYuO7hjaaTs3ungIaAdcsWhOLTe/
         gWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678939; x=1782283739;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8sXKAn7NodoWIBzkzU7p7jMP8ZjJV9xJRxBLf7gKME=;
        b=ghHS74WKj7ujnpt4GSfocJCyPqFZRck/lTARoAMJHuy91TA0709Nl15Yk/I/6wknv2
         MAFzgfurrxVv8JhtA4GbsO5SSTfM3LOD49A1CJrRqEldB+TirvF8c/J8g7skst+3R1rg
         K49eZFPlEJqfT1TS7aXSEymmVemQ3/PO5w3GyCRCB0S2IaKHOCMa2wG/PoHHtXX47UG9
         1itC8tQM2stPB8r78xTF9p6bJXiNMMnUrhFeWl4jKaUZyaUufJTpL/R6vZasPzsfc/aS
         J+4sbDfKFr5O/k/oRCiYc43BuK/E1wVD2EQhYhsp+e8+1jpBHh0eaBALAfX4J6SFiPsY
         VfwQ==
X-Gm-Message-State: AOJu0Yxu+5Q3YHRO9m/5i9kJXHhpw89wZQh1Qml5qRYlN2GdTGmPPCjn
	tooFt6rdg2oRXs/ps29++xwmKwczeSNaTzboSngDE2JssxoIIZLng1L/bU0GXcBy4nIPH1tld/B
	K14FbcufNrZjMabx5BV07zdkJkrlCq00vXRP2UL7uA4Crx+8c294ETa2qcbNSUXEgs4iRYQ==
X-Gm-Gg: Acq92OFVjr6p4Y1MyV3or4bsPHkqS75GZhfvsBV0IBniO8gJzBHezYSRPCVWoS/vv2K
	kOmanuTb25oUE3Ew6jVVffGn4pxRZ90KJQ5uQ2T6Ud/Oeao4oYQl8SyBzk/05ssa5240T+YjcT2
	oaMJkpubVa2glKYvhRrp/1b/XkYImvRsqZp/DAOQNJ0prJFQ2120qiQcndMOG+mcyLqO+1ZZsUA
	HHwUGor+eaXxpJQItcFBUtMG8Hq3JFsfxXRh8hIxnZPimZnix8ysWagRm5M3wOXd/rS0g0OO3ar
	6+sZovZA+MNvCjjPcG7OSUsIMwNtAJOhALqxviVPIuqmDdlNSYcVYrXOs6n/HZ/oWajJKHvdzqf
	lkmJs0X4Aduqe8LHOTOXg2/bwXWfKyReGnjSe0oAEnKlwM5woMxb+/AFqI4lAvCRBERHsQkQR7G
	l9ioE9lSE=
X-Received: by 2002:a05:6a20:2583:b0:3b4:e4f0:94e1 with SMTP id adf61e73a8af0-3b8bf0bb23amr2810052637.39.1781678939582;
        Tue, 16 Jun 2026 23:48:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:2583:b0:3b4:e4f0:94e1 with SMTP id adf61e73a8af0-3b8bf0bb23amr2810035637.39.1781678939115;
        Tue, 16 Jun 2026 23:48:59 -0700 (PDT)
Received: from [10.133.33.65] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651af080sm13543921a12.29.2026.06.16.23.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 23:48:58 -0700 (PDT)
Message-ID: <177fd404-dc48-480d-96fe-8a79394ba8e7@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 14:48:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: expand UserPD ID mask to support
 up to 8 PDs
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260604031551.4178754-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260604031551.4178754-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX4r5OMD7tIPNX
 i+rkl5sUGUQEJGkzlvLcOsjYbCcZaogsYHxwxQ8IiKRmE1FkGkTfZZeqfiNKowuZzvTX3jmkwlV
 nl7ldC3pHuSl2t1LqH2hUmaPIfz5LLpxq4vJ1jI4nm/j0hVphBr9K7e4uarTk7LShwNOFKgq7OO
 eTaa72yvtvHc1gzAVtgrV50Gx7Pqf93VbZPqtEBxZRH61hMT1qk+qWsxYFduhCpUoX7GGdSok0w
 fuu2Vbmbei7nagSbE7/OjDiU8ZccfmQ406TYSakeXnu+3loi8Nd6vqmtMDv/4+EKpUbQEVm9Zdo
 cHsvWozZRy2Or4g5TdP5/4npBy5bD/RjmrCIa/ei/YQ9bNshPdu1KNTsTOaDBMLKKCUBiAK1xzA
 WJmM5k1YsfOUAcXNC/yHUZGubAWzAd8qyET3ZI1/PPiP3Prav/jWDwHUtuPdWjmxunkrnFLmhNM
 R+tOPdCpBkeqF+IrF7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX2Nb903byCqD4
 B1oTVBNcB32En+udOr0VT+j4waXDoNUfIy78NgHjjUPlwv6g+l8HOxB8GCvCihX1zL6o+r0iSkA
 RZi/aoICaHq8zSpdI89wwgXTJSw1bg8=
X-Proofpoint-ORIG-GUID: R78EGF7wkw1rl1fwnNnVA_ZuXa6OqTot
X-Proofpoint-GUID: R78EGF7wkw1rl1fwnNnVA_ZuXa6OqTot
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a32435c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=qcwypVmIGuKwP8SevUEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37846-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EBFD696F14



On 6/4/2026 11:15 AM, Aaradhana Sahu wrote:
> Currently ATH12K_USERPD_ID_MASK uses GENMASK(9, 8), which defines a
> 2-bit field and limits supported UserPD IDs to values 0-3.
> 
> Future IPQ5332 multi-PD platform variants support more than three
> UserPDs. Expand ATH12K_USERPD_ID_MASK to GENMASK(10, 8), increasing
> the field width to 3 bits and allowing UserPD IDs from 0-7.
> 
> ATH12K_USERPD_ID_MASK is currently used only while constructing the
> ath12k AHB PAS ID, so this change does not affect existing platforms.
> 
> Also remove the unused ATH12K_MAX_UPDS definition.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

