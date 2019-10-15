Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D941D6DA0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 05:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfJODXU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 23:23:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33223 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfJODXU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 23:23:20 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9F3NBK0004972, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9F3NBK0004972
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 11:23:12 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Tue, 15 Oct
 2019 11:23:12 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Subject: RE: [PATCH 00/10] rtw88: minor throughput improvement
Thread-Topic: [PATCH 00/10] rtw88: minor throughput improvement
Thread-Index: AQHVfbFc26VWAFzfcEe2tMzpR0n4B6dZ7MldgAEnPJA=
Date:   Tue, 15 Oct 2019 03:23:10 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18FDB17@RTITMBSVM04.realtek.com.tw>
References: <20191008082101.2494-1-yhchuang@realtek.com>
 <87mue3fyoo.fsf@tynnyri.adurom.net>
In-Reply-To: <87mue3fyoo.fsf@tynnyri.adurom.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Kalle Valo 
> 
> <yhchuang@realtek.com> writes:
> 
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > This patchset mainly adds support for beamforming and power
> > tracking. Power tracking can monitor the thermal value of
> > the device and adjust corresponding power indexes, to make
> > sure the RF output power is expected.
> >
> > And another thing is to add a debugfs for physical layer
> > information. This is useful when sometimes the environment
> > is too harsh for the device, and provides the activities
> > for us to debug.
> >
> > The rest patches are some minor fixes.
> >
> >
> > Ping-Ke Shih (1):
> >   rtw88: coex: Set 4 slot mode for A2DP
> >
> > Tsang-Shian Lin (1):
> >   rtw88: add phy_info debugfs to show Tx/Rx physical status
> >
> > Tzu-En Huang (6):
> >   rtw88: add power tracking support
> >   rtw88: Enable 802.11ac beamformee support
> >   rtw88: config 8822c multicast address in MAC init flow
> >   rtw88: add set_bitrate_mask support
> >   rtw88: update regulatory settings implementaion
> >   rtw88: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
> >
> > Yan-Hsuan Chuang (2):
> >   rtw88: Use rtw_write8_set to set SYS_FUNC
> >   rtw88: pci: config phy after chip info is setup
> 
> It would be easier for me if you could split the patchsets even more,
> for example fixes into one set and new features into another. That way I
> can apply the fixes faster. (I now applied five fixes from this set)
> 
> And maybe you could even split the new features into smaller sets, or
> maybe even just send them one by one once you have a patch ready
> (especially on bigger features). That would also make it faster to
> review, reviewing big patchsets is pain.
> 
> But whenever you submit, just to use wireless-drivers-next as the
> baseline, and no extra patches on top of. That way it's for git to
> handle conflicts.
> 

Sorry, it my fault to mess them into one patch set.
Will try to split them into more sets.
Thanks.

Yan-Hsuan
