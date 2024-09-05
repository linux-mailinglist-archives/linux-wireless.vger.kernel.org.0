Return-Path: <linux-wireless+bounces-12532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A849E96DA66
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 15:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D87F1F237A8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CE19DF5C;
	Thu,  5 Sep 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPtZHFRW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C519DF5B;
	Thu,  5 Sep 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543209; cv=none; b=KZ/3/3CeQ0ckX2laEEU0j8eS9QrgED1AZgz0sVh/qDp8fqpKXmDtzqJBAaUPu8aBjV7rU/9WJtrObFCQJ7z3xeiMXmTFKSKGQuFaGGLmDf0ZWdq844Dv7CaYEKlFbzKoV+XQiBp7G8J4oS1qSvoGj6DBTwslGeTNZqgpkH64Kzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543209; c=relaxed/simple;
	bh=bnAS4E/vDjLHG8xkgTnr6zM6XR0xaTXlpGLRZPgH52g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LjFcQ8MC5x4HH34M12FWNRfi/+UrAiLiUtDumw4XJVJNgZvOCm56NuoaUxqQ1fXp3SQP2DwlWoaPmBNgGYfoIDT7pFS4vevymSA/7eajJUfFMjMBkQ9Gogtb3+AYylqF/iO5PfX5tq+AJABK85F9qCKBChyvcBZTjW2azhBtV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPtZHFRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66002C4CEC4;
	Thu,  5 Sep 2024 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725543208;
	bh=bnAS4E/vDjLHG8xkgTnr6zM6XR0xaTXlpGLRZPgH52g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EPtZHFRW8llmK6Z6OVTsRpJ+4eQesF7cbGV3cffdTTduiP8DBxzH6kgfFtLWMqyh+
	 cPWIUMczr4JeZd/3P1zpsXPKCqbIcKXB1o6K/8NmSdrhy+SNdQNv3AiZyiSO4VZJio
	 UzVf2/99ht0fcJ0m8x/ZoZvIYbDEn+QTuraZaK3s3lNn2dUHCRUZ7fCBADyx8cp/Ur
	 wnXIQhZHgmyKpKSgiUHTq7oSDM9m90AgoZo0yWZCxS/yKngy+PsBnM/uMRzHV4JPr7
	 fwR6SIEF4GDs7UzJgMidLwgUbkZTNB6YewSBtbxy3ZE0UOrBh+OqX+4c8ioUc3IuCU
	 C4CQi5fFHDYew==
From: Kalle Valo <kvalo@kernel.org>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Bert Karwatzki <spasswolf@web.de>,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  sean.wang@kernel.org,  nbd@nbd.name,
  lorenzo.bianconi@redhat.com,  sean.wang@mediatek.com,
  deren.wu@mediatek.com,  mingyen.hsieh@mediatek.com,
  linux-wireless@vger.kernel.org,  linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in
 mt792x_mac_link_bss_remove
References: <20240718234633.12737-1-sean.wang@kernel.org>
	<0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
	<CAHbf0-Hn=ZyYpk7bS1yLK7K3ZpfWKgt3-t=c9Nhdj3Ov3H84mQ@mail.gmail.com>
	<f7197c55d059cc8ddbf6c3def16dc414c5ec0b42.camel@web.de>
	<CAHbf0-EBHERbxPGakY4-1jTQWqGqua3F0OYZjxcakdemJ5Soqw@mail.gmail.com>
	<51e80bde6e3f3256ecdea2e5260463341e65578e.camel@web.de>
	<CAHbf0-HYi=x11bc-sMJFbZ4cbkdphMYQ_hjzD_wrPvJevVwyYg@mail.gmail.com>
	<980698e0d6dfa1e0043edfed6e174ff17705e053.camel@web.de>
	<CAHbf0-FfAQhuu1TgQ_jVcxPqLsF-ON8vC1QJ=mNhis44dYWufw@mail.gmail.com>
	<d657110b726646efa972c5e83bfce6c6b1627626.camel@web.de>
	<CAHbf0-ETMTYs+T=qkLd=Y-W1ssQq1ZMDkxqHCJPSYA9U9CCgHw@mail.gmail.com>
	<CAHbf0-HbLRRhtUEj1TDzemePoaLo71sxMFDN526HPEB_zO+4ow@mail.gmail.com>
Date: Thu, 05 Sep 2024 16:33:24 +0300
In-Reply-To: <CAHbf0-HbLRRhtUEj1TDzemePoaLo71sxMFDN526HPEB_zO+4ow@mail.gmail.com>
	(Mike Lothian's message of "Thu, 29 Aug 2024 17:52:36 +0100")
Message-ID: <8734mecjiz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Lothian <mike@fireburn.co.uk> writes:

>> > this seems to be exactly the same error as I had (It can also be actively
>> > provoked by "nmcli radio wifi off"), but in my case commit 479ffee68d59c599 is
>> > enough to fix the issue. Can you please double check that your faulty kernel
>> > does not include this commit. If it does and you still get the error I can post
>> > the fix to the list.
>>
>> 479ffee68d59c599 isn't enough to fix it here, I've been applying the
>> second patch since it was pointed out
>
> Sorry I've gotten myself confused as the patches changed
>
> My kernel with
> 6557a28f3e3a54cff4f0dcdd1dfa649b26557ab3
> 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3
>
> Is enough to fix things
>
> I've been applying  the old fix on top which was only applying
>
> @@ -1206,6 +1206,9 @@ static void mt7921_ipv6_addr_change(struct
> ieee80211_hw *hw,
>                },
>        };
>
> +       if (!mvif->phy)
> +               return;
> +
>        read_lock_bh(&idev->lock);
>        list_for_each_entry(ifa, &idev->addr_list, if_list) {
>                if (ifa->flags & IFA_F_TENTATIVE)
>
> Casing it to be rebuilt each time

So just to confirm: all fixes are now applied to the tree and we don't
have any missing fixes?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

