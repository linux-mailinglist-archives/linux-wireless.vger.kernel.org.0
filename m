Return-Path: <linux-wireless+bounces-1962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3182E97A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 07:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553ECB20B6B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9916D10782;
	Tue, 16 Jan 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIWd9iG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFE101E8;
	Tue, 16 Jan 2024 06:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30961C433C7;
	Tue, 16 Jan 2024 06:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705386192;
	bh=wn5afpTDsUt4WqYPTCnDiyIElZQNuJSw8lHT2Uhwh5k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LIWd9iG8qo3cXa094mD7kjv18MKoQe8U4Ml1yfgNowrLZa9m7uwflsVyDbY8c+Qg3
	 2KG+DCpATXmjuDfnShYXJs0+84KYtDi/dEEL/SuAwJDbFGS55SEyuOl2XC5ey7nXDY
	 j02FaMCRg7nfX+iVk3qZun7zFCQ/bPZ1gWvXL90efBSj+qV3kLJApf7paibBLnD10b
	 4gSpe75lhasICL3zKbv3VMOqBKOdJHq8cZZjASVNDomc7tf4co2KwqG8wqTVPGl6d4
	 Z2UumhD8EsZF0oIGIrPPIKETJK2S469gjM2f/Bo/I3UDA0h6Im3zVvGXoSF3iW0odQ
	 M84NzH/4lrvKA==
From: Kalle Valo <kvalo@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
  oe-kbuild-all@lists.linux.dev,  Johannes Berg
 <johannes@sipsolutions.net>,  linux-wireless@vger.kernel.org,  Ping-Ke
 Shih <pkshih@realtek.com>
Subject: Re: [wireless-next:main 32/56]
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:
 sparse: invalid assignment: |=
References: <202401161318.YtXoCkjU-lkp@intel.com>
Date: Tue, 16 Jan 2024 08:23:08 +0200
In-Reply-To: <202401161318.YtXoCkjU-lkp@intel.com> (kernel test robot's
	message of "Tue, 16 Jan 2024 13:47:32 +0800")
Message-ID: <877ck9hk4z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> head:   ece90a8622320bf5a24d3326da1f8e109891573c
> commit: b837f78fbffa5f8e7e7c59879db54793abf161ec [32/56] wifi: rtl8xxxu: add hw crypto support for AP mode
> config: riscv-randconfig-r132-20240116 (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401161318.YtXoCkjU-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse: sparse: invalid assignment: |=
>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    left side has type restricted __le32
>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    right side has type unsigned long

Martin, could you send a fix for this ASAP?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

