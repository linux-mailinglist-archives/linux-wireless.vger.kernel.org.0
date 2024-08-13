Return-Path: <linux-wireless+bounces-11341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5495006B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A0C1C22C53
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 08:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865B170A03;
	Tue, 13 Aug 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAHRME2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD9137C2A;
	Tue, 13 Aug 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539203; cv=none; b=LqUvxbcIOFVJMFnAZ6uA/+WeiFBO76CSkQPFOZkvFjGw8anorCjXZlMtHmSBCchwpszud3BJ1wFcjrzsd721/HuLRqGo2fwKatDnT9vmOfIWet43HSe12e/fb9M5gcfW9BO7l5FtcMYHnusGN+z0wPZEh2GZ8AGFfeTQ+uAat1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539203; c=relaxed/simple;
	bh=Zt/BNMi0s/3C+WPmitt441Fm7U11gXVv/aXZ+eqKplA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLhyda+3GPGtbRYSpV5QRgB3PV28xgAkUvUcLDs57ra8COT7yiQgGg9abnw4iEfVT+FszIYL54g9HPE6Y+CffqcqXxP1vxFKGJixelgQxujxJ4guZu4eXfLWf2QOTMUZyC3Wwt9S51w2eRhVS9uWbiuChUhxICXnECAMgk2mCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KAHRME2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0263C4AF09;
	Tue, 13 Aug 2024 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723539202;
	bh=Zt/BNMi0s/3C+WPmitt441Fm7U11gXVv/aXZ+eqKplA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAHRME2M8jgJkT/uouaJNPq7DGuoxIcwEXLO5O6diDjFGrQXpZgggSgMu2giNr22F
	 Q/M+IrBvEC6jmkd0G3Afixp4szZ13aJU1TEs/Qd1F8gO6Ik38Wx35Y46N/r/ag9QpC
	 bRWnpN9kiu84YyT6YB3aNFQ2OR52r8vonP+L4OrA=
Date: Tue, 13 Aug 2024 10:53:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: stas.yakovlev@gmail.com, kvalo@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: rtl8192e: Constify struct
 lib80211_crypto_ops
Message-ID: <2024081310-sepia-jargon-98f9@gregkh>
References: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
 <dfda6343781ae3d50cd2ec7bbdcf76a489b6922a.1722839425.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfda6343781ae3d50cd2ec7bbdcf76a489b6922a.1722839425.git.christophe.jaillet@wanadoo.fr>

On Mon, Aug 05, 2024 at 08:40:39AM +0200, Christophe JAILLET wrote:
> Now that functions in lib80211 handle "const struct lib80211_crypto_ops",
> some structure can be constified as well.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

