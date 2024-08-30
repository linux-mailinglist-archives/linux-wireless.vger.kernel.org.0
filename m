Return-Path: <linux-wireless+bounces-12246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3E8965994
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE4B21F1E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9201509A8;
	Fri, 30 Aug 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JORgyirg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003A158528;
	Fri, 30 Aug 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005443; cv=none; b=LdhdZrCZyJew7FVm3hHped9dx5BY0UMl/GNGSRLl8Lc1r3uk/VEYpbxs8Li50TKAmt8MmfQ+9S+NL6nYPqRD3QowcUFZvEbsd/xUDPu7mHRACf+3AyCLWdkakO9M2c+BN2KXBXW/SpWB9lkCkH26k+cR11uGSp88NnU0oyUweEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005443; c=relaxed/simple;
	bh=ZygKSRZowQbgdebKmZAcW/XeSZFFXj2C5+igaleld5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXUC5R3BSfOv05AfFcnTQt46w2oZGK62azdSut0tb0jB/+CV87wf9GNbyT1EakfQhuh32aHaTNM0dhsrfAj6mouXtBvD39foJcK7kJeR1piAHGkPagMhSkeSE1gRYsBFoUhkjszcvOuiFY/7OIL9+HK4VjavEDeV2eimvt1wouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JORgyirg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B424021155;
	Fri, 30 Aug 2024 10:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725005430;
	bh=ZygKSRZowQbgdebKmZAcW/XeSZFFXj2C5+igaleld5M=;
	h=Received:From:To:Subject;
	b=JORgyirgBevfFN5PDFqTWzJbIRyiWh7gCFs2GiCt8uDd2WBscilhcQEeehcpY7AiI
	 4A0o1mg1DZRdvy2f2CeDInaRhzZ7ARHOYT+Xz9rofztwmVJuXxGfEd5q15BCEbdq0i
	 9cbmeDbvCd0seljVWAlK0IHGI8y0j+7ZwbtV9nB1wHeVvm0FGJfl65xvvUU1rnBY2l
	 GapyENkn36S0Ni6pZqVc5KGM4VgRjW4H9jUrUsCqRJyvsmq3ZC7IZ5b3b0EDv+xL+N
	 3lI7KDdzd/sgCgdJSLUQPdgUkADgV/sIG53GXqUfemPrPGR+nA16/VpDWTy3BMjzzX
	 Yz0HHPuXbtu8g==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 67B3A7F9D0; Fri, 30 Aug 2024 10:10:30 +0200 (CEST)
Date: Fri, 30 Aug 2024 10:10:30 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: avoid AP and STA running on different
 channel
Message-ID: <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it>
References: <20240830030630.825818-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830030630.825818-1-yu-hao.lin@nxp.com>

+Sascha, that just sent a patch to handle the same issue.

On Fri, Aug 30, 2024 at 11:06:30AM +0800, David Lin wrote:
> Current firmware doesn't support AP and STA running on different
> channels simultaneously.
> FW crash would occur in such case.
> This patch avoids the issue by disabling AP and STA to run on
> different channels.

Is this a generic issue of specific of some firmware version? Asking since the
driver as you know is supporting multiple Wi-Fi device.

Francesco


