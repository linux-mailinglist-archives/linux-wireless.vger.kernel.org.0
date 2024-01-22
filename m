Return-Path: <linux-wireless+bounces-2339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75783712D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 19:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA48288104
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FE3EA97;
	Mon, 22 Jan 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvjPwQdS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EE3D553
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947633; cv=none; b=jDgjx4x7lL9ZTRScgIGEbYUjA3p4DvxuXAqBCgas3eISb0VnEQ7IS9APC3OpJZZAglIQOE6aSqF9HYQQKg8YU0vRv9CL4/7aUM8dbdNFqHZrYS8f9k9GmZY1WgImO4C9ZpCrWmDOERPk8ZNjDKDrFEmOLNFa5FQxNyAa5d6QfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947633; c=relaxed/simple;
	bh=5k2MDoKDwONfs42iRlncAiKTmYSEyHYrJZ4dS2XGnPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vo+aVKtaS/L2gDXlCDnUf/t8DES5DKhJJT9zKRuYeqGKUV/Lq8xmHCw6526mXEseT/o2v0YkZZBy1UJbrQcotbntosrDtpDJnmP5Ur2NjmK65zdc/z6IA1Jn4VCuCxeM9S0ZB98CFs33GdTTcD+rlci+GU8k2uURqRsHawsEOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvjPwQdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA52FC43390;
	Mon, 22 Jan 2024 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947633;
	bh=5k2MDoKDwONfs42iRlncAiKTmYSEyHYrJZ4dS2XGnPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IvjPwQdSK6GnFxrWgSOz3/RUu9adS4p/B82V483dx8ujCKz4l4Zzxpczz8flFC8a1
	 t02UgUSVYLirOhp54H7QowAs+1KkkCxEuSPhXZdt+LxJ9dOaxjiHDDCrgDj22TgWYL
	 RvAGvYNJP4GmTMsHJJbVHWlZ+gx/YknHicwVXXiYFdII63kEGm9U+kAaTV9362sEY+
	 IQOHC/hBMyF1lvTqU64nERcySKpr3Mt0XR/DbA+eyhuoKhaCb/DMPyptNACWZDJUvt
	 mOGzmzHEm7Dz9a64HXKxdMb8Dm0ulbfVYpf/sr5vqh5AJUBCPeD2YwUsn1ZRzmOKM8
	 P0fzyf4mhbBWw==
Date: Mon, 22 Jan 2024 12:20:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] [v3] wifi: brcmfmac: handle possible PCIE irq
 handling errors
Message-ID: <20240122182031.GA276974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122115749.67682-2-dmantipov@yandex.ru>

On Mon, Jan 22, 2024 at 02:57:25PM +0300, Dmitry Antipov wrote:
> Switch to newer 'pci_{alloc,feee}_irq_vectors()' API and handle
> possible errors in 'brcmf_pcie_request_irq()'. Compile tested only.

If you have occasion to update this, possibly s/PCIE/PCI/ in the
subject, since this is generic to PCI and PCIe.

Bjorn

