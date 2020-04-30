Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B645D1C0A78
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 00:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgD3Wig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 18:38:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:53781 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgD3Wig (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 18:38:36 -0400
IronPort-SDR: dqkyG3bggd/Ck79VA+/otcEYKX+pINeM0yZa2jwy5urVi5cYxjnJB+3jP+SZYIxgML27NqJOh2
 tKYq0ucIA1Ig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 15:38:35 -0700
IronPort-SDR: G7gUCRLVZSfUGKqK/ZpF3103XgGWQZP33vtln/kzhuFqIpyVCpM3Oj7DpcHw/ZyDPreA/KYzCe
 ldfUdGcchv7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="247341960"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Apr 2020 15:38:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jUHpA-000Bn5-KW; Fri, 01 May 2020 06:38:32 +0800
Date:   Fri, 1 May 2020 06:38:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Miles Hu <milehu@codeaurora.org>
Subject: Re: [PATCH V3 1/3] nl80211: add support for setting fixed HE
 rate/gi/ltf
Message-ID: <202005010643.4LK4hgmF%lkp@intel.com>
References: <20200429145708.25992-1-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429145708.25992-1-john@phrozen.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi John,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mac80211/master]
[also build test WARNING on ath6kl/ath-next v5.7-rc3 next-20200430]
[cannot apply to mac80211-next/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/John-Crispin/nl80211-add-support-for-setting-fixed-HE-rate-gi-ltf/20200430-040802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/wireless/nl80211.c:4440:47: sparse: sparse: incorrect type in return expression (different base types) @@    expected unsigned short @@    got restricted __le16 conunsigned short @@
>> net/wireless/nl80211.c:4440:47: sparse:    expected unsigned short
>> net/wireless/nl80211.c:4440:47: sparse:    got restricted __le16 const [usertype] tx_mcs_80p80
   net/wireless/nl80211.c:4442:47: sparse: sparse: incorrect type in return expression (different base types) @@    expected unsigned short @@    got restricted __le16 conunsigned short @@
   net/wireless/nl80211.c:4442:47: sparse:    expected unsigned short
>> net/wireless/nl80211.c:4442:47: sparse:    got restricted __le16 const [usertype] tx_mcs_160

vim +4440 net/wireless/nl80211.c

  4431	
  4432	static u16 he_get_txmcsmap(struct genl_info *info,
  4433				   const struct ieee80211_sta_he_cap *he_cap)
  4434	{
  4435		struct net_device *dev = info->user_ptr[1];
  4436		struct wireless_dev *wdev = dev->ieee80211_ptr;
  4437	
  4438		switch (wdev->chandef.width) {
  4439		case NL80211_CHAN_WIDTH_80P80:
> 4440			return he_cap->he_mcs_nss_supp.tx_mcs_80p80;
  4441		case NL80211_CHAN_WIDTH_160:
> 4442			return he_cap->he_mcs_nss_supp.tx_mcs_160;
  4443		default:
  4444			break;
  4445		}
  4446		return le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
  4447	}
  4448	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
