Return-Path: <linux-wireless+bounces-30104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A925CDD14A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE5B30194D2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CA9278753;
	Wed, 24 Dec 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StBMaAZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301122127B
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766612879; cv=none; b=dGwZyc3swE3kjouOxI1v7TrJK9unxZf1NgXQhSXQ1Tz2+vrKyjXuvbU06ZHxBgghKlkMR12p6uM3r6ww+NsrqepVRe1i8nvlgoiPnUTE4ODtg/rW/ujZjIGDraJbDZi8+EtH31c3Ras15WPaE4orGaSLSofaZT4KFQFcLC9CPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766612879; c=relaxed/simple;
	bh=SsQ8suhdnxoLg/BALTIe9vX5/+I9FvVwhH94aNp2h2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mR0gv6zSoJB78xNzOtjXFsjYsy5D7+FvtbcpmaOsXwOjI1O2jtCVXhi4cK5lj045YdeJKib4rAc2k1S5PtB4v6Ti95U8W0KUNHJT+ujFjPbqCxKn3WNt7KCoSTNk44+xGWFY3gnaLRSSVEm1x/AQlmZIPSKXMuDV8KjLGU/5vaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StBMaAZM; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-459a6261428so294467b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 13:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766612876; x=1767217676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha4eKRJIz/T1ZwOob3JaZe2/+i72Uxp3TMnMs1kyDmY=;
        b=StBMaAZM34/1D36J7sXnDIBoZlcF6MSgUTMKkbcAEn4u3F17Qigf80nfNvptyh3MF2
         iOup1icT0YZmtpcIzikwmoYObBq3G1Ys+BOaJneqT1HEUbyJ+jq1AgLUs/yUrn6eIuLs
         7wc2EXqvFGlQgg/tZ/5969SOSLT8ULVZNCEH0vAIra2c0kwmjskOiod0SSurfH0EYRkM
         vt/RqRSbf+3B4sJmsWQOMZb1A3BcE4Iz0dq6jOEzWpit/gxFMJIS7UUtb1N+kZnLSlZT
         ctMhYvOqroa/86ntRP0sRTJNq+kqQ82EmLDpRZ7jG6Ga6y7WSwnN/gaduLMk0VwAeYxj
         v8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766612876; x=1767217676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ha4eKRJIz/T1ZwOob3JaZe2/+i72Uxp3TMnMs1kyDmY=;
        b=w32M2Dv6gZGuS/rh5TbLLyZCvg8XElpS8C/mCBMKPmjH6d+/gEo0zJb0kXYUtdUeJC
         7cIZyfPlEiA5cbfQTAQ3ZME06UTFTiVVA7kCBCojT4eatRHQmemW58xRSpf0PESPcOHy
         k1/Fq9LFvA3TVTH+GPqvdCWrs938RUaoAV3uKZ/zz2KYmmX4Gz72X6BkI9F46uvkdzAJ
         jFqW9nXXLvEsiTLXgcOfxgN3/2tUZYzj+N/fPBZKy1C4SrdMF9cerztY06YSuBwuMs8s
         9cKFEYFbUSe26/jwE1nHyZb9cGzEG/kc100PxOnDtv9RqEIVJxYrn41JArVX9vuhHuHn
         UFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX83a31WpMaRc7HEPBBJ0FyH/8++ve1zwOZvgufQh9krfpw0DT7o/ta9KRJWjzu9S0rVEFs4l5n9lP1uEpNyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxw6buXU+v/ANTxhyp0T1Qt+7sNLVlVL2tzQQgk06ZilJVomv6
	ki9Forv5PIxoCIGgfadLSWKsHu6JDwQXYYjpEZuxK9n+LcsIgTzFgkYa
X-Gm-Gg: AY/fxX6qb7dudd9hSMUupWnpoibyyNztyqwWWQHIafGQXbeQiohPUogVS9k3Iey/so9
	iClnRdKGDDRwBcUxD6/EB+c6Sd4snKAVJhf8iLY1d7/HYo4KqWPHObtLgixNwmzOQovUgDGxpvF
	Ysf4HBsP+bVLy1wN42XKFWbawgzl0hp+4PaxoBZpd6Z1VqaDj5IAaOlXr93HhNArHYafuS2Awi5
	KonEkRc7VEpLRrn1DtUiRdaSy16UUzyS6PZ4H/oDCsDpgOUjcvccmVQ/0K3sdKvhtEPYvAIBCgA
	pjEv77+SArdskovOCNpLLFmy7/swLlUCb7GQCKim2U+uz7KU8pmwja6HtISC/hzFLTF3HSnfxeA
	+XLz/QQaTz6U12kjDZFYv+X6j6WmLQI1z6UZsSgsFqo988wSyNN5LvlvuIbsj4gHScvn9D/qrni
	NY1qgl9csBFnZP0z18QRwzZWqBd8PGNQniuM7zHRcXt/PeBa5LWJL5lsHbid7uzoUT6Jkp35CwF
	/gb3XX30/nc9UZE3Jx22xFXZ/wiQe0=
X-Google-Smtp-Source: AGHT+IGu5KZ4dsfgHYKgEBcNkgI5QWefcHhYRFFlHiYBwboCpljiSYdEgGO062vJLCxBROo3r+3vXw==
X-Received: by 2002:a05:6808:180e:b0:450:d4b5:3527 with SMTP id 5614622812f47-457a29567c4mr10023379b6e.24.1766612876310;
        Wed, 24 Dec 2025 13:47:56 -0800 (PST)
Received: from nukework.gtech (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d4f62sm12176872a34.19.2025.12.24.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 13:47:55 -0800 (PST)
From: "Alex G." <mr.nuke.me@gmail.com>
To: jjohnson@kernel.org, ath11k@lists.infradead.org,
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject:
 Re: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB region
Date: Wed, 24 Dec 2025 15:47:53 -0600
Message-ID: <884758381.0ifERbkFSE@nukework.gtech>
In-Reply-To: <7ef46837-7799-4ede-9f5e-88a010d5d1d4@oss.qualcomm.com>
References:
 <20251206175829.2573256-1-mr.nuke.me@gmail.com>
 <7ef46837-7799-4ede-9f5e-88a010d5d1d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, December 8, 2025 4:23:46 AM CST Baochen Qiang wrote:
> On 12/7/2025 1:58 AM, Alexandru Gagniuc wrote:
> > Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
> > 
> > assumes that:
> >   1. firmware will make a HOST_DDR_REGION_TYPE request, and
> >   2. this request is processed before CALDB_MEM_REGION_TYPE
> > 
> > In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
> > after the host region.
> > 
> > However, if the HOST_DDR_REGION_TYPE request is not made, or the
> > reserved-memory node is not present, then res.start and res.end are 0,
> > and host_ddr_sz remains uninitialized. The physical address should
> > fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
> > 
> > resource_size(&res) returns 1 for an empty resource, and thus the if
> > clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
> > is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
> > 
> > Use "if (res.end > res.start)" for the predicate, which correctly
> > falls back to ATH11K_QMI_CALDB_ADDRESS.

I am ready to submit the IPQ9574 support. This patch is a dependency. Should I 
include this change in the series that adds IPQ9574?

> In addition, does it make sense to do of_reserved_mem_region_to_resource()
> before the loop, which may give CALDB_MEM_REGION_TYPE a chance even
> HOST_DDR_REGION_TYPE request is not made?

I'm sorry that I initially missed this question. I don't think we should move 
&res initialization outside the loop. We also need host_ddr_sz to be 
initialized by a HOST_DDR_REGION_TYPE (1) request. On IPQ9574, the firmware 
doesn't make that request, so host_ddr_sz remains uninitialized. Since &res 
and host_ddr_sz are used together, I think it's better to initialize them, 
together.


Without patch:

    ath11k c000000.wifi: qmi firmware request memory request
    ath11k c000000.wifi: qmi mem seg type 4 size 409600
    ath11k c000000.wifi: qmi mem seg type 2 size 262144
    ath11k c000000.wifi: qmi mem seg type 3 size 1048576
    ...
    ath11k c000000.wifi: failed to assign qmi target memory: -5



With patch:

    ath11k c000000.wifi: qmi firmware request memory request
    ath11k c000000.wifi: qmi mem seg type 4 size 409600
    ath11k c000000.wifi: qmi mem seg type 2 size 262144
    ath11k c000000.wifi: qmi mem seg type 3 size 1048576
    ath11k c000000.wifi: qmi ignore invalid mem req type 3
    ath11k c000000.wifi: qmi req mem_seg[0] 0x000000004ba00000 409600 4
    ath11k c000000.wifi: qmi req mem_seg[1] 0x000000004b700000 262144 2


Tested on : WLAN.HK.2.9.0.1-01890-QCAHKSWPL_SILICONZ-1

Alex





