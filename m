Return-Path: <linux-wireless+bounces-37969-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dn2pOIYJOWoNlwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37969-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 12:08:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A376AE896
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 12:08:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GV6aXRnr;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EvQxCATm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37969-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37969-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7776B3046D7B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8613546E2;
	Mon, 22 Jun 2026 10:04:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF13A3E60
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 10:03:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122641; cv=none; b=kJJ6op6AiGIIRsL2Y7lKge+Ec4asemNrySR4vclONV0I7lMbzdTPsGhpvEDX/BAEyrHST9APFDODBKrTqsog4fNjzLl8RcGcX7D1qPmZEkWVmNP2Yw3SVrlO4+1LesG5ykrmUSAHz2sBeFu4m/TitwWBqZUDXAc6xPqwanFO9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122641; c=relaxed/simple;
	bh=5Bq/TDDUtmW0FANcbSPEkZUmwqQXlskg6spLGv/mF8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUNZM224w3pGQWuZ0yfUmGLyORGdFRFo3vQMaOQkgWypUDIDi2tnq+L62/UzRJl/N77JH3iU+lfeHX81R8bmoV+k6drqYm5oIK0hq4sWlHO7h0W3R760VeTy0y/iWHEH30mnvZ8EHxFsJk6LP09mcmzwRHE5HoE+ig46jxaSSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GV6aXRnr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EvQxCATm; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5BTIV255503
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 10:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k4eg/8KeKJ2ZFZ9C+wf3K26eTZdYYjACoux+rrZXgDY=; b=GV6aXRnrGTwsvNjN
	yFk9MSz2x1E8ZtnQkyClSaJH4xuElgi2XMp4gtiFhjKITAi0C1NvEoPW9ecosC/l
	PkGYccDWGB8ZWu8kfFqpyR7E0auv8O69/iDTlpG9ojs4ZaoaJKcYvSdHrKrrdtyv
	99KR6vumr7VjV02sYQZn7b6a7aKAeFckN2iIoeQ6Z9aDtZ+BGXMWpCDH0dWzKfGA
	Ggr5JVBGrI0xvA+1OFXSDuGBaENa8OcaSfCCPxGCZOaVUb3GhVVJqdErHXP0RGzI
	fImPCdHlcvrYnqXvSK7j1DDK+KJhpLEosxiy91ark53m3FM81d3Q5oorLtMxGxZm
	l0AwqA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewhv5p3rb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 10:03:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso2929966b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782122638; x=1782727438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4eg/8KeKJ2ZFZ9C+wf3K26eTZdYYjACoux+rrZXgDY=;
        b=EvQxCATmesmxInucVY60T7xG8bHEQCXE3/yMMlgeA7yRG52bA21N7fMVJqOhuAxcqv
         GBfpMi2sEipsBHIOkkfD1pVMYcm7696VzrjL8BcQMaFegyqMyjC7RgCGolzJ2/ByWAQK
         gffA8fG41tZzAbHu9FWnAi8K6uDm8PY1+MthMTkU92bBqcUCMHQUwMsga3phVjlqHA4m
         CtsXVribw81y6UlCXQ7MgpN1RCLfqU8rzkutjbuYNUeuMbelUxp47VoV2H6nP+WpBJnr
         xNVzosoe+uqN0zjvvtI92FqFQYhXJvVjmItcRgAuNrZCOeItR67UJJ7yBGbwm5ou2L8u
         gFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122638; x=1782727438;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4eg/8KeKJ2ZFZ9C+wf3K26eTZdYYjACoux+rrZXgDY=;
        b=iWykmMYJR1TTBceNLEEKTVvz2da4on1w5vBND0n+7hERPwvAQ4ZDvsA7M4LxbyMrgN
         BkjrklMTe66/Uua2kl4DT48NO/qw7qib2X2iq8tsRxl/yovjY32Jfqzb5EYtHHg8OQ49
         k0t3z2F/0Duj8gTc56//rBsOidSlB3mvlBZsOMsPqQ1JgXC7HHH7BAkA3C9zspta8GM9
         ApXsVGDv7oTy/l3V1eAFZb8EOImd1ftoTEu1FIabKSOObGSPPuhqflG9MSHtiAhnq8SP
         D/EwHPkMPjFj/WaDSj+tzW6/vyw/0W/+O1EWKflqOqZ6ZXGbEBx7WwssPWyn5bi49Uc0
         AgrQ==
X-Gm-Message-State: AOJu0YzsoAj7XRLxqCH4iS1EJBiEFpHblu+ltg4RLGBXNvU7rd6CTCE8
	2uNDErC8zmlZuywWQevIjlSjyHZj8o1qDjj/n/uXGk5W8vAhMdCGEl7GmgnKuesDpv1KzZuocEh
	gPu0HE8iXaq42bdVEyApl5BW11Hu79Jr1H57UjH3UNf5ahDtlL8Qfbi/8RvXpcQORx/jGCw==
X-Gm-Gg: AfdE7cndl02Cdu/jp6Ow0aVXn4IPjP7c3Kb2DGbHfmF2DXc6VvareNFU5XIK4e15U0w
	jrgrUSNKhPt2/AzYP1HyY6dCEk2FVTSp76uEe6+6l1kJLHDgIdQ2/27bEQWRT0H4BF79qSnMcCZ
	vsrCNlaQhR8fNmbVvvqdSE0eGDzRQQdVqgu0SwCiINREopggr1kVufssXzyuvaQWYKozTQTeDop
	23C+h5zoN92mNPnkm/WNcTOzLCZZD6UokvFSbVM3CT/oqNC30kQthWH/PwYFrpDGsHqqPaecETp
	VPKxG4DyYUhMKr8iujDIh2ijztRSj6uVIJW/3lAtwkOOriUZe4yTZeXZrQ+dFn7cTliWdpTZfyD
	p6Udw2v6unGM6/AENX9UKQ1XcPAKHCamQyKBvMQ7bbOXYZeMWxK+gXEYEcBRwmoTs8JTlJiOnnr
	neepBfZyfQ
X-Received: by 2002:a05:6a00:6c81:b0:845:371e:43f6 with SMTP id d2e1a72fcca58-8455077c6bdmr14400578b3a.8.1782122637702;
        Mon, 22 Jun 2026 03:03:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c81:b0:845:371e:43f6 with SMTP id d2e1a72fcca58-8455077c6bdmr14400544b3a.8.1782122637126;
        Mon, 22 Jun 2026 03:03:57 -0700 (PDT)
Received: from [10.133.33.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7480csm7026590b3a.33.2026.06.22.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 03:03:56 -0700 (PDT)
Message-ID: <9cb74a72-baec-41fc-81da-e3948175870b@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 18:03:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5OCBTYWx0ZWRfX7kTyvAUB3N0r
 F/wO4zoOIlgxsJ9lI1waJyAZYYcQF+XkI656d5uByhyvDEZlc+PO+W3hqHESL1CL5zdU6F0F0/o
 fhQqkpX6DggP2D7iXD5cIX8EeBbg6JQrHNMQz+7KOMef9dWLjqyDL/Y77QUbo/78KxgL/cVpkkx
 CHFp/BTbEREXBRx9Q2yEIQdZquXy1rdvCxF4Acs6pFkSpvBAupyc0b8K9w6N4BZbF6vZLMclcJU
 JY8p6VlhwOGS/PZ2qwlQs2lJiRdtCm5h6N6Z7gkhFuN1PhCw8yiAJZq7ycWz1tFS8zHFklpVn5S
 1TOk3mTtOs7KYQVmWBc1HChmotMoVnF9NEejoNJ06hsmOpUFBgQiUedUyoYAAI0oMALjoo3+Gjl
 3ot2hr6m18ZAAXYVwR20MkJ/06U3gioKe6vfgzUKP7k0a/1d28W4NQDADykE+OEox1kensZPBsu
 9bvyxHdAf7h60CDc60Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5OCBTYWx0ZWRfX5yBi5JNV1x9Y
 tW43sYnhUAOdkD7eNlzPjkQapgu5C8XMGH0SD8Aef4VKU/zItFgDTVbZ17RvDo1mCSjfWEjZX+X
 Nv9Rf01SeRhgJURqt+TtqKo0PYDih2Q=
X-Proofpoint-ORIG-GUID: mX42PQh5aUyvPsBWlWePtW3HBIzrJ06l
X-Proofpoint-GUID: mX42PQh5aUyvPsBWlWePtW3HBIzrJ06l
X-Authority-Analysis: v=2.4 cv=UrZT8ewB c=1 sm=1 tr=0 ts=6a39088e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vXOABIWjEGlRoqXTTScA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220098
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37969-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38A376AE896



On 6/19/2026 2:58 PM, Aaradhana Sahu wrote:
> On AHB platforms, firmware operates in two modes: fixed-memory mode where
> firmware uses hardcoded addresses for memory regions such as BDF and does
> not request HOST_DDR memory from the host, and dynamic-memory mode where
> firmware expects the host to provide memory addresses including HOST_DDR
> after the Q6 read-only region and relies on host allocation for all memory
> types.
> 
> Introduce QMI capability negotiation to support both modes. Add a new QMI
> PHY capability flag dynamic_ddr_support which is advertised by firmware to
> indicate it supports dynamic memory mode. When the host detects this
> capability, set the dynamic_mem_support flag in the host capability message
> to signal the host is ready to provide dynamic memory allocation. This
> triggers firmware to send the HOST_DDR memory request and use the
> host-provided address.
> 
> For backward compatibility, if firmware doesn't advertise
> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
> where firmware uses predefined addresses.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

