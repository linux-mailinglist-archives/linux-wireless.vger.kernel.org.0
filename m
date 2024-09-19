Return-Path: <linux-wireless+bounces-13008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C697C5D1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DC71C20BB7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C2198A33;
	Thu, 19 Sep 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="mCy+21T6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A1194C69
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734502; cv=none; b=QLyaZQufCf7oOX5FmyxZ/I3wPonLYpi9HrWIh3ZRmGZpUujf2lir1gK3MJrlFp9preFaFYwH7xQ0qqT0b4H6JBdGtnQl6wEVs5NeZAsVfQ5TSF0DjbhXjXCCMCtPlklEBTcS9z9SLPSDbP/BYZzN8ammHLPS9TxEHf19I6ni9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734502; c=relaxed/simple;
	bh=eLidqbtPzCspss3Nv9wE7e0mzTjcbb74vzaG77UOIi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC/sTBmU1wd+0JiMDhwT1AedivLwCL98yrMAkILH61NBv09bKqdxKx2ZlQpSPfzsp7UwjHfLjp3XsqeksWS59y8/6h1I+oHP6f1NDRm/OzFYCdMQGnbIDi2nUke2ofmZs4WJ1Z9fohcsOd0vQy+r8jCitbSvlmiZVzvBlN56B5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=mCy+21T6; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 12433 invoked from network); 19 Sep 2024 10:28:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1726734490; bh=1/dJQWT9p73cDbZAc6QNaH5u2sZ506MbkP/WzBejaUs=;
          h=From:To:Cc:Subject;
          b=mCy+21T6tauZxIe7HpY/uRFt4pj64PM1Eg5P/ywq2R3jUd9xWEZuznGP+HaANLJgc
           zT7U/0r4qjdTqVn+FgbOR5n8QDrubsuTPT1rSlkv0q7QbJ1KfFz/X6hPnnQd0hNIay
           ScMl6aDtc5Q06wl71UdyrTDmOVYRgnrX1n01zPVg=
Received: from 89-64-14-248.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.14.248])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <kvalo@kernel.org>; 19 Sep 2024 10:28:09 +0200
Date: Thu, 19 Sep 2024 10:28:09 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Kalle Valo <kvalo@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-wireless@vger.kernel.org,
	=?iso-8859-1?Q?Martin-=C9ric?= Racine <martin-eric.racine@iki.fi>,
	Brandon Nielsen <nielsenb@jetfuse.net>
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
Message-ID: <20240919082809.GA13162@wp.pl>
References: <ZuIhQRi/791vlUhE@decadent.org.uk>
 <172666715574.3996465.3960547479597216434.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172666715574.3996465.3960547479597216434.kvalo@kernel.org>
X-WP-MailID: f2a40ae3715579129f9e7618afc9ee2a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MeMR]                               

On Wed, Sep 18, 2024 at 01:45:57PM +0000, Kalle Valo wrote:
> Ben Hutchings <ben@decadent.org.uk> wrote:
> 
> > iwlegacy uses command buffers with a payload size of 320
> > bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
> > describes the default buffers and there is no separate type describing
> > the huge buffers.
> > 
> > The il_enqueue_hcmd() function works with both default and huge
> > buffers, and has a memcpy() to the buffer payload.  The size of
> > this copy may exceed 320 bytes when using a huge buffer, which
> > now results in a run-time warning:
> > 
> >     memcpy: detected field-spanning write (size 1014) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170 (size 320)
> > 
> > To fix this:
> > 
> > - Define a new struct type for huge buffers, with a correctly sized
> >   payload field
> > - When using a huge buffer in il_enqueue_hcmd(), cast the command
> >   buffer pointer to that type when looking up the payload field
> > 
> > Reported-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> > References: https://bugs.debian.org/1062421
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=219124
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
> > Tested-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> > Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
> > Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> Should this patch go wireless tree for v6.12? As this is a regression I think
> it should.
It's not driver regression per se, just false positive warning when built
with CONFIG_FORTIFY_SOURCE. But it should go to 6.12 IMHO as fix for
the warning.

Regards
Stanislaw

