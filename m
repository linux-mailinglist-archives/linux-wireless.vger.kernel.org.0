Return-Path: <linux-wireless+bounces-7642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5388C5746
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5379F284C03
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E545145339;
	Tue, 14 May 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D84pr56z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54A145338
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693507; cv=none; b=XgXcEiE5UuGc20XUDQDTpnshL02EVOOeb7FDisXl33/z7VGVdXACm0Yp5hgwgpSh3o2MxxfRiotquq7mN27XMQM8Tn7esj9PT6RW50s0JM2doKa+zxEnjBLwvjnmQg0rhDUJXIgWMaW02tuVuDCEKlY1/2oy9tCveURGwEovqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693507; c=relaxed/simple;
	bh=2IvNo2nSbcBH0a5KhQ/WYRfvuebIZ+ll7f5SIOSSAH0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UHK7mh52qMWdTu6Yf0z+3xKVBiCV1Axa8K4XZUNfJR50gEkKUu3HRqsglMIxJKz4NSoYU8+S+5SR2Eom580jQ4pU2uKwXtK3AgBNG7nctDq+GG2Mt77hRqPOSBXSxwIo0qAE5lvN4ll0Ztjas36Jjn2bFP1/vRTyTXupklZf9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D84pr56z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977ABC2BD10;
	Tue, 14 May 2024 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715693506;
	bh=2IvNo2nSbcBH0a5KhQ/WYRfvuebIZ+ll7f5SIOSSAH0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=D84pr56zYfkV+SWzhVjmopCNd0Z9GmcL39t+Dflx3i8jEDIuNwTxKqyoRmq0xSbcb
	 wrJxQUUIgMj1u+bw/slz3cZ7GCLjdG7UnUyDK/Qmnay+fK4Bc4nJAzAXLj9ONRzraJ
	 At13eGyvHmkEvJDaSHNqOim7yMPy8Wy7yLFuVcDu9GbozUaXgxDcTSTNipWi6j8muU
	 IK3UVLRj+07hS7s1HsC63DVHVSDGuozZRiKWTPoeZPIZ4v2b6LKFdK2naq9rPM7SSD
	 IUGq/rNd1FH5FX0czcQc9YGNTEYq13ysivsWhWr+6G6ocGFfQAYeOKtOwTOC7/E0eH
	 91fs9OEZ7zMhg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmsmac: LCN PHY code is used for BCM4313 2G-only device
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240509231037.2014109-1-samasth.norway.ananda@oracle.com>
References: <20240509231037.2014109-1-samasth.norway.ananda@oracle.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
 samasth.norway.ananda@oracle.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171569350371.2079576.10919239108711550851.kvalo@kernel.org>
Date: Tue, 14 May 2024 13:31:45 +0000 (UTC)

Samasth Norway Ananda <samasth.norway.ananda@oracle.com> wrote:

> The band_idx variable in the function wlc_lcnphy_tx_iqlo_cal() will
> never be set to 1 as BCM4313 is the only device for which the LCN PHY
> code is used. This is a 2G-only device.
> 
> Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

c636fa85feb4 wifi: brcmsmac: LCN PHY code is used for BCM4313 2G-only device

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240509231037.2014109-1-samasth.norway.ananda@oracle.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


