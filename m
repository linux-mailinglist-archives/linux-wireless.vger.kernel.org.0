Return-Path: <linux-wireless+bounces-38489-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sVXzDHseRmofKQsAu9opvQ
	(envelope-from <linux-wireless+bounces-38489-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:16:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 955406F4AE7
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:16:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GwcYpUnZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BISNpcv0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38489-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38489-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FE923017500
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF73D4128;
	Thu,  2 Jul 2026 08:12:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028062E54B6
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 08:12:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979928; cv=none; b=L5b8t4yTo1QH/+tho+xljHD8qklYmrYxHtkYph60eR8u3wIOCTGKLHtHPrGDAWVYnCTk+u4jJLXuUpoRSVyxNSFQp78ENfacLsGyJUa6k+U1xI8FGnvssbKolcVUJjLNVFKzeXCafBn/biiP7oBfwOZrJA5OK1l7vxdmHF+qZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979928; c=relaxed/simple;
	bh=hBfW1eVaVJwN36oy84l9pvJf63LCeiP5BZ+extnzSSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIvk2Vnkll53rmcGE32Nn+7eGem+DecfURmUXAz6UGiK3kJROpsYX4A8jBk7JUOD8utgqvOFfxIYwYPZOv4OnbSglGdpPuAi6DgMMHAVlUo0yb220O4ny98k7BUJdU0XKRSVM8da2pvQQ1LGv5VgZGrehRoYRl29pZsnT+Wr9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwcYpUnZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BISNpcv0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KJq63067584
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 08:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LJ/2x+XVHtMq89QE+QEJmdN3JjMlArDp2qzGS+R+kMw=; b=GwcYpUnZ3OLJJ2Qy
	9N0r4k9nRP6In/WpXlrzo8y7WMQij5X54gyX9c/y++Feeo3MvKrJ7cYnXQgQ2iz+
	Il/NO2CskZWD19BNojxCt/7nCVuTL1uMMbkSNQc/FuqYCYehzf1861v7JNyl4ZTu
	pN8NJ3VdFvpN7zcvhnAwPE4OGZjNZYLYRp8sBb9i+3/H5hq7EGt5LMvjH4uf7hsS
	9l6nJ0Q+6Jt0Z7zhrACJL2Nz/VWsscpjZrNvN1/zqNRliaj0hyN2QSP548ZQ//Kw
	ygc+7oAN6AEgvRG4xoQuhmqurXbYEw6e4ZYa3zZRnwNb/EJsKuD6PjxnAudsCT/o
	k8qF7Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510amjad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 08:12:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c9f0073e20so23047145ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782979926; x=1783584726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJ/2x+XVHtMq89QE+QEJmdN3JjMlArDp2qzGS+R+kMw=;
        b=BISNpcv0w5Bdikd4D3jB1RdBeZH8KoIgXz+FuZcT/1DnchhxdEqqmxjAjsad9FrSSW
         EeZtzRTafkern+DeOnF8RKx3aOiH8essO4YenS5X2i5izq1aOIccWYILXRTBeJ+GQTbx
         JAvQfQybGjcUz/nIIEmXyYQdqj6a6TYNcLBOFJGWzyEPwLpnKuGieAfff+6d9hMAWa3C
         9p0uNa+sCwLUSCfx+Mpak1/SqSI9H7jZuDoKtrf9Rp/vHEqHb+a1a2Fnh5nU2HMpMuXM
         Niz8I+G7ZcydPClmeHCt+upu+46Vft1zk1TYjRlSlA/qUCULaxpiLn58r4vD3zbTB6MA
         NBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979926; x=1783584726;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJ/2x+XVHtMq89QE+QEJmdN3JjMlArDp2qzGS+R+kMw=;
        b=dyvXa4DgS33O05a3XclYHVf2ZPtIB9Dvk28PiRJ36q6QgPuMO5dc5Ad8W7SfHq0uv6
         oG1TYWU2RR8RBIP+aLU0Q211KwR934+RnR4rU/H5GK565icLFs3v09EWyoJCeAyvBEQM
         ndgYDFZ1Fk43W0VyQiDktPlzeG40H91qH4EzEApif6D3E0+o+4JH0x3z+iY2b6R2WlPV
         tDqXIcahZ5YDRtQNcdYDeV1vzuc9nRffjoxL3Zuq1QFJcflLTLDMA57tkT6yTMS1NoCX
         otLBveAr01l/+bPW9TRXjgVgISBiPPyxnNso2KPGtMVbNUmCosv1xIHTovfyH1eCvpIE
         qrgw==
X-Gm-Message-State: AOJu0YzqBzSIQDNkqkjr1KwlrNd6YpHEbYLVf9q/cceH+Sb2MLykjNGn
	teq0LITK0Vibe4YayyL3IGQkDd8XmzvKFPU/Fru5L104NeMlZE2N4/rGEc4pOJFv1EMs9DPPrlX
	cukEwEnepzr4P9Do3k50tQ29w0VcYZqlUCvi0Veqy2yJXbt5xzg9fZ9MsMyIXVJJlJJ+AiA==
X-Gm-Gg: AfdE7ckXgiYVcqhEznDFl2YEcAoBiYhaVeYFr2bdIPcdbVvyANwa8EmuZYaZsys4OLa
	XIkdbm0grMYx+oDcTYc/faIRPnOC/MHM9cbQetzNQygYdV4YLpyfRLzaR87GOtz8fiy2wAU+ZdE
	v7XQ8HiPhaC294V723VR/Kdcb0aCxG6K3bP7spMniPEtkiEV+gBasYa1q47/GLOdriRP/feapKP
	OQeXi5h/gqfOnMVXMV/8r1ZnXMgR+KTo9+7WTDqJO8NA2aN/DC3g6d146tXAFxz4P+6mk0MzR0D
	7Ev8UsuGXuIQn3+iD1jCdr+0dsLWeA9Zdh6XagwClNMY9ZHjRHy6UA15qXyZR/NqdgOdp1MDVDY
	WIr5Kx1rhaEvaYplB4EJGwEpfj22BVEHQjKFcKaAzOgafF+i2umOuIHHZflRLBZ/l5jhbAhIh5w
	ttoYDRNKTi
X-Received: by 2002:a17:903:2ac7:b0:2c9:9927:a060 with SMTP id d9443c01a7336-2ca7e751e3emr51677385ad.24.1782979925526;
        Thu, 02 Jul 2026 01:12:05 -0700 (PDT)
X-Received: by 2002:a17:903:2ac7:b0:2c9:9927:a060 with SMTP id d9443c01a7336-2ca7e751e3emr51677085ad.24.1782979924931;
        Thu, 02 Jul 2026 01:12:04 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dae49sm9805725ad.10.2026.07.02.01.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 01:12:04 -0700 (PDT)
Message-ID: <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 16:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rxW3C7vc2IC1SYcBGdCgVXiGe041T3mo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfX2RekmycK+6Pv
 rmv10UYN2GGqKmVZTSHTG57nAoi+mNO2w4VXGwR6TTv5cBy+KvZQqzlhvcdppQnO/f/Cx0dwYi7
 zoCdsrni457FKMWuj+wmfPoTFSHd4Ng9c2VIAed1DYVsFvprFKhDHS+88FE/WdYpeR3ohshqkDa
 AWcyZfEduG4qgeoB3O8Mt8UztVnDBqtWgxJG95ybJX5ZWX6u//4xRKb18tFPeoUv7Jv+7VuVLJb
 CYq+noATd2RVTPo+YCb+/BhA4Pe35mZ3geGHwGTPNiCMROwT4NbiHY34WlsmUgFs1nNErYv/yxV
 ivntW60qlUpuInFhPJUwEtNlUpPju6Z60ORKwEXF+POqHGcrBtlnWNKcbuqiVfz0MclYfpnbqJy
 4N/GfqO+dzD1LwYhf5CEWqxMjYP+SMKCW7wx1iBp67YiHpo0NecljkzzJKl/nY6SLn4GwPzh/HY
 Q2td8pu2IVI7Peyva3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfXzioKkuOWPvuI
 VMRHu+kkxdXb8+VIg01wvk4XPTT6Y36jEd1M1F0EilO0Yvqzff3iffwEYQ1mkkOz4GAggAYJXvk
 5slqrWH56LTDujmiTjczpTr6Vx3fJpU=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a461d56 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=N9GNhs4bAAAA:8 a=ywX3x0iTvHv4trEmZJsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: rxW3C7vc2IC1SYcBGdCgVXiGe041T3mo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38489-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,westermo.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 955406F4AE7



On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> CPU-native data types into an u8 array. On a big-endian architecture, this
> later results in a null‑pointer dereference. Convert the data to

Alex, did you find a time to investigate the root cause of the null pointer?

> little‑endian first, then copy it into the target array.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index f8cfc7bb29dd..50957915dbf4 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -647,8 +647,11 @@ int ath12k_dp_arch_rx_tid_delete_handler(struct ath12k_dp *dp,
>  
>  static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
>  {
> -	memcpy(addr, &addr_l32, 4);
> -	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
> +	__le32 le_addr_l32 = cpu_to_le32(addr_l32);
> +	__le16 le_addr_h16 = cpu_to_le16(addr_h16);
> +
> +	memcpy(addr, &le_addr_l32, 4);
> +	memcpy(addr + 4, &le_addr_h16, ETH_ALEN - 4);
>  }
>  
>  static inline struct ath12k_dp *
> 
> ---
> base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
> change-id: 20260317-fix-mac-addr-copy-on-big-endian-f1a4fea40184
> 
> Best regards,


