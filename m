Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A9255305
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 04:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgH1C0B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 22:26:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59132 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgH1C0B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 22:26:01 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07S2PldD6018559, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07S2PldD6018559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Aug 2020 10:25:47 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Aug 2020 10:25:47 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Aug 2020 10:25:47 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::e076:9c5c:7feb:1364]) by
 RTEXMB04.realtek.com.tw ([fe80::e076:9c5c:7feb:1364%3]) with mapi id
 15.01.1779.005; Fri, 28 Aug 2020 10:25:47 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        kernel test robot <lkp@intel.com>
CC:     Kevin Yang <kevin_yang@realtek.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no previous prototype for 'rtw_pci_probe'
Thread-Topic: drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no
 previous prototype for 'rtw_pci_probe'
Thread-Index: AQHWYnAq5+kmvVKwgE+h5UOW6tJm76lM/yug
Date:   Fri, 28 Aug 2020 02:25:46 +0000
Message-ID: <a3a708a0d8094b7895065d17e5396b82@realtek.com>
References: <202007251817.x5EF2Aoc%lkp@intel.com>
 <87eensbc31.fsf@codeaurora.org>
In-Reply-To: <87eensbc31.fsf@codeaurora.org>
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

> + linux-wireless
> 
> kernel test robot <lkp@intel.com> writes:
> 
> > Hi Zong-Zhe,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> > head:   23ee3e4e5bd27bdbc0f1785eef7209ce872794c7
> > commit: 72f256c2b948622cc45ff8bc0456dd6039d8fe36 rtw88: extract:
> > export symbols about pci interface
> > date:   10 weeks ago
> > config: arc-randconfig-r026-20200725 (attached as .config)
> > compiler: arc-elf-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 72f256c2b948622cc45ff8bc0456dd6039d8fe36
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0
> make.cross ARCH=arc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no
> >>> previous prototype for 'rtw_pci_probe' [-Wmissing-prototypes]
> >     1477 | int rtw_pci_probe(struct pci_dev *pdev,
> >          |     ^~~~~~~~~~~~~
> >>> drivers/net/wireless/realtek/rtw88/pci.c:1557:6: warning: no
> >>> previous prototype for 'rtw_pci_remove' [-Wmissing-prototypes]
> >     1557 | void rtw_pci_remove(struct pci_dev *pdev)
> >          |      ^~~~~~~~~~~~~~
> >>> drivers/net/wireless/realtek/rtw88/pci.c:1579:6: warning: no
> >>> previous prototype for 'rtw_pci_shutdown' [-Wmissing-prototypes]
> >     1579 | void rtw_pci_shutdown(struct pci_dev *pdev)
> >          |      ^~~~~~~~~~~~~~~~
> 
> Tony, these are older warnings but please also check these.
> 

I think this warning can be ignored, as the commit was going to export
pci symbols for the follow-up patches to use, such as:

f56f08636dda rtw88: extract: make 8723d an individual kernel module
416e87fcc780 rtw88: extract: make 8822b an individual kernel module
ba0fbe236fb8 rtw88: extract: make 8822c an individual kernel module

And these patches were submitted and applied together.

Thanks,
Yen-Hsuan
