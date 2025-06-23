Return-Path: <linux-wireless+bounces-24347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299BCAE3D37
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 12:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309E23AC262
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928F239E65;
	Mon, 23 Jun 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="I4M6r+xV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522D23BD00
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675648; cv=none; b=E1HnPhGaa+B4DZH8u5zPbgBCPOelzOv2ixkTy68TIilug+nVhfb4n+5wRmBiIb8H7DK+EHhcBqT2zxebw5nbFHzunpLIvlfAyu92OpGPARI9+ngU/VIcFg60JpDQU7cNEns7rj0BJs1Lz3Lk+0Rp+zP/cvvOn8H30gvG1F+gRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675648; c=relaxed/simple;
	bh=wLnOGCdWaS9KuZAxZN8hKqMIXqmfIXzXpGPVcbUS5KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM3mf45xFjBy4ub5W03X+/8bqp2gzIqaxmmdycDCksKwOEm7353zBYaRexuJ6GVabGpYzw5EGnAVx92p7dnzeno1bIBBaqGuc6alM0K/BTBZsnq/irjatxBlMh8UTLGRLZNAvPwLX849x0ch1UPn/zEtQfcnrQNL5sBG+Bp9Cbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=I4M6r+xV; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 24439 invoked from network); 23 Jun 2025 12:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1750675244; bh=p/cwLwgpPW01+hT2S2XgzDpwrmukQ4xw8AL6TKybcos=;
          h=From:To:Cc:Subject;
          b=I4M6r+xVf3coRo5EOOcBbwo9qjmbqTyYy96IFVJNwsRUepWOAgRbPfwbo/Q/xP8yi
           qm12o3Rsp5cOUqW56Ic0h87o06crHCGduhHFNN8lXpTSGMdafnITsrWO9ck9S+NxyM
           p7rnmudTdUw/tHZiy12/9zQmkhDL3SfeQkxH86uLNL9iyV3TZKrY5XmHy/lln0ZkyH
           CS0SlOiucHblHmaOIpkbfbw/i24fC/Wp9ersnXnHTQcAYlBoK9x0gpR/e20MPY5tfC
           yd/7oTW+WYGFx8LfaIGxTAc8ce9xg8mWUX4HHG4rZ/5GaNXlr5i49w4NUdzx/m63Df
           mYEFaPta7lUSw==
Received: from 89-64-9-92.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.92])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@kernel.org>; 23 Jun 2025 12:40:43 +0200
Date: Mon, 23 Jun 2025 12:40:43 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] wifi: iwlegacy: work around excessive stack usage on
 clang/kasan
Message-ID: <20250623104043.GA2260@wp.pl>
References: <20250620113946.3987160-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620113946.3987160-1-arnd@kernel.org>
X-WP-MailID: dd6ab97b8af3c8994fd33ebc0b60180e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [cVH0]                               

On Fri, Jun 20, 2025 at 01:39:42PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some rare randconfig builds, I seem to trigger a bug in clang where
> it unrolls a loop but then runs out of registers, which then get
> spilled to the stack:
> 
> net/wireless/intel/iwlegacy/4965-rs.c:2262:1: error: stack frame size (1696) exceeds limit (1280) in 'il4965_rs_rate_init' [-Werror,-Wframe-larger-than]
> 
> This seems to be the same one I saw in the omapdrm driver, and there is
> an easy workaround by not inlining the il4965_rs_rate_scale_clear_win
> function.
> 
> Link: https://github.com/llvm/llvm-project/issues/143908
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/4965-rs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> index 0e5130d1fccd..031d88bf6393 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
> @@ -203,7 +203,8 @@ il4965_rs_extract_rate(u32 rate_n_flags)
>  	return (u8) (rate_n_flags & 0xFF);
>  }
>  
> -static void
> +/* noinline works around https://github.com/llvm/llvm-project/issues/143908 */
> +static noinline_for_stack void
>  il4965_rs_rate_scale_clear_win(struct il_rate_scale_data *win)
>  {
>  	win->data = 0;
> -- 
> 2.39.5
> 

