Return-Path: <linux-wireless+bounces-8855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A69051DF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027321F27863
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27716F27D;
	Wed, 12 Jun 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXWplOsq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE05B5B6;
	Wed, 12 Jun 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193650; cv=none; b=KWGT2oXBjN1LBsEM/P5iVKM4twFabdy7vYyQtGPAaHjC1LDlfmYkHhW5KmNpC03StkayyOIKUetXSOvqHTnq0UOgQnUnRPASRrKNyWR3SMWkmdeTT6eLPaUxzBtd2DJesKBhwDFRo0lHZoGWyeVfW0Uo0tMK38qk98seLuvPXdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193650; c=relaxed/simple;
	bh=n07DsxpF09u9uRBGe0+vElVCf39YcKw1xJ60iXRcKzg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=LDHx1BUY+VCfoBQnAkRfS+Q2GbMvCRizOynoyQUTw1T7yBnGh1imJz4bAkPh+E51+4nut56TxsPAv+d+lG9oJXuMe3I3e+A2tUUR1V9OCbarzTX9+qnP/ksNdBaMtTzM8cU409reLLf1aOrfc6kQ9KtXF/3dcvrThHgPn7CTkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXWplOsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93BFC3277B;
	Wed, 12 Jun 2024 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718193649;
	bh=n07DsxpF09u9uRBGe0+vElVCf39YcKw1xJ60iXRcKzg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=oXWplOsq4nnAtuLBBD+pAoPfNo9LptulGP0gr4nvRfkbtxPnYsxqr3QnMyNnPfYH6
	 kM6B6mF0kd1Ds3lXuu2aUqqdtb2Kf38jBF1DBUwPw3CjvcAU6TbpOfjINQEFLou32C
	 gNO36MRx2EzUGOJIr1iRM4rmsewkGDoLFBIRqLrfA6o7BBfLjPGcu1/Xs+KG6d1IOK
	 SaWDYf3mFcw/dBJ2LvrZiUKXKqd+PR93+0BQK7042tV8lwenoBsaUewEsHFnSGXvYO
	 Z9Uz4PZkJTxFTCe4Ya9GSvubI3jvnXrYn/a7krp8m7cfs0ZimCQ+kJYlNXoJ8vWeOV
	 fN1MYBnBNUaIg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] wifi: at76c50x: use sizeof(*pointer) instead of
 sizeof(type)
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <AS8PR02MB7237C784C14DBC943CB719F88BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
 <AS8PR02MB7237C784C14DBC943CB719F88BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johannes Berg <johannes.berg@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Erick Archer <erick.archer@outlook.com>, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171819364392.3856519.7235762996052092002.kvalo@kernel.org>
Date: Wed, 12 Jun 2024 12:00:45 +0000 (UTC)

Erick Archer <erick.archer@outlook.com> wrote:

> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). This patch has no effect
> on runtime behavior.
> 
> At the same time remove some redundant NULL initializations.
> 
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

2 patches applied to wireless-next.git, thanks.

aea9165ccfd1 wifi: at76c50x: use sizeof(*pointer) instead of sizeof(type)
bbef1d006cb1 wifi: at76c50x: prefer struct_size over open coded arithmetic

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/AS8PR02MB7237C784C14DBC943CB719F88BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


