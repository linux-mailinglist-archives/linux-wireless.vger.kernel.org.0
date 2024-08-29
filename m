Return-Path: <linux-wireless+bounces-12210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD5964BB8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300CD2833D6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40EE1B5312;
	Thu, 29 Aug 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwEY8MrN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F361B0132;
	Thu, 29 Aug 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949098; cv=none; b=HvBqM3NlFZ4JVLT9tpPuFsgVqg2bjYKbWsIBImsbugOk0ik75DoajqFxOo1qxKO0Xl8kXhfFZFy0h64j8umIO9rdIzOP7GFYod2gnoHtFu1aFNbzXNUssNaUo/nmkygSbt66dwNqtmTtuaJHm/1s7561B1AptSA1a/OeQ6ptwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949098; c=relaxed/simple;
	bh=h/1tihQVLOfVmreAgQmR9yexsQmkDj6RITif/x/+a7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Prf1FXgqZ4m6AT1dV7P1z0cDYUx45y/yJZsP1Ew0jNtzVBkg98gK1qRdkUWY2cZ+1zg59f6NnsMReYlT7AaEo2DU26iV+Jo+NReXFVZIgWGn4mS3rDPlDOwkc0JVwIem90GJR6nK241QBs40bvYkoKyn/+2QbYBhW5sOSomw4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwEY8MrN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724949096; x=1756485096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h/1tihQVLOfVmreAgQmR9yexsQmkDj6RITif/x/+a7M=;
  b=nwEY8MrNcdxKIVHN/OKh8b5f9tzuxJk7Ul6LSvAU6Jo0cGqUPplS66Bm
   IaQUWkG8bomGmnwGdGDmUWfDzjDgUxyHblg4U/gKZR3Lpp32M0XK80jFq
   2BQJSRo01KnD3ndV0MsOJgbSZBnoQF7yq6jAtc3/9oAx6/60ARJBRBHiT
   pM9Km8uOsUy1t4iAARpHm4HOUzEaPQFJtpR5yYoKMQFETn+lYVClhqbCY
   urJBTbzJQm4PFX9BzYghcVnhDhIzPRGgXj3OrOrzfLf96LvK5ZijFNyb3
   ibQPkzuZ1XF1MX3TyUxIaBsHz7DwCG9Sp86VmPkLtjVmIfA3YflWYs7mS
   w==;
X-CSE-ConnectionGUID: TXyNRyfsR/mxyaqRiDnmnA==
X-CSE-MsgGUID: k50l0+VAT+K2pTYCviplsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34221510"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34221510"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:31:35 -0700
X-CSE-ConnectionGUID: /d26fRiJQkiBSIrlhX/fAQ==
X-CSE-MsgGUID: yUo4UQ8lTBOnyfTmIyxVbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68521077"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Aug 2024 09:31:31 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sji3U-0000UU-0P;
	Thu, 29 Aug 2024 16:31:28 +0000
Date: Fri, 30 Aug 2024 00:31:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Jacobe Zang <jacobe.zang@wesion.com>, Ondrej Jirman <megi@xff.cz>,
	Sai Krishna <saikrishnag@marvell.com>
Subject: Re: [PATCH v13 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Message-ID: <202408300052.uYcuFzk0-lkp@intel.com>
References: <20240828-wireless-mainline-v13-4-9998b19cfe7e@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-wireless-mainline-v13-4-9998b19cfe7e@wesion.com>

Hi Jacobe,

kernel test robot noticed the following build errors:

[auto build test ERROR on dabcfd5e116800496eb9bec2ba7c015ca2043aa0]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacobe-Zang/dt-bindings-net-wireless-brcm4329-fmac-add-pci14e4-449d/20240828-165201
base:   dabcfd5e116800496eb9bec2ba7c015ca2043aa0
patch link:    https://lore.kernel.org/r/20240828-wireless-mainline-v13-4-9998b19cfe7e%40wesion.com
patch subject: [PATCH v13 4/5] wifi: brcmfmac: Add optional lpo clock enable support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240830/202408300052.uYcuFzk0-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408300052.uYcuFzk0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300052.uYcuFzk0-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: In function 'brcmf_sdio_probe':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4456:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    4456 |         if (!bus)
         |         ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4458:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    4458 |                 goto fail;
         |                 ^~~~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4458:17: error: label 'fail' used but not defined
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4450:34: warning: unused variable 'fwreq' [-Wunused-variable]
    4450 |         struct brcmf_fw_request *fwreq;
         |                                  ^~~~~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4449:34: warning: unused variable 'wq' [-Wunused-variable]
    4449 |         struct workqueue_struct *wq;
         |                                  ^~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4447:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    4447 |         int ret;
         |             ^~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c: At top level:
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4461:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
    4461 |         bus->sdiodev = sdiodev;
         |            ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4462:16: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
    4462 |         sdiodev->bus = bus;
         |                ^~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4463:29: error: expected declaration specifiers or '...' before '&' token
    4463 |         skb_queue_head_init(&bus->glom);
         |                             ^
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4464:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
    4464 |         bus->txbound = BRCMF_TXBOUND;
         |            ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4465:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
    4465 |         bus->rxbound = BRCMF_RXBOUND;
         |            ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4466:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
    4466 |         bus->txminmax = BRCMF_TXMINMAX;
         |            ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4467:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
    4467 |         bus->tx_seq = SDPCM_SEQ_WRAP - 1;
         |            ^~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4470:9: warning: data definition has no type or storage class
    4470 |         wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
         |         ^~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4470:9: error: type defaults to 'int' in declaration of 'wq' [-Wimplicit-int]
   In file included from include/linux/netdevice.h:35,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:12:
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4471:48: error: 'sdiodev' undeclared here (not in a function)
    4471 |                                      dev_name(&sdiodev->func1->dev));
         |                                                ^~~~~~~
   include/linux/workqueue.h:524:72: note: in definition of macro 'alloc_ordered_workqueue'
     524 |         alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
         |                                                                        ^~~~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4472:9: error: expected identifier or '(' before 'if'
    4472 |         if (!wq) {
         |         ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4477:9: warning: data definition has no type or storage class
    4477 |         brcmf_sdiod_freezer_count(sdiodev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4477:9: error: type defaults to 'int' in declaration of 'brcmf_sdiod_freezer_count' [-Wimplicit-int]
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4477:9: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4477:9: error: conflicting types for 'brcmf_sdiod_freezer_count'; have 'int()'
   In file included from drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:32:
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h:355:6: note: previous declaration of 'brcmf_sdiod_freezer_count' with type 'void(struct brcmf_sdio_dev *)'
     355 | void brcmf_sdiod_freezer_count(struct brcmf_sdio_dev *sdiodev);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/workqueue.h:301:9: error: expected identifier or '(' before 'do'
     301 |         do {                                                            \
         |         ^~
   include/linux/workqueue.h:308:9: note: in expansion of macro '__INIT_WORK'
     308 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4478:9: note: in expansion of macro 'INIT_WORK'
    4478 |         INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
         |         ^~~~~~~~~
>> include/linux/workqueue.h:305:11: error: expected identifier or '(' before 'while'
     305 |         } while (0)
         |           ^~~~~
   include/linux/workqueue.h:308:9: note: in expansion of macro '__INIT_WORK'
     308 |         __INIT_WORK((_work), (_func), 0)
         |         ^~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4478:9: note: in expansion of macro 'INIT_WORK'
    4478 |         INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
         |         ^~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4479:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
    4479 |         bus->brcmf_wq = wq;
         |            ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4482:9: warning: data definition has no type or storage class
    4482 |         ret = brcmf_sdio_probe_attach(bus);
         |         ^~~
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4482:9: error: type defaults to 'int' in declaration of 'ret' [-Wimplicit-int]
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4482:39: error: 'bus' undeclared here (not in a function)
    4482 |         ret = brcmf_sdio_probe_attach(bus);
         |                                       ^~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4483:9: error: expected identifier or '(' before 'if'
    4483 |         if (ret < 0) {
         |         ^~
   In file included from include/linux/sched.h:2148,
                    from include/linux/kthread.h:6,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:9:
>> include/linux/spinlock.h:332:1: error: expected identifier or '(' before 'do'
     332 | do {                                                            \
         | ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4488:9: note: in expansion of macro 'spin_lock_init'
    4488 |         spin_lock_init(&bus->rxctl_lock);
         |         ^~~~~~~~~~~~~~
>> include/linux/spinlock.h:337:3: error: expected identifier or '(' before 'while'
     337 | } while (0)
         |   ^~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4488:9: note: in expansion of macro 'spin_lock_init'
    4488 |         spin_lock_init(&bus->rxctl_lock);
         |         ^~~~~~~~~~~~~~
   include/linux/spinlock.h:332:1: error: expected identifier or '(' before 'do'
     332 | do {                                                            \
         | ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4489:9: note: in expansion of macro 'spin_lock_init'
    4489 |         spin_lock_init(&bus->txq_lock);
         |         ^~~~~~~~~~~~~~
   include/linux/spinlock.h:337:3: error: expected identifier or '(' before 'while'
     337 | } while (0)
         |   ^~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4489:9: note: in expansion of macro 'spin_lock_init'
    4489 |         spin_lock_init(&bus->txq_lock);
         |         ^~~~~~~~~~~~~~
   In file included from include/linux/sysctl.h:27,
                    from include/net/net_namespace.h:12,
                    from include/linux/netdevice.h:38:
   include/linux/wait.h:65:9: error: expected identifier or '(' before 'do'
      65 |         do {                                                                    \
         |         ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4490:9: note: in expansion of macro 'init_waitqueue_head'
    4490 |         init_waitqueue_head(&bus->ctrl_wait);
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:69:11: error: expected identifier or '(' before 'while'
      69 |         } while (0)
         |           ^~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4490:9: note: in expansion of macro 'init_waitqueue_head'
    4490 |         init_waitqueue_head(&bus->ctrl_wait);
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:65:9: error: expected identifier or '(' before 'do'
      65 |         do {                                                                    \
         |         ^~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4491:9: note: in expansion of macro 'init_waitqueue_head'
    4491 |         init_waitqueue_head(&bus->dcmd_resp_wait);
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/wait.h:69:11: error: expected identifier or '(' before 'while'
      69 |         } while (0)
         |           ^~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4491:9: note: in expansion of macro 'init_waitqueue_head'
    4491 |         init_waitqueue_head(&bus->dcmd_resp_wait);
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/netdevice.h:24:
   include/linux/timer.h:105:24: error: expected declaration specifiers or '...' before '(' token
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                        ^
   include/linux/timer.h:121:9: note: in expansion of macro '__init_timer'
     121 |         __init_timer((timer), (callback), (flags))
         |         ^~~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4494:9: note: in expansion of macro 'timer_setup'
    4494 |         timer_setup(&bus->timer, brcmf_sdio_watchdog, 0);
         |         ^~~~~~~~~~~
   include/linux/timer.h:105:34: error: expected declaration specifiers or '...' before '(' token
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                                  ^
   include/linux/timer.h:121:9: note: in expansion of macro '__init_timer'
     121 |         __init_timer((timer), (callback), (flags))
         |         ^~~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4494:9: note: in expansion of macro 'timer_setup'
    4494 |         timer_setup(&bus->timer, brcmf_sdio_watchdog, 0);
         |         ^~~~~~~~~~~
   include/linux/timer.h:105:41: error: expected declaration specifiers or '...' before '(' token
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                                         ^
   include/linux/timer.h:121:9: note: in expansion of macro '__init_timer'
     121 |         __init_timer((timer), (callback), (flags))
         |         ^~~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4494:9: note: in expansion of macro 'timer_setup'
    4494 |         timer_setup(&bus->timer, brcmf_sdio_watchdog, 0);
         |         ^~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:6:
   include/linux/stddef.h:8:14: error: expected declaration specifiers or '...' before '(' token
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/timer.h:105:51: note: in expansion of macro 'NULL'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                                                   ^~~~
   include/linux/timer.h:121:9: note: in expansion of macro '__init_timer'
     121 |         __init_timer((timer), (callback), (flags))
         |         ^~~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4494:9: note: in expansion of macro 'timer_setup'
    4494 |         timer_setup(&bus->timer, brcmf_sdio_watchdog, 0);
         |         ^~~~~~~~~~~
   include/linux/stddef.h:8:14: error: expected declaration specifiers or '...' before '(' token
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/timer.h:105:57: note: in expansion of macro 'NULL'
     105 |         init_timer_key((_timer), (_fn), (_flags), NULL, NULL)
         |                                                         ^~~~
   include/linux/timer.h:121:9: note: in expansion of macro '__init_timer'
     121 |         __init_timer((timer), (callback), (flags))
         |         ^~~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:4494:9: note: in expansion of macro 'timer_setup'
    4494 |         timer_setup(&bus->timer, brcmf_sdio_watchdog, 0);
         |         ^~~~~~~~~~~


vim +/fail +4458 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c

2baa3aaee27f13 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22  4444  
82d7f3c10cf41c drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2013-12-12  4445  struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4446  {
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4447  	int ret;
e92eedf4e080fc drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2011-11-22  4448  	struct brcmf_sdio *bus;
9982464379e81e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06 @4449  	struct workqueue_struct *wq;
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22 @4450  	struct brcmf_fw_request *fwreq;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4451  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4452  	brcmf_dbg(TRACE, "Enter\n");
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4453  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4454  	/* Allocate private bus interface state */
dcb77f854ae086 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Erick Archer     2024-05-27  4455  	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4456  	if (!bus)
b3e8126eb4c102 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Jacobe Zang      2024-08-28  4457  		ret = -ENOMEM;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4458  		goto fail;
b3e8126eb4c102 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Jacobe Zang      2024-08-28  4459  	}
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4460  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4461  	bus->sdiodev = sdiodev;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4462  	sdiodev->bus = bus;
b83db862ffb871 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-19 @4463  	skb_queue_head_init(&bus->glom);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4464  	bus->txbound = BRCMF_TXBOUND;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4465  	bus->rxbound = BRCMF_RXBOUND;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4466  	bus->txminmax = BRCMF_TXMINMAX;
6bc52319c2c688 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-08-10 @4467  	bus->tx_seq = SDPCM_SEQ_WRAP - 1;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4468  
9982464379e81e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06  4469  	/* single-threaded workqueue */
41b637bac0b0a9 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Sean Anderson    2021-08-02 @4470  	wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-01-09 @4471  				     dev_name(&sdiodev->func1->dev));
9982464379e81e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06 @4472  	if (!wq) {
5e8149f5036afe drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2012-12-07  4473  		brcmf_err("insufficient memory to create txworkqueue\n");
b3e8126eb4c102 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Jacobe Zang      2024-08-28  4474  		ret = -ENOMEM;
37ac5780e08e4e drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2012-11-14  4475  		goto fail;
37ac5780e08e4e drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2012-11-14  4476  	}
9982464379e81e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06 @4477  	brcmf_sdiod_freezer_count(sdiodev);
9982464379e81e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06 @4478  	INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
9982464379e81e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06 @4479  	bus->brcmf_wq = wq;
37ac5780e08e4e drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2012-11-14  4480  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4481  	/* attempt to attach to the dongle */
b3e8126eb4c102 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Jacobe Zang      2024-08-28 @4482  	ret = brcmf_sdio_probe_attach(bus);
b3e8126eb4c102 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Jacobe Zang      2024-08-28  4483  	if (ret < 0) {
82d7f3c10cf41c drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2013-12-12  4484  		brcmf_err("brcmf_sdio_probe_attach failed\n");
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4485  		goto fail;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4486  	}
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4487  
dd43a01c5cdb81 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2012-11-05  4488  	spin_lock_init(&bus->rxctl_lock);
fed7ec44e7ef64 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Hante Meuleman   2014-03-15  4489  	spin_lock_init(&bus->txq_lock);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4490  	init_waitqueue_head(&bus->ctrl_wait);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4491  	init_waitqueue_head(&bus->dcmd_resp_wait);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4492  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4493  	/* Set up the watchdog timer */
e99e88a9d2b067 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Kees Cook        2017-10-16  4494  	timer_setup(&bus->timer, brcmf_sdio_watchdog, 0);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4495  	/* Initialize watchdog thread */
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4496  	init_completion(&bus->watchdog_wait);
82d7f3c10cf41c drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2013-12-12  4497  	bus->watchdog_tsk = kthread_run(brcmf_sdio_watchdog_thread,
9982464379e81e drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Arend van Spriel 2015-02-06  4498  					bus, "brcmf_wdog/%s",
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-01-09  4499  					dev_name(&sdiodev->func1->dev));
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4500  	if (IS_ERR(bus->watchdog_tsk)) {
02f77195db6ce2 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Joe Perches      2012-01-15  4501  		pr_warn("brcmf_watchdog thread failed to start\n");
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4502  		bus->watchdog_tsk = NULL;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4503  	}
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4504  	/* Initialize DPC thread */
2c64e16d1ff122 drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Hante Meuleman   2015-03-18  4505  	bus->dpc_triggered = false;
2c64e16d1ff122 drivers/net/wireless/brcm80211/brcmfmac/sdio.c          Hante Meuleman   2015-03-18  4506  	bus->dpc_running = false;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4507  
706478cba54458 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-08-10  4508  	/* default sdio bus header length for tx packet */
706478cba54458 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-08-10  4509  	bus->tx_hdrlen = SDPCM_HWHDR_LEN + SDPCM_SWHDR_LEN;
706478cba54458 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2013-08-10  4510  
7dd3abc14f94bc drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Daniel Kim       2014-05-27  4511  	/* Query the F2 block size, set roundup accordingly */
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-01-09  4512  	bus->blocksize = bus->sdiodev->func2->cur_blksize;
7dd3abc14f94bc drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Daniel Kim       2014-05-27 @4513  	bus->roundup = min(max_roundup, bus->blocksize);
7dd3abc14f94bc drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Daniel Kim       2014-05-27  4514  
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-01-09 @4515  	sdio_claim_host(bus->sdiodev->func1);
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4516  
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4517  	/* Disable F2 to clear any intermediate frame state on the dongle */
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-01-09  4518  	sdio_disable_func(bus->sdiodev->func2);
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4519  
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4520  	bus->rxflow = false;
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4521  
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4522  	/* Done with backplane-dependent accesses, can drop clock... */
71bd508d7ded8c drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Ian Molton       2017-12-08  4523  	brcmf_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_CHIPCLKCSR, 0, NULL);
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4524  
c9aa7a91de740c drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-01-09  4525  	sdio_release_host(bus->sdiodev->func1);
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4526  
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4527  	/* ...and initialize clock/power states */
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4528  	bus->clkstate = CLK_SDONLY;
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4529  	bus->idletime = BRCMF_IDLE_INTERVAL;
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4530  	bus->idleclock = BRCMF_IDLE_ACTIVE;
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4531  
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4532  	/* SR state */
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4533  	bus->sr_enabled = false;
fad132285081c1 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-01-06  4534  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4535  	brcmf_dbg(INFO, "completed!!\n");
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4536  
2baa3aaee27f13 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22 @4537  	fwreq = brcmf_sdio_prepare_fw_request(bus);
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22  4538  	if (!fwreq) {
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22  4539  		ret = -ENOMEM;
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22  4540  		goto fail;
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22  4541  	}
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22  4542  
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22 @4543  	ret = brcmf_fw_get_firmwares(sdiodev->dev, fwreq,
bd0e1b1d380efe drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-05-27  4544  				     brcmf_sdio_firmware_callback);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4545  	if (ret != 0) {
bd0e1b1d380efe drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2014-05-27  4546  		brcmf_err("async firmware request failed: %d\n", ret);
d09ae51a4b6761 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Arend Van Spriel 2018-03-22  4547  		kfree(fwreq);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4548  		goto fail;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4549  	}
15d45b6fbd01ec drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Franky Lin       2011-10-21  4550  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4551  	return bus;
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4552  
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4553  fail:
9fbe2a6dc71d85 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2013-12-12  4554  	brcmf_sdio_remove(bus);
b3e8126eb4c102 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c Jacobe Zang      2024-08-28  4555  	return ERR_PTR(ret);
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05 @4556  }
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c      Arend van Spriel 2011-10-05  4557  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

