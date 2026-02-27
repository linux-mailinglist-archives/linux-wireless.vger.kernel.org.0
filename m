Return-Path: <linux-wireless+bounces-32284-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP9eAcVyoWkPtQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32284-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:32:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA31B6050
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 590E13012CCB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF08355F46;
	Fri, 27 Feb 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lkpXHIDZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dAMpPedj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354330F951
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188354; cv=none; b=sV6sVB6nfgO1vqzvgxT6+0bDaxomOf8wF3FB5CNGEzKCqizQF+iHVw6HG16eUn/w1nAnN9yrnBpKH8Ky5oeCIo4lGNhFEP73w61c5wN99JZWFWrcxsjxQgqSazhWVmEzn8X1ml37gv7DIlnv5v2u7t9LIExoNA9CWLdSi5/dI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188354; c=relaxed/simple;
	bh=5zBeVOvS1AXKQ4mZPMnMHSDjiWYT9tot7it3044GRcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3/26oVcdn5FQNLXFx/XZYCinQ4BGWTWsXwgW4ztePKZquHx7Rhnu6jtogK8i5JWLq8kxvXkXqhhZ1RngEZ5bNmhvU+v6eMSGLdl0MSOj3F415lAhk/9uMHEuv4O4KMRJW1nVGSOVRqM0HFQnyAd1jsvIpsPuU0si83AqiYly4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lkpXHIDZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dAMpPedj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9qPr3236179
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cQkT5daBDycOyMQTG4OEBBlhjqWgEkfRjFH+U9DTcZQ=; b=lkpXHIDZHzzgNT2s
	B3nAO5yIEDkfj0Ym+tr5mtEfwsq0n8oAaoFfG6wHN/2KF0FsCfsU3e3SKF+L45ye
	OFmc/BZ/risD0WvGFsc7hd7w6T9W0xi7KZweNyYDcR/uvLDUOPQFYp8ZA6uAI0A4
	BP8WA9DJTi4xQy6aiqOwCr97dzLjImCPQTopdJJq1HbV736rAOJTLGsH2yp22NC1
	sgik9loGnGios7iAfsBn170XL5+oCpHLF9G4UhGCBFMrhsN/Ora+PGav8NoccVa9
	09ENgaE4mU8YmeZ4M1+gVXX2JKaioRm4XMrIdcioKgdyMXMYWAdSTVeE/8Eb5ER4
	fPqmAA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xt4vb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:32:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630753cc38so8383615a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 02:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772188352; x=1772793152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQkT5daBDycOyMQTG4OEBBlhjqWgEkfRjFH+U9DTcZQ=;
        b=dAMpPedjV7MBHylVuzjXELikWnDR5qJMsrC1KxJMZIhDa+bcLiLXtac9u7ahP2qw37
         gbIb15oD5ph7ifnp0wkZLTatFb96Vz8rmHc5c5HVzMOW8GAhKKW7adIiXLfkq4kmGITJ
         EN8vMh0YYVM0wkplsVuvyd/+4hpsdWNYCkYiFo/NJ8fVEUuYIG7ly6cVk8mdw3tf2m4K
         6CI8I5D2zuXuuCeORvzdr2ywbsSxjsm+5LpCtcxb3bvFXUlWErC/eMVcyUUMlEjMVu4c
         BysFcQC7eZwYZG2e2KB4dxgYD6nzAEm8Oug45DY3ghVTXKYST6fN1YJfrYliKEqrUT/b
         b49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188352; x=1772793152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQkT5daBDycOyMQTG4OEBBlhjqWgEkfRjFH+U9DTcZQ=;
        b=SEpynhImWE4ZmLQLy5bAVS61K6saHHUMrVh2G8vKSWJR3+VrYYKkpJ7XZqg6GpvTWL
         c6HTjYwis/F0VJzJwSrnnkan8KE7ONRsB1WKqE0APw/Utm3BVIrmKMqpakXmy1dQlaK3
         VPHNAmytGs5+tbWEGWuuj+PyaUA4A6lG2UU1yw6Tf4wvgg/qLucEDIeSbxMzXCLuPnbt
         5UqEtPWGJKwRSr98fugQ5CFnTZTYZHk3EbS0OXTpF7SDCS4yNNizs4dGnwuCBTbR9nB5
         gyyb6vlfZtA3lX3zywYb0KJj6HDG/ipVrXJuP/bAzcw7P35uKrnkv3EFHYx8H5mKPKa+
         hTow==
X-Gm-Message-State: AOJu0YziN5RvWms29cSknsg4LFf7it/sjR3GLHB5MvjN1xd6TmEYLZo9
	R4xqfMT6rOLpR7dGtCpg63+YK2Brw1X+Udz3bbcaD39Vu+6B1MNd56bDHxGKSrcebxFzvHozg57
	+oFMrBZeTK/k1ipzGSrjl8U3Azh56MzLU6z0RGVhHR3Wr/zF+xdM2Ydnu6h13jqdR5XET/Q==
X-Gm-Gg: ATEYQzzShv7rPwjSvlDPckqJPs82U4fO4TDfoop60h4TuwcEnM00QHpJPaD9EEJu4rt
	9qF+1/suv0WTgU/bloFMEnznkt3pbd0RokVIu9fDl5H9Aar+UxzTqVn/RLV67tUCwT9gA/ujq6x
	rrNVTw4L32Zf76hLHQo5NgcR+A9y3alvTrQzSRtd7oTwQ0fzOqEuhmC9tQzUMC0VUzFQ4bFWeU0
	h08+82/12v+pWJpEpZxc5gvjS/sM3DUgqB+9aSOyS29dYdQ+RO1zD85UYYY9B+1js24Yomz4y53
	1THJ67FLcV/N3gd6GVGeYLniyD7njUMIJB5eaLw+djs9mrhb/VXZcJbhCHt0sYQK5aBpJ9UHOza
	DRS2vxQUQnt3Ze0XUGG1NbtIJzKRjOecsEtgGQa/0fPoxu+P7XyEEC4KjaoP/Mfjxlik=
X-Received: by 2002:a05:6a20:ac43:b0:38b:de3d:d52c with SMTP id adf61e73a8af0-395c3a1bc3bmr2134900637.3.1772188351732;
        Fri, 27 Feb 2026 02:32:31 -0800 (PST)
X-Received: by 2002:a05:6a20:ac43:b0:38b:de3d:d52c with SMTP id adf61e73a8af0-395c3a1bc3bmr2134882637.3.1772188351219;
        Fri, 27 Feb 2026 02:32:31 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa3756dbsm4150790a12.0.2026.02.27.02.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:32:30 -0800 (PST)
Message-ID: <8b9a8d78-dfdb-4ddc-aba7-e1f9065c3fb8@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 16:02:28 +0530
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
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260227033332.687805-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pRqsp1yqkKxWiOZmypGrzuMX-qwgpw_n
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a172c0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=RW0mjsVknEAIwFTJWnUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MSBTYWx0ZWRfX+xNcZ+qPoJyv
 ns/dJ/H3Dm9z5zPLddPFcG0qLaEGIYg78rTnoZwp4opUhRtf049F42TRutpmMoonee2PyK1pRlJ
 8PlSo/jH6SlR0EPenM49EMML4utksxj6QJUje+QWT/7ggaBiXr8BV3Vgnecag4xYWIN5bJnPg8p
 yq6z6wCrJBenLq2vOMbLqdQNLwhQ11UWOYJAxHegnaIfItN7pCDXEigPzzubhRfHWUWhDBV1+7h
 nNCiBCo0lyE8rSt7Wac4V0/kHqL9RjzNoeHtoRLJ4v+PO/asHPVZ0n/ABWA5R/hJKvUFcK0KZsH
 hPoUEEGBAYOKWma5sSllVQu/e3IAQk9GqB79XGJ4xsCecR7XL9ern0twlS3cbT7O5kg01VBkqtL
 syPjS7Pd2ncCyXaha5NtJp1u0KwTp55YQC/OUlCbbeOkhNl0a8twwYIySxjkvbK7XqNTmiKTLUy
 xaMgECo2yf+3Uh/aYXg==
X-Proofpoint-GUID: pRqsp1yqkKxWiOZmypGrzuMX-qwgpw_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32284-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73BA31B6050
X-Rspamd-Action: no action



On 2/27/2026 9:03 AM, Aaradhana Sahu wrote:
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
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> index df045ddf42da..27acdfc35459 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
> @@ -617,7 +617,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
>   			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
>   		.svc_to_ce_map_len = 18,
>   
> -		.rxdma1_enable = false,
> +		.rxdma1_enable = true,
>   		.num_rxdma_per_pdev = 1,
>   		.num_rxdma_dst_ring = 0,
>   		.rx_mac_buf_ring = false,
> @@ -626,7 +626,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
>   		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>   				   BIT(NL80211_IFTYPE_AP) |
>   				   BIT(NL80211_IFTYPE_MESH_POINT),
> -		.supports_monitor = false,
> +		.supports_monitor = true,
>   
>   		.idle_ps = false,
>   		.download_calib = true,

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

