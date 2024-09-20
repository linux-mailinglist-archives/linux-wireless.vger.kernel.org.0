Return-Path: <linux-wireless+bounces-13037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58897D118
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F10B21424
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A42AF12;
	Fri, 20 Sep 2024 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5fVjqgB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2833986;
	Fri, 20 Sep 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813342; cv=none; b=KBZ7NlHa7DLIdsJv3+XkOwXktuXzWHscEccU35A0FZFkQNDLqpA7mOFEgEG1iG+Y/LS/OFQijd8YM3a8UQ5eY7gHfxEboGB3tA+uWxuMzrMDOV5C4ab3g8p8fwCUfqpnF8DezclTXs4gsXqgq0beFI5mxxA5YM+v2K0nrZJTFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813342; c=relaxed/simple;
	bh=+jAirL1/oeAkkDpgdQtrPbO8kpNl79De0V9vN6W6MbM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bcNHSDdj36G+E9lFQ7JrJyZsOc3dpHedi0RrAc2ZeTUJoVXO0Zsl57yua4heDEm49QPUEu0RrHAFiOYES4j/vfYPqG8EK5Dnz0lHIgNJsqyjamY1O4dy2TUC/531aI4CkhmHnaJ2+wzqE6rOJbQZphl6sJdYYhfMoRJuoLuQWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5fVjqgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36798C4CEC3;
	Fri, 20 Sep 2024 06:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726813341;
	bh=+jAirL1/oeAkkDpgdQtrPbO8kpNl79De0V9vN6W6MbM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=b5fVjqgBli9C8jpCq2u03zWPjW/REQgQXeNkVT/QXCSqO2Ith8qnm+/Zz9eKOyAfC
	 4a42udKV8uWCIrB4IRBUO/3qJDMSnadIqgDKZk/BF21eZCoA2jiZNAnvBava0QydWJ
	 3LRcNz/Z0siGhNYFQibbhDnUzJaly8rsGt4GeI7ar+DeGupHMJqCm+vjAw7aJxlWc2
	 AeaM+Q0N06b5lOFgN8yZRLeLLSEBH22mwbNEXTUVthgBgPRtEvzVzBb+Z5u/33PO1+
	 6/jjt+FxTJC/bIfMUBVKAwFZ1zmxGLyctrX3gcg1xRZcAKClsE07C7lf0jH7YRRsmV
	 8U7i25yy2cBIA==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Jeff Johnson <jjohnson@kernel.org>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  ath11k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the
 inputs of the ath11k on WCN6855
References: <20240814082301.8091-1-brgl@bgdev.pl>
	<83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
	<87msk49j8m.fsf@kernel.org>
	<CAMRc=McEWWm8N++4a5LMCAa0GWsQdi0KuSpj3ZuS_he=H0LP+w@mail.gmail.com>
Date: Fri, 20 Sep 2024 09:22:16 +0300
In-Reply-To: <CAMRc=McEWWm8N++4a5LMCAa0GWsQdi0KuSpj3ZuS_he=H0LP+w@mail.gmail.com>
	(Bartosz Golaszewski's message of "Thu, 19 Sep 2024 03:59:17 -0500")
Message-ID: <87ed5ec09z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> On Thu, 19 Sep 2024 09:48:41 +0200, Kalle Valo <kvalo@kernel.org> said:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>
>>> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> ---
>>>> v1 -> v2:
>>>> - update the example
>>>
>>> I don't understand why this patch is no being picked up. The code
>>> correct represents the piece of hardware. The supplies should be
>>> required, because this one particular device - the one described in this
>>> binding - cannot work without them.
>>
>> I have already explained the situation. With supplies changed to
>> optional I'm happy take the patch.
>>
>
> No, silent NAKing and needless stalling is what you're doing. I responded to
> your last email with extensive clarifications. You're being told by the
> experts on the subject matter (Krzysztof and Conor) that the change is correct.
>
> The change has no functional impact on the driver code.

Until now it was possible to use qcom,ath11k-calibration-variant DT
property with M.2 devices. If your patch is applied that's not possible
anymore.

> It's also in line with commit 71839a929d9e ("dt-bindings: net:
> wireless: qcom,ath11k: describe the ath11k on QCA6390") under which we
> had literally the same discussion and that you ended up picking up
> after all.

I don't care about QCA6390 as it's not really used anywhere anymore. I
picked up 71839a929d9e, even though I considered it to be wrong, so that
your pwrseq subsystem is not delayed. But WCN6855 is a different matter
as it's more widely used.

> Arnd: I've added you here to bring this to your attention because it's somewhat
> related to what we discussed yesterday. It's a change that is very much
> SoC-specific, that has trouble getting upstream due to the driver's maintainer
> unwilingness to accept it. Is this a case where a change to DT bindings should
> go through the SoC rather than the driver tree?

Like I have said, I'm happy to take the patch if the supplies are
optional. Why can't we do that?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

