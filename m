Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AC1589FC1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiHDRO4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiHDROy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 13:14:54 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0254C91
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 10:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL3riToG38SDUWcTnPYmjffwynV9IgDcrQu/ksn2P74LUGwSCi+QHkkZTmMNCiaSB+kNoEyWyPDyp4KU8uLelnxOojFqepd9FiuOILgts2/3+z5elvls75B6hR/S+3Ix8mlz7x5ckKKdRt8Q3XLhfoYQj0elHEtOEMawmq3TMt4LlpjMuDiJJJa3nR81xQZRzHBK45kBy2h4RpoXTE0xPZJG/JB5DScopqMPQLoX6RS5u2Os830rIjnsuEiYaCGvreQgq8LcXfNkuuXB9uCN3QyVJc2WoiKZIQ/o9FmF8XqnXo4m8gAk+mXIvE9HnTaNQ6zvd+uox8BSWCCJXKbdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQNdhLiqb6x4B0I2Wu7tRjL0jPXc9CQthjDubmWC5aY=;
 b=i88mgy5PrN6GLdvtcfkWB4OiIxI4/yCojTyNpGL79otQD9uNjSbeT1YbcItpb7aiItSUuBjlIHXAJksa6qZzZx7UvjI6Bzxt3GlSFgEYzBqlOauIuqWBz9OkzJ3oQlZhOpTMqxU9Rwn1WEH+PJKppwozbEBmrVcfNA2rULcGqdTqMGNnp6c/lKezPtau+kz3g3BFVl9eRR0xWWPmfJrG//OoSNWYdyaxix/lkQYRwWYeLYsfwzQsDwcKyJ7NMJ/Q7qk04fpo+lbWCEi9/ZhJCCk70VabgNFvslzYptKGNpN7lAl6uK7ojx/kGAwcT+ohPHozrKns4kN1Svn3dJtA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQNdhLiqb6x4B0I2Wu7tRjL0jPXc9CQthjDubmWC5aY=;
 b=5aCq+GFHhuiHEUb2uDL/+NqrMKCM7VNGtUvCssUkyS6kwbKfa5zZmT2W8l3zvwAeoTepQdt6ETVmMHqfXvJCFQ8AdZH/m6Qy51XJ7zhCxo8g+UBVkKw2LMRc6TeKaQz01+LyVSB+OC19uehULiG9IslpGc595+AVOWNUE8d90+KqiHWcHSD0FkXygKV0wwj1xHs40yzvIHw+3e2FkyHCe6nAMeIoC7yzbpyH0ZKTlOGHiQc2zQavI64WjwPQ2zjCISzmDyYFrTToXO7Wv5l1lkMCIRzeigyYScbHbxZV7we3N9yJBEPuot73W0UpSAiHayyM063l9g9rnAc3R23yVA==
Received: from VE1PR04MB6494.eurprd04.prod.outlook.com (2603:10a6:803:127::15)
 by VI1PR04MB6863.eurprd04.prod.outlook.com (2603:10a6:803:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 17:14:49 +0000
Received: from VE1PR04MB6494.eurprd04.prod.outlook.com
 ([fe80::c535:5a80:9f11:c8b0]) by VE1PR04MB6494.eurprd04.prod.outlook.com
 ([fe80::c535:5a80:9f11:c8b0%7]) with mapi id 15.20.5482.012; Thu, 4 Aug 2022
 17:14:49 +0000
From:   Kostas Peletidis <kostas.peletidis@suse.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.com>
Subject: mt7921e: Network device not responding following chip reset
Thread-Topic: mt7921e: Network device not responding following chip reset
Thread-Index: AQHYqCVq81s6yxOdWUOwhxwJBAnnyQ==
Date:   Thu, 4 Aug 2022 17:14:49 +0000
Message-ID: <VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d026e97-8087-4a8e-67d7-08da763cd6a7
x-ms-traffictypediagnostic: VI1PR04MB6863:EE_
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dRhRkV1sQ+p4FY49Lz/RFSNy+SBqjWUasMwWqsDr1KmSAjp+eADOapG2bhhn3t2V4QH+0PXWWJHjul9r4F56n+SToHk0/gz2g5NXDn7h8aC0AjFPgrnVFRnJAU/9+GRVC0V5QzK9ydZMzMLqPkUjV5WskgPCGmyTtIB1u/6jV109K3tyDashqOEwLzbKPyXplnBi9e6vxU7BcMI/PU6CYmtJldSMTNNWUlEu9F62m4R6s9+eLIiCUuyC6oMg/XmA4eLn5skCnmWgQo3xK4XyWBgDjj/ONJ9pMFaUbDiEiJUTblCzGratm6w2mXUZw1LGKxZJ6VNZ2Ml4rSE6z2LzVU3a/nTvZ+6DmivR/7PIl6uh+UEXG0R+q8kwC1OK69IBt/oDUtNkGuP8meDEESa8QEzXM+r9Dk7RQmYC2R7PgZkvDK39mGy+VHb9Clw3M5ffHgFgEEuefsQt2ljQal6esVyoKuMIE56AH5ZqC/5CHe5aBMbzQwGgd4WfCDBGW3O8aHfU2bWDGQGCRobpd5pr3sCW1NHdz7RkKXaRkrznwOfIIRKxC0vkNkkepeq3HKcS/jjGOO7lI/2aB49WJ1A5zCReH2aK73JDnIpnXGEYW1kAb34uvnJeOGik8XAJSMtHgo/7JkAUWZ7BPQMl6ElpRPEI5WLp7P9y1n7PcnXKoUNPlI+yVSTPk4kjF+v1QC3MNBd+EMpts7q/GJpFBQplnLP42aeuU5wJiXK1FC6bsrbmckhlll8OyaIvmnPDvbXwaWfLthFjFUZlA1MM5lyAMcrz9GNxZZ0CXmjN3VnZfCz721Y4+IuUrS4Ma9kUJSyLYpkVcN/3RpPA9Sq2idgXiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6494.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(136003)(346002)(316002)(6506007)(478600001)(33656002)(6916009)(107886003)(55016003)(966005)(83380400001)(41300700001)(71200400001)(86362001)(38070700005)(26005)(122000001)(38100700002)(66946007)(8676002)(4326008)(76116006)(66446008)(66556008)(91956017)(66476007)(64756008)(55236004)(5660300002)(8936002)(44832011)(186003)(52536014)(2906002)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bo2lj+9RsbAXTxcSkWYrzVdWcUa9/EcIkrwudquNLdSmtMWuBIStq4Igcr?=
 =?iso-8859-1?Q?61Fv4+RLklayX9PllXto6SZyOdTrXcyBje0rpoc1h31dSgPmizx6FghQdM?=
 =?iso-8859-1?Q?DRkgMxYF0sNNp282IHS2x2TcMLMtvdK5eAjKFG+oWBf7Cl5ZO1hPI7nGfu?=
 =?iso-8859-1?Q?oGIHT97HY5Ub4ZrTDtDnD0VLgmzO47wd7P8t0t68fwCYt1WS3BeUmPXWf/?=
 =?iso-8859-1?Q?GMdTBykjoOaK4ff/u6Rz6WR1/LSme4Sr/X1SipviTs59falLUJvsNx8h3n?=
 =?iso-8859-1?Q?W8EF490qg7BrqEdY7DxsQy0MEgDgObPf4/V+/23bQuq7TtUlCHPN5qtWab?=
 =?iso-8859-1?Q?n43Eggh5OtOs6b25Gu2vZo25U3sat7w4SHqoVkJ8UWDlaMnUqTlZNfUmNc?=
 =?iso-8859-1?Q?2Y2nIJEfStC3tQNuL3oOXqMJf1pHE/pqStGn1XWzBgFFfbsWU6PuDF57dK?=
 =?iso-8859-1?Q?MHKgwXCuyNrjeY9aSkZjxDf/q9j/DdEX3vqxtzkdhxF2CMk/fWsAfi8h32?=
 =?iso-8859-1?Q?lJOY6xkp3nxjRbfTKyyoqqha5B8sgyWI+B16zbjFqK7awSojPP85SXXkNy?=
 =?iso-8859-1?Q?vNpaiRvMVnIz3cYEC/5cDvcThLQkTrpyEjlQgV+rwjdWA+BFdqJSmUAs9d?=
 =?iso-8859-1?Q?Ad9/iDzFfBZHOt4cudM7A2hi/ggX6voxsF/1Or//aB17YNHTKnYoWNYn3U?=
 =?iso-8859-1?Q?AjtKrxGGT9aJ0vPvJBYT1ubkGS3cs0lAEA4EqWMuyyWpG6Cm5rSagSmc5i?=
 =?iso-8859-1?Q?GHVTHXASutuGsPheqI6uC79i862GlPcY7V7Xe0DL/rPC9HEn1wIliYLtqt?=
 =?iso-8859-1?Q?WL03sae6sfogW3GKYPq6UQF4QXeIMCt0Ss1CZJKJjRlWUuqNI+wtG45tU1?=
 =?iso-8859-1?Q?+khbB7TOSJ8I+9VSRRDmaY5h1rybW3g+beKeQiF0sKH+NVmmFrUjJFuPsg?=
 =?iso-8859-1?Q?APXOx+YyPq0cd2GcDx4N+MobBhvmiSnEM+LJttc5Rcbmnbahlb6EbEiX/Y?=
 =?iso-8859-1?Q?kcKhXxiP8UDOBQEE1Fcqd1wIyhgbO+z1JCGKZpl+RjBoBRdvfgN6UXLrbN?=
 =?iso-8859-1?Q?mMSLO4X/C13XiIKGazOV64EWn6rsGmWfJXJBxiDdtfqrhlnyz9/FS3VHP5?=
 =?iso-8859-1?Q?GE+AsJNCAN3XMryUKxii0A2SdVOea8HCZ8zCq3VplHfzOPokH5qea+RKnY?=
 =?iso-8859-1?Q?zi0cnBBOl7G3C7Urp8/8VUdeEd9LxG7evKvtTEQZLOaqL3ZZtSbSGQBIZ1?=
 =?iso-8859-1?Q?+mPTSY+1pTFWrwIi3KO/CWNuMytfuume+viyiy4IfTCAJAojQKn6osPOo6?=
 =?iso-8859-1?Q?FCrfEXSrkw3Lv2G0pXPSPg8m/X0aD6UJ0yYAkX+gGwZg2u2BvBBIUU1v1h?=
 =?iso-8859-1?Q?91ildek+dKo5dWMioM0koTUJo95D1wDWMy/hiaOMMTHECfEnVxn+6R0HnW?=
 =?iso-8859-1?Q?499Tq1V5GG4V2xHb1cuPUNP4YxEDp9jpeati617Y7L8wSTmW0UjPRb6fNJ?=
 =?iso-8859-1?Q?rYjY4K62gpf9FB9WCJleKTgGcOacHkcsaqRDgO+9e0x20PdXGOHRLuD6Hv?=
 =?iso-8859-1?Q?+0a4AC506ZurOrb8IUPuWiqNBkIXLGT89OLjTUlaHFAqmuSVkhpevIZFDg?=
 =?iso-8859-1?Q?/aGhBWNw7MBdKKaITeYYyyo3+6pG1kSzO4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6494.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d026e97-8087-4a8e-67d7-08da763cd6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 17:14:49.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNfkl+gezxjB54ArqDCXNCk+AD8fniTGxpnsQptesN+8VZrh/SdgVMwv+OfLI1iJYUQMSKFa/lJIE51T/ss8IGEwzoPTrEXzPtYdE63GwWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,=0A=
=0A=
Takashi (in cc) and I have been looking at a strange mt7921e issue I encoun=
tered and any help to get to the bottom of it would be much appreciated. Du=
ring normal use of my machine sometimes the network would become unreachabl=
e and any network related commands, such as ping or ss, would hang indefini=
tely when executed in a terminal. This is what a typical dmesg output would=
 look like (see URL at the end of this message for full details):=0A=
=0A=
[11249.676616] r8169 0000:02:00.0 enp2s0f0: Link is Down=0A=
[11453.812782] mt7921e 0000:03:00.0: driver own failed=0A=
[11454.986117] mt7921e 0000:03:00.0: driver own failed=0A=
[11454.986134] mt7921e 0000:03:00.0: chip reset=0A=
[11456.170894] mt7921e 0000:03:00.0: driver own failed=0A=
[11456.278532] pcieport 0000:00:02.3: pciehp: Slot(0): Link Down=0A=
[11456.278536] pcieport 0000:00:02.3: pciehp: Slot(0): Card not present=0A=
[11456.313973] wlp3s0: deauthenticating from f8:5b:3b:0f:2b:9f by local cho=
ice (Reason: 3=3DDEAUTH_LEAVING)=0A=
[11457.286206] mt7921e 0000:03:00.0: Timeout for driver own=0A=
[11458.400420] mt7921e 0000:03:00.0: driver own failed=0A=
[11458.400442] ------------[ cut here ]------------=0A=
[11458.400443] WARNING: CPU: 2 PID: 8597 at kernel/kthread.c:659 kthread_pa=
rk+0x81/0x90=0A=
=0A=
I have noticed this issue both with tainted and not tainted kernels. To me =
it looks like some kind of hardware reset timed out (or the hardware was pr=
obed too quickly). This is what a successful chip reset looks like in my lo=
gs:=0A=
=0A=
Chip reset OK, no warning=0A=
-------------------------=0A=
Jul 04 13:06:33 savra kernel: mt7921e 0000:03:00.0: driver own failed=0A=
Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: driver own failed=0A=
Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: chip reset=0A=
Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: HW/SW Version: 0x8a108a=
10, Build Time: 20220311230842a=0A=
Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: WM Firmware Version: __=
__010000, Build Time: 20220311230931=0A=
Jul 04 13:06:36 savra kernel: wlp3s0: Driver requested disconnection from A=
P f8:5b:3b:0f:2b:9f=0A=
=0A=
And this is what the chip reset looks like when the issue occurs:=0A=
=0A=
Chip reset timeout, warning=0A=
---------------------------=0A=
Aug 03 12:18:00 savra kernel: mt7921e 0000:03:00.0: driver own failed=0A=
Aug 03 12:18:02 savra kernel: mt7921e 0000:03:00.0: driver own failed=0A=
Aug 03 12:18:02 savra kernel: mt7921e 0000:03:00.0: chip reset=0A=
Aug 03 12:18:03 savra kernel: mt7921e 0000:03:00.0: driver own failed=0A=
Aug 03 12:18:03 savra kernel: pcieport 0000:00:02.3: pciehp: Slot(0): Link =
Down=0A=
Aug 03 12:18:03 savra kernel: pcieport 0000:00:02.3: pciehp: Slot(0): Card =
not present=0A=
Aug 03 12:18:03 savra kernel: wlp3s0: deauthenticating from f8:5b:3b:0f:2b:=
9f by local choice (Reason: 3=3DDEAUTH_LEAVING)=0A=
Aug 03 12:18:04 savra kernel: mt7921e 0000:03:00.0: Timeout for driver own=
=0A=
Aug 03 12:18:05 savra kernel: mt7921e 0000:03:00.0: driver own failed=0A=
Aug 03 12:18:05 savra kernel: ------------[ cut here ]------------=0A=
Aug 03 12:18:05 savra kernel: WARNING: CPU: 6 PID: 26340 at kernel/kthread.=
c:659 kthread_park+0x81/0x90=0A=
=0A=
I have added dmesg logs and all pertinent information in the ticket below:=
=0A=
https://bugzilla.opensuse.org/show_bug.cgi?id=3D1201845=0A=
=0A=
Would someone please have a look and help us figure out what would cause th=
e "driver own failed" message to be logged? Thank you.=0A=
=0A=
=0A=
Regards,=0A=
Kostas=
