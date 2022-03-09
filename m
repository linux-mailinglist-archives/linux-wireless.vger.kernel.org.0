Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7004D3D19
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 23:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiCIWjf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 17:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCIWje (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 17:39:34 -0500
Received: from CAN01-TO1-obe.outbound.protection.outlook.com (mail-eopbgr670086.outbound.protection.outlook.com [40.107.67.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76937108BEF
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 14:38:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcQAfPuFBAbL9AfZUi4u2/LNe2mzk92553WgO96l6vWHDyxhbKgbk0BbBglK98/KfXZ32XpYQqivnXqc6qZbVoAOXs1iTPCWAvVwI5uqZ/3nsZhm3r/PF6yQo3pFJ6NS31vJFe2tXhERIxnx6cMYAXZ85pF7GYaTwRieZkdb3yDhdoEsR55SR8ns+tfViMyzUaLRStVZBWPlXRB9nmug6jCau/1RwlV0rJcqquExygRiluetGmg3GgNgYp8eNy5fQgFL6PyLWQykqhY11Vb+olmTe7H9eFsAyi2UHXZtVIMgXKDVJOrrZoxAY72ZjomGvP2vZfxUziaX9JiMVohtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07rYH6Freg3DXGnQ6Q15ujsaaAsfVv+soTdtg3tdWbk=;
 b=DVRzQMyjxVHXu1Ou4fo2kXOcOwzNBpN20RA3xu50XGnM4/9ciuxkMUAJFlTrohKU/6ZxRlPHN4uFAyn2lfv4tOrRfP8p4TTkrNDPGkeeUsiQzppsFsTyvblFfnaZb/55/6NPM+CTAqnO6AkcoAffjMlYzl6OzdKIXnihG/VXB3mgl7ytvqoJXoVxzCdTXzO3+NVVt8TG8LlvgObzVuEYau8FCnS2AX8qAPRYhH1guWElWLRPofXcpiaqWcbOf3Y+/q/HgplC9QY7FRsxjDaRhiderSZqAnE1T3XaReMDh0HfWPBSQxzprzj8sYpOe4n/hkX77qjpSYWX2QPcsPUnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB4732.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:18::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:38:33 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5061.021; Wed, 9 Mar 2022
 22:38:33 +0000
X-Gm-Message-State: AOAM531lgTbLXmJJPQLb4nlDcx3QOWLof17Xed1Elm87ejr5LYbgP8vw
        +wvB7taIIOK9tnKaWbPFpla9kCB06aoBaFP653I=
X-Google-Smtp-Source: ABdhPJzJL8grp4ZPXstgRKxa6Cgpcv2sO5sgxoPAre1EYFCl4YwlZSaeMtJ/uOZmRMdakDK/KKS2pEWCEamYSy088/E=
X-Received: by 2002:a05:6214:c81:b0:435:bcec:c925 with SMTP id
 r1-20020a0562140c8100b00435bcecc925mr1740537qvr.108.1646865510501; Wed, 09
 Mar 2022 14:38:30 -0800 (PST)
References: <CAKe_nd1jthFhJhojQLXMeU741AoTks74K+J1v5FqS6ABB6gW-Q@mail.gmail.com>
 <87r18d1upk.fsf@kernel.org>
In-Reply-To: <87r18d1upk.fsf@kernel.org>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Wed, 9 Mar 2022 14:38:19 -0800
X-Gmail-Original-Message-ID: <CAKe_nd3Hc+5u9O0Bd31oFF_mTOJU9bx5hmcS1TkSy0FMtQamBA@mail.gmail.com>
Message-ID: <CAKe_nd3Hc+5u9O0Bd31oFF_mTOJU9bx5hmcS1TkSy0FMtQamBA@mail.gmail.com>
Subject: Re: QCN5502 support in ath9k
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath9k-devel@qca.qualcomm.com,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BL1PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::9) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bddb615-07eb-4f12-fc4b-08da021d8a3a
X-MS-TrafficTypeDiagnostic: YQBPR0101MB4732:EE_
X-Microsoft-Antispam-PRVS: <YQBPR0101MB4732E320324627D4D1F83E28B20A9@YQBPR0101MB4732.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wvuhUGb+JaStg0xOM9FeKk1Hwyy85w2m4k7BJxLJy2AyK1kxeG/kL1r7FUb3q3vReTaNrF4kkDu0TwminCjlmuerS77G87FJUOo7nZYsrwCFgk0Z8m+WDgGg8CkT2Lkdg7sJLusPs+kRl48BKUZOE8n1Ke4ZVZeM+aOuWiJzMZv09/T3bmKWA1E2MRTO2vqUUc6TuPOiGPQsEIjyS9ZPdF7q8EZuePnGWnfxc1d1s5Tqf1omoO7EXSZbjYVHvsRZsfaW8dqxIAHGPI1dU1lDda0iWGhoT/fsnmyo6eApXWYcc1CyeA7TZISw6Evky0ZJqdPEYBV0wRwqeHc586nB598CNbOq/0301yFMmAXYAXCXpKNHMOmoiC8hUjOUpy8WUfdkRCCXf2oq+48UJ5JC+daGYiOXpK98wGWsUyuLL83QFjS1yUPY1XiSbY6gM6p4QbwRmkLuQzmHxjsP00IYnaw0g/TAS/Z/+bTsAHb1P3WnA3cY+ceX7+Nzdx6JyWiMfts3WCwXJmcGDPHYzoashhenkbTMAAaY8XB8cVTE0NeCkJuywq9PFxnq5hNslJNo0NoAml5yq1+IZIdEWPKilUg4hZD5q2nu3puqP44yhMDNXHh7DSBRc+EMVBkbLpqhbXRvLKhtoRokmNOeZ5axENh9hJBd9lqRQdqXEu78fmYp/VNC7Rv6tyYm/TXGp2vBQcQ/FJ51xRX+MheDPSaUIWEdDpXTmiVNaTzVpAgz1IeYFGIiqMkRI5InQFzqxoHENQYvJiIWt4W4e3gIGho3R2TD/sNTF8NxTvQvlMrdXwY/FLMA7JRKpGfayonJPxF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(6862004)(8676002)(52116002)(9686003)(6666004)(55236004)(53546011)(6512007)(6506007)(966005)(6486002)(5660300002)(508600001)(66946007)(66556008)(66476007)(8936002)(86362001)(38350700002)(38100700002)(786003)(316002)(2906002)(83380400001)(186003)(26005)(55446002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtlaTVwMFgreVpwZ2VDVTExQURkaGxBQmtvR2pzMUI4L2VxdzluSll1WTlh?=
 =?utf-8?B?N0hydFBiTVVzZnlmTXR1aDZ1c0ZaUHF3RzBKUnk3N1pUQUpQaW5pNS93WWFk?=
 =?utf-8?B?bkNoMHBiNmw1ZVFUaE80Z2l6ZjZmNXZhV092aHAwNGcrMWVVNWMzbVJNa0ZF?=
 =?utf-8?B?MGpzZHRsTUZNMmJBRzJBaGh5dFo4eDU1ekJSWVRvSEloaXJ0SnUwNDY4SExP?=
 =?utf-8?B?ZHRma0Zpak5OaXhER1pqYXhxd3lOL1UwSmNJUVBMY0s2UVlNT0dBNTl4bEFp?=
 =?utf-8?B?OHY1b2E3Z2xsTU5LZm05VGhTT3BZRmFzQng4VkNvaWtqb3dtbHhWK2g1UlVO?=
 =?utf-8?B?ZitPZHYwTnlOc3ZLdXJzSTVRNDBWTkxFS3VZc3BUajhidmZWMDNLcWsxRWU3?=
 =?utf-8?B?ZCswQ3Q5WlNYNlNsaXdCUmtEQ3RPeU9jZTBBUFZmTEM4cHpZL2Nha3lBd0g0?=
 =?utf-8?B?NnQrNGo4N3ZHcGJOMzRKYnJYajVVYlNSMFkzcmtNaHU3eVdpNTQwWmQwVmVC?=
 =?utf-8?B?UW4zMGlyd3VFWmpCNTF2UEMzbjdzYi83K0V0dm1GaG9OQ2pyOHYveUZGZytB?=
 =?utf-8?B?aU9iRzlhS2tHWUNtVUZuM0xsWWxjdCs4NVkrTjk3dnh6MFgwSE1qcWlhOFQw?=
 =?utf-8?B?ZlFjU2ZWenpKRGZRNC9ERXRlci85UU5hMzhLQWFLYWc2RWxMRjMvZVFrZlFP?=
 =?utf-8?B?em1PWjN6VzNUU0UzZFVXelUraXVlUFl4VWtSNzNYZXVsWTVIRVBsMUhwR1Vo?=
 =?utf-8?B?QWRaS3dKeUNpK0hMR25pU3pLUUVvTmVudHQ1ZUtHVXVJcHBic0dnV1RQQ09j?=
 =?utf-8?B?dC9jNklLSUd3eFV6blMxekY2b1kxYWNVd01mVjg3TithM2Z6NTJId2Rubkhs?=
 =?utf-8?B?V3YwQUluUTk5TnhoNzUxTituSTJhQ1ZrZXcxaE9VUmNyY0kvQ1doU3lqNGJ3?=
 =?utf-8?B?MGgvUjVlWi9lNHBWTDlYWHBJeVUxWmlCTTNQbmE2YnhaZVBVcGROOFJyTjQ2?=
 =?utf-8?B?Q2V1S1FOVno0dGpXd1F2K3hDZHVDV3JiOGxwMUVlcTRBaGMxRmFGZDQ0TDVi?=
 =?utf-8?B?UFdaeE82dktnMHV0SXBWbXYvRkVXMVB4SDJIUEo3Y1l1NTV3eHBBYndtSHpZ?=
 =?utf-8?B?WGEyMk0vbHVpNXpmNDNGSldGcUZCY01VVEx4amY4dWVhM3EyNi9JcHdiNWdn?=
 =?utf-8?B?ajBLY3Z4SDJXVnNvVkwwQklkTFdBUzVJSzNyMTArMzRsVm9kanZQbEdCVXZh?=
 =?utf-8?B?VEZzeW9vWExORk5uaDdPTkhsazFkNXZ0YWR1aFJ2allzSlk0eDYwUjlGMjVu?=
 =?utf-8?B?NjlXMEozM0dHaUM0YXBvSWY0VStLWGtXQWs2SVVjODQwYitGVys4N1hqZU9p?=
 =?utf-8?B?QkFRZWVpYmdjSWZZbVlaa0dadEJpcFM3RzBMMkNFekF4Ri9zRjI5OE5wV09y?=
 =?utf-8?B?TEpoOGdLYWVXSWo5ekdIaVNxMlZmUTJPQjFhTWxpdEpZQjJnYzVSQ2RxSVNQ?=
 =?utf-8?B?QzQ0VU5RaktqRTh3RjQ5TytXa0VhN0JzQmJ0U0VMdVV3ZXc4aGxNUmxWWlBO?=
 =?utf-8?B?SWFESFVZbHcvL3NNVFB3ZjM0eks3RTJlWitXdmxjK1pPa0ZTK0tNT2ZMa3hx?=
 =?utf-8?B?UHk0QWdVTUhja2FxKzh4YWNoZVJvUzJnUS9SSHdqQk9objhIT2tqZU1jMUpr?=
 =?utf-8?B?WmtWTUptenJTQUV3cG9Ld3JBT3hld2hzNloza0VDNkRmZGlISjdRR2R0d0pt?=
 =?utf-8?B?OU0rbUFJcG1lSHJJWnUwMFdZcTIyTzIzVmN4UkNhWDQ0OEtDQ0xtdlhWcUM1?=
 =?utf-8?B?UklHS3lmb2hxL011azN1WFIxU0ZNR25kYlU1MUhvcDVKTGtHcEhrWEFYbkFY?=
 =?utf-8?B?V0Q2RVJvdjBQMVlXblBBRVdNOHp2dlVwTzBEQUVncDEzUk5kMzRhOU9SQysx?=
 =?utf-8?B?THAxVUxoQWs0ejVPM0VwUXRJZW1yaitBZUZ6UGNOV05nS0xzOVVhdjkwckta?=
 =?utf-8?B?TEJ1cjBhdkhHZGM2RUpMbWxJWHdJQVRtUGZ0bldKYytWT2JKNFdnVXZlNnZi?=
 =?utf-8?B?N0VMNDZUYlhVejBMVXZrckRndmNnbE5DcGdONVpYMlJMcEg2NVNRUVI5Z1NR?=
 =?utf-8?B?UHZrbDBZZkhTNUM4bnhvTzBTL0plbTNleWV2YkhWZ2s5Q2Nxcm9zbUdPbFB2?=
 =?utf-8?Q?rZzIkHkVAxW8DRhQ5eOOOKE=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bddb615-07eb-4f12-fc4b-08da021d8a3a
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:38:32.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QBG+IPcCWyWEkmeyjWStH1R0jQBfCCro27wUkig23cWUDQQ3jxX2zHkBOhO/UJR3yR+lJhSjBrh7QK2C5k9iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB4732
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I've managed to get QCN5502 working in ath9k in a very hacky way, by
mainly treating it as QCA956x, including the initvals:

https://github.com/openwrt/openwrt/pull/9389

It would be great if anyone could provide comments on the code, as
well as the ideas for incorporating this cleanly into ath9k (and
whether there would be interest in doing so).

Thanks!

On Tue, Feb 8, 2022 at 3:08 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> [△EXTERNAL]
>
>
>
> Wenli Looi <wlooi@ucalgary.ca> writes:
>
> > I'm wondering if there's any plan to support QCN5502 in ath9k. If not,
> > is it possible to obtain the initvals and other information that would
> > be required to support QCN5502 in ath9k? (such as those for QCA956x in
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath9k/ar956x_initvals.h)
> >
> >
> > For context, I have recently submitted two patches that seem to allow
> > QCN5502 to be fully functional except for the integrated wifi:
> >
> > * https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=a0b8cd5c223042efe764864b8dd9396ee127c763
> >
> > * https://github.com/openwrt/openwrt/pull/4271
> >
> > Thanks!
>
> Don't use HTML, linux-wireless drops all HTML mail, I don't know about
> QCN5502 support, but hopefully people see your email now.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
