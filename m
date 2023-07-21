Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5475BEBD
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 08:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGUGWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 02:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGUGVl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 02:21:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2089.outbound.protection.outlook.com [40.107.215.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6027358C
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 23:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hei9/0TkfK1F4UONvwypSXyKpRK38KV8/5vy2Bppgceyhf4TNvhUri2OK4cPHw+8s98DQJqTEBp3281nRcXqZHE0owqONcm80eyTQNfBQJ18a2oL6MwIujggiMfXhDh4oDgki1OJrV96WeWz1Fb6nE4NaPqmm+9ReT6/PqyfHX1OaNRYMlmFssSoM2l+E0LiZejdv82NIrXHWzgLV7rGTJTIcUdbBkg4iXLh6Z28azoGecRu38UjJhuz60Spk/ZjKb4CyWCtgfzrbRLNfgAUOH0qccw4KEXzxNSrMrZYxXxejf46h0G2iGFJt2wNEIxszGgKrFeQXksPayHp0EK75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLdlAmM2FJJf5wVzwZIgg/8OOjDQ/JNfCvOker/MMKk=;
 b=ogfPlHh9rIbEn/dY8BvneufAYa53lXejZN9gdDAArhojqX5wa0aLfV9byl2jT5NyAmX1MlVkXFmGPQMWOjm5gXedVhpoVbx3C0Ej9XeGT0V/aMdkTkENzO3OA9Hfd9M8rmKINogVtSAt2ZYgrHkS3nUSCE0DGTc+v4gQOkMLeKlhYP9f/MfjcKcr2DsDVupdbJLxOyucqGrmf/zZbVV/IjHzysqYkDZBLv4//8z0EgN3ArusGZH49jQrGb3VOV54MzFc4+RMPrcHxkAr2xlPLyTciC2indnZxOLjCh4t8+91idF+ii/FDQxy158/Dk1ZrNjfG+bpZKeRKRcBTha4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLdlAmM2FJJf5wVzwZIgg/8OOjDQ/JNfCvOker/MMKk=;
 b=e/1AtZchT1uJh7/OWcb/63SyCaUDkGUd9nhN0od/aDhXmKDW8extv0DfJZ7OJ7DR6m7yDUMt5qgNZSTms2siR4ciXBBgVAPoPCM9JtVmB8PegpgVSYhPYpZ8i2wNj2KgD9JxYyo3H8IzuIsFeeIdjK4YC16NkH/BFt6mL/STNnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 (2603:1096:4:80::10) by KL1PR01MB5525.apcprd01.prod.exchangelabs.com
 (2603:1096:820:cd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.38; Fri, 21 Jul
 2023 06:19:22 +0000
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::20f2:920f:691:4cd0]) by SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::20f2:920f:691:4cd0%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 06:19:20 +0000
Date:   Fri, 21 Jul 2023 15:19:57 +0900
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: fix error handling when channel_switch
 on S1G band
Message-ID: <20230721061957.GA1224@DESKTOP-7BCE18E.localdomain>
References: <20230705141206.22a74fa3@kernel.org>
 <20230711080918.20114-1-jk.shin@newratek.com>
 <20230712173724.607067c7@kernel.org>
 <E8117F40-49CB-4878-B314-57D228CB2C54@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8117F40-49CB-4878-B314-57D228CB2C54@sipsolutions.net>
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 (2603:1096:4:80::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB3286:EE_|KL1PR01MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4205b2-fc8b-4a80-368d-08db89b26b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCv34XnTnROIj8lcbuW7nkodc2lYdkaRCAXciiFygHRrHy1DRkoOAyOTsJbb2Z61+UdOes3zZy4mqIPsynqbsyyX9KTOlgEnUE1MBXL66CBYF48ARlY2txbkt4/KFcUsusCWLh6WwUfWWo7+gZVycfsqhhxst9q1sSYr534WWR3ILPeuHYHTwhGteZsn6s4NpZTRbNtMFkzcnBY/dhdBLae0Va4OLySoWWxL1kK1Bq4e8CjPQqq/JvmLgM25o755hwfH5JSq5qpqhP/U4TTs7/BGGBFFFt/OisGdO0Dm1FMVDpaUGO6JXaq8sE+CyKKvb70ZImW9J5PUosaoa/VzXtzn3ryZY2iDCchvYNpqchv9fGQODeD2FcGwUeB1wA36HG2uPSk2RzkQacuyIUdNmboqEtGZtPxyftQZP1FUjyO1nyBTVwmwfQ7cAz5j3WE+9w1pk+ct/bSLNBmsb3FzAvkhQ67PzQtf8rghG1pLBbL1tTPSmCObRqCzgk5mY2JH22bL/GAfL19+2FqFK2LY53IYXmgkNmN7AcyVJNuMzBluN66lhJd8hj0fqlbWQrL2+O5WLYv0uu8C0vl3mU2lBxIfQy9oEZapOXwo/EWSoBtRwE/o1XuCBBiSMHiSX7Z/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR01MB3286.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(346002)(39840400004)(451199021)(2906002)(41300700001)(316002)(5660300002)(8936002)(8676002)(33656002)(86362001)(478600001)(186003)(9686003)(1076003)(6506007)(26005)(53546011)(52116002)(6486002)(6666004)(6512007)(38350700002)(38100700002)(66946007)(66476007)(66556008)(6916009)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+gn/wNdupzjYKgBtPy2lHVB0QoFEQfLX2H1GGqhyZMIvCBH8Ub3V+pujXkNl?=
 =?us-ascii?Q?N8rfxEpyHgNLvvHUt8ocpiLsQjOUBPI5EKAuRQbUaW9ceBtdeq7xPuSU+qt+?=
 =?us-ascii?Q?5+naI0gJts9FGarmdEcKlRxESC1zdbhVkyImbXpK8IbENQmEqe4OH02w2u2D?=
 =?us-ascii?Q?J5Ci0TJu7Kj+noC2T8xVqWIrbmnB+KeS06LK0YQxniF/nm/e+2nBQ5FXI5Rm?=
 =?us-ascii?Q?tD361BbI1mZj/kGVbXdQ4oZIfnk1yzEC3dN60pRjDY5fCyZWGMfquJ5ox5GR?=
 =?us-ascii?Q?cPRRVNwlrW1uHshzlCcCVDaPtN17AAk/88vb6ujPTFOMGBBrknhlkLE4uipa?=
 =?us-ascii?Q?oT5ttf74e77aLb5uaE9o+fJAUjDzT/27Xdro1j49ya8RHHNjLW1fpiV1DBBY?=
 =?us-ascii?Q?UdmrwacDZPhp0IsSTBLZgBWVti+YgOkwpFwktRmS7JNQZpz3BNjWMbsWQQ+Y?=
 =?us-ascii?Q?xzTxCUYw/sWVDpdIzUUCGDr43sUB+3U5/qdPKKl4DrCsTIrkPsn1U5QBQ8mc?=
 =?us-ascii?Q?gn6dfCdofvz3Bjn+ms0kRFv8SI1PXFHWnjT1KomNP2G6/5kFSoCo4qdmu7hz?=
 =?us-ascii?Q?9ko6E1HPA4W05u4I0rNLRXiBhxUdHRbnDXZ4ub0QqAjXUtQALr5udNhaj+LN?=
 =?us-ascii?Q?XUCYaze5FjmuIi+eVnatV/xSSKZ7CFa+y139h3cRA9vVfPhszAokq8dXvNp1?=
 =?us-ascii?Q?/31QYgjMSwOS3ZN4INDZQHVUCa6KTpYV3btTI4+DztsYYRnS+teXAmjqW51j?=
 =?us-ascii?Q?MMmgMYrAQKjCBWMDO8Y2xRpCtK+ADfYCyzVOixWrbaxZ11t+f0Kyi84BdiBX?=
 =?us-ascii?Q?Q6cyFfJKPu4u9ABX3VMMbEb0mygnYeAkeNWvqYl3fATiJjvwcaCX0vsHqWIZ?=
 =?us-ascii?Q?PNSx9A3zdXQ2okyipu+JU4lPgtFd/GBdSLQkKPfnEMaEiEuMvyzeU/Lpfbvg?=
 =?us-ascii?Q?gvycdMuGmr5FUttYFgb9S4NnL0XqCh36OvAYjAF37zTkz9qj9VOD70bsG2vz?=
 =?us-ascii?Q?K9xT0TO05maZ35e174ldlWj+lCuG5IjLVTgwk6iCRsiyDKesDEhJ8g1DnjuA?=
 =?us-ascii?Q?+Cl8putSifFoTTIKn++Tu4vftue3kfNoCfUJHI2kMgUSI/AcRfvz3FgplD9B?=
 =?us-ascii?Q?i36V2BPBJB+7oH3744jLz2oHOCsE+u4S/PzzCiLPI0ywdb1+VArzHVibWg8x?=
 =?us-ascii?Q?YY4DRGBAX2PQ4kexkkiOKSHF3VmWwA0EaxArTNw8+vN85FmvvP6KDwVBB2Hv?=
 =?us-ascii?Q?cCkucViNJVQpBFseeoFmBagccd4TRQGfZOeFUBIGrAZXsHVz+jSona5z42aE?=
 =?us-ascii?Q?06p9Bvf4rC5/eF1QyX4jAsGVo9MDMK4X329XRtbuZn4z8bYGE+g61WPcUOyf?=
 =?us-ascii?Q?UQJbowt/DHSJ7opkf1byGaVMWX+qZW+51sEGTr+4/JQo+4E5iwolHuSM5AWK?=
 =?us-ascii?Q?KwPk1r9/Wh52EXAeFh2XzgL9DjgwU92HX5JSF/tQDBrHZeFRZA12m/L1F9+C?=
 =?us-ascii?Q?wvDZiOAhtVhtSUiLiRDYnn5fUxhrzxtCRQrUs57v5oTj+jrsH+EXlnBVBf9j?=
 =?us-ascii?Q?QNigDeQ47ZsCgbEAsgiv6rx0QP1JwwII5CctdHOh1E3CHmm0kJCVVLKnfKhZ?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4205b2-fc8b-4a80-368d-08db89b26b0f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB3286.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 06:19:20.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKWLBgooFP++HE1DBCq+O35tOBHRLvjpUhYRsMf8HXfMxdYM8web7eYmqniDJ61aNyOe4G5YYYk7OU/oP0raIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5525
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As mentioned below, frequency offset is not used in the current kernel.
I would like to contribute to the kernel so that the use of the S1G band
can operate completely, but I cannot afford it.
Therefore, I am using the S1G band by modifying some parts of the kernel
and hostap on my own.
A more detailed explanation of the kernel modifications is as follows:
1.Function to convert frequency and channel index according to the country.
2. Skip the regulation check on the S1G band.
3. Bandwidth setting for the S1G band and other changes.

However, as you know, in order to apply a patch with these modifications,
there are parts that must be preceded.
So, I have uploaded a patch that can be easily checked in terms of logic
to see if it needs fixing.

We will gradually upload patches to fully support the S1G band.


On Thu, Jul 13, 2023 at 08:52:16AM +0200, Johannes Berg wrote:
> Hi,
> 
> Yeah I'm home for this week, so really just a few more days.
> 
> I think it can wait, I'm not even sure there's a driver that fully supports S1G band upstream yet? Other than hwsim, but that doesn't _really_ matter. Well, arguably it's a whole new feature for S1G, so doesn't matter much anyway. 
> 
> Also, I'd be a bit worried that the comment there means we didn't push the frequency offset through all the APIs, so it would still not work with the patch? Jun-Kyu, did you actually try this? If so, how? 
> 
> But I haven't been able to take a closer look.
> 
> johannes 
> 
> On 13 July 2023 02:37:24 CEST, Jakub Kicinski <kuba@kernel.org> wrote:
> >On Tue, 11 Jul 2023 17:09:18 +0900 JUN-KYU SHIN wrote:
> >> When channel_switch is performed to a channel with a freq_offset,
> >> such as 909.5 MHz, channel_switch fails with the "-EOPNOTSUPP" error.
> >> Since freq_offset is used in the S1G band, it should not be treated
> >> as an error only with the freq_offset condition.
> >> 
> >> Fixes: b6011960f392 ("mac80211: handle channel frequency offset")
> >> Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
> >
> >Johannes, since you seem to be around - yes/no/can wait? :)
> >
> 
> -- 
> Sent from my phone.
