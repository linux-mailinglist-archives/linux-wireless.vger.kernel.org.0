Return-Path: <linux-wireless+bounces-15157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED149C321C
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Nov 2024 14:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77FB28146E
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Nov 2024 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305CF1547C8;
	Sun, 10 Nov 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZblRtM4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572C847B;
	Sun, 10 Nov 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731244131; cv=none; b=OEFGZ6DvKxNUJKxN5UaSagP0cM0/2mJrPwnP64nsPIvSv1QnNFCybyJE/4+ycG0HhvXrKDzq9uXe+31xQA/6hSQn6sjduVid+KwRkuwF/TpgeRAvgVU+r4H2KAmv2iTFvcgJNL9D6lbphmhU/yllfrb47KLYWGgg88cXjgOQlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731244131; c=relaxed/simple;
	bh=hd6OE1c1WD+mxP7GixtxSUqagcvFHfJKil44W6QVUQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPR+SlcooWoO60pvowrDmtQq4xrIufqUjfaXvTL+NH8yIII8WnTSVuLFv+jHlKIku8WAtxPM5jFiE3YYn5AKe4c055QxrMVL86Pkq+KQ4Gy/EyudBhF+qD0tVMCWnU14nZQi3di73bCmIfEDoeZ/nrMXb6b5lLr+qfBjGOkSTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZblRtM4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58757C4CECD;
	Sun, 10 Nov 2024 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731244130;
	bh=hd6OE1c1WD+mxP7GixtxSUqagcvFHfJKil44W6QVUQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZblRtM4IKufp0f3KTDk/84NWp370punWIRoC9spihf5lWByfbXAvefUTyD/p1lqCa
	 sSxlf7y8YY5MfGij9tNhH+Xr+CwTuIdZWZy8CQxz41cG6x76IV3tcCw0/cn0kSjp6c
	 e0LaI3R8e7IwdYAZRRozICiWEDUXL3ZuSsxCLDcLBu65/iE1GE++TtHsAeWZgKFmHb
	 r4CCC6LKqkJNNtQaFMN+bBnatj8zHCDXMTYqtKFE1xZfB9aYZKtNg798GJbNdmDy3A
	 U+NMomShvVIC8HUxvRJLRKbpv4wksouCN7G1gcUWNIVQClCTSGe8t2NwSmgIBxucOE
	 +olZxFzvJd8dQ==
Date: Sun, 10 Nov 2024 13:08:46 +0000
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 2/2] net: convert to nla_get_*_default()
Message-ID: <20241110130846.GK4507@kernel.org>
References: <20241107134331.cbacbd7d40e0.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
 <20241107134331.861afd88e719.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107134331.861afd88e719.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>

On Thu, Nov 07, 2024 at 01:43:31PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Most of the original conversion is from the spatch below,
> but I edited some and left out other instances that were
> either buggy after conversion (where default values don't
> fit into the type) or just looked strange.
> 
>     @@
>     expression attr, def;
>     expression val;
>     identifier fn =~ "^nla_get_.*";
>     fresh identifier dfn = fn ## "_default";
>     @@
>     (
>     -if (attr)
>     -  val = fn(attr);
>     -else
>     -  val = def;
>     +val = dfn(attr, def);
>     |
>     -if (!attr)
>     -  val = def;
>     -else
>     -  val = fn(attr);
>     +val = dfn(attr, def);
>     |
>     -if (!attr)
>     -  return def;
>     -return fn(attr);
>     +return dfn(attr, def);
>     |
>     -attr ? fn(attr) : def
>     +dfn(attr, def)
>     |
>     -!attr ? def : fn(attr)
>     +dfn(attr, def)
>     )
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


