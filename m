Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8B620654
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 02:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKHBvp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 20:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKHBvo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 20:51:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E51D1D66D
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 17:51:43 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A81oxvK7027538, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A81oxvK7027538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Nov 2022 09:50:59 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 8 Nov 2022 09:51:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Nov 2022 09:51:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 8 Nov 2022 09:51:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: 8852b: change debug mask of message of no TX resource
Thread-Topic: [PATCH v2] wifi: rtw89: 8852b: change debug mask of message of
 no TX resource
Thread-Index: AQHY8xN6CWZUdm/fEkimHHP3Z4ZYnq40Qsww
Date:   Tue, 8 Nov 2022 01:51:36 +0000
Message-ID: <fc1f2b8dbaab427e85eede5c7783be5e@realtek.com>
References: <20221108014230.11068-1-pkshih@realtek.com>
In-Reply-To: <20221108014230.11068-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/11/7_=3F=3F_10:50:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Tuesday, November 8, 2022 9:43 AM
> To: kvalo@kernel.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [PATCH v2] wifi: rtw89: 8852b: change debug mask of message of no TX resource
> 
> 8852B has smaller TX FIFO than others in WiFi chip, so it would be buffer
> full frequently, but it doesn't affect TX performance. However, it shows
> verbose debug messages with RTW89_DBG_UNEXP mask that is used to indicate
> abnormal behavior, so change debug mask to RTW89_DBG_TXRX for 8852B.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Sorry, I forget to add changelog of v2.

v2: add comment to explain why we change debug mask for certain situations.

> ---
>  drivers/net/wireless/realtek/rtw89/pci.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
> index 07a2e23759f0b..7aa0af18cdd50 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -971,8 +971,10 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
>  	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
>  	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
>  	struct rtw89_pci_tx_wd_ring *wd_ring = &tx_ring->wd_ring;
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
>  	u32 bd_cnt, wd_cnt, min_cnt = 0;
>  	struct rtw89_pci_rx_ring *rx_ring;
> +	enum rtw89_debug_mask debug_mask;
>  	u32 cnt;
> 
>  	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RPQ];
> @@ -996,10 +998,20 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
>  	bd_cnt = rtw89_pci_get_avail_txbd_num(tx_ring);
>  	wd_cnt = wd_ring->curr_num;
>  	min_cnt = min(bd_cnt, wd_cnt);
> -	if (min_cnt == 0)
> -		rtw89_debug(rtwdev, rtwpci->low_power ? RTW89_DBG_TXRX : RTW89_DBG_UNEXP,
> +	if (min_cnt == 0) {
> +		/* This message can be frequently shown in low power mode or
> +		 * high traffic with 8852B, and we have recognized it as normal
> +		 * behavior, so print with mask RTW89_DBG_TXRX in these situations.
> +		 */
> +		if (rtwpci->low_power || chip->chip_id == RTL8852B)
> +			debug_mask = RTW89_DBG_TXRX;
> +		else
> +			debug_mask = RTW89_DBG_UNEXP;
> +
> +		rtw89_debug(rtwdev, debug_mask,
>  			    "still no tx resource after reclaim: wd_cnt=%d bd_cnt=%d\n",
>  			    wd_cnt, bd_cnt);
> +	}
> 
>  out_unlock:
>  	spin_unlock_bh(&rtwpci->trx_lock);
> --
> 2.25.1
> 
> 
> ------Please consider the environment before printing this e-mail.
