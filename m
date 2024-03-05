Return-Path: <linux-wireless+bounces-4394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D63872704
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557E01C255F9
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5CE288DB;
	Tue,  5 Mar 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFg9wDER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEA1AAC4
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664823; cv=none; b=po41dEinrsC+jA81SpR5y7ZPvCWPtjklJpj0qUMqASoa0V4UPLMKarM45eQuYNZlGj68RKbp6Y86AynKIA/2kmFmRfwOCcMjIgmoeQ6o4bYCbZ/tbH2wmEjzJVGDCBmQMAuE5deEfh96DnWgWr8q+eckUrIDe92lYPDIoRjSFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664823; c=relaxed/simple;
	bh=PyEXgtJV8kidZOAb/BRxCAVgjiRHcFs4T6Vk356zXNc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kj+AfDvNe91L3xG9955JlhM7VPzrAh65hoFJVIA8K5alcK2iZ1VDaxGS2+Mo5X7qprP/dqyW72fHztor/E5L0IUH3nU8E7//dbd5q+4sfXhlARRuFSm1QnVdErjJXrKw0ch7y0jv73LEz59UL0bilqISP8j7N+6NBWhTi7VFHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFg9wDER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C935C43390;
	Tue,  5 Mar 2024 18:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664823;
	bh=PyEXgtJV8kidZOAb/BRxCAVgjiRHcFs4T6Vk356zXNc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MFg9wDERYDANhs9qvvcjbxnT5rzDsvbUHbZv58Las+y9iwhT3zjXttfwW0o8M3fx9
	 2DpU6jhuUQ4JQbREMGYxECyhEVXGr/DXCgJzrqRS93sX/gkdmfrgHE5euWb0JVEw/2
	 J7eE9cRYphjNe9emcE/elDe+7PgNR7OPOLHMDBuY+avWMw9KwYjBhbGmIzhpQTSFML
	 fMMmx8t5WQDWhO6UBSgoOY+kr8B9mWbVyRH+dCqoRmJlRBUqU4omFQEGXJmzMd017n
	 iWVtQv0MqtRIHdJh0LpJUX4qhRz76qBwWkyAMbAjS4P55KS3bQDItSzp8LBhSC2Rkk
	 mhdHvhtySU37w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: Remove rtl_intf_ops.read_efuse_byte
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4e2c968d-f25c-4a40-be97-4fdcbdde69cf@gmail.com>
References: <4e2c968d-f25c-4a40-be97-4fdcbdde69cf@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966482018.424347.12786361370903562829.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:53:42 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> PCI drivers and USB drivers can both use the same function,
> read_efuse_byte(), and they can call it directly.
> 
> rtl8192de was the only user.
> 
> Tested only with the upcoming rtl8192du driver.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

7979061313c8 wifi: rtlwifi: Remove rtl_intf_ops.read_efuse_byte

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4e2c968d-f25c-4a40-be97-4fdcbdde69cf@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


