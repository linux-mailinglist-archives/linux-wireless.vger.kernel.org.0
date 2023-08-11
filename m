Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E757787A2
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 08:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHKGrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHKGry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 02:47:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2100.outbound.protection.outlook.com [40.92.99.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111332717
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 23:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHqTbX8xfCKnnmys0E8yuW3KvIjYKzeTUp30gkXpBtKpJAKZJX66ZVARm1sMT1g9gkpnZyG+DAYDUxtDfAmx1T15RfF8TgnJBGDLiOsioePwjnAHJwAcxGUacui72eo4NnXCQBNAJCsYhtwYW/9hd2aus63gTwc9tTD42yRARpSKuDyhUHNLqySJp5qJ2DQng3ybzjfk8+CHKTPS9Y2G5yhC4wkUrv+4uQELxh3FSJ2L/ppHKS6LcuEPDM9b4+19GokAtOtkNpCAjwd2KpJlQXwoXHJBXPhFeT3vcAFI6CwyfO05bMyzNVpYrqxLmZZ6qo6Y8GBPhAfqFqk0w9dIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfGbB5iRYPA83IuYwVs6fLhI0N84cFefdCg4JIEk6aA=;
 b=FDidJvi2sZgRKnONtCmbFf1wEpVeO1kgfHlvF1NekBJEuI1Q8bRz7YNDcNQgTOQIJEEJhiHUtVzvi2yg1a6AVkMb7NKCtDAxZG891HkbBccjE9Q4S8q4c+lJ4b+LZfUTG44WUTfGOiqv6dd49Up9G/muisABRT6GNbc0WQrup2d/5aDjNdmH5zqvQBN5FMDpcnXTpowbx7pa6LS4xUZD2ZbF8wgjpWtEuCK7qEukhtJORSsSuppkMHj/sb9riiGy9Z7jZ/1jjeUOmJBmHevAu+I8+AIwlsVtgZWWU6sPy8jpQLyCLx+2fgZM9Cjs0x6XMBFC+cMJgUdMcryJrzXAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfGbB5iRYPA83IuYwVs6fLhI0N84cFefdCg4JIEk6aA=;
 b=BmrZDKEQk2TMAq4YmLmmDOSzYXSanr7w5zcSox+6YHdMQnr1wRzwL9a/uSbJ+byJvi03HS1A0tUULxBAcxmUe+AChZP0MlsxjPJMnYPoTqoGmq5PCdLl1MiGDGhHGPELpUBdxUC2Jg7FnF+YanBWxSvUyQJEiFKk7tfM/o2ogKhRQblckvNiY3bKK8lEzIwca2eIsD6hwoo2hDTCoxd4dG0z6GqmxGymGJtKVK/jS3n6kU6kHWt/Pt1mY1jQBGo24S1gaUiUB4SBQFU+yd6Zt5KyYXdpSoChMm1iKROGDFvrEIYTyISIqIQ5MK+epkztbRqdhWFU+U0lTjr8qbnRPQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:47:51 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9%5]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 06:47:51 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     stf_xl@wp.pl
Cc:     helmut.schaa@googlemail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rt2x00: limit MT7620 TX power based on eeprom calibration
Date:   Fri, 11 Aug 2023 14:47:39 +0800
Message-ID: <TYAP286MB03151DE75F87A100A9FFA53ABC10A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806082701.GA361202@wp.pl>
References: <20230806082701.GA361202@wp.pl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ufN61GV/Zp2/5byCezAy3ZTnL7/+VuWP]
X-ClientProxiedBy: TYCP301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::9) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230811064739.24399-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1500:EE_
X-MS-Office365-Filtering-Correlation-Id: a71368f3-54fd-4145-4c2c-08db9a36e1a7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIICoQRL2hTniQnITBlRyMCd4Nbyo6g90xNp9OESs+56aXmZwMTfUnQg+pC7fhSVq2I9zQUsyFOfUB17MgZ2Y2J7LpMTPdmeNPZv8LsPzG3I+rg13MOmx6Yd2Dg+Mo3vlCa4otgAxLnpLqoUVzfjtfO08I8nR0eEIa9SNNtSlP8VPzM4eJFXzvkxec6nftKKd9NOKVebnN1nLb7Rq5Tafwfu4g04rYBmcuRBogJ6R5KbOrUVFu0TK5u6A4+3Rka6FZCdkD5A4iYvZtzqjzgBJTkjzesPZ4guVlruW7thWro45Sy0DWFRlOUXEK9wNaHvSHt3NXA7WgxLgzSArNR2nfyBSMUf+rVHC0SuBvfK0cu1kHMbn/WYvDvUzfKhDTAMkhK09dZTSSbf9rhLhlfXy5OeRortvCeyNZ0Y2qxz4ZWpu1HP4CAee1UhugXGK4BeDXxwFc/R9MeArnwd9QVdsqrQHmFAoj33I84BPO0n+WgEoXH1sFGnfmiblbBreGtpssoXPoe0IaYtraX8lvjPqOnc3iRFZhme+k9doBnat0Jkiz6cDHATnu/5OAUT88uJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?It9m9sBlvkpILsLAAtf/m5/9bIrycktCoMFIGeGOhqYRJTaahft+1kMF3VPQ?=
 =?us-ascii?Q?hZt54ZCjBJAVUnkgNpxxa3UDNip6J1OOCRsCi9e6sNHH9c8OM+3sknj6XIfo?=
 =?us-ascii?Q?inQuxKinIgse1gHL3oBbFcPYMrQgHDMZdb8naWrW0y5M0jDgn5CLsW7pLwd/?=
 =?us-ascii?Q?fl03mwDPYODo+yH3HebD1RAdSLqD2nx1a71bsF6WcUty97ixq/NHY1eWa3Se?=
 =?us-ascii?Q?ioEn43wSoMDPRGs3J4RCQcJrqqzqoO6OZ4ki0d2mar679S67+Mq36iw0JxPI?=
 =?us-ascii?Q?aFgbmxOVOgKItKLxiqogFpd/NIRTZyYM0N7bhgNEb8nDfb2YjgaNFvjdlgt1?=
 =?us-ascii?Q?8dwlm5xdfpWhBoUMyUIwgIsAgHNpfaktDbQRQLnDPKShd5jz+QDRejiFiJfi?=
 =?us-ascii?Q?JQWNupWgqL4UNMdCikykgve3blMzJQGjAHbKOLziA6KXeSmeU0RnNT81fNFM?=
 =?us-ascii?Q?BQGAXKTX7UJUBMDbuFQw/vXTcSt2NRTKai49HQJfg1Ua+fvDWstkDaL9KmaC?=
 =?us-ascii?Q?jkwWlBdhnDkGRVeJw5vgBlgltHuzUQ7bVhc4p6k8ookPdSYbo0Y3wYw4DhmV?=
 =?us-ascii?Q?VMqu2RE/p5qesmfjMegOYbDWJzLtvej5vyDX+AHEZvCAYFCe6ytYvTsDYX+a?=
 =?us-ascii?Q?S42mPlvN06WcSEYgiV15Ns/TNfjTCdwCe1j/QoI8b9lHi/PFn+qXVyLi8vLW?=
 =?us-ascii?Q?pNQRA64D1vj1dpBTRnL0lJJ67E8/MI4DBkTgNQrB3TKQtARReJyoy5ik9PMp?=
 =?us-ascii?Q?ifs3I7j6Vt9RiBC3cGigiXmzdngDXYq/k93ZwZXjyvhbAlH4tO6By1BQhFkE?=
 =?us-ascii?Q?6j9kX72Zkx3eI+0Ct2N573POJobz0GElcxc/KGlhvN4DdDZjGqeacFjH3zLe?=
 =?us-ascii?Q?48VB1YyXQbmpSsZuhiDbgitGWVR8UwT4Q8tM3kyEZ5Va6zhULnx5Le1JziqB?=
 =?us-ascii?Q?cAcBZweaeRXicpaft/3pkf3jYuq+uiMCtmhPOtgbF2c/bBCSTzIjdvE970BJ?=
 =?us-ascii?Q?FZGc/118LMkdpPJrPSH7rvNPhSGeq29MiQSWY6NXUeufbVpUotD9I7JZZZEZ?=
 =?us-ascii?Q?6U2fXPRAvcvDVo+0O/CfNYtccMAOp3kI4SfEukoxUfvOKa4l70O6HHzV0pR4?=
 =?us-ascii?Q?PaO1ma7wjhsPiQ6v7JTeOJXkcBzNSnHIxr0Y+t/XdZvtqa6Tb5WeSoNxn3uR?=
 =?us-ascii?Q?RERxcQKliEw05bB/4F6xqq2K303SqbDrtDBp0Dsi4yq1KMjlQLuKyn96YAY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71368f3-54fd-4145-4c2c-08db9a36e1a7
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:47:51.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1500
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi! Thanks for your review.

On Sun, 6 Aug 2023 10:27:01 +0200, Stanislaw Gruszka wrote:

> > -	max_power = chan->max_power * 2;
> > -	if (max_power > 0x2f)
> > -		max_power = 0x2f;
> > +	power_group[0] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG1);
> > +	power_group[1] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG2);
> > +	for (cnt = 0; cnt < 2; cnt++) {
> > +		chan_power = power_group[cnt][rt2x00dev->rf_channel - 1];
> 
> I whould add
> 
> if (WARN_ON(rt2x00dev->rf_channel not in proper range))
> 	return;
> 
> just to be on safe side. This can be done in separate patch, if you think
> it is appropriate.
> 
> The change overall looks ok to me.
> 
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

I add the channel check in V2 patch [1]. MT7620 only support WiFi4 2GHz
band, so I limit it to [1, 14].

[1] https://lore.kernel.org/all/TYAP286MB03159090ED14044215E59FD6BC10A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

Regards
Shiji Yang
