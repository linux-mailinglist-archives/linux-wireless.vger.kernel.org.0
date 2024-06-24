Return-Path: <linux-wireless+bounces-9489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2BF9145FF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5795E286BAA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 09:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451235EE97;
	Mon, 24 Jun 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtKHoYRd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D72C95;
	Mon, 24 Jun 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220554; cv=none; b=gd6xyRVAgU+1x2FOneVWQj6xVmm0wGI6F12miJ03e3Ijz+K2CtrriGE6ahWohCsA5OkpZ+2nVniTB+mgVxffuRg9wV4yUiNp0WvIlMjt5tzdsAvyxohkVydBFkIboKEG3tQMbXjf88RtaF4s57zqZB5LFCUER577BesnSoTyXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220554; c=relaxed/simple;
	bh=3TUo3EMMp2WVQ87yOcyBELzxPkaPehB8lSHQ5fDIpa4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uYOWrVcsqG2B4ntEzOAPbYDmZhlg2cz1SX/UVw6ievIK9Cy6ZVYhyy+iyrR5bzCRHb6C97ZwlMxRb6gK6VYcY0j8x8XRACOqf9ammq1FkpI+G7EVRKEEXxN8Vv51oPQyIDpd/fzbnrCn1Hz+46y+qnmh9dRqOtcD0he2fyEx4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtKHoYRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C062AC2BBFC;
	Mon, 24 Jun 2024 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220553;
	bh=3TUo3EMMp2WVQ87yOcyBELzxPkaPehB8lSHQ5fDIpa4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YtKHoYRd2HJ6enVATmRESqjstyG2dIxLknZWWpyuBwcZWbxfnKxTfEx6H4vJozKj7
	 g12H4ZeZw9ew7QsMS1sLjmz6zaSesZBWA4kGspJdrfwDtwUj44iQNtch4ajQOMLizS
	 b5U5ZSNwJ2pai5ca+DgIs6wVKZvRdPdxiSzFxWrsTdxP3mxJbFFXKIdeekFbqQIuWj
	 bFratpLU0LkufXyK46hUiepQoglazhqBMjIBiIFOg3IwBZlg0QZU6SEmDNUi6Z1fJn
	 YzkncSKGEfLj5LuwlxG42lNlfz16F2kcqZwr4uc7aSTGeAq/BYau2Upw7Mi9hdtNPb
	 lXoQrySK9LdVw==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Jeff Johnson <jjohnson@kernel.org>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  ath11k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  ath12k@lists.infradead.org,  Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
References: <20240605122106.23818-2-brgl@bgdev.pl>
	<171862259099.4124983.18069958656274980613.kvalo@kernel.org>
	<4c3d4437-4c24-4db3-855d-f2ba7d0c6f8a@kernel.org>
Date: Mon, 24 Jun 2024 12:15:47 +0300
In-Reply-To: <4c3d4437-4c24-4db3-855d-f2ba7d0c6f8a@kernel.org> (Krzysztof
	Kozlowski's message of "Mon, 24 Jun 2024 09:00:56 +0200")
Message-ID: <871q4mk8fw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 17/06/2024 13:09, Kalle Valo wrote:
>> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 
>>> Add a PCI compatible for the ATH11K module on QCA6390 and describe the
>>> power inputs from the PMU that it consumes.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> 2 patches applied to ath-next branch of ath.git, thanks.
>
> Hi Kalle,
>
> Are you sure your tree is properly fed to linux-next? I cannot find
> these patches in linux-next and above repo is not listed in Next/Trees.

ath.git is not included in linux-next builds. To my knowledge wireless
and wireless-next trees are the only trees from the wireless subsystem
which are included, all driver trees are not. But Jeff and I are talking
about including ath.git to linux-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

