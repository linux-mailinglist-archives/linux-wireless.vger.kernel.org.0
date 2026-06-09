Return-Path: <linux-wireless+bounces-37583-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 40QcMAj1J2pC6QIAu9opvQ
	(envelope-from <linux-wireless+bounces-37583-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 13:12:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A265F5B1
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 13:12:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=H65C1MMu;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bPPsPRSO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37583-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37583-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3CBD3000FC4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532E3FD12D;
	Tue,  9 Jun 2026 11:11:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFC3AC0C0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 11:11:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003480; cv=none; b=M8D72XyqTlnxFq3o8ZoHxpuKMpVeM/pKFaGW1MAYCI5uTUUKsfyLS5pIImh6NYP6csbuUNNrLfthlbIEC/GiGbojWp73ndifrXq51b/lTAmGO/75IObuaKeNrIiG4bqiPX0ybOLWS/UmS1FijXRmMgja0L79o9Yn3f9cG+A1/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003480; c=relaxed/simple;
	bh=luYeJYflYXnZhbAdcaeCGEAM3+3bPyEQmEVVwO2MO9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keXzr6kk1ulcBDnV7iOHaDl6cRXBRHrhxD9ssr+pNkJxack/r/ReTLsWe3cKHzCdXvqFh3fH3sNwgfPWKmitLAq8g+y8hKdi3kAcmrB+qm2yWo4eZnRpxi1R2LywgGgRp8L1covhCMjJmrQuxm6pCP2NEqK0DC8aeH4EJFzKfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H65C1MMu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bPPsPRSO; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vDik264341
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 11:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n/J+OOATbu63FC4mSfzgPjIwoOf9EQ43EsdP/k2YTX8=; b=H65C1MMuBK4i8zP9
	busMjCdSTJRsO85X4G6G6yWbFwAuJzMFwjpRp+NOqZL/WW0fEhweUp5FNbs2Wwli
	8VrF/ihCPFluj6PortUY+nfs+rdYwMjAMXlek7BGK8HvECzq5AY9hd2pwQMmCY+k
	JL0hTvMrsXcTAfDce19sp66D6xi+sXYFg6GdTR53U1QWepMhrb7AzQ67whIMMDDW
	9XbL/eKGsThZUHgrcSOcDfZr+it5wMEbZlNOg6wMU1D2qcDaoyiIO4PMaXQ9WEOL
	r2UXwpAXzkkTwc1Q93aNHyMSn+6Fs6fi4FSMLud+YiIk5y2pCs+rJIIck2Aw58tp
	lTWuNA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0srqur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 11:11:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf11699875so55984155ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781003477; x=1781608277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/J+OOATbu63FC4mSfzgPjIwoOf9EQ43EsdP/k2YTX8=;
        b=bPPsPRSOJ0FpODoUe6GonVkNnH0IngiDB77JEEej0zHfeu0m1IJ1ZuUT/21XvDxJod
         zVOcygw2AKF1aSjTQgnzJNYcvqGbQ5HJmeugry93Cj52/Kz0DV/8mGTC1smpLAjf3Io1
         TbO8tsCdaB0zW71RHEUEdqonVVSyoMSqXMWPQkq7neSK7ee0oyifB8Q2M+jhcrk1o73h
         lP7CFgkYFs52QJbQRutalReSw3O2qJpwE6I/izR1EcFSfvaKlBipU/7iL2RmIdj6kU+i
         gqw+NwAXNzZevVvUcZwiuLIJsjLexUZE0PTugp62yu9J37OlPg6hN1drzcbxfANZb6Av
         EJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003477; x=1781608277;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/J+OOATbu63FC4mSfzgPjIwoOf9EQ43EsdP/k2YTX8=;
        b=JEsdGdwFN3BPoHNiLZIqGd8lkxVf4hOZQv9u2vObtRk6FHqSD9HFK7qMTWD5TYEOiV
         8jlyxAyFrQVzZ9RAlsbLNrlX6Fa1/pj0i/7NSjhLlu1QmwKuG7Plph+rQTXTKiqKuWvN
         770UtSodVH6F3SUy6kNbEg56tsJh2j/5W04FmZq6a6Pyc5+IMnoyin5s4AIx3wFCe0DL
         yTC48WIZtlCbh2tQOyKVvTFB94K0f12yvTn7rIZ2PqCtBsh+HeCNZikBy5qjEbczXhQo
         p9hIxkcGvudBnRJP/ObHV5YJ+1wZWcxDwo0Jq3Bdvf8FdzLMGK4Cm8jc+ySqjVIHZyOX
         pObg==
X-Gm-Message-State: AOJu0YxF2tgyX8+zof01LlwHc2923VKCT5UxdsZ/yO60ZIP3c6DyRYP1
	XdGtF9FuLMLgnvsdq3nGGZMv4jLErHJ/HxIs8fq6dsUmzrw/XuYTHRrnYVGWafiGBvQWS4wq77U
	tnyYtqBVC7mcMxllImhw9ZsdYVHQAGaYF/Ret6pHLxVh8TUyTX/r2dz08MgbIz0JIsR0QDA==
X-Gm-Gg: Acq92OG7brUgHxZNbERj/6ii/eCdYTu6+HYwr4DD1NZohR61sbX4RBIr17JvMUCr8pZ
	b1s+panu2vpGuFxOdOgzd4Z8apxucOPoRaxFCYnwYx1W4/i9EHgj7JZBY5qOSxTSNCI4HKy0igc
	COtD+3zpnb0x57uqBM73LzjLoGnEV55JgqVOzvxFzw6NsUWuUnhlXjjlcQvXWKIA5zyAaD4BkDG
	93AxCbuljeddfgumUMZKXQQ546N0c4BvPw5mv/O64ezQfvkfn9gXtoEfTPA6Lm80dJjFE0Eqxw0
	no+Alv4lwYibJ+qXei8meHONLmslKxmsfhBJgKIJFx0bMqi1erFXOpMAXcZLRcYjGFigMYbwuTJ
	3ic8ahhTFCWr+sdqDz0Znt12l/EvHcVuhRYjJGeqJ5FjEYPe8oMZHpTlHLsxzChc2yUOh+YtX
X-Received: by 2002:a17:902:d2c7:b0:2bf:13af:b077 with SMTP id d9443c01a7336-2c1ec9290abmr169510795ad.14.1781003477473;
        Tue, 09 Jun 2026 04:11:17 -0700 (PDT)
X-Received: by 2002:a17:902:d2c7:b0:2bf:13af:b077 with SMTP id d9443c01a7336-2c1ec9290abmr169510495ad.14.1781003476997;
        Tue, 09 Jun 2026 04:11:16 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d318sm222078575ad.15.2026.06.09.04.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:11:16 -0700 (PDT)
Message-ID: <67196fd1-4239-4c64-8c41-16704a0e5c55@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 16:41:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: enable
 IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
References: <20260604095831.2674298-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260604095831.2674298-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwNSBTYWx0ZWRfX7oF+RYuFrKsg
 2o/VkMG+zPzju8Z7hbTwrWT3oDW1ABI+q8kp7AjWsYsuh5i585hWzwlxieXleQlNIhWd8WW42lV
 TPTwG8HPsQEQ9Z/roIjQ+4dXHH2KfbSaChnc8ZYP9nVrzvu1nMKCAnrOwTU8cjCKGDF2JZyCKID
 ogFqPbB4sFNO41qvnFZQmjw/bPMZoph4qyijwe7iPYrAG+xWdp3rmgm32U+dvBhAQ39PiQ/663A
 gLmrq9NfexyFCHVPMlqgvaBClNuiTOYdqraxUyeg5Ro9uuIGxOeN8bsLKUM5VtTRGXnNkuA9myZ
 1yb74D3dJKZrWKyKutgyAv1o3mAPD+S9IgK14F0ShIGT1MjLjKHjq1XRtwwJZWjEaJ6UiMS7T2T
 hUPXz9htd+CXMQfLMEduN87NmIFU7a0Y+hIcQxLjTaalO0ipBi7T9070JYP700zIju8fc3hZGSH
 mh4/g5Q4S9gJUe30fcw==
X-Proofpoint-ORIG-GUID: IM0GA51B_y1gRF_MZOiJfzVVU7t3xoOU
X-Proofpoint-GUID: IM0GA51B_y1gRF_MZOiJfzVVU7t3xoOU
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a27f4d6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=l4s1JwOcGLE_FPx0VMUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=pioyyrs4ZptJ924tMmac:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090105
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
	TAGGED_FROM(0.00)[bounces-37583-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maharaja.kennadyrajan@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:quic_wgong@quicinc.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,quicinc.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A96A265F5B1

On 6/4/2026 3:28 PM, Maharaja Kennadyrajan wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> When firmware reports NSS ratio support, SUPPORTS_VHT_EXT_NSS_BW is enabled in
> ath12k. However, IEEE80211_VHT_EXT_NSS_BW_CAPABLE must also be set to make the
> advertisement valid.
> 
> According to IEEE Std 802.11-2024, Subclause 9.4.2.156.3 (Supported VHT-MCS and
> NSS Set subfields), the VHT Extended NSS BW Capable bit indicates whether a STA
> is capable of interpreting the Extended NSS BW Support subfield of the VHT
> capabilities information field. Advertising extended NSS BW support without
> setting this capability bit is therefore invalid.
> 
> Without this change, mac80211 detects the inconsistency and logs:
> 
>    ieee80211 phy0: copying sband (band 1) due to VHT EXT NSS BW flag
> 
> This indicates that mac80211 implicitly aligns IEEE80211_VHT_EXT_NSS_BW_CAPABLE
> during ieee80211_register_hw(). Explicitly setting the bit in ath12k avoids this
> fixup and ensures capabilities are advertised correctly by the driver.
> 
> This change follows the same approach as the existing ath11k fix.
> https://lore.kernel.org/all/20211013073704.15888-1-wgong@codeaurora.org/
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 18ab9d038fad ("wifi: ath12k: add support for 160 MHz bandwidth")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

