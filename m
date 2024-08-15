Return-Path: <linux-wireless+bounces-11496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2690953909
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79027285B3B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EEC4778C;
	Thu, 15 Aug 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+mps/zp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CC41C6C
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743125; cv=none; b=ETaaRAAYdoO3IfQ1GtgiSMgB+PedFwXiNokzXxFi0nSu0d5QEljl04aXPH51Grkl7qdfByU5ZoqvNfzoSVCxZ00mp/Qc9QExUdaNk8HTZXEmoHslpGYUUPqLcs15l5ybB63wx/QcENDkYgfaDnANYYO4g9ysvvHXvDuhhiwQvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743125; c=relaxed/simple;
	bh=bJF14wmu9jsa43+2yR+/HNeL1nQvM/2EmjSz0o16s0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7JcYaNox8BpQMQLf0jVWDF3GBLNxCNe0DFxD6pdnSAosP4D4gsz82H870X7e0XHp1uqRwuispjqgxgfyk/VaW41IjZLhI9wmhTciCZ/eXqkOb16pz355OauI7PXSh5IMe+Tumm3nTZD6R++azGodJqIjzlz4cANxALA6kZoPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i+mps/zp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7126c9cb6deso750968b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723743123; x=1724347923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJF/UOMD5eEDAA8HbpPiltNYMc2YMJhbR1FeAQVndRg=;
        b=i+mps/zpqec7OWA39EeUDR6ldZZRxjf1SaUE1I+9ayfcr+x0OF/zFKuWisWwHhvqA4
         tks3FyQD/WlSNm43djYyZ57hhoEvuORj7brCekyaopRjh8tOkKIhYZIvaYqAGbAaXtuN
         YQn6Jq1Hbl61Z+/fOoTDf/Uo8WRXIozpQDzFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743123; x=1724347923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJF/UOMD5eEDAA8HbpPiltNYMc2YMJhbR1FeAQVndRg=;
        b=pYUUktr76n3wr9kC/q/9846jKKUwaH9GLgA8EOQzrikonr/KSsrvsBUy7Y11CRFkvt
         BRfQM2S9GIrbBwzlTiQwnSczQDjbD1Ga1nrpNIlUBEPJMdtROYfedKUXF9RvJiWqHk+E
         9oHhvi3CzYhn13Y6ND6z29LPrex0zwm19X0ShvGKsaQVvWAj/N4meVDZrB69kDEC7+i6
         xm2Cvct/5bB+wVUqT9sl713NPpCYvHNCAmCO2sGicZKCIoIT4cOYxeWrrJMHVzL47mgh
         Csw5ucWVeQUCqFo60TsZqCHjut49S9Gzqo7xAzWfd4pY0p3hTyJby+bNh/LwSHLejG5o
         lscQ==
X-Forwarded-Encrypted: i=1; AJvYcCU80xbQyBi4JD6TsW9HOL4U03sljktAjVlyFTqCDkg/zW3QERDj7XfrjjctZHTI7vGWWGs+CUuxlcDE1ejnb3HUqgrkNibFi96DzEbHcC4=
X-Gm-Message-State: AOJu0Yx7R8LulDGvX46/EZbF26L/2tGyW9o9S64mVDRwpyb4bFk4/bAN
	7fmKDIVGQTM76nKoFahsz67SVxysSuvEDbOhVJpL9FyQwanPQeF7rjMlUiP/jx0qzqdhSzUJZZg
	=
X-Google-Smtp-Source: AGHT+IFLsfQwfWCjQHECvs9QdlrI8dsI849S+aGHrh3pWIyHIF/blT6qN6I3iN7jmcbQFzZw6wEX9w==
X-Received: by 2002:a05:6a00:14d2:b0:705:9a28:aa04 with SMTP id d2e1a72fcca58-713c4ed2c6fmr532021b3a.23.1723743123067;
        Thu, 15 Aug 2024 10:32:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:5afb:2a2e:f5be:2aed])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7127aef68casm1234886b3a.108.2024.08.15.10.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:32:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:31:59 -0700
From: Brian Norris <briannorris@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rafael Beims <rafael.beims@toradex.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Fix uninitialized variable in
 mwifiex_cfg80211_authenticate()
Message-ID: <Zr47j60F2NjclfcE@google.com>
References: <d7d043b2-95d5-4e1d-b340-5d7330053ac6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d043b2-95d5-4e1d-b340-5d7330053ac6@stanley.mountain>

On Thu, Aug 15, 2024 at 02:29:27PM +0300, Dan Carpenter wrote:
> Smatch complains that:
> 
>     drivers/net/wireless/marvell/mwifiex/cfg80211.c:4408 mwifiex_cfg80211_authenticate()
>     error: uninitialized symbol 'varptr'.
> 
> It's a check for NULL, but "varptr" is either non-NULL or uninitialized.
> Initialize it to NULL.
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Brian Norris <briannorris@chromium.org>

