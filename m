Return-Path: <linux-wireless+bounces-8615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3308FE7F3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7205DB2753C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42131195FF6;
	Thu,  6 Jun 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI/8uVeD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B217195F1C;
	Thu,  6 Jun 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680916; cv=none; b=nk0WpkUB1wzYwUtsEpQmnl8JLKS2Ya/i5PiIkPUUjqKhM83pjszhfL6VXXskLFKlxd6/1GiVSmcghPPVSPkjSpuYdxzLXo9XJGXUXJP9jpyJ0mB6nA4zZpoyr29rTjDfP4/XhiOpJx5t/Po+aLx0cy6eTYxK7MltN0A+XDmSuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680916; c=relaxed/simple;
	bh=g4hBhRJqi9bIx8jS0ly5UfYBFgfUA6hE9sFgGnJRl6Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DSgFhrLG4rS2m2XzzO3uba27YHigFtKCKRkHfHp607/VIC2stf0+qFF5A+Rlm7myvYQvfgJm1CoXtbWDoQgnD5DzrsyeOb9gngb+XN3PCFI+51dK+4y6tkN/HDxf7r6tZAD/nhJFLgpAysKrHPIPTz1g57cyq53AIMraTfRwE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI/8uVeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FBFC32786;
	Thu,  6 Jun 2024 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717680915;
	bh=g4hBhRJqi9bIx8jS0ly5UfYBFgfUA6hE9sFgGnJRl6Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MI/8uVeDWYEMCXL7mrddu/F6OFwCew54CFuTZaUQlMzthMjNfGOOnoSkG+XuO3oiK
	 KlhiDnQEyFDVMjoj9ZogtTDeslThV0Ktvx8oJy2fwRE75TzmpOgtADBa+SeIXVdy8Z
	 JDBwZGdUiTxEWsdTi0Vf4T8LkgddhOOca5aV7sEb0RUHdDRfnn0UiGHszoWhCwXUmU
	 vzYZXOYn1aTLPKGglyLUfel9g93KFSA5FZM3zcf81Itkz2TdsG3X5ngihFJTeVTHSU
	 0jcPtaweyEzGobZ+5zHRgAtqT/cFZSRWLhJTknkv3iI5W67WgoWbiKoKx5Rq4nXPoO
	 Ivy0MmpaMFl6g==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  ath11k@lists.infradead.org,  linux-kernel@vger.kernel.org,
  ath12k@lists.infradead.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v9 0/2] dt-bindings: describe the ath1X modules on QCom
 BT/WLAN chipsets
References: <20240605122106.23818-1-brgl@bgdev.pl>
Date: Thu, 06 Jun 2024 16:35:10 +0300
In-Reply-To: <20240605122106.23818-1-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Wed, 5 Jun 2024 14:21:03 +0200")
Message-ID: <878qziqjn5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Here are the two dt-binding patches from the power-sequencing series
> targeting the wireless subsystem. To keep the cover-letter short, I
> won't repeat all the details, they can be found in the cover-letter for
> v8. Please consider picking them up into your tree, they were reviewed
> by Krzysztof earlier.

Is it ok for everyone that I'll take these to our ath.git tree?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

