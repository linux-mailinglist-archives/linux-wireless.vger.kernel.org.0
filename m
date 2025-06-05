Return-Path: <linux-wireless+bounces-23762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E460BACEE9E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1318968FF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469E213237;
	Thu,  5 Jun 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mOnxlL1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2C1C27;
	Thu,  5 Jun 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123646; cv=none; b=q2JCUMmkj76v8IDVzlUzXV2RL0TU8lZd7X3EHNAqWBMdp39HjO017m6CqsyM94V48BKLGGxWhpugFqKveEG0O500LBBhEq8b2JkhbmwwMAAnrr7uInd68GuW2NDU/lZ7ZIg/Tw48JmQsEnKh5R//x04uAg24b9CwFRPiDJz+TBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123646; c=relaxed/simple;
	bh=zF82Ri64VnD1/TFKi9NEOhW9+yaqnsiRdJ8v0TrNTtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7oaYbznaDubifhAMx05WpeIVo0j2v1GbvYTkl90oTUo4HFyYI+TubqVIme4KI0gvLCn9q/2QojdwjGXbGsgeSrTlY3Wdj1RAWj6eUI1GFcdayzU/iNFi2DjhIZy8bC96WNTuk/WaTD20jbmkYnqUkmUz4ELl4bqiwpS+IvN9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mOnxlL1K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zF82Ri64VnD1/TFKi9NEOhW9+yaqnsiRdJ8v0TrNTtQ=;
	t=1749123645; x=1750333245; b=mOnxlL1KqShrQn4B+5y3O/jxu8aCHCSe9j55sl+DOIpVyL/
	pFVfhIBrBubzXA/+Ei99nfTXU4nXVkvE0Edp5Jegp/exB7rbvukrNfmAd1+RtQJ03IFogTERa0Jwq
	XeT236C4qN67nRY3QNeYxnlCk4sW9f0wKJl/QVOyg+i/cZMigD9eXPSRR2iBGGsBI4qkTzh7GZss9
	75AYEaVNFnvGSI4PcQ4SWIRU1V0zjAUCoUBuNRL0g71oWlNwXQ8Uy3QuoFth20/U9ihYZqSNDIEiZ
	x7CuRCwJjoDOUVWzkSzaYTskQ/a3UY9t6ndCTqTu+zyi+bqxnb57133JCEg+jj/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uN8xd-00000002KlM-3mkK;
	Thu, 05 Jun 2025 13:40:42 +0200
Message-ID: <0706792a7d08d7bcfdf7fa929cd5f1afc80e3f19.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v1] Revert "wifi: mwifiex: Fix HT40 bandwidth
 issue."
From: Johannes Berg <johannes@sipsolutions.net>
To: Francesco Dolcini <francesco@dolcini.it>, Brian Norris
	 <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Chen
	 <jeff.chen_1@nxp.com>, stable@vger.kernel.org
Date: Thu, 05 Jun 2025 13:40:41 +0200
In-Reply-To: <20250605100313.34014-1-francesco@dolcini.it>
References: <20250605100313.34014-1-francesco@dolcini.it>
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

On Thu, 2025-06-05 at 12:03 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> This reverts commit 34253084291cb210b251d64657958b8041ce4ab1.

I'm confused. If you want it reverted in wireless, this is the wrong
sha1? If you want bit only reverted in stable, why are you tagging it
for wireless?

johannes

