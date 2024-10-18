Return-Path: <linux-wireless+bounces-14209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84309A391B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC3D1F23EA0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191818F2D8;
	Fri, 18 Oct 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B1aifIBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71218E74D;
	Fri, 18 Oct 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241447; cv=none; b=OMJUIUDXgAkkFWa6BhXWQ3UNn2SzQMqC2/IPqdJ4CasyduYnL5EP7P9WWVhocAO7JEk3s7UmbqUIx3DNCqBgzk0ScOo0FjX7Gc6bVHgKatxIpbRRws2KqAGKL3Vm5LE5NNa8UhVPSC03kRGK5X/6hIpSbHxb4/Q6MiWBHt3ujyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241447; c=relaxed/simple;
	bh=6h58gmhvH19+l1HmL8w0zIeXa7o5pPUxEE3u/i7chHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDlqw5w9CFQaHoLheLJGxiRPKAL8NqR6CUL4zvrVF2y8V8EbSYsjDN02zNQZFUk10RHVxbTe7boFzUVWRxRAvm06UeuKy1SaRR7D+6Af/vSipmd+CFrslkeW2eS5f6OvBWW33mvdJWIu/XDdUw/7OELbtx4bUEdNL/iAknQfso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B1aifIBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7F7C4CEC7;
	Fri, 18 Oct 2024 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729241446;
	bh=6h58gmhvH19+l1HmL8w0zIeXa7o5pPUxEE3u/i7chHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1aifIBLfda4gEYe3iCknDkikfpKCFcV4s1rq0bU5yRneUxvldn6UyFYlOry2uPBV
	 yad+Y5j2oNoaADnoUXxV1l5nkAR/zGgd6MGsBz0mbIk0PQ0SouBJ3wUo3AZwZlp/Mp
	 m2anFgMQvkWc0l7Ewp4puKp+9EvxZ7h610Omuwho=
Date: Fri, 18 Oct 2024 10:50:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, johannes@sipsolutions.net,
	davem@davemloft.net, kuba@kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5.15.y 5.10.y 5.4.y] wifi: mac80211: fix potential key
 use-after-free
Message-ID: <2024101836-unsavory-snowdrift-1f2c@gregkh>
References: <20241015222030.1105765-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015222030.1105765-1-sherry.yang@oracle.com>

On Tue, Oct 15, 2024 at 03:20:30PM -0700, Sherry Yang wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> [ Upstream commit 31db78a4923ef5e2008f2eed321811ca79e7f71b ]
> 
> When ieee80211_key_link() is called by ieee80211_gtk_rekey_add()
> but returns 0 due to KRACK protection (identical key reinstall),
> ieee80211_gtk_rekey_add() will still return a pointer into the
> key, in a potential use-after-free. This normally doesn't happen
> since it's only called by iwlwifi in case of WoWLAN rekey offload
> which has its own KRACK protection, but still better to fix, do
> that by returning an error code and converting that to success on
> the cfg80211 boundary only, leaving the error for bad callers of
> ieee80211_gtk_rekey_add().
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: fdf7cb4185b6 ("mac80211: accept key reinstall without changing anything")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Sherry: bp to fix CVE-2023-52530, resolved minor conflicts in 
> net/mac80211/cfg.c because of context change due to missing commit
> 23a5f0af6ff4 ("wifi: mac80211: remove cipher scheme support")
> ccdde7c74ffd ("wifi: mac80211: properly implement MLO key handling")]
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>

Now queued up, thanks.

greg k-h

