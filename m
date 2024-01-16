Return-Path: <linux-wireless+bounces-1967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E782EB47
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 10:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1571FB218F0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BDB125C4;
	Tue, 16 Jan 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYYpum9e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50B125C2;
	Tue, 16 Jan 2024 09:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA93C433C7;
	Tue, 16 Jan 2024 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705396169;
	bh=mGR5fdiwItdflTpKRth3JFoB5tYEIN9Uc+2YAA+d68M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OYYpum9eHU+6VIppsLHZ5AzxKAvECTQwZ1VKVz8yDGusHN/j9/dXY1Gn4c1n+iLwl
	 MObRoAPHiceTW7XYBwTdDyS8E2o0eUpkCkvdKipqLTWhvhaL5CAbkmUETVlzglMV/P
	 TiMYq40gR0wdq+3Mhac2pTOj4r4jlRbpjEMNgwb05SvUwNcynakYqm2XCW/wPK9Xz/
	 L14WVtwImRbhmXLmgxpJqRCEiDOjU+HqmvqTpQIQGIv/Q7oI+7d/29bJTEHfRqj8X5
	 kU2MpcMedJisdCyMezDU9R9THMbQmSBOVF2BhudZ4yvIOMbzmsU22QZFGGgW3R5SNi
	 pyXnTVIETseSw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: kernel test robot <lkp@intel.com>,  Martin Kaistra
 <martin.kaistra@linutronix.de>,  "oe-kbuild-all@lists.linux.dev"
 <oe-kbuild-all@lists.linux.dev>,  "Johannes Berg"
 <johannes@sipsolutions.net>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>
Subject: Re: [wireless-next:main 32/56]
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:
 sparse: invalid assignment: |=
References: <202401161318.YtXoCkjU-lkp@intel.com> <877ck9hk4z.fsf@kernel.org>
	<0337a8c9c9224ec8852e8ec03bf21560@realtek.com>
Date: Tue, 16 Jan 2024 11:09:25 +0200
In-Reply-To: <0337a8c9c9224ec8852e8ec03bf21560@realtek.com> (Ping-Ke Shih's
	message of "Tue, 16 Jan 2024 08:19:03 +0000")
Message-ID: <8734uxhcfu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Tuesday, January 16, 2024 2:23 PM
>> To: kernel test robot <lkp@intel.com>
>> Cc: Martin Kaistra <martin.kaistra@linutronix.de>; oe-kbuild-all@lists.linux.dev; Johannes Berg
>> <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: Re: [wireless-next:main 32/56] drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40:
>> sparse: sparse: invalid assignment: |=
>> 
>> kernel test robot <lkp@intel.com> writes:
>> 
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
>> > head:   ece90a8622320bf5a24d3326da1f8e109891573c
>> > commit: b837f78fbffa5f8e7e7c59879db54793abf161ec [32/56] wifi: rtl8xxxu: add hw crypto support for AP
>> mode
>> > config: riscv-randconfig-r132-20240116
>> (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-lkp@intel.com/config)
>> > compiler: riscv64-linux-gcc (GCC) 13.2.0
>> > reproduce:
>> (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-lkp@intel.com/reproduce)
>> >
>> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> > the same patch/commit), kindly add following tags
>> > | Reported-by: kernel test robot <lkp@intel.com>
>> > | Closes: https://lore.kernel.org/oe-kbuild-all/202401161318.YtXoCkjU-lkp@intel.com/
>> >
>> > sparse warnings: (new ones prefixed by >>)
>> >>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse: sparse: invalid assignment: |=
>> >    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    left side has type
>> restricted __le32
>> >    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    right side has type
>> unsigned long
>> 
>> Martin, could you send a fix for this ASAP?
>> 
>
> I help to prepare a patch [1]. Because sparse reports two warnings, I fix
> them by two patches in the same patchset.  
>
> [1] https://lore.kernel.org/linux-wireless/20240116080945.20172-1-pkshih@realtek.com/T/#t

Awesome, thanks Ping!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

