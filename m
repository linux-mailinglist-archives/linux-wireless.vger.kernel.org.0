Return-Path: <linux-wireless+bounces-14782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F729B7C9A
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FA2832F3
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27CA19FA93;
	Thu, 31 Oct 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL94M9TB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B719EEC0
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384335; cv=none; b=WZ3QNbnQhS42n04crST3YXF7YW5CXiG58XwW5Cj0zUZqIpZdlISbrNsM7n5SFBCj36IwtbI/J/YPFhda7F4o+neuxQlwnXwS6R62vnEOqY3MPe4d7565vRQNxSWAB5a2cmP54o4PHqIcJhMzU/q7YJQQY+rTXtzLR13J/FnPsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384335; c=relaxed/simple;
	bh=uDiapnInvBCmn8/tufC6OPO0vr2eWKKkPy+v6Qk0DMA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fqQCYZ2aXMQSBJqy46isnWFbg2VD0elt8sdN7kI0giCL7mpMp0oMZ7ySBoien7JmpXgRG37x59pNf2oFyHl5IAvTdN8VRGJORnU33v/+g6ZDve3ZFb0NZYljbyhv/KDDVojmTGGYF8CosDHUSxLQGB6uC29cJdMCgpNBYJ6Iq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL94M9TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C7C4AF51;
	Thu, 31 Oct 2024 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384335;
	bh=uDiapnInvBCmn8/tufC6OPO0vr2eWKKkPy+v6Qk0DMA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GL94M9TBCKphLqMbhdGDAsWfYs4B8jVFR0nIoztoID2jjOBvTebp2EgQU391bqyX/
	 LmHwwJVLrSO1yAoKSkgyTMIdThiTdXe4u5N2Nj0HewCF08SinMyZcVf8k8yMkZN9Av
	 0T+zVNTo+x5nx/HcqHrNrhHbNAN1ZPhXdqIL6JHntGVw8XjU75qYrqLaeBaid+p7wn
	 s+X5maGAXwyJwCe/uVLd0ueyIrinw+P+/uaS853ld21789agxljj0F/5CojdUnwxIP
	 PTToiRmgbAsWIACJk372PF8a9GaiRedowfkJKG0oEzXM45daypYosO2IgTsiHGv+Af
	 0M+Uewydg9mMQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wfx: Fix error handling in wfx_core_init()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241022090453.84679-1-yuancan@huawei.com>
References: <20241022090453.84679-1-yuancan@huawei.com>
To: Yuan Can <yuancan@huawei.com>
Cc: <jerome.pouiller@silabs.com>, <gregkh@linuxfoundation.org>,
 <linux-wireless@vger.kernel.org>, <yuancan@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173038433204.539202.14907836259811918738.kvalo@kernel.org>
Date: Thu, 31 Oct 2024 14:18:53 +0000 (UTC)

Yuan Can <yuancan@huawei.com> wrote:

> The wfx_core_init() returns without checking the retval from
> sdio_register_driver().
> If the sdio_register_driver() failed, the module failed to install,
> leaving the wfx_spi_driver not unregistered.
> 
> Fixes: a7a91ca5a23d ("staging: wfx: add infrastructure for new driver")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

Patch applied to wireless-next.git, thanks.

3b88a9876779 wifi: wfx: Fix error handling in wfx_core_init()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241022090453.84679-1-yuancan@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


