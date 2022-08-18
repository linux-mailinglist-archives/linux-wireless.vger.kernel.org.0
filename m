Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA005980CD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiHRJZv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiHRJZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 05:25:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B050B14C0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 02:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKZutX3B1HnT+tcKaN1uONK1jbtloktriNtgybU3GWYkL3G2CEu32Hcqw1+2rPUtFfN7LlepPPjKek09zewSXrrJD18Fq9ZbEHnTUU+fNEpNSMG6G6/FSfwAqDz3tKL4Nf6Iat4nbMt/Jsm70bAVttzDH7TV0bNWS5+UiRklzO/wpT9CjfhY8zA30Ji0mMThca5yfr59ISNNC/4isn/76LuV+/1I1EngOcrISuaxnIB/pO0Hq1Dgx7ZpTfA7SNAp6gkCVfdN7y6Bc15SLCVeENqRydJcDP6NCGwMLYCX3GhHffXlWmibWDU4L/rcaQk89A1JwhC9/7NX/Rr3AnuAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IL2yHfZbvBqIwD/VIOOXC/yVKcFk7Js/1PwzRWH5C0=;
 b=Etimv0pGwX0xo6BhKmdgXH5cw3IbykdwWfCWLOjC6K4vTiHaY0ZOTLAvUGjwyKSeZXbnt9hy1HpNCDjEFeepuRHajxEYfJxpOtX0Ce3yJ38WzYfECODvFiigsijOKpUIcoVWlMQqcdjPzh/2Kra7+i3IbjsPzcD4ZvCnfrKlyE1KgJRATE3ng0ZEEFsnYyvAmnXEVEfwVc9eC1PAWs6cNRkHmtft0BGBZwjIwLkPJYArGJpnsEBal/joQhhqT533k//2x9CgLbmwzFnaazorR6WIxMYyBhHKyCBjcccJ5q5/H/XOrNN8q3A+8xdxgx4hEQ1yKFJYrRvwYJUuM+g6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IL2yHfZbvBqIwD/VIOOXC/yVKcFk7Js/1PwzRWH5C0=;
 b=vJCffqIUhOtkdcKhWH4y+HchOGmnfMfKXcCYvjazhCiluSBlax9f5FY5haMG30pTwPfYNvpXSIHzD0F1ySoj8hZnwZBKS1Gl6R684YBsKWLDqBn1BVe9Fr5I/SmCaM+haBuH9D0snnX1d/yralGwoYCAorsFxWbl/p+LOqajaO8IWjh5Do38K+QSMgSoDc80HQXx8HFuCZ1v0wP2HKdFU8t3XzdWc+cRSAgpYKqgkawdZLgDkdS4GliIYYqJX3mlldyj74EBWXPX8UqV4Jq7mQfbiUKAfQ08yPcQtyUPhnMJKVk+9YHThslEEBB+iOspM5LIcM/vPYz7vzuv9yzatA==
Received: from VE1PR04MB6494.eurprd04.prod.outlook.com (2603:10a6:803:127::15)
 by AM5PR0401MB2643.eurprd04.prod.outlook.com (2603:10a6:203:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 09:25:44 +0000
Received: from VE1PR04MB6494.eurprd04.prod.outlook.com
 ([fe80::b1f3:dafb:9924:447d]) by VE1PR04MB6494.eurprd04.prod.outlook.com
 ([fe80::b1f3:dafb:9924:447d%7]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 09:25:44 +0000
From:   Kostas Peletidis <kostas.peletidis@suse.com>
To:     Takashi Iwai <tiwai@suse.de>, Sean Wang <sean.wang@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: mt7921e: Network device not responding following chip reset
Thread-Topic: mt7921e: Network device not responding following chip reset
Thread-Index: AQHYqCVq81s6yxOdWUOwhxwJBAnnya2lUQ0AgADPJoCAAZ/4roAMtTmE
Date:   Thu, 18 Aug 2022 09:25:44 +0000
Message-ID: <VE1PR04MB6494A9F0126292B8A6826EFCE56D9@VE1PR04MB6494.eurprd04.prod.outlook.com>
References: <VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com>
        <CAGp9Lzp0H7wEAhbFBHDkr2q3fCvjRB5CnpHqeE+y9D=62Y9GOQ@mail.gmail.com>
 <87mtcevsws.wl-tiwai@suse.de>
 <VE1PR04MB64942A33F7B3C65E4167ED1AE5659@VE1PR04MB6494.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB64942A33F7B3C65E4167ED1AE5659@VE1PR04MB6494.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd5ecb83-bfcf-46b4-fdd9-08da80fba065
x-ms-traffictypediagnostic: AM5PR0401MB2643:EE_
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2SUc1nCMvnYRXDM3Z3kEa678xoBlc/Wu2d4hRqtQcXW4RiAffn3x8MFWqCIXVIPZjHP12+2bomRGwtP6hhdfs1DVy5b6ACr7mPVmblQVdSvRovs7lgMAMNSpysrcRjTNY8TMxKa9aIXfKFILHW6i9OlI9XDKucNqPa30PnPa57mZeadeUvUvQPuoKl8p1TWJO2L5ZpftF/AAuK3/4rFwM6WzKBgXjpxGwRDdrUiIpAHpiadRsHLQ0Fs4Y77xBzWlvM3KNdGz63wRtIdOE9FalY2xEYn2K2ZoKQG7iPAdKRIyUsUFPOTf73+cTd59G43l2IEcww/P9r5hnydHs4Md7TXyhHOfJTyvrNibODDjicKgsG44pClYUYdJRbNKOmYQIynupytXQR52APfp+DpwspRImfa08pfUfN3mNWIehC2s5R6AW9FFhAer9u/sXVe9jD1ebMEKRqvDy24fQSeMOyPrcbeUZI/Vkh3qb8uCbLOlhifJvwfRSJ3sbr03MlUlazeyTuOAsu3e0OgZTnRPeihcoIqS6mMcbDoItu3+JMqq4tcBdZanWG8miDZ/rJ3S+bHZCvaXXl6ZydM2xXP1nqmCCsw/blXP9zmhzzDnGtZu9fHXeJRvyi8m6wCG3LNP+XaeIjpQb3p7AJ6fJjHEfE1kIgNFsiqqRbcwFyKBkSuiOux2rGlNVopk2Dxkn5gAHFPaAVMwaJAUWU91wknjBP4lExbZOC8vTapmJ4Lg9ylXFf+i2cKslDYuN3r2KBM0eotkcgEQQ0dlexThBLIAX5VF0fERWg36NNl5UXhPNcv+zIQZUb9QzYpC3OXhsyB0ASxbHwAyPYXEwNt6hjePQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6494.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(346002)(376002)(136003)(44832011)(52536014)(53546011)(478600001)(9686003)(6506007)(83380400001)(8936002)(7696005)(55236004)(110136005)(54906003)(5660300002)(26005)(33656002)(71200400001)(316002)(41300700001)(107886003)(122000001)(38070700005)(55016003)(186003)(86362001)(8676002)(64756008)(76116006)(4326008)(66476007)(66556008)(91956017)(66946007)(66446008)(2906002)(38100700002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UW5whPyMvMrEvh1N60y+NvNyZ6mFMv/BswvbD2ku9my17PQpqMTMo7HBHo?=
 =?iso-8859-1?Q?R5b2RJLGM5KJ8moRDhWPXAGyN3OAUPVlYfniEJRyReYpjyNLkz89d/A4mZ?=
 =?iso-8859-1?Q?tRVUZslEod2IdZ7F/AIUIl8q5s6i7rRlb5/30IxXZtCDXA9+gvUw6XYXpv?=
 =?iso-8859-1?Q?6OS2dlR4N/sJMpWbQRPrEkwaP5xuzeJjT1EeUc8mst7BFsI4BTj+XyspTu?=
 =?iso-8859-1?Q?ePEF9Vg0DpRY3bKDJiTQel61ZmvEwyAPTioBAwkhfmAObrZlVaBy9L5Qt9?=
 =?iso-8859-1?Q?6uNrBGEETVaVGddiNdimL2XzodHUHTY6sGCy+Ic3+6gxWt67i8bgwo5R6W?=
 =?iso-8859-1?Q?G7egk4NapilKz8cPaV6XLP7qCtis6sr0cXezcv0+6ICNMWH9CRLkJmhd4n?=
 =?iso-8859-1?Q?X5iDwQ/34SY3FFCApvaCjdArb+TkJfxTHwjMsFMGSFeM7tJXfM6jk22onH?=
 =?iso-8859-1?Q?/gL6ZCgLVHMSLzNEHgY+ldZhntHVbpZHuepTXBByxrFr5u8ecZBY4tt6pe?=
 =?iso-8859-1?Q?zw208/FDIThtyPaPj3ys7wUTekSeM8wwYU/r1YN7ooQ1p1wrXKJ/3dV9lE?=
 =?iso-8859-1?Q?fmWwmBkEy7oOBirHq2J01dlSar70cP4zgi2jRUmllTe/QIsaA6mDyyqc1I?=
 =?iso-8859-1?Q?K0YLnk90lzvCChHwpJSMpo9xX7iTdvH8pXn/cop8c5Csi850RIi7uGw+CK?=
 =?iso-8859-1?Q?NmqDbd/Zvyxc4OaOsko+sqo7FudDWFaiUcONgvwUZrPZzA/IWhOqLesXDc?=
 =?iso-8859-1?Q?dajyjY4Eq6y+18a4ib5ldWzNA17j81V5VmbtsTArHXH4uaFAEj6O775lqX?=
 =?iso-8859-1?Q?H8447UmLDjjee3wU+FQiBjOX8upopt1Digqhw9xSi82Q/jD0PX+YmZ2Tg4?=
 =?iso-8859-1?Q?843R1DZ73/SUHlfEt0QFzp/CoV4kHDlNgoQZ8b8Dl9YORo5w0+N4EBrxEc?=
 =?iso-8859-1?Q?j7XcR6qftXS2QWRseUrsLWFza0J/ds8JFx5ffdMK02gbCO7cr7eyVrOq6M?=
 =?iso-8859-1?Q?mIn9fuaL9F4FW7gOoFZf0ZPsPMZ65ILhC+tOPpJLRovgr8xfjlur61OEzg?=
 =?iso-8859-1?Q?VDaQmUycNeWL6uBHNJXaQiT/Utqd/zlxFA/5nBsAvky2EVXkZaXmF/UwXV?=
 =?iso-8859-1?Q?ILPQWzB1rvkSJNutCw43AMK5rXOprBDRJgeiA7sidFqIzO9BsF337vQ1LC?=
 =?iso-8859-1?Q?SCZctskW536Le4clLfnCGDZZ1/JF3cW1wf+2qWlqE24Qd08MTlNLZJMzpU?=
 =?iso-8859-1?Q?d3vGiWF3mHAarpeyU5E4K3VpliFPoaCp0ECiZ/PAzdOKMfH8LFIocaeBf8?=
 =?iso-8859-1?Q?LPxylS0WWuYcX98HYk65Y3ZFb+b/hjfbQWRXaFtHEG3EGD6qS0qRQdq2G8?=
 =?iso-8859-1?Q?8hJazqeZoj46h3xnBX+2zCPPEAL7L6UA11WsU5QAIU8jpIn9jwUYyAUcJY?=
 =?iso-8859-1?Q?ExvzaqfnUgqWFjWwHtRAs/lkb0RvQD8nl5Ig5nZ123MCd1Ws/5J24OrQGf?=
 =?iso-8859-1?Q?6QRkUS4qhnps39vU5tTqqLFR2JGnI70E19GiqwIikKWsC+Wpfl5hMbAY04?=
 =?iso-8859-1?Q?Q6zM9ORzo9FSl571bHU4O+j5brFMtnyAmcjdBJ7zSoeM2Rtx7O7Ao3+hCu?=
 =?iso-8859-1?Q?coGFhDqQ8hbl5g8SDcXZqOrNT5bjud0mSL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6494.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5ecb83-bfcf-46b4-fdd9-08da80fba065
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 09:25:44.2219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8DWOMtLCmYLAGpsvtb5+EvrwPRRga9TB6vCZk667lD9oEy7sBmZaTiGebal6vGHP8D0+2/l9D/dFSImyDL4ObNKZRQWpPB8EkFo1z+vLkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Takashi and Sean,=0A=
=0A=
Quick status update: I haven't seen this kernel warning since I switched to=
 the new firmware and kernel. All I see in the logs, as far as mt7921e is c=
oncerned, is the usual set of init messages at boot time:=0A=
=0A=
[    5.594006] mt7921e 0000:03:00.0: enabling device (0000 -> 0002)=0A=
[    5.614022] mt7921e 0000:03:00.0: ASIC revision: 79610010=0A=
[    5.703321] mt7921e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time:=
 20220608210839a=0A=
[    5.980281] mt7921e 0000:03:00.0: WM Firmware Version: ____010000, Build=
 Time: 20220608210922=0A=
[    6.808253] mt7921e 0000:03:00.0 wlp3s0: renamed from wlan0=0A=
=0A=
If I see that issue again I'll update this thread. Thanks for your help.=0A=
=0A=
=0A=
Regards,=0A=
Kostas=0A=
=0A=
=0A=
From: Kostas Peletidis <kostas.peletidis@suse.com>=0A=
Sent: 10 August 2022 09:16=0A=
To: Takashi Iwai <tiwai@suse.de>; Sean Wang <sean.wang@kernel.org>=0A=
Cc: linux-wireless@vger.kernel.org <linux-wireless@vger.kernel.org>; Takash=
i Iwai <tiwai@suse.com>=0A=
Subject: Re: mt7921e: Network device not responding following chip reset =
=0A=
=A0=0A=
Hello Takashi and Sean,=0A=
=0A=
Thank you for your help.=A0I have started using Takashi's kernel with Sean'=
s patch and the firmware from the location Takashi indicated earlier. I hav=
en't seen the issue yet; it seems to be mainly random, though the last two =
times it happened during a Teams call. I'll stick to this kernel for a whil=
e and let you know if I see it again.=0A=
=0A=
Regards,=0A=
Kostas=0A=
=0A=
From: Takashi Iwai <tiwai@suse.de>=0A=
Sent: 09 August 2022 08:21=0A=
To: Sean Wang <sean.wang@kernel.org>=0A=
Cc: Kostas Peletidis <kostas.peletidis@suse.com>; linux-wireless@vger.kerne=
l.org <linux-wireless@vger.kernel.org>; Takashi Iwai <tiwai@suse.com>=0A=
Subject: Re: mt7921e: Network device not responding following chip reset =
=0A=
=A0=0A=
On Mon, 08 Aug 2022 19:59:58 +0200,=0A=
Sean Wang wrote:=0A=
> =0A=
> Hi Kostas,=0A=
> =0A=
> Applying the patch in [1] should be able to fix the following kernel=0A=
> panic to make the system run even if something goes wrong in the=0A=
> driver.=0A=
> =0A=
> Jul 08 08:47:21 savra kernel: WARNING: CPU: 7 PID: 113 at=0A=
> kernel/kthread.c:659 kthread_park+0x7b/0x90=0A=
> <...>=0A=
> Jul 08 08:47:21 savra kernel: Call Trace:=0A=
> Jul 08 08:47:21 savra kernel:=A0 <TASK>=0A=
> Jul 08 08:47:21 savra kernel:=A0 mt7921e_mac_reset+0x9e/0x2d0 [mt7921e=0A=
> 1df6344b7ec017c6819314bafbaefbc4739af58d]=0A=
> Jul 08 08:47:21 savra kernel:=A0 mt7921_mac_reset_work+0x9f/0x14a=0A=
> [mt7921_common a3df60fd5ed501d6ce3c322675b791e633aa28b5]=0A=
> Jul 08 08:47:21 savra kernel:=A0 process_one_work+0x208/0x3c0=0A=
> Jul 08 08:47:21 savra kernel:=A0 worker_thread+0x4a/0x3b0=0A=
> Jul 08 08:47:21 savra kernel:=A0 ? process_one_work+0x3c0/0x3c0=0A=
> Jul 08 08:47:21 savra kernel:=A0 kthread+0xda/0x100=0A=
> Jul 08 08:47:21 savra kernel:=A0 ? kthread_complete_and_exit+0x20/0x20=0A=
> Jul 08 08:47:21 savra kernel:=A0 ret_from_fork+0x22/0x30=0A=
> Jul 08 08:47:21 savra kernel:=A0 </TASK>=0A=
> =0A=
> On the other hand, we need time to figure out why "mt7921e=0A=
> 0000:03:00.0: driver own failed" happened in the log you provided=0A=
> here.=0A=
> But if it is possible for you, you can try out the latest firmware in=0A=
> [2] first to see if it would be helpful for you.=0A=
> =0A=
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/727eb5ffd3c=
7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com/=0A=
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwa=
re.git/tree/mediatek=0A=
> Grab and update the following three files.=0A=
> 1.) BT_RAM_CODE_MT7961_1_2_hdr.bin=0A=
> 2.) WIFI_MT7961_patch_mcu_1_2_hdr.bin=0A=
> 3.) WIFI_RAM_CODE_MT7961_1.bin=0A=
=0A=
Thanks!=0A=
=0A=
Kostas, I'm build a test kernel package with the patch above in OBS=0A=
home:tiwai:bsc1201845 repo.=A0 Once after the build finishes (takes an=0A=
hour or so), it'll appear at=0A=
=A0 http://download.opensuse.org/repositories/home:/tiwai:/bsc1201845/stand=
ard/=0A=
=0A=
Please give it a try later.=0A=
=0A=
The firmware files should be already included in the latest TW=0A=
kernel-firmware-* packages.=A0 But, to be sure, please install the=0A=
kernel-firmware-* packages from OBS Kernel:HEAD repo, which is built=0A=
from the latest linux-firmware git tree.=0A=
=A0 http://download.opensuse.org/repositories/Kernel:/HEAD/standard/=A0 =0A=
=0A=
(Note that OBS Kernel:HEAD contains the kernel package itself, so=0A=
better to download kernel-firmware-*.rpm there and install them=0A=
manually instead of adding the repo URL to zypper.)=0A=
=0A=
=0A=
Takashi=0A=
=0A=
> =0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0 Sean=0A=
> =0A=
> On Thu, Aug 4, 2022 at 10:25 AM Kostas Peletidis=0A=
> <kostas.peletidis@suse.com> wrote:=0A=
> >=0A=
> > Hello,=0A=
> >=0A=
> > Takashi (in cc) and I have been looking at a strange mt7921e issue I en=
countered and any help to get to the bottom of it would be much appreciated=
. During normal use of my machine sometimes the network would become unreac=
hable and any network related commands, such as ping or ss, would hang inde=
finitely when executed in a terminal. This is what a typical dmesg output w=
ould look like (see URL at the end of this message for full details):=0A=
> >=0A=
> > [11249.676616] r8169 0000:02:00.0 enp2s0f0: Link is Down=0A=
> > [11453.812782] mt7921e 0000:03:00.0: driver own failed=0A=
> > [11454.986117] mt7921e 0000:03:00.0: driver own failed=0A=
> > [11454.986134] mt7921e 0000:03:00.0: chip reset=0A=
> > [11456.170894] mt7921e 0000:03:00.0: driver own failed=0A=
> > [11456.278532] pcieport 0000:00:02.3: pciehp: Slot(0): Link Down=0A=
> > [11456.278536] pcieport 0000:00:02.3: pciehp: Slot(0): Card not present=
=0A=
> > [11456.313973] wlp3s0: deauthenticating from f8:5b:3b:0f:2b:9f by local=
 choice (Reason: 3=3DDEAUTH_LEAVING)=0A=
> > [11457.286206] mt7921e 0000:03:00.0: Timeout for driver own=0A=
> > [11458.400420] mt7921e 0000:03:00.0: driver own failed=0A=
> > [11458.400442] ------------[ cut here ]------------=0A=
> > [11458.400443] WARNING: CPU: 2 PID: 8597 at kernel/kthread.c:659 kthrea=
d_park+0x81/0x90=0A=
> >=0A=
> > I have noticed this issue both with tainted and not tainted kernels. To=
 me it looks like some kind of hardware reset timed out (or the hardware wa=
s probed too quickly). This is what a successful chip reset looks like in m=
y logs:=0A=
> >=0A=
> > Chip reset OK, no warning=0A=
> > -------------------------=0A=
> > Jul 04 13:06:33 savra kernel: mt7921e 0000:03:00.0: driver own failed=
=0A=
> > Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: driver own failed=
=0A=
> > Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: chip reset=0A=
> > Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: HW/SW Version: 0x8a=
108a10, Build Time: 20220311230842a=0A=
> > Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: WM Firmware Version=
: ____010000, Build Time: 20220311230931=0A=
> > Jul 04 13:06:36 savra kernel: wlp3s0: Driver requested disconnection fr=
om AP f8:5b:3b:0f:2b:9f=0A=
> >=0A=
> > And this is what the chip reset looks like when the issue occurs:=0A=
> >=0A=
> > Chip reset timeout, warning=0A=
> > ---------------------------=0A=
> > Aug 03 12:18:00 savra kernel: mt7921e 0000:03:00.0: driver own failed=
=0A=
> > Aug 03 12:18:02 savra kernel: mt7921e 0000:03:00.0: driver own failed=
=0A=
> > Aug 03 12:18:02 savra kernel: mt7921e 0000:03:00.0: chip reset=0A=
> > Aug 03 12:18:03 savra kernel: mt7921e 0000:03:00.0: driver own failed=
=0A=
> > Aug 03 12:18:03 savra kernel: pcieport 0000:00:02.3: pciehp: Slot(0): L=
ink Down=0A=
> > Aug 03 12:18:03 savra kernel: pcieport 0000:00:02.3: pciehp: Slot(0): C=
ard not present=0A=
> > Aug 03 12:18:03 savra kernel: wlp3s0: deauthenticating from f8:5b:3b:0f=
:2b:9f by local choice (Reason: 3=3DDEAUTH_LEAVING)=0A=
> > Aug 03 12:18:04 savra kernel: mt7921e 0000:03:00.0: Timeout for driver =
own=0A=
> > Aug 03 12:18:05 savra kernel: mt7921e 0000:03:00.0: driver own failed=
=0A=
> > Aug 03 12:18:05 savra kernel: ------------[ cut here ]------------=0A=
> > Aug 03 12:18:05 savra kernel: WARNING: CPU: 6 PID: 26340 at kernel/kthr=
ead.c:659 kthread_park+0x81/0x90=0A=
> >=0A=
> > I have added dmesg logs and all pertinent information in the ticket bel=
ow:=0A=
> > https://bugzilla.opensuse.org/show_bug.cgi?id=3D1201845=0A=
> >=0A=
> > Would someone please have a look and help us figure out what would caus=
e the "driver own failed" message to be logged? Thank you.=0A=
> >=0A=
> >=0A=
> > Regards,=0A=
> > Kostas=0A=
> =
