Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC6559BF67
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 14:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiHVMVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiHVMU7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 08:20:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4533A36;
        Mon, 22 Aug 2022 05:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX080vzKOvR1essSTy/9wGbWIodyqUb+6wpkiYs5rr8q9+swVEzKvAaJXzb1nNFLTRaICGVo6qhyEpu7ZGOAfGLsov/Zln2XSaIZRaoOBNVfNUsOcNPmTibTANseGO1X/fB47OCSarV4GnuSpOxyt5ta8PaCSEcZBNTgpQPHzwPllSKnl4g585c/l1chMoE/f+6tHx8Zz5Oj8hM+CVAaicdxy3w/f9N0it9XTIlgax+8HIL64dnaA9zZJOq911rJKUjp3M7d0QP0LvpEMJRq7fc6+NzIThmxJa6yAIyXyh8eAMKfak8lMOAVxY/nmCgo0IGGXW425YQ1i7FKmht+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+U1o4pZkwO3lTH9Yu6XQM6+qfa9K+7h2X9IAJZXh84=;
 b=EOY5NjKwGYigzzYw30L1RNQPczyRk+1Ddfo0aij9ixV3GVI4T1zojc6KYNVuZ1pxTvU2dMGKIror2ljzKI+A5C3OLEwoIiAl+WEj/0qj7NqVTtrgYc6AMpKxl4Y33siLHqUJBviVI0hMGalHz8DjdQetZZNFhJwCSuh+a6c6wxQUKiXIMmqusJ7CSz3zTjCQVM0abf5rFsfL57s2OUfShrXE/tQdXYewnzOphaZAHCS7yBlAZt/KuA7BoPgg/4rVXU083848dHPQfhMXIpzAgXd06KYmhagBFarF1z4bvA/g08EAwPBxZI0KOVxnvAi2YuYkqL6tdu6xqQOzrnGrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+U1o4pZkwO3lTH9Yu6XQM6+qfa9K+7h2X9IAJZXh84=;
 b=mle1x2I8qFG+mEhq5LA7vqXpPNQHEBznActwtR7O7xjejLUeGY/8KwJSr2mdcLDykNvU6i9jA4H6tb2nerNZVFB9vTB3s7AOj1hmuqvjdeeloli/Ga1Ddp2kG8wQcydC3v9pxPqiXzOM37/hV7v+M2t95QEPWTIzjDJpab+GRLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) by
 BN6PR11MB3938.namprd11.prod.outlook.com (2603:10b6:405:79::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.19; Mon, 22 Aug 2022 12:20:56 +0000
Received: from DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::54ad:4f63:71df:fb59]) by DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::54ad:4f63:71df:fb59%5]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 12:20:56 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wfx: prevent underflow in wfx_send_pds()
Date:   Mon, 22 Aug 2022 14:20:53 +0200
Message-ID: <2729343.a3EqFhE7eK@pc-42>
Organization: Silicon Labs
In-Reply-To: <Yv8eX7Xv2ubUOvW7@kili>
References: <Yv8eX7Xv2ubUOvW7@kili>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SN7PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:f2::14) To DS7PR11MB6038.namprd11.prod.outlook.com
 (2603:10b6:8:75::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b677611-49c2-47b0-ade8-08da8438c3ee
X-MS-TrafficTypeDiagnostic: BN6PR11MB3938:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZ/ZeVGkaTTbh2jdG9nGiLuduEaH4pM9u6XqqM/6uzyaWxD9/9lHMmAs7Vz7HdVevg+BhHmfE10t5GQwXRkMP+TG1lZ4myYolqtDLq9nmhpN7/ZHw3OXAOgKWiSiRMCI18tBaq3Y4Sngn4pJ7mhLICsO8IlI21Xc+PtrtvastZJqbQ3j3uAvYdgnwUxs+JO+0ssfxSrqI03mxWVM9MwB0po73UJ43dVadbOU3KXDe4FLvL66BUwKlc3vdLDsmmjEBsbKinpjtgzK+GpPsJJef2WkS6q3oLpPFstYuR+J9o4HCuToNhVg+OrKSrgqGoMBoBY4AYJwo/Olx+y3VH24+Eac97G5bD+czLroVW7iOewVtz3G7PZyJXryOBrVeJfal9oMk3jSZd2REtL8Xz2JgEdW6WwZQI9W/rMzvb0HBQOsHo1rVouPDMHGxEfLH6jfZqxY8NGKehSKgwI6AHAf43UO3l9vdEfactcCc1INxM1arvG1y1t0Bx5xmlgZwT+M5kYzbSzS9Ajdo40VTmHyh+B/X6+VMn5HgCJ6BCNuNMttgESt8P/q4FlLssD11gDgiuy6NmQjUZmQhx+yjgPL8tmzm3fCENBqbSDpfBLqoP09+m4LZlVuUOqOkjNwJU7zJX4e+aH3WROiLW4wtKkrPwsJ2BPJ0lfFadOW4aSJ+2Oqa/UqsO3IAvpy4ckhrEPafPeH0Er+p5tmmo5KQsBzJESjOdFSpnYnK2e1H0sDVWKsp8JroxyLSXcUaq6i0TW3xnFSN7aMWJJEOwtyUqC/zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6038.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39850400004)(346002)(396003)(136003)(376002)(366004)(6486002)(6506007)(6666004)(478600001)(41300700001)(186003)(52116002)(6512007)(9686003)(2906002)(5660300002)(36916002)(8936002)(4744005)(33716001)(316002)(6916009)(66946007)(66556008)(4326008)(8676002)(66476007)(38100700002)(86362001)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kAppOl9Frhu+QHWNnY5EHWSamY1Tw2PQU9i7CfUuoYki3H/TtBxIwmQf77?=
 =?iso-8859-1?Q?1wgflP2NiA4TKyGtZUKrjX0p8LOwPElexjHMXpwGVhBA/w3ESMw8NLZe9y?=
 =?iso-8859-1?Q?DkyBsE3g4cM8nsceOqoIMk0pvFOTUWJjIlpdmSgJhgrNLZ+F75oW2PdwiL?=
 =?iso-8859-1?Q?mn1OZ5ubekIiH0fx+usF3GsJmV0C0dbo1OYclJv1IYftezGbCU0xzow4TJ?=
 =?iso-8859-1?Q?IyU2clud9K+NFlMmhHoGvLzkPU1ds0s6MQQvuFzTRKWIj2l4q4ozkp6zwD?=
 =?iso-8859-1?Q?GbdLBkY9YX44kdynpb9Awfuwj+2siSBUYWtdXMdkpjXBZZyH1X9kXSpYa3?=
 =?iso-8859-1?Q?tbtVv7zm5uMJDRw41PwNXB0zVCtouhc78KM4hoH5FeDnBZcrA6rwOqRuTn?=
 =?iso-8859-1?Q?8477SvTHn9ezObYBKJFroPzjLa9VcJkJ9ggKVdai11yshDLI+3qnsENtNk?=
 =?iso-8859-1?Q?tCPdayRDKRUB2GQMIBKY9h4ZWE1+lIVIX3DLutxhZ4iowLNi8VJoVGevas?=
 =?iso-8859-1?Q?qXkCGQ/TWr0oykLVdM7HdmhdhMFbfrV4YpvS8TRLODJe6VamlWAebZLaDF?=
 =?iso-8859-1?Q?uPIsUX7ipaARH80tfekdOc4Myz1a6Q+QrPKBiTWV6XIf1hhA6Qy/27k+0H?=
 =?iso-8859-1?Q?LSOGFm24tt1CBE7a0ctEGVXJ873WW9nyq7ScWP+Ucs1mT6lxxPwMDzZL6B?=
 =?iso-8859-1?Q?Xg/cpQMhShVwZZQZQS+O+WIrhAhEJ0Q/MU6X4nLNqAIanTzPFVrj29fMlC?=
 =?iso-8859-1?Q?6hDAomE7/LdSLSr/1CX+ZiYUEwV+jrF9FmoRXQ3k4qMjnOgKhgGj+VM5x9?=
 =?iso-8859-1?Q?ycRrwDwzmq0HniY++UY/e8h/05B7J119mYhMPPq6md8/RlicDgrjxbcMsM?=
 =?iso-8859-1?Q?WgHwDegovJ8EvTOM/r9gvkSGUsEYgwXhEFmEKkDblEZ4ve77j0awLJpFK+?=
 =?iso-8859-1?Q?sdpcmLIrh/Hqe7m0iUid7S0Y6ZKMIR+Pgjdnopb5CzFBRjVmmHU0bM77RH?=
 =?iso-8859-1?Q?QKEboQZue3M8z4KrUfrKCUrvwuJjTkOOkGbopzCYht1asUX/W3wtI0Iy3F?=
 =?iso-8859-1?Q?bDYnytWnZRnGS+qU2odhQAxQooyvZzIvAVmBl8ZpLCiScyORlse4KQGQoV?=
 =?iso-8859-1?Q?qnDqbMYJdxPTYPtLCNRBRA9GDmiT0sIq1QTXd9oJAzs3orizqLkbmE7N+p?=
 =?iso-8859-1?Q?RbA9TqOUNwfLynMHNkuDPJPQfGmhnChzrEgunUJKk/kEuf6NioKesuizuJ?=
 =?iso-8859-1?Q?dcRfT62bLh2wSpLULP/RtaUxnD6Kr0hFQMT8cO2l0c5UuL8Xkc78b82TNW?=
 =?iso-8859-1?Q?CVVEZtOEak4RqtxyHRw7pUMjY/9xJpjqCiqo4xz1WqQ3vYovG84Tc8VsAW?=
 =?iso-8859-1?Q?DzL9VK6/mIcsfbqzOdEpxVrLdhbUWf1AAAM61kGv+fM2HjYeulnVe4b1XB?=
 =?iso-8859-1?Q?fwqw4lXK9tmEU5wh0gpf03/3hNDc8Se2iOcMC86iuZN2HfJW1hTfj+ZYiq?=
 =?iso-8859-1?Q?G1UzKxFn8PTqbHz2BOd2FablPuowS8CVPFcw+H6g0Wza6ypAT8weSpqm58?=
 =?iso-8859-1?Q?fG5ndQLW49AG0c6JiFMHoVXcGT8CY9lL7qxFOBqU5irjdRGjq1mp4jhkeF?=
 =?iso-8859-1?Q?4zTw3nNq2xAzjI6dfY8Nphyo1YlC+Yxk8dtw9SIte0MxQZSREx//4eh04L?=
 =?iso-8859-1?Q?XgYoXgWBOlmAgoprOW7hfYh2B+JVyUArrWs9JIwL?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b677611-49c2-47b0-ade8-08da8438c3ee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6038.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 12:20:56.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxz8ke2FwChf5D+eFVJl8lltv+CGF9KQSRWqarwzqZIBeNKtPJ14tv2GQVhRx7im0FOzOTAv7Q/3UenoNhtwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3938
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 19 August 2022 07:23:43 CEST Dan Carpenter wrote:
> This does a "chunk_len - 4" subtraction later when it calls:
>=20
>         ret =3D wfx_hif_configuration(wdev, buf + 4, chunk_len - 4);
>=20
> so check for "chunk_len" is less than 4.

This patch also ensures that buf[4] won't overflow during:

    if (buf[4] !=3D '{' || buf[chunk_len - 1] !=3D '}')
    	dev_warn(wdev->dev, "PDS:%d: unexpected content\n", chunk_num);

> Fixes: dcbecb497908 ("staging: wfx: allow new PDS format")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller


