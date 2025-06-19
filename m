Return-Path: <linux-wireless+bounces-24259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C07ADFB83
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292F916879A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B166221FCB;
	Thu, 19 Jun 2025 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayBthVzA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FD221F00
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301615; cv=none; b=YUimHNC507icTb1vKi8MRghnEpYsA4FFhlbev5pyj6pNz9YKNdMCL9KNGl0TjBl/ZvnMkEX4YdlJRoX8YGkuOsU00f0/DabJsNnnCJAeUY2c3jEgxHTm/e83nLVmySogs0C1/0ep6jGz5vgc92uP1buuHlCxVyKRdCiyLyiQwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301615; c=relaxed/simple;
	bh=OsdN13/dSed9kBQwRJxxWTY3QfS6d80pDSHIWWLDRmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UffbDzNZclXWOErqkRyloA4jsWlYSNCiTA9wsALkakrZs76SqvtbauZcWvRiS1Be4u4Pdq6GkngxNN0eL3/Wiqgi4riMYnkBiy6DWmADe7M/CgQ9cXm34JLoR9nq9ayscqGm2p5zvjYPv5q/DSesfMp7oy/c1a2+lU3huyzONxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ayBthVzA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af51596da56so314942a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 19:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750301613; x=1750906413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FU7hS3nxP2s1VnD1O6EqAa6UCfOLId0EKfwYuX88Apo=;
        b=ayBthVzAZbc0N2UEw/ff0eXYSYxcbET1tji6nbrCBGz5EYSErOX7TfLS7U7fub+Ycj
         sPIuMdta51FjPdwl28SBC5RQtAT24PaS3KkEHwc1qnlF/dDOzgTTVoX2N4glWzYLcEo3
         M8NPxrow5uzsez637LKB82s7/jNn7Gxuanjn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750301613; x=1750906413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU7hS3nxP2s1VnD1O6EqAa6UCfOLId0EKfwYuX88Apo=;
        b=tD3GcNW2h62Y5YZh1uFvTcFgRIUMRG9+LfYvJaTV7G48kpjr464MOhXFrfUyxtyN8s
         rAbLzWi7PFdltGxAd4k+J8g8yWalt0paewGdlopHHp3dlG7TmMrWJHaEzKAVVtCZ39LF
         xBfeQ5E2cHvN4RlBJMmITbARCltyosNypb53OilY3r8fToWIApmEdQa+/MUC+CW7hY0U
         9JC+ldT8c4bRRyatGQmJXCylkwxYiEWmC9iqkgE/vUd9hmSrxGG7OLDFtw59hNMr6dvw
         5ptrrMOh1W4qgC8BAFEVLvGrmzEGYsOa6QCR6jiDzqxinJNk68E1RD8qb0OOyPa8ZmmV
         Q0Ow==
X-Gm-Message-State: AOJu0YxEWxvGQH1RHiGAMcdUsN9PY6KJ2x2RvVrYZ9NdhXKctfBK8RdF
	ZzPC0oPGICOcSzILtpIFBtDqcozgUQx8GklyNsFJjSx2DSWT8WlnCBDQpMscff9cCu212oZE2ID
	rBo8=
X-Gm-Gg: ASbGncvHomF5Ve+FVIInbJ3CoyLOHpzbZKYGI6174XTI7UNcgCcXIMPjDJnSmJ9gyq2
	+RQzJU6x61uZz7VL/UJhaR0tI65mZpPCTdOlzYoYjw97+SC59+ftYmVLdSBtH7WOLzSbOu5dxh7
	P/yS1JgPUOY6dZ8Zf28GNHlJMtO5VsqRlAlhGIAkIlF7MLag+7q1mw2LEpFjN9LXx/29uNtz91D
	ByEM5H+FfL1/5WpSHZpQOSMgz1IPsDJhxbxX4PiwHyfSb3UgsZYNGtVkLxRAaOKCW6zvzjAq6tl
	KiNAcDMf9kH06j1ZHvhlC+lI/jBni4ChctChtDHR8qNtTOd58xdfr8edfhxHJK89FA==
X-Google-Smtp-Source: AGHT+IGNccPkiKMjhJp9xYP7Kep1hqlT//YVjWo3nk5z9pz6Nus1LaUm0/pUREXGtm7Nq43cBr8sEg==
X-Received: by 2002:a05:6a20:7f8b:b0:220:3a5:43e9 with SMTP id adf61e73a8af0-22003a54b20mr9849038637.32.1750301612935;
        Wed, 18 Jun 2025 19:53:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31c1b48c69sm3688361a12.31.2025.06.18.19.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:53:32 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:53:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jeff Johnson <jjohnson@kernel.org>, 
	Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv3] wifi: ath11k: clear initialized flag for deinit-ed
 srng lists
Message-ID: <xgypo7y24oxfe57psg6bdzrmvmahx7swb2ifjxqmpteagsdonw@ubrubygzpbyo>
References: <20250612084551.702803-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612084551.702803-1-senozhatsky@chromium.org>

On (25/06/12 17:45), Sergey Senozhatsky wrote:
> In a number of cases we see kernel panics on resume due
> to ath11k kernel page fault, which happens under the
> following circumstances:
> 
> 1) First ath11k_hal_dump_srng_stats() call
> 
>  Last interrupt received for each group:
>  ath11k_pci 0000:01:00.0: group_id 0 22511ms before
>  ath11k_pci 0000:01:00.0: group_id 1 14440788ms before
>  [..]
>  ath11k_pci 0000:01:00.0: failed to receive control response completion, polling..
>  ath11k_pci 0000:01:00.0: Service connect timeout
>  ath11k_pci 0000:01:00.0: failed to connect to HTT: -110
>  ath11k_pci 0000:01:00.0: failed to start core: -110
>  ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>  ath11k_pci 0000:01:00.0: already resetting count 2
>  ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
>  ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
>  ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
>  [..]
> 
> 2) At this point reconfiguration fails (we have 2 resets) and
>   ath11k_core_reconfigure_on_crash() calls ath11k_hal_srng_deinit()
>   which destroys srng lists.  However, it does not reset per-list
>   ->initialized flag.
> 
> 3) Second ath11k_hal_dump_srng_stats() call sees stale ->initialized
>   flag and attempts to dump srng stats:
> 
>  Last interrupt received for each group:
>  ath11k_pci 0000:01:00.0: group_id 0 66785ms before
>  ath11k_pci 0000:01:00.0: group_id 1 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 2 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 3 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 4 14780845ms before
>  ath11k_pci 0000:01:00.0: group_id 5 14780845ms before
>  ath11k_pci 0000:01:00.0: group_id 6 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 7 66814ms before
>  ath11k_pci 0000:01:00.0: group_id 8 68997ms before
>  ath11k_pci 0000:01:00.0: group_id 9 67588ms before
>  ath11k_pci 0000:01:00.0: group_id 10 69511ms before
>  BUG: unable to handle page fault for address: ffffa007404eb010
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 100000067 P4D 100000067 PUD 10022d067 PMD 100b01067 PTE 0
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
>  Call Trace:
>  <TASK>
>  ? __die_body+0xae/0xb0
>  ? page_fault_oops+0x381/0x3e0
>  ? exc_page_fault+0x69/0xa0
>  ? asm_exc_page_fault+0x22/0x30
>  ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:6cea 4)]
>  ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
>  worker_thread+0x389/0x930
>  kthread+0x149/0x170
> 
> Clear per-list ->initialized flag in ath11k_hal_srng_deinit().

If you are with this, can you please pick it up?

