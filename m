Return-Path: <linux-wireless+bounces-36261-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMe0OnEoAmrFoQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36261-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 21:05:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE3514D4A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 21:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119723037418
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C64C9009;
	Mon, 11 May 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LjUI3YTZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TIhg52Zy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175B44E027
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526171; cv=none; b=lmMRM2zNdR7v5rW1VLcfNW3I2xdekDjc0kBJ4d1gueQohP77bORLQLCpHQCoBUV4Xl+eQIN9meePPcgVuuJ/jjKkmKl6nqiDo45ETEkBW9kcUxMgn8X/JO37TzOC9IAZLXCY1jsEBY8YJRF05Ralazunn5Ss8d7PMfyT4Hr+ZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526171; c=relaxed/simple;
	bh=m9OAJXlTmnWaX5FCM1so3RbP9Q6zSw3FLjQaJS1Dbks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2XwUvuIoqMc55FwUaX5K5xYtIV7yFsLESI2DHej1Yvunan6g13Im4hSzNyL7YtPXxPd5/WgKbSQeQHVMkofNBShCDOE/sBUh8h1IkSOoHjzZo9XzMM13u7gmoHsf3C4I1+cknXuoK5yebZUyWjZvqYIU9+olcgot0oczApH6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LjUI3YTZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TIhg52Zy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BINVY11106444
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K6AYKxAAyxziRqLJJS3fTnBEpzVHpo8LX+0srwQemhM=; b=LjUI3YTZ/1aPNY4A
	G4ziUYssJ17TtnFeY9ukYmuI9mcCHSzdB/R7zKZ+fXEl7lnRIMxD3F5tA2Jt0Xdp
	pujjAinCEmcv1dqFi4nxX5nuBoR3R/XW8cuVTLZ7/M+3GArMxp4GFNhvfI4X7pXy
	4cYWyKjQIg1qmEYiZ8OoXEdDxM1bnmsslKotd3e3C4TUDEVeOiYcPYSXz88iWPdD
	eUVErf0Ko1lpyP+fmH+Fbho3nHW1uG5VUdZohCUK7MwGpZcilQmwAyLl5JGeezCg
	Cc6N5ZzkTzN63wynEbV0kyC+yv0boibvTTqWzDNzPZ0ogusPpyV0RH0vtoqJ9mNO
	0dz1Ng==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esr9tbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:02:48 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1270dcd11c1so9717171c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778526168; x=1779130968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6AYKxAAyxziRqLJJS3fTnBEpzVHpo8LX+0srwQemhM=;
        b=TIhg52ZyVRZ/yKqArDo8AbuJM57GpNHfQkLG9pgei9f5sEi7zGUEO1LAKLiwh32zZl
         bkSl865tHn/oILW4w5iH5aSfOtGD6sNMY/7Rj6RlBhVCIYBnhP6DaG5JjExWXEsyaD9B
         PFwvcgFELEAZpZPOQ+V+kx3NV6l8xhjZqEhL6zBUUJ7a0zBoGnq+hXRkeN9TL20C4c3Z
         zeYNOzBHwWOP77rYFqbiODfCZ3M1+aQ/LLfTE4oV9ZesuY9LzgW5NaaKoTD0jzsDZf7o
         EDQ9TGJnU6SBiepb/gfUjiuPQo/nky4YwzEdol94PKf8AExFPivjqdEHvZFZRpIXIzbG
         7tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526168; x=1779130968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6AYKxAAyxziRqLJJS3fTnBEpzVHpo8LX+0srwQemhM=;
        b=ArTvrsQ2/fBAOiG/a0wKJNhYturePDbdvrANoq9AHiL4DKqJe3PgPMJsre9HUhhqm0
         T+ZpxBw5gxZkaKXqvy1AjFUqpxwnbVV5vS2hwNDRJ41K03O2fRCezNJqEiKx5nPMmij/
         FN7LSbJjt3nNoqfFjtkzXdR/iDveGt63AIkWo9F62kn21ypH3HTvDMJJh24Yie1QWB7E
         okyh20R0ME8Z3JFFWcNA1FLcKRw3wKDXjDKIkR1T1vreceSbYHZMzvxwXI/b/tOeqzUb
         MZenxHr1KTdJNPnmUqSKg+TgpVXhGnVG1ydH6faa9Ka5g2pL5XiN/Joy4mV1L1edcLrh
         oIdg==
X-Gm-Message-State: AOJu0YzqDywOKSM06tdA4uaKcq83OW49kTjYGwQWx10HhtF3YAGsrN8g
	/HqmdA3SAH68mlOqtifZibKfuDLkiHPZVQ3k9No5Rlh0pBldT8F64PdjwH9/KyasYIjsGqGH/Bp
	lXseA1e5Ck7TIlgIOcTi0KMai7NGukEQTSgaVQczbZujb6B4S7RQ9yxViNnzYHAhVXoRbbg==
X-Gm-Gg: Acq92OFOvABXJHGxDZTF05t7ikd5NYBhe8IxgVeNnIHs6cCGFolHWxN3sJGAMSVOsau
	2mnqZTqwIqtXPgQLwTt7RfaHiJ7Chv043jdBxXa50xcCUBiGzsKznHTNkx2fZg5UL2Fd40rC9m1
	DoGR7lA8/QhlOt1JQSHPRqFTnWJJrfuWNjSGSecSmJBrvXfumVcMseVin4IU98juHJ6jDyXNpTE
	A6xZL8PnpNsDqyJ8buJUhIWrcUEVeRDT+ex+HAYV1+K9Gr+mpf6pqotlMobWTAZscVWEXDc4oQ6
	X7CVL02X21jhHA+GbkFEgL1gP1wrq4nMONkf1ENiac6LcirPV7tZGBmR2ttViiejDcAblBLdvzh
	h3bVEOl+TSw/CcVO6lHizUhBhDPxP7vjuNjgleTRyT94n/UwZ3QPfrPh5I2G6mATaDuXij10lTF
	5xs/2PO63uhBy0UQ==
X-Received: by 2002:a05:7022:1b0e:b0:12f:1f67:e747 with SMTP id a92af1059eb24-131a6af4231mr11030903c88.40.1778526167778;
        Mon, 11 May 2026 12:02:47 -0700 (PDT)
X-Received: by 2002:a05:7022:1b0e:b0:12f:1f67:e747 with SMTP id a92af1059eb24-131a6af4231mr11030867c88.40.1778526167111;
        Mon, 11 May 2026 12:02:47 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm19710428c88.15.2026.05.11.12.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 12:02:46 -0700 (PDT)
Message-ID: <89f30996-3210-403b-8c9a-52cf6d5fcb51@oss.qualcomm.com>
Date: Mon, 11 May 2026 12:02:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: skip unknown direct buffer ring module
 IDs
To: Nazar Mokrynskyi <nazar@mokrynskyi.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260505172415.566328-1-nazar@mokrynskyi.com>
 <20260505172415.566328-3-nazar@mokrynskyi.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260505172415.566328-3-nazar@mokrynskyi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 91ItF9V5aiZzBx50BUZVAut-KAiVOaaB
X-Proofpoint-ORIG-GUID: 91ItF9V5aiZzBx50BUZVAut-KAiVOaaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIwMiBTYWx0ZWRfX1lyyNzltoPae
 qmUVU7npKYRITrn5WtUfHcuJKuAZbUhZQU7A6ryTGWkf05uvJseX44+QGIAXwdF4f02OeAVmhxk
 pY8UFpq8f7R9QSXE4MzRRdhVD2cM+VXleQlI7k7aHzDqYrdI5IoXJbYoT2KIWBL6xPuIXb989e+
 Yr6PIQPyE6E5/RDS/O1L5rVVrs2gm2wnz+EV7WMP/6705XONbviC5YgvxsPdI/PeOwRkZiR7t0i
 0IoKpKjKOnT7iM3uxLpaNfMemqRDKNXbzEjcc+buf4W73XfaH4xQJR7httnP7BIgpAj7gs6gpr1
 0T3boh2m89Ssh0xb7rSfVqUizimXoW7W9TiHRW0BFl8jUWY9ICSbJHK5rjqwwlG0Q5KwnFypezX
 WZfN/N/XHZuU1mI4CXS/6563bq65Na4JeTsdY9IBQuA9N5DIKWG6xcmqowrkwHgGvcoI2vx3fHy
 F1DDX11PQHg7Ox+r8SQ==
X-Authority-Analysis: v=2.4 cv=G40s1dk5 c=1 sm=1 tr=0 ts=6a0227d8 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=TD6mGIVpAAAA:8 a=MjesTKNxIBkL7_LiPggA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=V7iCuLqznmuTtf2Pv1nF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110202
X-Rspamd-Queue-Id: 48EE3514D4A
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
	TAGGED_FROM(0.00)[bounces-36261-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/5/2026 10:24 AM, Nazar Mokrynskyi wrote:
> The firmware may advertise direct buffer ring capabilities for module
> IDs beyond what the driver currently knows about (WMI_DIRECT_BUF_MAX).
> This happens with newer firmware versions that support additional ring
> types not yet implemented in the driver.

What "newer firmware version" are you using that has this issue?

Can you share the "Skipping unknown direct buf ring module id" logs from your
modified driver?

> 
> The current code treats an unknown module_id as a fatal error, returning
> -EINVAL and tearing down the entire driver initialization. This is
> incorrect: the driver only needs to set up rings for types it uses
> (SPECTRAL=0, CFR=1) and can safely ignore capability advertisements for
> unknown types.
> 
> Change the unknown module_id handling to skip the entry with a debug
> message rather than failing, allowing initialization to proceed.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nazar Mokrynskyi <nazar@mokrynskyi.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 484fdd3b1..0e776a8d8 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -4814,10 +4814,10 @@ static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
>  	dir_buff_caps = ab->db_caps;
>  	for (i = 0; i < dma_caps_parse->n_dma_ring_caps; i++) {
>  		if (le32_to_cpu(dma_caps[i].module_id) >= WMI_DIRECT_BUF_MAX) {
> -			ath12k_warn(ab, "Invalid module id %d\n",
> -				    le32_to_cpu(dma_caps[i].module_id));
> -			ret = -EINVAL;
> -			goto free_dir_buff;
> +			ath12k_dbg(ab, ATH12K_DBG_WMI,
> +				   "Skipping unknown direct buf ring module id %d\n",
> +				   le32_to_cpu(dma_caps[i].module_id));
> +			continue;

by continuing you don't populate the dir_buff_caps[i] information below,
leaving that record with zeroed data from the initial allocation. Does other
code correctly handle that?

would it be better to have a separate count of the number of dir_buff_caps
records that are actually filled, and then update
dma_caps_parse->n_dma_ring_caps to match once the parsing has completed?

>  		}
>  
>  		dir_buff_caps[i].id = le32_to_cpu(dma_caps[i].module_id);
> @@ -4829,10 +4829,6 @@ static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
>  	}
>  
>  	return 0;
> -
> -free_dir_buff:
> -	ath12k_wmi_free_dbring_caps(ab);
> -	return ret;
>  }
>  
>  static void


