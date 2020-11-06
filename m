Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011042A93D9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgKFKNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:13:02 -0500
Received: from mout01.posteo.de ([185.67.36.65]:42249 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFKNC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:13:02 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 95E4516005F
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 11:12:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1604657577; bh=mrgkDtqe0IdcsrZcdb7dmQmh5URjnJ2bbhAn1rYd5U8=;
        h=To:From:Subject:Date:From;
        b=Tpm7kqwYTAiAu+jcfsRPoY21QNN1/pbGK9ImXdL2yr3VKl/8ybi2HWr9iz9vqdHuP
         5Rx37FJ/8jZ1OdxlqDEM4W4BWg256m+YktjLlGI/80yW7ajCSiitBmM7ifP1Qpsp97
         HoKqHt2EiLgT08vDCxbkJta3mswF9IPxJdc7paUTlpzjEm9xMqpt0SoVcCabW9KoDL
         wWNwEcbU7k5aQX6Vo7REq+9bS3z8PBMLwL8xgzBMOPGqRHO3i8Tkjru3sFDfPGscbE
         wdxW+QEnia0Y8X6Lj1HOkl06ojCFr/ztcAyRIeU3Jp8aioNmRnxIROSRpksbNrQTBI
         cmEs1VN8Mr6Vg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CSGRV46B8z9rxq;
        Fri,  6 Nov 2020 11:12:54 +0100 (CET)
To:     amitkarwar@gmail.com, siva8118@gmail.com, kvalo@codeaurora.org,
        kuba@kernel.org, linux-wireless@vger.kernel.org, marex@denx.de,
        kernel@puri.sm, siva.rebbagondla@redpinesignals.com,
        fariyaf@gmail.com, jahnavi.meher@gmail.com,
        prameela.j04cs@gmail.com, amit.karwar@redpinesignals.com,
        karun256@gmail.com
From:   Martin Kepplinger <martink@posteo.de>
Subject: rsi: unusably slow / no tx
Message-ID: <f909c001-e91a-1292-1239-18e41cbc693c@posteo.de>
Date:   Fri, 6 Nov 2020 11:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hi,

I start the driver with options rsi_sdio dev_oper_mode=13 and (try to) 
connect to a usual wpa2 encrypted network:

The rsi driver is unusably slow for me still. It slowly (sometimes) 
connects to a network, but even then it's unusable. To me it seems like 
the drivers sends way too little; tx() that is registered with mac80211 
is rarely called - just 4 times in the below logs (where other drivers 
would send data for each received packet afaik).

Thanks a lot Marek for working on the driver! I already use 
https://lore.kernel.org/netdev/20201015111616.429220-1-marex@denx.de/ here.

Does anyone actually use the driver or at least has seen similar 
behaviour, or even know what could go wrong?


So I added messages at a few spots in the rx/tx path and this is while 
connected to a network (without doing much):

[  124.277947] rsi_91x: RX Packet Type: QOS DATA
[  124.377107] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  124.377118] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  124.377123] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  124.377128] rsi_91x: RX Packet Type: BEACON
[  124.377915] rsi_91x: RX Packet Type: QOS DATA
[  124.478435] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  124.478443] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  124.478447] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  124.478451] rsi_91x: RX Packet Type: BEACON
[  124.480417] rsi_91x: RX Packet Type: QOS DATA
[  124.581890] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  124.581899] rsi_91x: rsi_mgmt_pkt_to_core: rssi=32 channel=5
[  124.581902] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  124.581906] rsi_91x: RX Packet Type: BEACON
[  124.582812] rsi_91x: RX Packet Type: QOS DATA
[  124.684240] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  124.684249] rsi_91x: rsi_mgmt_pkt_to_core: rssi=32 channel=5
[  124.684253] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  124.684257] rsi_91x: RX Packet Type: BEACON
[  124.686162] rsi_91x: RX Packet Type: QOS DATA
[  124.786681] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  124.786689] rsi_91x: rsi_mgmt_pkt_to_core: rssi=31 channel=5
[  124.786693] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  124.786697] rsi_91x: RX Packet Type: BEACON
[  124.787938] rsi_91x: RX Packet Type: QOS DATA
[  124.889066] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  124.889075] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  124.889079] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  124.889083] rsi_91x: RX Packet Type: BEACON
[  124.889653] rsi_91x: RX Packet Type: QOS DATA
[  124.990968] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  124.990976] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  124.990980] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  124.990984] rsi_91x: RX Packet Type: BEACON
[  124.993480] rsi_91x: RX Packet Type: QOS DATA
[  125.093930] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.093942] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  125.093946] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.093952] rsi_91x: RX Packet Type: BEACON
[  125.095727] rsi_91x: RX Packet Type: QOS DATA
[  125.196263] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.196273] rsi_91x: rsi_mgmt_pkt_to_core: rssi=34 channel=5
[  125.196277] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.196281] rsi_91x: RX Packet Type: BEACON
[  125.197271] rsi_91x: RX Packet Type: QOS DATA
[  125.298640] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.298649] rsi_91x: rsi_mgmt_pkt_to_core: rssi=32 channel=5
[  125.298652] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.298656] rsi_91x: RX Packet Type: BEACON
[  125.299643] rsi_91x: RX Packet Type: QOS DATA
[  125.401058] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.401068] rsi_91x: rsi_mgmt_pkt_to_core: rssi=31 channel=5
[  125.401072] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.401076] rsi_91x: RX Packet Type: BEACON
[  125.503021] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.503033] rsi_91x: rsi_mgmt_pkt_to_core: rssi=31 channel=5
[  125.503037] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.503043] rsi_91x: RX Packet Type: BEACON
[  125.506415] rsi_91x: RX Packet Type: QOS DATA
[  125.605841] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.605849] rsi_91x: rsi_mgmt_pkt_to_core: rssi=31 channel=5
[  125.605853] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.605857] rsi_91x: RX Packet Type: BEACON
[  125.608029] rsi_91x: RX Packet Type: QOS DATA
[  125.708252] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.708261] rsi_91x: rsi_mgmt_pkt_to_core: rssi=32 channel=5
[  125.708265] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.708268] rsi_91x: RX Packet Type: BEACON
[  125.709203] rsi_91x: RX Packet Type: QOS DATA
[  125.810602] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.810611] rsi_91x: rsi_mgmt_pkt_to_core: rssi=34 channel=5
[  125.810614] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.810619] rsi_91x: RX Packet Type: BEACON
[  125.811462] rsi_91x: RX Packet Type: QOS DATA
[  125.913060] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  125.913073] rsi_91x: rsi_mgmt_pkt_to_core: rssi=36 channel=5
[  125.913077] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  125.913084] rsi_91x: RX Packet Type: BEACON
[  126.014441] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.014455] rsi_91x: rsi_mgmt_pkt_to_core: rssi=36 channel=5
[  126.014459] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.014465] rsi_91x: RX Packet Type: BEACON
[  126.117810] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.117820] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  126.117824] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.117830] rsi_91x: RX Packet Type: BEACON
[  126.220184] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.220194] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  126.220197] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.220201] rsi_91x: RX Packet Type: BEACON
[  126.322626] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.322635] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  126.322638] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.322642] rsi_91x: RX Packet Type: BEACON
[  126.425004] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.425013] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  126.425017] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.425021] rsi_91x: RX Packet Type: BEACON
[  126.425784] rsi_91x: RX Packet Type: QOS DATA
[  126.526894] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.526902] rsi_91x: rsi_mgmt_pkt_to_core: rssi=37 channel=5
[  126.526906] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.526910] rsi_91x: RX Packet Type: BEACON
[  126.528278] rsi_91x: RX Packet Type: QOS DATA
[  126.629794] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.629803] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  126.629806] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.629810] rsi_91x: RX Packet Type: BEACON
[  126.630853] rsi_91x: RX Packet Type: QOS DATA
[  126.732207] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.732217] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  126.732221] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.732225] rsi_91x: RX Packet Type: BEACON
[  126.733031] rsi_91x: RX Packet Type: QOS DATA
[  126.834587] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.834596] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  126.834600] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.834604] rsi_91x: RX Packet Type: BEACON
[  126.835484] rsi_91x: RX Packet Type: QOS DATA
[  126.936996] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  126.937004] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  126.937008] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  126.937011] rsi_91x: RX Packet Type: BEACON
[  126.937771] rsi_91x: RX Packet Type: QOS DATA
[  127.038852] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.038860] rsi_91x: rsi_mgmt_pkt_to_core: rssi=36 channel=5
[  127.038863] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.038867] rsi_91x: RX Packet Type: BEACON
[  127.048340] rsi_91x: RX Packet Type: QOS DATA
[  127.141785] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.141794] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  127.141798] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.141802] rsi_91x: RX Packet Type: BEACON
[  127.143494] rsi_91x: RX Packet Type: QOS DATA
[  127.244166] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.244175] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  127.244178] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.244182] rsi_91x: RX Packet Type: BEACON
[  127.244930] rsi_91x: RX Packet Type: QOS DATA
[  127.346544] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.346552] rsi_91x: rsi_mgmt_pkt_to_core: rssi=37 channel=5
[  127.346556] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.346560] rsi_91x: RX Packet Type: BEACON
[  127.347466] rsi_91x: RX Packet Type: QOS DATA
[  127.448957] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.448965] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  127.448969] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.448973] rsi_91x: RX Packet Type: BEACON
[  127.450759] rsi_91x: RX Packet Type: QOS DATA
[  127.550883] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.550895] rsi_91x: rsi_mgmt_pkt_to_core: rssi=34 channel=5
[  127.550899] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.550905] rsi_91x: RX Packet Type: BEACON
[  127.552690] rsi_91x: RX Packet Type: QOS DATA
[  127.653746] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.653755] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  127.653759] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.653763] rsi_91x: RX Packet Type: BEACON
[  127.654704] rsi_91x: RX Packet Type: QOS DATA
[  127.756126] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.756135] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  127.756138] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.756142] rsi_91x: RX Packet Type: BEACON
[  127.757035] rsi_91x: RX Packet Type: QOS DATA
[  127.858537] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.858546] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  127.858549] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.858553] rsi_91x: RX Packet Type: BEACON
[  127.859516] rsi_91x: RX Packet Type: QOS DATA
[  127.959937] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  127.959949] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  127.959953] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  127.959958] rsi_91x: RX Packet Type: BEACON
[  127.962037] rsi_91x: RX Packet Type: QOS DATA
[  128.062817] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.062826] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  128.062830] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.062834] rsi_91x: RX Packet Type: BEACON
[  128.064199] rsi_91x: RX Packet Type: QOS DATA
[  128.165737] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.165746] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  128.165749] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.165753] rsi_91x: RX Packet Type: BEACON
[  128.183085] rsi_91x: RX Packet Type: QOS DATA
[  128.223550] rsi_91x: rsi_mac80211_tx: calling rsi_core_xmit
[  128.226344] rsi_91x: RX Packet Type: QOS DATA
[  128.268116] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.268125] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  128.268129] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.268132] rsi_91x: RX Packet Type: BEACON
[  128.268793] rsi_91x: RX Packet Type: QOS DATA
[  128.370578] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.370590] rsi_91x: rsi_mgmt_pkt_to_core: rssi=31 channel=5
[  128.370594] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.370599] rsi_91x: RX Packet Type: BEACON
[  128.371840] rsi_91x: RX Packet Type: QOS DATA
[  128.472939] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.472948] rsi_91x: rsi_mgmt_pkt_to_core: rssi=30 channel=5
[  128.472951] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.472955] rsi_91x: RX Packet Type: BEACON
[  128.473766] rsi_91x: RX Packet Type: QOS DATA
[  128.574799] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.574808] rsi_91x: rsi_mgmt_pkt_to_core: rssi=31 channel=5
[  128.574812] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.574816] rsi_91x: RX Packet Type: BEACON
[  128.583857] rsi_91x: RX Packet Type: QOS DATA
[  128.677698] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.677706] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  128.677710] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.677714] rsi_91x: RX Packet Type: BEACON
[  128.680048] rsi_91x: RX Packet Type: QOS DATA
[  128.716215] rsi_91x: rsi_mac80211_tx: calling rsi_core_xmit
[  128.716252] rsi_91x: rsi_mac80211_tx: calling rsi_core_xmit
[  128.780108] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.780117] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  128.780120] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.780125] rsi_91x: RX Packet Type: BEACON
[  128.780938] rsi_91x: RX Packet Type: QOS DATA
[  128.882489] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.882498] rsi_91x: rsi_mgmt_pkt_to_core: rssi=35 channel=5
[  128.882502] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.882506] rsi_91x: RX Packet Type: BEACON
[  128.883508] rsi_91x: RX Packet Type: QOS DATA
[  128.984899] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  128.984908] rsi_91x: rsi_mgmt_pkt_to_core: rssi=34 channel=5
[  128.984912] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  128.984915] rsi_91x: RX Packet Type: BEACON
[  128.985848] rsi_91x: RX Packet Type: QOS DATA
[  129.086567] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  129.086579] rsi_91x: rsi_mgmt_pkt_to_core: rssi=33 channel=5
[  129.086583] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  129.086589] rsi_91x: RX Packet Type: BEACON
[  129.088048] rsi_91x: RX Packet Type: QOS DATA
[  129.189696] rsi_91x: rsi_mgmt_pkt_recv: Msg Len: 333, Msg Type:    2
[  129.189705] rsi_91x: rsi_mgmt_pkt_to_core: rssi=31 channel=5
[  129.189710] rsi_91x: RX Dot11 Mgmt Pkt Type: BEACON
[  129.189715] rsi_91x: RX Packet Type: BEACON
[  129.190978] rsi_91x: RX Packet Type: QOS DATA
[  129.247548] rsi_91x: rsi_mac80211_tx: calling rsi_core_xmit


thanks so much for your time and effort,

                          martin
