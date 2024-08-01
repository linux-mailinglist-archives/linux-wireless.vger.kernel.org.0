Return-Path: <linux-wireless+bounces-10810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383094463B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C494A1C2289B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB84208A4;
	Thu,  1 Aug 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNcSofWz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B41EB490
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499814; cv=none; b=fh0frrPMpa/K5mhrJIu0A+4SRPuK4VP6w1AFas5wFjaLcxf5a/De9foyUBKOA0FYoef5CNE/v/dgTASkqXSIXTuC3PigunvuYkxyh6XtB+1JZ9z7SjLNvMMsbRm3tbgDr/GPcbnO+pOyPuagzYTOEA5JYgIIg43Z1JMYyjutOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499814; c=relaxed/simple;
	bh=haHhP66/1HiBBW5zwEpBEfdg3At4pPJYtVIOdtrQUnY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sBxJ4hxYaTCu/zwYmk5pA+GfI3nlaFi/oU6+RzOcCyz8uN6exMUkD96bnKp/8hTZEQzRx4qmnr+O9G1QmBAb81+l54KvFzNJikO6/LbEFhxgy/GcG9VWYCpd3U2ExHw+UQcZ9ge+bpsT2RcYDHKf6BEMJSgrsshYG4cnXjWDwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNcSofWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4B2C4AF09;
	Thu,  1 Aug 2024 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722499813;
	bh=haHhP66/1HiBBW5zwEpBEfdg3At4pPJYtVIOdtrQUnY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VNcSofWz4s49saB5MXI9ucw7BmiNMgE5aCOXUa2X9mJDjjEuN741UTyt5XlxKxl0R
	 2ZITkLDJ0vphmB12lInrH4X7rweftJszNYuUoUY2+SptM86Emi/7ARIvYlwR/WdHJx
	 OowciEjRPzd7YUFsFpyeRfy/lsl6F7PeNi/f9dzKmguOwwtREsgfvGnIBcxhcTJm1V
	 7h/nomTWctaadbql3iS6EOzJzbtDuqF0hAG8UVjU/fBZ9DAZS1hiDd/GIFiYXn0I8j
	 kWLLMGWOJsys6TuLGiFZJnQz3yx//+t+JPCupbA6zrFpB7bmlOh3C2iAvesYm/Hd9D
	 OIg9PAas93bOg==
From: Kalle Valo <kvalo@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
References: <20240731210243.7467-1-rosenp@gmail.com>
Date: Thu, 01 Aug 2024 11:10:11 +0300
In-Reply-To: <20240731210243.7467-1-rosenp@gmail.com> (Rosen Penev's message
	of "Wed, 31 Jul 2024 14:02:40 -0700")
Message-ID: <87cymsk6jg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> Avoids having to manually call free_irq. Simplifies code slightly.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

The title prefix should be "wifi:". I can fix that, no need to resend
because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

