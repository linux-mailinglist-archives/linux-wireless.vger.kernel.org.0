Return-Path: <linux-wireless+bounces-7157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E578BB9AE
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 09:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC5B283071
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 07:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC824A24;
	Sat,  4 May 2024 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU7PHdik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242E4689
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714806607; cv=none; b=frrnZTBCSw3HMqiBHO7OkPllytniEgLthAGZwT3CBoHvMXXSinmX36sit5jn4UIwYjlYY4xZuuhNxh4tfRe4qW698BbiSiBbtdcm0oFnoLWfQ+bXpVAWI0hVb/eNEBeApXrJCFUYO4rFbHKYUa7NrmB9IOLrcpaBOv5arjwnv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714806607; c=relaxed/simple;
	bh=MLgcUHnoInPulcpSXffucXKc2udSWGyMYiw3oEuFMw4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=b/p84+gALG5mypBhSmFDmKWxS29zjZecvQD2eHVjJ6Iq+f9CTW9tSNQgmJAZd49Lt12KkOglxa/VW3PelsHsZ0N9bhJj6X8dFgPdphj9mLVV1dplxwOyJs8E9KjrX7yRtJn3ETmpcyR90xfKYvlb0TI7AEXAv92uwL2sJnUoTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU7PHdik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E592DC072AA;
	Sat,  4 May 2024 07:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714806606;
	bh=MLgcUHnoInPulcpSXffucXKc2udSWGyMYiw3oEuFMw4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FU7PHdikL2JCqNIjMvOSCoxrJoO4NZ+PFmdgjerefuHItIEN+/54rAmVgkMiRnddj
	 SRJ3z6dEVUJ0XKId0RCKxbQb/6b+G5H7q0ttE4mm25cBiPeIEpUI6neBBZBX99CT7f
	 s3cqVbpboCvDxfYHwlllwxkYvsIufRyXHA4INrASJIu63nEgO313/3yzSe6bH3m8mk
	 5Ux0ztJ4a/cHmGlB7IjTxcE2F0WCATwbxLQ/S4D/jbhmnVTKeDkQ/wJTHDZALeZSGG
	 1QN/bCBZJm0O0FXjVyyZIfXj/i4Cms1wJZb62JGXhiOGT3k0PzJtKXlio0Emdxmxt+
	 zLWjBSYLyi85Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-05-04
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <333d56f0-ef24-4946-958d-e804cf9c733b@RTEXMBS04.realtek.com.tw>
References: <333d56f0-ef24-4946-958d-e804cf9c733b@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171480660387.2072516.10612946227059882367.kvalo@kernel.org>
Date: Sat,  4 May 2024 07:10:05 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

I see a new warning with GCC 13.2. Please fix this and send a new pull request.

In file included from ./include/linux/fortify-string.h:5,                                                
                 from ./include/linux/string.h:369,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:13,
                 from ./include/linux/sched.h:16,
                 from drivers/net/wireless/realtek/rtlwifi/rtl8192d/../wifi.h:9,
                 from drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:4:
In function 'le32p_replace_bits',
    inlined from 'rtl92de_update_hal_rate_mask.isra' at drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:986:2:
./include/linux/bitfield.h:189:15: warning: 'rate_mask' is used uninitialized [-Wuninitialized]
  189 |         *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
      |               ^~
./include/linux/bitfield.h:196:9: note: in expansion of macro '____MAKE_OP'
  196 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |         ^~~~~~~~~~~
./include/linux/bitfield.h:201:1: note: in expansion of macro '__MAKE_OP'
  201 | __MAKE_OP(32)
      | ^~~~~~~~~
drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c: In function 'rtl92de_update_hal_rate_mask.isra':
drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:863:37: note: 'rate_mask' declared here
  863 |         struct rtl92d_rate_mask_h2c rate_mask;
      |                                     ^~~~~~~~~

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/333d56f0-ef24-4946-958d-e804cf9c733b@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


