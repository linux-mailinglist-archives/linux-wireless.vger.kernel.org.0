Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC44E3100
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbiCUT7V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 15:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiCUT7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 15:59:20 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660076.outbound.protection.outlook.com [40.107.66.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37169181B0B
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 12:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjCg5SFpSdQb7tM//LCOwu69m+RwSKDs8nvsbyK3pvv9w+oG9nfBS7mAfUJdi03ALOOYS8qR5yEy9O2K+INFlTYKEdDjHm/OQDaRxnQ5G0GeCraTOI+0RLhQ7ZNOMcUTK+6buQur4NWnEx+Xr/P6PKYnN44doNbtryLWLOb57HzcwsCvpnzq3Q2YDOchSWqenNXEm++QkZEhmLai3djo5d5/2Rr9TTqI6lkCbKSv5FcYENY4tPhyqyCgpyxtAB5UYelXbLehaRVXGljsuCmZshZyZKc5x4x2ieE7IRyQ97/GlR/f0UtHp4XB6N9WLWczZebL5dU/lLZRqWZLWnXttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj6tQqJQhSOCmlkvHMlHP2JWBIdKiVkj4awA9XRyv50=;
 b=TpKImDjsey0/AiekwS5tHB1+wspu+lSPstp4z++rAeGcsxuxQye9R0ZAbSraJc63vHRW3EvryrR58SNzJbmgXattxXKCMwFRxv4b7MjUTHv4HW2okI6s4zXCbSJh6E8o0ymSX00krXXbN326B9bnKvdCdeW3R0J2Wbh77o8/PwpYBMbb1+oDNzVODiHvL+8pGYHD8unE7M2lvo/H5WpzxAk+5JmB9EVYaTsE6DntJn3IS7fOdLfPBui9t2Y4kzqbZgv1lJnzdngur5ULOFZImhFRmhwKlXVbo6g1+lqN1MqA7zvy8lVGfmx54BjsLm5bwnpL0AD39/tdEKzGHoYa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB3568.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Mon, 21 Mar
 2022 19:57:52 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 19:57:52 +0000
X-Gm-Message-State: AOAM532BNpZtn0jUoV6OcKkgDlw2If7iE8ZqqVzfnreeODuNC9aitgaI
        04O7aQJcnG3bZz5It+g+WdXABRk8nNQvV8YLFNY=
X-Google-Smtp-Source: ABdhPJwhQ0ayq6uxxycfbKCdjpxEoetjPCKaaRev626GF2XMa6Q5mbU7diSPP4Qmfl11Wb6QiQG7MV71Jk060k5ENfQ=
X-Received: by 2002:a05:6214:b6c:b0:440:f3b8:d0a0 with SMTP id
 ey12-20020a0562140b6c00b00440f3b8d0a0mr14724645qvb.97.1647892667661; Mon, 21
 Mar 2022 12:57:47 -0700 (PDT)
References: <20220320233010.123106-1-wlooi@ucalgary.ca> <20220320233010.123106-5-wlooi@ucalgary.ca>
 <87a6dj9uds.fsf@toke.dk>
In-Reply-To: <87a6dj9uds.fsf@toke.dk>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Mon, 21 Mar 2022 12:57:36 -0700
X-Gmail-Original-Message-ID: <CAKe_nd0huJzqsn=8bQfyZ0oPLTzCjJFCrPPhUCwTY5W8WL-H5g@mail.gmail.com>
Message-ID: <CAKe_nd0huJzqsn=8bQfyZ0oPLTzCjJFCrPPhUCwTY5W8WL-H5g@mail.gmail.com>
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BL0PR0102CA0063.prod.exchangelabs.com
 (2603:10b6:208:25::40) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f508fb-668c-43a4-7996-08da0b7513e0
X-MS-TrafficTypeDiagnostic: YTBPR01MB3568:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB3568254CB7990AFD115D9591B2169@YTBPR01MB3568.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u586zE8dbo2UjZNKp1jrIgjuEF/ruT6KNwpuOwMniw7r71DRcJoEFIy+mJgWo5qkrCMZwopFxoB09szGokfXft2s8eTiE56vmA661bh+sIM6s9eJO5aUYU2KgELPk4jqie+js+vNiN6RfxaaCPAdwG0mi/OiFbky0g8Jz6jOh4KMIfoTaNiLoJEvPc8f2RM30PlLGJiTESgvzgDlmB1CnNCNO9vp6LzAsNVy1zVENoFyaYHsh6hbrnrax8yRiAiEz1b3vaKgQ2pZGmTACiOBSFSDuWzxOqCFfbkKudUQins5a50m5pBagfZhYbJeDJEyljEEAuXCKF9B5EZAs6F/QQYZbhDI0c0ZSlvB1jXI2kA2XcMoPN05moR+jFwIlmcefEkBohXL3SJyw5VHS2krLSCn0I4hpacFW02Rzprhl4Kp3vb0RzSTBD1TsNYgXNAB2LVtsVEsQkj0ihX5iVKh/BZ/2KX7L53VXu0h9n9oLHGarV98N4ybnt0kqbRgpazcDmr6w/3n8rlQ7+4Qfaew+b70jYPoGUxYoB5bnGSzFXEWbALSwEADmX2Bhk2+3oXlfKNSlBZhpQhXQx1fiktSrGTFmbPe0g70jbIcOyxCZG1KHP5ecpwdrop3jJnWSEtEZ3/kWPIdwETrZoUhPsUFDfDWXsY2V4EnTxvZrFOGf5Uwz/Vx+hwG79Zp8dgFP3edOA9VtauanyhiIQ2atNA2GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(186003)(26005)(2906002)(508600001)(786003)(66574015)(316002)(6486002)(6512007)(55236004)(9686003)(52116002)(53546011)(6666004)(6506007)(55446002)(86362001)(38350700002)(38100700002)(66946007)(83380400001)(8676002)(8936002)(66476007)(66556008)(6862004)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlIeEJGa0c4eVVGMG9EZlhEQ3NXajVseGZZSmV3VU1wS1lpVnF4WkZudGNn?=
 =?utf-8?B?UTU0LzZDcFNNL2dJbkcyMFRXOFdBNGVWZVVhNU0rS1JOVEtQMi9VY2dHMVZx?=
 =?utf-8?B?b0V6U2kyWnM1Y2ZrV3VrMnY1Tm9LbHJBN28wTW1SOS9FYW84eHlLRkgvbmMr?=
 =?utf-8?B?ejV6Nzkwd2xtTS9HYkRlRjV5K2NJQzhvRjhyM1BNOHg2V25IcE4ybUw2YjZO?=
 =?utf-8?B?YXIrSWVyZ0I0K2s0aUNaK2g0cmpjSGxKTjBGd0FxVXdZbWRadEFJNUJna0pv?=
 =?utf-8?B?QURpQjlUdTJVamtaZ0hYaXAvdGQ2SEJ5Z00yeGZ2UXV4alVkdHB5SFpLb2Ja?=
 =?utf-8?B?NXNTVVROa2txN3B2ZHgwSXJmUjN1VjF1SjZmNHZ3Y3UwU1dDWUZ6S3VDRTFJ?=
 =?utf-8?B?UU1mQXdjbldOUjVDOTlucVZFOHVkOTFFNXpyTTdxaEQxSWxsN1IzT1huZHUv?=
 =?utf-8?B?eTFDd041ajJGaEwzblFMektxeUFXVUJoSjB6Y1hOZ3dER3BORzQ2R240a2Mr?=
 =?utf-8?B?RWlsSTRNTHI2UmhLd0x3dy9ma2FCT09OYlhjbHBjLzBkQlB4NGx1cERvRi9S?=
 =?utf-8?B?TlpMcnV5bFJOZ3kwMFBnOXJ2b0lJWlBHTERvRUNVdHJRaDNHWkUwZ29kdGs3?=
 =?utf-8?B?b0lmdWF1TDRibGFGZzBvWmVRdVBSOE5Ta3JuUDA0eDZ1UUI3cHlOR2UyZlZO?=
 =?utf-8?B?bjVKK3cxT2twQnhrV2hsUGNXdCt1Q1J2Qm1FRTkxSU96dlpHemxuQkRHbSsy?=
 =?utf-8?B?bk55RzFVSVlRS01XOFFPbTd0Uk1ibkxZdnVhblVBTkdGb0xFNDR4UDhHcGNE?=
 =?utf-8?B?Zm9NVXI1U0JHQTVSUDRyTW1RekZ3aGxHSWR0bGxoN016M0NKL3F2RWM4Vlkr?=
 =?utf-8?B?ZFRFR1o4UzBrSGpoN2xSU3RDK290dEZlNmFZaFRhRjcyd3YwSGM0VDJjNzV5?=
 =?utf-8?B?QnAyZ3ppR2x5MFZtMDJUWEMycytQSzVvYjVJR3NsMXIvQTZtZ3dHZ09ZYTRx?=
 =?utf-8?B?VTY4VlFoWTF0UjVOcEl5MWV4R3l4Rkl2RStzNW4vbEVQMWpDN2RGeWZRK0Vi?=
 =?utf-8?B?aWRlNEhvd1R1WTFnK1FNZ3V5UTcwTnZJNWpETnBna01sYkNPcHIwTGh1ZVJr?=
 =?utf-8?B?RWh5bU12TytUd2NzaFVtb3FNbmxGa1hlTEJUc1NzY2N5OVJjREVtcENKOTY0?=
 =?utf-8?B?Sy9URE5GVlh6MGoxQ0pZdWVoMktjYVBMeFM1cmRXd2tpMzBVU29SVlRiM2tp?=
 =?utf-8?B?YTJ4SEZabTRlVk1od0E2ekZCenBHMmxZK3dqS1hzN0FZMXJ6V05qbUZpZEhs?=
 =?utf-8?B?cURzcEZ3VGRadHQ5U0IycE5TYVhRdjVZYjBMSVNwZ0dETmV3ZzFqM3BHR3Uw?=
 =?utf-8?B?WEFTbnkvcjR5bUdHL011UWQySUdMbDdXWUVNTFl2ZjBDdjNXelcwMUpma2No?=
 =?utf-8?B?ZzU3SUQ5MUFpZVBhaU5DalFSeWNlQ2JTQVVpK2l3bnJtY2FhMmVTa1dOQ3R6?=
 =?utf-8?B?VEtlYXBRTHFQSXJYQTZDa2l5YUZMeG9UdDQ5KzhKdVJOQWRTTmVTbEFTbyt6?=
 =?utf-8?B?VDBTbE1Xa04yK2pudnZUNmhuc3ZENzA0ZHdNZmVEWitmdHBwUWo5SldFWmxk?=
 =?utf-8?B?byt3N1JvVHVsYm4xdjdlT1B3OWx3Vmp4aVZBekdVQlc2Y2lIOFJMaTBGZE1X?=
 =?utf-8?B?NFZ6NGRjNVZnUkNSYS9UVDBvUHEySEQ5NDFWTEYvV1lJSVorN3BwUVpxSC9l?=
 =?utf-8?B?Nk9Kek5NS1pObnJSc1AvR1pXektQL0VNY1hTQkQ5MTlkUGdneTRLcWJEZXM4?=
 =?utf-8?B?c3JYbmRkeTh0dHM4dVBNWWhoVDRPTjBtSlN6TW9KWmdxbEhka3M5bzgvL2t1?=
 =?utf-8?B?RGR5VGxrZW4wL2FkY0NJK1lNV2RrazVyWWMzbzJVZlRWaGFScU5xbGROTjhI?=
 =?utf-8?Q?rjqaaKeCdN2nwFiSAb81kPSvyg4GdH/1?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f508fb-668c-43a4-7996-08da0b7513e0
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 19:57:50.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlhDVQk0sxlj3iD4+Mti9P8/uLacTPeYlaHza3VjRnYCuOhClw+nlzEuqxevip55LplH1vNkNQnRvVJaEQU/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB3568
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 21, 2022 at 8:51 AM Toke Høiland-Jørgensen <toke@toke.dk> wrote:
>
> Wenli Looi <wlooi@ucalgary.ca> writes:
>
> > The current implementation is reading the wrong eeprom type.
> >
> > Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepmisc value")
> > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> > ---
> >  drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> > index 669b49b56..a109a44a1 100644
> > --- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> > +++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> > @@ -5615,7 +5615,7 @@ unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
> >
> >  static u8 ar9003_get_eepmisc(struct ath_hw *ah)
> >  {
> > -     return ah->eeprom.map4k.baseEepHeader.eepMisc;
> > +     return ah->eeprom.ar9300_eep.baseEepHeader.opCapFlags.eepMisc;
> >  }
>
> Looks like this is only ever used to check for the
> AR5416_EEPMISC_BIG_ENDIAN flag - so is that never used by AR9300, or how
> was this ever working given that it's a completely different offset?
>
> -Toke

I think it's never used by AR9300, because get_eepmisc is only used in
ath9k_hw_nvram_swap_data, which is only used in the eeprom types other
than AR9300.
