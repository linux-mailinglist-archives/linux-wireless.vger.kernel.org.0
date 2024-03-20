Return-Path: <linux-wireless+bounces-5061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66788191B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AEE286426
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92D4F8B2;
	Wed, 20 Mar 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KCocj90j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79CB1DFC6
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970118; cv=none; b=kseyZVBcBtpjDmMQmsZNTvw7IzDCXtWE9L1GEhqPiQRKElCHiVK2v8xG4foX5TahY/UcoV3Fce1VlIHekks7tbVNW0boZbfzLvRY3jSa3w5hwAcD7gt5nDYqhMwRUMpf27U4sZAlWUSXJHMk9e2Y6coMsSgnYXjFo8zaLRoLcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970118; c=relaxed/simple;
	bh=mh/HxhPp9i97mC1VuDIbHEVd91dhaAEp1Bjk44jT5fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBIJD0lP1KqEwN+UIA4NuIusyVEjV3OrSdTuAvNNaO97gQmjmQE93bHjncaXo1xCvdoRy+KOBhDfVdKh7sSa6YTI9hVfG2y24rQDnncADZVSDRr5FDZcsdOZ8CWqqAZN3itMf0QOn6EKcNmDt6nWnMsS6N+Vyec9fEqDG1w9+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KCocj90j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6082eab17so356286b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710970116; x=1711574916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XI3QkOwZqtEGEx+OWmx4gtkRygEIOYcGFpQlI1fX2Y=;
        b=KCocj90jQis1pOqu1ZN11y0IC7K8y8XORNbbE2/0h3/Pb6ukKgfih23fzpZo5Kwr5f
         U8tl3PDApsKLzgw9DSHSP/xP1dIzxMTueJ5BqiI51tgOOHuqe5lxWvHjFI5koThf1qnJ
         gwbh5Xj+609nZxyluh6HLAHYZfTjcXEQ468y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970116; x=1711574916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XI3QkOwZqtEGEx+OWmx4gtkRygEIOYcGFpQlI1fX2Y=;
        b=fp5rkvuN7wn09qDbPWMB7nDp9xAQM2PM9iWFJgwovZu5Bq2LI2xH6SBoWMrY4YKI6g
         c4sS9lQC/aLU+Lpgcc9j2F5UXGESQ/6BvUSm6g5b+chUDfhiFdzz0ldiXNtse2qWfSdM
         7zlks7PLBsR0bJ+pNsRiHgMEyD9NOoMvlhfIAb48eiSiEUPfswYE5O+lLYpMpQhpknFy
         uwuVI6t2K55YOwc/XqUvmn4Y5zEwBa72p55zY60BPs4YQ0mIcWhuhHoPbXb0ltYtNVxo
         4grOcu0lgmndJiVWF20ISKsTOeyeRwiX3/vxbObYYRBo3oE7DmFysYAQVf1bRm6ufMsW
         hh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLXWSN7YZSau4OYbGuIvO8awP/H2lsST3Qgc02oK/xtxzUQ9XgydBTOH8Bib1Cp7bkIPYEG1JXLdOyTHqlhgq/CfK17m5GO3cocHBABP8=
X-Gm-Message-State: AOJu0Yy+Zm1d1Bdb89VfBVcO60DMvM5wyaKCQhljUvoNKYnnS9JagUX3
	DklqONFU/xh4L8G0FxOi43wbOrfcvvew//sIH/xqwbtU03Nsd1OvVvVELSDj2w==
X-Google-Smtp-Source: AGHT+IHCN2B0PBhcokBRVUeOlwIbTQPKdL42LmiNEd5VobsohfR0Z18dPC60k+Vl60uyEaFsjxaPOg==
X-Received: by 2002:a05:6a00:b84:b0:6e6:f9e1:fd07 with SMTP id g4-20020a056a000b8400b006e6f9e1fd07mr19878333pfj.10.1710970116076;
        Wed, 20 Mar 2024 14:28:36 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:8598:2b3d:6e11:4163])
        by smtp.gmail.com with UTF8SMTPSA id b19-20020aa78713000000b006e6c3753786sm12080255pfo.41.2024.03.20.14.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 14:28:35 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:28:34 -0700
From: Brian Norris <briannorris@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, tsung-hsien.hsieh@nxp.com,
	rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <ZftVAiArz_qu1jur@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
 <878r2fevu5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r2fevu5.fsf@kernel.org>

On Mon, Mar 18, 2024 at 11:24:34AM +0200, Kalle Valo wrote:
> Francesco Dolcini <francesco@dolcini.it> writes:
> 
> > Hello Brian (and Kalle),
> >
> > On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> >> This series add host based MLME support to the mwifiex driver, this
> >> enables WPA3 support in both client and AP mode.
> >
> > What's your plan for this series? I know you raised some concern when
> > this started months ago and I'd love to know if there is something that
> > would need to be addressed to move forward here.
> 
> Based on the history of this patchset I am a bit concerned if these
> patches break existing setups. I'm sure Brian will look at that in
> detail but more test results from different setups we have the better.

It looks like the latest patches generally avoid touching behavior for
devices without this feature-set. And I've given it a bit of a whirl
myself, although I have a pretty blind eye to AP-mode as my systems tend
to be clients.

Yes, testing is always a concern for invasive changes, but I think we're
in OK shape at least w.r.t. regressing existing setups. Or, I won't
provide an Acked-by until I'm happy.

Brian

