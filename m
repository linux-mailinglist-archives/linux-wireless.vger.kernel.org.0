Return-Path: <linux-wireless+bounces-754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1EC811E52
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD8D1F21A3A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0B8339A1;
	Wed, 13 Dec 2023 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ipv1pPbe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A5E1A6
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:11:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cecb004339so4145280b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494698; x=1703099498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpG+EEGCB6qn4cMUhkO53jShDEsB2LuwXJ0kT5xqd8k=;
        b=ipv1pPbe+UpX5iGCBRETIUcZl6Cdk/6odX+DLXqrbaqn66KAZ8vP2k77YeakrpKL7t
         gO/Ie7JrkC3ROdi3Eo/5A5zNQOfpgIBpUWAsDxBOPon5XrXoPeWbFoh2767D933TRvYs
         e/toES0K+gXxyKKvNDhL7MVrivjyGxv3ARELs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494698; x=1703099498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpG+EEGCB6qn4cMUhkO53jShDEsB2LuwXJ0kT5xqd8k=;
        b=rlnk5ynIAVRvqedPB/rVjK00mCyheUEYKOnlmHvGRwCX/0frXuTxrcgXQqyxumlIaB
         a0kEqc29qWthACL7ubF4uagI+HQ5qaO+34ccu078MQ3tDowdgMHsc38BfNnxpC3OC9Lh
         ekn+qXp89Wf4TZ0e7+mUqtNCyeRkSQCgOrgJCTb5dlqh73DVtD31dt1I4CLi8qn01xSA
         +Xwr4HvgHIG4M7++GgZ1ZwH5hjd32u4BpNn/K7TskmjnpW3th7QCv6ZMOhbUwwqOEPL/
         ZI3Xe7wlIiFHnBaXaORBQ3A2mfpAqth8Ri8sCTP6WMDSda/nmE2khxtK7MxcgxD5us6C
         Amfg==
X-Gm-Message-State: AOJu0YxdLqJOcHB6HvlfA2LVpo1DzVhe00G4RqDB90fCIjpHFxaH9Quu
	5xAy49mRCRWgBWYOSJMYRfrUoA==
X-Google-Smtp-Source: AGHT+IE65DZud1cxhlQnjhKFYRVoxzWYts7ImiaFpC108iXuhbQIThqPXHzKV6YtNeM3dkGKKHJTsQ==
X-Received: by 2002:a05:6a00:460c:b0:6ce:2732:1df6 with SMTP id ko12-20020a056a00460c00b006ce27321df6mr5670114pfb.48.1702494698162;
        Wed, 13 Dec 2023 11:11:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a056a0002a500b006ce19a67840sm10227618pfs.199.2023.12.13.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:11:37 -0800 (PST)
Date: Wed, 13 Dec 2023 11:11:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] wifi: ath10k: use flexible arrays for WMI start scan
 TLVs
Message-ID: <202312131111.256FE1A@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>

On Wed, Dec 13, 2023 at 09:06:40AM -0800, Jeff Johnson wrote:
> Currently ath10k defines the following struct:
> 	struct wmi_start_scan_tlvs {
> 		u8 tlvs[0];
> 	} __packed;
> 
> Per the guidance in [1] this should be a flexible array. However, a
> direct replace to u8 tlvs[] results in the compilation error:
>        flexible array member in a struct with no named members
> 
> This is because C99 6.7.2.1 (16) requires that a structure containing
> a flexible array member must have more than one named member.
> 
> So rather than defining a separate struct wmi_start_scan_tlvs which
> contains the flexible tlvs[] array, just define the tlvs[] array where
> struct wmi_start_scan_tlvs is being used.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Yeah, this too looks like the right approach: keeping the flex array
close instead of externalized into a no-op struct.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

