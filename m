Return-Path: <linux-wireless+bounces-35037-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF3HOkHu5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35037-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:13:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5369D428B52
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96535304854E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A2937F74B;
	Mon, 20 Apr 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BppVZ9fd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tk3XHwG6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88DA38BF6C
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676383; cv=none; b=FanId7nRWbs6dX1ZQ1lbZdTYBsmNfJUTvnJlKagAOS0k7u9elDF7cPDuwBJu4QorATYF5VQol8WJS+51mZGCIqXEdiyPLETtR4FS2nf5vZCUJI04LfJq/EImPhPof9X50eG+nmP312UoyZyeZqow3xlVd8duji4l8ee7y0D7YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676383; c=relaxed/simple;
	bh=ifT/j17g/58kssrdsozqO7BS21ShtuUCkTb/L1fOdGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZATyMTB3ktZkTCqRpC1JYGWLYOnzVamzl/qzCzMLE85B6L16JxLJ8x3l+l1feioaB8RRMGcdx97jsPx1LAU3pwQ5syuJiyKAie2pot+l8A80g88MeAShE+KkWiFPS58WOMsprmVV7+6bJ7Ar7xK8/5Ae1ZcQOIXwl4q7HCHlvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BppVZ9fd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tk3XHwG6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97rjn1600322
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5pxCTlDC+coywvJaWj8zWDAR9+2cEnLUT5lWWXOoA04=; b=BppVZ9fdKeedmA9Z
	7QF3Cg4jlkxMJjLHC3EO3oZKGFBkofZwb+/kjW06L5hQpodTjP5I6JRm6Ye6d2OX
	Q1o10psYteE/b0gRCzcJ3d01OBgjoXk2NyBCTJ7bgKiFCHp8fNroldGx1bk6wULr
	s93RziRe9iCBvAljvvl/k0n5gHOz+EXX/ECQjOZ2fEnif/6rbEC0oV7wAgtVOaWh
	JlUqqNgFX/wWWWlxhInt7umBy+Ce5wGplcG3AHWksGqnVi0xhhZkKQjTilZRuJFF
	NerUhgZw86mix/vr5VgVTMRh6ek9jNaODxQM57QV/73jhSWSegdEuie+dhPQRySg
	1/EUmA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh8980nk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:13:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f803658d5so3355008b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676380; x=1777281180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pxCTlDC+coywvJaWj8zWDAR9+2cEnLUT5lWWXOoA04=;
        b=Tk3XHwG6h8AdHEo4baJ52JG/t2XjZiJxksC+E8zi9UaXj7S5V1cG1VgTIR0KLFMf4O
         qPDTFWN+j7sMfLJ17CmX09ClGlCK0yvi8Fk9hYGTWOW73bmgW+3f6xJyh8EC9vFdl5pY
         0yHqYqRXh/rEE7eBa37OGwtSa27r47d3+wI9jSAXdzz+In4SCbCnDwr/LDmOFJ3GmUkV
         WYk3t0pbwc2qxLzmXCcshpkYcUjOY/t+9BjGjl0tVWJwQR5E9yhrUygF6VTuSn64VfIC
         1ifohGRaKWdpyTpSjcX1m0G1ZDqgG/6Iz8XmQoyNvQJMYbzECa5FmwthS8VZXmTV+mEH
         2StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676380; x=1777281180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pxCTlDC+coywvJaWj8zWDAR9+2cEnLUT5lWWXOoA04=;
        b=Stv5eODDgdbpSTF+OOoDUMWkKupKA5ZgntgkNVIBdnUs2QEXh6+t7VOWXC/ZG7ovFS
         MKt58NJu1xxAmWocbOU9y9xHuZVE4JQ9NjIdhrPDLytmaagqktPK3gwEPfX/Y82B/0VO
         vNufKVyhwiKhmC6TwCMPhlXGn5o1axfAm2XpHec7x13lFavEMjceh7hrVrSmC5RzTVnY
         8Q93JMwDUsHeR7PKZ7zdyeG1s0yiWvn9+EYkeXIrU/WIdzxSpWBTaur/4gyAyq2czsU8
         rBJkJfrf3Fab+i/Keytdeli5hzSVRf2IF+uZyhUEDba9fFi0OrJWZyVG+GkUljhH/vH8
         36Cg==
X-Gm-Message-State: AOJu0YwrE4Zv7b7RixpMJG8UpimoiTzHgwKtvbuGIyspxwlNGvf+zKq+
	F70tQ3mlAa5noZNF+p/V7xKqhsZ82lA+NsK2VN9BKxUCkpsZtW4teQ1CWzDFWAdbZQt9m5r8t3e
	Uih+P3c7dv9THtl4Zt4638FZteyDTQ8x5LX5tXzq802x6vmHhPIMFNQjQwTDQXNWgp8MJ
X-Gm-Gg: AeBDietyhJ40PEvpizOij/HYA6x/ZOy4GxT6CydluozU+yIDjUWcMFxcKTJrZDwPu09
	0H8ydNq3Z2nQZdBHr5vEADvU3x++yQK48eEXMYHN01GuE8UYigvkPj8SlCodZvoduRl7qJFB6tD
	9fz8BpZIVlPk2MPOR/bFcpLhBsG7jjfGVr7OJluJRtwrRnGmCCnlUKVwcHdgPX9+KM4S2Ld1JqY
	rvPDajqBzp/KOLY19hCbyqq+IL3MeiBwZS+rcMbiTC/9GQ+tGzQSCj/+k6w1pjBpKNPcoc2T1Gz
	MZZECS8ZmIessNoZPJtNWt8XNc4HdhKci8rURpwfKYovtk8FpIoQRJ1kubG/IIJXLyM41RquTtR
	lE6rDI6vumaaAetK3pyT6LerC/kfRQZ5tJKoGm+3BhuSA0qfJCc9UFzyss4qCU8o=
X-Received: by 2002:a05:6a00:2e06:b0:82f:4f63:31e1 with SMTP id d2e1a72fcca58-82f8c7df522mr13906953b3a.8.1776676379544;
        Mon, 20 Apr 2026 02:12:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e06:b0:82f:4f63:31e1 with SMTP id d2e1a72fcca58-82f8c7df522mr13906923b3a.8.1776676379024;
        Mon, 20 Apr 2026 02:12:59 -0700 (PDT)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm12284799b3a.38.2026.04.20.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:12:58 -0700 (PDT)
Message-ID: <a8a93309-776c-452a-9f96-625c6abb8a28@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 14:42:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 11/14] wifi: cfg80211: add PD-specific
 preamble and bandwidth capabilities
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
 <20260320175938.2547288-12-peddolla.reddy@oss.qualcomm.com>
 <aaab6a224b82a8fd1b255f1546ea142d68653b50.camel@sipsolutions.net>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <aaab6a224b82a8fd1b255f1546ea142d68653b50.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXzNwwPXieFpJT
 CCHEttKFCDqhHv/81F20fNQPPCkHBAJNiq+0JXgGNA7SwzGw7CBmGazYbs5Va7VTB6OVJxZuYXj
 yRuUzdhipAGaLxUf2Zh77pf3LmMpCSWc711WgKbAo3uPChrBTlw3NEJPNCO2TORn97pazAqVOF7
 /6vFcSXjhcLsIs1kIIVNXUbiCIFe9+C7du62Vjtp9E18vcHZhrCD1PSoDora+tttfXqM6A0oqMI
 zMVZvnok8icn0VJ532N0BniKvXdCOgEblTRkMLln7trzc+peT9BQcELX8nObPJFRm4BWuTOUy5I
 gNoyXfmzusyV9d4gOO3dRXo39asfQh7PQJJWIpbQJJ1YHm9imQzpzb32YQ6LW1RNks8i7EvfQot
 nFJlmp8t8+LFJbVcKbmfrFDToCrHZ9/pmlGg1MTGBayQzqpj0U2FkYaVWSKgx2e4Wbo8h19NMxV
 s2uzVs3vxaBdAqPalFg==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e5ee1c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=AwhJ_Kf_DgFWvNLGIToA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: dFFTsw84IsLnaLf-a8Ope8jVihLTcW8n
X-Proofpoint-GUID: dFFTsw84IsLnaLf-a8Ope8jVihLTcW8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35037-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5369D428B52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 14-Apr-26 2:05 PM, Johannes Berg wrote:
> On Fri, 2026-03-20 at 23:29 +0530, Peddolla Harshavardhan Reddy wrote:
>
>
>> +++ b/net/wireless/nl80211.c
>> @@ -2482,6 +2482,20 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
>>  				cap->pd_max_peer_rsta_role))
>>  			return -ENOBUFS;
>>  	}
>> +
>> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES,
>> +			cap->ftm.pd_edca_preambles))
>> +		return -ENOBUFS;
>> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES,
>> +			cap->ftm.pd_ntb_preambles))
>> +		return -ENOBUFS;
>> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
>> +			cap->ftm.pd_edca_bandwidths))
>> +		return -ENOBUFS;
>> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
>> +			cap->ftm.pd_ntb_bandwidths))
>> +		return -ENOBUFS;
> That probably should be contingent on pd_support or so, otherwise you
> end up with a bunch of zero values in userspace, which is odd?
>
>> +	if (out->ftm.pd_request &&
>> +	    !(rdev->wiphy.pmsr_capa->ftm.pd_edca_bandwidths & BIT(out->chandef.width)) &&
>> +	    !(rdev->wiphy.pmsr_capa->ftm.pd_ntb_bandwidths & BIT(out->chandef.width))) {
>> +		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth for pd request");
>> +		return -EINVAL;
>> +	}
> This seems odd to me, why are you adding *two* fields when they're never
> treated differently? Shouldn't you check if it's an NTB or EDCA request?
>
>> +	if (out->ftm.pd_request &&
>> +	    !(capa->ftm.pd_ntb_preambles & BIT(preamble)) &&
>> +	    !(capa->ftm.pd_edca_preambles & BIT(preamble))) {
>> +		NL_SET_ERR_MSG_ATTR(info->extack,
>> +				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
>> +				    "FTM: invalid preamble for PD request");
>> +		return -EINVAL;
>> +	}
>>
> Same here.
>
> johannes

[Harsha]:- Fixed in latest patch set. Thanks.


