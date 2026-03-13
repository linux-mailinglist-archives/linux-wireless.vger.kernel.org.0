Return-Path: <linux-wireless+bounces-33185-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD4jNDS0s2lYZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33185-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:52:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E56D27E5F9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE0130D7DE6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C533F8B4;
	Fri, 13 Mar 2026 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aGInq14/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O0qJr9T8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6B25B2F4
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384624; cv=none; b=iV2zM0cy1HZodxDiRzoMY0oAVsHfE6jucWAf7ciwH1seVCBbnetnsc39vSeRKBGLSYGgBZjqFv1sv57vWplamtY6CIgyUYGdtLGS3W7tqbZ4nkquYLjgHwk1YhyPiOE6bWy2SCWR+aP3puyxqYG0DNpe6hRc541JNP/iel0dOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384624; c=relaxed/simple;
	bh=5fWz3X5WKVVwHwUWS/HjYoWztWkHRpBfUveFqWGcz/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STUcXFeFFS/m3NLPXyuWLDJCaEvCvSO3WELLFzDRdpgcMIWEJv/9jPEPnSqzFZXUJ+hxn3OA0QkBjIWBvjrxaSCNR8ngibNEB2/ArKmIyYdj2AkAa1UPd7d2GZK0A03T1Ht+rIdXo3KVimlapf4TuflUAHZlcHOHdeowMIobZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aGInq14/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O0qJr9T8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tZC13229784
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c11wsmz5XIkmIWHXb5uA+V8l
	dNGjY2veRXDnBRS0QwI=; b=aGInq14/byGCOzv3tsTMhCKWaiSwvd/pEn5dbOES
	ko0+Bs2cEpWhpo0dLIsiTEB9sUKYiwmTUYmSgbslKM+rvCPWTS0wlgMlURYgltfV
	evrC3cCZtewgOK6TEByWwAfWEBp//baAr9dpO3j7SSbKCjkmIT+XtT5v2sfyh31A
	ZreLrRytvDD5jWlOf+ps5vGAx9hgp80yxTA0VDbSRSOBtUmQjHYNuTuhxSvkUTZQ
	/nxeDB6A5N9uLb6R0snZD9UhPn7eWBfRS2qUlDbElFTOOnD0TYngE9Q7LGn98cZI
	bW4Z7dhUS6Ii/2rde5cmdNiIZAxeVwSj3WwRqnuvda67Xg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7gwqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:50:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd7fec8d44so1238801285a.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773384621; x=1773989421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c11wsmz5XIkmIWHXb5uA+V8ldNGjY2veRXDnBRS0QwI=;
        b=O0qJr9T87y2IoFmT57OoJpHXZLxhnJm9miOzG/udjVDu2RyowJ+SlI8ZJ2ATGzlmRL
         2cNy5sRFMZ8wb8h2TjRfSE6//pF0afHCBhIHUM676Y9CXYYxWXKj31d/92YBz63WOdrY
         jZMr2mAJN7hfc8WeHllRNc/YemLMRu4x+RMDX/Z9iw77N6hTUe8p0wELTx2C9Ae7tLS4
         QzDvWBT2j8GzMBFH8y1xLuxEgLbb86Er7zq0I3tK7/X0EKm1UnzKWQ1m0lSydwrQcsqi
         A786XjzGuaokICbBlfaHheZ5REP8jr6Ce4Q3VJvPUqvv7rFwqowpZKuWm/JDdd7ULAMl
         qGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384621; x=1773989421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c11wsmz5XIkmIWHXb5uA+V8ldNGjY2veRXDnBRS0QwI=;
        b=USKSmN7a1wcVfVklEFJF8xniYv0wdcFt4zZJ217DeeMaDrbm7Lt+Nz2VXSE8HPgnZR
         wuNurBRCI4qZ3XTnyLTRK6uNm142q2WONdC7974dsPWDB4Hfl44kgdqSF1058+sOwHSV
         FMBfpyAlsiBB7Ihwb2bk7jXT9bvX6crV6jEX+IuC4wl3S3jT6Y58HO6Pyo+It6hUI03F
         dY8/xhhfGFrVBx4SzsGu5HU041TG+5LA+/vWEL2g9UhgcERXc0059qYKeYtsigI0xs4o
         SfVj+mKydiJD7JlZYPDxOw3jzOUBI4Tao8OzsgzDhFS61SumAtSnddrvc73NZRB1eB8Z
         Hsow==
X-Forwarded-Encrypted: i=1; AJvYcCUNDjrRyqmvRmUlSuKG7A+TiZXI+g4W+UgM7AolXDkEi2h3u1vh50TvIOrDkf3ZtQuZij/NhM8gjYDjXIN2Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIF90oXTHxpQ9P0f7pBai0FuZ9reShkR+qEGBWONaRiTFc5B9J
	28QdhscL54cBIoggBrkEiKkQ02HCKP1BtHlEyrArG3AQtB7AwoEy7nhok1iqadAujPuwotBnmi/
	Ldx29CepqA6lcvJ+vhuNR4WWu7p+KbAI0kia+/zu5pnvDNVdIXzHVm4bfseQXNYBOKX7rzA==
X-Gm-Gg: ATEYQzykalpb/NUPy0UHptO2SKsq/NAeoIPfOz9TDoMgGjjnhm3Z1Qoa29ziUH2bCuC
	C2sbxPjN6PnaoEuh2X2FSt2LskmCVqcUcctc7BGZNft0gJqeEpU0HHORqTtXTGpp5qkXDZsGSXw
	C8CtpgHS4a3shjXgN2Sl9hOUrFT6vQo/xKhmOS0JszWFjV9cmZxSq8CAq3c33c/hTAHb7cA54eY
	1qJMTh6L7D0HOEvvr8Igy/lEx5nP4xvjbyGqB2yFacOHrf2Dny09XUTo4MrnvmEVS2v2y2mVeMj
	2cuveQRPF6v8wKQCPwmXN0HmIAkxH4ECzozO+uuXwhIq7+SDiqbiusFdigh/XqJrOPCxSFdG8tO
	k+c/7EQIJN2dA6Zcvlf/N0KzjdkyDw8dnvgs465mp0j/jX1Lc6UcbH28SrbEgQbmTH8nj+919N0
	K+KRfhB9bOgYis7cdX3GHiWdxFI3PlbkkpRl4=
X-Received: by 2002:a05:620a:470c:b0:8c7:177f:cc1c with SMTP id af79cd13be357-8cdb5a060acmr316353585a.16.1773384621569;
        Thu, 12 Mar 2026 23:50:21 -0700 (PDT)
X-Received: by 2002:a05:620a:470c:b0:8c7:177f:cc1c with SMTP id af79cd13be357-8cdb5a060acmr316351685a.16.1773384621140;
        Thu, 12 Mar 2026 23:50:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e2e1sm1354399e87.24.2026.03.12.23.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:50:20 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:50:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: JB Tsai <jb.tsai@mediatek.com>
Cc: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Michael Lo <michael.lo@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>,
        Chris Lu <chris.lu@mediatek.com>, Quan Zhou <quan.zhou@mediatek.com>,
        litien.chang@mediatek.com
Subject: Re: [PATCH] linux-firmware: update firmware for MT7920 WiFi device
Message-ID: <xofpo36rayp3hfdpexh2f3bwcho3f3fea47llk4cqnoi7qteli@s7neefdrmuc2>
References: <20260313005635.2853784-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313005635.2853784-1-jb.tsai@mediatek.com>
X-Proofpoint-ORIG-GUID: DJ6MGi6iTUFWFMjmOYImhCUNBpGQXLEU
X-Proofpoint-GUID: DJ6MGi6iTUFWFMjmOYImhCUNBpGQXLEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MyBTYWx0ZWRfX63LZUwQOsikN
 IOA9eEnvglJrn38pXKvZXQqT8s0C3o8Xb2bherzaIh4G3Lb8fm8SBW7bmQLO/Tf3eAlEk0uMPCv
 5BAjYvEaSq9uBQStdmKb0Nkyl8VQAZDQViLqA2XGBtiNfqq35InTzb8mtw9f3e83kAiZ5sSVYvG
 1W1150XI2sMO/Uwxj+QfLKX/9pvsuSVLT1e+JEDmtdYpRS/80hNO9mMo9VdXJ3pwvndnSCudl2+
 Mjp7oHtqyxEQ9T4iY1KFn8MjN93EPdAJuPIom2H9lMdqGK1xJY7vkx0A5UiNkAkP9WAwIRiotm5
 4DpWw4yFsWJPy1MENXoXOktItHvsIzTJGwMShEefc75Q1Bh+9NiEAAzA+p4R0SOBnscYIDrHL2Q
 HGAsgznuwzJfSRCbmRLbKKkA7QPwP5oIMX2fLdJRJkNJs8XjGlvLdh8vVnoAS+vAlijf0MHQw7R
 IV5Bg/KewFEFxrd/j2Q==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3b3ae cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=mpaa-ttXAAAA:8 a=Tdx_NzqeC2gGNTS-E4IA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130053
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33185-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,mediatek.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0E56D27E5F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 08:56:35AM +0800, JB Tsai wrote:
> Update binary firmware for MT7920 WiFi devices
> 
> File: mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin
> Version: 20260224110857a
> File: mediatek/WIFI_RAM_CODE_MT7961_1a.bin
> Version: 20260224110939
> 
> Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
> ---
>  WHENCE                                      |   4 ++--
>  mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin | Bin 100384 -> 100384 bytes
>  mediatek/WIFI_RAM_CODE_MT7961_1a.bin        | Bin 802744 -> 802808 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 

Thanks, merged and pushed out:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/958

-- 
With best wishes
Dmitry

