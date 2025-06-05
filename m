Return-Path: <linux-wireless+bounces-23755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC9ACEE58
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BB13A759A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F8214815;
	Thu,  5 Jun 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l4pINWvw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6031C4A20
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121929; cv=none; b=jW/lCpf6KEjahnBz5Gns3h+Kgcf7FB6oSOSq8gejyP+1qCHNCcFhzH68tHFTQxpvswgzAPXgDTnZsaZIBuaTBv9Ctxwlahgd25HyNbH+ifiVqbvXGKvv5JRAsvKtIXkMwFMZTm4tr4sE57uZElVfFcCt+D/dZkIybnsDoS9Y15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121929; c=relaxed/simple;
	bh=k/pinwCt5ISV07mmu0p1tveIUgHi69fCID6fybEXwYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPuuKc3Wg7etiterK9GHF7Y9QiNxdFNWV7EGqH9WPgorR46sSSIeFoTawrqU29nCRcbf6iPpVU2wCh9YNgv/4+H6896p9it488DEtjB1+8PWCC3LLTvEIVlOhueLI0WsQytdHNeZHbWLh6yEnMDyzD1mGLkHqyz04eVLKyByTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l4pINWvw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DoZ/FBRtfIq4vqKc6J5aEGGuB1WJB6jhEhWLadfyzVA=;
	t=1749121928; x=1750331528; b=l4pINWvwMLvwdgBNFaCwF/h0o0K2yvNt7lF5bC1bNmS/Ir2
	FKvYNnXz4Vx2kTJIMZ1S2Rg/UZRX4Yz/c/fUC7p7FygJK1jXZx3ChjrwebbRi2b/zS0g4x/ky8s1S
	A29/DaS03YwnUS1zhr9CG0IqmzcVUheJ7Rf5ky+seJ31FPqk7v46UKC5KUg5krf27EOb30oMOfyhv
	Wqt9fliYYYlwChMD3RC7ImKEm1ThgV77ulTS99H1djGVTPH/cRw8Ez3WVJJzJG4Tz8TeKx31T6Pib
	qYqFe/Ugvtv2zvRPBYsyU8mX6Ktd45v1R7BbY1r7TCeZR6oh7fObA38zCjP4B2NQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uN8Vv-00000002F4g-3EsC;
	Thu, 05 Jun 2025 13:12:03 +0200
Message-ID: <a4998706df28f2275c686de5b5f4334f0a552500.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v14 0/4] wifi: cfg80211/mac80211: Set/get
 wiphy parameters on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 05 Jun 2025 13:12:03 +0200
In-Reply-To: <20250605111040.3451328-1-quic_rdevanat@quicinc.com>
References: <20250605111040.3451328-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> v14:
>  - Fixed errors and warnings reported by kernel test bot.
> v13:
>  - Fixed errors and warnings reported by kernel test bot.

Please don't abuse it this way.

johannes

