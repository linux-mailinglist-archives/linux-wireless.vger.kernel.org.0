Return-Path: <linux-wireless+bounces-32135-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PDZGKXr7nGmtMQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32135-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:14:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA51806D4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2923046036
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 01:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860522A80D;
	Tue, 24 Feb 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGjEp+WP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O6Z9becI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918B145A05
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895671; cv=none; b=a7kNl1qNdjRnUbqm8LtHSOZN0gbQhx5CYnKRMfLjU0txjTGAGG0Gc0ToP2GSoP8CSHGE//kl4i+cAcKuDaBcmj/2b3QYAirNYEV4HEmfXRNvro4oA7orjZiVvtM5dgI+0Shp9jaisfjPSF3kPcimnSp2q2Iqe2abqpBB/4gWq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895671; c=relaxed/simple;
	bh=L9FKMCy/xo2RvBZk3tvZrnUwezvvh82AolLJ2st6ggU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sc2jWnO7OQjZZPcRquyv6cttpjL2JVnQs5JY3kynSCb5WJRPwNjU8DWnnGScw3sNoMjAZbBoQC2zsDc9uzmMCFVRasnEGgdE60wMrbBiiSHpzwNbzO/yCjfMFko4ZXKk5n+72NW+3lGKa2fr/MZYT45UF0Toed9nuQkd13W/iqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RGjEp+WP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O6Z9becI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NICCYZ3732751
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 01:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w1/kowcfPiZ63aqxrhjD+JeSq7F+B4yeWdD2GIIqjgI=; b=RGjEp+WP1dnqKoIF
	FHBee8QJNn/lkJbIlB2n3CSC/kJPVdy3r9yWfxxfhB47GTSWBcNeJDDpYYRcWToE
	TAqNRbgTiFeLkBSZqB3F5KqdNBNvbn90UPnuaFLyw/UGTuj0Maw/S8oGu6Y2pijz
	IVHzld95C4zkqH/1OYJ89XMXIfILprRMHmqZaVcPu3V4rL0zYfS2dyH5oeE3Ij8y
	TpIkB/7ssMKknmUuGmahO149Ml+qy5RPwIulLrz36dNJbr59WwOOf5PsIWeehaLI
	amnPyHRaug+F1xM/a97df3ffotf2eMC3qC29ngEniDFFxRrV7zQZ2W/DTsIkbCu4
	eUDetQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn7tae5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 01:14:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a944e6336eso323938665ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 17:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771895668; x=1772500468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w1/kowcfPiZ63aqxrhjD+JeSq7F+B4yeWdD2GIIqjgI=;
        b=O6Z9becIhGelQq795CM6g4w83ceCmlB5J6glZNTb26x88ul9AyL3Og1lZ4n1AD98di
         LeLeDge7DdrIzBiOfCcuiiCKpakDS+VwMq76Y6otq//lphqIih/wCr7vA7jyQb2fD+1Q
         8sFCLLNLshZWOWCRWAGFRJ9+0JEJQ9PzzxF8tVDFUDYFw0AtL9WZ92oxV2V37eowprya
         p/XNInYyYgOk8iejwZ3anr0F7gzijeIXapp/EMvTrZ68odKHYBRB/SYKeI/cPKMwZL2y
         sowIeNCfnc2i9Sa5BBg1w5uOU+6NHbNVl6xHxuNejLnO1PbhTo0fDzZe6IjCmekT1KvW
         5rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771895668; x=1772500468;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1/kowcfPiZ63aqxrhjD+JeSq7F+B4yeWdD2GIIqjgI=;
        b=BaT7oFd7RWKAdcfIGQQK2+YJQBBv+SF8znFl05eOJ/GctgwB3Qqfxkkocu4caXmxXB
         MOAT3lr4kvonbuCUnGY4oLaQXWJfXwyA+hAVEOIkYdRECuec2dpYiKsLBwFKSC1HNIQm
         TSon0WkFdBPyjdMOrMgVdiyuCWHrM6x49soOkzKycSQXHwjuuxxHLT45FsZk4lG122Uq
         ScgfrWbqUWzA/nk2nnJGABLuS6wyBmdSmhP1Q/mMSs0LvQu3TEHOmaYpb1V6uhl3iHRe
         rN6U0utWL2eDIwWqn4wYibGueeADEL32UZTSysxBAoohl1xI7s47vSbXDOHmv8civsdi
         eUxw==
X-Forwarded-Encrypted: i=1; AJvYcCW+TEX1fockAtThzHbf3BJbLCd1TSJRj0uL5EvyG3JWTzMrNORzanPTzVUpaKqfjlNIXg+392hR36G44ghasg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywdSIBtjCJ0zTFWy15SN9u3mqwPJ//K/9mT3e0m370039qmUuq
	gTBKeXj933uJva5wI8Xtz3MOGChCB9O4uY3LgADos+ZX45B3j6dsmh6kvs4A23UhZZXEMIaIKgH
	6+WnyfcE7HgMbc8TTIOguiPclLArzYaeRraBxyr2fweULItAbZ4IqqQd/6M+m/jl3R9SDHUsJ2F
	5BjA==
X-Gm-Gg: ATEYQzz0tHx53Ozh1FCFPI73cFN6puW4hE3FMQhR3uzKEYqUg/So7WLZvuwPm0/pbOm
	iRzipfwO+TJQRzaDg6N8lUQKT5HXi1ExK6c45zhkekjHA1R7mievHlx3YkT7MZXQBmzfyVlV/ns
	33pYrJkCdChkVEYq9hWYvqFdQFka8/Jlv5RFMXsQDzXpWSbBHmSXlFemzPfxPkvY5AtXt2FUrkS
	o/ffoR/gi2+2n+l+4QfiYvpA1aN7oA2Ju2B9o/OTIPZq5mTgOQ3I6YG/i9lMIqmsAYvWACCOcsS
	nqlwxx7m7lvXP8wwzKXiyGGB8mAtmF/jBqgEXvGtm4xGKqjtjyYGT0618Xko7GGgO3u0I7iyYzX
	PqHR4I3BvEVLvsDvPJChltSlSCJi2UQkfseHs8nx1S5y7QAtlgPnG62WgOSA7PYmnKvKb0Au6BH
	X00NF6UamDFiL4Z/KFNjc=
X-Received: by 2002:a17:903:38c3:b0:2aa:e6fa:2f6c with SMTP id d9443c01a7336-2ad74460475mr111797445ad.24.1771895667862;
        Mon, 23 Feb 2026 17:14:27 -0800 (PST)
X-Received: by 2002:a17:903:38c3:b0:2aa:e6fa:2f6c with SMTP id d9443c01a7336-2ad74460475mr111797225ad.24.1771895667331;
        Mon, 23 Feb 2026 17:14:27 -0800 (PST)
Received: from [10.133.33.133] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e9csm81801255ad.3.2026.02.23.17.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 17:14:27 -0800 (PST)
Message-ID: <9db7e1bb-9766-4239-bbf6-a95a872ea130@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 09:14:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wi-Fi quirk found in Dell Inspiron 5567
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <c7c5a458-ec8b-457f-893d-1c4b147ebb65@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c7c5a458-ec8b-457f-893d-1c4b147ebb65@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c5OmgB9l c=1 sm=1 tr=0 ts=699cfb75 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bgCL48uodNVjzKK0AG8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Gz_WoQkEWqYVfAXWDVLbI7Yt89HEWD8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwOSBTYWx0ZWRfX82InMmSckacb
 KfVyk18zsD2gw4IJu7TQ3ofGU4yZEU62ForI2unQm3uK341i54SsBoawABLIAfd9cK7oCwvyOHH
 Ctc6NV1570PuUcCpYcKrTkGfUw7Vhm710vqqriPatMLU0GOTW2odp9JGU7rG72uu8gLGPyoKqKZ
 OssMwR4USY1OMqOyTzC+DQYnoSdRc5PoCf4IJ5hbAzKWRrdxOnUcI2td+e+SDBodYOf1K0f2dHG
 eJv7b/tBsnMWCBdzKcsJmykJGC2Mt3sIz9hGdKIjwch+qd35GQuLaupBZ4o/BFh64IHMiYHBjl8
 LkFRJh8wirDVfq9j9HwRW6dDmPtO/DvZo6N5WJnWTvpdBhCiHtIpjywF79LzTaXd+VV7C1POc6b
 IEhHFE1psb6Gns5HOcENfk1vAVOaqQYFSmi4KSkH2m8huq11tDbaMkc6xUxes4EYCeFoHbVzRWu
 mLWpI6dWK/H5zRzmXgw==
X-Proofpoint-ORIG-GUID: Gz_WoQkEWqYVfAXWDVLbI7Yt89HEWD8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32135-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EDFA51806D4
X-Rspamd-Action: no action



On 2/17/2026 1:05 AM, Bandhan Pramanik wrote:
> Hello,
> 
> I messaged regarding Dell Inspiron 5567 earlier. This is regarding the QCA9377 chips
> placed on these devices.
> 
> I fixed the issue using "pcie_aspm=off", and I can say that the ASPM configs of the Wi-Fi
> chip might be problematic on this device.
> 
> The reason is that *these laptops run Wi-Fi erratically if we don't turn off the ASPM*.
> The result is the overwriting of the dmesg ring buffer within seconds of boot and IRQ #16
> being turned off for the influx of multiple correctable errors, which hampers the
> touchpads too.
> 
> What are your thoughts on turning off this device's ASPM by default? I will be happy to
> provide any details as needed.

can you please share the complete dmesg log, as well as the output of

	cat /proc/interrupts
> 
> Bandhan
> 
> 
> 


