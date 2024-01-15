Return-Path: <linux-wireless+bounces-1937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66582DC6C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 16:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A598F282608
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22E1773D;
	Mon, 15 Jan 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCsQuhY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265D8BE2
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 15:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D0FC433C7;
	Mon, 15 Jan 2024 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705332948;
	bh=yHZKmeXhQWua2LT7+setasCLUF/ot995lzkKJhmsS6Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VCsQuhY71D7udhp0cWBDWk05XvZ6EeWqwybkVSgG4UkH+RC1L593tLwixK2X6VmWD
	 A7YrivuOgQP5k5mBcR1+BMiPEREz2AgJzT/8UqyBvnfHNnlHhhI70tDyzY7CsZ14o2
	 qybgmRxynXZYh8SNexAitvXq3PROKWnJ69xsLbGV0Tf1UyIkfo7Mxbaj4CZzKZTxr6
	 izXJYGp4xtjVdbamQ6O2RmsL8W83JwSU3ak2YPPdqy4seb8HgP1R7vO++cnmVxaH4E
	 g+nPEYMjcFf+8YWJx1f/dVh29v4nz0XhtzFqf+lNpQai+TC1UflcO3Np74QuTdksZS
	 zTmm+5wk2GscQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/10] wifi: ath12k: Refactor mac80211 callback
 operation functions
References: <20240103063731.3356060-1-quic_periyasa@quicinc.com>
Date: Mon, 15 Jan 2024 17:35:45 +0200
In-Reply-To: <20240103063731.3356060-1-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Wed, 3 Jan 2024 12:07:21 +0530")
Message-ID: <87r0ii7goe.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the existing mac80211 callback functions are defined assuming
> each link/radio is represented by a single mac80211 hw. In order to
> support multi link operation (MLO), need to move from the multi wiphy
> model to a single wiphy model. However, the single wiphy model allows
> multiple link/radio to be exposed by the same mac80211 hw. Therefore, we
> need to separate the link/radio specific handling within the mac80211
> callback operations. This way, the callback can be extended to support
> multiple link/radio in the future.
>
> 			Current Multi wiphy Model
>
> +---------------+            +---------------+            +-------------+
> |  Mac80211 hw  |            | Mac80211 hw   |            |Mac80211 hw  |
> |  private data |            | private data  |            |private data |
> |               |            |               |            |             |
> |               |            |               |            |             |
> |               |            |               |            |             |
> |   ar (2GHz)   |            |   ar (5GHz)   |            |  ar (6GHz)  |
> |               |            |               |            |             |
> |               |            |               |            |             |
> |               |            |               |            |             |
> +---------------+            +---------------+            +-------------+
>
>
>
>
> 			  Single wiphy Model
>
>                            +--------------+
>                            | Mac80211 hw  |
>                            | private data |
>                            |              |
>                            |ath12k hw (ah)|
>                            | +----------+ |
>                            | |ar (2GHz) | |
>                            | +----------+ |
>                            | |          | |
>                            | |ar (5GHz) | |
>                            | +----------+ |
>                            | |          | |
>                            | |ar (6GHz) | |
>                            | |          | |
>                            | +----------+ |
>                            +--------------+
>
>
> Karthikeyan Periyasamy (10):
>   wifi: ath12k: Refactor mac callback of config
>   wifi: ath12k: Refactor mac callback of bss info changed
>   wifi: ath12k: Refactor mac callback of conf tx
>   wifi: ath12k: Refactor mac callback of start
>   wifi: ath12k: Refactor mac callback of stop
>   wifi: ath12k: Refactor mac callback of update vif offload
>   wifi: ath12k: Refactor mac callback of configure filter
>   wifi: ath12k: Refactor mac callback of ampdu action
>   wifi: ath12k: Refactor mac callback of flush
>   wifi: ath12k: Refactor start vdev delay function

In the pending branch I renamed the patch titles like this, an example:

wifi: ath12k: refactor ath12k_mac_op_conf_tx()

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bdb399b467daacabdc0e2127e03874d399f17a38

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

