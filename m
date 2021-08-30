Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6078C3FB201
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhH3Hj2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 03:39:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50302 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhH3Hj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 03:39:26 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17U7cOXa9010194, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17U7cOXa9010194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 15:38:25 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 30 Aug 2021 15:38:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 30 Aug 2021 15:38:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 30 Aug 2021 15:38:23 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Pkshih <pkshih@realtek.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>, Gary Chang <gary.chang@realtek.com>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: RE: [PATCH v2] mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug
Thread-Topic: [PATCH v2] mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug
Thread-Index: AQHXnWbnzT/X7+iY+0Ogu2bICOnx2auLqKLA
Date:   Mon, 30 Aug 2021 07:38:23 +0000
Message-ID: <7f1c52fa16aa401297bad21d7c0ecdd6@realtek.com>
References: <20210830061728.10332-1-pkshih@realtek.com>
In-Reply-To: <20210830061728.10332-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/8/30_=3F=3F_04:21:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/30/2021 07:14:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165837 [Aug 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 457 457 f9912fc467375383fbac52a53ade5bbe1c769e2a
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/30/2021 07:18:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Ping-Ke Shih [mailto:pkshih@realtek.com]
> Sent: Monday, August 30, 2021 2:17 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; nbd@nbd.name; Gary Chang; Kevin Yang
> Subject: [PATCH v2] mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug
> 
> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> In ieee80211_amsdu_aggregate() set a pointer frag_tail point to the
> end of skb_shinfo(head)->frag_list, and use it to bind other skb in
> the end of this function. But when execute ieee80211_amsdu_aggregate()
> ->ieee80211_amsdu_realloc_pad()->pskb_expand_head(), the address of
> skb_shinfo(head)->frag_list will be changed. However, the
> ieee80211_amsdu_aggregate() not update frag_tail after call
> pskb_expand_head(). That will cause the second skb can't bind to the
> head skb appropriately.So we update the address of frag_tail to fix it.
> 
> Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2: an alternative fix to prevent iterating fragment twice.
> ---
>  net/mac80211/tx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 2d1193ed3eb5..fb5e43489b62 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3380,6 +3380,13 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
>  	if (!ieee80211_amsdu_prepare_head(sdata, fast_tx, head))
>  		goto out;
> 
> +       /* While n == 2, frag_tail should be the address of head's frag_list.
> +	* However, head probably re-alloc after ieee80211_amsdu_prepare_head.
> +	* So, re-assign frag_tail again to make sure the correctness.
> +	*/
> +	if (n == 2)
> +		frag_tail = &skb_shinfo(head)->frag_list;
> +

I mess up the coding style and fix it by v3 [1]. Please ignore this patch.

[1] https://lore.kernel.org/linux-wireless/20210830073240.12736-1-pkshih@realtek.com/T/#u

--
Ping-Ke

