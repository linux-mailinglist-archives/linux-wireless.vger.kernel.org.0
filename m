Return-Path: <linux-wireless+bounces-24017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F757AD62F9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 00:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E71890B4C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04EE219FC;
	Wed, 11 Jun 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/5vkNUn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96841C69
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682015; cv=none; b=nVIYfRW6sfU07s/Ej0yCXIgFaxT+yn/IwQg2YQ1NPLWU9MYplyXhq0j4Ccs7ejAuzhikU5BSQsxU3NMlfjnyQ1EH5DP7g9qutUAHhY9hpE/ttWEht3+KNJVCRiWua4gVrfPh13drdgeQwcEWchkDSpm5aNPk0DJ80wehNNia3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682015; c=relaxed/simple;
	bh=LsYYgtbs5whnT9mSXJp1Eq53eFhWhrY5iX4DQHLYkd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVOIi7vY3BKXbNWK4Mub4n8LZaYH+IIyptqNBJ+3AAPhxpbSgTncVXCf8BJZ7PbppuJ25nTt48TDdqP/n2emVZuCBrHGCerkF8w5paKieOlZH0T93degzO3Jzj2nxTZlwW5D0NPnF62Ks6H3CTKVfjWw/AzdKsip2EOm/M99B0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c/5vkNUn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235ef62066eso4012425ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749682013; x=1750286813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFx7aQNRgw8lJFWTh3MAUKZTG+gQu0E2L2N97DFRfu0=;
        b=c/5vkNUnuyT1VAEl+ibRIrWtyOQK98TiGgvJm98P2tpwdEDxj+IPbhaIfPb1WdmFI0
         xfGtrNi0mjN93WTSIvesM4xupcICDyu1GJF+QHTnO8g5BcB/AHNx9SpnQ/mjwJGQHWFI
         vTohj/BMHjmLxv+W2ctFlMeHuPTvBTUlP3VN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682013; x=1750286813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFx7aQNRgw8lJFWTh3MAUKZTG+gQu0E2L2N97DFRfu0=;
        b=thygnhO609DJnSstr5V2kOcMC/LAvrkQc/Tbl0+ZFy7vAVraxTxfrIqu+sr15+Bhro
         QnRg4VA4Ue16qbDrDYTx5aMTj7nUM+Z2cAyMG7A+k3tR2ggSJvvc6w0bh3Fdf48tvthe
         ilXmocuwe8sdmnr/d/PU/PFxzPohpKKGZuBhjEreHivMIzii4ze5DX3wPt+uSHMMswZc
         mdTi75dnsVdBKsnpkRJU/Ul0ScyQ8KhbjhvIcksUi+ui4QRH/jwzZiGJbszCl0iBAQOq
         8t/ApP178rF15JHKD02bu/ZIu999ABmmP1S+pm/Xq+VJ83b3xuETA1f4Ctkx9Ro/tHh8
         9Qfw==
X-Forwarded-Encrypted: i=1; AJvYcCWe6I3foL5TcuAC8Vso9wsEdQDu41iHEFj/k5Z4Pw3Cw8QNG6oreHdEDAQ8MvGW8OoZ86wZE3VK88gqmsKf7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEp0Rv+d7XOEfDlKO8HPN3gAVX4bUsqKO9PMCJOuSDm7MQW/QH
	3Gnz4p38qALAt0qxyS9uQ/fLV55x5gTTOJ9P2iC6WGMSX1Yi56lVDeUvBFQIWiGi+qNhigsQjo9
	pnOE=
X-Gm-Gg: ASbGncvIJOZ/URhsiUI69x3Mqy4fyrWj0vi4qrfhMbbSehxThDQAf57Fv0nOGQRX2Dr
	oOEckATHQRvuTMk7QxKZYgHfvOb1C8SDAkxXKvTUQCmdsdLg04/mOhI64gV9JdwHEiT2lbx+IDl
	Z3fdpriUYei9zInNfLiOfdQJj/k43Cr2V/FrPoB0HG2scok8sgMu51vV3kV1ekw/SeHD11m4pwn
	sPNi9lfZj2fK6NQII4upJiyjlbkStsnaFi9Gy55laA9DrpB4QtFOxYsl84On8Os+eSn/k1QikT8
	kdc05Kiw82BW34C/dBrVm6hU1p6nponPpUNYIAZWdgw3Q23ci04ejonq32IqFehE4+6tXieRWQv
	78xkdRqaU+sXqXCOLfwHk12AO
X-Google-Smtp-Source: AGHT+IHfxQumAIvTnAC11qGewLlT2l+e661MXzd9Z0cWhYEeo+EYBK5deXOhCJDGROAteHYAv7Tqyw==
X-Received: by 2002:a17:902:d550:b0:234:ed31:fc99 with SMTP id d9443c01a7336-23641abea95mr74422965ad.21.1749682013305;
        Wed, 11 Jun 2025 15:46:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e790:5956:5b47:d0a7])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2364e6fe4ffsm899915ad.147.2025.06.11.15.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 15:46:52 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:46:50 -0700
From: Brian Norris <briannorris@chromium.org>
To: Rafael Beims <rafael@beims.me>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH wireless-next v2] wifi: mwifiex: enable host mlme on sdio
 W8997 chipsets
Message-ID: <aEoHWrBsMTBJ1rja@google.com>
References: <20250530094711.915574-1-rafael@beims.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530094711.915574-1-rafael@beims.me>

On Fri, May 30, 2025 at 06:47:04AM -0300, Rafael Beims wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> Enable the host MLME flag to allow supported W8997 chipsets to
> use WPA3. This feature requires firmware support (V2 API key), which
> the driver validates before activation.
> 
> Tested using sdsd8997_combo_v4.bin from commit
> 211fbc287a0b ("linux-firmware: Update FW files for MRVL SD8997 chips")
> 
> [    5.956510] mwifiex_sdio mmc2:0001:1: info: FW download over, size 623352 bytes
> ...
> [    6.825456] mwifiex_sdio mmc2:0001:1: WLAN FW is active
> ...
> [   12.171950] mwifiex_sdio mmc2:0001:1: host_mlme: enable, key_api: 2
> [   12.226206] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p197)
> 
> root@verdin-imx8mm-14700070:~# strings /lib/firmware/mrvl/sdsd8997_combo_v4.bin |grep 16
> $Id: w8997o-V4, RF878X, FP68_LINUX, 16.68.1.p197.1 $
> 
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2: improved commit message, add r-b francesco
> v1: https://lore.kernel.org/all/20250521101950.1220793-1-rafael@beims.me/

Thanks for the updated details.

Acked-by: Brian Norris <briannorris@chromium.org>

