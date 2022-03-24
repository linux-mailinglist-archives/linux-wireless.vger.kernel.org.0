Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE34E664E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 16:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351475AbiCXPxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351406AbiCXPw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 11:52:56 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2064.outbound.protection.outlook.com [40.107.115.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6F91347
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 08:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJAclXm0cmvRmtmZ7nB0sYd16UY6R5wf7xfbNkFXdSDcxLLNymsSrSyH4DZi0X3YG1WoGsF/akBYK5/IyC9XpICCRpZLEs568PgdBszzG8jBDyzrlKTT+jzGopjR8CMB/5W8J2uBcswQGbYswlcGaUFcF2yq2yy3PJVvfMorw/mdnuoWWtbSwD9M+pKWHfC8t+ISiTcnjpYiljO8zEyS3uH1gk005egpEex8j5Ww392Cq1z65Q1nzkssFxVZ1ALulxejysxH1auAbplaltfvBJsBg63xYzjvgDvMIXqSq1NuDFW6vBdrNHRvjtAFOSVTnZ41ets3HspiGPWb9K98Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfarKCO4HxKK/0CwBCtdwx3PODNqnyMX2HWZ/vfmPvE=;
 b=gDEdtfhCCIAqbmvt4q5bik2oB7cd7WMiI5w+apM7+JJJfcPjWI8sC55wm6bLy2+y4KWc2Rn3IN/zH2WEHeNzcZ4Ci3KJkH9arlSWPfgEnAIbNH0RaBi1Uj0BYZbQFArWC1BvG3vQANBeFD2XOtX4vydwJUYXv0/jUwUXsy9W29vHl8AiQgu//ObAplXj0QoVg1qmllEhbclNtfaxF1YywAxO5jvDP22IvgwZdr447uuljzbJohVyLHElGl3wd1digjygGt5BS4629D9pRvadtyuOVVtd0wBGCENfccj6edLZqWsGvis3097hDBy2MN+1blMx3FtsOo3ff/KELSxBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT3PR01MB6582.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Thu, 24 Mar
 2022 15:51:22 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 15:51:22 +0000
X-Gm-Message-State: AOAM533HpOdYUDmByirTmdGoaThDMI2kSPS/EoUHUtJOE0zCi0CBqZmv
        wpzipYqu8pmNgssYOUWudrmwMeGHlCC6jbASc/k=
X-Google-Smtp-Source: ABdhPJzv15we5fEko5YURMvbh/DrPqonXy2CI0xJOeTpXb9mre99bB0Zs0GoEb3zC+hlbqvwNAY7lQZX012SQ6hxKA8=
X-Received: by 2002:a37:aa13:0:b0:67e:d:5530 with SMTP id t19-20020a37aa13000000b0067e000d5530mr3746144qke.148.1648137079038;
 Thu, 24 Mar 2022 08:51:19 -0700 (PDT)
References: <20220320233010.123106-1-wlooi@ucalgary.ca> <20220320233010.123106-5-wlooi@ucalgary.ca>
 <8735j9vww4.fsf@tynnyri.adurom.net>
In-Reply-To: <8735j9vww4.fsf@tynnyri.adurom.net>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Thu, 24 Mar 2022 09:51:07 -0600
X-Gmail-Original-Message-ID: <CAKe_nd0xCYHGQYoLgC9TZY7wXS-XR=47G6ENWfTHUdrHh-q_mQ@mail.gmail.com>
Message-ID: <CAKe_nd0xCYHGQYoLgC9TZY7wXS-XR=47G6ENWfTHUdrHh-q_mQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
To:     Kalle Valo <kvalo@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL0PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:207:3d::30) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2377182-df2f-4ddc-ac70-08da0dae2454
X-MS-TrafficTypeDiagnostic: YT3PR01MB6582:EE_
X-Microsoft-Antispam-PRVS: <YT3PR01MB6582AD99F8516B8CA75A6F48B2199@YT3PR01MB6582.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2y8S5joFUowaJiqtQyH7NCuXMy4KdcE1gPcVsu9z0QDdzD4TaonNRNVhYTyAxeLWqXXmqHyhGntCnHa0wdVyrlm8+tYdLrjwRCVhpx+Qy3lfdqGoq+Sp0qrO1fZGIrzkaupMtvFpd4M/ufuYaim/Iw/g/91N0x3QhTW7CykszEeZ4NvF9NcqdsLWAH9iHnE6tBRAbQSe7e8PPkuP835jDSV3PP79tENpVIFBt5ot8JlRZg9FksBkri7poiFP2wcXhP+OXGUfbSXqHTzsw+wn6BQBh4L911TnYTrdJO233zYyPM56Rc5lsatOwvQ6Ih+5sXHHkUWbLNdmpoPMEIWkLWkjXNjttfqeREiFGA2FL8FicUu3s6Gu1AUmu2cbRYbHrZrYVEX296KBU2iNH59QRDdF6P4Z45YGP27g6u1mJHS/2TpJIAP3h2gqzFcMBEgdUR8+Do9BkVbPb7cUpS6jGo3rTS1nJcpoug5ioBovHQkzUUbjm+EgfVn0bk81nB1zFEzEOkyn07EmAU1AZQcI3A7rsm3R8Imkh6x3hukftWIZtIlYG/UZBXTGZkaCI4TirIiuKMmMHW/Jb1oQ++mCn2vh8CwsV0RGjTVinVrDFMFXxLjLBVxZxTzHPncdJJI8Krh/oPALZJ5YnA9uhNqwNeJjg16FXBfJpzUeiLA4PdK73G8ntBEvAMsM3YTi1Ckp+Wn0R7FaUFZ6tiHiDrs0Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(26005)(186003)(5660300002)(66946007)(66556008)(66476007)(6862004)(8676002)(6486002)(8936002)(4326008)(2906002)(6506007)(55236004)(53546011)(6512007)(9686003)(38100700002)(86362001)(38350700002)(52116002)(6666004)(107886003)(4744005)(316002)(55446002)(786003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0tCNEtHQnE3THdVQUN5UloxVkdFMXd1NVN3ZHlRYzNaTWdTUVFqbGhJRzRa?=
 =?utf-8?B?dUIvcmYrL3czZ1JCUXZKS0c0enVnOGNuQ0kzN1pHSlRkaG9NVENoYnJVcW52?=
 =?utf-8?B?aHhjQVhnamtDOTNRSE93Mk1OKzBaVU13OEEwUEphNnM2UmRzcXZIWTJIQTdZ?=
 =?utf-8?B?amdiOHQxcFhVdTRqWFI2ZnQ2Sm5uaVpHa01JeW83YVU3VXFFTjBoRER1SDFM?=
 =?utf-8?B?MHlDUi93enZ4c25XZXNscHB5R2s3S09iOVlSUEQyMFdoMTBUcTFmYzJFaUVl?=
 =?utf-8?B?RmIreWxtUFBWSUgzTXJVN3VaYWNiLzNFenJqcUhqUTdxbVREb3M4UmNJdEFF?=
 =?utf-8?B?a3RiOGtIZ0RCZmVMVDM3RGdqUTUvYVJBdE13U3AyUU1uRjVzc0lSZU9iT2h2?=
 =?utf-8?B?dTZRN09SbjRUU1lpdUp4eDhmZlZHcWtNZHhqMGNEcGdWN0lLbi94dnJ6Qktk?=
 =?utf-8?B?M2xIVGZWVENPZEFHRTBxSVBSUFdhSnlZUWMzQ041NFk5NWVCeUdqTzdpNUtZ?=
 =?utf-8?B?Tk42TFN4VGtZU1IxaHFUNGt5d3dDRVJETDNtd3g2SWJQdS92d2VaZEJaV1NL?=
 =?utf-8?B?QVVoaHcrU0hVZ1hHR0lOMGtMaklHN1dFSU5KWFZHTm5ZdTJ1Z01XUERtaDhj?=
 =?utf-8?B?amFMdVk5QlBEYVNiaGxhWWFTdFFSaTZRUDlxRnFOb1BwQllsNkhVVXU5aWo3?=
 =?utf-8?B?Sy9zQlBpTXRES2hldXg5VEF1VUc2bVNPOENPSlp4T2hNZVplZFd3K1Exb2dL?=
 =?utf-8?B?ZjN2cnNWYmZ3S0hTbEdkNGJSN1FLK1lsOTAxUndMT3U2YURTeWw0WTF5WWV6?=
 =?utf-8?B?RlpMTjNaSXFqYzBJcTRza3ZhSXRGZTZCbXZuK1QxUmRqM285UUV1VEY0aWl6?=
 =?utf-8?B?WEJxaVRsYUFuQTB4OHdTd2JZNERMNmU2RFhDcUxIbFV2ZzJSSmVydFNCK0p0?=
 =?utf-8?B?cFdSb2YrZThhcjkwTU9SelhndFM1ODFwOEZtNmxKaFFpVTM4MWJQdXkyNnRQ?=
 =?utf-8?B?MndXL25UdCs4aTdDaHluR212TnlWY1VNeEFMR1dzdytYczM2NWZKVWVRaWdl?=
 =?utf-8?B?WHNuVkpWZEhIZkk1QWlFSm5qbDJhYUE3c0x4ZXl6d0xVa3ErNTNnM2Z5K1dv?=
 =?utf-8?B?bHpjMmhlREp5azNuVkJSanJhWHIxblh6M1lqY0dJY3RGcHU3Q1E0L2NZeFRw?=
 =?utf-8?B?ZmE3bXllNXFVeTdvVkpGUGdVTERWaFNaUEFhZzBydld3cEdjS3UxZTJvL3I4?=
 =?utf-8?B?QmdWTEhvS2ZsVUdsaHI0eG9VVm9iUFFEandWc3pEOC9jdW5tcnRzV1RkMkht?=
 =?utf-8?B?WHNkQ0xLZEZOYnpwV3haRCtNRDB3K1gvM1ppYjBUbFF4TTgyTGo4dmVWNkcr?=
 =?utf-8?B?anMwV3JZNm51N0RpREpvc3FNQnRMYWxPR2VDcW82NWxmbFVFSWlDMXVERVZ5?=
 =?utf-8?B?SmxiejJJdG0yT2NwdzdNNGo0TVFETE41enlzVnByRnFONXptRW94TGV3eS9p?=
 =?utf-8?B?aHJMUHhpL1lwcU9nUXhoWWxEbFdQdFdMYkFPN2FQaktkSFJCemtqTUxxVStU?=
 =?utf-8?B?dVNOeTFaRUEyaGVSWmJjMTJDNFkxcEoreHRzRVB4TDIyd2trN1lIYnFlcjUr?=
 =?utf-8?B?SXZFcWxBcHhqb0tSMGFRWWZxZ2NHSS9GTlNaOVVQbjcyaHhBNTVUT3QvQmlR?=
 =?utf-8?B?ekRHRDZxQ2FMQjVlODl1NmNobUR1OGQyd3VoZUUyREkyL1B5Tndja01VUytX?=
 =?utf-8?B?bTUvb1ZMakVFbTRlVnc4RWRKdm1BNHMreUFBOE9ORlN2Q3Q3dStGUHloaUxn?=
 =?utf-8?B?Z3ZuMFh3Z1BENE5lTG1BZGdUSUhlN0hITXh6b0Nhd292VkMyd0I3V3JjYTUy?=
 =?utf-8?B?Mm0wcjdyZTF3b09UTk13NUxQWnVkQmtaT2xaN0JxbG9DTjhtbFp5Q0d1Q1pZ?=
 =?utf-8?Q?wPINkqrQ5fTTSa/Jkx/JEr5GPETGMkLs?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: d2377182-df2f-4ddc-ac70-08da0dae2454
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 15:51:21.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACI/GBEmcrWQgT9tAkkPW5zfisXO9cvDv1aQnJ7Mr+Rwc9Wul6dBNPJGeBGfeUfGxwZNLwwDFFh3Xz6DAiO7Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6582
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 23, 2022 at 3:30 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Wenli Looi <wlooi@ucalgary.ca> writes:
>
> > The current implementation is reading the wrong eeprom type.
> >
> > Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepmisc value")
> > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
>
> The Fixes tag is wrong, I fixed it in the pending branch.
>

Thanks for the fix!
