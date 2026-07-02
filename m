Return-Path: <linux-wireless+bounces-38491-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 21CzLiEjRmpNKgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38491-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:36:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C976F4DB1
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:36:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cSKnM9B1;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VLS4kR3M;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38491-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38491-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB6C306DC52
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC942642D;
	Thu,  2 Jul 2026 08:27:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55C36493A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 08:27:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980871; cv=none; b=S+GnmBYAzcE35sLqZcjp4n0MPnDDBm24jWAmUYLE8+mNCeUTJ0IeQ9UHPX6GOeu9lL11lLlzOo6k3Thz5ys5NOjmw9fj0x2dsGse9r87E5xQZgpeDQ5LjtHNrp3lRNe1TkzYIAWdLNxXSZASQ2QdSSxhXgAftKWQkM238t8O2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980871; c=relaxed/simple;
	bh=mC4x6or/X+5NN6lpoYhoGSnv/sjtQL9GcnsD3yHxQ2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pswksCPkFFPdWtaxBcEXoTdLw5L4BIFlKU7FzOVQbtBihnwWT6eES6EcipsopL2gxoqzOHDpVAhSGYYTvgEPwei/wAWUu9ou5EKmyazpE2OF+X77ea3TLHTOJ1PpVOd+2faYai+/oBixM7SugBcX3JrTrz9A9Gi2KTA+lg853F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cSKnM9B1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLS4kR3M; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624ioNw3592740
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 08:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1HVkKpzQdbeQaZnyAkJaHwqYV0JX9ZR+ROJzieyYOnE=; b=cSKnM9B1WyHdngTC
	fjt+oN3laX3gp6i8AAUSLqfeS15h/9eP02nXyfgH89pGxW3FWBkfVXu+a0A7+loF
	aU0CSMYNYppaXOQg8Ua73+svfTsCf6j39bFsPyoMGB8qbr6gJSo1/ml9Ity4h4q5
	rooV+DkrBbnHaUXY+Fqc4LY/9WZG6AwXTDp14DkU902LHi4uAmCgXFhRwPPgleC6
	j+3nMg/GRYYx5DJYyIxGWQ5N+6RgeSMf3pMR+slNVs9kAHPwrD3zOuIF1IwnUub9
	IDn7KPEXNPUfprW7haxToUZ1CuMymnCmp3lpqxNrNQB7dQ7O0NSBLaMIP4+iRxNa
	c+Z3VA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n8scb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 08:27:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88d7a75507so2179649a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782980869; x=1783585669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HVkKpzQdbeQaZnyAkJaHwqYV0JX9ZR+ROJzieyYOnE=;
        b=VLS4kR3MwjErOVkHHQY2mEjNA19lgZ6YTzXB958/aK1KYdt/37FLvDTISmYUrUJEfj
         lkkkHWg1773YqzG6G/n4orknxtMckg5YmM++zQ6grMa3wSrpj40oPIjo5RCuNwQJMSQb
         cHrUrHfC2cxXQD77L46p15WBo7jJ4wxKtExzBGxyzgJ7Ye/yLmsrMickyLtEr3uzpkgY
         yJtd25KthyIpwTZpEPRnzZkj7Jdu/TzelofeJA75SGMXP/56We0Gxz59sH1ZwNA4lTu2
         0FU1Ht0Vm/rI7DjDcSzqaEg6V/EXJPrjLRoQFPlp1TdiTdRKV10J5whUJn/icENlNwAz
         vP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782980869; x=1783585669;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HVkKpzQdbeQaZnyAkJaHwqYV0JX9ZR+ROJzieyYOnE=;
        b=lNHwP34+h46IGnMjalfrAcYPg3rgtS3+f4sqoJk71rTnWu4EjtswoDLN4lfk/DJzX1
         IyX+DIzUffuq+TguX8eGfGcXZ5gZhqOkUdV1TKmjRyyMSHP3MCcJshvqQY0eOgT8h4I4
         cqN1Ivapm5cuNtK/T8vcsLFYWOC1sCMe7VByPGQRAsiuJlPnj/UuSfAyMmxVh6fVGBaF
         IoYCTrU8elpzb0qpA7zb6sYMB/fhaFzHONXS3JeJ340EiDa6n4KDStRCawmrpRDC8Cay
         3c3YFHPjSNTy4oaK4Tolo6qxhzGqgdDRD32UpB4KaR5wosd39gBNnJMhI4l6MtVAKpj+
         17HQ==
X-Gm-Message-State: AOJu0Yyg30y6RjxoRFjvJt14LbMoAItdd5EukGM7xf9vr7zglKwjQ4Fm
	A6R9i3yFuHBbIydaJ4IHuA920HeFK6zjcvg4NRbjeLWTgR7OFTuKv69JVOj3tA1WSvLHZnwOTPZ
	dyIOePwi7NGksFv1X8+c3YuJGB7EE6c/scJPmCWMl9649siW3SJdCDdkoftKlh76pab+ROQ==
X-Gm-Gg: AfdE7cmNbyzn6EdFlss6O2jl2aza664HLzghlP5kEp73MP4cHq9fXLiFC5cZhI29yxg
	gxPLs0ZKoY6+CuoFtMCz1Ms200EgfkN4otYJrCqiaud5XKqGjIJFYn5ztvdzMhnetn7LGYHON9G
	6RFjeHx6j89+kielz8h+NnmDh/rWGPBcCcwPYFdCO6WNsEz/nnaNCh15SdpWKTnUs7kh+FVF2/1
	O4NCWMQvIPfY6cPb9H443IgY1nQo1BrENjjIPwZ6UWEX/+SM7NH97kJo7be9H19CJhJoQ5GIS9o
	inUs1KYSMzE3QMI0ynPZ9MREa8jikTG4gyhnT5ki7gKJfVuIATYIKPXU/X2ec8BWpZCrhfNXtC1
	0il+RCSBNMfuqCnSFntqfj9qXL4MV6eai5n4wBDlNDR9MQaCN31rbs/Z1jUJ1hngkGv+JtJrQ36
	MMM5XGrSzf
X-Received: by 2002:a05:6300:6713:b0:3b2:8675:4866 with SMTP id adf61e73a8af0-3bfed471c52mr6055784637.31.1782980868656;
        Thu, 02 Jul 2026 01:27:48 -0700 (PDT)
X-Received: by 2002:a05:6300:6713:b0:3b2:8675:4866 with SMTP id adf61e73a8af0-3bfed471c52mr6055757637.31.1782980868273;
        Thu, 02 Jul 2026 01:27:48 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f5c2836sm899047a12.13.2026.07.02.01.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 01:27:47 -0700 (PDT)
Message-ID: <8b29a6f4-0742-46f3-bc86-defa6e0faeae@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 16:27:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] wifi: ath12k: fix channel list copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4NiBTYWx0ZWRfX3EXWKohKH6SJ
 v4xONhHu3+4QC/nrZufhBfSefpMtyVRGTMYgNlCLlXGEcNf2j3cDkZqwux3y0G2FT6AK1l7uw+E
 BxyUcVSEBNb+5FuqGCSVm9HmhCUYnFSARAX2SDU5yiwliAs8ugOS/cMmFarXV+ovqiGWNPU1mcO
 dDJgm0ge7j7Vhdd3RPa+Geus6Hzs1MVarwJhVPIE6rafKrB2In+cO+mB/GyaFuahpOzqAihFfbv
 lMZwS6NmDCRhuEahg5Mj3o1y4Xn9suyE+wJFyZlyoST3BOlHO4Ypmgbcp80x34ldnpY01+jcmNK
 MmfZENcvMfmNAkEaMJ5u2hbG6QdFyh289m5M/lcoXVBhz5tU2Bjmx4Ffsv/XjuNM8kyEXIIh9T9
 +pAqps9X4z7z3878SFx4MnIBtoWN+ugy6wA3GsiYuhmJQeluaZSNpULL0UQynkW7KELGq4u2EMe
 9gxDWvdyuX2K+NEqRJQ==
X-Proofpoint-ORIG-GUID: qvrm_d0Y3g2JJ2UMLbx_Wt6J0fWE904d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4NiBTYWx0ZWRfX1gVV3ZSq5ynI
 lBIsAnuWm9u/sJqA7EwnIScX6feJeNuX9470sR/2lZTmtlLS4ygKK+gQtwTbIgqu8oBjsJ3DHlH
 bG+iDINoOgLm+9mdZp9BK0XExknDEak=
X-Proofpoint-GUID: qvrm_d0Y3g2JJ2UMLbx_Wt6J0fWE904d
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a462105 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=N9GNhs4bAAAA:8 a=ywX3x0iTvHv4trEmZJsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38491-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,westermo.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
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
X-Rspamd-Queue-Id: 19C976F4DB1



On 6/29/2026 3:46 PM, Alexander Wilhelm wrote:
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

seems hint_s_ssid and hint_bssid at the last also need the endian conversion?

> ---
> base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
> change-id: 20260317-fix-channel-list-copy-cef5cad24fb6
> 
> Best regards,


