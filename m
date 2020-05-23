Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A261DF6DA
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgEWLb6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 May 2020 07:31:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:6112 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgEWLb5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 May 2020 07:31:57 -0400
IronPort-SDR: MV5s2//wVBmgJnuFHaixoBfx7hQlPVfRjtGGcSVKUKUpEu0s6FT/2m6bCvb7IkCwGAFoYQo1cN
 Y5xjG/SK9PVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2020 04:31:57 -0700
IronPort-SDR: MjuAy3kXc4oimvECVVyq3Nu7F9h4fpcJrS37Lk2uTU0LGdFGZAlui3/gPXnGWwT1cCKIPYxu+g
 u+hWmvbT7cUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,425,1583222400"; 
   d="scan'208";a="375003278"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2020 04:31:57 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 23 May 2020 04:31:56 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 23 May 2020 04:31:56 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.241]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.245]) with mapi id 14.03.0439.000;
 Sat, 23 May 2020 19:31:54 +0800
From:   "Sang, Oliver" <oliver.sang@intel.com>
To:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>, lkp <lkp@intel.com>
CC:     Andy Huang <tehuang@realtek.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [kbuild-all] Re: [linux-next:master 2957/8703]
 drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing
 braces around initializer
Thread-Topic: [kbuild-all] Re: [linux-next:master 2957/8703]
 drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing
 braces around initializer
Thread-Index: AQHCtP5KVt/tTPVQ+NI5/lIQdR2vYgIFCSEfAwhYSe6osQBbQIAAfGIAgAKZi0A=
Date:   Sat, 23 May 2020 11:31:53 +0000
Message-ID: <F09C421E5D2EBE40AFD7EEA977444DDC4D7B0779@SHSMSX103.ccr.corp.intel.com>
References: <202005141308.j8dUPd66%lkp@intel.com>
 <87blmljuqz.fsf@kamboji.qca.qualcomm.com>
 <08fd8d04c2d84d58ac751371cd1c4c1f@realtek.com>
 <F09C421E5D2EBE40AFD7EEA977444DDC4D77F535@SHSMSX103.ccr.corp.intel.com>
 <06f65d3990b94913a087a215e188cf1a@realtek.com>
In-Reply-To: <06f65d3990b94913a087a215e188cf1a@realtek.com>
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

> From: Tony Chuang <yhchuang@realtek.com>
> 
> >
> > > Kalle Valo <kvalo@codeaurora.org> writes:
> > >
> > > >
> > > > + linux-wireless
> > > >
> > > > kbuild test robot <lkp@intel.com> writes:
> > > >
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > > master
> > > > > head:   e098d7762d602be640c53565ceca342f81e55ad2
> > > > > commit: 5ad4d8957b69f3ebf95ac02212c388bda75aeb30 [2957/8703]
> > > > rtw88:
> > > > > set power trim according to efuse PG values
> > > > > config: i386-randconfig-a002-20200514 (attached as .config)
> > > > > compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
> > > > > reproduce:
> > > > >         git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
> > > > >         # save the attached .config to linux build tree
> > > > >         make ARCH=i386
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > >
> > > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > > >
> > > > > drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function
> > > > 'rtw8822c_power_trim':
> > > > >>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
> > > > >> missing braces around initializer [-Wmissing-braces]
> > > > > s8 bb_gain[2][8] = {0};
> > > > > ^
> > > > > drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
> > > > > (near initialization for 'bb_gain[0]') [-Wmissing-braces]
> > > >
> > > > Tony, please check this and fix it. If it's a false warning please
> > > > let us know.
> > > >
> > >
> > > I tried to re-pro by:
> > >          git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
> > >          # save the attached .config to linux build tree
> > >          make ARCH=i386
> > >
> > > But cannot see it. And I checked the code, looks fine to me.
> > > It seems to be a false warning.
> >
> > Hi, what's your compiler? we can reproduce by gcc-4.9 and follow above steps.
> >
> > From https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119 , the warning
> > should be only on old compilers.
> > If made below change, the warning will disappear.
> > @@ -1036,7 +1036,7 @@ static void rtw8822c_set_power_trim(struct
> > rtw_dev *rtwdev, s8 bb_gain[2][8])  static void
> > rtw8822c_power_trim(struct rtw_dev *rtwdev)  {
> >         u8 pg_pwr = 0xff, i, path, idx;
> > -       s8 bb_gain[2][8] = {0};
> > +       s8 bb_gain[2][8] = {};
> >         u16 rf_efuse_2g[3] = {PPG_2GL_TXAB, PPG_2GM_TXAB,
> > PPG_2GH_TXAB};
> >
> > Similar fix could be seen, as an example, on
> > https://lkml.org/lkml/2017/9/12/159
> >
> 
> Oh, my gcc version is 5.5.0 20171010.
> OK, then I know it should be fixed for old gcc versions.
> Thanks!

Thank you

> 
> Yen-Hsuan
