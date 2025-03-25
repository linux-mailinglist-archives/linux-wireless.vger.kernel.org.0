Return-Path: <linux-wireless+bounces-20814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D68A70CDF
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 23:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191AC176413
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF1269CE5;
	Tue, 25 Mar 2025 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vi7sb70J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134926A084
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941604; cv=none; b=cjh15R41/WFq5L9m4qIhbTGE+I9zFGx1LtmRKU6LfYi+o1JLlyJLKQawvdUxiRHdkw0CPcPBufyzL+V1rNr8WMl3Kfj7rsCeslN0J1VCoGZ3yqRRuh4EuOUU5/B6l1kZBlH5QdcG+06plm+M1a6nXjV0fJDt1gotRTRj4loy0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941604; c=relaxed/simple;
	bh=Ax/xgb3TsFCNXd+hqnMtNKg6gGOsr2N5FRf66cIOIgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNrXec2KsPBvGGI3o0XDdPqkDttgq4CodSZBBpHG9i/aRNg2z5nZaAPs1G1ymm+YK5tI+JVwiUH1jfG2qg5BfvtpSiVA6qj3syBgmQQgSEpkbQcmg+Dyj65exQYl9nnOfs3u6f40r87JGdqB31xBj1BsRUHiaBZJdzS1K5cKIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vi7sb70J; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso122114815ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742941602; x=1743546402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax/xgb3TsFCNXd+hqnMtNKg6gGOsr2N5FRf66cIOIgg=;
        b=Vi7sb70JtuukLn5QGDZk04k5Cnb/LmkT+4Bcd5F5LF6Ue7BmnVPKXComjR0tj04gIw
         iukAnQ2ki9J5FupWsM0WhPvw8VqRm+G3jEzYb3m9eoX/n7T1x2gFGdT7qLzq+ZDRafqB
         34LDoKzaA2fwQXL5FtT8v5Tvy8wLsQO75Qw2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941602; x=1743546402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax/xgb3TsFCNXd+hqnMtNKg6gGOsr2N5FRf66cIOIgg=;
        b=feOrVGEnEWkvWmA1G03rklMo7TIuiMBENZngfsCVa7H2KeUL3h8xYGWWOqmUSqiaJy
         QvKD/ZYvRBFzuTjXDogwemvUcOxdXAcOiuMMc7CX9ZRQvRuo6eqQeJNVztJP3YE8Mc9G
         +3qD06Q7JlgtABwWcSpBcrb5bOOkhexxLyMXUgW7Y7Jk/krhclYTaNAfwoLzR30DgOh/
         paYInOFiaRoa0oM+sb3EsrX/nmSV7hm3rcP4jTJWFXiykH1qC/0CwKoMcez+MLTrH1ds
         Aj17msUQJumP9KBD9QrlTnvzrBbW1vpFS1b8SJqHSW6m1r+r+FkhftVGJDxMzL4ExD8J
         d0ag==
X-Forwarded-Encrypted: i=1; AJvYcCUbSDhrID+SJbnPQP+4KNklLZKq/HoCOFpwPyRyp3M5cqq7SrIydJv89ALSXfMqmPgSKXUenG+Ys4qmUWAuPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEz9ttpQxu/Bp1KHumhkRBh8dpPVUoMvl5B208VcZIVfHwkIp
	z24KSE1202dK8LnTppQnOj/QZJFT9EAyQeT2ypEar2IX4Al65wjtkgH5oKO95Q==
X-Gm-Gg: ASbGncux/u5bctTA9bulzUlUMQWVAx3PxWWuku8FErbjaBguQ/nBtfPXZiq6f7a5dj5
	+ltLnF9F3qHx1kH3RjWB3gy9uWEF30Cs8T6EvmhkxtXMpd6w8lh55MZSpBW2Rt4wwLHOXUphWdq
	rdHdvvRtbj2qQiJwoqedVidUhJNretM6mu2zTiR+xWKEXLvgItK9dMh1VxSoxutwWllZza++zrP
	jpdvIL/KeN1pdhzo+BykGg524A5VlsArLAP7sZTZlWby4BcVXS+Gb7vKQDCEOSJakuLv1B78bha
	6AQ5y5ebMvaZYwYFlqUy9Vr3P/yzx+n/GdSCxGnpdUtUdj4cOw0zq8z5zxxaO8U/cWjtHsOadFl
	Kq2BRnhc=
X-Google-Smtp-Source: AGHT+IHVHlRkM1Xo1gijBPKRyHa63UrZO0+fcBb9I1JM7qtE52PfSIfTdRLQC0cXlJNB8zkMo6XFeQ==
X-Received: by 2002:a17:903:3285:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-22780e122c6mr238387615ad.40.1742941601896;
        Tue, 25 Mar 2025 15:26:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f39d48sm96249485ad.37.2025.03.25.15.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:26:41 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:26:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH wireless-next v5 00/10] mwifiex: cleanups
Message-ID: <Z-MtoOCLX2_1GztI@google.com>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>

On Mon, Mar 24, 2025 at 02:24:01PM +0100, Sascha Hauer wrote:
> This contains several cleanup patches for the mwifiex driver. I dropped
> the MAC address fixing patch this time as it needs more discussion, but
> the remaining patches sent here are nearly unchanged from v1 and should
> be good to go.

Thanks! For patches 1-9:

Acked-by: Brian Norris <briannorris@chromium.org>

I had some issues with patch 10.

If you respin before Johannes applies any of these, feel free to carry
my Acked-by.

Brian

