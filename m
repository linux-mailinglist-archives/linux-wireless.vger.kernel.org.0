Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7EF52E3D9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 06:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbiETEfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 00:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiETEe5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 00:34:57 -0400
X-Greylist: delayed 896 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:34:54 PDT
Received: from CN01-SHA-obe.outbound.protection.partner.outlook.cn (mail-shahn0099.outbound.protection.partner.outlook.cn [42.159.164.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3D11801B;
        Thu, 19 May 2022 21:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U53Sc9W/cvpZF6Zg7ExNgusicyH8UbMZA5IMjXFAW0Knkr6+YZisXkl5gnuskxkeMY73b2OWsvRRqgWfQi9EYYum/AbTIn2R79VZ9f0Pc72AsZbPiPVy0yO1P5VOcVtlDoE1NgmCQ2xFLgfW7dK06x/pW6e40Nqcu0LL8St5fnmDeKpProtr4ujEfdO+EbItJGeSZXodrtPyCq0Wcoh3JaQtZyTG06xsVuLP/L9XBFk623uzSz5Qqx+BVGtLoA+kZlkiqhGuflmP040YHegVuBM52MzEL5Uu5uGbCg+kY4Tj+91p2Xwb8eCy1L54uNL2F9T0+OZCdx+ZGryp51zJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=DLVYgyqK1Tc8RT1DzbVlphEZBDaO6ooU+sljOK4Kwe287cZ+jSjSUppqBqgnB6qes1ecG00W2XwxxDRoAyvab7vmBgGqbmASX1oEx6v3/IDji0W6ypwD0LcYFdIqd/VrqQByixYNZ0L4aaCCarSt8qj/4C1l3JASB32HXe4uHKDpATwOmRKDL0NRBtx7b41vBQKmSrsTMCZOzn2zr2VTwktwvNFRtpJ8CIHSSJ0juXvnQZJ4vhxtr+VCr++IewdxAiJR0uAR0A/mLCfdmF06tqJewYUtLaBbmVFDqqalTTB9ZGE5lRLOjP13EWEVtWuMMGk4mT/bXC9lmWi239Klfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=jDaTucfQIdyn0lcdd6uScrYEtiJuc02Td9uODmxhKEd1s5wWlb2tRet1GckmudstGc4etC01C0MBUQ8g0T7uxBRcv/nGdFIcXNZufFNp5sc99qC7MMjPDvrtHusT0GhKCTy9TSodN49+iA22jDWdnHh3/l4XEp2vEY0e/9EG46FZCi2qol6Nl9wJxEwuplhURDtKHvWE/m4YWQ+WPDZA3/Vh8IbLDh5IoEyJvfAw/IBHTe+3KVnmJXd9N0effb9p4CtQRa3rpycXVGm+s+HcdDyVpslNQnJKqIWW1+DfQU+zDApo2lRdSsapNP9zpaMhhF4Q7tbOjc7JeHB8FsjC4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0509.CHNPR01.prod.partner.outlook.cn (10.43.110.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 04:19:56 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:19:56 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:18 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0015.CHNPR01.prod.partner.outlook.cn
 (10.43.34.155) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB0623CDE66AD90B4EBEA7BE6A89D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1285adc9-e304-4310-661a-08da39141ffa
X-MS-TrafficTypeDiagnostic: SHXPR01MB0509:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB0509287DC1B285E160A5050789D39@SHXPR01MB0509.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cm1/ZaWoOumpk/++hFlvUcqm3skW0XWmpu6WJXB/0LW5bFZ31KSHayvhM4?=
 =?iso-8859-1?Q?lt2oZbSoav/xN5qvSf0sfzHiT2D9tt7Bm+kIcNjwIJ/c2NbpFfRLC8IOsd?=
 =?iso-8859-1?Q?ve7ajqh/gJ9Dir6tvQzfYfR9BR+wI1YvR92Lq4STABN1o8H0sYMB3MWTYw?=
 =?iso-8859-1?Q?ElIT0d4TgJEnEnx0/dVaaE5+Bqa/cS8tCjxXKonvJXwUpLtjWkQU/pxR45?=
 =?iso-8859-1?Q?ij9aIuU447nW2tVeYxHhpxyFqi8Pfwc6qv14ox+DI8RkcpVulq0zpuZYRD?=
 =?iso-8859-1?Q?TN2Jib6Ph3lJsk2jEKfqc2mxMiKh2QpXw8njQXT+TOLdgFneoPhMX5qaWq?=
 =?iso-8859-1?Q?RN3fVn8RHWzdjdIotiAUXt0qIzyoyXSyXsknI1vpCfKX64lUfrttqaDMNw?=
 =?iso-8859-1?Q?XjF01X33zP9bS19SSw/hxZnmAfBIqNMpS+C+9iNIMGENcF36G3nfOUK1Z4?=
 =?iso-8859-1?Q?/EXCgJbUzRltYjWzezJ9DdL+noc3OwXfkqHR5/7yn6CmotZECGKJBnfX46?=
 =?iso-8859-1?Q?vL3c+TJ/7tYsN+l4OHUj12voP/qg/Y2l122a//wMpCmZa610z5fUpSqrdq?=
 =?iso-8859-1?Q?mU7rSh6nK4CXd3D/a9TSlIfV6pbQ7SeEm7jqF4yWQYhVe8PUZqPnHCtwwe?=
 =?iso-8859-1?Q?BLfUBxgYD5qQITq32U+TgG2rbZhRNRVCO7XD0gbgjLsOGwn0DerNBnWIEY?=
 =?iso-8859-1?Q?uRd4w1iAysc4MndAPlN+8vkTxwO0hCjggEeo+im61bDdeEDwjZe9d/syMw?=
 =?iso-8859-1?Q?XouLeg9l9GPTsgdt4JCiKkXKdBx2KKF5ZBF3LzMpqSw3aPx19kMy6Qhs+M?=
 =?iso-8859-1?Q?XcBv4duq0sv2B4hO29OJGdoBPaSJSj30gxXZ02kl6p8KpspowFILWPjEF5?=
 =?iso-8859-1?Q?q6v16nAu3ns6sWsg6v2W2Ja/D3UF/JD+RlxFvPsOJy9vaQneKtZv6pfNlx?=
 =?iso-8859-1?Q?n0M+AHaVodmJFd6+EIszRRBBn+ygBa1hpjvNPuEywkSEttFpgj27G9TJcW?=
 =?iso-8859-1?Q?H5ni7eSpZsvouhs+VnlDRMM1ZwaoMGTLX/XoI1wx7gtYRgg/tufKHespEE?=
 =?iso-8859-1?Q?iQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(6666004)(52116002)(7116003)(6200100001)(40180700001)(8676002)(33656002)(40160700002)(558084003)(4270600006)(86362001)(66476007)(66556008)(66946007)(9686003)(26005)(3480700007)(8936002)(55016003)(6862004)(19618925003)(7696005)(7416002)(7366002)(7406005)(2906002)(38350700002)(38100700002)(186003)(508600001)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?20VE92N5m5+eBcutZCZuePzuuVgjOyWjIIPNE2gmQ7V523KZZlZIgt36Lg?=
 =?iso-8859-1?Q?yS4mAVvoUaE3k7i8ZRSepYssU8kLzvijtjzlVUtm9+Z5DoFO7LKUGC44Fc?=
 =?iso-8859-1?Q?oCdjxt4avJXbEYduxwN9jGv9UqCM1W6geDz5LYEHzELe8bZ2J+g2pa6/eA?=
 =?iso-8859-1?Q?vdmcmATgQMRHdZCkH2/0hgQBBuikmJnPQ7sPnGFsEeEgnIbD+NgiLKpHFU?=
 =?iso-8859-1?Q?dtKFMSnn8ZciqIE4N7C+gwQKzsenjTI/SFEYkzz5sNXX5FLiSUs1awltYN?=
 =?iso-8859-1?Q?rl/w83oIPuzJsgrNC0P6gCH45ss3DyrsdwPatveeisLBtk2ZUBxFYhR1hp?=
 =?iso-8859-1?Q?Ma5dfJHz/KIVpKoinytEZGzoJ5wO8wGaiyCk0O7XNZ0xkSEDp5lM6Unus9?=
 =?iso-8859-1?Q?lQAxEaVtru/c4qCDP7He2Q5yHkl0y622aXmRpvnFlfT8erefFszHkhaUG2?=
 =?iso-8859-1?Q?XI8mFg+p0v4b0mUXPOtQ782mlFUnX/j7wEY8shgaQofxPR3xL4nu8YCEut?=
 =?iso-8859-1?Q?w2ldEHysbGNRHfzkqaTYVSuecqkpncoYdou/0k2h7xgQWKNnbo5pUdRv4O?=
 =?iso-8859-1?Q?K0JVRqyhcrS6iVMYYOYX/DLvMIrkS6jp+jA0WArk5TNyXb+J4Lmrw4QZux?=
 =?iso-8859-1?Q?bNLTyGGWJeM41W/4muBitoE+mjITHeWc5ax5XVqNSjmSumSPtdWWek7twX?=
 =?iso-8859-1?Q?0wX1tIvp1zQir6jziKyHvUMN9DTZHw4YMjhzF1YCJUW6fsA3fE+9Org1EA?=
 =?iso-8859-1?Q?gdqBxLGZyI+BmISlVD9NrXSfonxV7hRPw/GCxH8yotdpxqEZp7r2lCU+6X?=
 =?iso-8859-1?Q?eFMA7SIeHCT43JXDQvlEqg8Hs1tQUeWJIIKWINmRAW6rPhAeBXCdNHM3yF?=
 =?iso-8859-1?Q?CPcO5xT3FOM6peKVPeeIaHApIZ2tkKFe/LL9bMgP+Pg2+JRUxK1aiByH8r?=
 =?iso-8859-1?Q?Afhoi8jg4kwWaxn0Az6zKQYkNe/XT+MW7K8V4eRa5+QsYcw3wvv/rurdvB?=
 =?iso-8859-1?Q?jevt91GH+KmQu6/uZ9pP7ODAsUUdP6je8Eoa3UMrV8ehsP+W+F/vBjirTm?=
 =?iso-8859-1?Q?Q3fIWqhBrhqq+b19pwazZfieR/xEpsV2wzvC9vCHbjMVLxai43aC3kkpYJ?=
 =?iso-8859-1?Q?oW1yHpU5OJFsVoZNNYxnEfUEKIFVCEROL7EcKOBwkLoMG9PDeuDjKbxMel?=
 =?iso-8859-1?Q?CokCk1aVI5IgUyX4oQdhGKnUJyFv0BflUEYDL6ewTIAcZvaJxCP5vJNJA7?=
 =?iso-8859-1?Q?L2n7+OwmUqdQu4E5ehU1Lh5zPzov7O/VHqOqllLqRvg3dBTv5RkR357YfS?=
 =?iso-8859-1?Q?NaUfCCSMC602Z6jARgwFuQSoeXa4STum75WIN/9U36zYNsCN25Auv/q2MC?=
 =?iso-8859-1?Q?awzVqw4M9Cw0JJbjZUEOQSmplCF4F/xCqyqDVsDm8v44I1g+voN+sS0Gc7?=
 =?iso-8859-1?Q?QMdccGdMP1aYYKDOWDtvxIuDneWN4nJM8y2CICB9upkLOIc72wWLuCQKP9?=
 =?iso-8859-1?Q?/cc9h9GaEBlSuCg9vwa6lSFzr7OFZsCskCM7f2OJSorGpk0ZT+PVs0/hEo?=
 =?iso-8859-1?Q?O1MXoVU9/jhf+0tuxjJaHMxCKFc1KrflSlwqKXCQsQwY9vCoPs225/+RYa?=
 =?iso-8859-1?Q?dnoEzhq7nWXwMSbSGusy4u9oPmQB7Kwld9Ud/BYOxM/fI7Mj94X1GMLJGI?=
 =?iso-8859-1?Q?ED5/y+0NnGno2N9tyeCHz1r0dPcy0j8k2qgDAJ30K5iD3Ryp/vYMa5Ovtn?=
 =?iso-8859-1?Q?Dq8g=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1285adc9-e304-4310-661a-08da39141ffa
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:42.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPRZmwQ7fsDsbbUNOZ7BcXEHImA3ZnCm/zzwAHOc68LPad8GfhrGXB4JyRAMlyEGVNzImiiNgPIaR8Oo5Qn3yS8oAtj6RY+3OUj2w4wAa2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0509
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_PSBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?42.159.164.99>]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4705]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [42.159.164.99 listed in psbl.surriel.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  1.3 DATE_IN_PAST_24_48 Date: is 24 to 48 hours before Received:
        *      date
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Can you do a job with me?
