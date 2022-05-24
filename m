Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA07F532072
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 03:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiEXB6I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 21:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiEXB6C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 21:58:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE757C143
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 18:58:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24O1vlKO3027016, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24O1vlKO3027016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 May 2022 09:57:47 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 09:57:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 09:57:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Tue, 24 May 2022 09:57:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH net-next] rtlwifi: 8192de: correct checking of IQK reload
Thread-Topic: [PATCH net-next] rtlwifi: 8192de: correct checking of IQK reload
Thread-Index: AQHYbwaNy449J32cKESOedbVe/9in60supaAgACIZ4A=
Date:   Tue, 24 May 2022 01:57:46 +0000
Message-ID: <bde0fd7c5a1d424f95b19bd4d1e01407@realtek.com>
References: <20220524003750.3989-1-pkshih@realtek.com>
 <20220523184123.4b22fd72@kernel.org>
In-Reply-To: <20220523184123.4b22fd72@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/5/23_=3F=3F_10:53:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, May 24, 2022 9:41 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH net-next] rtlwifi: 8192de: correct checking of IQK reload
> 
> On Tue, 24 May 2022 08:37:50 +0800 Ping-Ke Shih wrote:
> > This mistake is existing since initial commit, and I recall the vendor
> > driver to find correctness.
> >
> > Fixes: ee3db469dd31 ("wifi: rtlwifi: remove always-true condition pointed out by GCC 12")
> 
> Not fair, I did not break this code. My change did not alter
> the functionality.

Will annotate the commit 11 years ago.

> 
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> > This patch should go through net-next tree, because this one is going to fix
> > "wifi: rtlwifi: remove always-true condition pointed out by GCC 12" that only
> > exits in that tree.
> 
> If you want it to go via net-next you must CC netdev@.
> 
> But I don't see any reason to rush it, AFAICS the code was added in
> 2011 - commit 7274a8c22980 ("rtlwifi: rtl8192de: Merge phy routines")
> or so. We waited 11 years to notice, we can wait a few weeks for the
> patch to propagate thru wireless tree.
> 
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> > index 15e6a6aded319..f6ff32658863d 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> > @@ -2386,7 +2386,10 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
> >  			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
> >  				"Just Read IQK Matrix reg for channel:%d....\n",
> >  				channel);
> > -			_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
> > +			if ((rtlphy->iqk_matrix[indexforchannel].
> > +			     value[0][0] != 0)
> > +				/*&&(regea4 != 0) */)
> 
> Please don't add the extra brackets around the condition
> and the commented out code back in.

My patch is to revert your patch and correct single one line.
I will correct the strange coding style as well until your patch appears
in wireless-next.

> 
> > +				_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
> >  					rtlphy->iqk_matrix[
> >  					indexforchannel].value,	0,
> >  					(rtlphy->iqk_matrix[
> ------Please consider the environment before printing this e-mail.
