Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490392729C5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIUPRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 11:17:32 -0400
Received: from mail-eopbgr1300092.outbound.protection.outlook.com ([40.107.130.92]:19904
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgIUPRb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 11:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQLdqeUh37AatRtArVqozq//gV5t7ppPqpsiNCpkH66A3BVhBZ4v8palVQu8g45N1GiU3lbqBxaW3JwSCixGQUgKawRUTOZq9VQ9LxkkTmvv9vYZFH0IipzlzddQPUQWgT9AusVSPf5ZYxAq/9hNdXvM/gB60bHUIzlfvRg7aE1/LR2KQkaOSB9+/W64etTQ8ZOL8GCgiuC5EIuBCfgvLVhHI8/V8p4HsGl5NqzZhPQ7MT8i9pCfT3U08jVxo9krDKjtm6eaKePw/0xfAnm1b86KunFFzeARIdLLWlKZ3S3PXG3rVoEsqX/EZVWOBzWzQQl4rz7eplX4EY6i6yEgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy0bAKCeBMeim263S+Gu/ZauKl+PIc2p/RbTmM1qiG4=;
 b=WDFemN2w/AJLDxJ7h+bCYf1VgH1dX+cTezK1zoHsnSDaS66/mGii99DuLJRLMHp6fjmBeBh+saD/1CajPomN/OkogHDeVkFDFb05aWyHK+iBdlkbtcNnE1po4fj2K4QJJbegcQ0EJWF3FcIjhrLNl9lprBCBM8hbrVaBNc/Ahc2StSpfPH6Not5cA9ZzsjU5wpTX+5U79YOwZTDU7qXwczjSNdkjpS0PExzxwSfwzBebt1Yh6cxN3jHdpiZIk0dS/lafD3sjJn2xGpCoPxd66gsKZCBfMaD24+7jzHVFpWRT4RIxk0k96ElOxXkSPVOcobSRL/jRfm6yWPnipiNvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=veethree.com; dmarc=pass action=none header.from=veethree.com;
 dkim=pass header.d=veethree.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veethree.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy0bAKCeBMeim263S+Gu/ZauKl+PIc2p/RbTmM1qiG4=;
 b=A15MmolTSbkvTMTj1W2Eg5jjT2OTvfl8EYEvn6giZ7OIg5tYiIqaSl3ag4bMELY9zfQ2tdmAHdgHqaQOa6WduL+jEBM3gBU7M8usclHL7tuP+kvRh/UayRtwP/Y15VGmj/aTGDCNR/bf4UVBmJTxeruMd5Hgt6dyfiuAT/Oq9z0=
Received: from TY2PR04MB3264.apcprd04.prod.outlook.com (2603:1096:404:a1::9)
 by TY2PR04MB3824.apcprd04.prod.outlook.com (2603:1096:404:f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 15:17:27 +0000
Received: from TY2PR04MB3264.apcprd04.prod.outlook.com
 ([fe80::1dcb:b8b4:dd44:ae2d]) by TY2PR04MB3264.apcprd04.prod.outlook.com
 ([fe80::1dcb:b8b4:dd44:ae2d%6]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 15:17:27 +0000
From:   Eduardo Righes <eduardo.righes@veethree.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: ath10k_sdio QCA9377
Thread-Topic: ath10k_sdio QCA9377
Thread-Index: AdaQKj/quOQLXm0nT+yhKLHrTNPi2A==
Date:   Mon, 21 Sep 2020 15:17:27 +0000
Message-ID: <TY2PR04MB32644483BADB8D7C558C497AED3A0@TY2PR04MB3264.apcprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=veethree.com;
x-originating-ip: [217.39.183.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee64e00-b912-445e-f564-08d85e417379
x-ms-traffictypediagnostic: TY2PR04MB3824:
x-microsoft-antispam-prvs: <TY2PR04MB3824B77CC4E5BD456DF92E99ED3A0@TY2PR04MB3824.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUjK+tZ2yrUsKFQRf6DxLMgPx0//CEoIvh/RJehHU9fsOJd4toirJa1ZVgKk7eELUWc4lF8InZA/Rvr//CyrIUe271kzwUvUC1DzbxKAOj1RE/upzQXH3smCz7Td0nLCl+uaDd8vG+ZhrERekrcr/DkR714bVvzTmFfTSd0VW35DRK5lehFD2c0VPQHrzmAIYtpOf3a3NtziArrdVkBnZgplD6g1Cn26GNBF3OypHizqQzo5vL2POPUbVHhlmqtbx/EU9y6qcZWbqv3UUjwHtEOekyyKp8rAzlaBrLpp+7IfrG7FU+1OWHn3oOyazjfK5AfCuU2PSQclQp2kpOGL5eMSdeePG0Qvf7EK/MMQAYFvYNCoG4Zz5Wa0jdoU1FaqGX0xEZWD52/cXnWOKMq8tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR04MB3264.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39840400004)(346002)(396003)(52536014)(66556008)(5660300002)(2906002)(66476007)(8936002)(478600001)(9686003)(76116006)(71200400001)(55016002)(66946007)(66446008)(86362001)(33656002)(64756008)(6916009)(186003)(7116003)(8676002)(44832011)(7696005)(316002)(26005)(966005)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3q8Oj0S5PljMJ/p0PfGe5QcLlGl01DfsaAr/GT1nPvy9JcFcIIuxdDp7gz33nUVOf7KVrL5xVw7py8Tn9rJfy3YfpsoXmX+94utGJRF+viIqUZ2lEhhkz47Kp0dDDMDxrnFbOuhxg7nCR/Nt1psEaBmE0BRngyPRY9ll7v3CqAxD+gI4hy1712wnIo9o2ZWQyore3TOKiv50qrfUGLsuIOxI0lV+Icr1W14R0/aQHmwMOqHQ28Z2UjyZ0eU6i55B0REa6GbSQJDBLMd9/x6E4pby272yYuXw862Ce73HhjQJ2OMnMh8kAE+z0y667ZSzfS8iQjX0OXOHb24x+rtg6rq1aEo286Md0a5qder5Beoex7bFIHe4iddVXNlR8kWktEl/BwdrTLr/huSF06//kqZACocYTlolWgYkutCI/J4Tqn+OTdNEwlX8Ys8OQaZqvCTHSK+Bupa8zRqYaESvIklGQYU/rhlNT5fuI3SMzWak02Vh5R2zK13EWsYykEo6JUP1j7MIWC+u/RFMdESn1ElI/FkvwKtDf0kvQEp8sPhHX5nxCcgqeWe3uksRtVIvY+BoAjlIPpDjXYY8pQ4fBClTz5DbF66x9X43+12jCZacnR/NxFORqdvJMToTKL/0chhnZjsyAwO8DempIfyCng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: veethree.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR04MB3264.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee64e00-b912-445e-f564-08d85e417379
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 15:17:27.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e7bc8-f9e7-4624-b194-d2b4e6648868
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogHZ9i6loWBezap9Ts/DU4H5eW7vwhdC3GvUvqbRYe7hGjbYZQ0blLPoMvvHgS6vtnjUbVpMgIJaotgkX6UlafEc4wh0pKMOLUkb0xmZy6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3824
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am trying to use the ath10k_sdio driver to configure a WiFi module that u=
ses QCA9377. The environment:

OpenST Linux (STMicroelectronics) kernel 5.4 running on a STM32MP157C-EV1 b=
oard.
WiFi adapter: https://www.8devices.com/wiki/red-bean connected via SD slot.

Using the default device tree for the OpenST kernel.

I am awayre SDIO support is experimental and not supported as mentioned in
https://wireless.wiki.kernel.org/en/users/drivers/ath10k#not_supported

I patched ath10k/core.c to enable QCA9377.=20

{
=A0=A0=A0=A0=A0=A0=A0 .id =3D QCA9377_HW_1_1_DEV_VERSION,
=A0=A0=A0=A0=A0=A0=A0 .dev_id =3D QCA9377_1_0_DEVICE_ID,
=A0=A0=A0=A0=A0=A0=A0 .bus =3D ATH10K_BUS_SDIO,
=A0=A0=A0=A0=A0=A0=A0 .name =3D "qca9377 hw1.1 sdio",
=A0=A0=A0=A0=A0=A0=A0 .patch_load_addr =3D QCA9377_HW_1_0_PATCH_LOAD_ADDR,
=A0=A0=A0=A0=A0=A0=A0 .uart_pin =3D 19,
=A0=A0=A0=A0=A0=A0=A0 .otp_exe_param =3D 0,=20
=A0=A0=A0=A0=A0=A0=A0=A0.channel_counters_freq_hz =3D 88000,
=A0=A0=A0=A0=A0=A0=A0 .max_probe_resp_desc_thres =3D 0,=20
=A0=A0=A0=A0=A0=A0=A0=A0.cal_data_len =3D 8124,
=A0=A0=A0=A0=A0=A0=A0 .fw =3D {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .dir =3D QCA9377_HW_1_0_FW_DI=
R,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .board =3D QCA9377_HW_1_0_BOA=
RD_DATA_FILE,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .board_size =3D QCA9377_BOARD=
_DATA_SZ,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .board_ext_size =3D QCA9377_B=
OARD_EXT_DATA_SZ,
=A0=A0=A0=A0=A0 =A0=A0},
=A0=A0=A0=A0=A0=A0=A0 .hw_ops =3D &qca6174_ops,
=A0=A0=A0=A0=A0=A0=A0 .hw_clk =3D qca6174_clk,
=A0=A0=A0=A0=A0=A0=A0 .target_cpu_freq =3D 176000000,
=A0=A0=A0=A0=A0=A0=A0 .decap_align_bytes =3D 4,=20
=A0=A0=A0=A0=A0=A0=A0=A0.n_cipher_suites =3D 8,=20
=A0=A0=A0=A0=A0=A0=A0=A0.num_peers =3D TARGET_QCA9377_HL_NUM_PEERS,
=A0=A0=A0=A0=A0=A0=A0 .ast_skid_limit =3D 0x10,
=A0=A0=A0=A0=A0=A0=A0 .num_wds_entries =3D 0x20,
=A0=A0=A0=A0=A0=A0=A0 .uart_pin_workaround =3D true,
},

The issue I think I am having is finding the right FW. I tried several FWs =
from many places mentioned in forums but no luck so far, the dmesg output i=
s always:

[=A0=A0=A0 3.352993] mmci-pl18x 58005000.sdmmc: Got CD GPIO
[=A0=A0=A0 3.357024] mmci-pl18x 58005000.sdmmc: mmc0: PL180 manf 53 rev2 at=
 0x58005000 irq 50,0 (pio)
[=A0=A0=A0 3.394208] mmci-pl18x 58007000.sdmmc: mmc1: PL180 manf 53 rev2 at=
 0x58007000 irq 51,0 (pio)
[=A0=A0=A0 3.468057] mmc0: queuing unknown CIS tuple 0x01 (3 bytes)
[=A0=A0=A0 3.481526] mmc0: queuing unknown CIS tuple 0x1a (5 bytes)
[=A0=A0=A0 3.489913] mmc0: queuing unknown CIS tuple 0x1b (8 bytes)
[=A0=A0=A0 3.502223] mmc0: queuing unknown CIS tuple 0x14 (0 bytes)
[=A0=A0=A0 3.521976] mmc0: queuing unknown CIS tuple 0x80 (1 bytes)
[=A0=A0=A0 3.534423] mmc0: queuing unknown CIS tuple 0x81 (1 bytes)
[=A0=A0=A0 3.539934] mmc0: queuing unknown CIS tuple 0x82 (1 bytes)
[=A0=A0=A0 3.557813] mmc0: new ultra high speed SDR104 SDIO card at address=
 0001
[=A0=A0=A0 3.564424] mmc1: new DDR MMC card at address 0001
[=A0=A0=A0 3.581245] mmcblk1: mmc1:0001 004GA0 3.69 GiB=20
[=A0=A0=A0 3.594746] mmcblk1boot0: mmc1:0001 004GA0 partition 1 2.00 MiB
[=A0=A0=A0 3.600018] mmcblk1boot1: mmc1:0001 004GA0 partition 2 2.00 MiB
[=A0=A0=A0 3.623994] mmcblk1rpmb: mmc1:0001 004GA0 partition 3 512 KiB, cha=
rdev (242:0)
[=A0=A0=A0 3.658182]=A0 mmcblk1: p1 p2 p3 p4 p5
[=A0=A0=A0 6.021563] EXT4-fs (mmcblk1p4): mounted filesystem with ordered d=
ata mode. Opts: (null)
[=A0=A0=A0 8.722497] EXT4-fs (mmcblk1p2): mounted filesystem with ordered d=
ata mode. Opts: (null)
[=A0=A0=A0 8.866649] EXT4-fs (mmcblk1p4): re-mounted. Opts: (null)
[=A0=A0=A0 9.216543] EXT4-fs (mmcblk1p3): mounted filesystem with ordered d=
ata mode. Opts: (null)
[=A0=A0=A0 9.855969] EXT4-fs (mmcblk1p5): mounted filesystem with ordered d=
ata mode. Opts: (null)
[=A0=A0 14.726405] ath10k_sdio mmc0:0001:1: WARNING: ath10k SDIO support is=
 work-in-progress, problems may arise!
[=A0=A0 14.777934] ath10k_sdio mmc0:0001:1: qca9377 hw1.1 sdio target 0x050=
20001 chip_id 0x00000000 sub 0000:0000
[=A0=A0 14.804493] ath10k_sdio mmc0:0001:1: kconfig debug 1 debugfs 1 traci=
ng 1 dfs 0 testmode 0
[=A0=A0 14.858517] ath10k_sdio mmc0:0001:1: firmware ver WLAN.TF.1.0-00267-=
1 api 5 features ignore-otp crc32 79cea2c7
[=A0=A0 14.914048] ath10k_sdio mmc0:0001:1: failed to write to address 0x10=
00: -84
[=A0=A0 14.919672] ath10k_sdio mmc0:0001:1: unable to send the bmi data to =
the device: -84
[ =A0=A014.955756] ath10k_sdio mmc0:0001:1: unable to write to the device
[=A0=A0 14.960500] ath10k_sdio mmc0:0001:1: could not write otp for board i=
d check: -84
[=A0=A0 15.014268] ath10k_sdio mmc0:0001:1: failed to get board id from otp=
: -84
[=A0=A0 15.034465] mmci-pl18x 58005000.sdmmc: no tuning point found
[=A0=A0 15.038681] mmc0: tuning execution failed: -22
[=A0=A0 15.043137] ath10k_sdio mmc0:0001:1: unable to disable sdio function=
: -5
[=A0=A0 15.074172] ath10k_sdio mmc0:0001:1: could not probe fw (-84)

So my questions are:
- Can you see anthing obvious in the dmesg output? (please bear in mind I a=
m not a kernel/driver developer).
- If QCA9377 SDIO should work in any way, which firmware should I try?

I know about qcacld-2.0 driver and asked 8devices if there is a port of tha=
t for kernels 5.x, but no answers so far. If you know a qcacld repo/branch =
that works, please let me know.

Thanks for any help.

Regards,
Eduardo

