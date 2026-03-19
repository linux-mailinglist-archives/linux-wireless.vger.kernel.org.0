Return-Path: <linux-wireless+bounces-33448-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO3SH6hku2lVjgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33448-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:51:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 229462C5281
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F3130DA227
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D4387591;
	Thu, 19 Mar 2026 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NEijA3RK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S27/tN5K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2036BCC5
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888471; cv=none; b=UaXoWSBDc7TSiORHcKSsgFngZ5lygLVQXNKtOqgvuasgn2gxsEZO+B83p/Dml1awYgF8gi370E/HX5dYy4+1ceOb3bs1blPMGv0HKbNo8WAQe/rjouXFlpgag53xnMR2UM42mFEnM5+1DtgJIV7L/6GA2qxqvddy2v4/kKltSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888471; c=relaxed/simple;
	bh=JpRLou5c3IrWT5+/pUhl7GOXvFaDQh/BxYXfAd9bwAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUPYMgdhr0sUI6vkLfA0GZeKY6UqdAfuZZXpXm0PLMeQ/tgjmDd9Rn3Etk2THsWL8vxUvBh2l6TNarotZiezWiCcsaHGm+xPs8ETAiS7fS8WNsd1hw8t2RjyyGjttB2m7QQpPlMawYB6iPKW52FxFnl13mskNRflJqhlmYKrUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NEijA3RK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S27/tN5K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J0JoXl003915
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 02:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nHDyHXOy91HF/6i04YQNHlGpN7N/uSNnlOoEpxM8Ovw=; b=NEijA3RKUt7Ddj4M
	k7VRXMPj3qeVi8KCkJMOcAM8GZWyc89lsScltB3Q6t72P+DdFw0T/BX1kN2C0p8x
	Pgde9h8jZ15lkAdp6sneZy9MHBFdiyl8Xw/p+ytrEONokD96Awek+b896LufMemU
	3YdCdMIy9KVcCsUOee5kJL3u8pQ0wqFEBEndNLIwLaIpgzIuggfPkjryOzzEAFG/
	4ioHO5I06q2xBUTRzdUXr5paM/LDEcexTGupJ8XwxKRoUntlXczJH5NsQJjtX7Gr
	Htx4NlqHvuQw8iIQSs1vGV/SZEmhbkLLdpXw+eJxb2RR54bgMaHCuNWmi/HOQXrs
	ck7u4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb3ar2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 02:47:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b051befbb8so7243685ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 19:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773888467; x=1774493267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHDyHXOy91HF/6i04YQNHlGpN7N/uSNnlOoEpxM8Ovw=;
        b=S27/tN5Kybiv43S3JJqeyNSNih/dXkjDFokCdhkpGInFgFONrc6Y2hdA+2ioLzlqRx
         JM7fO551ToBtCzOlbb+jvEK30iPh7ZxCBLLn6eWMRVPkxMGjWpdho65FYqefGRRTSoiC
         qze9nrE70cxdcE52MHgZ4cGsMKMcqQAczy6JnodT1JbOceQHRvyPA2TI022oQUgBFXZI
         WAW7GiIlX5oRfqMmXPahLje6c3oMnnynnWbxID+pHqMPHE8ylo0o9IMqBW3KhWHVipOv
         QRpg9UXA4FhlKGnXGpz+692l8R4wQSAd82l4rNqvTu+LHQBhh1/L6psR+LN7v/Ytap41
         at+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773888467; x=1774493267;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHDyHXOy91HF/6i04YQNHlGpN7N/uSNnlOoEpxM8Ovw=;
        b=FSIOv7pMLAJZvzKh1y0QwQIdl/bx4auXdEEb+C7mFdtCgTSffCV9JUcMIvpOU9+6U/
         ufX+lyld4DSPXJrEoDW9JO3g0yDkZ4/GZ4MNmftZXC5n9cgP12/YS5ke3BL/yIX0JK9P
         kL+/vb1sOabqC9I5Wq/MrARGywbdFHzN1EkRP/5GV2t85S0t968k1SFETcO+DO7xrYQc
         UEVjTrCdF3JhTBCYc5Zfc5qMNWnVH9iAA8iApVYqE//3TOY9bG03C1piMmUQ0zRHHnhj
         tdq9hd61lITkXD1GIi3YHuHtED33FnpQbY905S6ap1eEsJyzFcNqSUCrJAtsSJ7acCGu
         3HIg==
X-Gm-Message-State: AOJu0Yy343H4iCpbt8fwGXfdXOe+cc77TwzEdayR5m/u81meKUATrvN9
	AwHazoTLmyxjkC0nEWkncqfkUn/EbU2I1qHAFONTRm2l1QUTKXfhr2roGloewLQljkO5Zk3zGik
	odvgM0A4CxswDBZSeaTVX0+3HTmHBx8OoiYKVGHQDXyfaucGcV4i9UxcbTQ/wj4yolWOze1u9zZ
	Op/7gX
X-Gm-Gg: ATEYQzx5aUSVgcqkQ4T3ftRoHtf4sF8TH0fW+cvlF1AhNapOD+rIdxiJ3AtkeuWWMDb
	iru9GcnOUwVqtrgSVlXBBIoDRyJ02DZBGWlmyjZKCOIZ9fBTc9iA3tydJv+9j8kXI722zMql1dU
	qJ8v/tK2740aPvNOtt9elD8ryGJuBLTsE4a+zBIJjNX7ayOzqLgdjB6IKoHRMGwEhL1nuW0WNLZ
	HtwRYoMrMwFTOvp2ZMR96G28WWw3ZBz76LC8Yt5T6ZvQtuH6+pz6E84n6UhMD7BU3enrJcKROdE
	Uphsy2gs/p+4zuBNFeXe5DyF1geEa0+9kiNRc6VCHR2UC/1vAW/TtUnDRbaq+W+EdpXNX6LJROC
	vw6MA1UvV0MCUs9F2S4qEJqMxN1u0i6cbeAgu6PVZUUsylIMUKvUA+XjEAaPnlMLB242UDjtnI1
	UO89Nt2pHA74l5o90QEWs=
X-Received: by 2002:a17:903:46c7:b0:2b0:643b:41d2 with SMTP id d9443c01a7336-2b06e3fe574mr55296205ad.47.1773888466653;
        Wed, 18 Mar 2026 19:47:46 -0700 (PDT)
X-Received: by 2002:a17:903:46c7:b0:2b0:643b:41d2 with SMTP id d9443c01a7336-2b06e3fe574mr55295965ad.47.1773888466150;
        Wed, 18 Mar 2026 19:47:46 -0700 (PDT)
Received: from [10.133.33.235] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e441374sm41024405ad.29.2026.03.18.19.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 19:47:45 -0700 (PDT)
Message-ID: <47c6626d-14aa-4410-bf75-6720d7673eec@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 10:47:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix channel list copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260317-fix-channel-list-copy-v1-1-5e1e5ae1c5d5@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260317-fix-channel-list-copy-v1-1-5e1e5ae1c5d5@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: l2Yb8sckXsUTuI3rcZbwRFybSOM_iyKt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyMCBTYWx0ZWRfXx1KQdjmJPai9
 7J2yVUaBhQRz5OOeKO6pk+GrIxG19d0cNgc3sL1JR2FTsTuoa6WmjsO5l3Zb1ExyvGI12ulLVGA
 3bPRA34kWY7OhR4IzYOiS2UxA+J874bwoOlVtioNjRUFPAggC5eCes9nJWT7As+0i2eUlrsCJCI
 a6sWGADPbj2Sj+Gd0B+OvDlhjLZ7v2TbjH4wCGerZxIyoABDPaZUkeWkpV6ASeME7P8Aw2DeJsy
 O08Pzi+VI2ZATckgpIZ2cUnLQuReNIS3+SwCOkJZY8YE1Zk00O4EMfbubUGZ3V7o/lKg+fAvRb6
 eQ5UqL0VDVwBb/0X1N2wDgW5i6A4Vo0+LL49mdhBBtA41bCx10rAMQPhbwo6WfTRWbgK23B8VBB
 DUikLh+OXrn1xg5UgH3knRp+OIeHXIPAUTC66r1bB1o/3zZNEJk9HH8AP/Aya49ITP5MZwPYOHP
 KCWF/WC1vDV7/HxyF2A==
X-Proofpoint-GUID: l2Yb8sckXsUTuI3rcZbwRFybSOM_iyKt
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69bb63d3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8 a=ywX3x0iTvHv4trEmZJsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190020
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33448-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 229462C5281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 8:54 PM, Alexander Wilhelm wrote:
> The ath12k_wmi_scan_req_arg structure defines the channel list in
> CPU-native order, while wmi_start_scan_cmd expects the values in
> little-endian format. The simple memcpy causes the hardware scan to fail on
> big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
> values to support both architectures correctly.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 65a05a9520ff..9e1d3c662852 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>  	struct wmi_tlv *tlv;
>  	void *ptr;
>  	int i, ret, len;
> -	u32 *tmp_ptr, extraie_len_with_pad = 0;
> +	__le32 *tmp_ptr;
> +	u32 extraie_len_with_pad = 0;
>  	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
>  	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
>  
> @@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>  	tlv = ptr;
>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
>  	ptr += TLV_HDR_SIZE;
> -	tmp_ptr = (u32 *)ptr;
> +	tmp_ptr = (__le32 *)ptr;
>  
> -	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
> +	for (i = 0; i < arg->num_chan; i++)
> +		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
>  
>  	ptr += len;
>  
> 
> ---
> base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
> change-id: 20260317-fix-channel-list-copy-cef5cad24fb6
> 
> Best regards,

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


