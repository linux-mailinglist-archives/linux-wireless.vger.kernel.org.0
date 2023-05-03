Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0486F54C3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjECJbo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjECJbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 05:31:42 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F740FD
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1683106281; i=jwollrath@web.de;
        bh=meJGLqfs/Wce4lHXFEvwEhruuhZllUgWWjK8q6/Zt08=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=E/gEMDptCwGz1rUV07Um3IlL37ErP3+Wc3ieV5QvTVC/Jo/k2gfbV1rja5mpnhef6
         EIrLF+n0mxpJ25zwfVvLGO0cHH1ssR31mhyusMmECDMXzlnunWJvWi/gKjyYiMrcX3
         s5CaK/IqeVlaaxfu+ymyQZ2u44g+WRo4utReEcxBSXb4rZdmH2IP4LqSGjHl4Q32xE
         vYYqfkF1Ob4ttLshSBys00tafUsEzK0r5f/L8Ntqc7hUH3HLqWUrlqbb4WSmF/fHyv
         7w/8MVGtLSafUJ0W6dPrGwWEFyX1FvbIZ/3jDpTRl4hu8iPqmQXXjk+M/5DQwe3Pbo
         aTAK73KyT09+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from schienar ([128.141.229.137]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6091-1prfzW1pgh-007UVk; Wed, 03
 May 2023 11:31:21 +0200
Date:   Wed, 3 May 2023 11:31:20 +0200
From:   Julian Wollrath <jwollrath@web.de>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com
Subject: iwlwifi: AX200 wrong regulatory domain information content
Message-ID: <20230503113120.583bc327@schienar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fEEMiD2CpnkzgFBndWTBdZBtTdXTxn5uu895HzUf+Brpoqv0/mF
 pM9Mw0DEKzbF3bORhsIieN9KgR0ysK4ZA2EiY3N8kllTuxI32oheeR0q0qB+36IPjqQXwNf
 lduJUZIQ+JCzDWx6gYthfTiNu69re/nfmT4A3kU0ki8bsuI9S8GK85ihu8RaGhlFI7rM/ZF
 5E1SJJO9s33Gw3PewG21A==
UI-OutboundReport: notjunk:1;M01:P0:r98r9Hgug6I=;x+ZZ05Rk/dVmSOcXWeE/bTK5LnP
 IFOdTdEeIdLDkdTe2jNzgilsXHyfrDFjJPYqSDYsEsctbVzgZ4Q9MQTiD0RByVR4/FVT02BR5
 IaayzmH/7fgaJ4+QHFbLBhDcrpKpxdVl4of785m8rQH6qQ2YZ9tS6W/eZfmgCR359a2aiBD6w
 1FNUJVDEqXxYe/SMPgrGaLiFvTGMq5+GNyLQD/XSQ5e0CrImNylC5FjSz37y/KVXl7yopryV1
 mK+l7dh3liUMPOKXjDGYnB0q8I7q6W12byL+I1Nve4ZrcOgZmJHJzqtJmSLHdDGa1o8BlzKZ1
 UibjLeGC1QgNN3JKsTbxNz39kzMBg9pJP5Ts6ZtI4O2RxwImuR4psc+uHut45PS4WpeoKPbgs
 iZ1/8RLM2rFA0ZqHGuwjAod3QcFej9K5DZveZIvOFFeegiHXx6J+mCbTJZpMjPTMqSX2pppkw
 VhOMbUzZEn01oo4Rg96oYunGkdsWSIDhrrW4+mCOvAbN7ZCInulg1mJdClosA8MCD5oM68v1b
 lSZ7MBVORjedkMu6BAuqr3sZoAm46eyGvdALUIZxjq2a0oiE6eYX6BZSJeFCtqkR84P6s3K1F
 A3PEb+5NXfkKza4fJTaEFFkTgi8ZWKDjNbjxsh/jxmgMnxuAff3a/XpGcUl7hqZU8NN6Zzq7m
 tH1V0at+i4nfFbZ9e6k3Jyoz8GrllU5Sjvc13eGg9F8b0EL171aG/q0trCXDmtEGRUrxWqQlG
 G9UIjmqg1y00fevexiy2z3J3hn6IF+w3fCUfwIv4vpsV+PelbRZeV8TO3wstkabsDjDMyVuy9
 +Ao6ZbG4gUGSCDcMTK2erpxuif22BzQMcUplgipiyaZdXe4XYTFmNmtgk0sLz9vZUm2GdPLCv
 zdkpszsPWL3Hz5FYN6gx/aMmO8rYj5xg0ejISZQ/tyWTkpRBjjGsWsJvAjwOG79vWp7Bd8I4n
 Jo2/uvvirXr4UAAdoGKlkjYOb1U=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear intel wireless maintainers,

I am on kernel version 6.3.1 with a Intel AX200 (8086:2723) WLAN device
on firmware version 71.058653f6.0 (see details below). I am in
Switzerland and the country code is also set by the device (see output
of iw reg get below). But the regulatory domain information is wrong, i.e.
i.e. in some bands the allowed transmission power is wrong (e.g. 5725 -
5875, compare with the info frow iw reg get under global or the official
information under https://www.ofcomnet.ch/api/rir/1008/12). Since the
device is self-managed, the correct information from the regulatory domain
database is not used. Can the deviced be forced to use the correct
regulatory domain information from the database or the self-managed
values be changed to be correct?


With best regards,
Julian Wollrath

$ ls /lib/firmware/iwlwifi-cc-a0-*
/lib/firmware/iwlwifi-cc-a0-50.ucode
/lib/firmware/iwlwifi-cc-a0-59.ucode
/lib/firmware/iwlwifi-cc-a0-66.ucode
/lib/firmware/iwlwifi-cc-a0-72.ucode
/lib/firmware/iwlwifi-cc-a0-73.ucode
/lib/firmware/iwlwifi-cc-a0-74.ucode
/lib/firmware/iwlwifi-cc-a0-77.ucode

$ grep iwlwifi /var/log/messages
kernel: [   10.319490] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002=
)
kernel: [   10.341786] iwlwifi 0000:01:00.0: Direct firmware load for iwlw=
ifi-cc-a0-72.ucode failed with error -2
kernel: [   10.345771] iwlwifi 0000:01:00.0: api flags index 2 larger than=
 supported by driver
kernel: [   10.345793] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Ver=
sion: 89.3.35.37
kernel: [   10.346281] iwlwifi 0000:01:00.0: loaded firmware version 71.05=
8653f6.0 cc-a0-71.ucode op_mode iwlmvm
kernel: [   10.500275] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX2=
00 160MHz, REV=3D0x340

$ iw reg get
global
country CH: DFS-ETSI
	(2400 - 2483 @ 40), (N/A, 20), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
	(5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
	(5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
	(5725 - 5875 @ 80), (N/A, 13), (N/A)
	(5945 - 6425 @ 160), (N/A, 23), (N/A), NO-OUTDOOR
	(57000 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country CH: DFS-UNSET
	(2402 - 2437 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-80MHZ, NO-1=
60MHZ
	(2422 - 2462 @ 40), (6, 22), (N/A), AUTO-BW, NO-80MHZ, NO-160MHZ
	(2447 - 2482 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-80MHZ, NO-16=
0MHZ
	(5170 - 5190 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, IR-CONCURRENT, =
NO-HT40MINUS, PASSIVE-SCAN
	(5190 - 5210 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, IR-CONCURRENT, =
NO-HT40PLUS, PASSIVE-SCAN
	(5210 - 5230 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, IR-CONCURRENT, =
NO-HT40MINUS, PASSIVE-SCAN
	(5230 - 5250 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, IR-CONCURRENT, =
NO-HT40PLUS, PASSIVE-SCAN
	(5250 - 5270 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE=
-SCAN
	(5270 - 5290 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-=
SCAN
	(5290 - 5310 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE=
-SCAN
	(5310 - 5330 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-=
SCAN
	(5490 - 5510 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE=
-SCAN
	(5510 - 5530 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-=
SCAN
	(5530 - 5550 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE=
-SCAN
	(5550 - 5570 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-=
SCAN
	(5570 - 5590 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE=
-SCAN
	(5590 - 5610 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-=
SCAN
	(5610 - 5630 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE=
-SCAN
	(5630 - 5650 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-=
SCAN
	(5650 - 5670 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, NO-160MH=
Z, PASSIVE-SCAN
	(5670 - 5690 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, NO-160MHZ=
, PASSIVE-SCAN
	(5690 - 5710 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, NO-160MH=
Z, PASSIVE-SCAN
	(5710 - 5730 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, NO-160MHZ=
, PASSIVE-SCAN
	(5735 - 5755 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-160MHZ
	(5755 - 5775 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-160MHZ
	(5775 - 5795 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-160MHZ
	(5795 - 5815 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-160MHZ
	(5815 - 5835 @ 20), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-HT40PLUS, N=
O-80MHZ, NO-160MHZ


=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
