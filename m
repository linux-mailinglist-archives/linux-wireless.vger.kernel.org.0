Return-Path: <linux-wireless+bounces-33778-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAJrJTalwmkyggQAu9opvQ
	(envelope-from <linux-wireless+bounces-33778-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:52:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DA30A830
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40623306586B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967E388385;
	Tue, 24 Mar 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hpANTLwe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PoVcSApC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6435DA69
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363801; cv=none; b=Hw1EwSQlpsMct+vGFwKREjAx6enkLUCDzCbji3NUsdRePTVlS9WFCuSfFo/1ab/vqrp9KX4r9lrv5iW/tnyOW4YnKXfXh/tAjmu1QDXSj4VtY7MKlbsnHqXGa+SCWRXl5n1+itJit518DQKW0vd0PEbbJOu86ubO1yc72lk5LZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363801; c=relaxed/simple;
	bh=hxnTqj3wpRJRKiaFSZGSYoKxFrIGxxEtFtX6TVqnXq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uk7JX/vh9uzYjmqCmcar5IcRRu7LvIa7qolf938QacE2JbXddiMKYZm3DVylmpnryDlOTmONr4CcZKSnj83VPrAHsbKtKBc2BzKaEL2dfHWirorhl7kCmitr1mkZqMkkKMfxXK1Urr94cTCyYuLAwShFHN3TfoTK8Lz4iMie9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hpANTLwe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PoVcSApC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9gO1L3903935
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bN1tyJWjxegqFibgFLwfN55375RZb0iAQob5xeB1x8c=; b=hpANTLwedWXSq1j4
	xjFK3PBjX/sXEa5ysYIfVXuXnFjwKJ+C/4OVJCAzIBYUF89Kw52c+Kb0mYkNKnS0
	933qSl1s7CuwN6buVjWQyhNorLgOkrxAEovKqXK3yKx+yFyd6QVCVJnUJ5xYWXnn
	TY45hpHQ/0njCNCv2bX9PtjO6acFuJIPdp9/GRBuweHYk6ib6sy2Nj7QI0eW/6Mg
	VaQ0Z/ExUMdFrtghX+zu1/wmSDZ1th/doab/zw7yzJdr6jWUOfW1xt7t1NfrlYyS
	z6y5G7VGlPImDguTFqqtK+nMJrI4qz1EhaDRfdc1grI/Zbs41QeoOSLamqjDQocw
	dXtMSg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0jemq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:49:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so1349461eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774363798; x=1774968598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bN1tyJWjxegqFibgFLwfN55375RZb0iAQob5xeB1x8c=;
        b=PoVcSApCIdV3FkMeW3+K7N/+4QGNNM4vNRJaXKGDV+HGMZcSlgTy7VwtA0s6e8icm9
         F3P8qAmU70FcaBohfIzEtNKqeEVWjXGkea8giyNZSdCJENZAsylWyiezZRtNZ+rfdrGb
         EXXVUBOK/5WG2IksLkVWQ3doyaH56JRHV+RLsbff1PEkrsnI15cQMuJmERLUoD4mujw0
         bXefDQx5kKIw2lz8f0ogTDQjdETDelBZ4Zk56Rzw5JXfCLDr+/4oO25BmE8ELiSV7Ne4
         QUAdSyrZ3FDJ3yDFsH/4fWQ6aS26hzqleBKWfMoaMsxHgUxbgvCnkUAb2YDutmXDklS7
         GE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363798; x=1774968598;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bN1tyJWjxegqFibgFLwfN55375RZb0iAQob5xeB1x8c=;
        b=Io4WCQLruQ7uaZdUKVQQUZUYSJ9g7MWaWSk9OMOFlErohTrXEa5Q86GtXh8P7v7n2s
         diNgUszDv1sFUCf5d+FOeWK/TmA0cNipKp63nVhX+yqrW75tDMhjUTelpEqTXqzcFdOH
         AqhOMcPAHEnNZBPJmnIhVgYHo8T+SYKA2Z0eu4npybQVKKBUo7q+xFml7/qw3D5gc3DC
         ItRyH6P/8Z+sqqy5JtaQUZh2iBnLutOm/2uYKa7Rt8c1UL3BgiPSsMvIXamPEyPDpKX9
         5qUBFfDl9RVnJ1e0PTBJH5A89hhRwine83XTxxvOE8PgR6tJfDBOz6kjqvp7mAyaPwJO
         HrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrdTP8du6lOLuInXtnhfVGYMTOEOC8HNQunmMwtkrfS8KEX6sq9teiU77Nq1Wm1jWpdrldMx4yCiTcekrIzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxovl4gF469i6rig+X1j0tMqQxQNulF7bQJcnXyWT/CrO3zc8N
	rF2xr9UbvSZkJnHUNTXKPSTYSFFalc8kp4akN90byffG3rlXIRCJw0nFGQjPjv+gCwfjAhFdVIo
	Te1hlgbQ5AA4Qg8i8Q+4QL6apGUsCgxGRIUxdTJjHmV9mySU1i6ALTh+ffIHNitxLlTwdE0et0m
	OBrA==
X-Gm-Gg: ATEYQzwhWSC+HKOpqn0f97hayJdV0eCsIlpfkwyNras1IE8bf7QbjV6CKhJPViuPJ2I
	ygf9utZJZUGMm3OVOZxTQCxCnHzq6q7xBhE0StApa1LbZcFHrNDkbb5UVYBB2kMa0chTKzE5pRw
	pCwn0dFHi6GWUc3iOHLqp72iZaEytKJXz3/egTo2Hvz1yssWHz/vjfqXWiwIAv3XKPAp27EDeQk
	jjUq48LhKWTKAtWl+P4p23AaWtLR9Lr1LgYiJhU2VpYZB170Q+gl8709yIWY7TqOp3BKH3WQfvq
	RUsvvz7OkAEoaH+/X5P+TzLeaejiFvW/PNPaMnOLFipnuPQKFFcMy+/hYlnx/4DSzRw7Tonc22X
	8xGgZ8CcFDkbhIku1wVyucqCjl7QT3kzKiILrhKKRhOZaTvKdItRxHIHSLtDx58wGiLn30jQye9
	YRvl5VaQ==
X-Received: by 2002:a05:7022:f00a:b0:128:d39a:b141 with SMTP id a92af1059eb24-12a72654adamr6942374c88.17.1774363797771;
        Tue, 24 Mar 2026 07:49:57 -0700 (PDT)
X-Received: by 2002:a05:7022:f00a:b0:128:d39a:b141 with SMTP id a92af1059eb24-12a72654adamr6942361c88.17.1774363797149;
        Tue, 24 Mar 2026 07:49:57 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733b4a99sm11426379c88.1.2026.03.24.07.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 07:49:56 -0700 (PDT)
Message-ID: <accee45c-7cae-48fc-b868-b7404b8c061c@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 07:49:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: fix u8 overflow in SSID scan buffer size
 calculation
To: Yasuaki Torimaru <yasuakitorimaru@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev, kees@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260324100624.983458-1-yasuakitorimaru@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260324100624.983458-1-yasuakitorimaru@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5-kV1ALr-tlXwZ4UGqZX3Hilvg3cLa8N
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c2a497 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZZREMoF7B9XdSHzJcukA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 5-kV1ALr-tlXwZ4UGqZX3Hilvg3cLa8N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExNiBTYWx0ZWRfX/KwM10GpH7NE
 23StYJNYcjvn9Xi5ZhiTwfUnPG2lqHEziXR9ypmMgkfVyQYlwUQnUPU2wBHhTx4RduyYVxU2fPf
 3GLYV9ew2y2lzCf7pe3dwJSRkFgukafC4QkWXoCkCln58TSpxaqZCfKORS/VnM7CGWgoW0Oz4zP
 3iuWLFbGIZDiZBR0DJhjQd/e4lwbUAsXs13SDe+5fJKnsKB6ErSVU6QG/vHNNryQvJsoP2YAdxf
 mJvIE/Mut8ju41kVc4M0tDBxiLyCx5FiOH64zjadB3HicU3fL1D0kGyL9RuYcr5psWXMURC2p0a
 MqqtR39RmDwwkf+WlSMuJXKu7dthTDLMa2fQ/ioUeakd7r3ErOcAXB7g1EGP1/jT9HuGtHBnSHx
 7XZ+B7JoXv3V/xmVFbeN9zuzVmZKA5/X8Vh4iiceHX3zyFRSrHyBGqKPArMt97Pzspn+Dj5skod
 D9pzeRdjmhuVURMdu5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240116
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-33778-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E1DA30A830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/2026 3:06 AM, Yasuaki Torimaru wrote:
> The variable valuesize is declared as u8 but accumulates the total
> length of all SSIDs to scan. Each SSID contributes up to 33 bytes
> (IEEE80211_MAX_SSID_LEN + 1), and with WILC_MAX_NUM_PROBED_SSID (10)
> SSIDs the total can reach 330, which wraps around to 74 when stored
> in a u8.
> 
> This causes kmalloc to allocate only 75 bytes while the subsequent
> memcpy writes up to 331 bytes into the buffer, resulting in a 256-byte
> heap buffer overflow.
> 
> Widen valuesize from u8 to u32 to accommodate the full range.
> 
> Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Another thing to note is it is very strange that the struct wid that defines
the TLV format uses a signed type for both the TLV length and payload pointer:
	s32 size;
	s8 *val;

I don't think I've ever seen this in a TLV representation!

> ---
>  drivers/net/wireless/microchip/wilc1000/hif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
> index f354b11cb919..944b2a812b63 100644
> --- a/drivers/net/wireless/microchip/wilc1000/hif.c
> +++ b/drivers/net/wireless/microchip/wilc1000/hif.c
> @@ -163,7 +163,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source,
>  	u32 index = 0;
>  	u32 i, scan_timeout;
>  	u8 *buffer;
> -	u8 valuesize = 0;
> +	u32 valuesize = 0;
>  	u8 *search_ssid_vals = NULL;
>  	const u8 ch_list_len = request->n_channels;
>  	struct host_if_drv *hif_drv = vif->hif_drv;


