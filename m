Return-Path: <linux-wireless+bounces-18598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A21A2AD49
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 17:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CBE188962E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5A1A317A;
	Thu,  6 Feb 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLNHkHwS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155071F416F;
	Thu,  6 Feb 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858056; cv=none; b=eMRbE/Y0VoGsNL0zcB9pnNSoRC+gX1ROSf53Z1DZcf3UjcrMFCGZYwn0OqgyvXeEzjuiEy0tQZwKctsHC5zqtD4Toxt1xYMoHukXxbX2My3FkdbON+rLNs78r9rexseirAZxVjOBwsn6HdEsuwIMpLsBKvQeiKKnhHdundcvxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858056; c=relaxed/simple;
	bh=QJ31moKrht8an0TRfYNCeVBnWmovWDMnZ+m/HiYcqTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgfvADj1Ok7lK6Yp5MQlto14C0klA5I3dDHNngpqqoJPu9K0uKaK7Vo3ZQ5yLKpy9ITSDcQ91b/4Wg5VMocMPlxRDE2eFeLSXO8waaVSRtnOm+qk4IkEQHYZ8WQ3jc4s9/aPGuTemOF27VEn9zKqVYfejFOVdPHapO18IrBS6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLNHkHwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B25C4CEDD;
	Thu,  6 Feb 2025 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738858055;
	bh=QJ31moKrht8an0TRfYNCeVBnWmovWDMnZ+m/HiYcqTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YLNHkHwSTJtdN+sCCESWIe/5zKTZ5Oij0fOItenE0G9+frcXv8kdu0ts7cSlO0OmB
	 C32T73ZSFdIilR1SZFdypctjMLHHmuSgCze9leuAdT36KBM2ze5jSRpQLvVZeEqoCy
	 MTFb+QhjgPA4zBeRW/AxUhkLo24bLOcGx2ojOaKm+D1D4u6ThP3JDyuKxD3Dkx3EM8
	 86+TsZCB+7ade8OXaAEBUWIE6WKpZwcglp8fKtdJ2lHIeygdhcNs7ShAl7GHJl38ke
	 3pe9PXKS5E7llqqLO6E1vlqBSZWssava6PkiHCULPKxjt5Zywxp+FluTBkEyTBoiTN
	 fEjWjwe82PmfQ==
Date: Thu, 6 Feb 2025 08:07:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 04/10] tools/net/ynl: accept IP string
 inputs
Message-ID: <20250206080734.13b6c1f7@kernel.org>
In-Reply-To: <20250206092658.1383-5-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
	<20250206092658.1383-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 09:26:52 +0000 Donald Hunter wrote:
> The ynl tool uses display-hint to know when to format IP addresses in
> printed output, but not to parse IP addresses from --json input. Add
> support for parsing ipv4 and ipv6 strings.

Acked-by: Jakub Kicinski <kuba@kernel.org>

