Return-Path: <linux-wireless+bounces-32066-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cERkN9SlmGl5KgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32066-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 19:20:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE3169FCA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 19:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C377303DD5E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D3A3002C8;
	Fri, 20 Feb 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpjER3mn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nizbca6z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA262F49FD
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611601; cv=none; b=JPXlWb/3MW0SBS2QLh8pB9pDmIzQGIgJAfHzjhG7/gzX4yxjFBKquzzw+ksqp3DtEncK+YtPOBHtc61c4zOm4CGS7SI4yKGvAASZu8lfoBNdI8OB0kPkqpRAb5UNqdQDtfOtTYElqq0iuYp40snel3ix/6w/2glj8sQCsKXxQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611601; c=relaxed/simple;
	bh=DgHlOj4Gp6XiknWQUFvnn+Sn0brSmrb6TVF1V1bXsd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGbBnTh41DlRpM2GoYIgaT/fdCUY3RDJTmwfEuoPvzlf99tfcoC523YH7fd75bRGQRw7YQH3+RM3hK06PRsnCQm1bwq9Ef4H6ZglRQf7qV+NtUhBotNhfpGAKW12aENN98dIh88nbVYfC4GsRhExWWMSyoEJMF2ZiEvWIuMNM4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpjER3mn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nizbca6z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KHWi4x351533
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ycu8SdaFISM+NY9OiFUq9fYC13DdFUlaknIDt7l+UEA=; b=SpjER3mnxB5X9Tbr
	kQ39FWKYByeRIrJwcjP6FShci7xHoLpOUegL3sP8XctPi9w4/e/LrDcqogAQOtbH
	AnxueAe3Sq5c0Th93sw17blojB5337xCm5/LSke19jZYVip1EeCWJmQ2wi5Rl/Qu
	KPltB8tdacYBo7H8swsOYtktQqxvZzbSSC8KgIKTcfWLIJfR8jP5zjGKO21pqbhD
	tMSrqsk5BZhwBqCAlTLNaKYkf94cUDm6jS+AgELFQ2qBsFj1Rl+VPwoONMtlJaQf
	dqozpGxd/uHn6I83lf0zww0nnHSUqYG2p247+tJSos9H5DMZhIicKX0AL/Wo6Dp9
	CzJzhQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cev3xg3ym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 18:19:58 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1270dcd11c1so2909608c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771611598; x=1772216398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ycu8SdaFISM+NY9OiFUq9fYC13DdFUlaknIDt7l+UEA=;
        b=Nizbca6zD1uavbXOSNWFkk8XmCec0BpF9V+FOH1BXKY3n3cjRCQfU2KBHTCejzwepB
         yWPVwSvfmt47PlJuB6EgBII6OtlWBM4tj6hm1CjKSmxwYQV+hc+sXdaCmNwD56Q6958y
         yIDbnNM4ihU38sVMg4a3VHj8nZzgKiUGVcwuiX47pFyGkxz70rIQ8PR/xN+HX0MJxc65
         LaPZ3GzSQyaYLp+a6Niu2ZgWqivNdWU4dxGSg6uwvC3np54MNHAZqU69GSn9OQfi368Y
         FULevc9+4DXwga0maoFWMoLKuvdYg+dQk/yupDH8oGevv79WuNvy2SJGMEz/pDdXG9Ky
         2v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771611598; x=1772216398;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ycu8SdaFISM+NY9OiFUq9fYC13DdFUlaknIDt7l+UEA=;
        b=bKc6VmxENn2yiaXwtjCmA09Xj8G5a9sL5VY69e7uJGjL1vF3OkAklFfU2nt9DPqJa3
         bKiWzbJG90gj6PKLmH+LsEDlNKAoR2aV6/LPnvYmSq0TbKxzJqbhbe67qa8ptAqMyA/9
         iLZ9vIEtClG/L+bxOcKnk4h83G9YE8twrmVpvj09BUOA7QuNm3nZe7oKED1XdFJzQbQ0
         yFIMou9iO9We3IkSDe3Ybdvy89nDLuG8AfLk2Cz8lqPPlt86a42zuTlhEuK3iypEW0GI
         PR2T0ZOFJ7DnKP5oqRLBZ0CYleL4CoU4112mtZbMdSPCPtGE+y/pJ59ylmUPCoJaYPtD
         klzA==
X-Forwarded-Encrypted: i=1; AJvYcCWkK2HfK1zmyi7MmrXPB04MWnFHTJdZdIFgvJ3OwBGIBCrRmy6FQB18ZyvksAuk0F+H3vMfFwYCbN9c0r/3TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkqdbMJnaYIoDRP6/sEcBD8B9EkyiS3Gjjizzu/E2FNTg+KMA
	reVwuycL+zQq/h4BdBS8CSirv1EC4hF8WqmEEOsSGqkBEmM9lGCqsMAFvggh2bPn4Wr4zwfEKkI
	/nOosyeHREQ30MQPqswTQXz+SP8LOlGU0qsdbJ8f6gj7mU83t1pLvWuKuSzuFer2kMD11iNly3s
	YqCw==
X-Gm-Gg: AZuq6aJ3gx68/YX7r68yR51WpZcb4tj2beiUvFvmtsI0PkXyakojZQK9plkNEJGmrEK
	i6scguim+NQiyuONdnSjEL85fUHe6xPc9k0Pvem/SVXTYQCxuGrnu6Ebq8ekWNiWwsAJ6fk0We8
	GKiCx0JF1u+qrMwWJfUVSmirOBzIQQyipfMQmfCmU4mLfQc1EAIawm3CSfvz7/VPnQ+dYWkeBC9
	pARYEVTH6dWIYJGS+QKKdict3yXdfBSqJBEcyecszhPIp5piQ7gboj3Mhky+2cuvrRdB1ZOB67Y
	pmFucJavvrQwrAMc+fi7J9aWo35O6iDeEMLCjwuLjJDJO7JqviZ2W6vCQjEciaj3ROAzjbHIaa2
	iKbHwF2MRv9VlprkDTnSSFBOtMN4DKP3ZAepGznURSmPM88sF/EFV8S1VJZyCbuN8Ay5cpdxKCe
	qtUq4DcrrEzzA1Pg==
X-Received: by 2002:a05:7022:6995:b0:123:2d9d:a90d with SMTP id a92af1059eb24-1276ad107e8mr211512c88.17.1771611597680;
        Fri, 20 Feb 2026 10:19:57 -0800 (PST)
X-Received: by 2002:a05:7022:6995:b0:123:2d9d:a90d with SMTP id a92af1059eb24-1276ad107e8mr211492c88.17.1771611597019;
        Fri, 20 Feb 2026 10:19:57 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af10481sm192076c88.3.2026.02.20.10.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 10:19:56 -0800 (PST)
Message-ID: <66d57a5e-339b-40be-bad8-5348e70a6a35@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 10:19:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/8] wifi: mac80211: rework RX packet handling
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260220141929.206976-10-benjamin@sipsolutions.net>
 <20260220151929.9c68f68fca75.Ie12ec077142c6a7fdbb58cdfc5660497cc75150e@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260220151929.9c68f68fca75.Ie12ec077142c6a7fdbb58cdfc5660497cc75150e@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1NCBTYWx0ZWRfX3QB9W08V8H1w
 6vmXHsIk/FY5bfiNM3H6y3f4gdYMTxTroTXDr0ebkmlaO6RdRlgJYQbTdv4k7Punt+bD8Zuj2K1
 0Amwl//vOFoya5aI8bLxtdmIUMZxaiFmzg4M+pixtkbt4Jp/dKQoRcd88cYTFigk+UH2CyaE/ij
 JtQ7tEJyvKu2+vvHJJaWYFaE1cps76t3b9JDlzvaav/Y7oBfnoz/Lm3QDr69cNu+V4JP5n1hTz6
 llhr1QsDs3/clrtRidPAHFjwqVpuXVEvFNnVlLVdWwUq0LKSbgzVOzliVv1ohxXCekO2P52ToQc
 cXc/8zoJRAXxahmIzuHGM6pp7yfJhJtq34k4GlrO6A8eVRFrkQ1c6YOKSd2nF0jMlJn5TxfUpw/
 ZxmOzYMH6MXJMQAAZHrQgVEnG5+CrfDmzX8xvYbSvLzUOkpoTigvvz7dBphZkfy7p6gYBkunNKt
 7DS6gziewaDKktlOjKQ==
X-Authority-Analysis: v=2.4 cv=F41at6hN c=1 sm=1 tr=0 ts=6998a5ce cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=XfvRK4UB-c0Nux64rDYA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: vukE0U4aK0m8k7PEZofmgEPrHBZsCr5K
X-Proofpoint-GUID: vukE0U4aK0m8k7PEZofmgEPrHBZsCr5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200154
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32066-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3FEE3169FCA
X-Rspamd-Action: no action

On 2/20/2026 6:19 AM, Benjamin Berg wrote:
> @@ -5292,92 +5284,102 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
>  		     ieee80211_is_s1g_beacon(hdr->frame_control)))
>  		ieee80211_scan_rx(local, skb);
>  
> +	/*
> +	 * RX of a data frame should only happen to existing stations.
> +	 * It is therefore more efficient to use the one provided by the driver
> +	 * or search based on the station's address.
> +	 *
> +	 * Note we will fall through and handle a spurious data frame in the

Note that checkpatch doesn't like the use of "fall through" in a comment since
that term is usually associated with switch code where one case does some
processing and then falls through to a subsequent case instead of having a
break. Should we reword so that checkpatch doesn't complain?

CHECK: Prefer 'fallthrough;' over fallthrough comment
#5293: FILE: net/mac80211/rx.c:5293:
+        * Note we will fall through and handle a spurious data frame in the


> +	 * same way as a management frame.
> +	 */
>  	if (ieee80211_is_data(fc)) {
> -		struct sta_info *sta, *prev_sta;
> -
>  		if (link_pubsta) {
> -			sta = container_of(link_pubsta->sta,
> -					   struct sta_info, sta);
> -			if (!ieee80211_rx_data_set_sta(&rx, sta,
> -						       link_pubsta->link_id))
> -				goto out;
> +			sta = container_of(link_pubsta->sta, struct sta_info,
> +					   sta);
> +			link_sta = rcu_dereference(sta->link[link_pubsta->link_id]);
>  
> -			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
> +			rx.sdata = sta->sdata;
> +			if (ieee80211_rx_data_set_link_sta(&rx, link_sta) &&
> +			    ieee80211_prepare_and_rx_handle(&rx, skb, true))
>  				return;
> +
>  			goto out;
>  		}
>  
> -		prev_sta = NULL;
> +		rx_data_pending = false;
>  
> +		/* Search for stations on non-MLD interfaces */
>  		for_each_sta_info(local, hdr->addr2, sta, tmp) {
> -			int link_id;
> +			struct ieee80211_link_data *link;
>  
> -			if (!prev_sta) {
> -				prev_sta = sta;
> +			if (ieee80211_vif_is_mld(&sta->sdata->vif))
>  				continue;
> -			}
> -
> -			rx.sdata = prev_sta->sdata;
> -
> -			/*
> -			 * FIXME: This is not correct as the addr2 cannot be a
> -			 * link address if the loop itself is iterated.
> -			 */
> -			if (prev_sta->sta.mlo) {
> -				struct link_sta_info *link_sta;
>  
> -				link_sta = link_sta_info_get_bss(rx.sdata,
> -								 hdr->addr2);
> -				if (!link_sta)
> -					continue;
> +			link = &sta->sdata->deflink;
> +			if (!ieee80211_rx_valid_freq(status->freq, link))
> +				continue;
>  
> -				link_id = link_sta->link_id;
> -			} else {
> -				link_id = sta->deflink.link_id;
> +			if (rx_data_pending) {
> +				ieee80211_prepare_and_rx_handle(&rx, skb,
> +								false);
> +				rx_data_pending = false;
>  			}
>  
> -			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
> -				goto out;
> -
> -			ieee80211_prepare_and_rx_handle(&rx, skb, false);
> +			rx.sdata = sta->sdata;
> +			if (!ieee80211_rx_data_set_link_sta(&rx, &sta->deflink))
> +				continue;
>  
> -			prev_sta = sta;
> +			rx_data_pending = true;
>  		}
>  
> -		if (prev_sta) {
> -			int link_id;
> -
> -			rx.sdata = prev_sta->sdata;
> +		/* And search stations on MLD interfaces */
> +		for_each_link_sta_info(local, hdr->addr2, link_sta, tmp) {
> +			struct ieee80211_link_data *link;
>  
> -			/*
> -			 * FIXME: This is not correct as the addr2 cannot be a
> -			 * link address if the loop itself is iterated.
> -			 */
> -			if (prev_sta->sta.mlo) {
> -				struct link_sta_info *link_sta;
> +			sta = link_sta->sta;
> +			sdata =	sta->sdata;
> +			link = rcu_dereference(sdata->link[link_sta->link_id]);
>  
> -				link_sta = link_sta_info_get_bss(rx.sdata,
> -								 hdr->addr2);
> -				if (!link_sta)
> -					goto out;
> +			if (!ieee80211_rx_valid_freq(status->freq, link))
> +				continue;
>  
> -				link_id = link_sta->link_id;
> -			} else {
> -				link_id = sta->deflink.link_id;
> +			if (rx_data_pending) {
> +				ieee80211_prepare_and_rx_handle(&rx, skb,
> +								false);
> +				rx_data_pending = false;
>  			}
>  
> -			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
> -				goto out;
> +			rx.sdata = sta->sdata;
> +			if (!ieee80211_rx_data_set_link_sta(&rx, link_sta))
> +				continue;
> +
> +			rx_data_pending = true;
> +		}
>  
> +		if (rx_data_pending) {
>  			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
>  				return;
> -			goto out;
> +			else
> +				goto out;

why change this?
kernel convention is to avoid else after an if that ends in a change in flow.

WARNING: else is not generally useful after a break or return
#5363: FILE: net/mac80211/rx.c:5363:
+                               return;
+                       else

>  		}
> +
> +		/* fall through, e.g. for spurious frame notification */

here again

CHECK: Prefer 'fallthrough;' over fallthrough comment
#5367: FILE: net/mac80211/rx.c:5367:
+               /* fall through, e.g. for spurious frame notification */

>  	}
>  
> -	prev = NULL;
> +	/*
> +	 * This is a management frame (or a data frame without a station) and
> +	 * it will be delivered independent of whether a station exists,
> +	 * so iterate the interfaces.
> +	 */
> +	rx_data_pending = false;
> +
> +	/* We expect the driver to provide frequency information */
> +	if (WARN_ON_ONCE(!local->emulate_chanctx && !status->freq))
> +		goto out;
>  
>  	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> +		struct ieee80211_link_data *link = NULL;
> +
>  		if (!ieee80211_sdata_running(sdata))
>  			continue;
>  

