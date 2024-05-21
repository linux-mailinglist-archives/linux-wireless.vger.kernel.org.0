Return-Path: <linux-wireless+bounces-7901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2EC8CB079
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8D8285637
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9892130A41;
	Tue, 21 May 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfrQs7E9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8571304BA;
	Tue, 21 May 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301750; cv=none; b=lI/SWp6zHYlX8KlPWpPxGCquwl5HU7lHuKxqwTfJvFS5IxL66pHAVPBlXUQly5RBR7iLhKKZDqnIPRw/6Anw2NPs24XglSI9cNygzAoWHynBaha0Udl62ri26mDtijDgp1zrjAEI20dhsXtShmp2P8ELpGLDpt5Q9xR5dzLAOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301750; c=relaxed/simple;
	bh=Fu9p9Il+lHWvAaKZCxwSLybjKw+hVxEYoGb2TSR6kTo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VXQ4ZGAJFgf3/ndSDITWNO0qgmKykgUdcQoGWx8nMdxXeAlZ4GZNfvNFKSXL0nZg5uCphFfTY1Uxv98N/Tremp07qoiscWeTWGrYlsrIjwj1k/mavQEfd1/s6fOLiZix4DAAu6pIU7GpiF6yLN2Oq+yae0ZdmU1uzEQ+BgbTWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfrQs7E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62829C2BD11;
	Tue, 21 May 2024 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301749;
	bh=Fu9p9Il+lHWvAaKZCxwSLybjKw+hVxEYoGb2TSR6kTo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dfrQs7E9sX2oHjAle4ssovB93neL23QrrgNDQlGRBQ0NYcLBrcO6+eBBe0Wsrq2Vv
	 DlHFnCuIbz90VOm+BvLPdFN+UfJFEUM8uf6McztWZm3mmhgKtJidsuxWsvv+p8FtIR
	 eyVMhwgEHvPD4B3MFeu1x5hVMUU29FjqfAUzUH6LHT6o/Hm+2i0A3sNXvMdNNTjxt/
	 d1ma3yuUh7vRuEKXolpggP+9VgQGkq3KhCu+hcPQNABHuhQYVC9z0Nod6ww9ZXQIBB
	 OwzTllk0GQcnhtP8FdjRR36nayP3tLhGHBe2RFxw0wLXmdrrCGnc/MIDqTiSM2vhY7
	 9E0rMpFAy3Siw==
From: Kalle Valo <kvalo@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: johannes@sipsolutions.net,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] wifi: cfg80211: pmsr: use correct nla_get_uX
 functions
References: <20240521075059.47999-1-linma@zju.edu.cn>
Date: Tue, 21 May 2024 17:29:04 +0300
In-Reply-To: <20240521075059.47999-1-linma@zju.edu.cn> (Lin Ma's message of
	"Tue, 21 May 2024 15:50:59 +0800")
Message-ID: <87jzjnnsr3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lin Ma <linma@zju.edu.cn> writes:

> The commit 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM
> initiator API") defines four attributes NL80211_PMSR_FTM_REQ_ATTR_
> {NUM_BURSTS_EXP}/{BURST_PERIOD}/{BURST_DURATION}/{FTMS_PER_BURST} in
> following ways.
>
> static const struct nla_policy
> nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
>     ...
>     [NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP] =
>         NLA_POLICY_MAX(NLA_U8, 15),
>     [NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD] = { .type = NLA_U16 },
>     [NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION] =
>         NLA_POLICY_MAX(NLA_U8, 15),
>     [NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST] =
>         NLA_POLICY_MAX(NLA_U8, 31),
>     ...
> };
>
> That is, those attributes are expected to be NLA_U8 and NLA_U16 types.
> However, the consumers of these attributes in `pmsr_parse_ftm` blindly
> all use `nla_get_u32`, which is incorrect and causes functionality issues
> on little-endian platforms. Hence, fix them with the correct `nla_get_u8`
> and `nla_get_u16` functions.
>
> Fixes: 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM initiator API")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1->V2: add wifi prefix in title,
>         mention the policy that defines those attributes as suggested by johannes
>
>  net/wireless/pmsr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

wireless patches go to wireless or wireless-next trees, not net tree.
But no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

