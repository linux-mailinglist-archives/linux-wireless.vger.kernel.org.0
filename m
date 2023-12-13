Return-Path: <linux-wireless+bounces-753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7646C811E46
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7958B20E3A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D08F5A0FF;
	Wed, 13 Dec 2023 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CE1E8N2Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A29D43
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:10:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so43703465ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494623; x=1703099423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqkTY1D+Z0smSuBPziSXpfoIkBBzL9zSOCOQ3/VwzV8=;
        b=CE1E8N2YrSlCa3ZagkQjHUXjZES8FXi9nuCnC6w3mP3ssI2+vrg6eCxwymrV/dwewd
         rIAEGlhIZyy9lZM5i3djaktv6e/Nr48ex/cEQdVS21w2XS/ukfPcDqjwbxVbDFx1JkZa
         Q2+ppRDpUisA3M3MywHl3dsIcyoamA2e9fxhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494623; x=1703099423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqkTY1D+Z0smSuBPziSXpfoIkBBzL9zSOCOQ3/VwzV8=;
        b=cHgS0tNIfy2oEOVh813d3RqgqzKIy9WpigeqfELpTVV05cA0U9dTJq2iYYFXAN0ybl
         kKKehh51Vr/BuR5o72gOVT4LLeQLJHh7+JoZyjkau1Qkwkc3wmfsq2tR8t0xokU9aWI6
         j+V+m/xqce9arHNflnaXBPdCM6zm9Jrih27CXIAjVBGHbsEVNQOGAaG+/RSV+YXrAvEH
         T39KBQD17f7XP/OvIROz9zap2O0jLBPcdr48LuyShK8+eGzMCkDAybfJ3QnxGSbye8I/
         m8aspUDTkNLmDeDfZmQR8F3t4fQ5xMB3MjvEkFMcdSDhOrAm9/UXGn2yQq4gzH1vf6uT
         okpg==
X-Gm-Message-State: AOJu0YxCKepJlb3bqshY77+DaaH1gAjSflVZbLJ+CyOSiw+NJKXOed1i
	gtIEOocmu4oU0x5Pvczjs8Is6Q==
X-Google-Smtp-Source: AGHT+IGgfljpT76KBPui5MmTR6g8xbaYQw4KFDi5WWuN30o04xnbXoheBZ2WDSfB+ilvt/xURB8IDw==
X-Received: by 2002:a17:903:98c:b0:1d3:4316:68d3 with SMTP id mb12-20020a170903098c00b001d3431668d3mr2259140plb.76.1702494623547;
        Wed, 13 Dec 2023 11:10:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001cc307bcdbdsm10950629plg.211.2023.12.13.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:10:23 -0800 (PST)
Date: Wed, 13 Dec 2023 11:10:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] wifi: ath10k: use flexible array in struct
 wmi_host_mem_chunks
Message-ID: <202312131110.F94BC3427@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>

On Wed, Dec 13, 2023 at 09:06:39AM -0800, Jeff Johnson wrote:
> Currently struct wmi_host_mem_chunks defines:
> 	struct host_memory_chunk items[1];
> 
> Per the guidance in [1] this should be a flexible array. However there
> is a documented requirement:
> 	some fw revisions require at least 1 chunk regardless of count
> 
> To satisfy this requirement, follow the guidance from [2] and wrap the
> array in a union which contains both the flexible array and a single
> instance of the underlying struct. Since the footprint of the struct
> is unchanged, no additional driver changes are required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

This looks like the right approach here.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

