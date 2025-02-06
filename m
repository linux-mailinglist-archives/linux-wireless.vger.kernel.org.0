Return-Path: <linux-wireless+bounces-18600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5BA2AD53
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A64188A6C6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A21E5B9F;
	Thu,  6 Feb 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPmzDaX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB61A317A;
	Thu,  6 Feb 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858236; cv=none; b=kNbnSAoO9rGezDYvZphueaTuStjSMwDMHMngZD0cSpeUw2yS9aYbyrTJ4pbCr46tMHu5rzweQ9V8tGCpFe5f3aiIeoJ/Bbgzs1DN0llR6o6py+/VwJKkrv1EyWjyCUbaqWScQCK7oY6kiUnqlmLMZI9J4zZfv3/xlM+hnxvW4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858236; c=relaxed/simple;
	bh=JVWt17XGMFQ+8EsoEQmmkuuAFPUJK3BzB4mQxP8SF/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDUKIO6u8e+oGN3C4nfGSKBG1QLo4b+rO2yNlCcOIurEhGjUntqcxGdubvnFSm+CfhNqmNygLq/48ywN/uELBpJlY9KtV53Q6mTYNyGQw22ty+bNj6hChJ85qB4yRnI76bxLVHE7YMMBR9qQx+bWxJupZplnLfZnkAeCsg/XtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPmzDaX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A27C4CEE2;
	Thu,  6 Feb 2025 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738858234;
	bh=JVWt17XGMFQ+8EsoEQmmkuuAFPUJK3BzB4mQxP8SF/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPmzDaX5ozfJMQdQ8wpe2rMZEYuXDe7bB9R6SjNGLaJ5JW6fQWgNAW9UEpUqUK3I5
	 opT+L73W/m1Lj9d7EIcXNZROgBj+UX8O1zK1GDEAqFzC4vP4Jwy6/kvYAeJUEyJw85
	 NdqJotZOkoMDYovjh+ig9E9Ga4KoddVJGUSucJGCXpelQ3gfsr6TadEzyTvTSv8Se8
	 ORFi4MzHbVobz+retFD8xdyWIHW47xExYk1RbKjzxM3ucguJCP2N6pymLISp5rGawz
	 Wp+2NygXlQ6QqcnlH5O4uok1uBTgVRLmkTtrKvj3jJn3IB8Fp6/dyOoyMOP8iYr6dM
	 bny0kPG1zMf2Q==
Date: Thu, 6 Feb 2025 08:10:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 06/10] tools/net/ynl: sanitise enums with
 leading digits in ynl-gen-c
Message-ID: <20250206081033.49a7f4d6@kernel.org>
In-Reply-To: <20250206092658.1383-7-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
	<20250206092658.1383-7-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 09:26:54 +0000 Donald Hunter wrote:
>  class Type(SpecAttr):
> +    starts_with_digit = re.compile(r"^\d")
> +
>      def __init__(self, family, attr_set, attr, value):
>          super().__init__(family, attr_set, attr, value)
>  
> @@ -74,6 +76,8 @@ class Type(SpecAttr):
>          self.c_name = c_lower(self.name)
>          if self.c_name in _C_KW:
>              self.c_name += '_'
> +        if self.starts_with_digit.match(self.c_name):
> +            self.c_name = '_' + self.c_name

bit heavyweight with the regex? I think this would do:

	if self.c_name[0].isdigit():

but either way:

Acked-by: Jakub Kicinski <kuba@kernel.org>

