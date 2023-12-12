Return-Path: <linux-wireless+bounces-694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D3180E842
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 10:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2496028123B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F3359143;
	Tue, 12 Dec 2023 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFs0Vsbj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9D58ADA;
	Tue, 12 Dec 2023 09:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57EDC433C7;
	Tue, 12 Dec 2023 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702374881;
	bh=g44so0aXENb1ZbYVlFiZWeI/HIvhAHxzBBi5p4XGpb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFs0VsbjwcxWVEkl3pXaSvyYM4X2Whkvb6oF9daOqpon9n89n7CCqsti8gUebdR2R
	 +clPMLnHbXFu+jQwf8uQvDs/tq+mKSCExqEkGkjpIROV45xBnjwYIh5V0qlIfRkyq5
	 bx6Ythe77BYpy+bOer+3uX6ncBG4HON8uowwMv5zNo6O2J5PwNjmk85saMFDiez1o8
	 4S1rKVJcYFWQ99fbKhm4DQgjhg2+U0ShImfMsXbYl+PZ6fq7zAxmg489KMVIr+m9DO
	 o3s0GpVg9aia5ugwjeKG33JFwAKTK+j0i5mIPiwMhmqIk8reskp5bMzQA7zDFmjEJW
	 iucHoZIM+mC+w==
Date: Tue, 12 Dec 2023 09:54:35 +0000
From: Simon Horman <horms@kernel.org>
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Josua Mayer <josua@solid-run.com>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pza@pengutronix.de, stable@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: rfkill: gpio: set GPIO direction
Message-ID: <20231212095435.GT5817@kernel.org>
References: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
 <20231207075835.3091694-1-r.czerwinski@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207075835.3091694-1-r.czerwinski@pengutronix.de>

On Thu, Dec 07, 2023 at 08:58:36AM +0100, Rouven Czerwinski wrote:
> Fix the undefined usage of the GPIO consumer API after retrieving the
> GPIO description with GPIO_ASIS. The API documentation mentions that
> GPIO_ASIS won't set a GPIO direction and requires the user to set a
> direction before using the GPIO.
> 
> This can be confirmed on i.MX6 hardware, where rfkill-gpio is no longer
> able to enabled/disable a device, presumably because the GPIO controller
> was never configured for the output direction.
> 
> Fixes: b2f750c3a80b ("net: rfkill: gpio: prevent value glitch during probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>

