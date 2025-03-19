Return-Path: <linux-wireless+bounces-20569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD05A694F2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74760189250B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318111A316D;
	Wed, 19 Mar 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="KQWXBu6H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD733E4;
	Wed, 19 Mar 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401732; cv=none; b=qnuIJiiO0E4S+llGw0OGGA3ZUSUQmeSS5URhQaKr86s014QQPIayNEnlSjJ7N28/G3dZJ/qMnU9bv7Zi5LbOy9lvU+1OcRf8L1AuQLKHrIvYQinElIbK6ik5GI8pirJK04HlQDPmyj7QF7sbp8Kf623VS7cDKFOlf7MEiuJhPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401732; c=relaxed/simple;
	bh=SasE9p0+y6wZb3DFJ23rxyYn2KRAjE3ZwCT1ehhw2PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIOz/pSR3HEb/QdN9Dbv4jVtYoHZFyXYnX1dbungDsWrrOFTxUa6A5udto7i6HXVtC70dMeghWr9AL2lbG1bYTxUNFoD/NJqX2nk6liIMbz/PD/490VKGlVidg74IOdzV5YKCXFlG45UW1cwJKSXUt2ep1k5bmcenui3mFDQm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=KQWXBu6H; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id A31971F92C;
	Wed, 19 Mar 2025 17:28:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742401726;
	bh=AYaLky7x4u/TYR46uP6h6WSnFZl+IKJDfQyAVabrXck=; h=From:To:Subject;
	b=KQWXBu6HWWcT5usyEMXtIcuIfO9NkcqboVdlBV1dHBC8lJ8ppQZYHK6uBdaYs6pR0
	 jdk3Ml06ibndift44iY07wC/skwg4qV16CDuvXEqIbdPxd0Yc593tdO2t5wRkRW3cq
	 MREjzpqnppl2f/4F7gzUTxK7N8lsOfx740MDpSQuwUArIiEKEHK2mI8VtHLJbwGvKd
	 QdDoJJDaaxrzZl8lg5qCFLgMclHYPD7WxjODP0pny3fhbp7nJxgo0rc985//YJojLQ
	 Oq39ZyzASPWjx+l7h2EP62kBn/UdtZuQxONCbEfV5PozngnBSmvxDHnH47LSa8KyXn
	 sTNsUP/91Ck6g==
Date: Wed, 19 Mar 2025 17:28:42 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of RF
 calibration data.
Message-ID: <20250319162842.GA46894@francesco-nb>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-2-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318050739.2239376-2-jeff.chen_1@nxp.com>

Hello Jeff,

On Tue, Mar 18, 2025 at 01:07:38PM +0800, Jeff Chen wrote:
> This patch resolves an issue where RF calibration data was being
> released before the download process. Without this fix, the
> external calibration data file would not be downloaded
> at all.
> 
> Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

The code looks ok to me, however I do not understand the commit you
selected as fixes tag.

From what I understand releasing the data before using it was done since
the initial commit 388ec385d5ce ("mwifiex: add calibration data download
feature"). What am I missing?

Francesco


