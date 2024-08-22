Return-Path: <linux-wireless+bounces-11788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83D495B0B6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 10:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37A01C22B2B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF120175D51;
	Thu, 22 Aug 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbXTnILI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACE171E69;
	Thu, 22 Aug 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316080; cv=none; b=LTI9Qdop1f6kH4VGRQ7u0BgiXZb5N1hTaGGVgXftH78oZUS6zGM+GxY9sg6WrH43iidNQ2zlfA6RGVL//pnEBy4oOC0aaRt1Yjl/h0h/C/wg1Ck0R+ymxgtrkfIdPTGKpwpckzk628wcjGKHBrROwWkH49Ar6ArDmGCQN9ohEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316080; c=relaxed/simple;
	bh=i00HcFXRrH3Z3fH5KHwO9JspjwGn2hyKWDlaT1RHe1o=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=dBYnouwGfJ+JlgKHJ4E2Vue+7nYZ3kZzinGfLWVw40Kh3R6lBij+xXB+Xf/4M7h8lcvuPRBGm9hYD1Kt2JJLkk5obacLu6FSF4bZgPtrj2qcIq8ARpgcy82gQWNkPG+5gv4cwTtP/b+8bHTbyRreMHeZqNvz6q4AxHc9Lj9mkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbXTnILI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3704C4AF0B;
	Thu, 22 Aug 2024 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724316080;
	bh=i00HcFXRrH3Z3fH5KHwO9JspjwGn2hyKWDlaT1RHe1o=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mbXTnILIyCdhiQBj80T4M94CK5cGt8hU/CQbmwU8wCN4ULItmmc6mXtRXDRPCkikh
	 EUSdvw487/ACOu8EA/Mnh2Bx57d08n3SB4YhcDr2Lpak16kWqdl3Jz1U9dWwW5jzys
	 4wcO2wMP4oqVFiEbV999TkG8Er2oMbralP35nZgvtF+0v5V5ZZ+de9JDdKx9bQVH54
	 oX1t90B7yGzbXh39cLrpYYlK8kKjz1QdRMlHJnio2rQo6BviD2Eu+jiZtIqbJLD4/g
	 Q5zo3GzdGL6CyFDl7Coh8MFb8U4m35gxp4KiqTHScCA9KwpWPp/BXzRHv4gkJq43pf
	 IIqYaIH9ae0Mw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <Zr2gxERA3RL3EwRe@elsanto>
References: <Zr2gxERA3RL3EwRe@elsanto>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172431607671.2217900.17688660521871057596.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 08:41:18 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create new tagged structures with the suffix `_hdr`.
> These structures group together all the members of the original
> flexible structures except the flexible arrays.
> 
> As a result, the arrays are effectively separated from the rest of the
> members without modifying the memory layout of the flexible structures.
> We then change the type of the middle struct members currently causing
> trouble from the original flex struct to the newly created structs with
> suffix `_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structures, they are always included within the newly created
> tagged structs. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement the `_hdr` structures as
> completely separate structures, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which we can access the flexible-array
> member, if necessary.
> 
> Also, remove a couple of unused zero-length arrays and flexible-array
> members.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/net/wireless/intel/iwlegacy/commands.h:1196:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/commands.h:1197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/commands.h:2505:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/commands.h:2549:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/commands.h:2654:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/commands.h:2665:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/commands.h:2673:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/commands.h:3349:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

a7e8997ae18c wifi: iwlegacy: Avoid multiple -Wflex-array-member-not-at-end warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Zr2gxERA3RL3EwRe@elsanto/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


