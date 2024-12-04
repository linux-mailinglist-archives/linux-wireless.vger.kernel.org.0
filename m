Return-Path: <linux-wireless+bounces-15873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA39E3113
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 03:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39138167099
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE217C79;
	Wed,  4 Dec 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgbJ8oLj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C205227;
	Wed,  4 Dec 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277802; cv=none; b=CwUnMpqtdcrmF+8mIviImY3jyVGdHoyiZLv33Ue5oVCoRVv1NaD0D3dtMRn+zrQWpCUAZUFQP0xaFHpdm76Lfi2AKtnc40STPbTJlqdAaqDmx7gP7+LpajOrEMsNXPMFO885UuVQtIG8RSEA1HYbgbluSIg18h8OHeot66Yf0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277802; c=relaxed/simple;
	bh=pwckfT/6HH3FsEedsxJSTBwCaFXgEgtEaLqnKhBwuRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bip1j84wKi5hufoHV44jx+mQRcCmBpNxoFGiHawh1nICyXY9NsdCdxTXhmW0tyfk1DydRSt2Fw2RN9q5tP2kpS8GO6Ldans0ZoZ0J1FyfSi40BaFGqiASnmr839+xvI0vS0bXllTvcclQZez7Lz51zcbPXu8lHM6/sDPFyc9oK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgbJ8oLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DDFC4CEDC;
	Wed,  4 Dec 2024 02:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733277802;
	bh=pwckfT/6HH3FsEedsxJSTBwCaFXgEgtEaLqnKhBwuRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AgbJ8oLj2FA5mS8e6eDLnkgirnOWzIWPHk1OtL9FbcXgzVOVQj86aj0cZKR8hEq29
	 Vs5Ngj4kjAyBHrEnKCoJsmhVRJwZwYRe9XDO8CvwJbU7a2Ed1iOwgd2yLcPF0kKO30
	 nRqZT2yMGU/CVOeT26c4TJDKpaa5ITGpVYCIvlfvHMH+0gmTQgNJdyosmUYdLdkIso
	 g69x9t1triRIxRW3KmwE78H0NeNXEY1QwVu98gHBSkJfyfrXiJ1eEkLpO9cn+Jh7Uo
	 kSi9KToVXmRViA5Za82QGYLyQN7/51KaiTnSjdEFSEgDx4Yri2mLH/39akuFz6ydQa
	 5xSpAUhMYYJKQ==
Date: Tue, 3 Dec 2024 18:03:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 3/7] tools/net/ynl: support decoding C
 arrays as enums
Message-ID: <20241203180320.0d4e5670@kernel.org>
In-Reply-To: <20241203130655.45293-4-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	<20241203130655.45293-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:06:51 +0000 Donald Hunter wrote:
> Add support for translating arrays of scalars into enum names.

But not formatting hints.. ? ;) 

> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 0d39a83574d5..f07a8404f71a 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -627,6 +627,8 @@ class YnlFamily(SpecFamily):
>              decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
>          elif attr_spec.sub_type:
>              decoded = attr.as_c_array(attr_spec.sub_type)
> +            if 'enum' in attr_spec:
> +                decoded = [ self._decode_enum(x, attr_spec) for x in decoded]

nit: missing space after 'decoded' or extra space before self, with
that fixed:

Acked-by: Jakub Kicinski <kuba@kernel.org>

