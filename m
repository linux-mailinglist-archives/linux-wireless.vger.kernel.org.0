Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AA6C9F38
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjC0JUA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjC0JT7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 05:19:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4DD3AA9
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 02:19:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32R9JQWu8013636, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32R9JQWu8013636
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Mar 2023 17:19:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 27 Mar 2023 17:19:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Mar 2023 17:19:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 27 Mar 2023 17:19:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes Sorensen" <Jes.Sorensen@gmail.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
Thread-Topic: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to
 update_rate_mask
Thread-Index: AQHZXOKii0d8HuoRPkCJFbimooDKPK8N4b3ggAB0avWAAAkb4A==
Date:   Mon, 27 Mar 2023 09:19:41 +0000
Message-ID: <b6e5ee31095549268987185d276e3e7c@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
        <20230322171905.492855-8-martin.kaistra@linutronix.de>
        <b48af4c2e9ef4555997b4a6388fdd270@realtek.com> <87lejitwlf.fsf@kernel.org>
In-Reply-To: <87lejitwlf.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, March 27, 2023 4:42 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Martin Kaistra <martin.kaistra@linutronix.de>; linux-wireless@vger.kernel.org; Jes Sorensen
> <Jes.Sorensen@gmail.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: Re: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> >> -----Original Message-----
> >> From: Martin Kaistra <martin.kaistra@linutronix.de>
> >> Sent: Thursday, March 23, 2023 1:19 AM
> >> To: linux-wireless@vger.kernel.org
> >> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
> >> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
> >> <bigeasy@linutronix.de>
> >> Subject: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
> >>
> >> The HW maintains a rate_mask for each connection, referenced by the
> >> macid. Add a parameter to update_rate_mask and add the macid to the
> >> h2c call in the gen2 implementation.
> >>
> >> Also extend refresh_rate_mask to generate the macid in AP mode from
> >> sta->aid.
> >
> > Firmware can support 32 mac_id (station instance) at most, so it will be a
> > problem if hostapd assigns aid more than 32. Though I'm not clear how
> > hostpad assigns the aid, it would be always safe that rtl8xxxu maintains
> > mac_id by a bitmap in driver.
> 
> Does rtlw8xxxu set struct wiphy::max_ap_assoc_sta? It would be good to
> advertise the user space the maximum number of stations.
> 

Thanks for this information, Kalle.

Martin, please add this. I think we can preserve at least one mac_id for
broadcast/multicast frames. In fact, I'm not absolutely sure we can
support up to 32 mac_id, so set wiphy::max_ap_assoc_sta = 16 -1 or -2
would be safer.

Ping-Ke


