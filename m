Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02764F8F7
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 13:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLQMcP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 07:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLQMcN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 07:32:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36C14D36
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 04:32:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BHCB0AP000588;
        Sat, 17 Dec 2022 12:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=dH6lKHP+N56Efa4mWQeA41BtZMU6AF6cA4+ssVullbI=;
 b=AReiDQs5maGthauYqM+pnrEsaoty3U3Nt3SFEPn0krX7skoQQrZBQ2LTdPev/lTXenqG
 BgPYnGo2zyxy2/dyclRm387S8UzS3lP5GNjvn5r+c3JivbaIDF12LTYxvMPlzB7u7oCd
 lqQrfvDWZ/lenejuj5BsiO2mRDyOA88WOq9x/jmNoUpWIBSwG1w2pM89ZvadjegAN/+u
 XsBpC04T9o8OSblEi3s35IHO6+WENkIb75lY6tm9xI7uqm+s07g0MHj2C0ALu3or4ElY
 ACe001+uVaemCO/+xx2eILmHVZeWydPyGrXizj8Mn3BnltfXUTISb3uklcTmDJTFC5HH Vg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh53rrsq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 12:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaJNouSQQLqq8GvhcDMK577c9AISHgdf6V7ofSN+8GKrLYjbglOSjKYkbB/ejNuqibUwBulIxdVIl/fto6Gvo3XegJJUVIMogICe/ie5NubuHXUKWy0OS8iK9PaW/VgBlZzVhEh/Y6nobStiEzDYAEOLwAa97jEqAhg6weafHoPrKOA1OMDu742eHlCxrBabgjyuvQ1Nt6e0lBuNtEhWanRw+anYSoR09F7M7JxMXocBCG99kKmPhXSdCDZ79ONx1c46L3+GMy921AcHZtrg5ztP6T6DeKzXvj+83m1jg+yXuY4vOqftfGSfkSr2yjPdCjEX5slnwu/xw22V6WyABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH6lKHP+N56Efa4mWQeA41BtZMU6AF6cA4+ssVullbI=;
 b=mxgtwDR3cq9gySOC3S4aWwVG0bnp2ArTVdFJhOa2MtcVJ89lRP/IIpPLxInUv/tbV/aFbkrmxl38UbYjZ50Yxi/Ve+2LHz3fBk74XkKcNvIoApUkaT+f7btVdGNVb8ydh0CZWpaVdcOTUTl7P4tAzZbSCSYWxgh2a1OzpXDGSVlAZCGpDP5/StcZ0f8i/aZi/gHstKmy5fkM+vPlwMY2NoatcUfA0cGTGeiRS2EfdRIooZD9LAMnjX3Cgg9ghfyu8s6dGMMEjeIXMoJzto7ZgTY+kT9q2ERH74V9rEzPLgr6pJNydKUhVMHfKfpCrV+yY808TJy1Ak8RwwfOX38Sxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by SA2PR02MB7676.namprd02.prod.outlook.com (2603:10b6:806:145::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Sat, 17 Dec
 2022 12:32:03 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::20e1:e816:c93c:67d8]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::20e1:e816:c93c:67d8%3]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 12:32:03 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: RE: [PATCH v4] wifi: mac80211: fix initialization of rx->link and
 rx->link_sta
Thread-Topic: [PATCH v4] wifi: mac80211: fix initialization of rx->link and
 rx->link_sta
Thread-Index: AQHZEfV6w+29HTJLFkqQn3deKX+SRK5yAIbw
Date:   Sat, 17 Dec 2022 12:32:03 +0000
Message-ID: <SN6PR02MB4334DE8556B4C30D40A5AE78F7E79@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20221217085624.52077-1-nbd@nbd.name>
In-Reply-To: <20221217085624.52077-1-nbd@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|SA2PR02MB7676:EE_
x-ms-office365-filtering-correlation-id: 91c374d6-cfca-46b2-4fe2-08dae02ab3b5
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1HBx9F78yuILbZ3ToGVDlvNW63fe+ajl8raXXdAXe8QFnXI3b+m3qJAr1dNLw3aue8bZww6zG2UmlhFt3rytknHzRa1u9aWwjV08r3/Lf4GM7szIu2wJIIWoUr4c3+LfE24QhIlGLfDXfPbdfD93lfSL42RRWgXUbFuOjVsyGdtR8fzTbfCnUPX+ktmOevjfrzQPUPChjZN7uZ88VGK2HJWV52ylxFj/82A6LFhM6If9Et7xQpHbotHBwDgchAfk7eCaSnRiQDS8O1JRwiLb34vvD5SWKXM6M5SQ6gs4+hLvl+wxJAQnEtBLOlPWAXYwBiYWKksF78f/fucO8dOu5UW+5DNbd0euLzI7eeV6b8kkzHFBAwnAEdkEQbJs5Xibdcd+98IvsQjYBDIsRywJ75AeL6j4mcDBrhrmRwrQuFy5Tyz32cJ26AKIsyyZJKZc2EwUBmJ8ehqUhMhtHdJoxuWP8GdbzrHmAc7fs9Wchg3ClXz1a8amCv2CAFQbPRpmgTX9+j/tTz0N9HYm4Zv0/afwqEY2xCtozQlqXKWwSlYBi3s4GwErUcNaS1mv5LVHOpiEnrOo8bFYk3cqV9ovpU9NQm7kKOBj9Q6mOobo2oBUmn3kBIPeRPrTOH4I0+xHYCFI1FLDxPOEx6FX2Gn3po3rFcmxgVB3PblnoVUgHQcDLgXfTFg7/3LgesvOsmUgrKVe7R4KTn/JB87wtVYUFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(316002)(186003)(26005)(478600001)(6506007)(9686003)(110136005)(7696005)(83380400001)(64756008)(66946007)(66476007)(66446008)(66556008)(5660300002)(2906002)(41300700001)(76116006)(8936002)(4326008)(8676002)(52536014)(55016003)(38100700002)(33656002)(122000001)(38070700005)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YDbANrhnXP5h5Usbk5ijCy20FM8yYQ2HJGKE45PlbMak2Av2LioLxyHZ6Eqg?=
 =?us-ascii?Q?Is6MPwWxX8+SDNoWrWWYnjw7poBULDtP8y/RaYSkDDJzOMvH6j70lba9lsic?=
 =?us-ascii?Q?QkRKViklNRRfkSgR355AUPVg2WY5eaRtKVdJee4ocwviMGTgVqHBwDWdPmAR?=
 =?us-ascii?Q?tBTCtHh0K3qgUQOJMNwlmnPHhw+69vyH5l2Adl3oEjcZrbfcfyxGFdZEMNro?=
 =?us-ascii?Q?LuNpFa4QNLWymac+xMJhQwSlonfOXL9z0gFSbikSF3QtEfy0sQPFpPVSdM37?=
 =?us-ascii?Q?Wmar8IKPF93PmgjVvGn8nkgALpvSkObDOOrn4sFAkLezVyuQrNXOceJHQ8FW?=
 =?us-ascii?Q?4oXvJ00041cnBSRwxgWCEeMBSVV0Xo8/GZEQF2B1CtNmkOBulq+D7xHJ1Z11?=
 =?us-ascii?Q?6Gq3dcthRyzO+dQ9CcFdDs9wWz9CFKvV+SJK9kwhtXUF4Ven8rU9UwlnFEqr?=
 =?us-ascii?Q?aDOi8+uCRl9va54x+NB/PcSBQLFj6Wa+VhvzKbq1Yy57TfcW6ukURI/t45GA?=
 =?us-ascii?Q?G1/KDnYTtVl7+1ayqb69KhL7emQwu8GTC3O8Hc2M4r2uMzNxaBGXMk2d6kax?=
 =?us-ascii?Q?vSun18A5AuXWYewYFRlZGXNXJnDe5t9uszQZb2of7/bxsTsbYM/Zt13ttieI?=
 =?us-ascii?Q?BUAgx1xOLp/OlpS4en98GSe50PwXAkf2oyS0uJq1Sai709GkwfWvuLp6FZb7?=
 =?us-ascii?Q?0IGpLhR74WKtTmBVUDc1wSTsWEGbbRKqq4v1TmKR7M5ICq+rdHClqPaXFv31?=
 =?us-ascii?Q?JPQ7kJji5Z77EzZHiCQNzHrISWurJSn5kGm68k5+IKo6d9YE1lGIcNAB11a5?=
 =?us-ascii?Q?XuEL7uMt9nYn4R40/5yTZa5BXoKpqzeWYiqn6CMNLL8VGUDTEte84GS3ZZwH?=
 =?us-ascii?Q?i4p8Cn7UcXjEPiwmHI20TWZKRGJGkzlxrJllzXRy2/qG4q+itEehwbMVUI99?=
 =?us-ascii?Q?frVQnUl7LEwkGVf4qPvaYw40p8IYOTlATVZY9w/VAQe0nQ6TQ3YqZKUmksKe?=
 =?us-ascii?Q?XZ4Fw9Png07RAire65o6DZRW/vvmacxt15O5bINUNtRw61GZKB/FCWMoMLc0?=
 =?us-ascii?Q?fPz+ewgad+svX/Y8r2naCBR0wsYhYUUP+vFVgkKD5Tctj6zqvye7+w9HPY56?=
 =?us-ascii?Q?K8aRhW5C5hvozGlwik417us11utfvecGANqZJDPlxFzOCN7Q1TQlu9oylLZH?=
 =?us-ascii?Q?B3qLO9HOPnY+rHZsMAViW81pse7tQZOpaAyHb+ZNYgOOspfyGpy3Re01NHNB?=
 =?us-ascii?Q?s/92VpL+fXrZ0e9oaqCzlf+ZcNvjLBAyJLIN/l0jWAUqC8tSBpAlQOD0IZBN?=
 =?us-ascii?Q?HicdSkj19rRFWV76RgnUb0l0qtss6foCcwvzWK4XB2aSf43V8LRnqW6nGNBA?=
 =?us-ascii?Q?EqzvcPhsII7thDEsqZ/5uwqZaF1uXfJFX2kY0QTnpvgwrzh/UYTVEO81GvLp?=
 =?us-ascii?Q?PUBx+BdfRx9qR51vlsh2ZUqXQ/tt7wKntE5W74m0UEY0C3Vy0e5Wrv/TmM2i?=
 =?us-ascii?Q?s68KXdsJlHMuObIxE+KNRm3KuPbSyKzAi7gKH/eYYjsbDZAv6XtKHRCMo659?=
 =?us-ascii?Q?1DQUmSLKe+toWjRF8ndMn55Mj7QMH6lfwuCw06Yj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c374d6-cfca-46b2-4fe2-08dae02ab3b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 12:32:03.4442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxLZV9KqX7E12B14gUEb6g7TW1iKoT53U8D9ZQlCButaLYswIp7SOgYfZp7mMfaH7KZrmWvB6ugm/rMKlNixUp92Kc4LuqPcJsQRl38jbyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7676
X-Proofpoint-GUID: -ljlcay2yu0A7yGujaOUdFW4TO_CL1j9
X-Proofpoint-ORIG-GUID: -ljlcay2yu0A7yGujaOUdFW4TO_CL1j9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=579
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212170111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>-----Original Message-----
>From: Felix Fietkau <nbd@nbd.name>
>Sent: Saturday, December 17, 2022 2:26 PM
>To: linux-wireless@vger.kernel.org
>Cc: johannes@sipsolutions.net
>Subject: [PATCH v4] wifi: mac80211: fix initialization of rx->link and rx-
>>link_sta
>
>WARNING: This email originated from outside of Qualcomm. Please be wary
>of any links or attachments, and do not enable macros.
>
>There are some codepaths that do not initialize rx->link_sta properly. Thi=
s
>causes a crash in places which assume that rx->link_sta is valid if rx->st=
a is
>valid.
>One known instance is triggered by __ieee80211_rx_h_amsdu being called
>from fast-rx. It results in a crash like this one:
>
> BUG: kernel NULL pointer dereference, address: 00000000000000a8
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page PGD 0 P4D 0
> Oops: 0002 [#1] PREEMPT SMP PTI
> CPU: 1 PID: 506 Comm: mt76-usb-rx phy Tainted: G            E      6.1.0-
>debian64x+1.7 #3
> Hardware name: ZOTAC ZBOX-ID92/ZBOX-IQ01/ZBOX-ID92/ZBOX-IQ01, BIOS
>B220P007 05/21/2014
> RIP: 0010:ieee80211_deliver_skb+0x62/0x1f0 [mac80211]
> Code: 00 48 89 04 24 e8 9e a7 c3 df 89 c0 48 03 1c c5 a0 ea 39 a1 4c 01 6=
b
>08 48 ff 03 48
>       83 7d 28 00 74 11 48 8b 45 30 48 63 55 44 <48> 83 84 d0 a8 00 00 00
>01 41 8b 86 c0
>       11 00 00 8d 50 fd 83 fa 01
> RSP: 0018:ffff999040803b10 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffffb9903f496480 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>0000000000000000
> RBP: ffff999040803ce0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d21828ac900
> R13: 000000000000004a R14: ffff8d2198ed89c0 R15: ffff8d2198ed8000
> FS:  0000000000000000(0000) GS:ffff8d24afe80000(0000)
>knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000a8 CR3: 0000000429810002 CR4:
>00000000001706e0  Call Trace:
>  <TASK>
>  __ieee80211_rx_h_amsdu+0x1b5/0x240 [mac80211]
>  ? ieee80211_prepare_and_rx_handle+0xcdd/0x1320 [mac80211]
>  ? __local_bh_enable_ip+0x3b/0xa0
>  ieee80211_prepare_and_rx_handle+0xcdd/0x1320 [mac80211]
>  ? prepare_transfer+0x109/0x1a0 [xhci_hcd]
>  ieee80211_rx_list+0xa80/0xda0 [mac80211]
>  mt76_rx_complete+0x207/0x2e0 [mt76]
>  mt76_rx_poll_complete+0x357/0x5a0 [mt76]
>  mt76u_rx_worker+0x4f5/0x600 [mt76_usb]
>  ? mt76_get_min_avg_rssi+0x140/0x140 [mt76]
>  __mt76_worker_fn+0x50/0x80 [mt76]
>  kthread+0xed/0x120
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>
>Since the initialization of rx->link and rx->link_sta is rather convoluted=
 and
>duplicated in many places, clean it up by using a helper function to set i=
t.
>
>Fixes: ccdde7c74ffd ("wifi: mac80211: properly implement MLO key
>handling")
>Fixes: b320d6c456ff ("wifi: mac80211: use correct rx link_sta instead of
>default")
>Signed-off-by: Felix Fietkau <nbd@nbd.name>
>---
>v4: fix regression in handling mgmt frames with AP_VLAN
>v3: include crash log
>v2: fix uninitialized variable
>
> net/mac80211/rx.c | 218 ++++++++++++++++++++--------------------------
> 1 file changed, 95 insertions(+), 123 deletions(-)
>
>diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c index
>3fa7b36d4324..09cd0caded16 100644
>--- a/net/mac80211/rx.c
>+++ b/net/mac80211/rx.c
>@@ -4091,6 +4091,56 @@ static void
>ieee80211_invoke_rx_handlers(struct ieee80211_rx_data *rx)  #undef
>CALL_RXH  }
>
>+static bool
>+ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8
>+link_id) {
>+       if (!sta->mlo)
>+               return false;
>+
>+       return !!(sta->valid_links & BIT(link_id)); }
>+
>+static bool ieee80211_rx_data_set_link(struct ieee80211_rx_data *rx,
>+                                      u8 link_id) {
>+       if (!ieee80211_rx_is_valid_sta_link_id(&rx->sta->sta, link_id))
>+               return false;
>+
>+       rx->link_id =3D link_id;
>+       rx->link =3D rcu_dereference(rx->sdata->link[link_id]);
>+       rx->link_sta =3D rcu_dereference(rx->sta->link[link_id]);
>+
>+       return rx->link && rx->link_sta; }
>+
>+static bool ieee80211_rx_data_set_sta(struct ieee80211_rx_data *rx,
>+                                     struct ieee80211_sta *pubsta,
>+                                     int link_id) {
>+       struct sta_info *sta;
>+
>+       sta =3D container_of(pubsta, struct sta_info, sta);
>+
>+       rx->link_id =3D link_id;
>+       rx->sta =3D sta;
>+
>+       if (sta) {
>+               rx->local =3D sta->sdata->local;
>+               if (!rx->sdata)
>+                       rx->sdata =3D sta->sdata;
>+               rx->link_sta =3D &sta->deflink;
>+
>+               if (link_id >=3D 0 &&
>+                   !ieee80211_rx_data_set_link(rx, link_id))
>+                       return false;
>+       }
>+
>+       if (link_id < 0)
>+               rx->link =3D &rx->sdata->deflink;
I guess this would set a wrong sdata link for a non ML STA associated to a =
ML AP, since
ieee80211_rx_is_valid_sta_link_id() adds condition above that a valid link =
id should be passed in Rx status from
a driver only for ML STA cases(sta->mlo check above).
Hence with no link id passed from driver for a Rx from a non ML STA, the li=
nk_id in this function would be -1
and hence will set the rx->link as the sdata->deflink .
A non ML STA could be associated to any of the links of a ML AP and hence t=
he assumption of
using deflink for link_id < 0 would be wrong I think.=20

(May be this patch didn't change any behavior now, but the issue is already=
 there I guess?)

Thanks,
Sriram.R

>+
>+       return true;
>+}
