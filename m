Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007FD255307
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 04:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgH1C1J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 22:27:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59260 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgH1C1I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 22:27:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07S2QwWK2018754, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07S2QwWK2018754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Aug 2020 10:26:58 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Aug 2020 10:26:58 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Aug 2020 10:26:58 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::e076:9c5c:7feb:1364]) by
 RTEXMB04.realtek.com.tw ([fe80::e076:9c5c:7feb:1364%3]) with mapi id
 15.01.1779.005; Fri, 28 Aug 2020 10:26:58 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        kernel test robot <lkp@intel.com>
CC:     Andy Huang <tehuang@realtek.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type qualifiers ignored on function return type
Thread-Topic: drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning:
 type qualifiers ignored on function return type
Thread-Index: AQHWfF4UTnmAkkSvPEutQmVesFW8RalMzHSg
Date:   Fri, 28 Aug 2020 02:26:58 +0000
Message-ID: <64a0c445dfe74ec183cc67636a9b6fee@realtek.com>
References: <202008271827.tuwLEqMO%lkp@intel.com>
 <87imd4bc4l.fsf@codeaurora.org>
In-Reply-To: <87imd4bc4l.fsf@codeaurora.org>
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

Hi Andy

> + linux-wireless
> 
> kernel test robot <lkp@intel.com> writes:
> 
> > Hi Tzu-En,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> > head:   15bc20c6af4ceee97a1f90b43c0e386643c071b4
> > commit: f745eb9ca5bf823bc5c0f82a434cefb41c57844e rtw88: 8821c: Add
> 8821CE to Kconfig and Makefile
> > date:   6 weeks ago
> > config: arm-randconfig-r012-20200827 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout f745eb9ca5bf823bc5c0f82a434cefb41c57844e
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0
> make.cross ARCH=arm
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type
> qualifiers ignored on function return type [-Wignored-qualifiers]
> >       71 | static const u8 rtw8821c_get_swing_index(struct rtw_dev
> *rtwdev)
> >          |        ^~~~~
> 
> Tony, please check this.
> 

Andy, please send a patch to fix it.

Thanks,
Yen-Hsuan
