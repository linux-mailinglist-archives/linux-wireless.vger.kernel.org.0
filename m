Return-Path: <linux-wireless+bounces-696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4180EE94
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB641F21590
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E357317C;
	Tue, 12 Dec 2023 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ3Yp75g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C47316F
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 14:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E53CC433C8;
	Tue, 12 Dec 2023 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702391033;
	bh=RFzRehKbJal1Ks9fvN2tnfICVyLscWmgOdTrzxAZvZg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aQ3Yp75gmNkZuCijEJY1nQKZftJVe08ds9T555jbNMl0x6BxVvBXBghGlPxXPxPLE
	 i1tyxUsZdS7O0ZJQmEz6kDXr/iCnAa5OC2yn3DGJYpHIIbwf3gX2wR6drV+BX28FSB
	 lj+oM/27DX5TIvyXEIlxthtv463T3Pi9lpOBfcnqXfHkwwP2uICFQcuAaIf5+GEpBk
	 cbdfqWZENCDsgNeqU5L6GFSBJTKe5NbwRhkli0x/kadIhNjswpPt8voM5D301BE5Nn
	 9s4k3wd9IGQoC0lzhYUN+AlWgexr+CE6duCMD75JcYEYWSU8zG3JzR5hIR3rp5B2Hg
	 exYaho6TqvtJw==
From: Kalle Valo <kvalo@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>,  "Ping-Ke Shih" <pkshih@realtek.com>,
  "Gustavo A. R. Silva" <gustavoars@kernel.org>,  "Ching-Te Ku"
 <ku920601@realtek.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtw89: avoid stringop-overflow warning
References: <20231204073020.1105416-1-arnd@kernel.org>
	<170196405395.2897000.836367709392997740.kvalo@kernel.org>
	<f39d5940-2030-4378-9a44-3355a4429e31@app.fastmail.com>
Date: Tue, 12 Dec 2023 16:23:49 +0200
In-Reply-To: <f39d5940-2030-4378-9a44-3355a4429e31@app.fastmail.com> (Arnd
	Bergmann's message of "Thu, 07 Dec 2023 17:11:06 +0100")
Message-ID: <87plzbo5xm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Thu, Dec 7, 2023, at 16:47, Kalle Valo wrote:
>> Arnd Bergmann <arnd@kernel.org> wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> 
>>> Fixes: 89741e7e42f6 ("Makefile: Enable -Wstringop-overflow globally")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> ERROR: 'wifi:' prefix missing: '[PATCH] rtw89: avoid stringop-overflow 
>> warning'
>> ERROR: Failed to find commit id: Fixes: 89741e7e42f6 ("Makefile: Enable 
>> -Wstringop-overflow globally")
>>
>> I can add the "wifi:" prefix but where can I find the commit 89741e7e42f6?
>
> It's in linux-next and came in from Gustavo's tree at
> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

Ah, I think then I'll drop the Fixes tag to avoid warnings or reports.
My understanding is that a commit in the Fixes tag should be a parent.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

