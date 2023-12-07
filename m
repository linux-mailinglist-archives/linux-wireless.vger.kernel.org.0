Return-Path: <linux-wireless+bounces-542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4780894B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB871C20AC0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB540BE8;
	Thu,  7 Dec 2023 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7yLnxDr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC740BE7
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 13:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4092EC433C8;
	Thu,  7 Dec 2023 13:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701956179;
	bh=Qwv9zUvW8VWAVcfYBG3DHiEhb0nep6/2uo02M3ARqe0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=j7yLnxDrri314CwcIv20E0nr2q84QjCXlLjNlifr/66r0tbpJuXxdhBYOHAfaLDid
	 z/+rEbP9uJoVkmzxXjVE9BWh1fBte4QZTMPkHgrWzc4okZGv3OXaZvD/2moKuLqyKT
	 blxOGJ/ZZG4cQYR6Bv7+WppezuRvZEuBRDQdPKVdn5q+lbdYK0TUCOfgHRPeSD8Ry4
	 NAu1TNhMYaqZOJbF5B3/E63vZ5e5m+iKeOpW8oQzDjPK1UBnNxYoWUdFqL4A+KLoPI
	 toN1PRybCgB5BRfSi7zVat4NtbM/nczm5yO+Php6z7tJO+hVFm+8xmcnVkvwjkMq6+
	 fJsSOIur2RXWw==
From: Kalle Valo <kvalo@kernel.org>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/13] wifi: iwlwifi: updates - 2023-12-06
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Date: Thu, 07 Dec 2023 15:36:15 +0200
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
	(Miri@web.codeaurora.org's message of "Thu, 7 Dec 2023 04:50:05
	+0200")
Message-ID: <87lea65e40.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

miriam.rachel.korenblit@intel.com writes:

> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>
> Hi,
>
> This patch set includes iwlwifi patches intended for v6.8
>
> It contains a few bugfixes and cleanups.

BTW your From field is weird:

From: Miri Korenblit miriam.rachel.korenblit@intel.com

https://lore.kernel.org/linux-wireless/20231207025018.1022929-1-miriam.rachel.korenblit@intel.com/raw

And on my end something changed it to even more strange:

From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org, miriam.rachel.korenblit@intel.com

I recommend checking your settings.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

