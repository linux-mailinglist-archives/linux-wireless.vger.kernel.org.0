Return-Path: <linux-wireless+bounces-12604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD496F7BA
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 17:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C283F2853E2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B751D3191;
	Fri,  6 Sep 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="MysOFamN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2521D31A2;
	Fri,  6 Sep 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635041; cv=none; b=ei40nAHIuv4wfs6ud/GXn7HUzQFDUREesSMbtJ6qToecrQSdV+Hvvc0xzY5g6SU034kUAJ7/wjKqVyG9sL2RSzqeMxWsa0Z2rrAE/tk9tSbZLHcivsavMllOI/Hho3NFKQrakqCxqLLbw0iw54mEZIZhPbkD2JOs73x7WjAiY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635041; c=relaxed/simple;
	bh=0DAeDZaLP0DU2MmjmVtrao0wyO8nipOg5KlCq+MG0lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm7yuWoYahNrwwFfyoDSat979lvqkI95GNtxHU3KAuFTTCQWkEZsz7ligI7QfyBBe5j/ZR3MzXwygsJ5+a/mp7R3ZzblllJUqF4yb3TH3E3hFn77WUgpIuVUENsO5ZPuEe6KAksDqVIX7dahYsLRmLScRlwShu6M70RXXY1593I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=MysOFamN; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B6BAC1F9DF;
	Fri,  6 Sep 2024 17:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725635036;
	bh=ipReIdMPXitBqltXsvmD6hYpQjXWgFygseGherE65fo=; h=From:To:Subject;
	b=MysOFamNOzKZySaZhmAIWXQD+wivNqXhGoZCUpOORiajEVChlSbVl9Kd7K388VZ0Q
	 o83mOJQipXsPvpG8NGOI6Ji3lEjgka3ocgu9oQFguBjKMZ58YExDtikWRYGP0PC8u4
	 0bf3+X2t499qBHn3ekEi/ShGbWEDOh90+YLUiY0vDXjqXWHt6e84f2efqsVBDXNWWu
	 3nZQwpQPHGRcq4Ye/HuIpRZEsQYx0UXR/VZCgcJvb7nwusr4NrOuDcgJ3he0OLcbWY
	 cCpU4cPE1KHkGpyDwmDMyOmmWXXeoDEPN6vNn6pxH57vgDJB04xqE7aNE81BNVDM3p
	 RIpGCf1GVGfXA==
Date: Fri, 6 Sep 2024 17:03:55 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] wifi: mwifiex: use adapter as context pointer for
 mwifiex_hs_activated_event()
Message-ID: <20240906150355.GC45399@francesco-nb>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-4-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-4-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:25PM +0200, Sascha Hauer wrote:
> mwifiex_hs_activated_event() takes a struct mwifiex_private * as
> context pointer which this function doesn't need directly and the callers
> don't have. Use struct mwifiex_adapter * instead to simplify both the
> function and the callers.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


