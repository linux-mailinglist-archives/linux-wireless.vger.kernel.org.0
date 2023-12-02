Return-Path: <linux-wireless+bounces-319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA6801AD8
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 06:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB74F1F21170
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 05:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9FD8F7D;
	Sat,  2 Dec 2023 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awNc6pr/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662F619BF;
	Sat,  2 Dec 2023 05:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1FEC433CA;
	Sat,  2 Dec 2023 05:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701494179;
	bh=a5C2kC+KSpawAbx8lhoz4O1Yt38hNED4Gqe/bJLIJXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=awNc6pr/csIVFZadi+dsjlFqJH0vMZ2ya0aZlzFChyv3Oe81+rw4R9lfv5pE6X1Wu
	 zJDPqLj3FNIO9IyUbrp9totzo/CPWBzfCCb8Jxd7tqbqWcbkcimAEFCaE1bzClx5Mz
	 ZmQN3rKeEA4xL5k9EXnOiUohZVbj+iOBVa2GaOzC/Y5QGV29IIXPr8dbfiQcehiCWq
	 uaigaHSZhkJ0BrxfRrH4qXSBzLdLSLdxIn00RkSYMhqY+RePTkHFLfTYcV+S9knhEK
	 5ZCDev0zcE2qBfG3SoETXSspt3Iy0lIqg82doFYapGl5rokjwF7PtgkttShxOF/xdI
	 92qvdxwXfvHDw==
Date: Fri, 1 Dec 2023 21:16:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, Jeff
 Johnson <quic_jjohnson@quicinc.com>, Michael Walle <mwalle@kernel.org>, Max
 Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <20231201211617.30371d79@kernel.org>
In-Reply-To: <202312012026.A0178237@keescook>
References: <20231130200058.work.520-kees@kernel.org>
	<20231130172520.5a56ae50@kernel.org>
	<202312010953.BEDC06111@keescook>
	<20231201104505.44ec5c89@kernel.org>
	<202312012026.A0178237@keescook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 20:39:44 -0800 Kees Cook wrote:
> > We are reading nla->nla_len, which is the first 2 bytes of the structure.
> > And then we check if the structure is... there?  
> 
> I'm not debating whether it's there or not -- I'm saying the _contents_ of
> "nlattr::nla_len", in the face of corruption or lack of initialization,
> may be less than NLA_HDRLEN. (There's a lot of "but that's can't happen"
> that _does_ happen in the kernel, so I'm extra paranoid.)

nlattr is not an object someone has allocated. It's a header of a TLV
in a byte stream of nested TLVs which comes from user space.
If the attr did not go thru nla_ok() or some other careful validation
we're toast regardless.

> > If we don't trust that struct nlattr which gets passed here is at least
> > NLA_HDRLEN (4B) then why do we think it's safe to read nla_len (the
> > first 2B of it)?  
> 
> Type confusion (usually due to Use-after-Free flaws) means that a memory
> region is valid (i.e. good pointer), but that the contents might have
> gotten changed through other means. (To see examples of this with
> struct msg_msg, see: https://syst3mfailure.io/wall-of-perdition/)

A bit of a long read.

> (On a related note, why does nla_len start at 4 instead of 0? i.e. why
> does it include the size of nlattr? That seems redundant based on the
> same logic you're using here.)

Beats me.

