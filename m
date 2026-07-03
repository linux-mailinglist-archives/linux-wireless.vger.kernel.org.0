Return-Path: <linux-wireless+bounces-38571-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 42y0Bwl1R2oRYgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38571-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 10:38:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1F700293
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 10:38:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kmxcBCvy;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hCsITTe0;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38571-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38571-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B325531B2E01
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 08:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7830B53F;
	Fri,  3 Jul 2026 08:18:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938C3019AA
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 08:18:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066720; cv=none; b=aryUChILjfv9YJUqLWYQDjFctyYQtiVm82kkXqWQAwxHPZvTDS48scl/caEib1qsKNzxmNYhAw6LGpFzVjkunYnNN9EjuFWKwxmXyI8N4NYaEQFuYddtVhyXW195axmdPBwblqs6hoUoN6QOWTgwY7Ug+OItpQL+iTvg2bgn/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066720; c=relaxed/simple;
	bh=t3T/hQYXc+9FpXSIk35jQy2Xcgi4cKGIGBNDh2J2ARU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD6AXmdt6u4Ykr4Omexcj7mlghIfRfazqMFbBY4d9woYIyW7NIfdMD9f53/rOZNL1RKpv8Udul722+jxGfNRypJ29m7w8c+LwL0ry59jBjJx637lRVGEECpwv34NVzbP2iC60SUBXQoWrriahFxSJ5JV0/qy5TCoh825L2alZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmxcBCvy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hCsITTe0; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rjBp3134747
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 08:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XwnRVOxgKogi71l6aiWlYjqOlv2v06YgcWQWPZimHNI=; b=kmxcBCvyMaU/p+kB
	zzhEgZ4vWZgVc2/mt9f5A5HP/igM3oFqpfHBsS9G2827jXqzw2aRmY0fwivmmvOt
	Kbz6VcaZEAknQfvfFjIYke7BARBbnS9RyA59Xwpwt3hAjJUKNODzjgenYMpUu0XQ
	XoHXW3Fbp5NxXi3UFM2Xtg33Y/tdFVGXIGXM4HTQe6B1FHQ76GSZUWOF1JJg/h6v
	cvQlYA/dZ7mTkjunzLh1K7grMzTUMsM5DzOKOoHwaDfb3vz7tsCZH/dmALnH7KFx
	fmv2ayRJpzosYP5i0CRjVL8dBr1kqrqaHQAFGIrmbX238dMrT+rIy7QQPFdOHRce
	QqFFwg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qch48j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:18:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so760087a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783066717; x=1783671517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwnRVOxgKogi71l6aiWlYjqOlv2v06YgcWQWPZimHNI=;
        b=hCsITTe0Y3+XvbFr+8Mjql6YGH6kcZIcslgGEhs8NDwfcC0Jx/kQ0WwI6+V16JHavM
         YbdcQtVWBJov0kKsrvpEw6wmeleM0hZteJlkpT6fZC6ykFvsd1DlXLuiPRTkiY7d9Aba
         m3FrxEwxmcovBF2zhFWVt1YfPwFv+Bu7Yb+0Nwf1tEtP5RicU7qExRfLGsgQx26AZgq8
         oupsvmo1emompjbrP3JCeq3To4xuchg1Q/34Q1V84sxkjcGn3NulIZvH6Qqw60Ot1SmS
         yYcq+++Ge49U/5GGJ5cXS6HIumUpWs9X0MjTdDg7UddUIFnWZGAGjrI0mashnyzvf66G
         lnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783066717; x=1783671517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwnRVOxgKogi71l6aiWlYjqOlv2v06YgcWQWPZimHNI=;
        b=nvlqknbQnZoMEjzLkcy+GW/s+pghnFtqHLi8wG9l8Sfn90icTbjECuMwct0NSvT57n
         MVeYanOPPaSmReapqm1+DIulLe7QtV0ZlGW+GHDjsRvFH5DxqntOpf0ntLV4CM5DuEao
         F9VQ2t/zIlLqe9I/svgBPbOrGIDsYtGYScBvvIsYmGqdjhnOKgV5UKo9guOIt4RvXkvi
         Txn3Djls4lWmQvQ5GGYfaW9i6K3oPSCqBmqBT9RTEOhaa61crx9S55pWk6rquy8gdLek
         jOXWfFL5MhhPQ+q9JANU/J+xAb1P2RdsxP4AzuiV+5QJrdJqJ0HBiINRZffcK7ut8b4w
         n/ug==
X-Gm-Message-State: AOJu0YyohTDYIXFU31TLV+YqsJA7Xs0quaz0Q1+IztxiyXQ9XMEkZ9y7
	gk7101OFnbMZqaChuWBEo+H6ZiT4kWhaZcITanHJIQ22aGiq1GAS2qs+4kHPzoQdJmEmxLfLkJQ
	3EQiSeWUi0nLlsAO120vNW4CKLXw9H+Vh9UdIDtnGSL0LD9WjAufP51fIXDyEmsjGIlzsiA==
X-Gm-Gg: AfdE7cny56xh/eMDzKyjYoC6nGhiEDx6KsByCEJBHY01mxZegbGk1KVWHt3MMctKpv6
	urHluF0YlHiz4YzuDJmGUO3FDLwdWYxggJD1p6vBeBT+ZpIAeikPGluVyT/KeYyyqSVbLunSAdJ
	Wjs8iyZGg0ulVifdsfHDxXUJo2vM8ZsCmbTtsdo/N2HZmIb74VyEAQgo9a+4WHhVNMrc1yF1Yo/
	+kHBt85fn2LLqeacFS2TFEm/cDnQxw9Gr8aABmI8HPYCTEGri0pSq3nt6l5YWdchkewxKr6SkDK
	oylTflhjrIAFJ7ir2SZ/VcPXBEDgDqGEC8LD4krs7hkQs1EDsuNT+XboBgl9wdB/kaPeihXwQYa
	54aF/i6OHiRDrwhdEor3sky+44PTNxxE7DxoFiQ59sEn9rPIcr/S1RWGMhxBgmhimPtQ7WI8riT
	PA7RoNqRJZ
X-Received: by 2002:a05:6a20:ae2f:b0:3b4:b2d7:c146 with SMTP id adf61e73a8af0-3bfed2a2cc6mr11509192637.21.1783066716807;
        Fri, 03 Jul 2026 01:18:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:ae2f:b0:3b4:b2d7:c146 with SMTP id adf61e73a8af0-3bfed2a2cc6mr11509150637.21.1783066716310;
        Fri, 03 Jul 2026 01:18:36 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0ec6bsm2322108a12.7.2026.07.03.01.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:18:35 -0700 (PDT)
Message-ID: <afbff608-a005-43c4-af76-968a58bf0cc3@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:18:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix scan command endianness on big
 endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260703-fix-channel-list-copy-v2-1-372c39306d79@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260703-fix-channel-list-copy-v2-1-372c39306d79@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2_riTLGgjQGkcOhouGPzswSnr2BU-Es_
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47705d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=N9GNhs4bAAAA:8 a=BEeBCuFZ1JbOFoEgvSgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: 2_riTLGgjQGkcOhouGPzswSnr2BU-Es_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3OCBTYWx0ZWRfX7Vy90wIx0M8g
 5FafSM2Yd8mQXpscCsNtPpJYXUic7iCO9Gc5cV7zUhNN9qF14UAgCMPAcIUAbA8sSo3zfSLFMmy
 m/jaB6N5ppo1Xos3u6HW9gqTgdk82Fru3S80JZbPqsmC5tF8R1gp+TtdpE0XiMxTRt2EIwbVsCx
 V3Rc2OydCDiUIq9aAUThgvI0evVagE+q8kBAL0kfYOmyx1RNYpS5MhBIQu+QQmb3+sP+QWyL/uR
 MtDl67nHHH4b11hH5OPmhjv+C/DIm1GmxbOAqZwXfPPStXO64xZ9byzTn5NSlOSanm7hPT0i5Xe
 fAjGQ47J3NV8/SuGjNX8V1RNKRZ6cJ42ILdrUaL0SNs5PqvkF3vir9QjKo3rsYK9956XbQKnoBt
 nPa+CXV41yOPkqF1lHBKw7zCgodhIKvQnj0b/ZTMJckTkwlw4XP4cmuw+i722BYApt0AIs5ioYc
 qafBzSdBcYi+QUczZlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3OCBTYWx0ZWRfX4gFVkQdjGLep
 xhqUdE1w1sfMmUZAcjVRzcx/D0GRu1Bp5A4/jcyXNFd1JtpB1ElOvFNkvEqfzLge+Nt+Sj+VULW
 /WXeHVtwn9o+sg1ziyhaiAIHAlPlcrc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38571-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,westermo.com:email,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 83C1F700293



On 7/3/2026 3:35 PM, Alexander Wilhelm wrote:
> ath12k_wmi_scan_req_arg stores scan parameters in CPU-native byte order,
> while ath12k_wmi_send_scan_start_cmd() writes them into a WMI command
> buffer whose contents must be in little-endian format. The existing code
> copies the channel list and writes s_ssid and hint_bssid related values to
> the command buffer without endian conversion. As a result, scan requests
> contain invalid parameters on big-endian systems and fail.
> 
> Convert the channel list as well as the s_ssid and hint_bssid related
> values to little-endian before writing them to the WMI command buffer. This
> preserves the existing behaviour on little-endian systems while fixing scan
> requests on big-endian architectures.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> ---
> Changes in v2:
> - Rebase on latest ath/master
> - Use additional __le32 conversion for s_ssid and hint_bssid related values
> - Reword commit message and description
> - Link to v1: https://lore.kernel.org/r/20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 20 ++++++++++++--------
>  drivers/net/wireless/ath/ath12k/wmi.h | 10 ++++++++++
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index ad739bffcf88..4dab6eee80a1 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2637,9 +2637,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>  	struct wmi_tlv *tlv;
>  	void *ptr;
>  	int i, ret, len;
> -	u32 *tmp_ptr, extraie_len_with_pad = 0;
> -	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
> -	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
> +	__le32 *tmp_ptr;
> +	u32 extraie_len_with_pad = 0;
> +	struct ath12k_wmi_hint_short_ssid_params *s_ssid = NULL;
> +	struct ath12k_wmi_hint_bssid_params *hint_bssid = NULL;
>  
>  	len = sizeof(*cmd);
>  
> @@ -2722,9 +2723,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
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
> @@ -2780,8 +2782,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>  		ptr += TLV_HDR_SIZE;
>  		s_ssid = ptr;
>  		for (i = 0; i < arg->num_hint_s_ssid; ++i) {
> -			s_ssid->freq_flags = arg->hint_s_ssid[i].freq_flags;
> -			s_ssid->short_ssid = arg->hint_s_ssid[i].short_ssid;
> +			s_ssid->freq_flags =
> +				cpu_to_le32(arg->hint_s_ssid[i].freq_flags);
> +			s_ssid->short_ssid =
> +				cpu_to_le32(arg->hint_s_ssid[i].short_ssid);
>  			s_ssid++;
>  		}
>  		ptr += len;
> @@ -2795,7 +2799,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>  		hint_bssid = ptr;
>  		for (i = 0; i < arg->num_hint_bssid; ++i) {
>  			hint_bssid->freq_flags =
> -				arg->hint_bssid[i].freq_flags;
> +				cpu_to_le32(arg->hint_bssid[i].freq_flags);
>  			ether_addr_copy(&arg->hint_bssid[i].bssid.addr[0],
>  					&hint_bssid->bssid.addr[0]);

the src and dst are wrongly swapped, should be

ether_addr_copy(&hint_bssid->bssid.addr[0], &arg->hint_bssid[i].bssid.addr[0]);

However since this is a pre-exising issue and not related to endian handling, not sure if
we should fix it as well in the same patch.

Jeff, your thought?

>  			hint_bssid++;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 51f3426e1fcd..52e6068d9a64 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3556,6 +3556,16 @@ struct ath12k_wmi_hint_bssid_arg {
>  	struct ath12k_wmi_mac_addr_params bssid;
>  };
>  
> +struct ath12k_wmi_hint_short_ssid_params {
> +	__le32 freq_flags;
> +	__le32 short_ssid;
> +};
> +
> +struct ath12k_wmi_hint_bssid_params {
> +	__le32 freq_flags;
> +	struct ath12k_wmi_mac_addr_params bssid;
> +};
> +
>  struct ath12k_wmi_scan_req_arg {
>  	u32 scan_id;
>  	u32 scan_req_id;
> 
> ---
> base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
> change-id: 20260317-fix-channel-list-copy-cef5cad24fb6
> 
> Best regards,


