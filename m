Return-Path: <linux-wireless+bounces-7681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208E8C6349
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 11:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F164C1F2397E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BAE57CAB;
	Wed, 15 May 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhDIlP+a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC25BACF;
	Wed, 15 May 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763566; cv=none; b=pyGPte4KZZZJxYzlSSWNQY/b6D2FvIpspDngfk6j8tJuvcYBCIlFi6VufLoAyxCbN5OgMEz122dd2rDHrAY7dswJqeNoawxkxyOVcY7aBIEkYYYQl0j0LLBGwUy7MhuwPkoeGnBuuM0o8+8Qgv18a4acWmf3/wO9USetQsZO3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763566; c=relaxed/simple;
	bh=wrhjNhMt1xp79b7iWBTzWLqdX0VxB4XNriKu8JSvx7A=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=G9xcpKj+fMAMarC8r0BQX6cGZY2yXJa3Lnzh1n+7LZ7NSYTYWlqQjfxtohGjyBn3U9WmItqYKGYkEgUVjpBIaOIMTcoobcwTWMVPqZe03nBKGi5AiDs4GNEJZbUXGXO9hn7frl7hZDKY2vREzDYj+bDjh5w1j3Ol3oTRrkXbJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhDIlP+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370CBC32786;
	Wed, 15 May 2024 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715763566;
	bh=wrhjNhMt1xp79b7iWBTzWLqdX0VxB4XNriKu8JSvx7A=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=PhDIlP+aiGt58su60LswgrQBw2yVfWrQypyefTD2zTRmGwkeot72P85JQ/WHMN+VG
	 0Sr1jzszzJwV8sf8J2jKx5Y2i1V1mejk5VuuRDqRO9b/aBWEqm9k2TxOf62JFe5DTX
	 caZrJCXPqpRfhhX/RXZ1mNjt3duGrLSkTJWoSYWMbP3Y0WI+FA8uQeVYM7Jo6Q3YyK
	 U424J2buUMXG/iAPXHqxPfVIUtWj2ITzSR5rNqUcC5tu7W8up8A3B0fGttcL7BcG3t
	 a/aVdn+2agHYjRT4GH3AGwmVTKWNl3yIV3IicTIXkaKZtlpqJJwz0l6xTLRmybSLKD
	 DwAPxUxz72TJA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various
 chipsets
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230611080505.17393-1-ansuelsmth@gmail.com>
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Sebastian Gottschall <s.gottschall@dd-wrt.com>,
 Steve deRosier <derosier@cal-sierra.com>, Kalle Valo <kvalo@codeaurora.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171576356159.2271935.2917787444907693936.kvalo@kernel.org>
Date: Wed, 15 May 2024 08:59:23 +0000 (UTC)

Christian Marangi <ansuelsmth@gmail.com> wrote:

> Adds LED and GPIO Control support for 988x, 9887, 9888, 99x0, 9984
> based chipsets with on chipset connected led's using WMI Firmware API.
> The LED device will get available named as "ath10k-phyX" at sysfs and
> can be controlled with various triggers.
> Adds also debugfs interface for gpio control.
> 
> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
> [kvalo: major reorg and cleanup]
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> [ansuel: rebase and small cleanup]
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8e1debd82466 wifi: ath10k: add LED and GPIO controlling support for various chipsets

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230611080505.17393-1-ansuelsmth@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


