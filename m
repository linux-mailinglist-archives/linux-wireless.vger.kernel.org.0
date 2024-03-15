Return-Path: <linux-wireless+bounces-4794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD887D777
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 00:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEE2B218D1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 23:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D25A7A4;
	Fri, 15 Mar 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c058IzQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDA4D9FF
	for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547126; cv=none; b=uPowed4jMfxR7cSTGSX4zK4DzdxE2rAuw/NDyucxVqg5X6jSPrKl2KYAXA17Pz+dODz4BorZBmatdyVr1pxAHk97GqmhHwHBceKixq7bAEi1r5etb/K6YQn9w4iXe6IkDjZXkDuB6McjAz92QEPY84oDiW94rXPuibuIHoC/Yas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547126; c=relaxed/simple;
	bh=gODwLtGoFUSzKln03siQ+IUa2xpmQmoK78tuikRkx3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIHX1n8ShbMpOL2PLsOq7pFnqd0EYAOTyUgN7sZbYV+raJf7vh17v5q5Ar1+cularTfy3jbDpxU8gmLQl9BY9bINNWNENYUl6eMYQMLHkvACemQAXtusfJYbeGloTtTDWO0LsLqO/dXBc0qL4qqHwZzAutWddj8TgZR1uk9wtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c058IzQz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def2a1aafaso8120645ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710547124; x=1711151924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gODwLtGoFUSzKln03siQ+IUa2xpmQmoK78tuikRkx3M=;
        b=c058IzQz2tZsj1RpNyJEL3HtBzkzmqLmEFPsBLQzUSDXyQH9eNviIeu4GW7iEhoqWM
         LVqPnjb4IFxGRXLGYsVfhHVBd7As+6Wm7ckLBnxc/jB93xO98yOtL7OdPhJgo7fdD+zL
         4r91OGUKR+Ajmrw/W8ku+irTYjkRTW6x0649Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710547124; x=1711151924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gODwLtGoFUSzKln03siQ+IUa2xpmQmoK78tuikRkx3M=;
        b=e0J01qTq1VXVh+yoCf43gL8Jntv8Cg0+r9UIykDi2qavQ24vNw9plO2TVsf8eEsAJP
         O00xXIP0O1Mc2lJVUJLz7UVU0OBsBPZ+IsaLMTB9LRsfV5dC3YhJo/fq03Q++XCT4hzH
         PSxkl7zLdU9J7U0Z/fzmOuB8d9uwUz05IiGyF57GRdtASwXMhZJa4ynHcADCNV6hcvl2
         2VojC+nmVF4ka5jOmvrok9COS8ogGgNQAvWB6j3bM2KtIu6RMM4p0Mb0euIJXrxUj7wo
         JQcMmL4SSbz70sYV/CaPwg3RvEyEMDcN2ZJEwZCtG/RwBR62Ts9B3rsVAYwKikPeFShY
         Wwaw==
X-Forwarded-Encrypted: i=1; AJvYcCVRIGEk2SRhekruXU8ttD2d8JknZ77iqR1f2Iq8xtp5/CtKavaqOhDVg1cdWDekNXrea6BfsZRxhzYMH0Argb34mwb8GL3xikAflAVnR8c=
X-Gm-Message-State: AOJu0YyLMmlFHWvly5yxfQSq+cYyo0aB6NLYHVahtrKsaenbvWCFACTc
	P3XvzDV693rrps9SpXo7BI4DuTm4AuVSW4sR1A8GsRTbCyJ4vVA6l5YytWnMcw==
X-Google-Smtp-Source: AGHT+IGMZzRVigj4dQKynLIVwDR0yjibYbLJNjU7mEPpu4oaAMaz8StTpp0jDEWcBwNaXn4nfVCD0A==
X-Received: by 2002:a17:902:e84e:b0:1dd:abc2:a028 with SMTP id t14-20020a170902e84e00b001ddabc2a028mr5599960plg.12.1710547124454;
        Fri, 15 Mar 2024 16:58:44 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id f7-20020a17090274c700b001dd6da21e30sm4440121plt.231.2024.03.15.16.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 16:58:43 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:58:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: kvalo@kernel.org, johannes.berg@intel.com, horms@kernel.org,
	trix@redhat.com, linux-wireless@vger.kernel.org, zzjas98@gmail.com
Subject: Re: [drivers/net/wireless/marvell] Question about a possible
 underflow in mwifiex_11h_handle_chanrpt_ready()
Message-ID: <ZfTgssw_1KBThqGT@google.com>
References: <ZfN4WHuqOIrO4Ef2@cy-server>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfN4WHuqOIrO4Ef2@cy-server>

On Thu, Mar 14, 2024 at 05:21:12PM -0500, Chenyuan Yang wrote:
> We are curious whether `event_len` is guaranteed to be greater than or
> equal to `tlv_len + sizeof(rpt->header)` in each iteration since we
> found that `sizeof(struct mwifiex_ie_types_header) ==
> sizeof(rpt->header)`.

You have the code available to look at just as well as we do. I don't
see any such guarantee on first glance.

Patches welcome as always.
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Brian

