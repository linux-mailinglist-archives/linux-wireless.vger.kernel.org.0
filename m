Return-Path: <linux-wireless+bounces-21729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B283A93BFF
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886888E4B37
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7704A1487F4;
	Fri, 18 Apr 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HgRwZDtG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF98F77
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997513; cv=none; b=CQa6JFDP1o7hWcV/48oBtbD3rPGUoMuM/YPogUCvrMC5t5hdcWyT8JEe2xyM/uFlbX3dJYs298nhIRtAZ9eIb+M2Nw7yASqxUI3LXVIEdGw53EU0qcUAoSvkd3mNpJm+PpukcLICKRoRE4y2AJAdaZb0EI4rQkcJRkK/IZlMfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997513; c=relaxed/simple;
	bh=skmcZu3toJZp947j2laTrO2az266CcX1lPvLVUWKFsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4XDGt1ayp2G/CIINcHJizX9OJfyJ90sDAkssmDDo0VN1A2obdiXla4YFWSvPvHbcaFcgV4UIBhts2+lpFlfM42PDUHeZ/Zd7UkecBV352r9r69BOx5uydvd1QWnPxx79nHsnL+55EtxwVy+8zrGE8P3MbV0pj4f7lvq9RCpnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HgRwZDtG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IFnuh5022803
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AlbYhs/tTM2jGkz/rjVwEWY9qnmGn2gfDI9FBnXvzLE=; b=HgRwZDtG3qSyNPHU
	pZtRAVExHS/sO6Dn0gXoGX7YeSppQj7LKEOkWobiuwklyxw3dudMCUALGhy5/EfW
	pDnAzKoX1FljTpShLpOXHJAaJMByGzjqIV1WLwiAWNbSnq0fWm+W4sg6BEjtN567
	DLqKo99a6fXziBdLGKLT93apxr82lfhJy0slDEUvxdrnd3i3L/ibdmPhYUPNt5HB
	KC9U/cKUROcuFjlyBxxKV9QKN8EpEAqOKxId0RsejOgdOVm70e+VQ82cPIVOpdaS
	1lkxkNIH8Hi/1dE9Gr61Ou63jzdcwxVWtiUsenVltCg9HIujuVYAV4amRymGZLz0
	DQuuvQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbq2afg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:31:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso2645578b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 10:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744997509; x=1745602309;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlbYhs/tTM2jGkz/rjVwEWY9qnmGn2gfDI9FBnXvzLE=;
        b=GTmfOpVNZVg5qvZiXtc/QxKK4YF/Nfi5cwQV4w6z++yUSPaT/01sk1JFgd45j6Xp4/
         J738u8KRH8oIjaYfhsp+rH7IOaUHcyGPTxDryKR7Zxqdb/9T+Y3ZnGlEiTdmHyuuHIVp
         YAKH/VrWkBkYGUG5kubWht7FVKM2p+q2WvRrfpwdMxNGOTGu2kwJGPHlGgdLS8GquCaY
         9UfmndyridKnke4RlKT6Y8P1OC44UeYr1hAwO0ymKLafUYhZjsZbBwuuI1116ECyTYBy
         MgMpTBYjKmwS4VAQ8G8Sao/fnT0FLfLmt+iCbYIUlbbFV9YtNw7OmXPL8mOYoF6HO/O6
         WwhQ==
X-Gm-Message-State: AOJu0Yx4/jZFJJbSnj7DpiPpOQFt7AtdmC+nqXE4G0wE0lJBbRc6JGoC
	C3k6khQ0yII/Vv2e5SYXQKvTdA9PKsxb883Ak3AsDtuDpeAk2C5gzOGH07qcJbCwdEB4m5/5Tqd
	gQRIFX9eeFm0RzHP68csYioFpeDUodGnGTeSj4QZZUByRVliqcwzPyyTiuKoIZMx6yA==
X-Gm-Gg: ASbGnctIzWCJ/GaynlcbwCLMzSm1IPr99iuw9OrbQRIJKmn0JBYKhOlSzqFjZaNfjCT
	n8HXmQ++RiX3dFiZyhZZSFzHqqzbYuaU6vI7vqg5y3Jqkr82A7IPqgXl6vkATwVSYn9PG27uBhL
	vO371snNT7H5a2e9knLDw6PIJTJ6l2ZnHMjj+meYQNMvRxCLmxtddWgAVQRYkLlMQJ/Hi2ve9mo
	Nk6BrXA680dYE5xZdXK8PJT8IlhoU2dEXF8Z+o8alw3i4xG3WlW7VFTAlSUTH0Ch77nzBSozV/p
	aIqUIJTwHdoYWLbF6dligz9f5oJuthknbSbvwvqHtPMqm3LO13zwqOUWv0Qfgoq9cnwDKnhvz49
	zpx8t
X-Received: by 2002:aa7:9301:0:b0:736:4b08:cc0e with SMTP id d2e1a72fcca58-73dc15a07b8mr4300901b3a.17.1744997509544;
        Fri, 18 Apr 2025 10:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBReyuJ6/FZJbmccvThGQm7dVpQP8cZI9VqxheDzjOaz+A+xzk1uPa+MF2XLEPT1n6f0sdmg==
X-Received: by 2002:aa7:9301:0:b0:736:4b08:cc0e with SMTP id d2e1a72fcca58-73dc15a07b8mr4300870b3a.17.1744997509028;
        Fri, 18 Apr 2025 10:31:49 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8c05d1sm1923535b3a.12.2025.04.18.10.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 10:31:48 -0700 (PDT)
Message-ID: <2fcc7ef2-6e15-42bb-8029-de5c89a1ad6b@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 10:31:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: fix compilation error seen while building only
 brcmfmac sub-directory
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        wlan-kernel-dev-list@infineon.com
References: <20250416060128.15703-1-gokulkumar.sivakumar@infineon.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250416060128.15703-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zUykbkH_mOw1dWRkf6gIga3fy_DwDyjq
X-Proofpoint-GUID: zUykbkH_mOw1dWRkf6gIga3fy_DwDyjq
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68028c86 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=bUQKSiCPAAAA:8 a=v2X0Zl_oqn6eSmZfj6IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=-fHZXUhsFbuwFN3fwQAr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180131

On 4/15/2025 11:00 PM, Gokul Sivakumar wrote:
> The function prototypes of brcmf_debug_create_memdump(), brcmf_debugfs_get_devdir()
> and brcmf_debugfs_add_entry() are protected by the "DEBUG" config MACRO in debug.h,
> while the corresponding function definitions remains unprotected in debug.c, so add
> the missing MACRO definition check.
> 
> Compilation error seen while building brcmfmac sub-directory with CONFIG_BRCMDBG=y
> is captured below.
> 
> $ make M=drivers/net/wireless/broadcom/brcm80211/brcmfmac
> 
> make[1]: Entering directory '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
>   CC [M]  debug.o
> debug.c:17:5: error: redefinition of ‘brcmf_debug_create_memdump’
>    17 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from bus.h:12,
>                  from debug.c:13:
> debug.h:136:5: note: previous definition of ‘brcmf_debug_create_memdump’ with type
> ‘int(struct brcmf_bus *, const void *, size_t)’ {aka ‘int(struct brcmf_bus *, const void *, long unsigned int)’}
>   136 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> debug.c:45:16: error: redefinition of ‘brcmf_debugfs_get_devdir’
>    45 | struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~
> debug.h:127:30: note: previous definition of ‘brcmf_debugfs_get_devdir’ with type
> ‘struct dentry *(struct brcmf_pub *)’
>   127 | static inline struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~
> debug.c:50:6: error: redefinition of ‘brcmf_debugfs_add_entry’
>    50 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~
> debug.h:132:6: note: previous definition of ‘brcmf_debugfs_add_entry’ with type
> ‘void(struct brcmf_pub *, const char *, int (*)(struct seq_file *, void *))’
>   132 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [/root/wireless-next/scripts/Makefile.build:203: debug.o] Error 1
> make[2]: *** [/root/wireless/wireless-next/Makefile:2006: .] Error 2
> make[1]: *** [/root/wireless/wireless-next/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
> make: *** [Makefile:248: __sub-make] Error 2
> 
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
> index eecf8a38d94a..3cb50140eb2f 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
> @@ -14,6 +14,7 @@
>  #include "fweh.h"
>  #include "debug.h"
>  
> +#ifdef DEBUG
>  int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
>  			       size_t len)
>  {
> @@ -54,3 +55,4 @@ void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
>  	debugfs_create_devm_seqfile(drvr->bus_if->dev, fn,
>  				    drvr->wiphy->debugfsdir, read_fn);
>  }
> +#endif

This does not seem to be the correct approach.

The compilation of debug.c is controlled by CONFIG_BRCMDBG:
brcmfmac-$(CONFIG_BRCMDBG) += \
		debug.o

Hence the definitions of the prototypes vs stubs functions in debug.h should
use the same config object.

So I'd expect a change to debug.h to consider CONFIG_BRCMDBG (either instead
of or in addition to DEBUG)



