Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69091DDE52
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 05:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgEVDtY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 23:49:24 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40355 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgEVDtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 23:49:24 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04M3n7nhD009640, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04M3n7nhD009640
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 May 2020 11:49:07 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 11:49:07 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 11:49:06 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Fri, 22 May 2020 11:49:06 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>, lkp <lkp@intel.com>
CC:     Andy Huang <tehuang@realtek.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [kbuild-all] Re: [linux-next:master 2957/8703] drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing braces around initializer
Thread-Topic: [kbuild-all] Re: [linux-next:master 2957/8703]
 drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing braces
 around initializer
Thread-Index: AQHWKazTyqacfl17Z0yHcQkIk0aUJKivJHXggALZVgCAAYZcUA==
Date:   Fri, 22 May 2020 03:49:06 +0000
Message-ID: <06f65d3990b94913a087a215e188cf1a@realtek.com>
References: <202005141308.j8dUPd66%lkp@intel.com>
 <87blmljuqz.fsf@kamboji.qca.qualcomm.com>
 <08fd8d04c2d84d58ac751371cd1c4c1f@realtek.com>
 <F09C421E5D2EBE40AFD7EEA977444DDC4D77F535@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <F09C421E5D2EBE40AFD7EEA977444DDC4D77F535@SHSMSX103.ccr.corp.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> > Kalle Valo <kvalo@codeaurora.org> writes:
> >
> > >
> > > + linux-wireless
> > >
> > > kbuild test robot <lkp@intel.com> writes:
> > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > master
> > > > head:   e098d7762d602be640c53565ceca342f81e55ad2
> > > > commit: 5ad4d8957b69f3ebf95ac02212c388bda75aeb30 [2957/8703]
> > > rtw88:
> > > > set power trim according to efuse PG values
> > > > config: i386-randconfig-a002-20200514 (attached as .config)
> > > > compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
> > > > reproduce:
> > > >         git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
> > > >         # save the attached .config to linux build tree
> > > >         make ARCH=i386
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > >
> > > > drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function
> > > 'rtw8822c_power_trim':
> > > >>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
> > > >> missing braces around initializer [-Wmissing-braces]
> > > > s8 bb_gain[2][8] = {0};
> > > > ^
> > > > drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: (near
> > > > initialization for 'bb_gain[0]') [-Wmissing-braces]
> > >
> > > Tony, please check this and fix it. If it's a false warning please let
> > > us know.
> > >
> >
> > I tried to re-pro by:
> >          git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
> >          # save the attached .config to linux build tree
> >          make ARCH=i386
> >
> > But cannot see it. And I checked the code, looks fine to me.
> > It seems to be a false warning.
> 
> Hi, what's your compiler? we can reproduce by gcc-4.9 and follow above steps.
> 
> From https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119 , the warning
> should be only on old compilers.
> If made below change, the warning will disappear.
> @@ -1036,7 +1036,7 @@ static void rtw8822c_set_power_trim(struct
> rtw_dev *rtwdev, s8 bb_gain[2][8])
>  static void rtw8822c_power_trim(struct rtw_dev *rtwdev)
>  {
>         u8 pg_pwr = 0xff, i, path, idx;
> -       s8 bb_gain[2][8] = {0};
> +       s8 bb_gain[2][8] = {};
>         u16 rf_efuse_2g[3] = {PPG_2GL_TXAB, PPG_2GM_TXAB,
> PPG_2GH_TXAB};
> 
> Similar fix could be seen, as an example, on
> https://lkml.org/lkml/2017/9/12/159
> 

Oh, my gcc version is 5.5.0 20171010.
OK, then I know it should be fixed for old gcc versions.
Thanks!

Yen-Hsuan
