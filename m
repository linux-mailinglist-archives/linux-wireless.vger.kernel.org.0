Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7D511381
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359421AbiD0IfY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiD0IfW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 04:35:22 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE881FA48
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1651048330; x=1651653130;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=+ZZGyj+NACu3dZqgOmZAN9JGPJ24PMow644W6+kYlZ8=;
  b=eeOSDABt8IHPoDvQ6l9jvJCsfHBxsiZFJzUvtJAPBJ12C+FmnpasDNxD
   +PzY7D27lE6C/l4zWbMbJBq9S1Jsf8gGcgr2Tz3oOlp6VfRZQ0fQVG+vy
   f1i9rY9HhHiQ3DwVyUaMaBR7HifxsCDwpIjQ0eCQqkiv+nz0aM9f7dwuu
   g=;
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:32:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqMI0RWqzMuVEy0meKZ2RYeR8MOW0DbHKH5fdIIwQr/xC4i4L8iu3ZsL/g5KZrWZJDJ0/1avq6bEwHofbmyzQpu+jeoHNvwVezcgEJikVdIhVapzaznjzBpSpbgfDVekSlG4Yp5ki2GjKLXfBPNQzLGRjaNLJWfOjN3pc6RF+B/WxMslOzpk+obFxJnGYo/tla5XM5X0FkNAdDCtWforEBR1DRfYwZa8WCvBtMcftNoZrBoRVRw9YRJQC2OhHYOZW6ff9VwUt6WsK0ea7hrYauGVH6R1+GjwcvNpQV9/wkYEnXj3OCfVuGyp3v2EXL/DmHWUr1ZBLwkmRsPbROImHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZZGyj+NACu3dZqgOmZAN9JGPJ24PMow644W6+kYlZ8=;
 b=nfYCKFZr2MlPtmTEl3Iau9hoqQpgJFuY5xmPcx/B9TF5RRZZZ4pPjBH4mGNTLkbofGGgzaBMK3ng5r3tGuFqaqe50cd/YKwX0MyGZyndSnGQ11PfuBuoLcrIW/d5jyTtu6BlC5ofTAnDm8q1+qxLQ3R2DeGEpLkoz3OAxv9q6Ljb7aOCVNt1d5mdfhWAEDIXTWYawdpB4ONQj94Zh8t9EdnaSVC8HlFSCiRaQmyKM7bmp9DpTa2VN9E04fPUOczE6ypY7+9trJlOfwP8zVRb2EZbCvhmJm8fdcn1z1BHg2Nqfbiw655BqIFDY9SIo0RLKmOzpWaUvwioByuOB6yxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
Received: from BYAPR02MB4567.namprd02.prod.outlook.com (2603:10b6:a03:5f::14)
 by BYAPR02MB5334.namprd02.prod.outlook.com (2603:10b6:a03:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 08:32:05 +0000
Received: from BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::1127:7dc6:c0da:ef4f]) by BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::1127:7dc6:c0da:ef4f%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 08:32:03 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: [PULL linux-firmware] ath10k & ath11k firmware 20220423
Thread-Topic: [PULL linux-firmware] ath10k & ath11k firmware 20220423
Thread-Index: AQHYWhDRGoYFrecWGkmfQQAlqnQSiw==
Date:   Wed, 27 Apr 2022 08:32:03 +0000
Message-ID: <BYAPR02MB4567E377F14F272DFF48907A92FA9@BYAPR02MB4567.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a45af0c3-6979-d88f-b821-d9c424c1b19d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qca.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 866347d6-f3d6-4428-6478-08da28286832
x-ms-traffictypediagnostic: BYAPR02MB5334:EE_
x-microsoft-antispam-prvs: <BYAPR02MB53343AD9AF6EDEBD8D1C2F1192FA9@BYAPR02MB5334.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4cPX4Qwj3ZVXFnbuOjNisyeBb5603fV8GKA3ZcYsFzyRa7HXntFqq/f5kU2HQHPpWH9b3IO/Cjb9w5+zwa7LKl/igrn8jNsbDd/KeQXFHi9B+BVHjQLcYqOHhtyCqKy5IzB6ZKphUQkuyrXjMzri7EeP1PTVANjvwGnm8Ul4C5NxikN+s6K+z6wl7+voAW6feqIL+cp/Zka8XKQcobpLHEOZQLLWIylxug1C/LmJm9kjDfc/M/z9xU1XvfvOd9Dn+q3fI+irIbRjBuRZ3FPCL/MgRmXOaQykYDaY2yl6Kjs1365JW5+S/zZgdsnKpfnYxeFmeqJ6WxWZNth+I/Wry9Zu55vIW9w+uSbDKFzq2TRxofltnxjJyIXfSxib6gXn31rsyOSj4i2C1iNWDjTcSqm6WuoIJ+77ktGbS+2Bz7Pgfttg12vYCl5+XfJ2XTN/Z1Jqd+mgy/Km/28vF/sEd8jVrOnRB8dT+cvrSqE7oO3EZT/TOeIB6zCh6A2M/etVk34wMc1BOi0OueaJs9x4oDiAyUmDfESAffWZZYb9n9W8Q8to3lIbs9uJN06zbolLX0HvacO/SkebcFz0ibv2hyz6KSk9Zwy7LvxBj5yE507J6bKmYe2RWRNvRu011L33dgwx76DzvATJOmDk54gGvz084V+uMK2I7IdLzUqDeAvgvepudG6lnsPHzzuJvKj4rA2Z+zy8pVvG3IbT5ubsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(4326008)(66446008)(71200400001)(86362001)(8676002)(66476007)(66556008)(38100700002)(38070700005)(26005)(7696005)(6506007)(2906002)(122000001)(52536014)(83380400001)(5660300002)(64756008)(33656002)(8936002)(55016003)(508600001)(66946007)(316002)(186003)(19627235002)(76116006)(6916009)(91956017)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sZ4HA30fXCWqDJGwrxubZJqEzED0ULCsFvwKaOykbB0cTHwsTN8hxQLCyi?=
 =?iso-8859-1?Q?58rThJlsdoiYAQArXvavgNkPHaX9Ksngpyq0oHRcBg1hfe6UgMULSiZipA?=
 =?iso-8859-1?Q?8q9B8KUzwggbNcw8WuVGprh8cndXeu6yO26rLiDrDnnLnjHTjWVTEVdQO5?=
 =?iso-8859-1?Q?0QSVEzCIBcBgXW/xnhRnyM/G3rp9Q6wwQd1cZUcXMqnDzZWlWbBmu8KlAE?=
 =?iso-8859-1?Q?znLhAudMa9swdgvTW0RMSquc/2tIds3A9Em20OV632SUi/rniaiCGZm+qC?=
 =?iso-8859-1?Q?Poh8mtfKzI3IxY6/Vg5OStvqK3lF2b4O7yoebOjzSmnE3mfypHOW4eowTK?=
 =?iso-8859-1?Q?5ZTfx1fYP2JvIa9zsEhaBM1jQBXT45GT/YtYcWb0ULhcxXShgytdmBAcNj?=
 =?iso-8859-1?Q?EyAlPkgbr2iz/0DhAzSoB0c6BxfQLgEZszsz6R+5wvbKy4UKh1hsS6HHCc?=
 =?iso-8859-1?Q?b056DDObzHLgVvSA2U+1+rf8RGC/ASS84jOB82uqVOVGC5s3zwEzwU8m2X?=
 =?iso-8859-1?Q?TQ2mccRJc5Wvegg4bnIKcrO06fnndqVlsQ8SlOOb+gnpkJ3nltukXcCrzW?=
 =?iso-8859-1?Q?oaKrAuXcUqwNd0jrHapr5JjhMwGBk8dvRj9nlkw3F4Lv3Xqea7nshaMwdw?=
 =?iso-8859-1?Q?DSUlsK0Pg7ih6yK8EVgqRXS8rPeP+SxHC5BB/VMjE152MvoyxG5iUHGcr9?=
 =?iso-8859-1?Q?PAcy12+K5LSe4YyTE/8ZjNdrPEf0W+CFsE4+VwKcgoIOIBJ2HHZBcuYCVp?=
 =?iso-8859-1?Q?2HltTjMRMqpe0NYRITQRm0o9go/bu8ocFjlkHNhUArUgT4Rsynrz9dK6Ca?=
 =?iso-8859-1?Q?4ygF8znbdGuwjzoSd9LVmiT7UBFv+oEoJQEQAeKxj41mku8oVL0m7E9MV3?=
 =?iso-8859-1?Q?D/kVZcvpT7cZvTNceqfwrnIOguvdNY+7ywui6w/ED4U2AMgM6SwPv4m8Kq?=
 =?iso-8859-1?Q?mlYaaPdCLndDY67DYAJGMZy3EwWdFxu7QuLhnSqhe71nvCkiUN0hZlxQrr?=
 =?iso-8859-1?Q?dPiBs6yuoqHgeUwEsHrrAMBZwmEKF1rpHGsSFKYvZMhSIBfdjtUfHcbE7h?=
 =?iso-8859-1?Q?ZyosP8AbK4mkpB+OYf1oJAcqrqGRhKMr9xvYVzMlLBAYraeZmyXwUX60aZ?=
 =?iso-8859-1?Q?cfg3AfMjk7mI+EXmLld/NRZBqnuU8D9m4kJvcopxDjsvHD80d/MSHBg3md?=
 =?iso-8859-1?Q?mQRoaAlBe+LHMKsL1lfz+2+pRPyAtPds/wM8KkuLWTQjOoTbIZcfCtp6fr?=
 =?iso-8859-1?Q?KUsvE+WEo97HlYICJcaRirvJ08n94XG1FDnM9m1vvTFZilJZi1Yg+RFH/7?=
 =?iso-8859-1?Q?BcuMTo5mkmAgWE53LYFjugZGvDXtM8lyYwNq69LQgQumS4kvYnJC8ct3O/?=
 =?iso-8859-1?Q?oPLfgYyY37U0Azln4PyFLjRkRblyz8tdrza63Wn+cHMYR7mdoLCXwstvFI?=
 =?iso-8859-1?Q?CLf4Vd/+PJDaoPReGAlpXUxoVbWzb11cmW+VefUFvijTYv/q6ddqsi3zc9?=
 =?iso-8859-1?Q?E6lEpqCqa/fwisLmtR1d76cJ8VhZrwZVjkRMdYnc3zj88PLeKBmOI7zr2d?=
 =?iso-8859-1?Q?tWQhPF3ev9MLJxmScZLaPZgQJXGv7qveMD1wmNYvIHruuzlsD/752GYoGC?=
 =?iso-8859-1?Q?VL3Wl/0QtvZgONg5tRYrqiVaCch33p8Xi3p7GVRGt+OHZ0pMBk6oPWtki5?=
 =?iso-8859-1?Q?OpECt1cHO7mn9kQtfbYPieq5nOz6j+Kjv17fw2ibKaEJL+bnT8czdtDt4c?=
 =?iso-8859-1?Q?QAMbHshynC8FuBvsSrghsqDYY5YZtq/ox1VT4/BtAhRjQT6M+TjB1rIsZq?=
 =?iso-8859-1?Q?H4dZ1Ps8mA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qca.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4567.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866347d6-f3d6-4428-6478-08da28286832
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 08:32:03.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7d6Yxd6BDmg9C3rgy11LQ2AgBntbTnudac/Tx6S+OsyQAJWH+of+agkIT3ZhIgWcU1FEdq8BtK7f9Nl6/zuBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5334
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for QCN9074 and WCN6750 ath11k hardware families. Also=0A=
there are several updates to existing firmwares and board files for both at=
h10k=0A=
and ath11k.=0A=
=0A=
Please let me know if there are any problems.=0A=
=0A=
Kalle=0A=
=0A=
The following changes since commit e6553076626e932983b1947e1cc593421cb83aa8=
:=0A=
=0A=
  Mellanox: Add new mlxsw_spectrum firmware xx.2010.1502 (2022-04-21 06:46:=
21 -0400)=0A=
=0A=
are available in the Git repository at:=0A=
=0A=
  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git at=
h10k-20220423=0A=
=0A=
for you to fetch changes up to 4a0e59f95830817b1601631281191a5c3327d138:=0A=
=0A=
  ath11k: QCA6390 hw2.0: update to WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X=
86-1 (2022-04-27 11:23:17 +0300)=0A=
=0A=
----------------------------------------------------------------=0A=
Kalle Valo (19):=0A=
      ath11k: IPQ6018 hw1.0: update board-2.bin=0A=
      ath11k: IPQ6018 hw1.0: update to WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILI=
CONZ-1=0A=
      ath11k: IPQ8074 hw2.0: update board-2.bin=0A=
      ath11k: IPQ8074 hw2.0: update to WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILI=
CONZ-1=0A=
      ath11k: QCA6390 hw2.0: update board-2.bin=0A=
      ath11k: QCN9074 hw1.0: add board-2.bin=0A=
      ath11k: QCN9074 hw1.0: add to WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICON=
Z-1=0A=
      ath11k: WCN6750 hw1.0: add board-2.bin=0A=
      ath11k: WCN6750 hw1.0: add to WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1=0A=
      ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_=
SILICONZ_LITE-3.6510.7=0A=
      ath10k: QCA99X0 hw2.0: add board-2.bin=0A=
      ath10k: QCA4019 hw1.0: update board-2.bin=0A=
      ath10k: QCA6174 hw3.0: update firmware-6.bin to WLAN.RM.4.4.1-00288-Q=
CARMSWPZ-1=0A=
      ath10k: QCA6174 hw3.0: update board-2.bin=0A=
      ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00156=0A=
      ath10k: QCA9888 hw2.0: update board-2.bin=0A=
      ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00156=0A=
      ath10k: QCA9984 hw1.0: update board-2.bin=0A=
      ath11k: QCA6390 hw2.0: update to WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_=
TO_X86-1=0A=
=0A=
 WHENCE                              |   34 +-=0A=
 ath10k/QCA4019/hw1.0/board-2.bin    |  Bin 607304 -> 1129788 bytes=0A=
 ath10k/QCA6174/hw3.0/board-2.bin    |  Bin 715444 -> 731852 bytes=0A=
 ath10k/QCA6174/hw3.0/firmware-6.bin |  Bin 702844 -> 706004 bytes=0A=
 ath10k/QCA9888/hw2.0/board-2.bin    |  Bin 84928 -> 133540 bytes=0A=
 ath10k/QCA9888/hw2.0/firmware-5.bin |  Bin 691292 -> 693604 bytes=0A=
 ath10k/QCA9984/hw1.0/board-2.bin    |  Bin 171916 -> 220528 bytes=0A=
 ath10k/QCA9984/hw1.0/firmware-5.bin |  Bin 679288 -> 681568 bytes=0A=
 ath10k/QCA99X0/hw2.0/board-2.bin    |  Bin 0 -> 157680 bytes=0A=
 ath10k/QCA99X0/hw2.0/board.bin      |  Bin 12064 -> 0 bytes=0A=
 ath11k/IPQ6018/hw1.0/Notice.txt     | 3916 +++++++++++++++++--=0A=
 ath11k/IPQ6018/hw1.0/board-2.bin    |  Bin 787208 -> 787208 bytes=0A=
 ath11k/IPQ6018/hw1.0/m3_fw.b01      |  Bin 6712 -> 6712 bytes=0A=
 ath11k/IPQ6018/hw1.0/m3_fw.b02      |  Bin 294912 -> 294912 bytes=0A=
 ath11k/IPQ6018/hw1.0/m3_fw.mdt      |  Bin 6860 -> 6860 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b00      |  Bin 340 -> 340 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b01      |  Bin 7000 -> 7000 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b02      |  Bin 4696 -> 4696 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b03      |  Bin 2357712 -> 2557136 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b04      |  Bin 370560 -> 412064 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b05      |  Bin 175588 -> 198052 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b07      |  Bin 8936 -> 9416 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.b08      |  Bin 409914 -> 453364 bytes=0A=
 ath11k/IPQ6018/hw1.0/q6_fw.mdt      |  Bin 7340 -> 7340 bytes=0A=
 ath11k/IPQ8074/hw2.0/Notice.txt     | 3916 +++++++++++++++++--=0A=
 ath11k/IPQ8074/hw2.0/board-2.bin    |  Bin 1311380 -> 1311380 bytes=0A=
 ath11k/IPQ8074/hw2.0/m3_fw.b01      |  Bin 136 -> 136 bytes=0A=
 ath11k/IPQ8074/hw2.0/m3_fw.b02      |  Bin 327680 -> 327680 bytes=0A=
 ath11k/IPQ8074/hw2.0/m3_fw.mdt      |  Bin 284 -> 284 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b00      |  Bin 340 -> 340 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b01      |  Bin 328 -> 328 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b02      |  Bin 4696 -> 4696 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b03      |  Bin 2589264 -> 2934864 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b04      |  Bin 985504 -> 1009888 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b05      |  Bin 387076 -> 243652 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b07      |  Bin 7048 -> 9816 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.b08      |  Bin 424524 -> 486546 bytes=0A=
 ath11k/IPQ8074/hw2.0/q6_fw.mdt      |  Bin 668 -> 668 bytes=0A=
 ath11k/QCA6390/hw2.0/Notice.txt     | 4839 ++++++++++++++++-------=0A=
 ath11k/QCA6390/hw2.0/amss.bin       |  Bin 3609456 -> 3628672 bytes=0A=
 ath11k/QCA6390/hw2.0/board-2.bin    |  Bin 58016 -> 115984 bytes=0A=
 ath11k/QCA6390/hw2.0/m3.bin         |  Bin 266684 -> 266684 bytes=0A=
 ath11k/QCN9074/hw1.0/Notice.txt     | 4094 +++++++++++++++++++=0A=
 ath11k/QCN9074/hw1.0/amss.bin       |  Bin 0 -> 11905872 bytes=0A=
 ath11k/QCN9074/hw1.0/board-2.bin    |  Bin 0 -> 786836 bytes=0A=
 ath11k/QCN9074/hw1.0/m3.bin         |  Bin 0 -> 340108 bytes=0A=
 ath11k/WCN6750/hw1.0/Notice.txt     | 7380 +++++++++++++++++++++++++++++++=
++++=0A=
 ath11k/WCN6750/hw1.0/board-2.bin    |  Bin 0 -> 843548 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b00       |  Bin 0 -> 340 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b01       |  Bin 0 -> 6848 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b02       |  Bin 0 -> 10300 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b03       |  Bin 0 -> 4096 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b04       |  Bin 0 -> 5783231 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b05       |  Bin 0 -> 175236 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b06       |  Bin 0 -> 266684 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b07       |  Bin 0 -> 1176368 bytes=0A=
 ath11k/WCN6750/hw1.0/wpss.b08       |    0=0A=
 ath11k/WCN6750/hw1.0/wpss.mdt       |  Bin 0 -> 7188 bytes=0A=
 ath11k/WCN6855/hw2.0/amss.bin       |  Bin 4972544 -> 4972544 bytes=0A=
 59 files changed, 22238 insertions(+), 1941 deletions(-)=0A=
 create mode 100644 ath10k/QCA99X0/hw2.0/board-2.bin=0A=
 delete mode 100644 ath10k/QCA99X0/hw2.0/board.bin=0A=
 create mode 100644 ath11k/QCN9074/hw1.0/Notice.txt=0A=
 create mode 100644 ath11k/QCN9074/hw1.0/amss.bin=0A=
 create mode 100644 ath11k/QCN9074/hw1.0/board-2.bin=0A=
 create mode 100644 ath11k/QCN9074/hw1.0/m3.bin=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/Notice.txt=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/board-2.bin=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b00=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b01=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b02=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b03=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b04=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b05=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b06=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b07=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.b08=0A=
 create mode 100644 ath11k/WCN6750/hw1.0/wpss.mdt=0A=
