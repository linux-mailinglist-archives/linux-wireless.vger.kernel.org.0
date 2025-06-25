Return-Path: <linux-wireless+bounces-24467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F33AE7E20
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 11:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8451885DA3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F83275B04;
	Wed, 25 Jun 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDu98FBI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3AC8EB;
	Wed, 25 Jun 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845085; cv=none; b=kOwu7O89yLRrk9CuGQzUF8PhzStRgrxF7k1FLVr1GRlbeg9E7YDKVWpcz/25DH9vdxMBgCbBTL2rgLdoEz4XGQFl15lzcFU9CfCTYmG9XjeBqi1OseyH0pZNWoELLfk5XGDX9TAlgF3H19Qi1qx+qj+wri8PYnKIlklc968Hp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845085; c=relaxed/simple;
	bh=nsyYLD5tEsSDiZwhTUu9p+LYrIKoWaOimwLJ+QPz3TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCKGJp2ol5VuF8R3WgHaGRVF8yHMMvidIXbEVAKLJ1kOwIDgNSBU9lT9nowYrs7YlILb0xxa9o77wGuSPZ0ELUxEkLHumQUIxu6vzjNH7NI7iI+UmIgO+9WENmmCTcR2js1xZQeVt3/8308ob8T8+ZB2L78Kt6aEGD/ivgSerjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDu98FBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E48C4CEEA;
	Wed, 25 Jun 2025 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750845085;
	bh=nsyYLD5tEsSDiZwhTUu9p+LYrIKoWaOimwLJ+QPz3TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDu98FBIEG1MEJZdAQZ8KBO68A32+ex0scuqy993yoe1dLovihqHl1p3SaK0DxNLS
	 H14OHHGhXFYk5H6lrwkIy+OBNxaUwC5THfx7L57G9r/fpVQO7+k65EYcTfIRJyhFkl
	 KoXA9/G4qOdnX1bDCzLYiurrdTFtCRGVe7adiP26WCIQvVUVBorfgIG9CZzTkITyX+
	 uKFMSWsAu/7wKOu1YpxCdlJY3JMxrhZ14a40WS2F5VUHfXJ31UN68mYPz5GEp+VF83
	 9DXFvKip96+zJIWQB6PMJOf1R2c73l7as6m3t6JYfUEnoKpWKKLlobYGItXIxnhdS3
	 KxSXXNyAOv/Ng==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUMmq-000000000eR-22uF;
	Wed, 25 Jun 2025 11:51:24 +0200
Date: Wed, 25 Jun 2025 11:51:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gregoire <gregoire.s93@live.fr>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
Message-ID: <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>

[ +CC: Gregoire ]

On Fri, May 23, 2025 at 11:49:00AM +0800, Baochen Qiang wrote:
> We got report that WCN7850 is not working with IWD [1][2]. Debug
> shows the reason is that IWD installs group key before pairwise
> key, which goes against WCN7850's firmware.
> 
> Reorder key install to workaround this.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
> [2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> ---
> Baochen Qiang (2):
>       wifi: ath12k: avoid bit operation on key flags
>       wifi: ath12k: install pairwise key first

Thanks for fixing this, Baochen.

I noticed the patches weren't clearly marked as fixes. Do you think we
should ask the stable team to backport these once they are in mainline
(e.g. after 6.17-rc1 is out)? Or do you think they are too intrusive and
risky to backport or similar?

[ Also please try to remember to CC any (public) reporters. I only found
  out today that this had been addressed in linux-next. ]

Johan

