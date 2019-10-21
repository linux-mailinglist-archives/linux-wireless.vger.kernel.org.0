Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C22DF7E1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 00:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfJUWO5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 18:14:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:1655 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfJUWO5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 18:14:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 15:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; 
   d="scan'208";a="196249108"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2019 15:14:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iMfx0-0003vx-Q4; Tue, 22 Oct 2019 06:14:54 +0800
Date:   Tue, 22 Oct 2019 06:14:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v4 2/4] mac80211: Import airtime calculation code from
 mt76
Message-ID: <201910220654.AzuMkFgk%lkp@intel.com>
References: <157148503639.2989444.8337290298332344733.stgit@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157148503639.2989444.8337290298332344733.stgit@toke.dk>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi "Toke,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mac80211-next/master]
[cannot apply to v5.4-rc4 next-20191021]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Toke-H-iland-J-rgensen/Add-Airtime-Queue-Limits-AQL-to-mac80211/20191021-234455
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/mac80211/airtime.c:211:5: sparse: sparse: symbol 'ieee80211_calc_rx_airtime' was not declared. Should it be static?
>> net/mac80211/airtime.c:282:5: sparse: sparse: symbol 'ieee80211_calc_tx_airtime_rate' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
