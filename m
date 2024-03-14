Return-Path: <linux-wireless+bounces-4730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E117487B955
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973801F213F7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F776A8D1;
	Thu, 14 Mar 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEAA2HiL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E1EEC4
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405213; cv=none; b=lAAOTZ9C/+zA9wFHUDaqh4PPwh04HP6UMnKQrCyF/ZkEBucZvdMiw0HOBgvcft2+9IBCbpr1O7DyfGvCYRcCCJmUdez0/5wGMlWAWx0DN8PA1CUKAw9Ztv687ltzqN0rpgY+sPa+CIWbUACpu42GAoKFedNLrnWzOQilLIt7oks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405213; c=relaxed/simple;
	bh=KssfxQpRbpAraK2Auwsewdz67eLinMu4N6AmB6bq1gw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YkaXSarSF1VjmNTk4krYOkQhfnjC+GzBTq3BK5sUc608gIwAlfuQVzF/kSaFo4wH4Suxz8VVN9DsKBMzLozIZUW9wMSFqhOeGifjgTUqc4PXhVgp0Vuvyz+vQ1Zt8SdAG3wr3KbH6QLvTcj1D1K3jDIiN2Rea6TZ6tasqkpJNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEAA2HiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A26C433C7;
	Thu, 14 Mar 2024 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710405212;
	bh=KssfxQpRbpAraK2Auwsewdz67eLinMu4N6AmB6bq1gw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hEAA2HiL5lER9J6Xql3mtzuKxbqZaZRCI2ibcTbTaRZn84kFDo5plWyaJVY92v4nB
	 JW/odT9BUgl780BLt1KpEeagD4VbgomQLQXd7etxvYNuGdV5xrkZRRqi2Qm/g3vnrl
	 ZNrcMxR36kdClAk0FId1m/qr08xbLxsSTEkbiKtVFw9jCnX2KTtd5NuwN9Y2C6k7ck
	 K2f/gentEZEXYICxWkwG8v7it2A+Y78pjvkUuMKEmRQW0/9VmbFMNGeMP5uPlgnhoJ
	 TtO6Fm5VfNy6w8zK7N67Gx3y1UIhu7+kOU3u4Ijwh06DB56gER8HVT57qaEASeJRfs
	 LKDZFro5UgB5g==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <ku920601@realtek.com>,  <kuba@kernel.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw89: coex: fix configuration for
 shared antenna for 8922A
References: <20240309001348.9906-1-pkshih@realtek.com>
Date: Thu, 14 Mar 2024 10:33:29 +0200
In-Reply-To: <20240309001348.9906-1-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Sat, 9 Mar 2024 08:13:48 +0800")
Message-ID: <875xxpfc12.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> WiFi 2x2 + BT combo cards can be two or three physical antenna. For two
> antenna case, one antenna is shared by WiFi and BT, and different
> configuration should be applied. Fix the typo.
>
> This problem was found by Coccicheck, and actually that is a typo instead:
>   drivers/net/wireless/realtek/rtw89/rtw8922a.c:2235:2-4:
>     WARNING: possible condition with no effect (if == else)
>
> Fixes: 652c9642eda6 ("wifi: rtw89: coex: add init_info H2C command format version 7")
> Closes: https://lore.kernel.org/linux-wireless/170992024446.15593.2682606960737891240.git-patchwork-notify@kernel.org/T/#m074885bdbd91071c7d1771f08917831d9f89d95a

BTW for Closes and Link tags it's better to use a direct lore link with
Message-Id:

    Closes: https://lore.kernel.org/linux-wireless/20240308074539.04512f66@kernel.org/

The benefits are:

* as the Message-Id is in the link, the mail can be found even if
  lore.kernel.org would go away

* it's shorter

* regzbot uses the Message-Id to close the issues

In lore you can get the URL from "permalink" link. I changed the link
during commit, so no need to resend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

