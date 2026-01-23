Return-Path: <linux-wireless+bounces-31136-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDomFjbWc2kOzAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31136-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:12:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B67A83D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55DA93013D51
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E22C28C2DD;
	Fri, 23 Jan 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYMnhlet";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ri0mCcNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79512110E
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199155; cv=none; b=lbwSAdkL4LbUl8LPEKKyOYqpYbUF/YNI6AfK7NmeHjr6kp3u2JLls1HG5yvJzkA0idFE9IqLtd2YPf9ITNYGej+/ThE3s7JKQfP3iNxLxJ562D/ebSv6UXwqpbuFYyAZlGot6J21epQM4zKXVr7xOxF/QecNgQuIdveHvU+ZLyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199155; c=relaxed/simple;
	bh=BOMbioXlTID1Lyg962qDRuSwAYV5Ot65vf+l+p3yX8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neaUga++mVb8f7oEbg1ThnHBMrLuxgywL8KoqxkYDxLYHrEbAiwnn2WEFlh4+xQ8EnGbSmSk5vi+F2Rt05ePzhVRJXembuNlDURbQIfehKKmJTLnVFuETBwPDaIljLnOOVBgYnRxHeO6ndsDRtA0w1Ds24uIVAOvGMCok9pkwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYMnhlet; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ri0mCcNR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NHD4l2722364
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hHlVLGWpB7O4VuCpAwpukkQwPq8TK+xRXk5qj7ONT/M=; b=AYMnhletRazrb3wc
	cbYtpp8TgjifQXSrQwRxh1Tu9Z67pk/QffuTUeAbQ5dRiIYTmOAC0rVv43WcM1b3
	KPEdxb8cO0JiX1qZ1S2Xim/AiwyEloeTMe2aS+79kt0xz6AKdhk7vGxZ9PuAtNsN
	eZOL/ETlO8nCHAcHKHBtTOXhlu8n2AHBfR6vkTzRG7mVWJ8VLBATp5j+L0HD0P9K
	Q9tgzr+86aJMeIvE+LOnJPSSRXn+Sw119//jvEVfEGH4xe/C2+UULhQzKZVWmW+K
	si0y89o6X+QG6J/U9YPmXoC03Wt1HwWRejeELTUHXrFOtZIXki8Xm5T16DXfzX4/
	uGsw+Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv069kedb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:12:32 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1247bb4db53so2597588c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769199151; x=1769803951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHlVLGWpB7O4VuCpAwpukkQwPq8TK+xRXk5qj7ONT/M=;
        b=Ri0mCcNR/PMDNR/Plfip0uFt2WpxNX4FkoSz93uFSQfOob1TIiWydFXL+I1IQT89qu
         J2Hs+gPk/+JlIHKxPlXUsPhv5IcjhtcT2W8SdtN1Q6vcTfHHx5uOC6ycwpYPZ1Nou+sg
         +WDRfKNO4LxwHG2Fe570IvuSmxz1SPLRUclty6OHcK2iYa1Y4+qW9CGYnMyyJOyRoHzh
         jY9i6KGYd/V9sx1dBlfe0a+m3g2oHJqR3oI5aKVzAF7luvNfl3yPbHRajcukADlcyf08
         3fR7cPLRQHSvU6BN4wc0F4+rh+tJyhNuQXxtET3zgnIOdD3du9X5hhtZB1EiR+XTCkUS
         rJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769199151; x=1769803951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHlVLGWpB7O4VuCpAwpukkQwPq8TK+xRXk5qj7ONT/M=;
        b=JU7zYRBrnDYu5JODNBzESqERXSCpxn3zRq/EoLqEIrOwRh9WfjzkpzSVIK0CO5wsre
         Mq2yG9AIKv4fBLVMDNb65S9l1+nSWI/bSknqHCAHynFkUoLZtXqsfNFbKfCnvWvmS0nn
         nHSSxwCxO4dwgSnncqstloCYT/hmWn1vGJ+QG6HnHpqhfgK7fjsVR5kw1r4mTrBWTybh
         IR/Ci//zMoXPe2uaTxKjSpMLbw/IJP67GGbTpG3s/99aBeAAdn9R+a3GOBrdBQzCxpCJ
         WMIf2Ah/4hFsi5BcaaCWy4vaPxNmY70KJE3Fsw1lKQYfaV3w0wgjn7rmutrDyPFipvzp
         cbqw==
X-Forwarded-Encrypted: i=1; AJvYcCXogre1LhLVmz0NqoY2VsuLSM3kjWspudMRvZ+Ggj8u79AJ0e0MwrTbzSfZYpBsPPinVbG2oM0V4ntto6XphQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pCNd1XnvZSPYC1H5W49WLHv6MG1gdpdSu/R4CcDVP8HqVM0c
	wa1ImOTPYVc+kr9e/+P3QGD7Oicec7Yosq08mE9MIWT6wcP7Sp5x8hcftGWD/jkDsiHEeKaEU+D
	tWrsWqWkWYuS4dQQNkMPyQFwPWKBsZGKh1fUnOvjWS/5nn+cNxV1Ri+LTH6epeoKlDLewGg==
X-Gm-Gg: AZuq6aLNFjJXjvqfchoQIzVZ3hxfppkPBXlQP0LmFgRhxjewOsdEEm2GR85Qq4AUK5S
	Bq/gluZunyQYcs3X65DqRtJcLk+yhE7MuOot2/XvZGuRDIrQV0Ujc4rMOOa5MD5Orsw5GpFye9O
	ilXktaT8kPfZLOUEZKRF1MJayhcHtc/1YaEnaNyO+G44di1fOenDED3Z0OIic32LJp60Z2mCOfT
	EyFzUysRva/6luXmhsCQWO+h9qxubYukW1gw//eHczW0wyBslH/ZE0n3MpdNnalgTO5tZ5CLOu5
	nObOiUWM4htHwlv9O5mL+5klky0INxcA5CJ30ZGPBhB2baUYvMUrGXO6sGCAdpdzvudLE72PWBU
	9uKxR54vFqUhL8MibpkcvOZhdBc2AIPiXCTmatPh4fV9WYMu0UkO2CdkV5fN9Q5dfLm+8XdF5sh
	tF
X-Received: by 2002:a05:7022:6722:b0:11a:23fb:16e2 with SMTP id a92af1059eb24-1247dbae9bamr2068770c88.9.1769199151088;
        Fri, 23 Jan 2026 12:12:31 -0800 (PST)
X-Received: by 2002:a05:7022:6722:b0:11a:23fb:16e2 with SMTP id a92af1059eb24-1247dbae9bamr2068748c88.9.1769199150345;
        Fri, 23 Jan 2026 12:12:30 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm5833880c88.2.2026.01.23.12.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:12:30 -0800 (PST)
Message-ID: <2e57f903-1875-431e-b7b7-e4423c9f7b97@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 12:12:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 wireless-next 3/3] wifi: mac80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20251216162421.40066-5-johannes@sipsolutions.net>
 <20251216172421.6b2e221c1cd6.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251216172421.6b2e221c1cd6.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eLUeTXp1 c=1 sm=1 tr=0 ts=6973d630 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=lQ4a5sekh8qImro8-5cA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: lVvLucAb29LYx1TZLHnamrGumiSjBsV1
X-Proofpoint-ORIG-GUID: lVvLucAb29LYx1TZLHnamrGumiSjBsV1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1NSBTYWx0ZWRfX59htAFGNxLqo
 SuXOeM/FJaP/RNsCcie5LYDGtqyGvOnsg8RaHRj5en/LlfONdSwJ9yWYJ2Zsw5pjf5raQsNNoKv
 uTM+4jYYC6j5MyBxoUlJTzDdIdtoucl3FDmicL48iJzMArYGLvjNBQAR5KwhDqp04QvqRWWxcVO
 +mQfP+xZ7UhjvkDhK055tEyigKW/ZRi7KpaXzwFDuYAw23MU/O2KZVS5PL+HdA5FyIkwSt2CqCJ
 AKUMA0VhprQ6uF1ncdajUOtlVE8z/Jy5bVajzYVA3iDON28so+NEBXiK6PLsQgGEa+ObW/Bauch
 fYcF1P+BAP05gYNFI9434X1FcsX6o/wd8C2kcPp6sp87y8FDKLSIOG8vtTd0WqyOfci6FgWaQie
 ZxmgXVS9MAvfzCs79BrK77e9FPZLqLmuhaPDbQyAxYaDVkzBWO86o5R96W9/e2QTipLJytqGAeP
 OPstBflbxR9fbWFpkqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230155
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-31136-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE4B67A83D
X-Rspamd-Action: no action

On 12/16/2025 8:23 AM, Johannes Berg wrote:
> @@ -4475,6 +4482,31 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +int ieee80211_put_uhr_cap(struct sk_buff *skb,
> +			  struct ieee80211_sub_if_data *sdata,
> +			  const struct ieee80211_supported_band *sband)
> +{
> +	const struct ieee80211_sta_uhr_cap *uhr_cap =
> +		ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
> +	int len;
> +
> +	if (!uhr_cap)
> +		return 0;
> +
> +        len = 2 + 1 + sizeof(struct ieee80211_uhr_capa) +
> +              sizeof(struct ieee80211_uhr_capa_phy);
> +        if (skb_tailroom(skb) < len)
> +                return -ENOBUFS;

for the above 4 lines:
ERROR:CODE_INDENT: code indent should use tabs where possible
WARNING:LEADING_SPACE: please, no spaces at the start of a line

> +
> +	skb_put_u8(skb, WLAN_EID_EXTENSION);
> +	skb_put_u8(skb, len - 2);
> +	skb_put_u8(skb, WLAN_EID_EXT_UHR_CAPA);
> +	skb_put_data(skb, &uhr_cap->mac, sizeof(uhr_cap->mac));
> +	skb_put_data(skb, &uhr_cap->phy, sizeof(uhr_cap->phy));
> +
> +	return 0;
> +}
> +
>  const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
>  {
>  	static const char * const modes[] = {

