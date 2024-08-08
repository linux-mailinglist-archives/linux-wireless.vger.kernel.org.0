Return-Path: <linux-wireless+bounces-11131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7C94C38B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CF01F283D3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BBD191466;
	Thu,  8 Aug 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey+v+lk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E35189B8D;
	Thu,  8 Aug 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137624; cv=none; b=t89v3MIgD+3/6ky7+LvR+V7GXqFP7h7OzNCW6Awwo6iJpH5oRMZf33sJvK3ll4t6ET/PW/415cYYORDKjMxM/TrpFmYV8sHBnJPsX2CLXMY4IWvDmRxkEM7Kh/MnZ9swfbZoD2vYM1Bf9bPeI87io7vG8GAv5/L89Fq9+Cb5VjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137624; c=relaxed/simple;
	bh=frzQzsm5MhWF5+FE6An4jpHJdeMQiqPsmIBSe8G7fpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehOe7TVaufUWa+IhbYRqYPx4iYIMdkE+sBKiroBIO53EolSuJGGDixNE//7DEyg9+mtpA31bcIuQ8BhPt193PCUF66fUccX1yL/smjtQpmeNO6ztBu09bgCMU+It4JRxD8V298jhvUqeYjqtfqGh+uEezDEz92DMUyq/0zSn5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey+v+lk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0070C32782;
	Thu,  8 Aug 2024 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723137623;
	bh=frzQzsm5MhWF5+FE6An4jpHJdeMQiqPsmIBSe8G7fpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ey+v+lk9EP6W3aoUZDhBmGDZyMbmIM18GngyiTsJCUngNzLwfFmsXXk3Zon5WYpGP
	 ox2eISoqOjXLBfoCPNeJHpKONZ4kAQukctFbQ+eJkHyaHuD0JvNrr8ecvCpqsHsGlD
	 Gz46x9Pt9qWI44mX0X6y1utaWMVrTbjP6NNps0U76SVsaV92gzvKUkGnhT8OVzvpDG
	 V4U/P2iauL3uhkWZVVwClfQ+WFJPKEhiI8y94z6HzLmQvpdOf4KDAcJePQbeA2h4iX
	 zdak0RxBJp59VhV8Zd3DP3lDWFySlhDG7HP6bxasISwAWCXpD2tNf8YbY0sXH4YM3q
	 dzPWZCzZ0Tm8Q==
Date: Thu, 8 Aug 2024 18:20:18 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	libertas-dev@lists.infradead.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: radiotap: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20240808172018.GC3075665@kernel.org>
References: <ZrJmjM4izqDqwIrc@cute>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrJmjM4izqDqwIrc@cute>

On Tue, Aug 06, 2024 at 12:08:12PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create a new tagged `struct ieee80211_radiotap_header_hdr`.
> This structure groups together all the members of the flexible
> `struct ieee80211_radiotap_header` except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct members currently causing
> trouble from `struct ieee80211_radiotap_header` to `struct
> ieee80211_radiotap_header_hdr`.
> 
> We also want to ensure that in case new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct ieee80211_radiotap_header_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> So, with these changes, fix the following warnings:
> drivers/net/wireless/ath/wil6210/txrx.c:309:50: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/ipw2100.c:2521:50: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/ipw2200.h:1146:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/ipw2x00/libipw.h:595:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/marvell/libertas/radiotap.h:34:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/marvell/libertas/radiotap.h:5:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/microchip/wilc1000/mon.c:10:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/microchip/wilc1000/mon.c:15:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/virtual/mac80211_hwsim.c:758:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/virtual/mac80211_hwsim.c:767:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


