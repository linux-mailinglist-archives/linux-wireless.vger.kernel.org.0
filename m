Return-Path: <linux-wireless+bounces-550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30978808CEC
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1BB1F20FC1
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC044372;
	Thu,  7 Dec 2023 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mY5disBs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7GNY5nA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748FEB9;
	Thu,  7 Dec 2023 08:11:29 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E066E5C021E;
	Thu,  7 Dec 2023 11:11:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Dec 2023 11:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701965488; x=1702051888; bh=Y5
	EtfXRSI/+ixNFoU04FOFaVdI+LJixYoWPRJ9FkR5c=; b=mY5disBsuPFMVlEEPk
	0cc9XMc6QWCWGB+uMWnfiO3pOHGhKeLZz6QymL1oOZsnWzzk/KUNLW2jsml1vMLG
	VShStlaQsAJmd7YZz6qnGL+jkxdNAs34o25ajZ9+bFr3ZfzQsX1lM3z5ZoS+Dnvc
	0CLVA+NUk6Ska/S7DydrCMGN63l9A7tn3m8Pru58MJDqYftoheutQLddR4kC1Uad
	/YidtYklvTW7ask6TJKhHBXBMSXnAEi9Yu8a/jtvwkC4D3fH2j0sZZooXi5Buf7i
	GSycLxwxMpYzX5MwdyPa1VG/w9HbI03hjaQZpM/gJfP/GFPV7rRzBuSp7gYy9Sqt
	E8Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701965488; x=1702051888; bh=Y5EtfXRSI/+ix
	NFoU04FOFaVdI+LJixYoWPRJ9FkR5c=; b=Y7GNY5nALvpo2EKuAaGU6+Jd06Q+c
	nFH4PRliG1iE4bcGsB0GziCFWLyAx+95Sy0F42dTow06az/D+ja4wfWE4eaj92HZ
	6vH2xVsFWuaQbp78pjWBRV66RQh5cuhMqXtQxt/kIJSIv+SzoDodFj1IpUA6zdXs
	Yfa5bdWWoMXrpQvZUwm99XvMqPvP3ZXiJny99oultBoG0yA8c3Q1PZUuypOzkL0K
	ycTtcbrtTok0nOt3HQnxfe2SQQvO5JxNdw6N6hnyeuHCrZL7AoydA4LHFClbwCt9
	1n7P4cqZexpQ18yqO3/7BiBFT4w6QZlrr+VqTo/FYAoENIBIGtj3n2arw==
X-ME-Sender: <xms:sO5xZWclTWKxVhBIizJucOoDtJTB8-e4tB6AjPPs8QaN36_LIbwVPw>
    <xme:sO5xZQOTXT9bcoKLgpnybEqOvTfM5vN2I8e1EUHWPU_C4tlgHHGSi_gdRXv8csxl6
    NextYnhPuT_xsmVWfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekfedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:sO5xZXiiECUZ-NrIY2dYBr4dQzHbCL9RvnoWMsjLfDsYjdchDrAGoA>
    <xmx:sO5xZT9pkNWvC6U2UtMpqwvB8VQe8jak3M4T9HgGJ19-YWeXImLV_Q>
    <xmx:sO5xZSsuY5Hy8hNkb3iu7qIpDJEOP4yHRT93dphu_VQlwGVgh88CLg>
    <xmx:sO5xZUIIcz4NyJFTwnsKodvyLZi79lC1dkoGcgWzd9o2aab2SoOW5A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 69B56B60089; Thu,  7 Dec 2023 11:11:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f39d5940-2030-4378-9a44-3355a4429e31@app.fastmail.com>
In-Reply-To: <170196405395.2897000.836367709392997740.kvalo@kernel.org>
References: <20231204073020.1105416-1-arnd@kernel.org>
 <170196405395.2897000.836367709392997740.kvalo@kernel.org>
Date: Thu, 07 Dec 2023 17:11:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Ping-Ke Shih" <pkshih@realtek.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Ching-Te Ku" <ku920601@realtek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtw89: avoid stringop-overflow warning
Content-Type: text/plain

On Thu, Dec 7, 2023, at 16:47, Kalle Valo wrote:
> Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Fixes: 89741e7e42f6 ("Makefile: Enable -Wstringop-overflow globally")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> ERROR: 'wifi:' prefix missing: '[PATCH] rtw89: avoid stringop-overflow 
> warning'
> ERROR: Failed to find commit id: Fixes: 89741e7e42f6 ("Makefile: Enable 
> -Wstringop-overflow globally")
>
> I can add the "wifi:" prefix but where can I find the commit 89741e7e42f6?

It's in linux-next and came in from Gustavo's tree at
https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

    Arnd

