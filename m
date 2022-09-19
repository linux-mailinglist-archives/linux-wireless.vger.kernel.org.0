Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC25BCFEC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiISPDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiISPCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 11:02:42 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2293B3340B
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1663599756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LGI4M3RUU3p4ARLu6M9830vAiWcbiDLtcBkwfZzUpD8=;
        b=Q2Anafizjm9AHQXqZPpfStajmQkvuuLKT3IcuIqKO27kRWTrY5FvSsometd8m19HA02PHW
        ypAK8XXKQ+SufvBYgDEKhgl44H2+ZxEHaTwirZlPBifQshpUwUEtCCNzwlx/9Nt5jJqvA/
        9Hlm1bi4TLsiJtN/qgvIocx11rCkXCc=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2054.outbound.protection.outlook.com [104.47.21.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-308-pe03lZdXPSmvGn__vu00cw-1; Mon, 19 Sep 2022 16:02:35 +0100
X-MC-Unique: pe03lZdXPSmvGn__vu00cw-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LOYP123MB3006.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Mon, 19 Sep
 2022 15:02:33 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1066:dd62:379f:a429]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1066:dd62:379f:a429%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:02:33 +0000
From:   Lech Perczak <lech.perczak@camlingroup.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Lenkow?= <pawel.lenkow@camlingroup.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Peter Seiderer <ps.report@gmx.net>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: [PATCH] mac80211: fix memory corruption in minstrel_ht_update_rates()
Date:   Mon, 19 Sep 2022 17:01:35 +0200
Message-ID: <20220919150135.90785-1-lech.perczak@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO2P265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::17) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LOYP123MB3006:EE_
X-MS-Office365-Filtering-Correlation-Id: 713cf539-09bd-4523-1e7e-08da9a4ffb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 0pE2ZCS0Ac3yW8io1CRbC/Hs3UuD8iOT0r48BzT4aVohdVy5WYwkkg3xHMORTaSShehLm0H7PEAhFelVDnjTfwInlk/HNXb7Oa2MEGxuFrrFrSz/G+93ZFYAYL5BGYVtWyRwQe51I8oXEBf0MTQ1dUwDhJUWxYmu7FU292oD6nmu5LA0CDCANF59xiZv5TIwFLHH4FUjbT4B0zOpIDnXfcDXbvWCzth1A6DKl81bt6Y+Qnd6/NzBQtPXIottrbJ4YURfO8vBKXUPuJaohst48Inr/xSGOFU2KYP0Nu14VvMjTDfE40VSCMoRRwd4Ai0+6ek8wr6YWY1ZBQMCtTCCUov36J383vEqFrIPlvQYIkDsUW+OzOKp+X7RShyBOw0uqsB6cL4NOV3ieszHURhdPG52hG83icehIozOdsuMrxvozrLHcL4MJ+aywiUxHNX8FfvwohTitzqOHbcJisgFznF8xV5cizsPV8Ci1vjT+baEbXtZeZQ6Ac5yBRNGRUULiILeAcKm7nH/FBlKvhIF9nVgHGcavE7Z0yfXDYvwBCFAd6ijH8fh2JzlplUg6x6Lk3YNUxJIoNVja9hDBiIP/HZGMGnQwv6OGemKIN/M9ytDxaX8ac2Pv9B0z1esdoxyAGTM1GfAWS8sADyrfglyAqylgCsv1e0EwbECESsdGF+GiwCus7AwqjP8f7mIKRTOR3tnRmQpT8HsGICrn10amb36UtcWINGI/oW8nY/2wfGcT+p7lOz5ng/jSQS9BLy1l8nXdoui67Qw3SuW6WY/xdMUGosglQZ9gP8AdMQjvN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39850400004)(346002)(376002)(136003)(451199015)(66476007)(36756003)(66556008)(1076003)(2616005)(2906002)(66946007)(38350700002)(38100700002)(4326008)(83380400001)(8936002)(66574015)(186003)(41300700001)(54906003)(107886003)(966005)(478600001)(8676002)(6512007)(86362001)(26005)(316002)(6916009)(6506007)(52116002)(5660300002)(6486002)(44832011);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saREXFmMddHGH3z9KzB1hHZ7yy+TWXuVp2xoJh3x723LJq0cRbygQ3dDKAh/?=
 =?us-ascii?Q?F8v7H9i1NFS7cC22ipQWQeEAJ3iWdCQ5UtEXpYwhyoIN6uhPyIiYIBNai5Dn?=
 =?us-ascii?Q?xPgGDbAGzy+AQTKHRMLTbSqvdhrkMa86BoPqO2spD/C+1RMiApdYGckY6/lb?=
 =?us-ascii?Q?o4JqUFfPSIwWgiJJ+EVO1/3Nb45c0n72br1bvcomU4+vqwHswT0plnudZKzc?=
 =?us-ascii?Q?Bjd6Mf1n71v4oxrq6zNgXg4zYOzu+WNp0zSD46PFMz3TEvHb3RAo8f82F2tN?=
 =?us-ascii?Q?kxM5ROR9NIG5gCkAdmdFCJK8iGd8t858cOlr3HUXddbnXI8L8I1dDbM7zkEC?=
 =?us-ascii?Q?33yYbvgWlWf7LDM+VL/sUuePYg96PvTy2ZYvrcIvDpRa9xy8Nb3jZPnulmJs?=
 =?us-ascii?Q?Hu5fJwJzoDJFBfap6KMSTWvbXh+x/5Fo1VUD0EkxPaBm14uSWK9Njw1w2O7H?=
 =?us-ascii?Q?Mez0u2jt2sGy6rUL4o9OGnLyFO9a9UiJ7NzjiMkfZN2QiesmZIOzXJwvwsSA?=
 =?us-ascii?Q?Qc+3jumJTag6Ocm4I2yNbRFGUscarVYRT6WCqE3U3AntkSHr+TunvvKIut7B?=
 =?us-ascii?Q?7SHANwhGB7X1pPTR1RrSK84cpXtX1/OB5bUZW9HH+sTmjVTmc9iRcqFN/RAX?=
 =?us-ascii?Q?473Y5AumHWi8j/YPZIeYZ4wREFNEL1UYmQVc9Re2hMko8ZXFaF0VctxpowRN?=
 =?us-ascii?Q?Ku+vBDvs01wk5aBabPnm1pI5/joh8GF2M4gwpPsr3UmgE1JmezLk7vky3k7o?=
 =?us-ascii?Q?3Q+iBM/6uupXt1wVdlI5UF8g/pxLi9yTWnR/402amLJQzlP1yFcm1QlfhuiH?=
 =?us-ascii?Q?7pR0BU3f2kj+ky5iIN+tQjT0/HsZWutxtvL/DTOlirgMLhuvmqfnq5oVBS+p?=
 =?us-ascii?Q?qkS4RIUldan4NEyVhYfta/wK7fEkmrDnEKSVjWL2Fe2K9ew9gJz0rVODSuBB?=
 =?us-ascii?Q?QlXVDTEcb/BWcJNfAna3Re410fM31Pak2RD0d+RM1RITIswaHxzk2uhqki8R?=
 =?us-ascii?Q?qCXu7fpR47v6BbKVQS2o5njWBhZyNl9fwvaIilOgClAZDctGyhX2rk82nYpG?=
 =?us-ascii?Q?ligWojachUcqJBYPdtEHG+EdFJh5mQIGW8UL9eM9PHZn+VCkVjL9G+7Zc60W?=
 =?us-ascii?Q?YGnyt1jQ4wPj4IPvsozjYSWnI1kZjR8fy5zfJiMdCK1G7mHFUbUzt0d7x1LR?=
 =?us-ascii?Q?OcRQbMLgayZMLyQDviaTq/6X+Gz/tcEsmoJwqxTO5EajTSzSz70gcKuFDI1M?=
 =?us-ascii?Q?XsrchvxUtuz30ecGQJuYdG9MW3R/7ey4CiWPWuT82osNMw0Y6lWkUPuFomlf?=
 =?us-ascii?Q?zAHz7tMQtLkgCudjyg4EPmMGTsUYFjKO/vR1/0Axb0l5hOMkeqEFdU5v23m4?=
 =?us-ascii?Q?StHsxE7YHMefGmf1YaXqxS0mvxH999rfds974Sh1bvxowdS7RwcB8wQemEp/?=
 =?us-ascii?Q?HI8lzfwfdP17rgxbBaDZzq6UiKlXjeCtEb9A8tMjQiwvh1CeBJn4XgDV9Xxm?=
 =?us-ascii?Q?M26OeZPXAHmtfIf6DSB0IN/+/NhBqkfHbQerIqw7jtbXe8gmw056Ut8VfIr5?=
 =?us-ascii?Q?fgMK39bNeGmMCY/BsQ4sNPmjcBkcgjs7CyoKOtqYdn6qtt581Mvma6YV7GKk?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713cf539-09bd-4523-1e7e-08da9a4ffb50
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:02:33.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc/SbV1YFwkOj9lRLmckojIGiHPkX8L3dmy9gzXp13CS5Vxo0dAM4ReCdOgDZ9hCjTj0Z7WqptgRD/DSm2LdyZgzsq0+WAMO/WY0JpX25Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3006
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>

During our testing of WFM200 module over SDIO on i.MX6Q-based platform,
we discovered a memory corruption on the system, tracing back to the wfx
driver. Using kfence, it was possible to trace it back to the root
cause, which is hw->max_rates set to 8 in wfx_init_common,
while the maximum defined by IEEE80211_TX_TABLE_SIZE is 4.

This causes array out-of-bounds writes during updates of the rate table,
as seen below:

BUG: KFENCE: memory corruption in kfree_rcu_work+0x320/0x36c

Corrupted memory at 0xe0a4ffe0 [ 0x03 0x03 0x03 0x03 0x01 0x00 0x00
0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
kfree_rcu_work+0x320/0x36c
process_one_work+0x3ec/0x920
worker_thread+0x60/0x7a4
kthread+0x174/0x1b4
ret_from_fork+0x14/0x2c
0x0

kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=3D32, cache=3Dkmalloc-64

allocated by task 297 on cpu 0 at 631.039555s:
minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
rate_control_tx_status+0xb4/0x148 [mac80211]
ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
ieee80211_tx_status+0xe0/0x118 [mac80211]
ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
tasklet_action_common.constprop.0+0x11c/0x148
__do_softirq+0x1a4/0x61c
irq_exit+0xcc/0x104
call_with_stack+0x18/0x20
__irq_svc+0x80/0xb0
wq_worker_sleeping+0x10/0x100
wq_worker_sleeping+0x10/0x100
schedule+0x50/0xe0
schedule_timeout+0x2e0/0x474
wait_for_completion+0xdc/0x1ec
mmc_wait_for_req_done+0xc4/0xf8
mmc_io_rw_extended+0x3b4/0x4ec
sdio_io_rw_ext_helper+0x290/0x384
sdio_memcpy_toio+0x30/0x38
wfx_sdio_copy_to_io+0x88/0x108 [wfx]
wfx_data_write+0x88/0x1f0 [wfx]
bh_work+0x1c8/0xcc0 [wfx]
process_one_work+0x3ec/0x920
worker_thread+0x60/0x7a4
kthread+0x174/0x1b4
ret_from_fork+0x14/0x2c 0x0

After discussion on the wireless mailing list it was clarified
that the issue has been introduced by:
commit ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
and fix shall be in minstrel_ht_update_rates in rc80211_minstrel_ht.c.

Fixes: ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
Link: https://lore.kernel.org/all/12e5adcd-8aed-f0f7-70cc-4fb7b656b829@caml=
ingroup.com/
Link: https://lore.kernel.org/linux-wireless/20220915131445.30600-1-lech.pe=
rczak@camlingroup.com/
Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Peter Seiderer <ps.report@gmx.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Drobi=C5=84ski <krzysztof.drobinski@camlingroup.com>,
Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 net/mac80211/rc80211_minstrel_ht.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_mins=
trel_ht.c
index 5f27e6746762..788a82f9c74d 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -10,6 +10,7 @@
 #include <linux/random.h>
 #include <linux/moduleparam.h>
 #include <linux/ieee80211.h>
+#include <linux/minmax.h>
 #include <net/mac80211.h>
 #include "rate.h"
 #include "sta_info.h"
@@ -1550,6 +1551,7 @@ minstrel_ht_update_rates(struct minstrel_priv *mp, st=
ruct minstrel_ht_sta *mi)
 {
 =09struct ieee80211_sta_rates *rates;
 =09int i =3D 0;
+=09int max_rates =3D min_t(int, mp->hw->max_rates, IEEE80211_TX_RATE_TABLE=
_SIZE);
=20
 =09rates =3D kzalloc(sizeof(*rates), GFP_ATOMIC);
 =09if (!rates)
@@ -1559,10 +1561,10 @@ minstrel_ht_update_rates(struct minstrel_priv *mp, =
struct minstrel_ht_sta *mi)
 =09minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_tp_rate[0]);
=20
 =09/* Fill up remaining, keep one entry for max_probe_rate */
-=09for (; i < (mp->hw->max_rates - 1); i++)
+=09for (; i < (max_rates - 1); i++)
 =09=09minstrel_ht_set_rate(mp, mi, rates, i, mi->max_tp_rate[i]);
=20
-=09if (i < mp->hw->max_rates)
+=09if (i < max_rates)
 =09=09minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_prob_rate);
=20
 =09if (i < IEEE80211_TX_RATE_TABLE_SIZE)
--=20
2.25.1

