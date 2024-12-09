Return-Path: <linux-wireless+bounces-16070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9629E9AAE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C06B2832F3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4F81C5CA7;
	Mon,  9 Dec 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd+XeR4u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A21C5CA5
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758663; cv=none; b=XBnIMnbJvrmhPQan3PP69mXSVV8dCPh8NKYF91Wb6ZHzHVaPLbLvJ0VOlvVwZVnJgsPcbzQ47vyNfjB7UZqaYT8P9qlnTFc/nC4lFdkwNmNrmsfIjuw7bTBpPnbdpElMao/ft6EzOCHspqqHG7EzBmpDMjOubGs3PILxZcP1+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758663; c=relaxed/simple;
	bh=cXpfKad7ahdOsjhCoNvLsP9akGn3j6cxcJ0cD82I8co=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m10FYW1U5cQFEUzUyIK1Q81CYV6Z7gDWbID4AIbmAz9aovDl4YqYjDJBAjspEUH3r+nGw2ZN8bar1BUshyxWeZnhwMjcOAcSUAirqKu96suzUBKyK4AXYFUVpaukz/0mSDrwNzEToqgitx7xZGfBRBeD2z+ZUuZc/AxFWYGQqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd+XeR4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D33C4CED1;
	Mon,  9 Dec 2024 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758662;
	bh=cXpfKad7ahdOsjhCoNvLsP9akGn3j6cxcJ0cD82I8co=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nd+XeR4u4fWoq3FzdBO50fYSn4o3+gZdL4MRRWbuRc0rB0IL4jMU9yIGv9LDBCAbG
	 Rzp6hZ+NzdSCT6lcr0806Tv0uQU0ZUhk6Ui7DJ3BaG97+54pt7cvME+8TRIgLSbpzK
	 8ISTTRAhn/Z49zdozu7N/JuanYFw0QfO6F4pKLy0nLhv6Vun8g9EHbZ/BIgp6Q3qxB
	 mdVwz7Ov1BZebPT1wlGinm+/VFd0EcGhU+JbCIW2TvSGIO1QZCA1ZBWELd9s7RnoGs
	 nN8Ga3b4x/Owc4VANDL4so8Acv/No/i2qGzvUEv2jo7S2lukbE6gYGkC2TSi9nrbx6
	 YgkoAPygtazkQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix leaking michael_mic for non-primary
 links
References: <20241206054552.177424-1-quic_bqiang@quicinc.com>
Date: Mon, 09 Dec 2024 17:37:40 +0200
In-Reply-To: <20241206054552.177424-1-quic_bqiang@quicinc.com> (Baochen
	Qiang's message of "Fri, 6 Dec 2024 13:45:52 +0800")
Message-ID: <87ikrssw8r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> In ath12k_dp_rx_peer_frag_setup(), commit ea4192553850 ("wifi: ath12k: add primary
> link for data path operations") checks whether a link is the primary link, and
> returns directly if it isn't. In ML scenario where we have non-primary links created,
> this results in leaking the michael_mic info since it is allocated by default but
> could never be freed for a non-primary link.
>
> Note that we can not move the might-sleep allocation after primary link check since
> there we are in atomic context (due to spin lock). So keep the default allocation,
> and then free it before return to fix this issue.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Fixes: ea4192553850 ("wifi: ath12k: add primary link for data path operations")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

