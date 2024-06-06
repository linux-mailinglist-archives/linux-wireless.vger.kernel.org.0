Return-Path: <linux-wireless+bounces-8605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0EC8FE3D2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 12:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632601F22BB2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912918FC6D;
	Thu,  6 Jun 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D51cTl1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB3818F2E7;
	Thu,  6 Jun 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668583; cv=none; b=Rt08CW3gkUBPg366n1K4ucqF1HosIjOwmp0D3CCjfSpDNefFHcr56Z5WN/3Rdd4UNWzoMDxO9BwobO8ftrfgmAN8wwuW2zeIPx67eFze7M2PBGEQ6zx/tIJ4tDTZj/hsBlWcmBWt+XjT7K8HN9QS6IdItZxGQt5Lind1xsjsU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668583; c=relaxed/simple;
	bh=7eW5DPCMgKarBv0elahi2qUIZ7QfuPQhiajhcK371D4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eZlng0Omz8h+Vmw4QB4hYOsPEZHE1O6I4D5gTwcZHR6GyhKs3HNHOsJlZDj0g09gRqtRyB6pdeKjEbZTWxtZwySUWFP71YuVxjJc4dytdRcpybKV2yeV7HFU+nfpqUfkf0I+KOZH8ChbVcuBTh0oQq9TCcYuHfLwacdTDEUwqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D51cTl1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E676C3277B;
	Thu,  6 Jun 2024 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717668582;
	bh=7eW5DPCMgKarBv0elahi2qUIZ7QfuPQhiajhcK371D4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=D51cTl1FxORGUXFGMiXnSDdw5jb5t0CnC+n3a+xfukgwOm0kAmaPpnDMbQkEvWxub
	 olLtpcHmHceKkP7lC/m5p/JKSQhuJKhhKeyouwr8afm63ymN9r9iKo+NIuIAh1uwHM
	 wHF8PScjcCpdvv5PI4K7M6oIGk0bpqaoC3chJeNsi+Lliy5S+fmUoEX5fuPL7XUqY2
	 YqWpD7owO93Mpx0ZU2ykHrcENbRRmi688DgPeTFLXPBwpkWr/pRZVESqjq55HSrLb9
	 aNHiELuXi7h3ZHbYBWfB9kTI5osherpcYBnFc2EznbRbgzND4jWjPAnOIg8UimRy3q
	 TD/JNLwEYaHwQ==
From: Kalle Valo <kvalo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Alexis =?utf-8?Q?Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Wireless
 <linux-wireless@vger.kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
References: <20240603110023.23572803@canb.auug.org.au>
	<875xuquyyb.fsf@kernel.org>
Date: Thu, 06 Jun 2024 13:09:39 +0300
In-Reply-To: <875xuquyyb.fsf@kernel.org> (Kalle Valo's message of "Mon, 03 Jun
	2024 13:01:48 +0300")
Message-ID: <87tti6qt5o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>
>> Hi all,
>>
>> Today's linux-next merge of the wireless-next tree got a conflict in:
>>
>>   drivers/net/wireless/microchip/wilc1000/netdev.c
>>
>> between commit:
>>
>>   ebfb5e8fc8b4 ("Revert "wifi: wilc1000: convert list management to RCU"")
>>
>> from the wireless tree and commit:
>>
>>   6fe46d5c0a84 ("wifi: wilc1000: set net device registration as last
>> step during interface creation")
>>
>> from the wireless-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>
> Thanks. We need to figure out how we solve this conflict, most probably
> we'll ask network maintainers to fix it when they pull wireless-next.

Alexis, you know wilc1000 the best. Could you double check the conflict
resolution, it somewhat complicated:

https://lore.kernel.org/all/20240603110023.23572803@canb.auug.org.au/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

