Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AAC297166
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750611AbgJWOga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 10:36:30 -0400
Received: from mx08-0057a101.pphosted.com ([185.183.31.45]:54238 "EHLO
        mx08-0057a101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S372730AbgJWOga (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 10:36:30 -0400
X-Greylist: delayed 1795 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 10:36:29 EDT
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
        by mx07-0057a101.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09NE1LGp019836;
        Fri, 23 Oct 2020 16:06:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=to : from : subject
 : cc : message-id : date : mime-version : content-type; s=12052020;
 bh=Mec28ZzRek3yuiBOiG8Z1P4qwiFsoIit0oTeiJ2jLzc=;
 b=M0Wh7w2QmwCyCBDuF9hzOnp6Qd1qTJeoYFOC4AzwR1GtMH3wsEBD43lDKKRC3auebQ1o
 pK6eenYVwPtq63cInwFbFoZTwg8QQKW1rj3xOmz+bDL5ez+M5n4pyPmbJeFnOpkTVmGC
 ayCWfwLiZtYRu17R+30VYdAoaLupjpis+yQWl7enA/zIUP94I1Qcbpqw5ceyYRZaAijp
 1zYmNOtnv+XM/7BYhb7ZsKrgKCB4lD2F/ZXd0g7jLF3zpQwe7cOKGFn/2wSoMHBiLCzF
 MOgITC3DKJfHnH+jiHuKRft2umOifHJxWY+srXCCxdVLdVwwL/NYbtTZuK3Z1Ye0IG7t og== 
Received: from mail.beijerelectronics.com ([195.67.87.131])
        by mx07-0057a101.pphosted.com with ESMTP id 34asjahucg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 16:06:29 +0200
Received: from wsests-s0004.westermo.com (192.168.10.12) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1847.3; Fri, 23 Oct 2020 16:06:27 +0200
Received: from [172.29.80.42] (172.29.100.2) by wsests-s0004.westermo.com
 (192.168.10.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1847.3; Fri, 23
 Oct 2020 16:06:27 +0200
To:     <linux-wireless@vger.kernel.org>
From:   Zefir Kurtisi <zefku@westermo.com>
Subject: [RFT] ath9k: multi-rate-retry fails at HW level
CC:     Felix Fietkau <nbd@nbd.name>, <qca-developer-program@qualcomm.com>
Message-ID: <2a8573d7-6683-3414-a8af-dab460772205@westermo.com>
Date:   Fri, 23 Oct 2020 16:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------B8AD4A121ED763E21333DFEC"
Content-Language: en-US
X-Originating-IP: [172.29.100.2]
X-ClientProxiedBy: wsests-s0004.westermo.com (192.168.10.12) To
 wsests-s0004.westermo.com (192.168.10.12)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--------------B8AD4A121ED763E21333DFEC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

I am running into a strange issue with the ath9k operating a 9590 device which to
me seems like a HW issue, but since work on rate controllers is already going for
decades, I hardly can imagine this never showed up.

The issue observed is this: the TX status descriptors never report rateindex 1, it
is always 0, 2, or 3, but never 1.

I noticed this by overwriting the rate configuration provided by minstrel to a
static setup, e.g. (7,3)(5,3)(3,3)(1,3), all MCS. The device operates as iperf
client to a connected AP and continuously transmits data. While at that, the
attenuation between the endpoints is gradually increased, expecting to see a
gradual shift in the reported TX status rateindex from 0 to 3. But nada, the
values reported are 0,2, and 3 - never 1.

I double checked that the TX descriptors are correctly set with the rates and
retry counts - all looking sane.

More obvious, after changing the rate configuration to (7,3)(1,3)(5,3)(3,3) the
expectation would be to have either 0 or 1 reported as rateidx, since the
transmission ought to be successful with the lowest rate or never. Again all rates
are reported but 1.

Now the question for me is: what is the HW exactly doing with such a
configuration? Is it skipping the second rate, or is it just reporting wrong?

Both possibilities have great impact, since upper layers (like airtime) use the
returned rateidx to calculate and configure operating parameters at runtime.


If this is a know issue, nevermind and thanks for pointing me to it. Otherwise if
some of you have the named device operational, it would help a lot to get the
issue confirmed. Just apply the attached patch and perform some TX testing in
either attenuation adjustable or varying link condition setups. Whenever a frame
is reported to have been transmitted at a rateidx > 0, the collected stats are
logged, e.g.
MRR: 2: [51029, 0, 4741, 6454]

In essence, the failure is confirmed if the counter for 1 is 0 or very low
compared to higher numbers for 0, 2, or 3.



Cheers,
Zefir

--------------B8AD4A121ED763E21333DFEC
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-ath9k-count-TX-successes-at-rate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-ath9k-count-TX-successes-at-rate.patch"

From 1548245968a97592b39abe1867106a22a30250c8 Mon Sep 17 00:00:00 2001
From: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Date: Fri, 23 Oct 2020 14:31:54 +0200
Subject: [PATCH] ath9k: count TX successes at rate

---
 drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index afb6a2f..de87ce7 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -3074,6 +3074,13 @@ void ath_tx_edma_tasklet(struct ath_softc *sc)
 			ath_dbg(common, XMIT, "Error processing tx status\n");
 			break;
 		}
+/* count number of successful TXes at each rateidx, print stats each time rateidx > 0 */
+static u32 rthist[IEEE80211_TX_MAX_RATES];
+rthist[ts.ts_rateindex]++;
+if (ts.ts_rateindex)
+	printk("MRR: %d: [%d, %d, %d, %d]\n", ts.ts_rateindex,
+		rthist[0], rthist[1], rthist[2], rthist[3]);
+
 
 		/* Process beacon completions separately */
 		if (ts.qid == sc->beacon.beaconq) {
-- 
2.17.1


--------------B8AD4A121ED763E21333DFEC--
