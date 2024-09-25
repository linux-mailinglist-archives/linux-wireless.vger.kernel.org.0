Return-Path: <linux-wireless+bounces-13141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C1985366
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B98B281D7D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B08154C08;
	Wed, 25 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8U4dPJw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C4132103;
	Wed, 25 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248108; cv=none; b=h3sB62bkfkNkar3uapAOvD/LwrdPPg6pl4DNvQ4duqvE9TtwrDbuw1asO+b6oEQ840PYo47DHYHCFNBvOpcBfbX7TaJE+3q/5lWdSCe4j0NxhtMJqPjZPoTr59fA4uonwUpiSByD4sPvEK5U5oAdZ1PQRDzYT8bN9S9YhZsjDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248108; c=relaxed/simple;
	bh=8C9zq1a496NalKgWmrzYn8bXqhj/Q05OOw+7Zz22H1w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KnD+R6Awt9AUmn3yGYkBhMKa/joPMtIRGjY1RYLL20F+SQQ6Fl+vnvXr5kRTB7w/KmTs4T0cAeyVvlPnOWUuvcIXEjWl2LQqY5jMvQg58Tb5fjGWUwy2M1pSTEAmkbDXQf3L3TQKD6pbcNWeHfBXEL7xh9kI/LYiQXjFc6MRRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8U4dPJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303DEC4CEC3;
	Wed, 25 Sep 2024 07:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727248108;
	bh=8C9zq1a496NalKgWmrzYn8bXqhj/Q05OOw+7Zz22H1w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=t8U4dPJwqPVePK5ibIHYaUUfrJdlCelv6H/y687rQt6wyCNuhcAHJc6TjAh5Y9MKC
	 xKtA1Qsvzjy7ds+LAP4atySalx5H/RfM+riSwuvKjr5uYn/SqzQ5F/3/NVkmBtUdcc
	 DFyxBwaHD/lOwQDqX4FEGN9+G+ZRA4tw2LXj+Zuq0NAHNRwAOs6ev3SL0JO1mmsxpk
	 BcTgms1h2rnf6dXE78EutsUqAUlNjmE94enSgB0pDdF2k6m5FnJnX/bP+WZNsgW0vM
	 YaC00xT3EZCSsGRuCqwPqVowrFpB4ywM836hGWRTVnjpAxdSSwBhWh2sQoYqot7BRO
	 cD7EJMcIcaxOg==
From: Kalle Valo <kvalo@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mac80211: MAC80211_MESSAGE_TRACING should depend on
 TRACING
References: <85bbe38ce0df13350f45714e2dc288cc70947a19.1727179690.git.geert@linux-m68k.org>
Date: Wed, 25 Sep 2024 10:08:24 +0300
In-Reply-To: <85bbe38ce0df13350f45714e2dc288cc70947a19.1727179690.git.geert@linux-m68k.org>
	(Geert Uytterhoeven's message of "Tue, 24 Sep 2024 14:08:57 +0200")
Message-ID: <87a5fw9pnb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> When tracing is disabled, there is no point in asking the user about
> enabling tracing of all mac80211 debug messages.
>
> Fixes: 3fae0273168026ed ("mac80211: trace debug messages")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

mac80211 patches go to wireless tree, not net. Also 'wifi:' missing from
subject but I suspect Johannes can fix that during commit, so no need to
resend (I hope).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

