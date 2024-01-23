Return-Path: <linux-wireless+bounces-2420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28774839C94
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 23:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2591F27577
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FB54674;
	Tue, 23 Jan 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0NzgG/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D096AAB
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050356; cv=none; b=NpxCD655TjITNRnK5DPJjZQC42RyOiI//INTjyw68/xvjtz+HQIAADakvmJ+TmQqRTFzT7g1fz7lTg/+tfYqvq70/RuElr9MTSLYxvMKcoiyeW3G7c8D86b6zZFC4/chwViJ5O3SsxegEfBg6QXI1RB6CXWd3WC3FaRn6bwG+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050356; c=relaxed/simple;
	bh=cM1u6TyGETJjhtJrO6J7JSwAWml7G37TEKeViMrmnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJN1Tylbm/xV2sT/JpAk3jhppBjOed+taYcsGATwRSXKONi+Zq4TPDLuQSi9YPcZcbI8072nYUkYDt3xuYE1Eey1vEtN4F9G2kDTqiNS2p/pIHJdrcWzVhASzJuekS6j9SVMecRMImJG/6RlmFmBrSkInsEeVvI/FCynZgBghyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C0NzgG/D; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59998b4db25so1116721eaf.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706050353; x=1706655153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8OzyRNimHg6MWBPPPferJ7a6OpiMFAs+H+g4XMLgls=;
        b=C0NzgG/Dtgm+JZP1sZbWdF2MiEiKlGVX+chQ+apBliQQPqDWONqY4GsZUHsOZ/l4Tn
         VefDp4FH0thNeBBWbqtlKuOcCaOLGBwYxYIk+IpCz8DDHVTD3a2GUMX7ciLC3Uo+Wj7K
         h3otUX+cogjgJNcr3/aviv5gOGCdMxmi2JtKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706050353; x=1706655153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8OzyRNimHg6MWBPPPferJ7a6OpiMFAs+H+g4XMLgls=;
        b=OKZrSE6Uxp/zVflh4kGTa+oWbWBSYYVJQgj1vCQg62jTFlriyUwkkKoMIQMDiqj6r1
         yIdNViCmLuzHkyHy6utvCGIIrxpDZus5gPTTMiIUswOkFqKqAmgVYdpQn9o+p1dQ7pSR
         vRuFeU1XFhJE2bDXQ7dtGZ7v0PcGjq/C8Gc5QpbWamdYiGykdB/+n3KZ40kzhZWzPTua
         MxQjW2icZ6vX03Jg7zkRaTPi6d5y+6lXVKaNHfnXYUo0FE6QL7tufbFSAl0TJ2N0XIdH
         t99uIBu4nfLFrgP6YZKP79KtZlTSpx34Uf65xd6JIkuqB/gqcS7P80dlsdwgT/BJ6vpX
         7qcg==
X-Gm-Message-State: AOJu0YzGcACpZWN2zWlwGfuOGVYl6VRBLqIo1FPTqAz4NeYki7eorP6t
	KzvIdDQYvQxrBXU0HULIab9UfWffAaBCyC5ED6tSffLv9W0NfDtyzq459DAclw==
X-Google-Smtp-Source: AGHT+IHDl/6I1rG7FFOH5TLpxkcvik0AXWrRwPOVODwTcq5RC8mUYxoyhnLKMEDwXanwWecFPslILA==
X-Received: by 2002:a05:6358:7e49:b0:176:3715:3c32 with SMTP id p9-20020a0563587e4900b0017637153c32mr3147609rwm.3.1706050353056;
        Tue, 23 Jan 2024 14:52:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e33-20020a631e21000000b005d0796e779bsm2079685pge.12.2024.01.23.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:52:32 -0800 (PST)
Date: Tue, 23 Jan 2024 14:52:31 -0800
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Max Chen <mxchen@codeaurora.org>, Yang Shen <shenyang39@huawei.com>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/82] wil6210: Refactor intentional wrap-around test
Message-ID: <202401231452.2A37D157C@keescook>
References: <20240123002814.1396804-41-keescook@chromium.org>
 <170601063238.3962299.12030024839048269322.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170601063238.3962299.12030024839048269322.kvalo@kernel.org>

On Tue, Jan 23, 2024 at 11:50:34AM +0000, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> wrote:
> 
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> > 
> > 	VAR + value < VAR
> > 
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> > 
> > Refactor open-coded wrap-around addition test to use add_would_overflow().
> > This paves the way to enabling the wrap-around sanitizers in the future.
> > 
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > Cc: Max Chen <mxchen@codeaurora.org>
> > Cc: Yang Shen <shenyang39@huawei.com>
> > Cc: linux-wireless@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Kalle Valo <kvalo@kernel.org>
> 
> If you can edit before commit please add "wifi:" prefix to the wireless patches:
> 
> ERROR: 'wifi:' prefix missing: '[PATCH 41/82] wil6210: Refactor intentional wrap-around test'
> ERROR: 'wifi:' prefix missing: '[PATCH 62/82] mwifiex: pcie: Refactor intentional wrap-around test'

Ah yes, thank you! I will adjust them.

-Kees

> 
> 2 patches set to Not Applicable.
> 
> 13526631 [41/82] wil6210: Refactor intentional wrap-around test
> 13526632 [62/82] mwifiex: pcie: Refactor intentional wrap-around test
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240123002814.1396804-41-keescook@chromium.org/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 

-- 
Kees Cook

