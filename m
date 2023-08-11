Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3F778830
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjHKHaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHKHaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 03:30:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0526AB;
        Fri, 11 Aug 2023 00:30:23 -0700 (PDT)
Received: from [192.168.151.20] ([217.224.112.34]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOzjW-1q9QVQ25xE-00PMc5; Fri, 11 Aug 2023 09:30:08 +0200
Message-ID: <eb944f1f-8d7c-5057-35f2-34812907e4d1@online.de>
Date:   Fri, 11 Aug 2023 09:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: [PATCH] wifi: nl80211: avoid NULL-ptr deref after
 cfg80211_cqm_rssi_update
Content-Language: en-US
From:   Max Schulze <max.schulze@online.de>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
 <bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de>
In-Reply-To: <bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:do9exluVpxUqgCt14zbZFktqXqM74KvMmw9JlvSUr2uKLtoAPX3
 N2OkaV/BZGEdsGgWom5xHsnDcACvU3RTGlUPbTE1jDZBaG3G6V1C2U8vmET7Y5MWWsThp6l
 TMwl6Z3R1948qfW/gIDiW/q/j3LM1Pf37Jft9btsuMQzzUwBsZl21P6yBuvpLe0iveZCTRd
 QdWzNFQc/oInYCgSpFdJg==
UI-OutboundReport: notjunk:1;M01:P0:qoKBlb1hWbY=;I8se9gl3J3siyiJt+4w5ZliESsM
 sXtxqImP0kvTeLjsPZTCUDVxVdLgKNjWITvCijBx04HNLiBliNGoKrbBdwZhNlpTLpsr/d0Se
 jbHZjrFG6/PKcJAEaGlFzllWVdZc79SZVyjReVRVelgo8owI5EttvUvZLQc4ik+I6FdHSxdNS
 F2jwS3FAX6t/mVZ9r+ntGqBOTQyzFizlpAiMu99sAliVIJQS2weN+iFY26ZpPMFRqvVhI8Imj
 2SIugS6DrRxlfI2BeOBexrOCFEw/QV07oJ3loqoP51uAy5aXsCP6fnwQP9G//lV2B8d+DeTpS
 UubAPBgQDYvfeEFriC2kyiaip1z8rgx9VT0xJTBYQ894f+Cxj9Nt2E0BiKgbK//yv1D1EbknX
 kKg8JNmYGNmcuk/Oqds4yf07ScXnPKMhNfQK3+DQk90QdA1nMJ+3Yby+xRCo12LqnPEixhAjH
 u5zEmC+ItpQySdk+YAGA6PS2E1BIK8WQ49+rNfakn2BnKk2cuOor0eCFoCVOA38zgy5izR+zx
 IL5r94HlEAWwuhiD435jYp2qecsf7CIYOxC3PBYmhCZSOAWU0ZZWLtHc85pU+y5+18bniS4Sv
 IRK2xWkzH8IPg+t5KuMdFmnt1XEttP9KAO4PmhCJuO2D+PcHmVofTgEADgaID0U1uGrL35MQY
 W4SIk2mm2Exk2bOHgjQY9wB1jdC94v12n9QUQG2+92toi85a3L/xDBjX+2Iw2tyF6CZIGE/Dd
 mfHVUDLfXOatpv70Duxe4SJ9aorQGu3qXbmamsCagz8a3koP5sBjW+moZeftYUuVwYXmmOWPx
 rp6o/fuINosg5wglXY2SkAHl/7VGrlXg+hox+NL4naO0o4y4kWJVxe6yfXdKagYrX55ZUGilv
 8aZFrY7/CSuO6sQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In cfg80211_cqm_rssi_notify, when calling cfg80211_cqm_rssi_update, this might free
the wdev->cqm_config . Check for this when it returns.

This has been observed on brcmfmac, when a RSSI event is generated just right
after disconnecting from AP. Then probing for STA details returns nothing, as
evidenced i.e. by
"ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52".


Signed-off-by: Max Schulze <max.schulze@online.de>
Tested-by: Max Schulze <max.schulze@online.de>
Link: https://lore.kernel.org/linux-wireless/bc3bf8f6-7ad7-bf69-9227-f972dac4e66b@online.de/
---

I have deployed this to 22 systems without issues and eliminating those null-ptr deref.

Example Trace from Problem:

wpa_supplicant[332]: wlan0: CTRL-EVENT-DISCONNECTED bssid=XX:XX:XX:XX:74:1f reason=3 locally_generated=1
brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=0000000017163222
brcmfmac: brcmf_fweh_event_worker event LINK (16) ifidx 0 bsscfg 0 addr xx:xx:xx:xx:74:1f
brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 2
brcmutil: event payload, len=0
brcmfmac: brcmf_is_linkdown Processing link down
brcmfmac: brcmf_notify_connect_status Linkdown
brcmfmac: brcmf_rx_event Enter: mmc1:0001:1: rxp=00000000dcf7c0c0
brcmfmac: brcmf_fweh_event_worker event RSSI (56) ifidx 0 bsscfg 0 addr 00:00:xx:xx:00:50
brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 status 0 reason 0
brcmutil: event payload, len=12
00000000: 00 00 00 00 00 00 00 00 00 00 00 00              ............
brcmfmac: brcmf_notify_rssi LOW rssi=0
brcmfmac: brcmf_cfg80211_del_key key index (0)
brcmfmac: brcmf_cfg80211_del_key Ignore clearing of (never configured) key
brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_NOTFOUND (-30)
brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=tdls_sta_info, len=296, err=-52
brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_BADADDR (-21)
brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=sta_info, len=296, err=-52
ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52
==================================================================
BUG: KASAN: null-ptr-deref in cfg80211_cqm_rssi_notify (/home/r/linux/net/wireless/nl80211.c:19089) cfg80211


 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bcf8e293..b12424382 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19088,7 +19088,7 @@ void cfg80211_cqm_rssi_notify(struct net_device *dev,
 
 		cfg80211_cqm_rssi_update(rdev, dev);
 
-		if (rssi_level == 0)
+		if (rssi_level == 0 && wdev->cqm_config)
 			rssi_level = wdev->cqm_config->last_rssi_event_value;
 	}
 
-- 
2.39.1

