Return-Path: <linux-wireless+bounces-1589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581C8272EC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC461F21090
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C44C623;
	Mon,  8 Jan 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPW+uoMh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C94C610
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 15:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA20C433C7;
	Mon,  8 Jan 2024 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727422;
	bh=+9HfResmFELxvjC7ij37IErxRXfh7YCjAMkpPlssfcY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UPW+uoMh8+EuJZVXHmo/j4U7184c6YrnQegTL67nxf7ZUZaRReb6G+HGbab6wuX/s
	 1125JICvEhM8/xgeOgG+SzEfvZ7hMx5P0tlemtSgbwm/DGQNvJvEkmw2uUF7aOcbrq
	 lPd9GXRJm6OvCvTdB43uJvjHWRUQ6drZwAmLt9kAVLJglKjkGq3ZSgqbQ/rhJ0tW56
	 S2phlG0fXxNEpzyFIltT58yJMVyV7BYAfzlu6INjhoeV5j64JBz5p8Ri3/D9WQirAr
	 VrRh2i1gPaHiATwosBsNDvrH9K0upls+lEVY1oSuGCwqqV5No+OUdqBaAdPWC0q6dC
	 o2dXa0QvwmnlA==
From: Kalle Valo <kvalo@kernel.org>
To: lilinmao <lilinmao@kylinos.cn>
Cc: "pkshih@realtek.com" <pkshih@realtek.com>,  =?utf-8?Q?linux-wireless?=
 =?utf-8?Q?=40vger=2Ekern=E2=80=A6?=
 <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
References: <20240105104542.463834-1-lilinmao@kylinos.cn>
	<1704693852309064.667.seg@mailgw>
	<077A3848-0696-4DCC-99C3-DB5389EA2EA2@kylinos.cn>
Date: Mon, 08 Jan 2024 17:23:39 +0200
In-Reply-To: <077A3848-0696-4DCC-99C3-DB5389EA2EA2@kylinos.cn>
	(lilinmao@kylinos.cn's message of "Mon, 8 Jan 2024 14:47:18 +0800")
Message-ID: <87jzojetms.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

lilinmao <lilinmao@kylinos.cn> writes:

> I'm very sorry for the various issues encountered during my first patch submission.
>
> My patch didn't change the original logic of the code.Perhaps I just changed the way 
> of writing the code to avoid the cppcheck issue.
>
>>The original logic looks like 
>> 
>>bool found = false; 
>> 
>>for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) 
>>if (expr) { 
>>found = true; 
>>break; 
>>} 
>> 
>>if (!found) { 
>>... [A] 
>>}
>
> After the 'for' loop ends, 'if (idx > RTW89_IQK_CHS_NR - 1)' is
> equivalent to 'if (!found). Cppcheck might not have detected the
> changes to 'idx' within branch [A] which leads it to believe later
> that 'idx' could be greater than or equal to 'RTW89_IQK_CHS_NR'.

Our lists drop all html mail, so please use text/plain format and don't
top post. More info in the wiki link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

