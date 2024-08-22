Return-Path: <linux-wireless+bounces-11813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C195BDBB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD311F24A66
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3EA1CF2AC;
	Thu, 22 Aug 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HdmhTDMH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138761C9DFF
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349028; cv=none; b=PCRUCJDKaOEZOAfhSWoTTOa0HwLji7flcvzdn3x4W+3Wp5Q9isnj27Sbp3K3VxgAYFZZSIKIBjYSEEEvqRV5CAuV3VB/yR+hY6GSk3Zd9EKz77o5pem+ulqpewvvOuYGzo/rZLQZYoX6T6UWPDhxJgE0niog5OK0AEiXS/QG5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349028; c=relaxed/simple;
	bh=dvjLhd87vCdRo/xiVsfDDYj5ouJ7dOsDPOl5m/jQnB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN9PTLjEkIWdkkB8rSI6PzlQFXeGHIZJF1EXibHgC6VFjGjMznFkcC2jk3uetOhfrDKcVKWaGJJVD6jEFRqRvIp2VRK8WFrJf7mDHQDxkRJ4aRoQ4NYRrMm/0zdKaOa1rRHljXpdInLdcqwaGaUtv5LQU44jHtOcatHJW8TzVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HdmhTDMH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so839431b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724349025; x=1724953825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCVHnlO2pIa86JaK5QjGr85qfeXpWfBdUE9lyP9m+/o=;
        b=HdmhTDMHdO0Cld6OncFcPIZAjg/uddeimxjulI3Ld4XVDE5G+5872NDI0wXrAVpx51
         uGbPsNkdAXEOyZfWZNgTi//CDbasczllkNQiMCBZ0gblO9nFUTXxjfYLfVyJVB4Aq7n7
         owSWzVTi64B+XpCgePSRh/V277TT/NWvHyv9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349025; x=1724953825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCVHnlO2pIa86JaK5QjGr85qfeXpWfBdUE9lyP9m+/o=;
        b=l7BstrcTD/E8e9176jxuQB9aKeZkPEB24bn3ed36ZT0gJS5eHBLVclisrYgM+NJo4E
         /hhGFxTTWdEZGBVF6wS68Ilz4xWpoCjRaQyZ2fQ4DHm5eAwMlwwvigLsbpVb4l4F0C+Y
         6sV8hav/Bt4p0ufO/x/xaZZjYlZVkVbRqe4nuU6UKUS51zxKe95jk7fNAKH9TCKTDm03
         HR1Ed2YXLVaw8CqSYBqPLMOZ2xAGBiIO83CsVNCQNkbQ3LZ8Ojz1RjtBodRqfxgp4er1
         cXAph/5B4tdny9p45i29/D5zzh3lkLvqVzv2QRUt7/65j3huQdOTQRYh1QotHpVM9Ndb
         QsNg==
X-Forwarded-Encrypted: i=1; AJvYcCU1B+3283Tj0YIJ+Px3StDLKYs7FrZciZDK4gJJzExRxQ9yNAFOU4UMvXYTcZbDvoeclCklpQRz2zwibsLjUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAOItf+9tn22vnXEqZrUsTHwesybMd7wTcdMv5opPuhl7Fhy5
	htQhgitb77zlk+bEhT7hLchRM9Ww7w2aFTOmaYyMMBW/yJ8168GzzexEXB308g==
X-Google-Smtp-Source: AGHT+IGfoGIJeQ5mwpQoLfvcD1BDbE9Q0hdoNktosEIXDb7FIO+5WC0W5xfEfFjtY5088xV28XfHJg==
X-Received: by 2002:a05:6a21:3418:b0:1c6:f043:693f with SMTP id adf61e73a8af0-1cada054f37mr7146439637.17.1724349025477;
        Thu, 22 Aug 2024 10:50:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:414c:5b44:2fea:fb6e])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7143577090fsm1537422b3a.137.2024.08.22.10.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:50:25 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:50:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_cmd_802_11_scan_ext()
Message-ID: <Zsd6YE6z5CNWQocz@google.com>
References: <ZsZa5xRcsLq9D+RX@elsanto>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsZa5xRcsLq9D+RX@elsanto>

On Wed, Aug 21, 2024 at 03:23:51PM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with a flexible-array member in
> `struct host_cmd_ds_802_11_scan_ext`.
> 
> With this, fix the following warning:
> 
> elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
> elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
> elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Closes: https://lore.kernel.org/linux-hardening/ZsZNgfnEwOcPdCly@black.fi.intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Brian Norris <briannorris@chromium.org>

