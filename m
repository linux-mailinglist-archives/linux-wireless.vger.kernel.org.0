Return-Path: <linux-wireless+bounces-37102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEr3DNVAGWpquAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 09:31:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A95FE892
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8AEE302BBA2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EF33342C;
	Fri, 29 May 2026 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efVZxVlK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9083191D3;
	Fri, 29 May 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039837; cv=none; b=bUEsyz4Y4ng/3BEx9K/YZsuqYR7ADcnwZQifVEFjLnBkcRFk6iWWiQqL9CMMcKcofpRvN2RGr/qTjOV1GB1nUN4p3kAgmRMxf7MFp2jFgVt1Akk+vZtYN0O/zbhmz2n6jCK3qA+l9LSzIvf6NqDn5wEKZeqCtbhD8IZYxrk1M1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039837; c=relaxed/simple;
	bh=ClMk5zNyCRJu81M7Srr+gaScjDUvl33BlIAsEzgQIdU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q5qor9fzqFRbLON/yIL5eJkqgpEuYNiWF54J2Rc313D2x1mTT0e49eRLgM9Fb5j+qwKb9j/dRITNx+3mvZtzz3ocvmmJqieQ/FMkJyJtDI/C915qhGqfOxWTRHotB6of0mBk0gKaT1K8MlMZCgxUWy4yAuicalSRbTDOji2mSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efVZxVlK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780039835; x=1811575835;
  h=date:from:to:cc:subject:message-id;
  bh=ClMk5zNyCRJu81M7Srr+gaScjDUvl33BlIAsEzgQIdU=;
  b=efVZxVlKNsuluyd2Se2BWOSsoLALlMGYEaHZJ5dURdWgq2mSCKeUbP9E
   /8XfybSh/vw/ZZknRO1oFIIKCu6bvzYr1lWwJ+Kvo5GsAumQZjeAihJHy
   qzlzIS96gsJcPLntDFZFFHky8P+DW/BPirJ3eHnEARDqVnHDbyxTuskta
   wbYVShfMEv6R+zo/aJZmma+A57vk8cNCc7ucfnWJKWoCEqHV5OyVLD34R
   Qrl0lZIOhSPNBvX7vYkN3RVtyKmM/9RQu+8zXWIB71eqhPF+zGP0DheV7
   oPwfwEJqBGXlno/fsKWwzxB1IDU6fYuXNpgrBtMDHmJnMkCW+mRcUW5ro
   Q==;
X-CSE-ConnectionGUID: l5lsO6UuRxG0lNvkm5K8Iw==
X-CSE-MsgGUID: VmsS6T07QwuEsSuPG1vYdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80883202"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80883202"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 00:30:35 -0700
X-CSE-ConnectionGUID: Z095tQyIRDmG5HMN6Dhl8w==
X-CSE-MsgGUID: +OukO60WTfKSSE7SqzhBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238590460"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 29 May 2026 00:30:33 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSrfr-000000000pp-035s;
	Fri, 29 May 2026 07:30:31 +0000
Date: Fri, 29 May 2026 09:30:24 +0200
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 linux-doc@vger.kernel.org
Subject: [wireless-next:main 10/20] htmldocs:
 Documentation/networking/checksum-offloads:157: ./include/linux/skbuff.h:181:
 WARNING: Failed to create a cross reference. A title or caption not found:
 'crc' [ref.ref]
Message-ID: <202605290940.E4u11iiQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.88 / 15.00];
	LONG_SUBJ(1.54)[205];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37102-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Queue-Id: 0C7A95FE892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   e7d6bd24e883bf7c328d73c99bf6bcde19bf5e61
commit: 25bfb3a8edcbadf4d9d27450c547a631e7513f14 [10/20] docs: net: render the checksum comment in checksum-offloads.rst
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260529/202605290940.E4u11iiQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605290940.E4u11iiQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/landlock:550: ./include/uapi/linux/landlock.h:45: ERROR: Unknown target name: "network flags". [docutils]
   Documentation/userspace-api/landlock:550: ./include/uapi/linux/landlock.h:50: ERROR: Unknown target name: "scope flags". [docutils]
   Documentation/userspace-api/landlock:550: ./include/uapi/linux/landlock.h:24: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:559: ./include/uapi/linux/landlock.h:168: ERROR: Unknown target name: "filesystem flags". [docutils]
   Documentation/userspace-api/landlock:559: ./include/uapi/linux/landlock.h:191: ERROR: Unknown target name: "network flags". [docutils]
>> Documentation/networking/checksum-offloads:157: ./include/linux/skbuff.h:181: WARNING: Failed to create a cross reference. A title or caption not found: 'crc' [ref.ref]

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

