Return-Path: <linux-wireless+bounces-20383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86DAA6135F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9987B19C1692
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F15D1FFC51;
	Fri, 14 Mar 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="xFzPl6eV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B21EB3E;
	Fri, 14 Mar 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961481; cv=none; b=qY9n4qWll5SL2KZ00om+x2S83gN8TAWItq5eh9N99fMw4sqMvSLCvLf8QZ6t94npEoUUMHLVg7w7IzffnhhPzozbwmBmiSwSF/7deGdEsHs0k2BwlDOzBbIgXUIVRVvHKOXMx2xC1LGZVu5GfrsL3iLu6Uh26SJ8FFpKr+5OikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961481; c=relaxed/simple;
	bh=CPBTHkqPzfVpKzNFgNPoisYMyOv0IqONQ41uCQM5qjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q74cqTtHFXPfMghqZX+4ralYk/FeYq90qUrwBOPUKh+ken+ZNv0MXqpHqMMAvde0trHKQphdCsnGG7Wcxva44MQiSdi6HTTRz0W1+fCvpBmVkSboH8Fl6ftOFBFd6DFviQeabBsOoyaLuzQLsFHcS4amxlmeCzXVRJVUfP5JGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=xFzPl6eV; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8F7DB1F93A;
	Fri, 14 Mar 2025 15:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741961475;
	bh=HsRFrggS6kqtvPWhfFvFAXCpmID8ibMboUcQ9J3zcys=;
	h=Received:From:To:Subject;
	b=xFzPl6eVh2TOJXz8G8hYw1ipGkmfc9k9ecY9ayNFP84AU6PMy6ywJmyREEhnBp/yE
	 suRuIDZu0HPv92vmu5BXFsw3NdmOWsZ9sO5PYiNcXG6NvcKMo3zsrFQdsF9oYatdv0
	 kFhclZyEmj7sLpIYfzk3nifhmk3TcWy1cbPVQVd3cc2CbpIYI10NYJaaLm5ZSTEn5e
	 /74mxX0rE98cxNtkrnEmiClvvKiATOurlXmrL3x/z8fPpscuR4RrF3KcplHkz8hwV5
	 QLluNFIlHJCH9ixZ27GfZxkL+A64APTUjX2YXIZP14eJW6LF80ZyAfM6GU4g9sxfAf
	 Zh+1aUnAoPMAw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 3EDA87FA28; Fri, 14 Mar 2025 15:11:15 +0100 (CET)
Date: Fri, 14 Mar 2025 15:11:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v3] wifi: mwifiex: Fix HT40 bandwidth issue.
Message-ID: <Z9Q5Ay9lZPA4OC6n@gaggiata.pivistrello.it>
References: <20250314094238.2097341-1-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314094238.2097341-1-jeff.chen_1@nxp.com>

Hello Jeff,
for future patches, please be sure to have a changelog after the ---
at the end of the commit message.

See
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#commentary

and in general that whole document.


On Fri, Mar 14, 2025 at 05:42:38PM +0800, Jeff Chen wrote:
> This patch addresses an issue where, despite the AP supporting 40MHz
> bandwidth, the connection was limited to 20MHz. Without this fix,
> even if the access point supports 40MHz, the bandwidth after
> connection remains at 20MHz. This issue is not a regression.
> 
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


