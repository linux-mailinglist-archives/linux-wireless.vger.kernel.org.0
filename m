Return-Path: <linux-wireless+bounces-32289-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPjkHZl0oWkPtQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32289-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:40:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D08421B6176
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F12D316AE56
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22B3A1A41;
	Fri, 27 Feb 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZt2KfrK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/CUQuC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926439E6E6
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188694; cv=none; b=lSm80qFlRPAIv41ltq7EFIgNU/wLR5MWvJARfmj2ZV6xgEhrSTDDp65KHIBEoBhErSveaoj0RnBKfFIho5aEPj+ZZk2HHUKFMoovoojfRH58TDxPIYKzehNdXShRfUjSeI4C0rDbKAeDXChP1ILZWqsn/xXUFSU6ac8JD0cvq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188694; c=relaxed/simple;
	bh=gMdHrMmjFnRc1gI6lUK4Dk6M1LiuZzX18zeeIdl1Gwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5BeHICliR0UMM8yzp/qPT86MI2K0AyWinzOqOh4PlekDS57CnRwbIL7peLS/PGwwDFDcoHV2KUqvhSwz9snKsK3TWUPWSjpr7BRJWc1Jt2Lx5XdNitrsLOAQmKY4Hj7/PilajvAZOHKM6LzoPBm7vhE+sWtnZ82ZitmAhNq3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZt2KfrK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/CUQuC1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RAUp0C2440393
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tKbt7yTaanLR6L8cws8tx4dbOl5KiX0XuRpCcJ6dhLM=; b=NZt2KfrKaz+goiQy
	WWVDhH4UxyY/GvnQCIgqiYancgdtfmSQcHY7+Lm3l9rh4NvpHb7VcZHqD8QRyxk2
	dXBxPN6Sw5NiadDcwDBxhzvcCgrrqm6SXwgbI0nNxBrTpYcSVEIhDCGAhki38ITB
	ebxq6SMrQkbDVxwNKUQpejH9+LHqOor6nTTz+xKeg6GkIs4+wX2z1fHShPiAXKko
	nl5U+v8d0ay1gzmgCQPoNdzykav9QSA6a+0x2BL6Y/p07soURJP4aAj/GgYNlpYn
	pcVsW5RQLn3I7utJwhJ9U3eF7JB0a6G4z89Rk5Lc0nhoyZQbJCJPL1yfEp1iP2E3
	u7Fatg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r2yq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:38:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ab0b2e804cso17641005ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 02:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772188691; x=1772793491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKbt7yTaanLR6L8cws8tx4dbOl5KiX0XuRpCcJ6dhLM=;
        b=Z/CUQuC1g20mCYbMHdiO0BYkRVY08X5Q5EwFl0vczg0caH0/g3dGS9FRZ1R9IDlhc7
         b32v/gh8dsOfKm0MFmTuJw9nOuOcEkuTn+6Rf3c57ZbHJm9yYPGfXpNVQ+z0Ds7Hy1Kc
         APqMweaR1e8ewq+DOaR88xmX8LA61+9IOnU+xw/pg8UhAJu24WJtFv/kAgJ64arDKaZM
         VZclabaz/T8k67LFzsAuLts/XKzeaaawEygY6NLTYY1ZE7uWAnO+AcVSzyMiDZ7/oK3D
         mirQwJiFJZcqGmVPbeWmfXZZpOdL71QnuNnzOT7ST+ZQT0pjQERHQ0cPB0owcRgTNzGI
         v2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188691; x=1772793491;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKbt7yTaanLR6L8cws8tx4dbOl5KiX0XuRpCcJ6dhLM=;
        b=gbg9SakWLTub6BCnfZY7LDA5ZL1MqtrU8jLIQQeJ7VVxmNixPNWN0SGsXwBC+o+YZs
         gxUb/fBR02wydBXcEO9o7tcxc4my6EM4Trfsv+KNgJJomredHlGIIZ8I7UR/E9I7FoxM
         rt4D28fgbtPT2mxJopDIX/mw70YiBb/ObO6UHa3iOaXSgQBz+3BDHevhGSPprWf7972X
         f0RRe1OV7KXx2YY6oXoXqqtbgom7UHjKO6pni7GPn8GNVkp4zzdpRe7oXNAh1zSOwrPr
         rBFRg1bC9IGUtYdj409t1iUtvhRPAyzOiKr0hwjMSeQiq8GomjbSNUMRkCf4HsMrEVuT
         YsGA==
X-Gm-Message-State: AOJu0YzssRRPQ1Q79XoDYxkTKkbSpRk5xk3Ilia+MzhSXGQx/PlfkSqp
	NCIj7gRobz5978VrlxB7sTl0r59pX3qRAGLB2z6Uv5DEcVEGUleshJVIAtrmh2A6E9scBuSzLrw
	HV0jhr1pyq0Wmg6oZgxYk1/73aXMixc8xY0OwUBfUqqGiQFWnioI1W9xv6gPqtuHFYo1vkg==
X-Gm-Gg: ATEYQzy47RVI7uNwqJXGVNG5bTJpp0tL75LgxLjre6Sa8AGiZifTB6eSkpNJlXKnQKI
	52FVoMBYl+NmTZg79ZhK/DpHujYzUaXztNRqrJNKmcCgwcS1B68/fg+wjIktZaCs1QdNgKZUtBo
	JnFp2QanDsweloog3Hp8BQz+Q6i1kTEwvdSAZ23ope/vhHOezAV1ifu63lm88D/4pOke/Os8a3e
	Rg7S5U7yTNmyf84k/u90Pc2TtStQK9LowR5JAv7f93LC2F4/qUM6l14JwECeSie7IoTCMIEeD+Y
	sL4Je3I6pBA1VpoDKHq4Ky5OO91YqAe0rm2owF052+arjUA4AHUzqHF3jbO7HOz8CzDzWRTwP0D
	7Y4bAUu+AGizqmEuVQb1xBS0AoNapf0Ur0SKA+JvRkag+QSzFP3nvZ55/48k88OK8DiWdfh07YO
	MKHu8WxwsyeSAcEtZFEw==
X-Received: by 2002:a05:6a21:9217:b0:341:d5f3:f1ac with SMTP id adf61e73a8af0-395c3b0dd7emr2123294637.41.1772188691523;
        Fri, 27 Feb 2026 02:38:11 -0800 (PST)
X-Received: by 2002:a05:6a21:9217:b0:341:d5f3:f1ac with SMTP id adf61e73a8af0-395c3b0dd7emr2123279637.41.1772188691052;
        Fri, 27 Feb 2026 02:38:11 -0800 (PST)
Received: from [10.133.33.12] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa801704sm4441519a12.19.2026.02.27.02.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:38:10 -0800 (PST)
Message-ID: <f667ddc5-0015-4970-8f9d-467f7165c962@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 18:38:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Enable monitor mode support on
 IPQ5332
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260227033332.687805-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260227033332.687805-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MSBTYWx0ZWRfX2AWiPrgAnPM/
 laPLZ5CUkZ66utlnWsOEWtV5LxlVjGeeeu4k7QJei4/3TRqZ+KIb9fiR98zVQfoSoo9Vy6PRUBz
 ZJNcz5cyxN83runMyRtpiPw4BPkqQxsrG2KCubID1IIUtXIMva+rvh00EPmGKCRg0uhMAgjjkk7
 ZPDmz/ef/SwOgHvdoS1wiNmTN0xUpab9LvugQw9zmi3bTuiRXE17J35AhMMrRbqF7nG4NOdDhty
 UVw0A4FI6Jgh8MtiV74tYz7SJD+tSP/Zs0lPpb0Zn0xbkVO31wFUfl6e2g7PiEFhCIlml+Zq4sO
 hGiSHXan1f7a7oc7LF3wGjWTFyXphxQShB8SCdQ2vnUdNvDrGl9eupk6ZtGaonM9UN15opukWj8
 sFn3H5x1kxTsG+MomzCz1RiAhK6Xsg2P3jU2vWl6j7YXAW1gc+WBo1z57jKnLbqpBHARRuK7sp7
 3kAD8Z5tmW/GQh4FQKg==
X-Proofpoint-GUID: 8eVGUZTdnDNAq7Iop39SlRKC7oGV4szp
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a17414 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RW0mjsVknEAIwFTJWnUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 8eVGUZTdnDNAq7Iop39SlRKC7oGV4szp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270091
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32289-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D08421B6176
X-Rspamd-Action: no action



On 2/27/2026 11:33 AM, Aaradhana Sahu wrote:
> Currently, rxdma1_enable and supports_monitor are set to false in
> IPQ5332 hardware parameters, which skips monitor ring configuration
> and removes NL80211_IFTYPE_MONITOR from the supported interface modes.
> 
> Set rxdma1_enable and supports_monitor to true so that monitor rings are
> configured and monitor mode is enabled on IPQ5332.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.7-00587-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> index df045ddf42da..27acdfc35459 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> @@ -617,7 +617,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
>  			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
>  		.svc_to_ce_map_len = 18,
>  
> -		.rxdma1_enable = false,
> +		.rxdma1_enable = true,
>  		.num_rxdma_per_pdev = 1,
>  		.num_rxdma_dst_ring = 0,
>  		.rx_mac_buf_ring = false,
> @@ -626,7 +626,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
>  		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>  				   BIT(NL80211_IFTYPE_AP) |
>  				   BIT(NL80211_IFTYPE_MESH_POINT),
> -		.supports_monitor = false,
> +		.supports_monitor = true,
>  
>  		.idle_ps = false,
>  		.download_calib = true,
> 
> base-commit: 20ad0d58517073b3b683ff786c65dd3142321707

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


