Return-Path: <linux-wireless+bounces-12823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768759778F8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 08:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C288287A84
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 06:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48EE1547D2;
	Fri, 13 Sep 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="Um5kYrhn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECC143C40
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210245; cv=none; b=lbVTMFTu/Ux8WV1tPMkkWha06N9aSAjQe5bnHoAiSa93GiF2ULZqvi1FEn3g009ViKf4BYaAWbMcA4+3CzcBcRxf7fpoAgreOttFeuSnle4LmfNJ1ch3+4za10eabFlkbID6JsjFfo+czS0a6io7Y62kY35hj652GPNtZ67IFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210245; c=relaxed/simple;
	bh=O+eGUOg7N+51oNPGc+xlo5V6qTCB1jv3kCGi+CtKG1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrfuGa3sVCIpgMQ6gWd6hHm+sWGVHzSXl7PXU6T1/19sTTArInawwzrAZ5E8dXsgxCZ4c6x7a/VEJZn4dlMS083ZipBgJUvUhYb/njKqhSXg32LIZX2FyZxmwg4ZPASIE9SAl40gy42++se8tYBlLXtviNJo+dv4zZTdMYfqAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=Um5kYrhn; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 19084 invoked from network); 13 Sep 2024 08:43:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1726209839; bh=PaptqPPKO+Bv69Youp8qikY1shYVRY2bY593utlwC6w=;
          h=From:To:Cc:Subject;
          b=Um5kYrhnIz1SXvY2GhWb7dCWXkWMfYnNxGpfMSa8U297SNrYe+nlmFbzGCvH/0QEM
           kKMO2SzFbn+DKx8HHLKl98QGopHUamCehV8CsvFC9jHr6a145IGE/ocQyhx32ZTd4X
           cF4zteLVnymzG5UXRtcFo81g6nEmRj7O1FAxQW1s=
Received: from 89-64-9-121.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.121])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <nielsenb@jetfuse.net>; 13 Sep 2024 08:43:59 +0200
Date: Fri, 13 Sep 2024 08:43:59 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Brandon Nielsen <nielsenb@jetfuse.net>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-wireless@vger.kernel.org,
	=?iso-8859-1?Q?Martin-=C9ric?= Racine <martin-eric.racine@iki.fi>
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
Message-ID: <20240913064359.GA147350@wp.pl>
References: <ZuIhQRi/791vlUhE@decadent.org.uk>
 <20240912083959.GA132706@wp.pl>
 <576a9e32-e1cf-478f-999a-7ef3849d714e@jetfuse.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576a9e32-e1cf-478f-999a-7ef3849d714e@jetfuse.net>
X-WP-MailID: fe535b7bd6ca9f0fb167043de94034d7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AbPR]                               

On Thu, Sep 12, 2024 at 12:30:42PM -0500, Brandon Nielsen wrote:
> On 9/12/24 3:39 AM, Stanislaw Gruszka wrote:
> > On Thu, Sep 12, 2024 at 01:01:21AM +0200, Ben Hutchings wrote:
> > > iwlegacy uses command buffers with a payload size of 320
> > > bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
> > > describes the default buffers and there is no separate type describing
> > > the huge buffers.
> > > 
> > > The il_enqueue_hcmd() function works with both default and huge
> > > buffers, and has a memcpy() to the buffer payload.  The size of
> > > this copy may exceed 320 bytes when using a huge buffer, which
> > > now results in a run-time warning:
> > > 
> > >      memcpy: detected field-spanning write (size 1014) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170 (size 320)
> > > 
> > > To fix this:
> > > 
> > > - Define a new struct type for huge buffers, with a correctly sized
> > >    payload field
> > > - When using a huge buffer in il_enqueue_hcmd(), cast the command
> > >    buffer pointer to that type when looking up the payload field
> > > 
> > > Reported-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> > > References: https://bugs.debian.org/1062421
> > > References: https://bugzilla.kernel.org/show_bug.cgi?id=219124
> > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
> > > Tested-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> > > Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
> > 
> > I proposed diffrent fix for this here:
> > https://lore.kernel.org/linux-wireless/20240520073210.GA693073@wp.pl/
> > but never get feedback if it works on real HW.
> > So I prefer this one, sice it was tested.
> > 
> > Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> > 
> > Martin-Éric and Brandon, could you plase also test patch from
> > https://lore.kernel.org/linux-wireless/Zr2gxERA3RL3EwRe@elsanto/
> > if it does not break the driver?
> > 
> 
> As far as I can tell nothing breaks with that additional patch applied.

Great, thanks for testing the patch. 
Stanislaw


