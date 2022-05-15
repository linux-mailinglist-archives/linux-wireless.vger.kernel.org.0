Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099E652FEC8
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344654AbiEUSXX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbiEUSXU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 14:23:20 -0400
X-Greylist: delayed 967 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 May 2022 11:23:16 PDT
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02hn2241.outbound.protection.partner.outlook.cn [139.219.17.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459C6543E;
        Sat, 21 May 2022 11:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuXa36FvAQH/U13fYAVGsvXSNDAlNrHZbBFJV6aA4quzr/HuO01HIW5jNPGRHVOACsTLEE1XEnXFVNahJAwbJw2L0ucrLlDkzBUSo55L4EE7VUOCgWsmEOCrzofMIpF0E3LIhwJq6v5QrRkojH5mG1nqQ1khFJl4Y0WB5FQnmabRNsl+qjCDOsOnFxIhzn9SNomyRk9CazBrV9qc9S6VbVzS/M5YyfZApay53VsCxmUjoPT2pLUdJDgmq7C8OwRWH85sxp+MPoC1O9DkkP3C9v92zMyizyigITzCGaJgP1s2yWFZd4/2ZpHV0RJPjmDiTuR4nrU34F2JgW9UgSXODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=B5xYTaJGJOnl/5jIrlRYKKduv8sOzS5MiPRCFx7Lo6VPfcwKtgUbLkOOtM53cAwbP8Cxd1D6aqdxy2ZSBtG6hdMMmHSOE3jtPhT5gVWA9GGfmEU3uLXEU/5VPl/AGyA9gmpU0FUdYpMDLrOcZZYxHFgX6hbzE7oWkxgpUvIFliuEUfJ+TkZWh7rYjSAYbCV0BBiyD832f9QlvGIx+/8OGDSs5toCX2pVC+YwGzkketrwWufMTDRVpj9J8E1zoiNmlCD0iOCPCv6rNEQVjZbvK73HP2mBv++VKBV9VHIH9CofII7wZtKGrz5zYvdmRIGclVZSayl98ecmPeCXVD0mLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=qjpEOcGdv2D3B/OIEySmRCQUqrhz0cZ8g/ASaluUEqaBX81/6PKwJ4/M+ySq8wyHl8/wXLiRBFNYS3Oiy1d39KA3k3LnXeTw2XPj8cyWYtbkYWdhJFGU/DAoGwO6fVNpQShZx5k55rAj+m26Lx2bX/PXWAuEqzgiXa9v+E+jYdNcv7gq83f2fYbgD9bLyP1n0V2UQgJufjQNNxaKIHf+B0Nm8kbZ1E8OT64sC/TVbva1hZos4/r4H1s7STGEN6Lv4AWiGw9+YR9AY8Qj2n4CI13fIK/v3WXoRcSfJfoXLNv/88v8847FH8qJPUffUJvl6dwq5iMs+yXfxctxUftgtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85) by
 SH0PR01MB0666.CHNPR01.prod.partner.outlook.cn (10.43.106.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Sat, 21 May 2022 18:07:06 +0000
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85])
 by SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85]) with mapi
 id 15.20.5273.019; Sat, 21 May 2022 18:07:06 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE..
To:     Recipients <tianjiao.yang@gientech.com>
From:   "J Wu" <tianjiao.yang@gientech.com>
Date:   Sun, 15 May 2022 12:39:25 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: SH2PR01CA037.CHNPR01.prod.partner.outlook.cn (10.41.247.47)
 To SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85)
Message-ID: <SH0PR01MB0729F034D32103D3BB41ECF58ACC9@SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf8bd70-7a88-4c02-cc26-08da366ffec8
X-MS-TrafficTypeDiagnostic: SH0PR01MB0666:EE_
X-Microsoft-Antispam-PRVS: <SH0PR01MB0666C243D9C8D8AD563599B18AD29@SH0PR01MB0666.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?46p5WoMwwZepa949qQpGR9wGxNGxi8E8RtWBUpB38thyKKv+/DDw6Qgceo?=
 =?iso-8859-1?Q?cHdTWLvJnsCM9FvrroDcE25ni72QZ49Bkxny7F4F3LqH+GtCj5u07qNLKf?=
 =?iso-8859-1?Q?tFjXAI9v+r5HnH7yRWXTx5nB+iS/JppFRj/gPMgq3juIGUI7FYqtPLCrQR?=
 =?iso-8859-1?Q?JpuexNRy6bks0LgCvfG5KmLPA30OfjdNOO2rJubR2H7dyoZRiSc1U7uJQH?=
 =?iso-8859-1?Q?Wzr8ODAuSqL8l5WbgDMvlpqkf5s4xq/fSPS2UMI9J3eyKcmn/ROsBR/sw2?=
 =?iso-8859-1?Q?SiVm84cW+jpY4G+u0lwWa+9z11w0oBuuzZUTLS/5HILbQNSWKegMmL2VUa?=
 =?iso-8859-1?Q?z5l2HEOMmQHvMvZLCQuNpm5M9UAl0d4cvFR+v8GwaB3gTUXKgYsNhopQQa?=
 =?iso-8859-1?Q?X/2GZEx9kMUEHoRCz7Xn/Lz6oSGk/yNoL5yH3RumNB7f4/kMmb9TQK62YR?=
 =?iso-8859-1?Q?Y7zQXtULmPS3WQLL5yxvZo/O0ML0Lw/hxTcpqen3Lg3RUD8hIuZTTwQjyY?=
 =?iso-8859-1?Q?IiTyJAKU1d0WsD/vRj3J4NbIcpECtZJvrnV8Ss3RtHWCrTOsxJTlxtDc93?=
 =?iso-8859-1?Q?PWQ0UzsfY0Du5MbrroNiC28Wqd+cS5jtmZJogVayU4hQ/XE3qEnzdPXFGt?=
 =?iso-8859-1?Q?sIzjTuPC2uDIjSDuicravYQJG2isY3ep8kP/sMb4uk7jc0u3vFJL4O6cyr?=
 =?iso-8859-1?Q?vXDZOQHJlktQSni7VUHfVUT4q/pWmCe2wXQtczC+3ROP5SmbnEtSmt5vVK?=
 =?iso-8859-1?Q?8bvIllYRQdD6P377SLq999A79H7fxY4kF9XHdjTvyY9GE3DRH1UZHLCcYs?=
 =?iso-8859-1?Q?4lK+8tXjk7mJmRaMBBSL0n71xDVVn5zAzfKtWoLq6eyoGnQYebrWQv1iSM?=
 =?iso-8859-1?Q?AqjssusZzCHAzTvS4cOWtfc8mcXvQTCeHWQ7Yrhl+fCU4TygYQl4GdbGMo?=
 =?iso-8859-1?Q?8U22nepKYH5J/SI+Acs+aRoz2jjeOIza3iiw5m2GYadl+7DQmvfvMQB1+I?=
 =?iso-8859-1?Q?OxplmhI32dXs67A4f/Ek1MMFIG3p8ZW3Y/otvHjHHpz/Mo+2o6RWkpqEoE?=
 =?iso-8859-1?Q?zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(6200100001)(508600001)(19618925003)(4270600006)(3480700007)(33656002)(8936002)(38350700002)(38100700002)(2906002)(9686003)(26005)(186003)(40180700001)(66946007)(66476007)(558084003)(40160700002)(7116003)(7366002)(7406005)(7416002)(86362001)(7696005)(52116002)(6666004)(66556008)(8676002)(6862004)(55016003)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gV/BiX7xBq7+a/BwD63fwridp+2yYk158+FDxzxd+zT8uOVJFuGACPmzpL?=
 =?iso-8859-1?Q?5ATG0N3sHublzULunRSg66ZL5GU7ZMPLqBctGNViGlJyiGKSDM4W/QNCMT?=
 =?iso-8859-1?Q?pDJ8Xb0RgsPZ61reyinMVBKa/mJ9wRSUfxL8rXpCuPunXUDAx8HIz0ge2T?=
 =?iso-8859-1?Q?F+yaYrt2bxscU+sIycemH9RogtRwsjOfEpNssa+vgxLVlS/LT91LGPxPIS?=
 =?iso-8859-1?Q?grzlQHkN8q9SpBTvvf4Twtv69h1bqpsKmJ2QkSk9LMfb+k6jhFTJWXlL/a?=
 =?iso-8859-1?Q?b3bXUdgPtmpFJn3doX5a719ouYn/2h74fnjUUSyl33c0R/n+D0wPsM+HBe?=
 =?iso-8859-1?Q?aAe7qS9oG8018mtkNX4i/suOJ2B7SUs1kZOHOYY/oQK7hNtiYQGTBt04OX?=
 =?iso-8859-1?Q?HZBsOQ2qgdTKlO+PjvUgvYO8FOGpo+gUlMpF5Pgu4lMSvzTEasKlOUVTg9?=
 =?iso-8859-1?Q?GDGtZsY1wqQH/KfUNoU25OYC/AGbNSIMSP6r8UOIFuSKGZWp4xGnaQOKBm?=
 =?iso-8859-1?Q?gBO+saR5P0VMTmTRYelG30iZIo+0nE1Cz294dA5fgna3MYc+gvtb9Qx9qB?=
 =?iso-8859-1?Q?t+Hs2rI/R0Eqgdrdd7NZJqEoO0GidkVEPhX3VKh/odD71Hka00t4AnjYD5?=
 =?iso-8859-1?Q?3XgPaRQ+vsv6iFquRrCdz3I2QrIII/O7oNWvqVPejsJgES8j6sXDW1/ukX?=
 =?iso-8859-1?Q?viRoWxHtCmnbhLUCChBFI7s2ohD+kHY+guJ+g/iXs6f/L2NW2H9wf3dIFm?=
 =?iso-8859-1?Q?+52flTQNRoFI8OIKxG8RbfHSLf1zZd+iJF+V3wD/LKq1KUG6c+BI+W+QI6?=
 =?iso-8859-1?Q?v/rOo0lIFR445pUP8GKHJ6H2YM1orfp5kTbtoNpwaKp4WHUT8f+23BnkQr?=
 =?iso-8859-1?Q?bDcbY49xnIDsxqxGztZtz63AjtnlYeh67jrjT0NunU+hkBML9TrWGVrTS3?=
 =?iso-8859-1?Q?IZRYW819gx7N9K6O8N5SngepzMmhQQ5Y9KFU0PJgkwGYqe8dhcAc9o5rdn?=
 =?iso-8859-1?Q?arySmrdFf6I8R7Yxn5iGniNdofeH9OyMhT/q1paazAF7cicDMD8k1+S2Kr?=
 =?iso-8859-1?Q?UievLerwKN3LOM1kEy5VbhPhpW1/wHbEqqEooFSk5WeMj3cuWF+g4KcFs7?=
 =?iso-8859-1?Q?blBCiFV1JuqdHw1fb1KbQNcJKCKj8rrYWb1Tu9EIMmCFBBnb+m5UX/93on?=
 =?iso-8859-1?Q?KLb/vyekXUpZzIEW8akMQuMTTPzvmwAstX4G1fZw/Bk4IdOg+jDfPU1QS5?=
 =?iso-8859-1?Q?H19AkhzatlLRCltmjwT68cNlEm1lQtBxnWgFR6DZhsvTd7NEIFEnfWcsRa?=
 =?iso-8859-1?Q?9l0IHBSgJ2K/ueN8OdJQwHDGGiSEWj/X0ixsSG8AXl5O9KHtTY+RWeOD6d?=
 =?iso-8859-1?Q?UMRZL5mfjQlYVVjTgXjhxYr1ME+HSk3VuImoKkvzEgp9QAPp7t++9jGLYG?=
 =?iso-8859-1?Q?2s4jGE2VpP/MeDmiZ+jMlusowjC6eJ4+LhMgc2pIbkYGRMmsn0KEH1tW2U?=
 =?iso-8859-1?Q?fFemHBbH2lv/sSK1vg+ErtGHJP5UmzzFSQJUy1jUPUOS34fxJS5gKVpTaV?=
 =?iso-8859-1?Q?9sD4sNlLm8oG5KAlXd2todkEbv/i2Jjx5pHiDLA9+eFQ3dHcxMOLMB7QS+?=
 =?iso-8859-1?Q?z21YeZlnDuM7nQ+ROe3LdzmRTM2ht1kehp7yEQZx+cenGYf1VIE/oXdxzq?=
 =?iso-8859-1?Q?5V4T3bdpEDWEvm9hKL2u8MeeBER/G+IgxohZxCVwNeLYxJfT4q/8gV8xmo?=
 =?iso-8859-1?Q?NoJs80UZLIYxw2eIInizoiXuc=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf8bd70-7a88-4c02-cc26-08da366ffec8
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 12:39:47.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g9EmpQzizJrjFxL6470Mr8XSsngbB4IyYR9bZMHcfHFn0gslr0Q9UTF+zKMGxvRgsyBfppO/gs2EBHZZWNK0Aa1udZzOY8RDGFkrjNOJVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0666
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_96_XX,
        DKIM_INVALID,DKIM_SIGNED,NIXSPAM_IXHASH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4895]
        *  3.0 NIXSPAM_IXHASH http://www.nixspam.org/
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  3.4 DATE_IN_PAST_96_XX Date: is 96 hours or more before Received:
        *      date
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Can we do this together
