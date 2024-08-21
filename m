Return-Path: <linux-wireless+bounces-11756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2795A3D6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 19:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB45B1C22A31
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C41B2534;
	Wed, 21 Aug 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVltTT5r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331781494D1;
	Wed, 21 Aug 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261203; cv=none; b=Qx6EZ2LoKDQT0wcmvxdGhMbzrKeO83Rqnpi7+2C2j9onnNTsHdLAApwPxOsd7etPTd/caWGGOtPiT2U3juDiIvQgviHZadD/oFuNK0/4QwQbkD5X7KdJR5CYukIHJ0Ks4looX/HpkgJ2/fmeOwfUk/ia6kNF8Lw3DPYYIned7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261203; c=relaxed/simple;
	bh=DM8/2KFRUJTePMGmJN4jQx4medejbfrHu9JQdUL0RtQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Hd7lWGoceAh9z3jhzM6hYzLegiRWcftBp4wNUOkv1wS35GM8rgMp3JC9B1o2furbc+/7Tuu71nOya4/wMaWG0MAvkfZCx1sZchZZmU8e+KDg1Okrr98wWV2ZS2rIJlp4kJX7nYARFNYkc20ARfZhzLLwdGI7LaaYv5ejs3A7lK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVltTT5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E5CC32781;
	Wed, 21 Aug 2024 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724261202;
	bh=DM8/2KFRUJTePMGmJN4jQx4medejbfrHu9JQdUL0RtQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gVltTT5rSL/gfwr+3AtiExA4fRwSWLVf9YuL1pwgCEJifq24xclEDNpz/filNrGVt
	 1N4n5Ipw8nk+3vk3hFFKTMhT91/US58monOE0XKgASeSl6kpBp0HcleXzwbSfVmGk2
	 7WVhCu5rxRsJAv68HVy1cD2is38HuuVlw9dpIskRbAv3jNjQYR0NJOJxszVKjSgOaV
	 whughWqvifpvqvmpdzFGQnTlqZeYHGVyIQslLbYLYw9UOLmgDxkKxPtL9IkqhpeJWg
	 9NAG+agYdA/IJeLNuFy1a77eQVTH4jRKZbeXmui+yiiOh+rHZ9YgPGQ6u70jDe0dyE
	 ppv+R6tWhspcA==
From: Kalle Valo <kvalo@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  opensource.kernel@vivo.com
Subject: Re: [PATCH v2] wifi: cfg80211: Use kmemdup_array instead of kmemdup
 for multiple allocation
References: <20240821111250.591558-1-yujiaoliang@vivo.com>
Date: Wed, 21 Aug 2024 20:26:38 +0300
In-Reply-To: <20240821111250.591558-1-yujiaoliang@vivo.com> (Yu Jiaoliang's
	message of "Wed, 21 Aug 2024 19:12:50 +0800")
Message-ID: <87a5h5hjn5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yu Jiaoliang <yujiaoliang@vivo.com> writes:

> Let the kememdup_array() take care about multiplication and possible
> overflows.
>
> v2:
> -Change sizeof(limits[0]) to sizeof(*limits)
> -Fix title prefix
>
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Kalle Valo <kvalo@kernel.org>

No, I did not review your patch. Do not add any tags (like Reviewed-by)
unless a person gives you that in a reply.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

