Return-Path: <linux-wireless+bounces-15245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C414E9C6DE8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD5B2B9DB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4C1FF609;
	Wed, 13 Nov 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7kgDf0O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D151F81A0
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496489; cv=none; b=R1mNLmBS9HspkjW8xnQZ1TYmaXPchEggRAlLMPXIBDSGx01xCa1F3MIPSBt7bMtY2CkE1aog4EmeEpMdyWsaXerK9C0IS5/y6aCHgGiaENmXZwMfrUa7Z5KGy9+8Dbfw209XqXahI+0S59ITDcllxBkv99WcWMkXqHua1LnwK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496489; c=relaxed/simple;
	bh=SfRuX/dV9mIBPRr+FPdrIt+g6zw+cc9zzZ61VvNw6Dw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uoYyHNOTNMZH8YqNpWInaDRCgnJ77zwpKNby+wt6jZo1iDYcrR4DyKYmdaJZqaTm9VtDhHZ/dciV/X75D8XIJZJ2BPohQzQU5ihPO3esF88MNuk2NNHHXvrnhqdj6jlFurX49szVgTzPfoKN5YGfyA6DOnH3VTy15e6N/OmIvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7kgDf0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28587C4CECD;
	Wed, 13 Nov 2024 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731496488;
	bh=SfRuX/dV9mIBPRr+FPdrIt+g6zw+cc9zzZ61VvNw6Dw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=m7kgDf0OGkfTdnZopKqitXbSpnQwMTFiBH4V2k59gWg9Wtik/J5bi6dQTNa2Q7leW
	 66+qyjCFnpw3HZUzN7AsY0MkX9nKGdMLNdupNwOert3yYX5fqotDQSHY2LGX6oE6SL
	 JJvbhsgUy+G9kTywKsHCHfqjxHqsmfRdKQ8xfE5OF24P0vhel06RHnmQTX0Old717n
	 Qkr5R//TH656yJHY1fyE7Y8HQlA1Ssx/CHRNyklIShhyr+JF7C/wepkKrKqNQQehpa
	 fodJ/tE0f8C7qUFhm/jDit5aONZ6JRuhfEdVRLYsOEnoO9fUKHG2rSMT+pkKpM7mf/
	 WIueLMTcW6tPQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/6] wifi: ath11k: move some firmware stats related
 functions outside of debugfs
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
	<20241113015631.3105-4-quic_bqiang@quicinc.com>
Date: Wed, 13 Nov 2024 13:14:46 +0200
In-Reply-To: <20241113015631.3105-4-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 13 Nov 2024 09:56:28 +0800")
Message-ID: <8734jv2xnd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Commit b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
> and commit c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")
> call debugfs functions in mac ops. Those functions are no-ops if CONFIG_ATH11K_DEBUGFS is
> not enabled, thus cause wrong status reported.

What do you mean exactly with wrong status reported?

mac.c is quite large already, making it even bigger is something I would
like to avoid.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

