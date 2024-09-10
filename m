Return-Path: <linux-wireless+bounces-12736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE254972C27
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4132836FC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBCA178395;
	Tue, 10 Sep 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Rrv9FzDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D6149E00;
	Tue, 10 Sep 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957068; cv=none; b=SeqTZKKz6WLjjNuQMW1RzOIpNWywXvl2/H2N1dVtHY7gF83NmjjKIjUBLcSPM2nmZiN5ihYuK7Vjq6kd0SWqb5/rJJOlIlb8k/0Vg3tCLVlHFro/2Zp8GyV+jIPQY4Jy2giJtBMBel8UNSon260A7t6AWiBnS5Lke4lGvvZbUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957068; c=relaxed/simple;
	bh=jAthi9SYkdIOrqdLbENok/7EirFyg4jyd+pR2WNA2RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnrJW0p5FxDxVvDU2iSCFrQt4U2AiMnPEOu/89diLxyxXKNRGP4XNfCYzHuAHEJvDrn8Y3vKme7em2wMzXAcjn1jfBlKyepU9fPOZCi7gfOsB66aRq2HihCKe6mfWO2rX5f3HAykdSuHoiDqUC0PZBjX8RAUCGa8YRWT/dVBJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Rrv9FzDa; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 82BBB1F918;
	Tue, 10 Sep 2024 10:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725957058;
	bh=qtC3MOBob7kr4w5trUE/AMVLxn9shjgvS7tsupO5Glk=;
	h=Received:From:To:Subject;
	b=Rrv9FzDa5w+gostoowNnmObw16l72/e2gKuzlKItGDCPPmNN5OzKCvuLHlFXn6IUa
	 KSuaK1pw8+MkFHuENSbLbK/WKgJD62Ynan8g4pGZgk1lQJ0Prk//l3SvrEwsxgEmWT
	 EXncFk4CvDJvGoQgjKJNVpqPCST7O+vk7LmMB75qu8FfYSfR4cs6seq/qJbCHE7Lvb
	 te+LmeoGSL+nvjBfgchlVxLjRpsxpdMt2GqxA0hperj6ga3HxO6eN8LcVrZi3MV5Yl
	 YeSW8zH1+1jbANLIgigdFN7jEqh6NW0q7W0i1VhOLoBtciFzF9G90dVhB77TBEv3EK
	 OnKmdSIIVUZmg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 1BCA77F953; Tue, 10 Sep 2024 10:30:58 +0200 (CEST)
Date: Tue, 10 Sep 2024 10:30:58 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <ZuADwpidC7wG7J6q@gaggiata.pivistrello.it>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-12-56e6f8e056ec@pengutronix.de>
 <Zt8s4xEun6VL-pHW@gaggiata.pivistrello.it>
 <Zt9XQNnrdgwly0yO@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt9XQNnrdgwly0yO@pengutronix.de>

On Mon, Sep 09, 2024 at 10:14:56PM +0200, Sascha Hauer wrote:
> On Mon, Sep 09, 2024 at 07:14:11PM +0200, Francesco Dolcini wrote:
> > On Mon, Aug 26, 2024 at 01:01:33PM +0200, Sascha Hauer wrote:
> > > Historically all commands sent to the mwifiex driver have been
> > > asynchronous. For this reason there is code that waits for the
> > > last initialization command to complete before going on. Nowadays the
> > > commands can be sent synchronously, meaning that they are completed
> > > when the command call returns. This makes all the waiting code
> > > unnecessary. It is removed in this patch.
> > 
> > I am not sure to understand this. Is the code to have asynchronous command gone
> > or it is just not used anymore? In the code here you remove waiting for the
> > firmware init to be complete, but from the patch is not clear why this is not
> > needed anymore.  Maybe a specific commit you can reference in which such
> > support was removed?
> 
> Commands can still be sent asynchronously by passing sync=false to
> mwifiex_send_cmd(), but this is no longer done in the initialization

Understood. So this is just not unused code since quite some time.
To me the change looks ok, but I would appreciate if someone else can have
another look.


> | commit 7bff9c974e1a70819c30c37d8ec0d84d456f8237
> | Author: Stone Piao <piaoyun@marvell.com>
> | Date:   Tue Sep 25 20:23:39 2012 -0700
> | 
> |     mwifiex: send firmware initialization commands synchronously
> | 
> |     The driver will send some commands to firmware during the
> |     initialization. Currently these commands are sent asynchronously,
> |     which means that we firstly insert all of them to a pre-allocated
> |     command queue, and then start to process them one by one. The
> |     command queue will soon be exhausted if we keep adding new
> |     initialization commands.
> | 
> |     This issue can be resolved by sending initialization commands
> |     synchronously because each command is consumed and the buffer is
> |     recycled before queuing next command.
> | 
> |     Signed-off-by: Stone Piao <piaoyun@marvell.com>
> |     Signed-off-by: Bing Zhao <bzhao@marvell.com>
> |     Signed-off-by: John W. Linville <linville@tuxdriver.com>
> 
> I'll mention this commit in the commit message next round.

Perfect, thanks.


