Return-Path: <linux-wireless+bounces-13001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D8E97C547
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 09:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3724B224F7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6219882C;
	Thu, 19 Sep 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc4q2SML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68F198822;
	Thu, 19 Sep 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732127; cv=none; b=jA7v/LC4Dm5iKZ7KSQd9ftPZ/I+JJyftGevx8dkbfqbZR3K2WwVbKHb46te0k4ltp7S1cYFVuM3YEcb3o3gGIHaAdNVj2SHr5kEBtKTsbGJdo6+yLIZ3XTxq/5qxB7zNybcCjHLo32ehnPBZJXbc1JELO8jCzkNLa9OvCy1nBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732127; c=relaxed/simple;
	bh=5i1YXeZcMX46ZW9/4GfFPwm8EbpuGNMp3b6EfmSvDeI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=r7eLI3tm3PauXAkUZIdnVVu3ZcEj55VF+UXgbuXPTU82v4d8z5Ua1tQZ+QpZi7X0CGuKK4PNo6Ru2T6360K+F7wxHNt+frIVRBHIxqY34Ogu+x0FrvG6n6CB/CEhvT0W9Zj2HvHm51ioXtp+rHWlrxgGOYzNRwUd9kCKrgAn3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc4q2SML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F6C4CECF;
	Thu, 19 Sep 2024 07:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726732126;
	bh=5i1YXeZcMX46ZW9/4GfFPwm8EbpuGNMp3b6EfmSvDeI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Lc4q2SMLW7byQ3nu3pq6Ke7JkI84zZIi5tgrvBMxTozrFDt/cprQepzOCsji+dKY9
	 X7FyF7gee3j75ZnwvleP4p7AJxqDfI5/iMRbU23K/BikE66k1aX3rqwsCsYlUEWKdQ
	 FyywpazeYqTz0t/lxgtfKq4Rj4Lk0K0nxAhdIvaSvZwy10qd932Sh3NZ8Cxt+J72Mw
	 PPLvqFAi+fKRXfD+8ZuW/rNiFX+ShQIMCmrO2w5VcAjO99l+w0Y0P5x0YYE2rHPM9e
	 PkmPPfwmMjtOxmqu7mKEZe4b8FtFWeYCtTljKmoYnE1NMvDh3x7qsH7Q7PFTz+aOSS
	 4wzKxa5YYqEAg==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Jeff Johnson <jjohnson@kernel.org>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  ath11k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the
 inputs of the ath11k on WCN6855
References: <20240814082301.8091-1-brgl@bgdev.pl>
	<83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
Date: Thu, 19 Sep 2024 10:48:41 +0300
In-Reply-To: <83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 19 Sep 2024 08:55:36 +0200")
Message-ID: <87msk49j8m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> 
>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>> 
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>> v1 -> v2:
>> - update the example
>
> I don't understand why this patch is no being picked up. The code
> correct represents the piece of hardware. The supplies should be
> required, because this one particular device - the one described in this
> binding - cannot work without them.

I have already explained the situation. With supplies changed to
optional I'm happy take the patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

