Return-Path: <linux-wireless+bounces-17835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59455A19414
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5661188A419
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51283214205;
	Wed, 22 Jan 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="addMpHj1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762F212D69;
	Wed, 22 Jan 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556588; cv=none; b=VEJP/OAyJK3Wi7jBIHQwFWWth94+/voSFAFkSRusd4juJgU64bTHLoNwhBUHNRNBRnh1fohPyMjnep09bcF89xs0SSu6GzIdPEO900C09DXxwIVx9FxyUnIQ7LeG6Ki+hcs/6oTE5suADECbWvtbBvtQaRzADiCLbfYHz4qMOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556588; c=relaxed/simple;
	bh=RV4JzHzu4eae6pTD2OhfKychm32hjbSiAStbOOtl1is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb+D8mXV35DK8iMpWNhIAciNXQoO8T+ide4EF6BSDzf/Z6KK0RY5dhp7nQBN2kQaLTLjnBoAoPvzTNAFR8iYS9IuHRSGqnOSwVXABnXldU9LAVoWf04YVTz6kRESFFxsnMD4Dqxww+9MA8wQxDETP981cJ+nd9KIQ47r0TxRMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=addMpHj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C67C4CEE2;
	Wed, 22 Jan 2025 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737556587;
	bh=RV4JzHzu4eae6pTD2OhfKychm32hjbSiAStbOOtl1is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=addMpHj15vc11sVqNn5Y9wkAElpxAeYhdOZyZmcBkjPa/hPmy7s6N7ieyZMvkpgfZ
	 qGqUJ4HQFKo4i40iD3ihQbeqO/Jd0fqgSH+Hh13TLxQp+JHVBgUA9IxBw09bgvY7Mz
	 bmqTSQH5wsQKwH9UhORsyTTJcKyNDAv5ApBqg887ir9QkRohDE5Y58Mk1op66mFbCm
	 vZd9KhTxwZs4BbsH5x36ih+ylB7jjbiX2Q/IV/x769a9f9M5gEIfKS/F9+f0F2v565
	 /Kh+WkuyDGDzN8eYw6cu7wKXvqRuHK+TZ3GWkqOpTIHrROwEpIzEFFzx574kriE46c
	 XHmDJEjACdnuQ==
Date: Wed, 22 Jan 2025 06:36:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org,
 nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 quan.zhou@mediatek.com, johannes.berg@intel.com,
 emmanuel.grumbach@intel.com, leitao@debian.org, mingyen.hsieh@mediatek.com,
 leon.yen@mediatek.com, deren.wu@mediatek.com, chui-hao.chiu@mediatek.com,
 kuniyu@amazon.com, romieu@fr.zoreil.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] wifi: mt76: move napi_enable() from under
 BH
Message-ID: <20250122063625.3ccac084@kernel.org>
In-Reply-To: <CANn89i+n4bpxUXMOiYdFa57SATCreum+XQAd8DtkLOFpic0a=A@mail.gmail.com>
References: <20250121221519.392014-1-kuba@kernel.org>
	<20250121221519.392014-8-kuba@kernel.org>
	<CANn89i+n4bpxUXMOiYdFa57SATCreum+XQAd8DtkLOFpic0a=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 15:25:46 +0100 Eric Dumazet wrote:
> napi_schedule() can run from arbitrary contexts though...
> 
> BH protection seems strange to me, but this is orthogonal to your fix.

Right, it doesn't need the BH "protection", it's just what we 
do to make sure there is a softirq hook point after we call it.
Since local_irq_restore() does not call softirqs. 

I didn't know how to express that in a way that would be understandable
for most :S

Thanks for catching the other bug!

