Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD97F4E6E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbjKVRcg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 12:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbjKVRcf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 12:32:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472DD83
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 09:32:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS6pyfg/CXgESunVkd8BECJ/CeQLVd2V9hbYkN0MRZa8yxGjHLIUMYfz+AWIDeACVjqJNiBjDF/F8dLnaAxqZOFNUlnDPq9u3JQLeOok0qWY0w69M+cc2NbFXv2CxLIttJfrIqch5meWwC/TelWlOslpK/MwWHUO9OVlEH4KG0X89TYiB5hDFxLHsOZOpDHXUpJZUwRSrgd7HF0Jb9YO6Pmf5GR8FBoTaC16brP4GE+oF2WfLJUvFG9Mb7Ne6EJk2Bz9cXPNv4XNO9coepsXbzDAr4JN3rDHw55P7tQ5VOJuMcx6WREwMAlb2t6SgaARMTdT+wfTvkwDqzq3G9psHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxuaHDwIjWHqpsZERUf0/7p4Nmn+iDaZr0r3dDIcxe4=;
 b=NSD+mY0G9H2ZzY8Dy9Q1hlRJ4bcrgGpBxWr892cSyWgFVrgB3DgyvZ301duOVlodvHvpqH3qL8hdL9e/MHy7VJdssDE33uesAh2uluvZzbpk8Azp8SsobqkZIg5DlTLReCNBnbMOPVZ8Fy+o331Zm17MwSHWz69nSJNXhJydqyTD6qMbJ9ht4SuIMOLSgthG5ZEWh7H7Tjp42fO/br6DqNIaE21RDFh1EZOxAUqSgZ/ePxju7U0gqhcZC7IGHhixDlkO5wgId/Rt9CwCJ8vZK66sFygnbzW/hADpnpMZshZqyMuqqMsivzvdMb1hbw7JRcPjFekrz2GTjO3HJ4EZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxuaHDwIjWHqpsZERUf0/7p4Nmn+iDaZr0r3dDIcxe4=;
 b=n0LexCTKlZ3OUXPdVHCaQJ3M4DY2xRL73Xen6UU3VzgFfLWV24JySqzls6/PeALoPxyIML7u5dwm6nLM+qXSc9Kg2+K+TsYP4KQr5M2AJYD7wXcl734usLs7B+xIjnrbDBcVN0d5uvbEdhMTZH2/STjNra77LS05IwT59DBtGMlNv0TFdfMHzvIv8J+NQu3ZvelakugOhtQ+tAM62ZIm1rv9FEL8Vu3mEbp5MAcUxdTUd3Bc4wB/t/faG7ewWXuggz62Pdm/N/WgFFe/UUp5l+vxODPgKa7MvjY0THwFhwd7PMb0cM8/Q6gmHvmlOIE8JWfQ3KhlZaVzlB/fRXmysA==
Received: from IA1PR20MB5049.namprd20.prod.outlook.com (2603:10b6:208:3a7::16)
 by DS7PR20MB3920.namprd20.prod.outlook.com (2603:10b6:5:3aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 17:32:29 +0000
Received: from IA1PR20MB5049.namprd20.prod.outlook.com
 ([fe80::6d06:82ec:16e5:ede5]) by IA1PR20MB5049.namprd20.prod.outlook.com
 ([fe80::6d06:82ec:16e5:ede5%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 17:32:29 +0000
From:   Jay Sweat <jjsweat@outlook.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Realtek 8822ce p2p support
Thread-Topic: Realtek 8822ce p2p support
Thread-Index: AQHaHJ6/35nL8BzLVE+iP+/w63/TCrCFjBhAgAEOZs0=
Date:   Wed, 22 Nov 2023 17:32:29 +0000
Message-ID: <IA1PR20MB50490BFFD9F797722C9688BAA8BAA@IA1PR20MB5049.namprd20.prod.outlook.com>
References: <IA1PR20MB5049CDB1D4CBA0FD5B68F15DA8BBA@IA1PR20MB5049.namprd20.prod.outlook.com>
 <16c31bac7aaf4c20917f500d6d2a52c2@realtek.com>
In-Reply-To: <16c31bac7aaf4c20917f500d6d2a52c2@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [u8Gogmb3cQHhNYZdN63pFlWjLWvHs5VJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR20MB5049:EE_|DS7PR20MB3920:EE_
x-ms-office365-filtering-correlation-id: 385c9a43-f4d2-4f39-cba6-08dbeb8100a5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWFugjQgNHOl0/dIsYy3Hfu2hFPowSAzr7jqepU8Mw+mwJx3q1fzlZQ2TRmTDT5TmNcUKGj43SkP678ZLE1y62zV8DO7ogNlalpwQcSSH/peHaSZ9joLLfvBsvjZ+PLqOwe3I+kXSDOop508cR4ca4o37wpBxW2LOmnvrp8/0K3HaIPGnhqV1W9kuxmZeB1L+bjC00Qsb8SWBDeOGvj/NkU0PqIhNoiI9PXsjCuetvybUl94Ebe6jm0ppZD9XUxSh7heM3vo40Srgo9ca8ThykQcgesToGwThxE1CKuaEMBY47mDnaP1+dogL/8ekWMzNicKcXluh9SPsr4cEKbrzWH+Uhc1DY+zAz7ePt3sCu1xQ+iiTgJHZ3oc2jY3cHOvRhVZfXGRi0e+f+Dg6pzHjvWwBW1wd5WzqB/r/imF3/a+B8zYpdTI/1lBW+tszRF4kO1a6S6CcJg0+Q/62vPRXcDehaYzPOreNXkyOAiOKZqtRpIt0Pcg8AuMVfZJ3p5XxjgYEl6pNneiA81D5+/sjo6gj2I8D+/EwjiSPcbXEAwMRUxb5po6w4TZ9yTUdwxg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LkWEuVYqnQ1W/bgVenDsGnEBYB7/cNGSbE1MgtZt3Ig3Apxhm9zNKWXJxiQ2?=
 =?us-ascii?Q?aNYNlPJbiLbwVcbKoQbvrxMm31Ts8WvyQ1Il4klfbvBHWSi2K6toQDablrgD?=
 =?us-ascii?Q?jtUmWwwDYKDQ9IQOvTjisSDLtH0aKBWERVKsueWztV0G+egb0ViXSdGq9Ytj?=
 =?us-ascii?Q?oKzm6L/n5HL8qs1JGHRUmUelEQlVbgFUN/UvRvdaDYEzZj+Gl5Si8MPE5VKj?=
 =?us-ascii?Q?1yjrqlvdSZuPx9gxpo0b71RdatSGlQFPj0AkxQTG2hBJhBn324DdQAOVhykx?=
 =?us-ascii?Q?krgQYdIviOFf/FaEAPNOzskSzosEhv9FYsGoihkKEOjEAZUItDNiumdpFGxB?=
 =?us-ascii?Q?6Yu6UmGT0FpZAFa7yrp2nTvIaHWV5+P7vgQUfcifDbhXj87ab2muQqQJ7TDW?=
 =?us-ascii?Q?H+LuABoIM8equZSJYs5291KIz9rF3vveHPz4tT2rt3hFpic0/m2wKdZoEqj1?=
 =?us-ascii?Q?v+w1x8/G/cRV/8Sg5LMw0VxdycqeAmjNLV281/PYgv/Daqv5G6QFZ5xHBK9k?=
 =?us-ascii?Q?v9THad2ERVsq01vW4Yi30xLt49xWNAinFv/as8W6J3Z4lxkwwul2M8MTKIq/?=
 =?us-ascii?Q?H5M7BywrexKibLD0yyVITK5Q5o7Tj3hLhcT+ogKwGZlTInGRM43k5ns98dmC?=
 =?us-ascii?Q?1Rx0xUkBf9TSHhAmgXi48LzYiG+nHcXYOs47s8f4WNQ9Q31Zcj89u0QRb4PM?=
 =?us-ascii?Q?lCR+HhYMSTF243oTg4ww/Pj+IpudXi4+nRLKG9wzfmmHe3ZrYUMK6kT1i+gY?=
 =?us-ascii?Q?VGC6pZ9LyIvlkErDJz0MJ0qKv5QTQkTOIz6uLMP8IPAGiolsrindZd8f/XGV?=
 =?us-ascii?Q?WPlpXTYKEHOwnX6/DY18/AfTCdMTL0+k5BqX9hA2dJDCT3vyNJKGVYYiG2tg?=
 =?us-ascii?Q?aiX2BqMknGQc9v/0dT/UvDVFHO+WNP5A/S+o8JxHpxj8fgry44lx27tC4S1v?=
 =?us-ascii?Q?0l/ctmxgkZ6pGAWfdG171ybMKGCEIdlBXOrCmROcmny65WPEvlSyg7HqRLGS?=
 =?us-ascii?Q?XsU6eIGvSlnWGkZP9AxsoMY9jDScMP6UD8rsNxoPSdiruA8+7w4h6BdjBvjE?=
 =?us-ascii?Q?Ivq+zIT/SLuQDUj2BFP//BB50Hrw4rC+l1R2AsB5/3tOlCMlT1+M9JlZYIm3?=
 =?us-ascii?Q?N8m1+pabZJd0xHFrpSi6ndWq6klpIz02uufhR9s8sE3DL60g1lm7c/V6EPhP?=
 =?us-ascii?Q?tm6vl5jUqaqLmR7wOUpsEJvlgJ620MfW6qiuyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB5049.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 385c9a43-f4d2-4f39-cba6-08dbeb8100a5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 17:32:29.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am interesting, but Im not sure how much help I can be. I only have a bas=
ic knowledge of linux and next to no development skills.=
