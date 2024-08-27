Return-Path: <linux-wireless+bounces-12089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CBF961626
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406DF282304
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA39B1D1730;
	Tue, 27 Aug 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohod8/mJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE821CEAAF;
	Tue, 27 Aug 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781488; cv=none; b=Ha+gcA+6bxfzUM/2Ovfr5hinmW71MmaHsy55vQZVkdb7DNSx3Y3BCgjcnCi/5K6rhj1uHmCe+qfn6cnMZxqyjHHVBCtu7fz/UJ+KQrNM55L87iNrN1zfmbysBBL1XFzv65byeNQiaROVDapL6Qzm3i1JNO8xJ7N//9QWjJhyG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781488; c=relaxed/simple;
	bh=3H21zN/Q4sFN7iNNsYkynj6132zekBozN8LU2+Zndjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TheGOvkzA2T3kXa/mK1c6CvSGOie/7w3Z1y2vgftalCk2zI0Ed4VourVB2rAGToEjwFUmD2u+fusqdtQWnVFTTCt5vhGhlQyF/QvwwFJXJgKGSr9P1iY2usxyxVoS11xA26d31Dyo9/qhnNyNi6dNZc3aEWCjVC+VfCTpKC9/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohod8/mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C998C4AF0F;
	Tue, 27 Aug 2024 17:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724781488;
	bh=3H21zN/Q4sFN7iNNsYkynj6132zekBozN8LU2+Zndjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohod8/mJQyjOHtafuyrQZbERzJcYP5TvQB8GZxqGsHDgCjF8CeFYfgGC6Gt6DBnVw
	 bXNNvcsrm2EQ94dfAFnsZxbRubZIq4izrVb7pclKAgh5EB4MTM2ZyB91npAZOqC8/s
	 z8B/udm6v7HdRhuf7vc5jPeFQZzhAxr0NYynEDMkxkUnnPxjWVduNoR+rvsl3K/O6d
	 RMJ9+jlFHASJymbVPLx5aO5sD/VmksCPD/IWPdI5fBuLLj2Qun37SKufSW0NYGTYge
	 fn9mClBKEptmjxq7x6W9rPss03QKeRw8ZCXPyRUfZ60IPmwsDNCEdT5TmTqhnTrllV
	 DLQI3xoUSAqOA==
Date: Tue, 27 Aug 2024 18:58:02 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: David Howells <dhowells@redhat.com>, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allison.henderson@oracle.com, dsahern@kernel.org,
	pshelar@ovn.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org
Subject: Re: [PATCH net-next 7/8] net/rxrpc: Use min() to simplify the code
Message-ID: <20240827175802.GA1903074@kernel.org>
References: <20240824074033.2134514-8-lihongbo22@huawei.com>
 <20240824074033.2134514-1-lihongbo22@huawei.com>
 <563923.1724501215@warthog.procyon.org.uk>
 <1b1ee6e6-ff2e-45d6-bfe2-1f8efaba7b38@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1ee6e6-ff2e-45d6-bfe2-1f8efaba7b38@huawei.com>

On Mon, Aug 26, 2024 at 10:50:03AM +0800, Hongbo Li wrote:
> 
> 
> On 2024/8/24 20:06, David Howells wrote:
> > Hongbo Li <lihongbo22@huawei.com> wrote:
> > 
> > > -	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
> > > -			      sp->ack.reason : RXRPC_ACK__INVALID);
> > > +	summary.ack_reason = min(sp->ack.reason, RXRPC_ACK__INVALID);
> > 
> > Can you use umin() rather than min(), please?
> > 
> 
> I see reason is u8, so may I use min_t(u8, sp->ack.reason,
> RXRPC_ACK__INVALID)?

I believe that umin was added precisely to avoid such constructions.

See: 80fcac55385c ("minmax: add umin(a, b) and umax(a, b)")
     https://git.kernel.org/torvalds/c/80fcac55385c

