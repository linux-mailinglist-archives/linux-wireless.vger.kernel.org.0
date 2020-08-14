Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BF22446A9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHNI5p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 04:57:45 -0400
Received: from mx01-muc.bfs.de ([193.174.230.67]:46296 "EHLO mx01-muc.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHNI5p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 04:57:45 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2020 04:57:43 EDT
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-muc.bfs.de (Postfix) with ESMTPS id A7F15204EB;
        Fri, 14 Aug 2020 10:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1597394984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4qyJxYn/ovogvflUCd44OAQh57P9+0K5dxbUuNr2sQ=;
        b=1ESe6Lz4/gAzE4/DqbwUp7INokgmMnvEFL/6i212ILgj7UcW6LGdn5I6DOvmfKpIlrp9lw
        1D072clfUAGNTt5c6UOiw0lhXxHbE/XDlx1V/Exf6CsGaoQc/mbfeZMEkI1FEnty17dPQC
        ypjeZcqn069aP6VF3P7CFxkdtd6x/LbPR7tRpww28zxwo5ulQTR0YH8UNoN44/TGoUhNlG
        aKeWOS9hRT4hoAANS4Ws4bw0CiIjvdp2BTU6DaPgLUDPcdpY6wtAoA6bmotOnq1CTcYlM4
        sd1Q4tBeb5ahVnYXzY9UYvhYoIPk+wrgPcIup63tDEcIWMzeBM4DppqJ9lJUqQ==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Fri, 14 Aug
 2020 10:49:44 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.2044.004; Fri, 14 Aug 2020 10:49:43 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Jouni Malinen <jouni@qca.qualcomm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] ath6kl: prevent potential array overflow in
 ath6kl_add_new_sta()
Thread-Topic: [PATCH] ath6kl: prevent potential array overflow in
 ath6kl_add_new_sta()
Thread-Index: AQHWcXw2vbpoc3kmAEWVoUdybkje7Kk3S5kl
Date:   Fri, 14 Aug 2020 08:49:43 +0000
Message-ID: <61e34f670a4845f8b1cbf6f6013f8a35@bfs.de>
References: <20200813141315.GB457408@mwanda>
In-Reply-To: <20200813141315.GB457408@mwanda>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.02
Authentication-Results: mx01-muc.bfs.de;
        none
X-Spamd-Result: default: False [-0.02 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.02)[53.36%]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

nitpicking:

the debugtrace will give the impression that the function is=20
running. perhaps it is more clever to have this after the check.

jm2c,
 wh
________________________________________
Von: kernel-janitors-owner@vger.kernel.org [kernel-janitors-owner@vger.kern=
el.org] im Auftrag von Dan Carpenter [dan.carpenter@oracle.com]
Gesendet: Donnerstag, 13. August 2020 16:13
An: Kalle Valo
Cc: Jakub Kicinski; Jouni Malinen; linux-wireless@vger.kernel.org; kernel-j=
anitors@vger.kernel.org
Betreff: [PATCH] ath6kl: prevent potential array overflow in ath6kl_add_new=
_sta()

The value for "aid" comes from skb->data so Smatch marks it as
untrusted.  If it's invalid then it can result in an out of bounds array
access in ath6kl_add_new_sta().

Fixes: 572e27c00c9d ("ath6kl: Fix AP mode connect event parsing and TIM upd=
ates")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath6kl/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/=
ath/ath6kl/main.c
index 5e7ea838a921..814131a0680a 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -430,6 +430,9 @@ void ath6kl_connect_ap_mode_sta(struct ath6kl_vif *vif,=
 u16 aid, u8 *mac_addr,

        ath6kl_dbg(ATH6KL_DBG_TRC, "new station %pM aid=3D%d\n", mac_addr, =
aid);

+       if (aid < 1 || aid > AP_MAX_NUM_STA)
+               return;
+
        if (assoc_req_len > sizeof(struct ieee80211_hdr_3addr)) {
                struct ieee80211_mgmt *mgmt =3D
                        (struct ieee80211_mgmt *) assoc_info;
--
2.28.0

