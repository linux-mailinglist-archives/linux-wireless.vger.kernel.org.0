Return-Path: <linux-wireless+bounces-4397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A510287270C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68461C26E4D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432323758;
	Tue,  5 Mar 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq4n6J4e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4A22F08
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664916; cv=none; b=GaSuU3560KJroK7nmYHoSf3TClQu1Wzn3QC31NVwNeXYyTWbdU0VITTZ2IVSal+LChlvrMVe5YU3XmXuphp8Xa9+sfdti7e9UlxdxG1XwwaGVCgL/zB3XV7bJ+8/hnfo4p70GcA/7A+Pqelr9T6OdodRyt5NwyXuFNHGv0UWqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664916; c=relaxed/simple;
	bh=OImQOKwMxwcAF5wo/xJ4GuMVkAfdgp1waVKV9ygeUig=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=iw8Ah2eYqsOdjqrnm/csFLcGqID+AdKD050L+LjAIdA3XFR5TWwbDtArLN+6+wWOdDLvyEIviDMPZN3fYPCLtEFCMAwmphZdVPq5uLNOQUF4juIw8BisHcUBOuaI7zTFNIbHjchy+/tK/z9c3CZvsDil/hBPIwvZ9m9XjijBYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq4n6J4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28698C433F1;
	Tue,  5 Mar 2024 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664915;
	bh=OImQOKwMxwcAF5wo/xJ4GuMVkAfdgp1waVKV9ygeUig=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=uq4n6J4eLsedJyVNw6oA1jZ3mdjQcdUDgH06u9o6xlYS6tluZzx5Vl2I989mNW11D
	 u4AXQm5I/7kZxhkJ14I3lqtAwgb3mWzPouQfZsWTiUcymOKCVNPoMrS3JfQHB7RuGE
	 3UjKd0u0jPJ5J0bwBJ0VZ2lEdeiRi/JsM6kQPWPP1s4abVOO8d/rcEDWrLSzD6rIm9
	 4Pe0Jxq6W56rsQ12Xkx8eMFc4iPYJNPtSdrxuCwEZlFhVHgmj72lVpHS5s6Z3t6p3F
	 4+Dzfxji7HdbAZNePUhIldY/m8xNy0iSfXSAlM/9pKLYqzL6AqHi2wcoPfVoCbDejh
	 OI4CzLL5IHBvg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: mac: add coexistence helpers
 {cfg/get}_plt
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240229074514.219276-2-pkshih@realtek.com>
References: <20240229074514.219276-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966491343.424347.14790085973195976950.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:55:14 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> When hardware grant BT initially but transition to grant WiFi, the PLT
> (polluted) bit is set to assist coexistence mechanism to debug if
> grant signal is expected.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

0cb01e0edf78 wifi: rtw89: mac: add coexistence helpers {cfg/get}_plt
d569f8545c7d wifi: rtw89: 8922a: add coexistence helpers of SW grant
652c9642eda6 wifi: rtw89: coex: add init_info H2C command format version 7
9d27596fdac5 wifi: rtw89: coex: add BTC ctrl_info version 7 and related logic
6ee10fcd284d wifi: rtw89: coex: Reorder H2C command index to align with firmware
eae888cfb734 wifi: rtw89: coex: add return value to ensure H2C command is success or not
bb90a32c3c7d wifi: rtw89: coex: When Bluetooth not available don't set power/gain
2422c2158fb5 wifi: rtw89: coex: Add coexistence policy to decrease WiFi packet CRC-ERR

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240229074514.219276-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


