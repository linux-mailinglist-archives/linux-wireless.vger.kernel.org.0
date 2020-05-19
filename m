Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939591D9320
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 11:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgESJRH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 05:17:07 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58335 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgESJRH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 05:17:07 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04J9Gm9Y2024528, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04J9Gm9Y2024528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 May 2020 17:16:48 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 19 May 2020 17:16:48 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 19 May 2020 17:16:48 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Tue, 19 May 2020 17:16:48 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        kbuild test robot <lkp@intel.com>
CC:     Andy Huang <tehuang@realtek.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [linux-next:master 2957/8703] drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing braces around initializer
Thread-Topic: [linux-next:master 2957/8703]
 drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing braces
 around initializer
Thread-Index: AQHWKazTyqacfl17Z0yHcQkIk0aUJKivJHXg
Date:   Tue, 19 May 2020 09:16:48 +0000
Message-ID: <08fd8d04c2d84d58ac751371cd1c4c1f@realtek.com>
References: <202005141308.j8dUPd66%lkp@intel.com>
 <87blmljuqz.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87blmljuqz.fsf@kamboji.qca.qualcomm.com>
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

Kalle Valo <kvalo@codeaurora.org> writes:

> 
> + linux-wireless
> 
> kbuild test robot <lkp@intel.com> writes:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> master
> > head:   e098d7762d602be640c53565ceca342f81e55ad2
> > commit: 5ad4d8957b69f3ebf95ac02212c388bda75aeb30 [2957/8703]
> rtw88:
> > set power trim according to efuse PG values
> > config: i386-randconfig-a002-20200514 (attached as .config)
> > compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
> > reproduce:
> >         git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
> >         # save the attached .config to linux build tree
> >         make ARCH=i386
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function
> 'rtw8822c_power_trim':
> >>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
> >> missing braces around initializer [-Wmissing-braces]
> > s8 bb_gain[2][8] = {0};
> > ^
> > drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: (near
> > initialization for 'bb_gain[0]') [-Wmissing-braces]
> 
> Tony, please check this and fix it. If it's a false warning please let
> us know.
> 

I tried to re-pro by:
         git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
         # save the attached .config to linux build tree
         make ARCH=i386

But cannot see it. And I checked the code, looks fine to me.
It seems to be a false warning.

Yen-Hsuan
