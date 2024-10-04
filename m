Return-Path: <linux-wireless+bounces-13519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27BF990A20
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 19:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1DFB2147C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F21798C;
	Fri,  4 Oct 2024 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pc8QveiA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842631CACC0
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062856; cv=none; b=tLmduL9xfGn4AXfYHFpBj9sNI+0k44jRX6WHe5MzCHJbP/GI8C5Ou2sJ+8RD9sQAUmyyXCWFZnV+TChnNMGnOBubBdblkfWNBO37CE0tYbT2HvGi0nxOkBNxHfVYdypUMzPHaOEbjrDxjwTcT7B14nsrAmRi+NINEWC9Cxu39GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062856; c=relaxed/simple;
	bh=ZB8O70drrAYOTrmKMZIYTuXNGC1odalrBfVPw3WcQ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPuNvDX3tbqG3Bj0yS8wabYZuTJLLWXHGxz7m5lKjMAoKhNWNe1eNPWRnH7zWS1QpLMughqVezkirq+FMh41iQ4QiG08izhVyjG63s4Ck/zv34CS0iDKmXLuRtFYH22qZVvFMhw+qAF++DzhFa2qIP4k9gedaX0+J6xy8XOORJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pc8QveiA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728062853; x=1759598853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZB8O70drrAYOTrmKMZIYTuXNGC1odalrBfVPw3WcQ3s=;
  b=Pc8QveiANUPI3M84Qv1qFb/3mEnkr4LPx1S/FiwoU9V8lpJKSw75NFkv
   SAF+safYzsAn8cUFeDMQuTvOOtdY5Y4ooZE8o8fnr6tZWhAVtMTMYiANG
   QLFB9i1shwUINlwV7v0P1kbB50UxLoy8NCI85S4o6BLZDloq5t47pCfLa
   flZKOsamFKGPWNOJiD7DLfJwnZqrFgPHHUXqBJCghlG27OluAK7oxygcm
   FRNcePRXPXiI4Rt+ZRKJ6m4Fc7gKbBJyKY0cuFTp+tYJjxnaSs9YW1jbG
   V4nZ383kMkQ6kK5Y37bJVGMiW6Yv6jXWgKnFPDvhTZ4gUYm5PJDOpfAhV
   g==;
X-CSE-ConnectionGUID: fLgp98cZTBKAiC43lNMYfQ==
X-CSE-MsgGUID: 5CVleYKPQbK925LGD1TcSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="44821007"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="44821007"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 10:27:32 -0700
X-CSE-ConnectionGUID: y9cnb6qeQquHjUGFPah79Q==
X-CSE-MsgGUID: Zg+7put0QFO8JeE+/orZbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="98096115"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Oct 2024 10:27:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swm5Q-0001xs-0I;
	Fri, 04 Oct 2024 17:27:28 +0000
Date: Sat, 5 Oct 2024 01:27:14 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, johannes@sipsolutions.net
Subject: Re: [PATCH v2 06/11] wifi: cfg80211: pass net_device to
 .set_monitor_channel
Message-ID: <202410050156.SGRpd8Up-lkp@intel.com>
References: <8f0d4a28a35b7efccc80e71101b38c82de20f6ba.1727942154.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0d4a28a35b7efccc80e71101b38c82de20f6ba.1727942154.git-series.nbd@nbd.name>

Hi Felix,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/wifi-cfg80211-add-option-for-vif-allowed-radios/20241003-160113
base:   5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
patch link:    https://lore.kernel.org/r/8f0d4a28a35b7efccc80e71101b38c82de20f6ba.1727942154.git-series.nbd%40nbd.name
patch subject: [PATCH v2 06/11] wifi: cfg80211: pass net_device to .set_monitor_channel
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241005/202410050156.SGRpd8Up-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050156.SGRpd8Up-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050156.SGRpd8Up-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/wireless/trace.h:13,
                    from net/wireless/rdev-ops.h:13,
                    from net/wireless/core.c:32:
   net/wireless/trace.h: In function 'trace_rdev_set_monitor_channel':
>> net/wireless/trace.h:1323:24: error: passing argument 3 of '(({...}))' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
         |                        |
         |                        struct cfg80211_chan_def *
   include/linux/tracepoint.h:172:61: note: in definition of macro '__DO_TRACE_CALL'
     172 |                         static_call(tp_func_##name)(__data, args);      \
         |                                                             ^~~~
   include/linux/tracepoint.h:217:39: note: in expansion of macro 'TP_ARGS'
     217 |                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
         |                                       ^~~~~~~
   include/linux/tracepoint.h:258:25: note: in expansion of macro '__DO_TRACE'
     258 |                         __DO_TRACE(name,                                \
         |                         ^~~~~~~~~~
   include/linux/tracepoint.h:259:33: note: in expansion of macro 'TP_ARGS'
     259 |                                 TP_ARGS(args),                          \
         |                                 ^~~~~~~
   include/linux/tracepoint.h:433:9: note: in expansion of macro '__DECLARE_TRACE'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:433:46: note: in expansion of macro 'PARAMS'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |                                              ^~~~~~
   include/linux/tracepoint.h:567:9: note: in expansion of macro 'DECLARE_TRACE'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/linux/tracepoint.h:567:44: note: in expansion of macro 'PARAMS'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                                            ^~~~~~
   net/wireless/trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
   net/wireless/trace.h:1323:24: note: expected 'struct net_device *' but argument is of type 'struct cfg80211_chan_def *'
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
   include/linux/tracepoint.h:172:61: note: in definition of macro '__DO_TRACE_CALL'
     172 |                         static_call(tp_func_##name)(__data, args);      \
         |                                                             ^~~~
   include/linux/tracepoint.h:217:39: note: in expansion of macro 'TP_ARGS'
     217 |                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
         |                                       ^~~~~~~
   include/linux/tracepoint.h:258:25: note: in expansion of macro '__DO_TRACE'
     258 |                         __DO_TRACE(name,                                \
         |                         ^~~~~~~~~~
   include/linux/tracepoint.h:259:33: note: in expansion of macro 'TP_ARGS'
     259 |                                 TP_ARGS(args),                          \
         |                                 ^~~~~~~
   include/linux/tracepoint.h:433:9: note: in expansion of macro '__DECLARE_TRACE'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:433:46: note: in expansion of macro 'PARAMS'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |                                              ^~~~~~
   include/linux/tracepoint.h:567:9: note: in expansion of macro 'DECLARE_TRACE'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/linux/tracepoint.h:567:44: note: in expansion of macro 'PARAMS'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                                            ^~~~~~
   net/wireless/trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
   In file included from include/linux/kernel.h:34,
                    from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/if.h:25,
                    from net/wireless/core.c:13:
>> include/linux/static_call_types.h:56:2: error: too few arguments to function '(({...}))'
      56 | ({                                                                      \
         | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |         __STATIC_CALL_ADDRESSABLE(name);                                \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      58 |         __raw_static_call(name);                                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      59 | })
         | ~~
   include/linux/static_call_types.h:90:33: note: in expansion of macro '__static_call'
      90 | #define static_call(name)       __static_call(name)
         |                                 ^~~~~~~~~~~~~
   include/linux/tracepoint.h:172:25: note: in expansion of macro 'static_call'
     172 |                         static_call(tp_func_##name)(__data, args);      \
         |                         ^~~~~~~~~~~
   include/linux/tracepoint.h:217:17: note: in expansion of macro '__DO_TRACE_CALL'
     217 |                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
         |                 ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:258:25: note: in expansion of macro '__DO_TRACE'
     258 |                         __DO_TRACE(name,                                \
         |                         ^~~~~~~~~~
   include/linux/tracepoint.h:433:9: note: in expansion of macro '__DECLARE_TRACE'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:567:9: note: in expansion of macro 'DECLARE_TRACE'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   net/wireless/trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from net/wireless/trace.h:13,
                    from net/wireless/trace.c:5:
   net/wireless/trace.h: In function 'trace_rdev_set_monitor_channel':
>> net/wireless/trace.h:1323:24: error: passing argument 3 of '(({...}))' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
         |                        |
         |                        struct cfg80211_chan_def *
   include/linux/tracepoint.h:172:61: note: in definition of macro '__DO_TRACE_CALL'
     172 |                         static_call(tp_func_##name)(__data, args);      \
         |                                                             ^~~~
   include/linux/tracepoint.h:217:39: note: in expansion of macro 'TP_ARGS'
     217 |                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
         |                                       ^~~~~~~
   include/linux/tracepoint.h:258:25: note: in expansion of macro '__DO_TRACE'
     258 |                         __DO_TRACE(name,                                \
         |                         ^~~~~~~~~~
   include/linux/tracepoint.h:259:33: note: in expansion of macro 'TP_ARGS'
     259 |                                 TP_ARGS(args),                          \
         |                                 ^~~~~~~
   include/linux/tracepoint.h:433:9: note: in expansion of macro '__DECLARE_TRACE'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:433:46: note: in expansion of macro 'PARAMS'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |                                              ^~~~~~
   include/linux/tracepoint.h:567:9: note: in expansion of macro 'DECLARE_TRACE'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/linux/tracepoint.h:567:44: note: in expansion of macro 'PARAMS'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                                            ^~~~~~
   net/wireless/trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
   net/wireless/trace.h:1323:24: note: expected 'struct net_device *' but argument is of type 'struct cfg80211_chan_def *'
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
   include/linux/tracepoint.h:172:61: note: in definition of macro '__DO_TRACE_CALL'
     172 |                         static_call(tp_func_##name)(__data, args);      \
         |                                                             ^~~~
   include/linux/tracepoint.h:217:39: note: in expansion of macro 'TP_ARGS'
     217 |                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
         |                                       ^~~~~~~
   include/linux/tracepoint.h:258:25: note: in expansion of macro '__DO_TRACE'
     258 |                         __DO_TRACE(name,                                \
         |                         ^~~~~~~~~~
   include/linux/tracepoint.h:259:33: note: in expansion of macro 'TP_ARGS'
     259 |                                 TP_ARGS(args),                          \
         |                                 ^~~~~~~
   include/linux/tracepoint.h:433:9: note: in expansion of macro '__DECLARE_TRACE'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:433:46: note: in expansion of macro 'PARAMS'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |                                              ^~~~~~
   include/linux/tracepoint.h:567:9: note: in expansion of macro 'DECLARE_TRACE'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   include/linux/tracepoint.h:567:44: note: in expansion of macro 'PARAMS'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                                            ^~~~~~
   net/wireless/trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
   In file included from include/linux/kernel.h:34,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/tsc.h:10,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from net/wireless/trace.c:1:
>> include/linux/static_call_types.h:56:2: error: too few arguments to function '(({...}))'
      56 | ({                                                                      \
         | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      57 |         __STATIC_CALL_ADDRESSABLE(name);                                \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      58 |         __raw_static_call(name);                                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      59 | })
         | ~~
   include/linux/static_call_types.h:90:33: note: in expansion of macro '__static_call'
      90 | #define static_call(name)       __static_call(name)
         |                                 ^~~~~~~~~~~~~
   include/linux/tracepoint.h:172:25: note: in expansion of macro 'static_call'
     172 |                         static_call(tp_func_##name)(__data, args);      \
         |                         ^~~~~~~~~~~
   include/linux/tracepoint.h:217:17: note: in expansion of macro '__DO_TRACE_CALL'
     217 |                 __DO_TRACE_CALL(name, TP_ARGS(args));                   \
         |                 ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:258:25: note: in expansion of macro '__DO_TRACE'
     258 |                         __DO_TRACE(name,                                \
         |                         ^~~~~~~~~~
   include/linux/tracepoint.h:433:9: note: in expansion of macro '__DECLARE_TRACE'
     433 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |         ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:567:9: note: in expansion of macro 'DECLARE_TRACE'
     567 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~
   net/wireless/trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h: In function '__traceiter_rdev_set_monitor_channel':
>> net/wireless/./trace.h:1323:24: error: passing argument 3 of '(void (*)(void *, struct wiphy *, struct net_device *, struct cfg80211_chan_def *))it_func' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
         |                        |
         |                        struct cfg80211_chan_def *
   include/linux/tracepoint.h:331:77: note: in definition of macro 'DEFINE_TRACE_FN'
     331 |                                 ((void(*)(void *, proto))(it_func))(__data, args); \
         |                                                                             ^~~~
   include/linux/tracepoint.h:342:58: note: in expansion of macro 'PARAMS'
     342 |         DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
         |                                                          ^~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/define_trace.h:28:43: note: in expansion of macro 'PARAMS'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                                           ^~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
   net/wireless/./trace.h:1323:24: note: expected 'struct net_device *' but argument is of type 'struct cfg80211_chan_def *'
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
   include/linux/tracepoint.h:331:77: note: in definition of macro 'DEFINE_TRACE_FN'
     331 |                                 ((void(*)(void *, proto))(it_func))(__data, args); \
         |                                                                             ^~~~
   include/linux/tracepoint.h:342:58: note: in expansion of macro 'PARAMS'
     342 |         DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
         |                                                          ^~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/define_trace.h:28:43: note: in expansion of macro 'PARAMS'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                                           ^~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
>> include/linux/tracepoint.h:331:34: error: too few arguments to function '(void (*)(void *, struct wiphy *, struct net_device *, struct cfg80211_chan_def *))it_func'
     331 |                                 ((void(*)(void *, proto))(it_func))(__data, args); \
         |                                 ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:342:9: note: in expansion of macro 'DEFINE_TRACE_FN'
     342 |         DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
         |         ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from net/wireless/trace.h:4113:
   net/wireless/./trace.h: In function 'trace_raw_output_rdev_set_monitor_channel':
>> net/wireless/./trace.h:135:45: error: 'struct trace_event_raw_rdev_set_monitor_channel' has no member named 'center_freq'; did you mean 'center_freq1'?
     135 | #define CHAN_PR_ARG __entry->band, __entry->center_freq, __entry->freq_offset
         |                                             ^~~~~~~~~~~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:1334:9: note: in expansion of macro 'TP_printk'
    1334 |         TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_PR_FMT,
         |         ^~~~~~~~~
   net/wireless/./trace.h:1335:48: note: in expansion of macro 'CHAN_PR_ARG'
    1335 |                   WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_PR_ARG)
         |                                                ^~~~~~~~~~~
   net/wireless/./trace.h: In function 'trace_event_raw_event_rdev_set_monitor_channel':
>> net/wireless/./trace.h:1323:24: error: passing argument 3 of 'trace_event_get_offsets_rdev_set_monitor_channel' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
         |                        |
         |                        struct cfg80211_chan_def *
   include/trace/trace_events.h:392:71: note: in definition of macro 'DECLARE_EVENT_CLASS'
     392 |         __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
         |                                                                       ^~~~
   include/trace/trace_events.h:42:30: note: in expansion of macro 'PARAMS'
      42 |                              PARAMS(args),                     \
         |                              ^~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
   net/wireless/./trace.h:1321:58: note: expected 'struct net_device *' but argument is of type 'struct cfg80211_chan_def *'
    1321 |         TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
         |                                       ~~~~~~~~~~~~~~~~~~~^~~~~~
   include/trace/trace_events.h:257:65: note: in definition of macro 'DECLARE_EVENT_CLASS'
     257 |         struct trace_event_data_offsets_##call *__data_offsets, proto)  \
         |                                                                 ^~~~~
   include/trace/trace_events.h:41:30: note: in expansion of macro 'PARAMS'
      41 |                              PARAMS(proto),                    \
         |                              ^~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:1321:9: note: in expansion of macro 'TP_PROTO'
    1321 |         TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
         |         ^~~~~~~~
>> include/trace/trace_events.h:392:23: error: too few arguments to function 'trace_event_get_offsets_rdev_set_monitor_channel'
     392 |         __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   include/trace/trace_events.h:256:27: note: declared here
     256 | static inline notrace int trace_event_get_offsets_##call(               \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   In file included from include/trace/define_trace.h:103:
   net/wireless/./trace.h: In function 'perf_trace_rdev_set_monitor_channel':
>> net/wireless/./trace.h:1323:24: error: passing argument 3 of 'trace_event_get_offsets_rdev_set_monitor_channel' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1323 |         TP_ARGS(wiphy, chandef),
         |                        ^~~~~~~
         |                        |
         |                        struct cfg80211_chan_def *
   include/trace/perf.h:31:71: note: in definition of macro 'DECLARE_EVENT_CLASS'
      31 |         __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
         |                                                                       ^~~~
   include/trace/trace_events.h:42:30: note: in expansion of macro 'PARAMS'
      42 |                              PARAMS(args),                     \
         |                              ^~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:1323:9: note: in expansion of macro 'TP_ARGS'
    1323 |         TP_ARGS(wiphy, chandef),
         |         ^~~~~~~
   net/wireless/./trace.h:1321:58: note: expected 'struct net_device *' but argument is of type 'struct cfg80211_chan_def *'
    1321 |         TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
         |                                       ~~~~~~~~~~~~~~~~~~~^~~~~~
   include/trace/trace_events.h:257:65: note: in definition of macro 'DECLARE_EVENT_CLASS'
     257 |         struct trace_event_data_offsets_##call *__data_offsets, proto)  \
         |                                                                 ^~~~~
   include/trace/trace_events.h:41:30: note: in expansion of macro 'PARAMS'
      41 |                              PARAMS(proto),                    \
         |                              ^~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:1321:9: note: in expansion of macro 'TP_PROTO'
    1321 |         TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
         |         ^~~~~~~~
>> include/trace/perf.h:31:23: error: too few arguments to function 'trace_event_get_offsets_rdev_set_monitor_channel'
      31 |         __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   include/trace/trace_events.h:256:27: note: declared here
     256 | static inline notrace int trace_event_get_offsets_##call(               \
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   net/wireless/./trace.h:1320:1: note: in expansion of macro 'TRACE_EVENT'
    1320 | TRACE_EVENT(rdev_set_monitor_channel,
         | ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1323 net/wireless/trace.h

14e8a3c47e8087 Beni Lev      2012-07-31  1319  
14e8a3c47e8087 Beni Lev      2012-07-31  1320  TRACE_EVENT(rdev_set_monitor_channel,
ec6ce719e0b1f5 Felix Fietkau 2024-10-03  1321  	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
683b6d3b31a519 Johannes Berg 2012-11-08  1322  		 struct cfg80211_chan_def *chandef),
683b6d3b31a519 Johannes Berg 2012-11-08 @1323  	TP_ARGS(wiphy, chandef),
14e8a3c47e8087 Beni Lev      2012-07-31  1324  	TP_STRUCT__entry(
14e8a3c47e8087 Beni Lev      2012-07-31  1325  		WIPHY_ENTRY
ec6ce719e0b1f5 Felix Fietkau 2024-10-03  1326  		NETDEV_ENTRY
683b6d3b31a519 Johannes Berg 2012-11-08  1327  		CHAN_DEF_ENTRY
14e8a3c47e8087 Beni Lev      2012-07-31  1328  	),
14e8a3c47e8087 Beni Lev      2012-07-31  1329  	TP_fast_assign(
14e8a3c47e8087 Beni Lev      2012-07-31  1330  		WIPHY_ASSIGN;
ec6ce719e0b1f5 Felix Fietkau 2024-10-03  1331  		NETDEV_ASSIGN;
683b6d3b31a519 Johannes Berg 2012-11-08  1332  		CHAN_DEF_ASSIGN(chandef);
14e8a3c47e8087 Beni Lev      2012-07-31  1333  	),
ec6ce719e0b1f5 Felix Fietkau 2024-10-03  1334  	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_PR_FMT,
ec6ce719e0b1f5 Felix Fietkau 2024-10-03  1335  		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_PR_ARG)
14e8a3c47e8087 Beni Lev      2012-07-31  1336  );
14e8a3c47e8087 Beni Lev      2012-07-31  1337  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

