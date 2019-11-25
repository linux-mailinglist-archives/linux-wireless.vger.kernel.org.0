Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F25B108FC1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 15:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfKYOWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 09:22:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:43303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfKYOWt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 09:22:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 06:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="211038573"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2019 06:22:47 -0800
Date:   Mon, 25 Nov 2019 22:29:52 +0800
From:   Philip Li <philip.li@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kbuild test robot <lkp@intel.com>, huangwenabc@gmail.com,
        kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        linux-distros@vs.openwall.org, security@kernel.org,
        libertas-dev@lists.infradead.org
Subject: Re: [kbuild-all] Re: [PATCH] libertas: Fix two buffer overflows at
 parsing bss descriptor
Message-ID: <20191125142952.GA4090@intel.com>
References: <20191122052917.11309-1-huangwenabc@gmail.com>
 <201911241536.lyRxx5Oc%lkp@intel.com>
 <0101016ea290854e-f5721fd1-1ca7-49ab-9c10-85277bc46c64-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016ea290854e-f5721fd1-1ca7-49ab-9c10-85277bc46c64-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 25, 2019 at 12:36:50PM +0000, Kalle Valo wrote:
> kbuild test robot <lkp@intel.com> writes:
> 
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on wireless-drivers-next/master]
> > [also build test WARNING on v5.4-rc8 next-20191122]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/huangwenabc-gmail-com/libertas-Fix-two-buffer-overflows-at-parsing-bss-descriptor/20191124-142236
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> > config: sh-allmodconfig (attached as .config)
> > compiler: sh4-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=sh 
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_ibss_join_existing':
> >>> drivers/net/wireless/marvell/libertas/cfg.c:1788:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> 
> I was wondering why I didn't see this mail in patchwork:
> 
> https://patchwork.kernel.org/patch/11257187/
> 
> And then I noticed this:
> 
> X-Patchwork-Hint: ignore
> 
> kbuild team, why are you adding that header? It's really bad for a
thanks for the feedback, early on we received another feedback to suggest
for adding this, refer to https://gitlab.freedesktop.org/patchwork-fdo/patchwork-fdo/issues/21
for detail. Since there's no further input regarding this usage, we keep
that flag. If this is not suitable, we can investigate other way to fullfill
both requirements.

> maintainer like me who uses patchwork actively, it means that all these
> important warnings are not visible in patchwork and can be easily missed
> by the maintainers.
> 
> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
