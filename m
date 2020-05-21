Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F5B1DCCF2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgEUMal convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 08:30:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:65237 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgEUMak (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 08:30:40 -0400
IronPort-SDR: Ri2kQQ5Ee31Qf/Rhp5IOqN76k/oJvc+R2XQ3k7ftjdjFtw4B+yqzLtEPmVL0hP/7J0CHPwlg6P
 iTGTNFRczIBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 05:30:40 -0700
IronPort-SDR: LBetqPKyrN8zAaM1h7SkvBJCdVHpS4+r2/QczctwkFpL7B58xkKwzy58nTMTGp1DEfusUoJ53k
 2LFKRC9E0Vsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="268617372"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2020 05:30:40 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 May 2020 05:30:39 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 May 2020 05:30:39 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.241]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.75]) with mapi id 14.03.0439.000;
 Thu, 21 May 2020 20:30:37 +0800
From:   "Sang, Oliver" <oliver.sang@intel.com>
To:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>, lkp <lkp@intel.com>
CC:     Andy Huang <tehuang@realtek.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: RE: [kbuild-all] Re: [linux-next:master 2957/8703]
 drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing
 braces around initializer
Thread-Topic: [kbuild-all] Re: [linux-next:master 2957/8703]
 drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing
 braces around initializer
Thread-Index: AQHCtP5KVt/tTPVQ+NI5/lIQdR2vYgIFCSEfAwhYSe6osQBbQA==
Date:   Thu, 21 May 2020 12:30:36 +0000
Message-ID: <F09C421E5D2EBE40AFD7EEA977444DDC4D77F535@SHSMSX103.ccr.corp.intel.com>
References: <202005141308.j8dUPd66%lkp@intel.com>
 <87blmljuqz.fsf@kamboji.qca.qualcomm.com>
 <08fd8d04c2d84d58ac751371cd1c4c1f@realtek.com>
In-Reply-To: <08fd8d04c2d84d58ac751371cd1c4c1f@realtek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Kalle Valo <kvalo@codeaurora.org> writes:
> 
> >
> > + linux-wireless
> >
> > kbuild test robot <lkp@intel.com> writes:
> >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > master
> > > head:   e098d7762d602be640c53565ceca342f81e55ad2
> > > commit: 5ad4d8957b69f3ebf95ac02212c388bda75aeb30 [2957/8703]
> > rtw88:
> > > set power trim according to efuse PG values
> > > config: i386-randconfig-a002-20200514 (attached as .config)
> > > compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
> > > reproduce:
> > >         git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
> > >         # save the attached .config to linux build tree
> > >         make ARCH=i386
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > > drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function
> > 'rtw8822c_power_trim':
> > >>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
> > >> missing braces around initializer [-Wmissing-braces]
> > > s8 bb_gain[2][8] = {0};
> > > ^
> > > drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: (near
> > > initialization for 'bb_gain[0]') [-Wmissing-braces]
> >
> > Tony, please check this and fix it. If it's a false warning please let
> > us know.
> >
> 
> I tried to re-pro by:
>          git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> But cannot see it. And I checked the code, looks fine to me.
> It seems to be a false warning.

Hi, what's your compiler? we can reproduce by gcc-4.9 and follow above steps.

From https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119 , the warning should be only on old compilers.
If made below change, the warning will disappear.
@@ -1036,7 +1036,7 @@ static void rtw8822c_set_power_trim(struct rtw_dev *rtwdev, s8 bb_gain[2][8])
 static void rtw8822c_power_trim(struct rtw_dev *rtwdev)
 {
        u8 pg_pwr = 0xff, i, path, idx;
-       s8 bb_gain[2][8] = {0};
+       s8 bb_gain[2][8] = {};
        u16 rf_efuse_2g[3] = {PPG_2GL_TXAB, PPG_2GM_TXAB, PPG_2GH_TXAB};

Similar fix could be seen, as an example, on https://lkml.org/lkml/2017/9/12/159


> 
> Yen-Hsuan
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org To unsubscribe send an email to
> kbuild-all-leave@lists.01.org
