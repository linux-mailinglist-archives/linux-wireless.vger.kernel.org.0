Return-Path: <linux-wireless+bounces-23465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414EBAC626E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190C5189F51F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CC9206F23;
	Wed, 28 May 2025 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NVOgWHQn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8B22ACD3
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415443; cv=none; b=gSn5Ppz/og2gXzveEc+bXoGlBW+6yV9ITOM1LNOKPp2fkz/UGM+iEwiYn8/MARnXMj81wiSqmcy2TxMtuJZhVIWxsALF/INj5QsFWEsT3EhK91awTNqLMl+7LByBBb2pME14F7ZowzC+5tLJZnx7K2n/oYCWC99CIbPwRsd0Axw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415443; c=relaxed/simple;
	bh=rog1aO13HU5eKghFpRoK9e6lQ3YCvwqh+Wh4tYN8qHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMkNXb3preWIa5r2vlSPLTtPLqMvEP791yrM6Gh4qn77uVT656uSZAQ0P+e4tikrhdAQ9x+vc+zK4H9Te88ii8zruFyU8Sp+3UQkeWixMmXQkosmdzaID+Alsf7geFwCvI5Gn2eIsP0NpE1NgGh06JwDT2JLY0umQKFZYmIPgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NVOgWHQn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22d95f0dda4so45717615ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748415441; x=1749020241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJf2emHEfq/X781Clwbr6MSwesl5vhnwmA7nNE86Ctg=;
        b=NVOgWHQn1hnmwgFNnK5wQ6eQSspQ7uxf4MLmQUagRJVIlgwGBETIKqlzn0xk6F8/MK
         Op6K6RogFzGYOukxEOkdoP7gOdZMGTy8IYEle6UEpVHVwyYbzJPx50xuYOnys83WwTa6
         nZyHPKoCo+WybZdnu3MvhXv3+lWqYlbguITDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748415441; x=1749020241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJf2emHEfq/X781Clwbr6MSwesl5vhnwmA7nNE86Ctg=;
        b=eaioKEqhBE7At0o5hgH6CQZV4qkz6H2sZ4gHnNYigJR8jGYR63i3bD5blg4ICNldwL
         A8E3ouzH4GPHx6R8hfY2+RcqHc7352zKqCKwhd73slytU896A145743+E8yt9OvHj/Wi
         gAs7yz3iIhse01nHexWuB+i7pPy404wSbVsWfk8tKFjzCBbpbyf2flQQHVFNRELG+7zh
         oWFt+BmJRL0ifZqrTQAzNA44No67bkwj/OagHBZOybHg+d9FtEl/mEe0BAUJI3MVkiqa
         54giG8sT5AYXyfshsQEQhuTWnyiMEcqyEFRsKe0mWVqcPVcnJaQ2QLcEyGBUHQTwFQVe
         iFzA==
X-Forwarded-Encrypted: i=1; AJvYcCVw47nnQ4ZPOvf2Q54H1WFzpyTOB08XvCAhAxkzPIzCY2ManxRH/qwctMB7DmmTYJctZHaYoPbd9bQJd90/Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbQykWL2xVGjsH2jDa+PmtqoP17OD1iSisTKIWlCSSMN8hQKk
	Tk17V/wlywi66hR2pDCTRNWyuuNsHEZTI/m935k6X4ks+iqIHxKabD2nrSqu+iWl8g==
X-Gm-Gg: ASbGnct5SBkoq0rDCZrkbFiaWuxMXSYpcvq/RXK2ShLPiA5UfOQ/YSCecu/BiZ6Ex9I
	3AqQPKx5csXZs1nXRRYcY6+7I7+DEF2FuYeQGRlxQWSMn6bxvjxmtHeWWgFBXvMIzSCtILcWgL9
	WcP9FUywnwtJ3Gbsq28muIPcLQldyLJWSHhqrQDW3DTybbsYupEuYxaHKaD20hLbt0SROo8IAsm
	91F3LN2/O4IUT6LOWbvoph6V9Gzwy9ygiw8VQdRUj10nB1HxjevnkvzomybUzry+9z40uC3VcOH
	kxIQP8AIwwpVjdEs0sV+3UTMYgX47hTiO8VqdmgMT+tZXT2QyX7X
X-Google-Smtp-Source: AGHT+IErFYP5ybzDLBUxNWWiAUfzYAgptPpNppOu82TA1YA5H9SJxLXCw5ie4h2NIJ0vK76PvvWdCA==
X-Received: by 2002:a17:903:185:b0:21f:35fd:1b7b with SMTP id d9443c01a7336-2341500bbcemr205484905ad.50.1748415441191;
        Tue, 27 May 2025 23:57:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:88fd:67f2:b90d:8b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fe186asm5332355ad.59.2025.05.27.23.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 23:57:20 -0700 (PDT)
Date: Wed, 28 May 2025 15:57:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: mark reset srng lists as initialized
Message-ID: <utofrwmlblop7re2ak24ni3wmlc4i4xx4jwwtd4dpg2gsvrpxy@prbr3vjl4qsu>
References: <20250528065510.2790649-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528065510.2790649-1-senozhatsky@chromium.org>

On (25/05/28 15:54), Sergey Senozhatsky wrote:
> ath11k_hal_srng_deinit() frees rdp and wrp which are used
> by srng lists.  Mark srng lists as not-initialized.

The subject was supposed to spell "uninitialized" instead of "initialized".

