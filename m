Return-Path: <linux-wireless+bounces-12001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E395F957
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 21:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D449C1F227CC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C81990CD;
	Mon, 26 Aug 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ2p09a4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236E84039;
	Mon, 26 Aug 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698960; cv=none; b=Dqp2+xRJUFA9AeHGmLPAjZT/4mbWiy80NfcK6rgXFZ2fjeZOLD5/pSx4cazKswHFGMhg76fcE1T61gHNgptLTv8ILhLfDZQLGK8CC6ZwtYBK9l/8rD1KOXJMyizwKhb6BYDib4wMv4xABMlbGKXnOWf7nu4pTJh7xWGBK4b0ObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698960; c=relaxed/simple;
	bh=OcWpWVRrtsMaT3oP17nElc01GySh5DS/TzMiuqAWNAk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FNwTStS51+1z8+Tz/Oo96WbdUCzJ35HawMXqRKZVvHLUJJHIPqR+dF2eD4WHD41M5jRF7w3aKDuDx49fx+3bcg2mw7pA1988ZNfXBK/Q+ULCa1jbov4VeeUipbxfQh2cgIOuSX+5hqaHSPX4ApvJhhbJSwswkQTYXOhnhMPPVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ2p09a4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB77C8B7A6;
	Mon, 26 Aug 2024 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724698959;
	bh=OcWpWVRrtsMaT3oP17nElc01GySh5DS/TzMiuqAWNAk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lZ2p09a4uZJtNbRm7ysmlmQzuqDflfabntixL4VjUYJ1VDPAnaIdBG7dZsWLWwE96
	 MFSuDGMW3d8n9lFgqPTXnVqKq0FSCieWjHfaqt4nf+va9USJYoMF+IyO8ws46/XG0O
	 4yQQRGrEb7oDF3V+kLzae7pB82axM1eCqyV4SXnxrZ5AyVOAfl5pI6mxM14POKCULy
	 ulcdLW8rUrjFrmcNdozcDAZsYW+f5cKqUBdAe3h+4IggfMUltZWX/Sza+tSneca4hx
	 H2HXP3GPlNQzIO0s1ocmApLHqDt3CnGxENwxumhq7tIpLyP2DqrTgFdtZPSMKyw0ED
	 oGA32AF4zdI8A==
From: Kalle Valo <kvalo@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <johannes@sipsolutions.net>,  <davem@davemloft.net>,
  <edumazet@google.com>,  <kuba@kernel.org>,  <pabeni@redhat.com>,
  <allison.henderson@oracle.com>,  <dsahern@kernel.org>,
  <pshelar@ovn.org>,  <linux-wireless@vger.kernel.org>,
  <netdev@vger.kernel.org>,  <rds-devel@oss.oracle.com>,
  <dccp@vger.kernel.org>,  <dev@openvswitch.org>,
  <linux-afs@lists.infradead.org>
Subject: Re: [PATCH net-next 1/8] net/mac80211: use max to simplify the code
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
	<20240824074033.2134514-2-lihongbo22@huawei.com>
Date: Mon, 26 Aug 2024 22:02:34 +0300
In-Reply-To: <20240824074033.2134514-2-lihongbo22@huawei.com> (Hongbo Li's
	message of "Sat, 24 Aug 2024 15:40:26 +0800")
Message-ID: <87h6b7f6ph.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hongbo Li <lihongbo22@huawei.com> writes:

> The following Coccinelle/coccicheck warning reported by
> minmax.cocci:
>     WARNING opportunity for max()
> Let's use max() to simplify the code and fix the warning.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/mac80211/driver-ops.h | 2 +-
>  net/mac80211/mlme.c       | 2 +-
>  net/mac80211/scan.c       | 6 ++----
>  net/mac80211/tdls.c       | 2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)

mac80211 patches go to wireless-next, please submit this separately. And
the title should begin with 'wifi: mac80211:'.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

