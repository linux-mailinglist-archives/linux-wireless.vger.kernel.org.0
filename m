Return-Path: <linux-wireless+bounces-5041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E760D8818F5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37CE28366B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D58562E;
	Wed, 20 Mar 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H5MRRhkY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6212B97
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969207; cv=none; b=rkOzmvh21nS5J2KVMgm8D21fktOsw3ru9ByAZxW79hvqahXIHOjBaGanLt7RquJrJwYFWH8EEl8AHSz+JMovsg8rNs4+PfmgqHlncj507MpVIEqonJxmuu3BNB1FPagjWhz0qw4b/j+hlnJ5xZgfg+jTMHIsKJVEwue8DZUQhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969207; c=relaxed/simple;
	bh=NVi+vcAVEgF9R3S44WE03lAkRfqkBmKGPJxLBY/3iZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l14wvX0XDSQD9gxvgzKwTg5zx/xuQelvMzgRYRNW37kEzEkMDzVFj3zLOWQOHctmKrU/okkNiU31DOP6r1yEQ/+XvpqYcxbh8cG/PRbZQuUpbOW5QYnncvtwbuLAgunLYLspQBl4wWeweol6OBbfEv6PVde60xYOPJZ+t8NwqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H5MRRhkY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dee27acf7aso1877035ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710969205; x=1711574005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hrhAdvacwtFgAecoSHjqV+1IjYrudfe2yxm0DSIjUc=;
        b=H5MRRhkY1H6N8FEUXE1s57alQwt0+ywDqGw3nRE7c/Tgu2vXPh5zDSvfsJtbbmGuze
         JTHOVgp7Emb+5hHCHRQ2bEHfG1xjGntFKjKDIzkiHkzSFyebSCPB/p8fiZ8Y+J3R6oho
         azV37GLRs3zONOQX1HvB7MJ31NZTz4mZ21EPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710969205; x=1711574005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hrhAdvacwtFgAecoSHjqV+1IjYrudfe2yxm0DSIjUc=;
        b=U8vodQtQkHzK7B02MW1zeahTRouqM0pFVDJ5BPf0koBuDUJ3+RW/y3U1JyZ4nqgrX1
         zz0yD2wWbmutCkaxrCfCGCPsZQtf7/owRMjEnLCD/5I4VIIa2UUVZJ2yvsjX2ppe0VNL
         5YfnwBQWhW3MX/ezvjGuFnzeAQDFwur4ZFQTXnNASWERKjmxVxycdNlFZAXkrva67swF
         icinC0k7xe5fI5fNruR+/JqkFVh6VvjZK5yyXCqz2TJFgDzp9Znl+GdOPdFCMYL+q2S/
         DrRegYSimPq8AMOhSQowfUCSWXk4fprIFT0f4Vd/TxaV+5tXFbRx/zPESMgxBEaIBq6z
         CMfw==
X-Gm-Message-State: AOJu0Ywm7myQd5KFOC2Tmzr7Fp5rQVm9tJie8uNtfe3iK5PKJliHVof/
	hmk1aCeXPFFOOgXMzfYUnfJ09H64jlz02hsmIDYEsT3NJJlP65NWbI+/F02rSg==
X-Google-Smtp-Source: AGHT+IGIAq8iLg723by1a+a246+lqYpGlBeuedEfSl1ZxJDHAqdrZl0MqFJiXg4yCvXjtAi7S3odHA==
X-Received: by 2002:a17:902:c942:b0:1e0:444:5f55 with SMTP id i2-20020a170902c94200b001e004445f55mr4272915pla.47.1710969205306;
        Wed, 20 Mar 2024 14:13:25 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:8598:2b3d:6e11:4163])
        by smtp.gmail.com with UTF8SMTPSA id z5-20020a170903018500b001ddc83fda95sm5854661plg.186.2024.03.20.14.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 14:13:25 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:13:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"rafael.beims" <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <ZftRdB5_Po-1Qnb7@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <ZfTiz_fhzPwRk4Xb@google.com>
 <PA4PR04MB96388A076FC16CF4C76F661AD12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96388A076FC16CF4C76F661AD12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>

Hi David,

On Mon, Mar 18, 2024 at 02:20:56AM +0000, David Lin wrote:
> > From: Brian Norris <briannorris@chromium.org>

> > I'm not sure if this has been asked/answered before, but are
> > the MLME/WPA3 limitations exclusively tied to the firmware support ("V2 Key
> > API")? Or are there hardware limitations on top (e.g., some firmware might get
> > "V2 Key API" but still be unsupported on a given chip family)? Could other
> > chips chips theoretically get this feature-set in the future?
> 
> If firmware reported support of V2 Key API, then host mlme can be
> supported without issues. There is a flag 'host_mlme' in struct
> 'mwifiex_sdio_device' to indicate if host mlme should be supported. If
> this flag is set, driver will still check if firmware can support V2
> Key API. If firmware can't support it, host mlme will be disabled.

Thanks! If I can distill the answer: it's just a software/firmware
limitation, and not a hardware limitation. The hardware limitation flag
in this series is added just out of caution.

Brian

