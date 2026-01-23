Return-Path: <linux-wireless+bounces-31133-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL9oFFjSc2kCywAAu9opvQ
	(envelope-from <linux-wireless+bounces-31133-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:56:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5347A5E1
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8505E3020A57
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37AB2652A4;
	Fri, 23 Jan 2026 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4zFzv1E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="My5ZVu3B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DA299920
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198152; cv=none; b=pnM1qe6iJTe7+tMiuxGeI6dm0p+cJ/KzFE+sb7CfLrdRwJW4lTWhBXChHNy5B6PpMUDNhKimkjBlYyK73A6GRTxvgFhxk2Ow8vUyU3ZwMV7BRvWTmwgN5YkVkfFBHOsRxt2/9vmphRZBzYx86NFohEGkPdUqHFXXBTMOP6q/Owc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198152; c=relaxed/simple;
	bh=k8milH7o+EsblEd8kAfN18/CQ9uzH5f+aAYcD6admx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/xW+hdnM7/nFgM8OjgqHWxnX0aojcUb63gyy9/jIx0p1ntKuTAXrNf4jy2aZ9nesBQIzX+JaKYTbSz4S9ENFbD+LbebuDDqsay4Cq60umjbC1mV0lb/TgFqA85b0KyOrgVGhNYhcig65OHzYeGZ38tYVANLWMOCoJbVD0iyBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4zFzv1E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=My5ZVu3B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NCGtmn3677903
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 19:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2FB1CTlWwWv4r33kIWwxiKEvgvPWkiQIev8OPuzLP0A=; b=T4zFzv1EfTEF8+ME
	Rcouy8wSERgivrbrQeFWWZUDPEHQIJAH13l6So6qedoxA0iPvAlT4R3OoZcb347n
	gXreYLK3EI+aWoh6mgFpPxIGr39CU10CShBFr2NcoUBoXczjebDp7wz3bRBF6Fm6
	rLiobE2qm/WgQwoG7NfQcIHxwpE92yD8FdJ0u26M6ZOC7SsbGKB2xEinZHuye2yl
	STEvt3OdC1cWH13VQfBLn2qeI6RtDTz8B5wEaF5AKjBD/ffas6BthoKc7iWIYecA
	u8wQDsFECPH+I4fZAOAjR5/jfTe3NO9vXUKs0RDA5kCYm+pf/t1QqD76EF/QE+Po
	rBHcGw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buqyp4x8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 19:55:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12339eea50bso13354467c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 11:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769198149; x=1769802949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FB1CTlWwWv4r33kIWwxiKEvgvPWkiQIev8OPuzLP0A=;
        b=My5ZVu3BG11frNsEOSOaceuwlaMLK7p2hdkIlUNI0BEEUK5csgbWOQEk7LV/h0fzt8
         7lyT+Gb8sm62GCyFJ7i/4TREUToeysScS3RTsn+ebM9pfZk1oETg6pZL4feL/3gPBF2Y
         Mw9ociVVEErl+4sJy5JL3g+NynhhPbRhpM+Hak0W1DIU8CdW7gmwIj/IERpjM8NRaOQT
         2p1PSUS/Xek6Iwg8+MTen/uMBSzdFRPb/BDMDjgUoEija2ofml5OO1I+n+oFRnt4YhGM
         /Hgk/2ZtjE0yUjJRLO7Et7Ne6Pf58sKz2XaEFHb923XexFC5apOLMxWulBigNFZVViO0
         CiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769198149; x=1769802949;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FB1CTlWwWv4r33kIWwxiKEvgvPWkiQIev8OPuzLP0A=;
        b=e6mB8cHwl349Lkrmk4rnkrFZvr8+cPFrULHUT3RJbh2sQKEDinPTkP9zGRiVADTIMT
         RJFbNaoZtnCRhgGVNqe35+JRkF7STwo2RXJgmfObk755dMSb+ngGxpE74uqSL8/nJe5o
         7rvVKkcCV92I4RKcpfFBCLf9rzUhr31p6k+gsIDv+GIs+ahQn310UgewBhT0HSgx7VYG
         BYuh8/Bdhvol4MCWGjPl+kNteJUow+IDQEQf/cn4pezYJol15K2MScYIYSlOeCJiXXnH
         3dQZNAXLGJeCH4yAx7/CIC4H2jdZryERC4+2rYIZScz6to9N0JKwp7X6LsIx3sl3IiO1
         ZMkA==
X-Forwarded-Encrypted: i=1; AJvYcCUIZG9Sw7fIiQQ1mEa/5tHFSnz/ryYT+aa27jh/F2umLaPv2h/rEGhvMRdGXH+FbhfaqXTgSYiBP32uTnN1nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmm3JuVbQO4GYLpTKIueVDYHr7swDopJu0nF6ivOTXWGjZxGi
	tSPf6/zE8PqzT7W9bnZ3v4smzi1Vo8yhMrPWlYM+Pn9vzG7ofdbOTvGRh9RShou1MTvEGXbAPTE
	eWXeAT9bdbR5HtxJSUAGpolViFWdpsNqZQMbq6dO3wmK9dp+TFQsH2NtetNtlLFGzD8LHjGtrDC
	V+nA==
X-Gm-Gg: AZuq6aLzg/x5qHCFZj3MYTcvIc5LZ6I2YzrHGh6BIAKS01HLBLkWq2M5ly+D00eWXb+
	q7MchljJaq/FHzqLAq1oy59+y3VjtsBBVozdhmj7mxzjw9FiNqQjMSAmuvTxISmO+7BeHk7DLw6
	AOGX7HAgCJ3LyDuo7V878DM8JoofJcV6yiIWiIYpoRl+fEQYPGGAKLR0E/mf0O/UIm+HfLrYDuC
	MoGtiLFpOl6dNBTxITQugbd4MeT45FJhj7s17lN/DRevZYgVszzbFD/zH1RtAjHpsWC/KqDLcEn
	FlPZwcDKs8ugkuGnWw0NszpOSYK21YzKfzaU/TxAwmp7xN6/Roe7pBWi53L6bu4Iva17Kq0rdZ1
	ysT3fGPsWaSOF4pR5+TbGXRokqSZzm5YJCbKtMgboh4tB4wMYPEVxE7uRilm4MDoSGE+XLtkoPb
	s4
X-Received: by 2002:a05:7022:120:b0:119:e569:f275 with SMTP id a92af1059eb24-1247dc01820mr2413640c88.30.1769198148602;
        Fri, 23 Jan 2026 11:55:48 -0800 (PST)
X-Received: by 2002:a05:7022:120:b0:119:e569:f275 with SMTP id a92af1059eb24-1247dc01820mr2413613c88.30.1769198147905;
        Fri, 23 Jan 2026 11:55:47 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d998102sm6218556c88.10.2026.01.23.11.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:55:47 -0800 (PST)
Message-ID: <2f0f8f27-c438-48bf-af9b-dd7c0d0f0073@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 11:55:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 wireless-next 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20251216162421.40066-5-johannes@sipsolutions.net>
 <20251216172421.5f35a099e950.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251216172421.5f35a099e950.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=6973d245 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0fyt21o6uKxhJ3Yo_c4A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: ll5z9FUB4VIp-XYJzkwQQl81QhonnqiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1MyBTYWx0ZWRfX2D1JvmOgnrGW
 gp1GgEDHaF2qxIBorV+/5srnWQpoPGHAiXhuWqaVRU6npthKqLPU5i4oZcgFcryhh2x4fUXkm/i
 AOtkvXmDG0yKrjLEVAJ4W6hLPReb3bthc6QlQa+sqZYwhmprAOYf2srNYRPqNHCy4kBt6pp5ho9
 uUmqBxugBexzAQ/8DxI2fGZwxVQ3JVVg8jKcfCfFPb2IfVeW/PazRFssdFYF7WsbXEMX7Pewvg9
 2lKvD+CAA+KKok4udhR3NBpwClAyaMzEijlFuInsXP4k8EP2/MUY+hDSQOUFlcyR25sOzoX7MA6
 JiOIHTKQUlDTEvK3ZDEmHTgnWXI5ICsSTSFckU6PyYplLgsdlTEwQGkNiVjG4RlPBhVg/ULb6AL
 TBms0PvHLPhTCspWTiKEaNbyhnjcPPFhgMD5EGYXAMVNoFuJJtbIb1FQ8RsHxdbHY5MRWs6ruUe
 vkCFAfBS+nZXNO0EhOg==
X-Proofpoint-GUID: ll5z9FUB4VIp-XYJzkwQQl81QhonnqiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31133-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC5347A5E1
X-Rspamd-Action: no action

On 12/16/2025 8:23 AM, Johannes Berg wrote:
> @@ -1486,6 +1522,8 @@ struct cfg80211_s1g_short_beacon {
>   * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
>   * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
>   * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
> + * @uhr_capa: UHR capabilities (or %NULL if UHR isn't enabled)
> + * @uhr_capa: UHR operation (or %NULL if UHR isn't enabled)

s/capa/oper/

Warning: include/net/cfg80211.h:1576 struct member 'uhr_oper' not described in
'cfg80211_ap_settings'

>   * @ht_required: stations must support HT
>   * @vht_required: stations must support VHT
>   * @twt_responder: Enable Target Wait Time

