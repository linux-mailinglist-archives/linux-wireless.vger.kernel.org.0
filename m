Return-Path: <linux-wireless+bounces-16270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2949ED81C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F260C162FBC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B21D90D4;
	Wed, 11 Dec 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3/Q7mcR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3E259498;
	Wed, 11 Dec 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951237; cv=none; b=tEQJok4USYGiGVCUv9/CbLFoFwfq7KttIUPwgtQ/hhVEE84RMs+Q3YmIGKbYOTF12EIfGPc84bkflRkRzhdjMrWecgl1ibfGNYcPyk38Wz0z94ppHUfLWyjfyqhUIoamOUe8fVFAgl4r4G34SJbsEAnc9bLKF2Vrp3FtsH/A7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951237; c=relaxed/simple;
	bh=X8KILXfNGK3WLsHVNBkpLIBMzdo9JMseXb3KS63Gyrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLbC5Ot5nVmC3BGhVui3XMwFb/Ee0inIVSYObLKP4atpXLYcn4bMVPn0zT2np3kPd3ai/GBi6HUxj1/jWWx1zn0jdV+G3vra8RqXi5zbJekYuclAH4mEYGhQ2iQSXIUU9dpkqmZhw+umabnZYMAvspZlJfdeiQMCxpYBsomWHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3/Q7mcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76765C4CEDD;
	Wed, 11 Dec 2024 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733951237;
	bh=X8KILXfNGK3WLsHVNBkpLIBMzdo9JMseXb3KS63Gyrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3/Q7mcRLxJEqjOiPMYRiY2l3ALNpPn2lQFTtV/rvUNhP5e2r2zGvD+L5qcJWOIOG
	 nOk9pEqaUoNGoJ6I12e/+MLOPAgXe8ohmfktsJOn/al+tjwuTgcoPFsYJaRAWNnQ8T
	 xnlWgT4w/1+eC0qcyoN9Sr1Zq+CAdNh6MX6bTG0VEyAIbEjsAHJpjyfsQu06szBBiO
	 YGGH8lMqKEpa+cU3IS6dG9z19U1/NXqg4QIenCuedO4SzhswgPrnc+EXg4xUDTFaud
	 BwVw5ADgQHDJ+iuB2lUXM7fhIckx0T65rPLxiRTExjLhgcvq9EIc0Qrux8Quft1eGt
	 E0k2+NUy9KLRQ==
Date: Wed, 11 Dec 2024 21:07:13 +0000
From: Simon Horman <horms@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 7/7] netlink: specs: wireless: add a spec for
 nl80211
Message-ID: <20241211210713.GE2806@kernel.org>
References: <20241210161448.76799-1-donald.hunter@gmail.com>
 <20241210161448.76799-8-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210161448.76799-8-donald.hunter@gmail.com>

On Tue, Dec 10, 2024 at 04:14:48PM +0000, Donald Hunter wrote:
> Add a rudimentary YNL spec for nl80211 that covers get-wiphy,
> get-interface and get-protocol-features.
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/nl80211.yaml \
>     --do get-protocol-features
> {'protocol-features': {'split-wiphy-dump'}}
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/nl80211.yaml \
>     --dump get-wiphy --json '{ "split-wiphy-dump": true }'
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/nl80211.yaml \
>     --dump get-interface
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Hi Donald,

Perhaps I'm doing something silly here, or my environment is somehow
broken. But with this patch applied I see:

make -C tools/net/ynl/ distclean && make -C tools/net/ynl/

...

-e      GEN nl80211-user.c
Traceback (most recent call last):
  File "/home/horms/projects/linux/linux/tools/net/ynl/generated/../ynl-gen-c.py", line 3018, in <module>
    main()
  File "/home/horms/projects/linux/linux/tools/net/ynl/generated/../ynl-gen-c.py", line 2727, in main
    parsed = Family(args.spec, exclude_ops)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/horms/projects/linux/linux/tools/net/ynl/generated/../ynl-gen-c.py", line 928, in __init__
    super().__init__(file_name, exclude_ops=exclude_ops)
  File "/home/horms/projects/linux/linux/tools/net/ynl/lib/nlspec.py", line 480, in __init__
    elem.resolve()
  File "/home/horms/projects/linux/linux/tools/net/ynl/generated/../ynl-gen-c.py", line 946, in resolve
    self.resolve_up(super())
  File "/home/horms/projects/linux/linux/tools/net/ynl/lib/nlspec.py", line 53, in resolve_up
    up.resolve()
  File "/home/horms/projects/linux/linux/tools/net/ynl/lib/nlspec.py", line 588, in resolve
    attr_set = self.new_attr_set(elem)
               ^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/horms/projects/linux/linux/tools/net/ynl/generated/../ynl-gen-c.py", line 992, in new_attr_set
    return AttrSet(self, elem)
           ^^^^^^^^^^^^^^^^^^^
  File "/home/horms/projects/linux/linux/tools/net/ynl/generated/../ynl-gen-c.py", line 824, in __init__
    super().__init__(family, yaml)
  File "/home/horms/projects/linux/linux/tools/net/ynl/lib/nlspec.py", line 215, in __init__
    attr = self.new_attr(elem, val)
           ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/horms/projects/linux/linux/tools/net/ynl/generated/../ynl-gen-c.py", line 873, in new_attr
    raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
Exception: new_attr: unsupported sub-type u32
make[1]: *** [Makefile:37: nl80211-user.c] Error 1


