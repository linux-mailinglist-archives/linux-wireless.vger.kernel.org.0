Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4C1D15C2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbgEMNiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 09:38:12 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:31887 "EHLO mx02-sz.bfs.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbgEMNiM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 09:38:12 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx02-sz.bfs.de (Postfix) with ESMTPS id 4CE302036A;
        Wed, 13 May 2020 15:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1589377090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZA2nEoSqh2DjvT74Q0ciKIZm6DaJuhkd7LpVsE0u8I=;
        b=AuoVseomCftwvIIiIVjmnErjsHLbEyWa0K+t10urfDUioF4GdDHKBgkn3VS9aM6U93bCnG
        bVlMIPsK/P2X4twYbYmflHrCQE1TcMxs+dVIztq17e0Q0dzZY5+mZseGyGT/Kj2Q72MM+g
        kKKwm+vYvFScVMOdCbtFFPoZO2JNSsnYe/ugdtm8JfpIoF5qNywxu/qvIuUwBtdhgGxwOa
        4kBnI/Mn2Vu7BrU1KFL/8+CoZIpZRfdF6juctB7P3QTdujPVj67iZziSGZoIr851LHtDAh
        ljcIzuw32pu4lzynMzA2UA8zpA3HrXx6RIJ6PVNDqVTgd8yn+lrSPrpBpVgELg==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Wed, 13 May
 2020 15:38:09 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Wed, 13 May 2020 15:38:09 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()
Thread-Topic: [PATCH] rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()
Thread-Index: AQHWKQqIUFdz9Xa4v0qQxm8hInt8X6imAcXl
Date:   Wed, 13 May 2020 13:38:09 +0000
Message-ID: <ba9452bd2cff4888b76fd17ef85a274b@bfs.de>
References: <20200513093951.GD347693@mwanda>
In-Reply-To: <20200513093951.GD347693@mwanda>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.12
Authentication-Results: mx02-sz.bfs.de;
        none
X-Spamd-Result: default: False [-2.12 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.892];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-2.12)[95.75%]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IMHO _rtl_usb_transmit() should not free() either
it should return -1.
The only caller is rtl_usb_tx() where we need a check:

if ( _rtl_usb_transmit()  < 0)
  goto err_free;

but i am confused, rtl_usb_tx() is returning NETDEV_TX_OK in an error case =
?

err_free:
     dev_kfree_skb_any(skb);
      return NETDEV_TX_OK;

hope that helps,
  wh
________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kern=
el.org> im Auftrag von Dan Carpenter <dan.carpenter@oracle.com>
Gesendet: Mittwoch, 13. Mai 2020 11:39:51
An: Ping-Ke Shih; Jussi Kivilinna
Cc: Kalle Valo; linux-wireless@vger.kernel.org; kernel-janitors@vger.kernel=
.org
Betreff: [PATCH] rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()

Seven years ago we tried to fix a leak but actually introduced a double
free instead.  It was an understandable mistake because the code was a
bit confusing and the free was done in the wrong place.  The "skb"
pointer is freed in both _rtl_usb_tx_urb_setup() and _rtl_usb_transmit().
The free belongs _rtl_usb_transmit() instead of _rtl_usb_tx_urb_setup()
and I've cleaned the code up a bit to hopefully make it more clear.

Fixes: 36ef0b473fbf ("rtlwifi: usb: add missing freeing of skbuff")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wirel=
ess/realtek/rtlwifi/usb.c
index 348b0072cdd69..c66c6dc003783 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -881,10 +881,8 @@ static struct urb *_rtl_usb_tx_urb_setup(struct ieee80=
211_hw *hw,

        WARN_ON(NULL =3D=3D skb);
        _urb =3D usb_alloc_urb(0, GFP_ATOMIC);
-       if (!_urb) {
-               kfree_skb(skb);
+       if (!_urb)
                return NULL;
-       }
        _rtl_install_trx_info(rtlusb, skb, ep_num);
        usb_fill_bulk_urb(_urb, rtlusb->udev, usb_sndbulkpipe(rtlusb->udev,
                          ep_num), skb->data, skb->len, _rtl_tx_complete, s=
kb);
@@ -898,7 +896,6 @@ static void _rtl_usb_transmit(struct ieee80211_hw *hw, =
struct sk_buff *skb,
        struct rtl_usb *rtlusb =3D rtl_usbdev(rtl_usbpriv(hw));
        u32 ep_num;
        struct urb *_urb =3D NULL;
-       struct sk_buff *_skb =3D NULL;

        WARN_ON(NULL =3D=3D rtlusb->usb_tx_aggregate_hdl);
        if (unlikely(IS_USB_STOP(rtlusb))) {
@@ -907,8 +904,7 @@ static void _rtl_usb_transmit(struct ieee80211_hw *hw, =
struct sk_buff *skb,
                return;
        }
        ep_num =3D rtlusb->ep_map.ep_mapping[qnum];
-       _skb =3D skb;
-       _urb =3D _rtl_usb_tx_urb_setup(hw, _skb, ep_num);
+       _urb =3D _rtl_usb_tx_urb_setup(hw, skb, ep_num);
        if (unlikely(!_urb)) {
                pr_err("Can't allocate urb. Drop skb!\n");
                kfree_skb(skb);
--
2.26.2

