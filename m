Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88DB18E540
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2020 23:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCUWd7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Mar 2020 18:33:59 -0400
Received: from mx3.watchguard.com ([63.251.166.21]:7816 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgCUWd7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Mar 2020 18:33:59 -0400
Received: from PRDITOMBX01.wgti.net (172.24.2.21) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Sat, 21 Mar
 2020 15:32:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by owa.watchguard.com (172.24.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3
 via Frontend Transport; Sat, 21 Mar 2020 15:32:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNiFUOc+2s/2giyYLAnuHyNriLEOjVqlyWGkH7+9OOb6QiefsOfm0dUD8wHNnxxPJrgqaD7rgLhcaJSZNLhfs+ze+Fp/UOklkGms6+pXkV1uZMiwRjNo9PymsIS6wTKK1ruWzFYrxk8StaX2z/t7S9SPOIyMgiN9IiqeX4xhzdtCXTO2jceGabYI6ewGezeppdx1VzVusBrwtfJR82DkO1ju2Qt7VOf4jyiURLMWwsIZKaDntqJ0qKtA0ydUFr8KtuK6aFXd0HPPwG1FHj+foVAS79g5y/bcoJWT2ZzpKb8Ok0s0bw3iQpAdZmLnJlB+Mx3RqhyCmuu8VjCtQ42WPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIf6W23wYdeSCh8OeMG0xwFY5ooFjF9O+QcjZbaOK6g=;
 b=RtZUBXfBTVxd5pzibNSYnop356QjSWh/y3QtA8Co5Y5Tawgsczn2+1CSexTtXvcHV7hdkanXp6FAoZnICCL/PxiZQss+JkPLzpD9vSsbFECkMQhyFKHasn5Rw5a371ubMnSop94tmVHvOYtHvXPRomWVg6ZIgcoSRP1tbNcnIaY0jX1KMOsCHeJEwIMlS0xuiw77z98/iIoh21xM3B8krTsFUo01+9Vk8Ac2F/FuKRN8+0IIoA13yLsyXWFxStsQZ9bvQsMGb0H9DqVmJUKutVhwWMKwyB0H9Lco53GR5AasATND4XY3p+h25+j7a57XMuPuJM7UaDrol4Vrv2O5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIf6W23wYdeSCh8OeMG0xwFY5ooFjF9O+QcjZbaOK6g=;
 b=Y+L8dzvC1ZxGvMsp/1WPsSLXAo8S7lYlPbZS2O34+WYSG71zPW8/FrD4//83TuQhZClMU4aF2d1kI7xH1+axJDf+hXZqzgb/kIfzNb4ciyQpgeIWzoQY+55r0G1tlLVetOj7FQhbq7zoouUEeqUC8aCkoAwIOqU6oRcCSydm8cQ=
Received: from BN7PR10MB2737.namprd10.prod.outlook.com (2603:10b6:406:c5::24)
 by BN7PR10MB2657.namprd10.prod.outlook.com (2603:10b6:406:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Sat, 21 Mar
 2020 22:32:48 +0000
Received: from BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128]) by BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128%3]) with mapi id 15.20.2835.017; Sat, 21 Mar 2020
 22:32:48 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     'linux-wireless' <linux-wireless@vger.kernel.org>
Subject: Firmware Crashed
Thread-Topic: Firmware Crashed
Thread-Index: AdX/0IddQlnI5ysLTPqj/1bTShZXzQ==
Date:   Sat, 21 Mar 2020 22:32:48 +0000
Message-ID: <BN7PR10MB27377248D2272E980A9DCD339AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [66.235.15.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b821a71a-55ea-4bc6-3dbd-08d7cde7c8c6
x-ms-traffictypediagnostic: BN7PR10MB2657:
x-microsoft-antispam-prvs: <BN7PR10MB26578C86E3A85BB89DB38D7C9AF20@BN7PR10MB2657.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(7696005)(71200400001)(316002)(2906002)(86362001)(55016002)(9686003)(7116003)(30864003)(8936002)(8676002)(81156014)(81166006)(76116006)(66556008)(186003)(52536014)(5660300002)(66476007)(64756008)(478600001)(966005)(6916009)(66946007)(26005)(6506007)(3480700007)(66446008)(33656002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR10MB2657;H:BN7PR10MB2737.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEQJOo22BCf1jRG88fAkf0HLdpa7yC2sk2ZRcOr5HhKeUIGttOD+oSamEoru054rQAG6xP0bu8pAVSILp3kJDZsdOmuxur5w77ST5u8F45UimTBtxmKELb+YYKgawliiquBMgyWk5oXINAFcawm+Hl42YV7yQHg4MChGp/ROEPZv0noRdgtGAMp/A2+SCVv5aRXCau9RvicKNhG7pPPHmWttYF8pLaVuydMjj6PwCB37tKsvErWk2sEQ9Y0iaWv/zRFuijrQGB1QLbmTUUh6oFrOaqeZ3h/mRKy/IQl0jF2smNwrQ2/uu2ekbU9iEFN0F+PaY2xv9ByT5NKwWqRU0Dgl2oHJv+6G3VD9b6itL7F7XXjC/lAwQurL4BC+0BrHAYnPEsEHwnfrV9uxawcwFIb4emfiRr+QDFO8f+zQvki/9bUmHfFvhCho2tEdWxqBfJEiipWwFBGjsinHBsGG6RUDMcDf3fik7PUwTmATQ33R/Sw0cK/GOZS7Vn/a11SMMNw3NuL4nhOpeZFpBG7TjC6GyhZqgSPrBm9FGWe/Av8OyOmFZZtBrxu2mMz9E93y
x-ms-exchange-antispam-messagedata: ngOYyEFPVbsVd8YYzRzqp8xWekF7ZFSlCABrNx6/9kgtEypBrjjVJkUGaZrsQYx0J5YJNCxeAavZm6l1xb9KlEl4CDH81cXrQFHzoeQxRzVWEDqbnF6qz5inPuvKiO1uTQNUUyVQtDofqzM7OyuHsg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b821a71a-55ea-4bc6-3dbd-08d7cde7c8c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 22:32:48.3490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXEqsHZfFXWqd+hBsMeMwBSX+vSl7GdfB7j/jmT13coBGAF2Shrct+VZ5SWq+8xbzUVMBlHJo24/37v3i5ILVF5o6C0xtvIseyK4TH0tKjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2657
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello guys,

I have a QCA9986 PCIe wireless module, and I plug it to a PPC-64 device whe=
re running Linux Kernel 4.14.83 with the wireless driver backports-4.20.17-=
1. The below is PCI info for this PCI device,
XXX@YYY:/lib/firmware/ath10k/QCA9984/hw1.0# lspci -k
00:00.0 Class 0604: 1957:0840 pcieport
01:00.0 Class 0280: 168c:0046 ath10k_pci
00:00.0 Class 0604: 1957:0840 pcieport

I am using this firmware binary file(10.4-3.10-00047) and its associated bo=
ard binary file.
https://github.com/kvalo/ath10k-firmware/blob/master/QCA9984/hw1.0/3.10/fir=
mware-5.bin_10.4-3.10-00047 AND =A0https://github.com/kvalo/ath10k-firmware=
/blob/master/QCA9984/hw1.0/board-2.bin=20

But it will always report "Firmware Crashed" when I insert ath10k_pci.ko. I=
 am not sure what caused this issue. Can someone help me take a look?

The error log while I am doing insmod ath10k_pci.ko is shown as below,
[ 2336.982978] ath10k_pci 0000:01:00.0: pci probe 168c:0046 168c:cafe
[ 2336.983260] ath10k_pci 0000:01:00.0: boot pci_mem 0x8000080080980000
[ 2336.983560] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
[ 2336.983597] ath10k_pci 0000:01:00.0: boot qca99x0 chip reset
[ 2336.983601] ath10k_pci 0000:01:00.0: boot cold reset
[ 2337.041151] ath10k_pci 0000:01:00.0: boot cold reset complete
[ 2337.041158] ath10k_pci 0000:01:00.0: boot waiting target to initialise
[ 2337.041164] ath10k_pci 0000:01:00.0: boot target indicator 2
[ 2337.041171] ath10k_pci 0000:01:00.0: boot target initialised
[ 2337.041175] ath10k_pci 0000:01:00.0: boot qca99x0 chip reset complete (c=
old)
[ 2337.041247] ath10k_pci 0000:01:00.0: boot hif power up
[ 2337.041258] ath10k_pci 0000:01:00.0: boot qca99x0 chip reset
[ 2337.041261] ath10k_pci 0000:01:00.0: boot cold reset
[ 2337.097164] ath10k_pci 0000:01:00.0: boot cold reset complete
[ 2337.097172] ath10k_pci 0000:01:00.0: boot waiting target to initialise
[ 2337.097179] ath10k_pci 0000:01:00.0: boot target indicator 2
[ 2337.097187] ath10k_pci 0000:01:00.0: boot target initialised
[ 2337.097190] ath10k_pci 0000:01:00.0: boot qca99x0 chip reset complete (c=
old)
[ 2337.097212] ath10k_pci 0000:01:00.0: boot init ce src ring id 0 entries =
16 base_addr c000000051919000
[ 2337.097229] ath10k_pci 0000:01:00.0: boot ce dest ring id 1 entries 512 =
base_addr c000000051760000
[ 2337.097244] ath10k_pci 0000:01:00.0: boot ce dest ring id 2 entries 128 =
base_addr c00000006795a000
[ 2337.097261] ath10k_pci 0000:01:00.0: boot init ce src ring id 3 entries =
32 base_addr c000000051e64000
[ 2337.097318] ath10k_pci 0000:01:00.0: boot init ce src ring id 4 entries =
8192 base_addr c000000075f00000
[ 2337.097335] ath10k_pci 0000:01:00.0: boot ce dest ring id 5 entries 512 =
base_addr c000000077246000
[ 2337.097352] ath10k_pci 0000:01:00.0: boot init ce src ring id 7 entries =
2 base_addr c000000075e80000
[ 2337.097366] ath10k_pci 0000:01:00.0: boot ce dest ring id 7 entries 2 ba=
se_addr c000000051a4c000
[ 2337.097382] ath10k_pci 0000:01:00.0: boot ce dest ring id 8 entries 128 =
base_addr c000000075e85000
[ 2337.098026] ath10k_pci 0000:01:00.0: bmi get target info
[ 2337.098171] ath10k_pci 0000:01:00.0: Hardware name qca9984/qca9994 hw1.0=
 version 0x1000000
[ 2337.098175] ath10k_pci 0000:01:00.0: trying fw api 6
[ 2337.098216] ath10k_pci 0000:01:00.0: Direct firmware load for ath10k/QCA=
9984/hw1.0/firmware-6.bin failed with error -2
[ 2337.098224] ath10k_pci 0000:01:00.0: boot fw request 'ath10k/QCA9984/hw1=
.0/firmware-6.bin': -2
[ 2337.098227] ath10k_pci 0000:01:00.0: trying fw api 5
[ 2337.100926] ath10k_pci 0000:01:00.0: boot fw request 'ath10k/QCA9984/hw1=
.0/firmware-5.bin': 0
[ 2337.100936] ath10k_pci 0000:01:00.0: found fw version 10.4-3.10-00047
[ 2337.100941] ath10k_pci 0000:01:00.0: found fw timestamp 1557172134
[ 2337.100946] ath10k_pci 0000:01:00.0: found otp image ie (9235 B)
[ 2337.100949] ath10k_pci 0000:01:00.0: found fw image ie (396915 B)
[ 2337.100953] ath10k_pci 0000:01:00.0: found firmware features ie (3 B)
[ 2337.100956] ath10k_pci 0000:01:00.0: Enabling feature bit: 3
[ 2337.100960] ath10k_pci 0000:01:00.0: Enabling feature bit: 12
[ 2337.100963] ath10k_pci 0000:01:00.0: Enabling feature bit: 13
[ 2337.100967] ath10k_pci 0000:01:00.0: Enabling feature bit: 14
[ 2337.100970] ath10k_pci 0000:01:00.0: Enabling feature bit: 16
[ 2337.100973] ath10k_pci 0000:01:00.0: Enabling feature bit: 17
[ 2337.100978] ath10k_pci 0000:01:00.0: features
[ 2337.100984] ath10k_pci 0000:01:00.0: 00000000: 00 00 00 00 00 03 70 08=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ......p.
[ 2337.100988] ath10k_pci 0000:01:00.0: found fw ie wmi op version 6
[ 2337.100991] ath10k_pci 0000:01:00.0: found fw ie htt op version 4
[ 2337.100995] ath10k_pci 0000:01:00.0: found fw code swap image ie (270212=
 B)
[ 2337.100999] ath10k_pci 0000:01:00.0: using fw api 5
[ 2337.101010] ath10k_pci 0000:01:00.0: qca9984/qca9994 hw1.0 target 0x0100=
0000 chip_id 0x00000000 sub 168c:cafe
[ 2337.101014] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 1 tracing 0=
 dfs 0 testmode 0
[ 2337.103917] ath10k_pci 0000:01:00.0: firmware ver 10.4-3.10-00047 api 5 =
features no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast,no-ps crc=
32 19ca6df2
[ 2337.103926] ath10k_pci 0000:01:00.0: boot did not find a pre calibration=
 file, try DT next: -2
[ 2337.103930] ath10k_pci 0000:01:00.0: unable to load pre cal data from DT=
: -2
[ 2337.103934] ath10k_pci 0000:01:00.0: could not load pre cal data: -2
[ 2337.103938] ath10k_pci 0000:01:00.0: boot upload otp to 0x1234 len 9235 =
for board id
[ 2337.103943] ath10k_pci 0000:01:00.0: bmi fast download address 0x1234 bu=
ffer 0x800000001012c038 length 9235
[ 2337.103947] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x1234
[ 2337.104188] ath10k_pci 0000:01:00.0: bmi lz data buffer 0x800000001012c0=
38 length 9232
[ 2337.133722] ath10k_pci 0000:01:00.0: bmi lz data buffer 0xc0000000750f7a=
50 length 4
[ 2337.133909] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x0
[ 2337.133956] ath10k_pci 0000:01:00.0: bmi execute address 0x1234 param 0x=
10
[ 2338.333138] ath10k_pci 0000:01:00.0: bmi cmd took 299 jiffies hz 250 ret=
 0
[ 2338.333155] ath10k_pci 0000:01:00.0: bmi execute result 0x42c00
[ 2338.333161] ath10k_pci 0000:01:00.0: boot get otp board id result 0x0004=
2c00 board_id 11 chip_id 0 ext_bid_support 1
[ 2338.333165] ath10k_pci 0000:01:00.0: SMBIOS bdf variant name not set.
[ 2338.333168] ath10k_pci 0000:01:00.0: DT bdf variant name not set.
[ 2338.333174] ath10k_pci 0000:01:00.0: boot using board name 'bus=3Dpci,bm=
i-chip-id=3D0,bmi-board-id=3D11'
[ 2338.333179] ath10k_pci 0000:01:00.0: boot using board name 'bus=3Dpci,bm=
i-chip-id=3D0,bmi-board-id=3D11'
[ 2338.333189] ath10k_pci 0000:01:00.0: boot fw request 'ath10k/QCA9984/hw1=
.0/board.bin': 0
[ 2338.333192] ath10k_pci 0000:01:00.0: using board api 1
[ 2338.333947] ath10k_pci 0000:01:00.0: board_file api 1 bmi_id 0:11 crc32 =
85498734
[ 2338.334766] ath10k_pci 0000:01:00.0: bmi start
[ 2338.334773] ath10k_pci 0000:01:00.0: bmi write address 0x400800 length 4
[ 2338.334807] ath10k_pci 0000:01:00.0: bmi read address 0x400810 length 4
[ 2338.334888] ath10k_pci 0000:01:00.0: bmi write address 0x400810 length 4
[ 2338.334901] ath10k_pci 0000:01:00.0: bmi write address 0x400844 length 4
[ 2338.334965] ath10k_pci 0000:01:00.0: bmi write address 0x400904 length 4
[ 2338.335011] ath10k_pci 0000:01:00.0: bmi write address 0x4008bc length 4
[ 2338.335058] ath10k_pci 0000:01:00.0: boot did not find a pre calibration=
 file, try DT next: -2
[ 2338.335062] ath10k_pci 0000:01:00.0: unable to load pre cal data from DT=
: -2
[ 2338.335065] ath10k_pci 0000:01:00.0: failed to load pre cal data: -2
[ 2338.335069] ath10k_pci 0000:01:00.0: pre cal download procedure failed, =
try cal file: -2
[ 2338.335073] ath10k_pci 0000:01:00.0: boot did not find a calibration fil=
e, try DT next: -2
[ 2338.335077] ath10k_pci 0000:01:00.0: boot did not find DT entry, try tar=
get EEPROM next: -2
[ 2338.335082] ath10k_pci 0000:01:00.0: boot did not find target EEPROM ent=
ry, try OTP next: -95
[ 2338.335086] ath10k_pci 0000:01:00.0: bmi read address 0x4008ac length 4
[ 2338.335145] ath10k_pci 0000:01:00.0: boot push board extended data addr =
0x0
[ 2338.335150] ath10k_pci 0000:01:00.0: bmi read address 0x400854 length 4
[ 2338.335221] ath10k_pci 0000:01:00.0: bmi write address 0xc0000 length 12=
288
[ 2338.361178] ath10k_pci 0000:01:00.0: bmi write address 0x400858 length 4
[ 2338.361348] ath10k_pci 0000:01:00.0: boot upload otp to 0x1234 len 9235 =
for ext board id
[ 2338.361353] ath10k_pci 0000:01:00.0: bmi fast download address 0x1234 bu=
ffer 0x800000001012c038 length 9235
[ 2338.361357] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x1234
[ 2338.361392] ath10k_pci 0000:01:00.0: bmi lz data buffer 0x800000001012c0=
38 length 9232
[ 2338.390933] ath10k_pci 0000:01:00.0: bmi lz data buffer 0xc0000000750f78=
d0 length 4
[ 2338.391113] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x0
[ 2338.391160] ath10k_pci 0000:01:00.0: bmi execute address 0x1234 param 0x=
40000
[ 2338.392373] ath10k_pci 0000:01:00.0: bmi execute result 0x0
[ 2338.392377] ath10k_pci 0000:01:00.0: ext board id does not exist in otp,=
 ignore it
[ 2338.392380] ath10k_pci 0000:01:00.0: otp returned ext board id 0
[ 2338.392385] ath10k_pci 0000:01:00.0: boot upload otp to 0x1234 len 9235
[ 2338.392390] ath10k_pci 0000:01:00.0: bmi fast download address 0x1234 bu=
ffer 0x800000001012c038 length 9235
[ 2338.392393] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x1234
[ 2338.392406] ath10k_pci 0000:01:00.0: bmi lz data buffer 0x800000001012c0=
38 length 9232
[ 2338.423316] ath10k_pci 0000:01:00.0: bmi lz data buffer 0xc0000000750f79=
90 length 4
[ 2338.423499] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x0
[ 2338.423547] ath10k_pci 0000:01:00.0: bmi execute address 0x1234 param 0x=
700
[ 2339.631535] ath10k_pci 0000:01:00.0: bmi cmd took 302 jiffies hz 250 ret=
 0
[ 2339.631546] ath10k_pci 0000:01:00.0: bmi execute result 0x0
[ 2339.631550] ath10k_pci 0000:01:00.0: boot otp execute result 0
[ 2339.631555] ath10k_pci 0000:01:00.0: boot using calibration mode otp
[ 2339.631559] ath10k_pci 0000:01:00.0: boot found firmware code swap binar=
y
[ 2339.631563] ath10k_pci 0000:01:00.0: bmi write address 0x4222f0 length 2=
08
[ 2339.631587] ath10k_pci 0000:01:00.0: boot uploading firmware image 80000=
0001012e454 len 396915
[ 2339.631592] ath10k_pci 0000:01:00.0: bmi fast download address 0x1234 bu=
ffer 0x800000001012e454 length 396915
[ 2339.631596] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x1234
[ 2339.631934] ath10k_pci 0000:01:00.0: bmi lz data buffer 0x800000001012e4=
54 length 396912
[ 2340.889804] ath10k_pci 0000:01:00.0: bmi lz data buffer 0xc0000000750f7a=
30 length 4
[ 2340.890104] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x0
[ 2340.890153] ath10k_pci 0000:01:00.0: bmi write address 0x400814 length 4
[ 2340.890193] ath10k_pci 0000:01:00.0: pci hif map service
[ 2340.890199] ath10k_pci 0000:01:00.0: boot htc service 'Control' ul pipe =
0 dl pipe 1 eid 0 ready
[ 2340.890203] ath10k_pci 0000:01:00.0: boot htc service 'Control' eid 0 TX=
 flow control disabled
[ 2340.890207] ath10k_pci 0000:01:00.0: bmi done
[ 2340.890240] ath10k_pci 0000:01:00.0: htt tx max num pending tx 2500
[ 2340.890444] ath10k_pci 0000:01:00.0: htt rx ring size 2048 fill_level 10=
23
[ 2340.890449] ath10k_pci 0000:01:00.0: boot hif start
[ 2340.899082] ath10k_pci 0000:01:00.0: firmware crashed! (guid n/a)
[ 2340.899099] ath10k_pci 0000:01:00.0: qca9984/qca9994 hw1.0 target 0x0100=
0000 chip_id 0x00000000 sub 168c:cafe
[ 2340.899105] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 1 tracing 0=
 dfs 0 testmode 0
[ 2340.902074] ath10k_pci 0000:01:00.0: firmware ver 10.4-3.10-00047 api 5 =
features no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast,no-ps crc=
32 19ca6df2
[ 2340.902803] ath10k_pci 0000:01:00.0: board_file api 1 bmi_id 0:11 crc32 =
85498734
[ 2340.902810] ath10k_pci 0000:01:00.0: htt-ver 0.0 wmi-op 6 htt-op 4 cal o=
tp max-sta 32 raw 0 hwcrypto 1
[ 2340.902938] ath10k_pci 0000:01:00.0: firmware register dump:
[ 2340.902944] ath10k_pci 0000:01:00.0: [00]: 0x01000000 0x000015B3 0x000CF=
FCA 0x00975B31
[ 2340.902948] ath10k_pci 0000:01:00.0: [04]: 0x000CFFCA 0x00060F30 0x00000=
011 0x00420D24
[ 2340.902953] ath10k_pci 0000:01:00.0: [08]: 0x000C0000 0x0040680C 0x00406=
814 0x00400000
[ 2340.902957] ath10k_pci 0000:01:00.0: [12]: 0x00000009 0x00000000 0x000CF=
EE4 0x000CFEEF
[ 2340.902962] ath10k_pci 0000:01:00.0: [16]: 0x000CFFCA 0x000CFEE4 0x00000=
000 0x00000000
[ 2340.902966] ath10k_pci 0000:01:00.0: [20]: 0x400CFFCA 0x0040678C 0x00975=
A00 0x00000000
[ 2340.902971] ath10k_pci 0000:01:00.0: [24]: 0x809CCB9B 0x004067EC 0x00000=
001 0xC00CFFCA
[ 2340.902976] ath10k_pci 0000:01:00.0: [28]: 0x809BFCB3 0x0040680C 0x000C0=
000 0x00406950
[ 2340.902980] ath10k_pci 0000:01:00.0: [32]: 0x809BFCE0 0x0040684C 0x000C0=
000 0x00406950
[ 2340.902985] ath10k_pci 0000:01:00.0: [36]: 0x809CCE75 0x0040687C 0x000C0=
000 0x00406950
[ 2340.902989] ath10k_pci 0000:01:00.0: [40]: 0x809866C9 0x0040689C 0x00406=
94C 0x0040690C
[ 2340.902994] ath10k_pci 0000:01:00.0: [44]: 0x809CD060 0x0040690C 0x00406=
94C 0x004144FC
[ 2340.902999] ath10k_pci 0000:01:00.0: [48]: 0x8098159B 0x0040693C 0x00416=
DF0 0x00400000
[ 2340.903003] ath10k_pci 0000:01:00.0: [52]: 0x800DFF26 0x004069AC 0x00000=
004 0x00413FF0
[ 2340.903008] ath10k_pci 0000:01:00.0: [56]: 0x800C383A 0x004069DC 0x00413=
E10 0x00400000
[ 2340.903012] ath10k_pci 0000:01:00.0: Copy Engine register dump:
[ 2340.903021] ath10k_pci 0000:01:00.0: [00]: 0x0004a000=A0=A0 2=A0=A0 2=A0=
=A0 3=A0=A0 2
[ 2340.903029] ath10k_pci 0000:01:00.0: [01]: 0x0004a400=A0=A0 7=A0=A0 7=A0=
=A0 6=A0=A0 7
[ 2340.903038] ath10k_pci 0000:01:00.0: [02]: 0x0004a800=A0=A0 0=A0=A0 0 12=
7=A0=A0 0
[ 2340.903046] ath10k_pci 0000:01:00.0: [03]: 0x0004ac00=A0=A0 0=A0=A0 0=A0=
=A0 0=A0=A0 0
[ 2340.903054] ath10k_pci 0000:01:00.0: [04]: 0x0004b000=A0=A0 0=A0=A0 0=A0=
=A0 0=A0=A0 0
[ 2340.903062] ath10k_pci 0000:01:00.0: [05]: 0x0004b400=A0=A0 0=A0=A0 0=A0=
=A0 0=A0=A0 0
[ 2340.903070] ath10k_pci 0000:01:00.0: [06]: 0x0004b800=A0=A0 0=A0=A0 0=A0=
=A0 0=A0=A0 0
[ 2340.903078] ath10k_pci 0000:01:00.0: [07]: 0x0004bc00=A0=A0 1=A0=A0 1=A0=
=A0 1=A0=A0 1
[ 2340.903087] ath10k_pci 0000:01:00.0: [08]: 0x0004c000=A0=A0 0=A0=A0 0 12=
7=A0=A0 0
[ 2340.903095] ath10k_pci 0000:01:00.0: [09]: 0x0004c400=A0=A0 1=A0=A0 1=A0=
=A0 1=A0=A0 1
[ 2340.903103] ath10k_pci 0000:01:00.0: [10]: 0x0004c800=A0=A0 0=A0=A0 0=A0=
=A0 0=A0=A0 0
[ 2340.903111] ath10k_pci 0000:01:00.0: [11]: 0x0004cc00=A0=A0 0=A0=A0 0=A0=
=A0 0=A0=A0 0
[ 2341.893166] ath10k_pci 0000:01:00.0: failed to receive control response =
completion, polling..
[ 2341.893176] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893186] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893203] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893209] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893214] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893218] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893227] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893230] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893234] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893240] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893243] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2341.893247] ath10k_pci 0000:01:00.0: pci hif send complete check
[ 2342.917164] ath10k_pci 0000:01:00.0: ctl_resp never came in (-110)
[ 2342.917172] ath10k_pci 0000:01:00.0: failed to connect to HTC: -110
[ 2342.917177] ath10k_pci 0000:01:00.0: boot hif stop
[ 2342.917222] ath10k_pci 0000:01:00.0: boot qca99x0 chip reset
[ 2342.917226] ath10k_pci 0000:01:00.0: boot cold reset
[ 2342.973153] ath10k_pci 0000:01:00.0: boot cold reset complete
[ 2342.973160] ath10k_pci 0000:01:00.0: boot waiting target to initialise
[ 2342.973167] ath10k_pci 0000:01:00.0: boot target indicator 2
[ 2342.973174] ath10k_pci 0000:01:00.0: boot target initialised
[ 2342.973177] ath10k_pci 0000:01:00.0: boot qca99x0 chip reset complete (c=
old)
[ 2342.975699] ath10k_pci 0000:01:00.0: could not init core (-110)
[ 2342.975829] ath10k_pci 0000:01:00.0: boot hif power down
[ 2342.975833] ath10k_pci 0000:01:00.0: could not probe fw (-110)
[ 2342.989170] ath10k_pci 0000:01:00.0: cannot restart a device that hasn't=
 been started


Thanks,
Ming Chen



