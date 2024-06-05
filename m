Return-Path: <linux-wireless+bounces-8562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C7F8FCF47
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22220B30E7C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667B19599F;
	Wed,  5 Jun 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7y54Cxx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E01E89C;
	Wed,  5 Jun 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717592072; cv=none; b=E2TeyxG2rDeMjf3w8lFXElkXbemlz8vZngIw8aII1Y2yewUp/VVurte6zzv9i6kD7szrMk3SONKHFJi/DA/GBnpk5Gi38qM8CHbYmDHxlPe6O7uMygFyMW1O7wpYZ19MhssU2lFjZlbMl1kejl9Esc31Cmk89tuT42D8JuGdnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717592072; c=relaxed/simple;
	bh=XB07QR+XSkJHYCaW2hwUoy4YszkpOcRuq7NZF7LreUM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kXBoowUXCBnLCmhgO6IRrgrvQ6U9wWTdmw1k5KfOFa4G2J43te9ZTOtCQPxG8bNezwac5aUugtIB0nbpFv1jEcWz+f3MZ5GeRsZM7s41bWcioRVmN4Z3OjU9PXNQVGqTSa/mo235sbG5eP87h7I7+m8GoiXTD9DlBPkHmztIdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7y54Cxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E107CC32782;
	Wed,  5 Jun 2024 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717592071;
	bh=XB07QR+XSkJHYCaW2hwUoy4YszkpOcRuq7NZF7LreUM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c7y54Cxx1Xv0TlGIq5HUgQ2nYtyeWNVe/PtsNtglsSeAXuaKc3I3Nbo/BsduhjI/1
	 H0zvh1L+J2ykqqKN3pGGvIUYuAoBav2L6iNFrrLojJinF6swHPqHTCHL0yoCklSxwz
	 VzwcKpya5PyhI3omNOazYBtnTxEqRw5F1CzzqAYALkLyvxU8InjCz9YgV3dhcYK8dN
	 lu5Ce9UyH35QkftqwPw8wbOBtYkartYTtvb5/uOufL6m1IZM7lC8fZ+2b7TTL5nGOZ
	 ycsmJdpoyx+8t64yngGCt5hQ9mo+OGDvKTTDaCIoXFyY/IwMnVnlnJTacMOIr6R7pe
	 cK8sUSngASrgQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] wifi: mac80211: use 'time_left' variable with
 wait_for_completion_timeout()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240603091541.8367-4-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-4-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171759206880.1969597.15358870283165767535.kvalo@kernel.org>
Date: Wed,  5 Jun 2024 12:54:30 +0000 (UTC)

Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

The title should be:

wifi: mwl8k: use 'time_left' variable with wait_for_completion_timeout()

I can fix that, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240603091541.8367-4-wsa+renesas@sang-engineering.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


