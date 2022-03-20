Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815C84E1DBA
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Mar 2022 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbiCTU0e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 16:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiCTU0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 16:26:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2090.outbound.protection.outlook.com [40.92.89.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DF190E99
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 13:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfoIg1664W9rgeOj97doMrMwqL3G34ofdsGJhHo7efoSG62a/XvQavO+diDa0ZMZ4OSVzi0DFLM3RJtGrhwKmJr2e/1kTSE9DL6ka2Vhbjpm+K9RRVa9XHgvGhkgXTUVbLADMbbalcVd+yrT++IfOt/C3rGdsFSHiXuHEFWzeTOh20UPU1hbvFrw6Rqdbx9f9X7pxh5Gr39kvbizr213N+8FvNaFFd6BhvreSdv2qR6eXBbWoTgBkUbg4V7WFXvmI3R/T4kppC6dugSXCbz++vaQNxY14zgv60eXDrXctXIXwhTahB7Ddg4CzK1wBfTFU4CZFi7+2a8TAHI+hAfBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5gfmLDv/VJXhH8c+I5h6Pwjv/1hX3VEdgiGqPnHkP8=;
 b=mW5XOrA+wveMDDKwU/iRSPU31C78w28YabocfnpcDDMa/UaC2OtQ/syhLt6sJKrV5zpqdfXDcJ23LEAMHTQ2MUHd7vyCMx7sS5BXzXwq/T814tQOghkwM/dG/EO3+INGw4LbJhUHcCmyuMfrWFZVaY2PjWes6PV6gb0pLND73rIZXODwDYrHG74LHhmyG3MigMq0tSXisSbxTEbAcEvPe00/hJ6vqU3XOUCLkJO0F4y3sM8iOM+NibhCwwr+7iqa+udM/0lfajXT1uce97xS/ZMiwmHWCCxal/4XJ5O3kQwUqmVQzEpVxhjCfprUUf0aPmLAB3c7J9F3qF7MwSigxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12)
 by VI1PR04MB4575.eurprd04.prod.outlook.com (2603:10a6:803:6b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Sun, 20 Mar
 2022 20:25:06 +0000
Received: from AM9PR04MB8100.eurprd04.prod.outlook.com
 ([fe80::ed4a:6bd3:4b62:2f3d]) by AM9PR04MB8100.eurprd04.prod.outlook.com
 ([fe80::ed4a:6bd3:4b62:2f3d%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 20:25:06 +0000
From:   Bernd Dreyer <dreyerbernd@hotmail.de>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: After multiple Wifi disconnections resulting from "empty download
 folder" errors in an update software of Lubuntu most recent version, Wifi
 manger refuses to switch the Wifi network an.  
Thread-Topic: After multiple Wifi disconnections resulting from "empty
 download folder" errors in an update software of Lubuntu most recent version,
 Wifi manger refuses to switch the Wifi network an.  
Thread-Index: AQHYOukBqQ5dZdd3U0KsvHgklGhN0qzIuKiO
Date:   Sun, 20 Mar 2022 20:25:06 +0000
Message-ID: <AM9PR04MB81000425655AE7D8BFA257CDCD159@AM9PR04MB8100.eurprd04.prod.outlook.com>
References: <AM9PR04MB8100CED1206441BBE638281DCD139@AM9PR04MB8100.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8100CED1206441BBE638281DCD139@AM9PR04MB8100.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qJV1WdYG4KLPqEwwZ561STNhRFrvTCRjNJ4+W9sCoPA=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e554161-c3f8-4e6c-7e3c-08da0aafb8c2
x-ms-traffictypediagnostic: VI1PR04MB4575:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ED2itWzg5yDzrS1TNtiHab34XEgFWNynax+jtbNUm3nGoIaIDBRMfxfPBlQJGDohybqZZOUSM/zjLUrJ33ZmV+0oEOkINPNgmiuI5bOEc4YliwiE21XuFhm8ejMZyM+F0ZGg2kwvqYM+xZMk1VvVdOrwssscMj43YQg+f8dCukcssOBUHTSJ83g4z53h0sfYwD7q2d+JricOR7cdhjcpD6oAV0J6j3QKSazWwpd8TcpgZDzQyyjQVLUyKsLV4w2c3c6dPyuYN8nAgd+QxxiE0YfD5onI0wbm7Y0V0pV7aVzOqyPjfSeVw4AzldsZJe26vyReZ2nFBVql7lvWJR2DEh9fymM6ZNkQ3O0EEEby41o/lVtFBOobLA38u/5gZCdgjoqPLPo7ox+83cDKpzW+QUK/A2q2sVAGbtt7GgVExxid9i1BWQGsON9inxN2MmTSjUQqa7ln6t5xNttz5kzywMHSYvjn3EXlRhNHi7sQpkG2aaoQhKuGOjFXi9V5VjvSQPzsxiJBX50+igjKDI90W87kbqL5xrlPZrLi0xR5Li6XJC1lf76QGkAyLE2ks1g53PvADjrnSgz6u4P3oq/PA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WbTePlUQhtxXY/FI45xwRusSOHcfI0Ez19dwr8zMPdr4qvZ1b1bCwWxbQy?=
 =?iso-8859-1?Q?tOYBW7GsGMpgeAmWSYeZAeLiKCass+gVA8vvNr7W7XLOeUC3Bkma2PJVTG?=
 =?iso-8859-1?Q?GbXrsfQgCEmRnk7K0Euse0FoQm/LdSzLmZqMXD5Ij3/j1rFMjSfu7JYhRs?=
 =?iso-8859-1?Q?KHWJQMguqKePRouy9NiSlUiATdt21Mb/bkXefHMKF9fdo1aV9zAth2Hu0s?=
 =?iso-8859-1?Q?L4tVShs+OlsYroTa48BL4kW1LhKuACZ4UWkDudMTdZLGYtpNaTyCt2n8jh?=
 =?iso-8859-1?Q?ZYWZRolOzV5285YXCHYqXHe/ade89U76UNKZRZpjm6FmnD7w1vTHZOFlrp?=
 =?iso-8859-1?Q?KiwfkAGwIdeiriqu0O7EBPGU6N2NbOXn19h25+0O46tHOrt92uYR7+sbAo?=
 =?iso-8859-1?Q?hxIeoRdsQC2JDKYP5iJARDAEydZ0bNhqqbDJKMbpKIvrng7urjeDDA4zNe?=
 =?iso-8859-1?Q?mNPzARoJPDAHzf9vmzTRol0A6XNmzFZMpBXtzgIfYoCsMqoTO+W0FfUEpZ?=
 =?iso-8859-1?Q?39fu5pVfrVLHbB+wvagf2Lzs0QgKHqPji9LfFBCVadqWl3VINxXSKMNdHb?=
 =?iso-8859-1?Q?j68d6eKQu9evD2QjaU/1iej7Fi4f0mdceFbiormuORtyjKAVxLnofU9ml5?=
 =?iso-8859-1?Q?N1Y3oiIrSVDXJJzYB3w+p8ZThNRrgF3R9EihpFXkV4rRV3NvS2Lr5Dhom9?=
 =?iso-8859-1?Q?EnenuqAKFb2YMBxZh0Q6O7UrREKK0mwlND/Q/MHkKqG09g1bwu4c0p9l3s?=
 =?iso-8859-1?Q?raNHfIoOlii+MsslDf3AN7A5RR6tVgCpEz2SvXyPmcOP1hRJK/hKXe9JoK?=
 =?iso-8859-1?Q?AARVIXagsEYi1gn7J5n8l8MC11R7zfuMQ8H0MpPfpaDvAswgNaV6ITxvbO?=
 =?iso-8859-1?Q?Vz5ro8Wy0FXzWSUbTR7TalJV8V2ABpla7Bgyeph78IoftyysXtibe2cBG4?=
 =?iso-8859-1?Q?CtBNyE35pMZTRVt9/IIujja1o7D2Q7x3qmn9/PqoFXXKPupj1ERhyVhhP4?=
 =?iso-8859-1?Q?hyhGhOLOSByVQiz5hY4aZoRDvvFkB0g0bm15cICxGRUZ1HPU24tBi2QC/8?=
 =?iso-8859-1?Q?d3xjBzBEjQadZj29vV8a/ITqjqmHeRfWEKCDXM9vK7MrCaLdYSMLcofCFY?=
 =?iso-8859-1?Q?qbBrAwkc/C4wx89UdTPqa8MHimXqRcYY7Fk8tEqpRk05sEZHPvUswMKqqZ?=
 =?iso-8859-1?Q?RHjAJ5JUo0gFuQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-03a34.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8100.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e554161-c3f8-4e6c-7e3c-08da0aafb8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2022 20:25:06.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4575
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good evening,
 
after multiple Wifi disconnections resulting from "empty download folder" errors during an update Software run in Lubuntu most recent version, the notbook was restarted with Windows 10. 
Now, in Windows 10, the Wifi manager refused to switch the Wifi network on. 

Wifi manager refuses to switch on the Wifi network now in Lubuntu as well as in Windws 10 and 7. 
Driver software is up to pdate in Windows and Lubuntu.
 
Wifi modul description:
lspci -s 24:00.0 -vvv
24:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network Adapter (PCI-Express) (rev 01)
DeviceName: WLAN
Subsystem: Hewlett-Packard Company AR9285 Wireless Network Adapter (PCI-Express)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 19
Region 0: Memory at c4700000 (64-bit, non-prefetchable) [size=64K]
Capabilities: <access denied>
Kernel driver in use: ath9k
Kernel modules: ath9k
 
The nachine is a notebook HP Probook 4730s.
The HP Probook 4730s has a button for switching off an on both the Bluetooth and the Wifi network (see below).

Whereas the button for swiching off an on both Bluetooth and Wifi Network does not switch the Wifi on, (in Lubutu only) the Bluetoth symbol in the system tray however could be switched from dimmed to full color and back.
 There is no driver for the HP Probook 4730s Wifi and Bluetooh network switch button.
HP Probook 4740 has Wifi and Bluetooh network switch button driver (for Windows 7), but also different Wifi adapter hardware.
Is this a defective hardware or overwritten firmware issue?
 
Mit freundlichen Grüßen
 
Bernd Dreyer
Kirchenstraße 8
84478 Waldkraiburg
Deutschland
dreyerbernd@hotmail.de 
Festnetz: +49 8638 2036295 
Mobiltel.: +49 177 5428627
 
 
