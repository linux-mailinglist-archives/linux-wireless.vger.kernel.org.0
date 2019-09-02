Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0161DA527A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2019 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfIBJGU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 05:06:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51227 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfIBJGT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 05:06:19 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x829644v009540, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x829644v009540
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 2 Sep 2019 17:06:04 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Mon, 2 Sep
 2019 17:06:04 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "sgruszka@redhat.com" <sgruszka@redhat.com>
Subject: RE: [PATCH 0/8] rtw88: enhance and stabilize T-Put performance
Thread-Topic: [PATCH 0/8] rtw88: enhance and stabilize T-Put performance
Thread-Index: AQHVTQyHs8QWm0j420C8jmKyMDfjhKcYQM2w
Date:   Mon, 2 Sep 2019 09:06:03 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18C2176@RTITMBSVM04.realtek.com.tw>
References: <1565174405-2689-1-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1565174405-2689-1-git-send-email-yhchuang@realtek.com>
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

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> This patch set could enhance and stabilize the throughput
> performance for rtw88, especially for RTL8822CE.
> 
> The RFKs, such as IQK and DPK, can make sure the radio
> components works more reliable. They reduce the distortion
> and nonlinearity that the components inherently have.
> 
> The parameter update is a result that is fine-tuned to
> optimize the hardware utilization.
> 
> And CCK PD can help to adjust CCK signal threshold to
> reduce FAs, and get a better TRX performance in 2.4G.
> 
> Interrupt migration helps some slower platforms not to
> over utilize the host CPU, reduce its loading.
> 
> 
> Chin-Yen Lee (1):
>   rtw88: 8822c: update pwr_seq to v13
> 
> Tsang-Shian Lin (1):
>   rtw88: 8822c: Enable interrupt migration
> 
> Tzu-En Huang (2):
>   rtw88: 8822c: add SW DPK support
>   rtw88: add dynamic cck pd mechanism
> 
> Yan-Hsuan Chuang (4):
>   rtw88: 8822c: update PHY parameter to v38
>   rtw88: 8822c: add FW IQK support
>   rtw88: move IQK/DPK into phy_calibration
>   rtw88: allows to receive AMSDU in AMPDU
> 
>  drivers/net/wireless/realtek/rtw88/coex.c          |    2 +-
>  drivers/net/wireless/realtek/rtw88/coex.h          |    1 +
>  drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +-
>  drivers/net/wireless/realtek/rtw88/main.c          |    1 +
>  drivers/net/wireless/realtek/rtw88/main.h          |   56 +-
>  drivers/net/wireless/realtek/rtw88/phy.c           |  143 +
>  drivers/net/wireless/realtek/rtw88/phy.h           |    2 +
>  drivers/net/wireless/realtek/rtw88/reg.h           |   17 +
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    7 +-
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c      | 1178 +++-
>  drivers/net/wireless/realtek/rtw88/rtw8822c.h      |   86 +
>  .../net/wireless/realtek/rtw88/rtw8822c_table.c    | 6930
> ++++++++++++++------
>  .../net/wireless/realtek/rtw88/rtw8822c_table.h    |    3 +
>  13 files changed, 6323 insertions(+), 2105 deletions(-)
> 
> --
> 2.7.4
> 
> 

This a gentle ping for the series.
Any suggestion is welcome :)

Yan-Hsuan
