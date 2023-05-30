Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E512716E3F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjE3T7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 15:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE3T7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 15:59:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE16E8
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 12:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFAQWZWzMMd8gqAbJQ4m+/pMaAmf4agPN5+sr29Kk5bcZC3+l7qNNrcL2ZVTz/UXRLuRaAjzR6sphhrioWbBRfd6TOe1vTTeVs3MoYe9ksHyK6VX4ULW6yIUZ0tOqWiIcDLMQUyKAE4+gJo8AlwqMx6vc3yZhBQdne+MROEpGeESdarGglxn6iEsBxA7tYcM2bVbFrpkQXDKqTujzA16O7j4vtxnFngoHwuLhJw7SZtSWSWl2JSYOpF7wNMrYS/rsye3uHAeDd2WrhDF391i2LYgcG0pbYH0jMX0dCjrYO+O0c2v38ewX3B5dtP+M7KeFwjAfEFfarMvT/aIhI7dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNR60VgvLTajGqIiYDPvGYah6lM++2NBj0J67/F89AA=;
 b=nSHGSOy2uzfZmHGXMN9MUvPxzni7G2RrPToOpGhvPTIKGHEZ1jnaxSjt8Yp1q+kg3jJh/RAFYSw5tYMTb8dj2p+NxgBBGIq9tZan3f5xJzfcp+Dl5OEkYuksQrAkDoD519rpKUu6F1mqe+N162kf84/UxHWCPARkDgQSa8digqXpTixl43VIRik+KkL90wS+45hbur38dQf6pJenz/ozPSQFoYPZzGnsKZMiO1rYM+NpOS9gD0hHeWQG1JIxNlDspGOm1x4YAVhU6lQkbPf0rU4Kcvq4o6jFeYaTQdhFQo2HYgagwXNB6MmBkigoOywr8K83wOOuig/8PZ+07XUUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNR60VgvLTajGqIiYDPvGYah6lM++2NBj0J67/F89AA=;
 b=VEPKMj1YHgIaGrgBtg3/UbEg4uw4HlmTtstAZCZaTw76E0BM1vF+bT2p7EjHOSoZWZLZ7wBmVCMWY2OzBZM4H5xgLIv7S+2n++igYSNMEJ8jfDYPkxc0Xn2IZdz2oemrD3/cWUECp3Rps4q8134zCUDmR0ARGX4aoMs2CNLTtrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4839.namprd13.prod.outlook.com (2603:10b6:303:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 19:59:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:59:11 +0000
Date:   Tue, 30 May 2023 21:59:04 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pkshih <pkshih@realtek.com>, Hans Ulli Kroll <linux@ulli-kroll.de>,
        ValdikSS <iam@valdikss.org.ru>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Tim K <tpkuester@gmail.com>, Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        "Alex G ." <mr.nuke.me@gmail.com>, kernel@pengutronix.de,
        petter@technux.se, Andreas Henriksson <andreas@fatal.se>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wifi: rtw88: usb: silence log flooding error message
Message-ID: <ZHZViIRQP0IZGu0r@corigine.com>
References: <20230524103934.1019096-1-s.hauer@pengutronix.de>
 <ZG32XKBsAub+Y+bO@corigine.com>
 <20230526101736.GS17518@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526101736.GS17518@pengutronix.de>
X-ClientProxiedBy: AM0PR08CA0013.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::26) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7723ec-ed28-4b17-0c38-08db6148560d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyjcNerOlhbeGkxL878fLI+eC8Bq3r5GwWneoSiRrT1TGDj9ofSU9OkTgK3qZxJfcMq7WcENHpA/HwJB9yRFb164DxTQyTpuz/hdixXJvp8RW+4Se3F4GOXVfrwFOmUpVsHBaenqzu6iWAcmFFaO1HPCI5ChgdUBWJO8WWHpMtwnR1XaZwbukDQNjoYq82rtWgL5VMu2gVOsmy4JylSwPpHLoEDnq09ew56K5zi2XHQ8dlfHJxDb1FB4dDqhocy1lPD8666hpJJYwFpdyGt6LbQIgIUSWQ940mmhI8TwXFEGzMe+JEbUpe/9oYDcIXd0Yt8ifMjvCEGr6czdLzIlUH0v16dpdHEk4YDkFU2Z0XogYczSis7nPmrUPU/QMCxhXp/+1IqQ1M+CXvK1mQb4WsrK+vvv3BpAQU4BqeFrpMfhjwKnpxlkCgWEwFlmEF54Plyf5Z58UbC5uU6YWk02tgKLdVJmHSsr1kRPuOvJkt24FiiBdd0ihthWh8aDgTqRWiDFIEGP0616AzLneDYP6MU3o0SU5e/feLPXo5vclHdFmadmKgcU+eLZ1Fl7NXudNfLT5awjsmI+Fwlj2WDQ6QnKDy+jzeL/IZM8HnoymQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39840400004)(136003)(396003)(451199021)(2906002)(186003)(6512007)(6506007)(15650500001)(5660300002)(54906003)(38100700002)(8936002)(8676002)(83380400001)(2616005)(6486002)(86362001)(41300700001)(316002)(66946007)(36756003)(6666004)(4326008)(44832011)(7416002)(66556008)(66476007)(6916009)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZnQZsVYEfDo8FIDl2w2dzcr5P8Bc9GC6v0cFzP1UTiFw9riyK+2iAos53OVt?=
 =?us-ascii?Q?eCIizqEbeOBIALFQNW5l12po/SQaakxTnngf7rOFx0OMLVdj5wNwLMz1Cg5i?=
 =?us-ascii?Q?65ahMEdZZolUqIxrJRt6qlqcN8+8hhYqozT4fFr7zxhq5ctPhj028taLQL1m?=
 =?us-ascii?Q?cot7HItx7H1jcrpYdhvKXFF3BEl2Kv9MJMme8xzB89kZS0Vzhj5M4d9KDKPe?=
 =?us-ascii?Q?Y69CDWnX94E1HO6uJoU9CCOTgFEazY8srSRSzqbuBedwC6SJ/p2zhWrqaFra?=
 =?us-ascii?Q?V/CrWT+VmoriIgoYSynZ3IB/TRnY99cf/+UP8bITmmMyalwKmrEXL1E3syRS?=
 =?us-ascii?Q?wQhBlvlhu1kqwyr1fBt/dLL5b39KflUpXPIQFigkUxdyHT0K0W72fa969lgk?=
 =?us-ascii?Q?7YByGwc3w/CSDmE8j942YT4bkpxCCS+NOquN1fyIBgU+qwzXPnp6yN66ngYS?=
 =?us-ascii?Q?atr+pNlehK3FMmGUw2KiN4a/uiAYWBHi7wYxinPvEZYca5i6U3kEnqGofA4W?=
 =?us-ascii?Q?tV0iNAkZkKXuxcopFkPzyMprtrKRigfqdGjyPW7QuxcrOMztnNdc6pvB6l6U?=
 =?us-ascii?Q?2knQkhxu9pS9hYA5u6sdnP0DePKQeOTw44Hjk715EzkAMCll8QF0HV2u2Ng4?=
 =?us-ascii?Q?pzWU7SffO6tXe1q89njieVkGGl3qdNvNC0gAQDQBg2KIsyRMgOvVsVPTTEmy?=
 =?us-ascii?Q?Q+j6pGT4FPwVyJO9r+c1kco/35n9IboVkpPzXTLoghcwXmkmYU5hDtd0n5p/?=
 =?us-ascii?Q?fNjyXnZdORXKbt8IlBtW6mopNTmq2mJbYtP+C6XnVa5RDAwTHpUF0ZIo3F3q?=
 =?us-ascii?Q?zes2ME7WN99bleeSlLGGNEehrdpNcPG9FiiOxHFpilAy3j7V9SBfKIZCsBzY?=
 =?us-ascii?Q?Pux7OsDfUNDUp9qo5/wo6icqf7RXF87v+II6pQsM7hYucO+O05r6xjsWOSXc?=
 =?us-ascii?Q?AQ9FmQYtcKSYHlU1jyUHpF0dMQHfvOblt9Vs+Z24ic9W4NFsBB2LMWdHYqkg?=
 =?us-ascii?Q?4tXQrXnBZIaGaWKlqfE1FmcxnmVwZPrml6NocECGe4YgKp2Xy9brDUvKK0Fp?=
 =?us-ascii?Q?UWsaNtJiWnxPsRXbJInuW5JJctKvWn+r+R/72b3JdTLmtXzYCVzkNSddGRuf?=
 =?us-ascii?Q?2cu8UrEAWgkgILEkIMlpoKUKimQ8twoJsWb+K3hyphGelazpaPQYsQJNff47?=
 =?us-ascii?Q?SWLAKCbPutSPyFtdxpHqG/Oec6JxJfeo2rR7brzZrAyTVPvkv8xr0aDpNViw?=
 =?us-ascii?Q?yC/1WVHiIxW7iOJdaMX2qmOd7JgEkmF6LxCjLUlBpu32f7b91g+1CvFl0mIJ?=
 =?us-ascii?Q?uAudJFeDFofOXvYF16O9uvDMp5UmbIxQGWufGJTgzmITh7u+MjGof4tZnjmB?=
 =?us-ascii?Q?ncf9mehH/vNHfQBd7XZg0hhldB7vY+aaeJsBKoKggBsy/B4fW1O/KmnGFy32?=
 =?us-ascii?Q?1XiLdxhVErPq0czUJwcBQWPd306q+NMbFPESwBc16jwSAsTcFPwxctNs/3Md?=
 =?us-ascii?Q?h+fe0ifZxkNxE+25ROujOxW0DNQR0n/FhHZTS5mi6claleDXDO4vD07lgODj?=
 =?us-ascii?Q?DvjLd2SByO9febOELsxPbJt3txmJ2aCAifYaPJQXvtJzVqyo0RCReAuXoZNk?=
 =?us-ascii?Q?V4m5f0xTivjYyvv5OuCp5Fdml0WSMF6fHzUUfIJYh4ECj/RYNp8KaGFw2Zx+?=
 =?us-ascii?Q?mfo8Pw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7723ec-ed28-4b17-0c38-08db6148560d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:59:11.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wonDxq0DS1Sipbn3uch5+KSY0ymNH8YOVeVTcWaC945GyLO22j3ylNg5fjp4RWa/tZjmAmp66PLLOM6AKC/OJQ+nNRR1+JKk1MRD7MMvE9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4839
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 26, 2023 at 12:17:36PM +0200, Sascha Hauer wrote:
> On Wed, May 24, 2023 at 01:34:52PM +0200, Simon Horman wrote:
> > On Wed, May 24, 2023 at 12:39:34PM +0200, Sascha Hauer wrote:
> > > When receiving more rx packets than the kernel can handle the driver
> > > drops the packets and issues an error message. This is bad for two
> > > reasons. The logs are flooded with myriads of messages, but then time
> > > consumed for printing messages in that critical code path brings down
> > > the device. After some time of excessive rx load the driver responds
> > > with:
> > > 
> > > rtw_8822cu 1-1:1.2: failed to get tx report from firmware
> > > rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> > > rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> > > 
> > > The device stops working until being replugged.
> > > 
> > > Fix this by lowering the priority to debug level and also by
> > > ratelimiting it.
> > > 
> > > Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> > > index 44a5fafb99055..976eafa739a2d 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/usb.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> > > @@ -535,7 +535,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
> > >  		}
> > >  
> > >  		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
> > > -			rtw_err(rtwdev, "failed to get rx_queue, overflow\n");
> > > +			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
> > 
> > This is certainly an improvement. But as I understand things
> > it is still somewhat verbose if the condition persists.
> > Did you consider dev_dbg_once()?
> 
> My rationale was that dev_dbg() is normally disabled anyway. With
> CONFIG_DYNAMIC_PRINTK you would still have fine grained control if you
> want to see this message or not.
> 
> Personally I don't care that much, I would switch to dev_dbg_once() if
> that's preferred.

No strong preference from my side.
