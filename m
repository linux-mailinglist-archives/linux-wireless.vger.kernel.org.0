Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB279C755
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2019 04:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfHZCop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Aug 2019 22:44:45 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:59744 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729217AbfHZCop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Aug 2019 22:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566787484; x=1598323484;
  h=from:to:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=BzEFt8b9wy/Vl7PDQctKswOFZmk7CSwMUpyH2Io/PEM=;
  b=mC9FquS1MrKXCOkAJdtwabZjljYqu0d0mWF5YaeSkkifxXsOReZFDC/u
   iMZ+5yiHSMeEELb61QGXTUdyc60h3L3dOHlsD+LGgcdWXJcn+alxlDAX1
   j6Aaj+W1B6Z0cuIImozzOAq0xXVAE6Sn+S45W3VqCFJ5duJxIFV+aQ4Fd
   c=;
Subject: RE: [PATCH] ath10k: remove TX lock from ath10k_htt_tx_inc_pending
Thread-Topic: [PATCH] ath10k: remove TX lock from ath10k_htt_tx_inc_pending
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 26 Aug 2019 10:44:43 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Aug 2019 10:44:39 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Mon, 26 Aug 2019 10:44:37 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Mon, 26 Aug 2019 10:44:37 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVWoLUu0EcF57GtkCF/PdkQDEHWacMuQEQ
Date:   Mon, 26 Aug 2019 02:44:37 +0000
Message-ID: <4cd30880ae754f5599e6b1a4c1ac6a74@aptaiexm02f.ap.qualcomm.com>
References: <20190824134857.4094-1-erik.stromdahl@gmail.com>
In-Reply-To: <20190824134857.4094-1-erik.stromdahl@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.249.136.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Erik
> Stromdahl
> Sent: Saturday, August 24, 2019 9:49 PM
> To: Kalle Valo <kvalo@qca.qualcomm.com>; linux-wireless@vger.kernel.org;
> ath10k@lists.infradead.org
> Cc: Erik Stromdahl <erik.stromdahl@gmail.com>
> Subject: [EXT] [PATCH] ath10k: remove TX lock from
> ath10k_htt_tx_inc_pending
>=20
> This commit removes the call to ath10k_mac_tx_lock() from
> ath10k_htt_tx_inc_pending() in case the high water mark is reached.
>=20
> ath10k_mac_tx_lock() calls ieee80211_stop_queues() in order to stop
> mac80211 from pushing more TX data to the driver (this is the TX lock).
>=20
> If a driver is trying to fetch an skb from a queue while the queue is
> stopped, ieee80211_tx_dequeue() will return NULL.
>=20
> So, in ath10k_mac_tx_push_txq(), there is a risk that the call to
> ath10k_htt_tx_inc_pending() results in a stop of the mac80211 TX queues
> just before the skb is fetched.
>=20
> This will cause ieee80211_tx_dequeue() to return NULL and
> ath10k_mac_tx_push_txq() to exit prematurely and return -ENOENT.
> Before the function returns ath10k_htt_tx_dec_pending() will be called.
> This call will re-enable the TX queues through ath10k_mac_tx_unlock().
> When ath10k_mac_tx_push_txq() has returned, the TX queue will be
> returned back to mac80211 with ieee80211_return_txq() without the skb
> being properly consumed.
>=20
> Since the TX queues were re-enabled in the error exit path of
> ath10k_mac_tx_push_txq(), mac80211 can continue pushing data to the
> driver. If the hardware does not consume the data, the above mentioned
> case will be repeated over and over.
>=20
> A case when the hardware is not able to transmit the data from the host
> is when a STA has been dis-associated from an AP and has not yet been
> able to re-associate. In this case there will be no TX_COMPL_INDs from
> the hardware, resulting in the TX counter not be decremented.
>=20
> This phenomenon has been observed in both a real and a test setup.
>=20
> In order to fix this, the actual TX locking (the call to
> ath10k_mac_tx_lock()) was removed from ath10k_htt_tx_inc_pending().
> Instead, ath10k_mac_tx_lock() is called separately after the skb has
> been fetched (after the call to ieee80211_tx_dequeue()). At this point
> it is OK to stop the queues.
Is this patch will impact throughput?
>=20
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
