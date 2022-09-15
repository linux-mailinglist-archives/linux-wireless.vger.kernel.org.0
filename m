Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26B05B9BA6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIONPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIONPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 09:15:16 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00FB26570
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1663247709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bT4G5irUGZps49pI6pAlPMSvv0FRqftO3H15oFZQQg8=;
        b=fFYApfLwRWCr3iSOsmcY97/ODsp+gF1mKlMmcBy6yLrzeHfGiG9S4Wz9UGc8MHV8CCOyfL
        VIKLSgsbNebPTATpAheaszj2Ezs3bF/1VfhTJdUyLMVPkJG2RO46Dx/lM44jTQ671qc3V/
        GESyycqrZxZbH/GEd0aKY0Si+4+waok=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2051.outbound.protection.outlook.com [104.47.20.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-274-nE7rfuB0Pv6FL43ZU6kMCQ-1; Thu, 15 Sep 2022 14:15:08 +0100
X-MC-Unique: nE7rfuB0Pv6FL43ZU6kMCQ-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO3P123MB2732.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 15 Sep
 2022 13:15:06 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1066:dd62:379f:a429]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1066:dd62:379f:a429%7]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 13:15:06 +0000
From:   Lech Perczak <lech.perczak@camlingroup.com>
To:     linux-wireless@vger.kernel.org
CC:     =?UTF-8?q?Pawe=C5=82=20Lenkow?= <pawel.lenkow@camlingroup.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Kalle Valo <kvalo@kernel.org>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: [PATCH] wifi: wfx: fix memory corruption by limiting max_rates to 4
Date:   Thu, 15 Sep 2022 15:14:45 +0200
Message-ID: <20220915131445.30600-1-lech.perczak@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BEXP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::15)
 To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO3P123MB2732:EE_
X-MS-Office365-Filtering-Correlation-Id: b5551bee-1fb9-49ee-7ea6-08da971c4edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 7GYY0wAxAtHsd3mgYtrrFLyY14m9A9ixv4i2bGP7d9G+vBld/I7Z9/hdqsXNCijfjdoriER3NT9LMovnaedfV7p2oY44uhXNH7QNJV45h8NXv7+ziMwh1ct/NqvuMiIVouFezfcZBRJvHRKII/5cAevwn8gtIEDyEwB8oqPtKPZHuDvQCa9iIydO+4Uz5VpPowEdwN3xZAxt00OGX06N2YJsIaFKKMGlJcpx/KzmHkyYOKqINlS61lvP9pNR1XAR1o11s9fataAEPX6VPNaHbcA1d2Xj5Gk5PBMY/vS1I4uQD8RA1KtbOkND/pGc6bpJ08ScFJOk0IB2E+k6QlpOVADo3++HLNaR8oABtZeFE1NexXMnSIfGwpQ2gPVNCUQU6I6beElQe97HcY+REUWL6/BLQvBs0s+yHGgE0CJ4ipymsZJTqK39/3Txx+gJZ+Q4Euv4acZrImZ6lZFk4oY8Qu9jO3p4VZbGBaCZRIMsXw3QfXlXr+0qrbPUN8MdM03rW18YZnXDyOh/8TDbbsVPWgthYfEx20LMmHbzABlLiesVw5TX78+RlO8revWzYzQ4FdaD45qmD/8Zj2LnGppzi62wjg4P61cLYUdLmblRTvcs5MDJUPYvenRf5sEYG1cRXqk795mlUemiCiPLRHTPqIgVVOfwdFDmWM32NLtRyh8Lprhc5CzykPVcdXCUFCLlm4Q7q/4y/7HQhNSdSTz+AaIpLBZj1XdZMXWCn0BA9FSO/vNQ1i4sq95lKAIP4Pjx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(346002)(39850400004)(451199015)(316002)(5660300002)(6916009)(38100700002)(8676002)(66476007)(86362001)(66556008)(966005)(1076003)(107886003)(36756003)(6506007)(478600001)(41300700001)(2906002)(6486002)(44832011)(2616005)(66574015)(186003)(83380400001)(52116002)(66946007)(54906003)(4326008)(8936002)(6666004)(6512007);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CDcNKkMIzMp6Z/01+bZSSH7nNpUjOwkZsFtWpjtv9SDMBuEM8jra13hQ9YIB?=
 =?us-ascii?Q?h0Pg+BJaBNSeLBpoy+cphSUOxztPRZ6sRYyQ5BwpmRZmHWkE9NNtXAyQOTWC?=
 =?us-ascii?Q?BvxddcUR5sha6m94OnNTHxIGDXVL7ZYpstrY7EjzEMDtlUjRkpTEJkK5JgZw?=
 =?us-ascii?Q?MhE6sTjURSYNZiep+AX3UEoJdihqFoqsQRoPp7bhGdjKdjpTJy5CHS7zxa1k?=
 =?us-ascii?Q?TwodL8JCwvDnUlKbmfFShmot9zOq0gwgjvkOdolIIF5GsWYyHiimO9oGLzYa?=
 =?us-ascii?Q?KxK6ShhV83UOEhpzpfPOwhSnj2NkhnF9teogs01bH5m3eKDxJWab1YsnlzbQ?=
 =?us-ascii?Q?Jd8HaxKatuKJPjdUq1ndXI8mNjlYZPgByvAndF/PX1QNSpU306ar2woAB3Ga?=
 =?us-ascii?Q?MYYLanCtjf7D2gPsQyG3Ri9JPCZM/WruJb7yvx62eBUj/WbT8VhqIfIgyVSk?=
 =?us-ascii?Q?va2ew0FJxuLRJVLz28A/wdqueZBs5/I/KWezrL8sSo7+AHKq3wkqWMPbkHBH?=
 =?us-ascii?Q?o+rcg7AV3HBRK6OPVu89WeQCEd44GD2RRPLMBbKbj2Z2DGJGErR+i5oYbw55?=
 =?us-ascii?Q?gdSgMSPICA2FHTDR+mWld0U55x7mUMUdhGEcx9S5HZpcT8d6YMrG3F0qU7Za?=
 =?us-ascii?Q?kTw3ucQgeFER1MMM6Uqk7Qs+EzwRYBeRAvuAKI+cDRdEFlc0/h8hkour5Xh4?=
 =?us-ascii?Q?Fx0sXQCz1Rz9osiucyagID/Dz1w1if0rxsDshE1pItp3DHPDl4fxZhSHHpRT?=
 =?us-ascii?Q?ett/QKjLMO9VgQIbqTCQscQ57gjiIAWdbLpickfYtVKe2vrJerXpckFgmWZC?=
 =?us-ascii?Q?jb5t+mfyav3H4Koq+9fTDDOjHmwU+OZaB0ksyZkymLVXJGgY9cwBt0H/+AX5?=
 =?us-ascii?Q?GxLq4Dd+ff+mpWiLgOd59x3i53VaSUueiiDpe75RKeg9XOUDb4qpBrPwvyXy?=
 =?us-ascii?Q?RfGU368zvbWD8LTb24Xy+kn0H3UKNslRYkGkPDtvtwtvhv1wiexB1CA+rOiy?=
 =?us-ascii?Q?nw4Ux2nZn61dpKuxUIMF0iyNgH1IVMfjolZCNpuIu4TGm6cZ84YLhKHbD8uX?=
 =?us-ascii?Q?1LW1ZlzZG3eZ43dWhReWX6a0Iiqt8Bgrw8aCosbSzZLlgzmzAiV4BDrd4s+I?=
 =?us-ascii?Q?Gf57sH5CgzUguUx1OSiHctuj2+e+2R0KcRrW5+AkVSvFAa0oAQnz+qnuzomN?=
 =?us-ascii?Q?byRPT1Td8ZuKFgUFNKUjmKNwzPzDIWGlYRRdyNeAIXtOUc8pC1r+U4M/HEaY?=
 =?us-ascii?Q?4W2asa0uz8L/a4L6IWc8+xM11iqy7QMT2i2A226FsaGzm8Kv9RqXb9VNnh+F?=
 =?us-ascii?Q?hVDUzANKeTAnAqy9GWhtVuMe0UmWzrFOaPUBktgpPt13KaZtxy8gmr+pJe5d?=
 =?us-ascii?Q?cuHL2M3FTLCTb5sPMhcxnt51o4AsPBCrj8gsF4krws5DCea1XfxfuInNqJSf?=
 =?us-ascii?Q?GFJWxbHzI6Rktj55dJ/oVnNp/SxxukCzDfMJmb4h8QvW3hV9e+lQDKSDZmCa?=
 =?us-ascii?Q?L0lCVsPGYTvu+nlogVJdINE4H8MH4N5ynI4wMiSTq0ZK14gcJy692brXRdHm?=
 =?us-ascii?Q?IBU3+77+dpfaeRIuzxAIRFzG3jG/F98WKEPnZLKvabNJQoRqiUMtJWToHih5?=
 =?us-ascii?Q?z9J7H/SqLZpJji6QCdzQCnSy3qa3cXofpEiOMHVypSlW//T/ZjGiAveQUyKn?=
 =?us-ascii?Q?4OD5VQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5551bee-1fb9-49ee-7ea6-08da971c4edd
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 13:15:06.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apARRdOJVInQ3I4VQvMpIsAtIWZCoUVb2pfNq321G0xbCrejcQYEeEZ1Upkr6klENHTv7ymaUR/HR22MA+UevEvJLjiiZxeWR7o2q+pdLdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2732
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

Limit hw->max_rates to not exceed IEEE80211_TX_RATE_TABLE_SIZE (4).

To bring back previous value, the global table size limit needs to be
increased beforehand in mac80211.h, or by limiting the iteration count
in minstrel_ht_update_rates against IEEE80211_TX_RATE_TABLE_SIZE as
well.

Fixes: e16e7f0716a6 ("staging: wfx: instantiate mac80211 data")
Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
Cc: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/all/12e5adcd-8aed-f0f7-70cc-4fb7b656b829@caml=
ingroup.com/

Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/net/wireless/silabs/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/=
silabs/wfx/main.c
index 84d82ddded56..7463fe4b5cae 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -273,7 +273,7 @@ struct wfx_dev *wfx_init_common(struct device *dev, con=
st struct wfx_platform_da
 =09hw->vif_data_size =3D sizeof(struct wfx_vif);
 =09hw->sta_data_size =3D sizeof(struct wfx_sta_priv);
 =09hw->queues =3D 4;
-=09hw->max_rates =3D 8;
+=09hw->max_rates =3D 4;
 =09hw->max_rate_tries =3D 8;
 =09hw->extra_tx_headroom =3D sizeof(struct wfx_hif_msg) + sizeof(struct wf=
x_hif_req_tx) +
 =09=09=09=094 /* alignment */ + 8 /* TKIP IV */;
--=20
2.25.1

