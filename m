Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE46E4033E5
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 07:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbhIHFrE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 01:47:04 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:60128
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238723AbhIHFrD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 01:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmNQhE20DY7B2eH/ZZ46il2YGWMy2H/6TBWg3vBg6Y0V9hU1k9qn4PTkHTAJT3HGXepOWzux5rSgM+ff1/Pq9qeMqXwy6odmW4fyWB0UY21NOsZA5kbKkqm3VYuoOvzb0b3CQizzOVaKsRBjZOWmvbzI16Z2azn08usSnV+dJpcDWjm4KW6ZA4NBuXP4WHSJ4KPB2swAsueae9IhkRnPCRCEnI2rl3xNwqBzuzatRBuIQEMPZA81y6tlk2Y6g4YZmwBKruOdsMWWl+G9Y2kvYJ3rPAr1UQ7dCgxf3aSftejAF0uWhPVywV5GEBPuZzAtB5zgHmb3QA/UWZiMy3NSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a1jmupFm34yt9mqzbYlrX03UPgMo8ECl1Ys/SgYunnI=;
 b=OIPPXpHfgB8MLRKU3WwCEJIRG/3YtphhCGuMiX2R5MMPW68D0OntUimmeGeLxUoUCyDIuC1Kg1hIlsrvk5bEzSWQ+/01ZcNer9nddMxvePoQ7IvIN7ZhDsWneWqmDzgp83CBNmTgbekDplplOJJHT0i+oUfLI00lhHEO4RlIw1uJGFNpqSNDrzud8K5R8P4qubuFJmLbfJvmFVhECaNDQ0SkysN+u4dg1S4g7wi9FLVBPcwLE/SOWPON7D+3/2bctUHcblFu3VDd9VlhVtRPuFye+BNXuCtxf324Hn2elUX0JBeXi2gywAbV1QEp9GuuABndbuOBRBOdjcVzwC7WDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1jmupFm34yt9mqzbYlrX03UPgMo8ECl1Ys/SgYunnI=;
 b=V8J6QxcZhX4llgJEMjty04jX/mH8kegWKqCfO/TDZoCTLK++1/+gez3+zixvY1UwzAktb7jmjDe3v0ViIH1iFeHDHzBomPHzMkVE7j8FZFdLiQ+OO/hHCfnsNBycQ17ESvrhmcv6jiYHHu4vH8d8vk+JRsbNotUrSNBHFkDLpv8=
Received: from AM0PR04MB4529.eurprd04.prod.outlook.com (2603:10a6:208:7a::18)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 05:45:53 +0000
Received: from AM0PR04MB4529.eurprd04.prod.outlook.com
 ([fe80::502f:edb1:8aa7:dbd4]) by AM0PR04MB4529.eurprd04.prod.outlook.com
 ([fe80::502f:edb1:8aa7:dbd4%4]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 05:45:53 +0000
From:   Sharvari Harisangam <sharvari.harisangam@nxp.com>
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        =?iso-8859-1?Q?Jonas_Dre=DFler?= <verdre@v0yd.nl>
CC:     Takashi Iwai <tiwai@suse.de>, Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Subject: RE: [EXT] Re: mwifiex cmd timeout on one pci variant
Thread-Topic: [EXT] Re: mwifiex cmd timeout on one pci variant
Thread-Index: AQHXpHN5KtudkcwYiUOhtd8STmKOxauZoHjw
Date:   Wed, 8 Sep 2021 05:45:53 +0000
Message-ID: <AM0PR04MB4529E0C28F43288E189D8F50FCD49@AM0PR04MB4529.eurprd04.prod.outlook.com>
References: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
 <YThLznrMQ4EYUDEl@atmark-techno.com>
In-Reply-To: <YThLznrMQ4EYUDEl@atmark-techno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: atmark-techno.com; dkim=none (message not signed)
 header.d=none;atmark-techno.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8039c717-79b0-45ed-0a87-08d9728bebd9
x-ms-traffictypediagnostic: AM0PR04MB7043:
x-microsoft-antispam-prvs: <AM0PR04MB704378B3ADB96CF808235CD6FCD49@AM0PR04MB7043.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyN0s1IfE33pSjgN1mXOnRdrOYrQYVQ6RQk/Ytzp+YiDZIWLGHzC/s8nMBpc9Y+x5C0qjmEjgkxeYlb6HeO6ZHTNGLam+hP2hrWa4e1P3KbiC2144eRK2TILO0e9+RPChYzSHL3oHVKIguPUPToDSvdWiJcVHfNA7AodS3m18+R2maD0ux9C7G5RijdjGdAnQVrxZrF+IzPcTnUkBtsEY4KispI1qr0CsbyL7g1h0PqCgruvvsFj/xkRijTwzImZirFFyBFoOI9saYC+BPXKeSz3Fh7w2mC4JpHktg6XGvfaOl4jopEDfvrWbMuoujAEsDMyfnidLR8ZlE04zhS2iBP/6rYWlAXhUiV2DP/1L2nZddqmku6OwK2yUOTjsUscCr4VT5Lo2GTUcqXG2qswlQFw7P+AyNQg7LDJSQ1y8bmF6u1flFPVDMQkIh072/snJ0G8dl7jHf7kW5US+AZUQaOyA3XyX5DtrWDiNrcv2Ukhyt6gcvMTxOz+4U/MpuAwzUxNArWbkMh2QHYiyuqPd5INm54DwRcExdyPAj1gNGWNGcYTXXN1rEJPB5xktuLeuzoIxceCbmdybaNLM68oXCHaWXeeOQJabGSPszvXj5GjWOgn2zwggJRDx3WXW4q4Ly2e3agy+O/och61tppFRbYj01WpENvOFVDXS+sYT6jENSfRMhEfZ9s32mPXX6CLL9/ol58dQb37lib+liZL6Ay2zyJKgaSFqjIyCIEz/wdLY3se8yTJMPkwlTO5LomXE0Qbaqpv7xPZrIYY4tEWGhoi+j93vYbwOvCbJMAw/U0nqk4wTsO1P+s/ylxzysIGEqrqqsQLMHNhpozOHewZlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4529.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(7696005)(26005)(83380400001)(52536014)(66574015)(5660300002)(316002)(110136005)(55236004)(2906002)(54906003)(186003)(55016002)(4326008)(38070700005)(9686003)(966005)(76116006)(478600001)(8936002)(66446008)(66556008)(64756008)(86362001)(66476007)(8676002)(38100700002)(44832011)(122000001)(33656002)(66946007)(45080400002)(7416002)(6506007)(71200400001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LQGrCX+oSr9moRH8p93gj+wTCW5QeKfmDp13hLjh0DErOVW3W3pAadMqj3?=
 =?iso-8859-1?Q?WXNhX3Muf3rselWgGdB/UFoD9IfKDVHegZXIvDMxLLAzMbCJ9bNTwdMltj?=
 =?iso-8859-1?Q?xB4atQLUQ+vzBK+BtrVdhUv16Tfm+m9JgNPCDzAUakdePbTpjYdyf0SNf8?=
 =?iso-8859-1?Q?3vPSkQDaD0CLacwqPQfPS5DxoA0iRfr/gmuRo0GDVtUQfijootp/TdBLDt?=
 =?iso-8859-1?Q?Tm/Z/C7LkyI+P8BoxPcr0KgR4HRA4kU6UNLjRZsLcfBw4+JE4MhocPpazM?=
 =?iso-8859-1?Q?AjJyZhbQPB66HMzNRANxBTXl9xeDsaam6lTQMXhCS4B5vVxHoQOhsuYJpa?=
 =?iso-8859-1?Q?Cqq8qhC1xZRykjq2muXhY33q1pDgQcoNSyYzbXFHnGbwkjpMOOmGDzAYmK?=
 =?iso-8859-1?Q?1e1PAma4nSrR3RHMCO1lkndY2ioikOWmL8c+SKvjoUiRpRH47Ki2o48ueP?=
 =?iso-8859-1?Q?tdaiBxY1VcfnEiX5BYJpzyNxw6Yqt62oZEefrxqhtz/l1chhB2acZxfl7A?=
 =?iso-8859-1?Q?rXISCXXokbJVKessFzvXdoZjmjSNNLRJ11cZsbeqH1SDXEFvugCprPLUww?=
 =?iso-8859-1?Q?/E0wCSBQwxVW5g7LeMeRfOpQ/x5wf/GKPFdicSJ6Yu6+yW/+p9hYj/Mnqm?=
 =?iso-8859-1?Q?e7VcPG/Y8QV2CP5ELiQrj7ACxQGxxWDYpkuAPGXKnK2FRcmkJSR4G/MDft?=
 =?iso-8859-1?Q?8SCOgn3EkzyEBKGicaGTytocPq4O7YDo9gru/27oChBGHDSpv2cAk62X5R?=
 =?iso-8859-1?Q?xl2KOaIKGY0OVHHXj+/vFhpyja6a4ckB++UO1BQDiORJ4mozIgptYUPoJq?=
 =?iso-8859-1?Q?Ck1QCOXuX406eE25dLUQcrY5EDXwDOYMVOGCAeoOGERD7vtrNpb09nT3vx?=
 =?iso-8859-1?Q?yVOgKBE08RteZ1Vho3v3keiH0y/vNDYo6y11txbPTP+XHdTX9qFkCLNnym?=
 =?iso-8859-1?Q?OpWXe+ix+7gdqRvJR+TtmdL52fuMFf8ZgBVWtQYQdAnNCou3OZBrmnFMoP?=
 =?iso-8859-1?Q?oeBttL3RqrxqkQmdcGWzgMicKMGjQrvw3kTyPyYSnrnAWg2JFy6D6U4eiC?=
 =?iso-8859-1?Q?oeLBtisL3C8euq7HNmWcu+SAWswrKzlp05HrHTPDHlxI0Sfjd7W1IM4Li7?=
 =?iso-8859-1?Q?we+zS3JxT/4mwYvOe/2wkMiFDHyJw5yXNrD8HL4fthDwt4fu+3Nv6ythXl?=
 =?iso-8859-1?Q?qmPM4Pu2ZFuwYcLkFidQz63KlIvsCQHWYIFDWXDqIJfXcsVk1b1HVGfhCF?=
 =?iso-8859-1?Q?HfBaC3zDNhCzvHCUizPvLl1KpnHmOOx5jzFWYD7uPYyQfHRsC1xLjjz0IA?=
 =?iso-8859-1?Q?ipHXdiqJfeHMcjl8y9wmiz7dlHc0fNFTdMTBKJqKYE9s2vk5hUdliPcSLr?=
 =?iso-8859-1?Q?kINjOYssWv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4529.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8039c717-79b0-45ed-0a87-08d9728bebd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 05:45:53.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJ69/7Rn/slumhePSCI7PiePAI51O5UCvpCmD1G7QF7YF5s8uRGH06B+cFdkn2gSIik4Gty5AC1MgkWh4fcGRTdSJqT3L0xNEDHzSSSRIFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dominique,

Use firmware from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/=
linux-firmware.git/tree/mrvl
for mwifiex driver.


Thanks,
Sharvari

> -----Original Message-----
> From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
> Sent: Wednesday, September 8, 2021 11:06 AM
> To: linux-wireless@vger.kernel.org; Amitkumar Karwar
> <amitkarwar@gmail.com>; Jonas Dre=DFler <verdre@v0yd.nl>
> Cc: Takashi Iwai <tiwai@suse.de>; Tsuchiya Yuto <kitakar@gmail.com>; Geer=
t
> Uytterhoeven <geert+renesas@glider.be>; Arnd Bergmann <arnd@arndb.de>;
> Lee Jones <lee.jones@linaro.org>; Kalle Valo <kvalo@codeaurora.org>; Xinm=
ing
> Hu <huxinming820@gmail.com>; Sharvari Harisangam
> <sharvari.harisangam@nxp.com>; Ganapathi Bhat <ganapathi017@gmail.com>
> Subject: [EXT] Re: mwifiex cmd timeout on one pci variant
>=20
> Caution: EXT Email
>=20
> (+cc Jonas Dre=DFler, sorry for two mails in a row for others)
>=20
> Dominique MARTINET wrote on Wed, Sep 08, 2021 at 01:43:43PM +0900:
> > I've got a board with an i.MX8MP chip, and three different marvell
> > W8997
> > M.2 modules
>=20
> (I just noticed Jonas' patches "mwifiex: Work around firmware bugs on
> 88W8897 chip" on linux-wireless, but it doesn't seem to change anything f=
or me,
> so my problem isn't related to pci post or interrupt wake apparently. Was=
 worth
> a try...)
>=20
> I'm surprised though he says the latest firmware is 15.68.19.p21, but I c=
an't find
> it anywhere -- linux-firmware only has up to 16.68.1.p179 and I got 16.68=
.10.p16
> from NXP dependencies, and now I'm searching a bit harder i also found
> 16.92.10.p124 !? (note 16.92 instead of 16.68, also
> NXP) but I have no idea where to find anything 'official' from marvell as
> git.marvell.com/mwifiex-firmware.git disappeared.
>=20
> Where could I find this version you speak of?
>=20
>=20
> Thanks,
>=20
> > -- one from laird which works fine, and two from azurewave which are
> > labeled exactly the same AW-CM276MA 2276MA PCIE-UART except one works
> > and not the other.
> > The inscription on the chip itself are slightly different, one saying
> > it's a W8997-M1216 from marvell (works) and the other having
> > AW-CM276NF azurewave mark. The electronics around are also different.
> >
> > I could say it's just a bad chip, but I've actually got two of each
> > (samples) which act the same... And I've tried it in another device
> > where it works with the same kernel/firmware, so there must be
> > something wrong on the board as well as the wifi card works elsewhere.
> >
> >
> > Anyway, if someone knows how to get around to debugging this, I'd
> > appreciate a pointer! I can't see anything wrong with the tools I have
> > here.
> > If nothing else, I can't read /sys/class/devcoredump/devcd*/data that
> > I saw Amitkumar Karwar request somewhere else, so just deciphering
> > this would be great help.
> >
> >
> > dmesg looks like this on failure:
> > [  108.513028] mwifiex_pcie 0000:01:00.0: mwifiex_cmd_timeout_func:
> > Timeout cmd id =3D 0x10, act =3D 0x1 [  108.522388] mwifiex_pcie
> > 0000:01:00.0: num_data_h2c_failure =3D 0 [  108.528310] mwifiex_pcie
> > 0000:01:00.0: num_cmd_h2c_failure =3D 0 [  108.534143] mwifiex_pcie
> > 0000:01:00.0: is_cmd_timedout =3D 1 [  108.539631] mwifiex_pcie
> > 0000:01:00.0: num_tx_timeout =3D 0 [  108.545029] mwifiex_pcie
> > 0000:01:00.0: last_cmd_index =3D 0 [  108.550431] mwifiex_pcie
> > 0000:01:00.0: last_cmd_id: 10 00 28 00 16 00 cd 00 1e 00 [
> > 108.557913] mwifiex_pcie 0000:01:00.0: last_cmd_act: 01 00 13 00 01 00
> > 01 00 00 00 [  108.565484] mwifiex_pcie 0000:01:00.0:
> > last_cmd_resp_index =3D 4 [  108.571318] mwifiex_pcie 0000:01:00.0:
> > last_cmd_resp_id: df 80 28 80 16 80 cd 80 1e 80 [  108.579237]
> > mwifiex_pcie 0000:01:00.0: last_event_index =3D 2 [  108.584810]
> > mwifiex_pcie 0000:01:00.0: last_event: 00 00 0b 00 0a 00 00 00 00 00 [
> > 108.592206] mwifiex_pcie 0000:01:00.0: data_sent=3D0 cmd_sent=3D1 [
> > 108.597954] mwifiex_pcie 0000:01:00.0: ps_mode=3D1 ps_state=3D0 [
> > 108.604085] mwifiex_pcie 0000:01:00.0: =3D=3D=3Dmwifiex driverinfo dump
> > start=3D=3D=3D [  108.613552] mwifiex_pcie 0000:01:00.0: info: MWIFIEX =
VERSION:
> mwifiex 1.0 (16.68.1.p179) [  108.621748] mwifiex_pcie 0000:01:00.0: PCIE
> register dump start [  108.627676] mwifiex_pcie 0000:01:00.0: pcie scratc=
h
> register:
> > [  108.633441] mwifiex_pcie 0000:01:00.0: reg:0xcf0, value=3D0xfedcba00
> >                reg:0xcf8, value=3D0x8260049
> >                reg:0xcfc, value=3D0x1282820
> >
> > [  108.648584] mwifiex_pcie 0000:01:00.0: PCIE register dump end [
> > 108.654411] mwifiex_pcie 0000:01:00.0: =3D=3D=3Dmwifiex driverinfo dump
> > end=3D=3D=3D [  108.661119] mwifiex_pcie 0000:01:00.0: =3D=3D mwifiex f=
irmware
> > dump start =3D=3D [  110.560689] mwifiex_pcie 0000:01:00.0: cmd_wait_q
> > terminated: -110 [  148.127107] mwifiex_pcie 0000:01:00.0: =3D=3D mwifi=
ex
> > firmware dump end =3D=3D [  148.134552] mwifiex_pcie 0000:01:00.0: =3D=
=3D
> > mwifiex dump information to /sys/class/devcoredump start [
> > 148.143669] mwifiex_pcie 0000:01:00.0: =3D=3D mwifiex dump information =
to
> > /sys/class/devcoredump end [  148.152485] mwifiex_pcie 0000:01:00.0:
> PREP_CMD: FW is in bad state [  148.158915] mwifiex_pcie 0000:01:00.0: in=
fo:
> shutdown mwifiex...
> > [  148.165829] mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed [
> > 148.443761] mwifiex_pcie 0000:01:00.0: info: dnld wifi firmware from
> > 169340 bytes [  149.511193] mwifiex_pcie 0000:01:00.0: info: FW
> > download over, size 632240 bytes [  150.163677] mwifiex_pcie
> > 0000:01:00.0: WLAN FW is active [  150.231583] mwifiex_pcie
> > 0000:01:00.0: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p179) [
> > 150.239814] mwifiex_pcie 0000:01:00.0: driver_version =3D mwifiex 1.0
> > (16.68.1.p179)
> >
> > I tried with two different firmwares, full dmesg and data.txt are here:
> > hang on `ip link set mlan0 up`:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcod=
e
> > wreck.org%2Ftmp%2F16.68.1.p179-
> data.txt&amp;data=3D04%7C01%7Csharvari.ha
> >
> risangam%40nxp.com%7C86cd8c9cb9ea4e65eeb508d9728a9b73%7C686ea1d3
> bc2b4c
> >
> 6fa92cd99c5c301635%7C0%7C1%7C637666761903623322%7CUnknown%7CT
> WFpbGZsb3
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >
> C3000&amp;sdata=3DI2QRJPwCgkPDqs1v8DnNGNciAHdqgPRIiYcrAc%2BPo4Y%3D
> &amp;r
> > eserved=3D0
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcod=
e
> > wreck.org%2Ftmp%2F16.68.1.p179-
> dmesg&amp;data=3D04%7C01%7Csharvari.haris
> >
> angam%40nxp.com%7C86cd8c9cb9ea4e65eeb508d9728a9b73%7C686ea1d3bc
> 2b4c6fa
> >
> 92cd99c5c301635%7C0%7C1%7C637666761903623322%7CUnknown%7CTWFp
> bGZsb3d8e
> >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C30
> >
> 00&amp;sdata=3DBcz1xLDvenNyPAF1l9lErWdzXR03FRmt9IHiWSTZUhs%3D&amp;r
> eserv
> > ed=3D0
> >
> > hang on `iw mlan0 scan` after successful link up:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcod=
e
> > wreck.org%2Ftmp%2F16.68.1.p179-2-
> data.txt&amp;data=3D04%7C01%7Csharvari.
> >
> harisangam%40nxp.com%7C86cd8c9cb9ea4e65eeb508d9728a9b73%7C686ea1
> d3bc2b
> >
> 4c6fa92cd99c5c301635%7C0%7C1%7C637666761903623322%7CUnknown%7C
> TWFpbGZs
> >
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D
> > %7C3000&amp;sdata=3D6UC7r1UTPkAbjJ7EwRvDKtDy9NgAFw2PExw9iObdabI%
> 3D&amp;r
> > eserved=3D0
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcod=
e
> > wreck.org%2Ftmp%2F16.68.1.p179-2-
> dmesg&amp;data=3D04%7C01%7Csharvari.har
> >
> isangam%40nxp.com%7C86cd8c9cb9ea4e65eeb508d9728a9b73%7C686ea1d3b
> c2b4c6
> >
> fa92cd99c5c301635%7C0%7C1%7C637666761903623322%7CUnknown%7CTW
> FpbGZsb3d
> >
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C
> >
> 3000&amp;sdata=3Detz0gCsNgiBRvrff7J0GH%2BOR%2Bn7TYgBj3RGNLkPbuGo%3
> D&amp;
> > reserved=3D0
> >
> > other firmware (dmesg truncated to just timeout message):
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcod=
e
> > wreck.org%2Ftmp%2F16.68.10.p16-
> data.txt&amp;data=3D04%7C01%7Csharvari.ha
> >
> risangam%40nxp.com%7C86cd8c9cb9ea4e65eeb508d9728a9b73%7C686ea1d3
> bc2b4c
> >
> 6fa92cd99c5c301635%7C0%7C1%7C637666761903623322%7CUnknown%7CT
> WFpbGZsb3
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >
> C3000&amp;sdata=3Dfz34AoQH2IwUU%2B3RyrTWUu8tLyqJTUQb0YWcWbWlVZ8
> %3D&amp;r
> > eserved=3D0
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcod=
e
> > wreck.org%2Ftmp%2F16.68.10.p16-
> dmesg&amp;data=3D04%7C01%7Csharvari.haris
> >
> angam%40nxp.com%7C86cd8c9cb9ea4e65eeb508d9728a9b73%7C686ea1d3bc
> 2b4c6fa
> >
> 92cd99c5c301635%7C0%7C1%7C637666761903623322%7CUnknown%7CTWFp
> bGZsb3d8e
> >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C30
> >
> 00&amp;sdata=3DABzwF0ix3q5PdbqI%2Bm8SQ2U6teVeh%2FclaDkgQBVKrpA%3D
> &amp;re
> > served=3D0
> >
> >
> >
> > Extra info:
> >  - it doesn't always fail at the same place, so this looks like a
> > tolerance problem? e.g. sometimes transmission works and sometimes a
> > message is garbled?
> >
> > - on the working azurewave module I can keep the card maxed at
> > ~300mbps in or ~100mbps out without problem for a while with iperf so
> > signals can't be that bad...? Or that could just be wishful thinking!
> --
> Dominique Martinet
