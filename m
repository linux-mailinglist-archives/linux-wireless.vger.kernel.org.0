Return-Path: <linux-wireless+bounces-7971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218CD8CCA33
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 02:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C329F282381
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 00:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF8A34;
	Thu, 23 May 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GC/q9BJc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDE1860
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425968; cv=none; b=JflJ6+4sSGyarZxJgwYGkEPKAj9fWZDu6YWE/wSEu4CJV1O/uMERi/ME22dq4aFEbLeim4ywDGqpW4kTOfeozSaNxEjPeYenUD5MSb4bzAwhxDHNPrN4v0brds6iTGelVFfAi4R0F8xcG3e828lPxQ+nMjYmu2eEmng88hLzaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425968; c=relaxed/simple;
	bh=CpuEU8gkiJ0/5ye3tcoFuX+/jEymMXGuXdXJUZl0AJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIGfx1PrORFOI/R5iXs9xaUK49UpfKoGPN6f1raFcq9iG21F4fa+q9STPx+52vSISf3XSvU1WbBfdmBKhTFXGrCh9c9v8bFbtmXvr5m+nyAPYqb7TtAoeq9JoGhe97aoBzykA4HQmbYNfi7u75l/7IPiSmsrGBj8l7uT6IH+rCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GC/q9BJc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1687117a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 17:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716425966; x=1717030766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CX8DBRwx1fNr/jRR54U+s7BTveofzSBxZ53Z/OKneyc=;
        b=GC/q9BJcPUOxeD1PI/um9ZKzVulLIHFKYZqy/RIEvk1BdOJTzH8mRHO3iCm3opE/Lb
         JnFa1TahhI5Elfq7PXWlmJJ5iDXlsZlUC8NlGCh5OuKf0EQOy3rpe8ixiPHeKKFOu0BY
         DPbjEU0xQbHWGXS3nNDb0qaJIzyXyLywgCdMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716425966; x=1717030766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX8DBRwx1fNr/jRR54U+s7BTveofzSBxZ53Z/OKneyc=;
        b=PGat3zmvRyXW9kpYoS28LvM3qr47PJzTjd6lgbuM4XqcRBohAholp9IT6Sy1nw0u62
         4RxZEheXC039ucgjsK6L72EIph7M9RoBb5+gazp820jcMClU/acfHb9OotGqwCJ526bH
         YJ07OAKJShEp+3AyZYNDU8NwJXkrmwM/P9/DCRQ3IF82fTBzyxdgNnatCdtLdsQREPu+
         SgZyNj8q+2CGoixRZjdUCGVYSLp24SWX9zXi5xXtISvR9D0caQxZmUeCLCFRF0t5te38
         MkjFY1I0m7UtND0k6KSW6cLxJAgbNd3+hanE77nXOOSPNwfDh8BcRUpzAQdcL/niaHTE
         24/Q==
X-Gm-Message-State: AOJu0YxCotxDreIajei0QTI371lQloRpadauBYMQsy0gRQ6xFcsEcrrR
	4vHOtV3fV/X6MGX65hw7+Diiy2OTXlEAsF141G1i9IM0s1vt5DLQnyUrXdb31Q==
X-Google-Smtp-Source: AGHT+IF1kq0qc68Ti7q1/FxLfV3UPXpGc8WblBZGdDgOdUFW4QXyJFtxHjX5YhmqDbo6ItY/3CUtUQ==
X-Received: by 2002:a17:902:c409:b0:1e4:3909:47c0 with SMTP id d9443c01a7336-1f31c9f7048mr51825565ad.62.1716425966480;
        Wed, 22 May 2024 17:59:26 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3a97:1cc8:ab6c:8d0f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f30fe572f2sm35823005ad.131.2024.05.22.17.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 17:59:26 -0700 (PDT)
Date: Wed, 22 May 2024 17:59:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP mode
Message-ID: <Zk6U7CYW2bP-DVTM@google.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-3-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418060626.431202-3-yu-hao.lin@nxp.com>

Hi,

Hopefully-last comment for patch 2:

On Thu, Apr 18, 2024 at 02:06:26PM +0800, David Lin wrote:
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c

> @@ -1712,7 +1735,7 @@ static const u32 mwifiex_cipher_suites[] = {
>  };
>  
>  /* Supported mgmt frame types to be advertised to cfg80211 */
> -static const struct ieee80211_txrx_stypes
> +static struct ieee80211_txrx_stypes
>  mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] = {
>  	[NL80211_IFTYPE_STATION] = {
>  		.tx = BIT(IEEE80211_STYPE_ACTION >> 4) |
...
> +	if (adapter->host_mlme_enabled) {
> +		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx = 0xffff;
> +		mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =
> +			BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
> +			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
> +			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
> +			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
> +			BIT(IEEE80211_STYPE_AUTH >> 4) |
> +			BIT(IEEE80211_STYPE_DEAUTH >> 4) |
> +			BIT(IEEE80211_STYPE_ACTION >> 4);
> +	}

This doesn't look like a sound approach. I think you should keep
'mwifiex_mgmt_stypes' const, because if you're making modifications to
it, then you may break multi-adapter situations. Consider someone loads
this driver with host_mlme_enabled==true, and then later registers a
device with host_mlme_enabled==false. The second adapter will get the
wrong values.

I think 'mwifiex_mgmt_stypes' is small enough you might as well just
make a second copy with the MLME-enabled values, rather than fiddling
with modifying a single copy.

Aside from that:

Acked-by: Brian Norris <briannorris@chromium.org>

(Feel free to carry that to a v11, since my only remaining substantial
concerns are with patch 1 I think.)

Brian

