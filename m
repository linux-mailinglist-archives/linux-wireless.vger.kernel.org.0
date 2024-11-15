Return-Path: <linux-wireless+bounces-15330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FA9CF441
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430CF1F282E6
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85A1D90CB;
	Fri, 15 Nov 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEKAP9h5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDA18787A;
	Fri, 15 Nov 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696420; cv=none; b=Nit51AYghTxcz+FtCjCnlU6rFDX1mYxRBMwB9vh0gZIAB+/4TqDDh0n8zV/GGuTXamoC7ObZAwnd3U2e1QwhxO8G5m4T8dUa8Hj5L/lGkH5CLEMw2tGpl5x3S8BEZVe4lzUg4Q5lRri7NHiuHCdtvfIPZaR7QypZjtmfM/qGiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696420; c=relaxed/simple;
	bh=X/BwoMLgA/Y/tWF4yzBI7YF5dBA32nk8rTnMdevZehM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejPOCq5HTte/ptKTlPBistxq8i3x9kCxWZe9ZmZmniGB1RrODcmkHbNqSzjADIKbzMic1kispWIMirqx0vVvy70/OS9FwKUav4Quypp+Pn2a5ESqISVgMwFGf9ko5LTIbSfBPwiPLDS3jMeutYC801bQEZMf5TMa/NUaNQgJGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEKAP9h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E64C4CECF;
	Fri, 15 Nov 2024 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731696420;
	bh=X/BwoMLgA/Y/tWF4yzBI7YF5dBA32nk8rTnMdevZehM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEKAP9h52lJX9fM3uP1cccOIbn1/wuU+iwQKQrYjhp6HkUUju6P145Q/YfSElkuMY
	 w2z4gqD9Bd5O3wvnau5ipvCj3gt37K/PUi3ODdduuClOu+UK4kgwT+quiHXrFFkbvZ
	 yCPN5xepcaPABQCcz724/7S50AnKrH+1CpfZ7JIrzYT37wAGdYdl9ZFxDVVl4cluiu
	 iI1j0vTTKsVz1VuJZKzoDnNXuTJBeuR9yM6GJhoWijwVYlEz+dluW6p3iXn7/gCB39
	 I0qq110+SyytG/klyQLXITwcSeJ8YMrRhtORMn7lGbJ5TMTi7/1dnvq4gFfnxDIHB5
	 bRKJKMnktkTwQ==
Date: Fri, 15 Nov 2024 10:46:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pablo@netfilter.org, linux@armlinux.org.uk, richardcochran@gmail.com,
 johannes@sipsolutions.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 dsahern@kernel.org, wintera@linux.ibm.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, jhs@mojatatu.com, jiri@resnulli.us,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
Message-ID: <20241115104658.72285ff5@kernel.org>
In-Reply-To: <20241115163612.904906-1-kuba@kernel.org>
References: <20241115163612.904906-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 08:36:12 -0800 Jakub Kicinski wrote:
>   * Return:
> - * Return allocated page or page fragment, otherwise return NULL.
> + * Return: allocated page or page fragment, otherwise return NULL.
>   */

I missed the double-Return sort of formatting, will send v2 next week
-- 
pw-bot: cr

