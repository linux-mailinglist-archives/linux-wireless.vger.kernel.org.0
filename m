Return-Path: <linux-wireless+bounces-14888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56999BB9DF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582FAB215C3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15601C1738;
	Mon,  4 Nov 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJv5c9rP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7621C07F3
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736665; cv=none; b=i8zdSf8Es0e84ZOegwJRyCHi/drfaQr8GT7l7hzX3fmD+kYlqHHwGLlcDnnUPVhUmNR1FfvWwh5WBKyNjzNRGd79H7KZYXuXOjF8LqAvcfWJw4FE3w7Fz3v9sWXvlSRlGB4ESs42WZV2GF9dXLNLFG7NSmlzYUR38us8yd5DAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736665; c=relaxed/simple;
	bh=oq0MHL3CLJd8/YsJe7HnPmPURjUl2rwEZGr/iD/Sj00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc4s7/0Y6za0KewnyAV76Gob0PaG/qrTe+/5AbtJC4i3eSHlSIWzlUUf4sdjgiA85hJQBZ0SPUwfadvvpEinIweRYazUKhKD2VAo+sk5RkN2TEGigSzfu9pwhJI6EvvhmIiZiVHIT3jXaRUH+dhxfeF6BFfPRlcy4UlHg3XQg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJv5c9rP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431616c23b5so26491075e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 08:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730736662; x=1731341462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LK0NvUMhsScOGKvQngx/j866I5wUItHfVHUyQMoJ0LQ=;
        b=NJv5c9rPLVSBNwT7lgzB/7q4ZYyXHkobjwlZSEBwIix9qeXDjHcLBfrbx1wTwn6Rmp
         cGnxZGCuBqK75uzjWl1BP+O3V5/cPVuGgKr/p0J6TF01fca/hdwily0jjJugZ4XOoY29
         rvZybd4XP4LS1COe5+rpqrPNjk8vlmEB7nxI+qkVfPqRFVOdLBaw25lndVRl1zyt4aRS
         UHtFsKyBwl5xt+DLrha7j8UiPad9FUUydWDafprWIUCvyKWeFp0XBgnnqiAclPrualsi
         X4JZL1jyZXvrE3LKnZ/cc8lqKUENXM29I5bd69VWkqaH2/trH6cR9aC+jbHIcvGM7hdK
         Rqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730736662; x=1731341462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK0NvUMhsScOGKvQngx/j866I5wUItHfVHUyQMoJ0LQ=;
        b=KOnkERY9rsKBqjFET4JmuqLtgFzgVgF0uDX+gFvE03FABERl2/LH58NWHTzPePW3cn
         DRXDJV/ptRrwcGntIOXClIGzJHJr9fz89Wf9Jg3ZUhRxhkVoDeSHnPaioSm8gSA/6UGk
         lE+b6dABV//0F8ihv5LwsTvQOPy/kzRd0m5s7cc/+pENhAd91TPS+HwxbLLyx0XozoBW
         yBPKjPta865J9xCrg/aq590+5XEvo/0ub/jR3vQtBDuJQvjINK0/OqsxMcsIH5uBi5yd
         nGFXpGTHLH9f/YGOU7LFABuHfLrPLN8bL3j+2JpaDjA5bC0FaMVcIMH3YP3NTwA9kZ0d
         zFYA==
X-Gm-Message-State: AOJu0YxigUQJJImyDQTJqko9CwCOYdNnIOz20UQrTZNnUFMORMSueqWt
	0Jj3Dni84AFR1b4XDXc0sMLef0ChG/7UkFJAFE41IEp5doNbocdlQVu7+KvFoQ==
X-Google-Smtp-Source: AGHT+IFnfTERJ8sNYvRifaDxUJfUUFgMpJHz/8Iah/3cnyDZADJ91EdK72UhuSobXEs2DURC6NERzA==
X-Received: by 2002:a05:600c:35c1:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-43282ff61d5mr100582645e9.8.1730736662302;
        Mon, 04 Nov 2024 08:11:02 -0800 (PST)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910902sm191391705e9.14.2024.11.04.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:11:02 -0800 (PST)
Date: Mon, 4 Nov 2024 16:10:58 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Message-ID: <ZyjyEl4kzFXz7tTB@google.com>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>

Hello everyone,

On Tue, Oct 29, 2024 at 01:22:11PM +0000, Aleksei Vetrov wrote:
> The channels array in the cfg80211_scan_request has a __counted_by
> attribute attached to it, which points to the n_channels variable. This
> attribute is used in bounds checking, and if it is not set before the
> array is filled, then the bounds sanitizer will issue a warning or a
> kernel panic if CONFIG_UBSAN_TRAP is set.
> 
> This patch sets the size of allocated memory as the initial value for
> n_channels. It is updated with the actual number of added elements after
> the array is filled.
> 
> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
> ---
> Changes in v2:
> - Added Fixes tag and added stable to CC
> - Link to v1: https://lore.kernel.org/r/20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com

I would really appreciate it if someone take a look at this single line
patch. It looks like v2 of this patch has slipped through the cracks...

Best regards,
---
Aleksei Vetrov

