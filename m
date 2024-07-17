Return-Path: <linux-wireless+bounces-10291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9D933944
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 10:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD011F21E86
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11A38DD1;
	Wed, 17 Jul 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Epe7CK3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FE38385;
	Wed, 17 Jul 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205662; cv=none; b=cz17EZK4LOxRh0KPoOOtZGVR95W5n7TyhMeDcb4nMX3GgWftn9XiXQW46cCCRVmgdVwTIRK/zORDPP4+UVupxe73QEWbUVyT0++6fs0fvF7WEnmdKo1+wH3a42SRWG8VFjXZyAOEpogkuExc3LTeRiEsQ7ByJDIRuIt2+wGVkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205662; c=relaxed/simple;
	bh=6IPB7gYcVncufg+zOK7BDYfLxdMVnopJpWdlwVuPnN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK65G2b1av+BNfLv6m7fiZaE3eXElOLUYJfTmM8M+WVto3eNOVLS7zI5UXHmrS6J5lz5zcI3r6OyWjcS0NRYomfEO5TZ5KPElyXCGz3aBGZFUTz1/j1rmmo+J/uIzJbUrQt8Bog6dkwI7tp/spQSZ/9BgEcpMKNjC7+J7zA2Jow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Epe7CK3T; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id ED9BF1F9B1;
	Wed, 17 Jul 2024 10:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721205657;
	bh=2vLQkWxKCU/zWL/g9egpluNEz//HSDrSJQGosY4MSSw=; h=From:To:Subject;
	b=Epe7CK3T133MVxfNq4MOlYE8Z0uXWIzx8vpPHkRVtil05pbwOJyItTtKvgKJHVs0B
	 smIML1YCIuA20a6rl1dsfH1fa4SENYtP2Lopuo1b4lmfDNJpg05YUBUTUXs2bZzHCD
	 Ay0jhwquBufcDohj6qwELIQ5VUNYWckgC+thVJ44fgl3B9tfreZNYCHmBa4wfmlUGD
	 wUbk5vMiemuoHnqDh6qtAijkkAmnUXVyEb+tzptwCUH0DeCeLPe55xYwPek+0ZZTo9
	 1kzL4kDoMH/tpf2v+gW/z09W/1tkgsZ0tiKco9j7zpVlmTzHYJxO222Ri8gL2N18Wt
	 hOBiO8TdprLiQ==
Date: Wed, 17 Jul 2024 10:40:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: mwifiex: simplify WPA flags setting
Message-ID: <20240717084054.GD3312@francesco-nb>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-1-eb53d5082b62@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-mwifiex-wpa-psk-sha256-v2-1-eb53d5082b62@pengutronix.de>

On Wed, Jul 17, 2024 at 10:30:07AM +0200, Sascha Hauer wrote:
> The WPA flags setting only depends on the wpa_versions bitfield and not
> on the AKM suite, so move it out of the switch/case to simplify the code
> a bit. Also set bss_config->protocol to zero explicitly. This is done
> only to make the code clearer, bss_config has been zero alloced by the
> caller, so should be zero already. No functional change intended.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


