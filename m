Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855FCDA3FD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 04:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbfJQCnO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 22:43:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60075 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388198AbfJQCnO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 22:43:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9H2h8S9006239, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9H2h8S9006239
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 17 Oct 2019 10:43:08 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Thu, 17 Oct
 2019 10:43:08 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] rtw88: Enable 802.11ac beamformee support
Thread-Topic: [PATCH v2 3/6] rtw88: Enable 802.11ac beamformee support
Thread-Index: AQHVhB3hIIg/wi4LEkSOThhMUyXK+Kdc+cKAgAEmKfA=
Date:   Thu, 17 Oct 2019 02:43:07 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1900CBB@RTITMBSVM04.realtek.com.tw>
References: <20191016123301.2649-1-yhchuang@realtek.com>
 <20191016123301.2649-4-yhchuang@realtek.com>
 <20191016170628.GA206123@google.com>
In-Reply-To: <20191016170628.GA206123@google.com>
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

From: Brian Norris [mailto:briannorris@chromium.org]
> Subject: Re: [PATCH v2 3/6] rtw88: Enable 802.11ac beamformee support
> 
> Hi,
> 
> On Wed, Oct 16, 2019 at 08:32:58PM +0800, yhchuang@realtek.com wrote:
> ...
> > diff --git a/drivers/net/wireless/realtek/rtw88/bf.h
> b/drivers/net/wireless/realtek/rtw88/bf.h
> > new file mode 100644
> > index 000000000000..96a8216dd11f
> > --- /dev/null
> > +++ b/drivers/net/wireless/realtek/rtw88/bf.h
> 
> ...
> 
> > +void rtw_bf_disassoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
> > +		     struct ieee80211_bss_conf *bss_conf);
> > +void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
> > +		  struct ieee80211_bss_conf *bss_conf);
> > +void rtw_bf_init_bfer_entry_mu(struct rtw_dev *rtwdev,
> > +			       struct mu_bfer_init_para *param);
> 
> Not used outside bf.c, so you should make it static in bf.c and drop the
> declaration here.
> 
> > +void rtw_bf_cfg_sounding(struct rtw_dev *rtwdev, struct rtw_vif *vif,
> > +			 enum rtw_trx_desc_rate rate);
> 
> Same.
> 
> > +void rtw_bf_cfg_mu_bfee(struct rtw_dev *rtwdev, struct
> cfg_mumimo_para *param);
> 
> Same.
> 
> > +void rtw_bf_del_bfer_entry_mu(struct rtw_dev *rtwdev);
> 
> Same.
> 
> > +void rtw_bf_del_sounding(struct rtw_dev *rtwdev);
> 
> Same.
> 
> > +void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
> > +			   struct rtw_bfee *bfee);
> > +void rtw_bf_enable_bfee_mu(struct rtw_dev *rtwdev, struct rtw_vif *vif,
> > +			   struct rtw_bfee *bfee);
> > +void rtw_bf_remove_bfee_su(struct rtw_dev *rtwdev, struct rtw_bfee
> *bfee);
> > +void rtw_bf_remove_bfee_mu(struct rtw_dev *rtwdev, struct rtw_bfee
> *bfee);
> > +void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif
> *vif,
> > +			  struct ieee80211_bss_conf *conf);
> > +void rtw_bf_phy_init(struct rtw_dev *rtwdev);
> > +void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
> > +			 u8 fixrate_en, u8 *new_rate);
> > +#endif
> 

OK, that should be static if not being used.
Will send a v3 to fix them.

Yan-Hsuan
