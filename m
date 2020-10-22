Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753CC295A56
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507711AbgJVI3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 04:29:18 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:64539 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2444393AbgJVI3S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 04:29:18 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2020 04:29:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1603355357; x=1634891357;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bMA3uVKH9bdhkBRZd2euuMcVB6CC+wFTfjNKsINGPsA=;
  b=lUuALLd7cntAQiLN1kczY0isWgOEJEXPfHY3ZyJHkbgsOBuA55cXrhXy
   lM1pCmRVe4OmW7Y9dt+DNtb1gYtdOZUxG7dqTt/uXh5JuHry9xrrGNOJN
   CRdesYiv9FJAY421wioM/JVJ+LD88bS+XE5UUpim3bvKwz4/f+L7e2LoC
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Oct 2020 01:23:14 -0700
X-QCInternal: smtphost
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Oct 2020 01:23:11 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 01:23:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 22 Oct 2020 01:23:02 -0700
Received: from BYAPR02MB4567.namprd02.prod.outlook.com (2603:10b6:a03:5f::14)
 by BY5PR02MB7041.namprd02.prod.outlook.com (2603:10b6:a03:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 08:23:01 +0000
Received: from BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::e85b:1ca9:6539:4b48]) by BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::e85b:1ca9:6539:4b48%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 08:23:01 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: [PULL] ath10k & ath11k firmware 20201022
Thread-Topic: [PULL] ath10k & ath11k firmware 20201022
Thread-Index: AQHWqEtZwlMQKO5WkE6UyM+YmDsh3A==
Date:   Thu, 22 Oct 2020 08:23:01 +0000
Message-ID: <BYAPR02MB4567892AD5957F360C01E73F921D0@BYAPR02MB4567.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=qca.qualcomm.com;
x-originating-ip: [88.114.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd37acb9-9f89-4b58-5ed1-08d87663b0c0
x-ms-traffictypediagnostic: BY5PR02MB7041:
x-microsoft-antispam-prvs: <BY5PR02MB704127861DB0560AC4854EAA921D0@BY5PR02MB7041.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ZbV4zxXqi4vbw2dfosXY3ij675OIpNjS3yD0mGK6AV3U7lp/wUAfzcu7V8JWoy+F29DQiiBn39xgL7JcPDT/20GRgJXMYgJT99Vymf3wq2qF3W6Sp5JwrbcPWY+1VQ5VnZflCOb7fvEI7MHs0rGFEza9hNzcWAghz1QLI3h+gBylTT0Y0J8Oxy5CR3zVhsLes62Zqgd3cz7Ug5jOGv7CJ6bpbisMg24QUhH5eMR4jHn+H9aPxpmyCQYw2YnNF3i61RoNKrqwDyuSi5usVmzkX7T0kBzOHO+O/r1PAcPZIi87gxQbIHMKOjH8XNNNLjiROiuCw6QuqMg7bDeCtkE/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(4326008)(66476007)(71200400001)(66556008)(316002)(5660300002)(6916009)(91956017)(52536014)(76116006)(66946007)(66446008)(64756008)(54906003)(7696005)(2906002)(4001150100001)(9686003)(6506007)(19627235002)(83380400001)(8676002)(186003)(26005)(8936002)(55016002)(33656002)(478600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Njmzz7VadKezHxnhlzAYi86x3/W+kJkUbb/P7Smc/M4e8DIbjCdiHKSfiInVlnhsHPcdbLEBT3C9hwFMYDM0N+rx55BaCYRdJEsLOkAZ5vffBYnbOifnbNRH0WvRo5QC2A/m2iK0ljMxTtgH5mKDMwabdlO8Q1ufo/TOwNJHME9osDu/DUu4hc/4y2esIKJj58W9R+ddHFGAKtlIDR/lVzRsk4b33CORdnJrwkqvXxsNPHtoAe9b4yNeYhlprzg7UbspuuSTSSteRrGRsX5MFL8MbPTQlBIOqCIQKXcVU/h3wMqOaQ1XTAf1zuj6SZJ+f7cC4gUv9LiReQ9HL7d7l4UPt3rrEluhN4TahPMX6orZXj0pO2YwoSsQSmiEJWxuZ6usJbJHKib0mh7FTkjNqJS0MlZSr+t+BhLcxHBWnS/FG6ROJ1P7vB6pn+uOqX/uoDc6Ck0/CTnE7zVB+O5Azdtl3EgUCXqFthPvDFdUmD8YJunvln3oJiWEuId791jKnYFmbvVTA8zFm7+uEwNDcnsM4G6T6LoJypXu0Hycgb1zazUXv0C+XFNg2FlVj5Ez+Vdy3A0fR4++8TkVryTSQ43HpmF6YOlEzuWj1hBPvQx9G5MTbSWt21/0Y9P7VSBH+8WXK4p9cVi+6oo54Muetg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKNB8HYToKPN1tqucg69S0chNwOoq1V5HkgbCJIUSisA96JAZEG888frfeWIIOad3E29GN8FMhM4BcExTCUSPLRvatN6Hl1xKUA93ttURlVVtSAWuyUbV4cZMhUFxclruTwGAPIZz/byjXYxp+SQ6VQZwEuTBYW6EM9UygM60hHQXyH6COwUxSk0sm67IiPL4nynPyi7qCXuTxIwag7qFnASic+XzbsYRSHsn9h8PrrLt8DCdKA2DIEaj26n+TECowzWkxZRvVUUdcMQAD+CCJBLSfPlfdKlHmlOEmhDH3JQnI9S1VAhEWOVjz3NqoUTyjLDgTPE3F+FiPv1D+l9YQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IVY0bTp8qTNecByNDRJhkGl0UBs/fpSS6sR+JGQxq8=;
 b=Lt8kOivBchxizeNLi0sAqgBmjDI3I4HfTiOybzN/yxM29Y5n2GXipMBjnJWKFcCdRJwPZBoZijrwZFmsrVnuIIH4x6X0b4gGr6kskBLBIt0868Ab940Vcs7AEpg7OS0Dl7PzN//idCnXmY2hFY4wQEck70NTmRZN0CBZUuxzsnpRtd5bhf+KadmcyP7j3hh9nDFQHNWPId+1K/AD3W2jNl33RTSqvs9T70TBFHJ9Et1XQZOFZspejUvexomMoVmy1jfxdVIq2F9UYDa0ZbtnxCnikOjTXBxRx90at+MbL1Qzzh502TBMM8xTDjpyVXpw0zbA+/qGRWFrxvor1ZwXUw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IVY0bTp8qTNecByNDRJhkGl0UBs/fpSS6sR+JGQxq8=;
 b=UEKG+63eTKiLM5FpSk0oMeBvlYSr1i4z+OI0dzjo/UiqEhx5BB1SEgrxvThXV/3/00tdGR2BOYqmxByxQEHAnDLR3Ec99efjDeQWx7EplovmAo8qE6VCxRDuJPIy2tgeuj08UkyEyZDjBMr3kzyF9J+Z4i20Dw1PcDcFhV6BJIU=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4567.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: cd37acb9-9f89-4b58-5ed1-08d87663b0c0
x-ms-exchange-crosstenant-originalarrivaltime: 22 Oct 2020 08:23:01.1162 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: rmZMLHBIGAnKvDs6QZxxH9DfrcWXuYhpe66ie404nCCYEqXkk/1cl3NNzdKOWRAFHw0iQHsJJ/RS5u5mOsefeQ==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB7041
x-originatororg: qca.qualcomm.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi linux-firmware maintainers,

here's a pull request for ath10k and ath11k drivers. For ath10k there is a =
firmware for new hardware QCA6174 hw3.0 SDIO. For ath11k there are firmware=
s for new hardware IPQ8074 hw2.0, IPQ6018 hw1.0 and QCA6390 hw2.0. And also=
 few updates for existing hardware.

I did not include QCA9377 SDIO firmware as I saw Christian submitted a patc=
h adding that.

Please let me know if there are any problems.

Kalle

The following changes since commit 58d41d0facca2478d3e45f6321224361519aee96=
:

  ice: Add comms package file for Intel E800 series driver (2020-10-05 08:0=
9:03 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git at=
h10k-20201022

for you to fetch changes up to 60cb7a28a5dce0b7da88498ee752d30b692090ba:

  ath11k: QCA6390 hw2.0: add to WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-=
1 (2020-10-22 11:06:49 +0300)

----------------------------------------------------------------
Kalle Valo (11):
      ath10k: QCA6174 hw3.0: update firmware-6.bin to WLAN.RM.4.4.1-00157-Q=
CARMSWPZ-1
      ath10k: QCA6174 hw3.0: update board-2.bin
      ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00131
      ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00131
      ath10k: QCA6174 hw3.0: add firmware-sdio-6.bin version WLAN.RMH.4.4.1=
-00077
      ath11k: IPQ6018 hw1.0: add board-2.bin
      ath11k: IPQ6018 hw1.0: add to WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICON=
Z-2
      ath11k: IPQ8074 hw2.0: add board-2.bin
      ath11k: IPQ8074 hw2.0: add to WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICON=
Z-2
      ath11k: QCA6390 hw2.0: add board-2.bin
      ath11k: QCA6390 hw2.0: add to WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_=
X86-1

 WHENCE                                             |   57 +-
 ath10k/QCA6174/hw3.0/board-2.bin                   |  Bin 584036 -> 633360=
 bytes
 ath10k/QCA6174/hw3.0/firmware-6.bin                |  Bin 700988 -> 702844=
 bytes
 ath10k/QCA6174/hw3.0/firmware-sdio-6.bin           |  Bin 0 -> 604416 byte=
s
 .../hw3.0/notice_ath10k_firmware-sdio-6.txt        | 1352 ++++++++++++++
 ath10k/QCA9888/hw2.0/firmware-5.bin                |  Bin 688140 -> 691292=
 bytes
 ath10k/QCA9984/hw1.0/firmware-5.bin                |  Bin 675948 -> 679288=
 bytes
 ath11k/IPQ6018/hw1.0/Notice.txt                    |  786 ++++++++
 ath11k/IPQ6018/hw1.0/board-2.bin                   |  Bin 0 -> 787208 byte=
s
 ath11k/IPQ6018/hw1.0/m3_fw.b00                     |  Bin 0 -> 148 bytes
 ath11k/IPQ6018/hw1.0/m3_fw.b01                     |  Bin 0 -> 6712 bytes
 ath11k/IPQ6018/hw1.0/m3_fw.b02                     |  Bin 0 -> 294912 byte=
s
 ath11k/IPQ6018/hw1.0/m3_fw.flist                   |    3 +
 ath11k/IPQ6018/hw1.0/m3_fw.mdt                     |  Bin 0 -> 6860 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b00                     |  Bin 0 -> 340 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b01                     |  Bin 0 -> 7000 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b02                     |  Bin 0 -> 4696 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b03                     |  Bin 0 -> 2357712 byt=
es
 ath11k/IPQ6018/hw1.0/q6_fw.b04                     |  Bin 0 -> 370560 byte=
s
 ath11k/IPQ6018/hw1.0/q6_fw.b05                     |  Bin 0 -> 175588 byte=
s
 ath11k/IPQ6018/hw1.0/q6_fw.b07                     |  Bin 0 -> 8936 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b08                     |  Bin 0 -> 409914 byte=
s
 ath11k/IPQ6018/hw1.0/q6_fw.flist                   |    8 +
 ath11k/IPQ6018/hw1.0/q6_fw.mdt                     |  Bin 0 -> 7340 bytes
 ath11k/IPQ8074/hw2.0/Notice.txt                    |  786 ++++++++
 ath11k/IPQ8074/hw2.0/board-2.bin                   |  Bin 0 -> 1311380 byt=
es
 ath11k/IPQ8074/hw2.0/m3_fw.b00                     |  Bin 0 -> 148 bytes
 ath11k/IPQ8074/hw2.0/m3_fw.b01                     |  Bin 0 -> 136 bytes
 ath11k/IPQ8074/hw2.0/m3_fw.b02                     |  Bin 0 -> 327680 byte=
s
 ath11k/IPQ8074/hw2.0/m3_fw.flist                   |    3 +
 ath11k/IPQ8074/hw2.0/m3_fw.mdt                     |  Bin 0 -> 284 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b00                     |  Bin 0 -> 340 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b01                     |  Bin 0 -> 328 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b02                     |  Bin 0 -> 4696 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b03                     |  Bin 0 -> 2589264 byt=
es
 ath11k/IPQ8074/hw2.0/q6_fw.b04                     |  Bin 0 -> 985504 byte=
s
 ath11k/IPQ8074/hw2.0/q6_fw.b05                     |  Bin 0 -> 387076 byte=
s
 ath11k/IPQ8074/hw2.0/q6_fw.b07                     |  Bin 0 -> 7048 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b08                     |  Bin 0 -> 424524 byte=
s
 ath11k/IPQ8074/hw2.0/q6_fw.flist                   |    8 +
 ath11k/IPQ8074/hw2.0/q6_fw.mdt                     |  Bin 0 -> 668 bytes
 ath11k/QCA6390/hw2.0/Notice.txt                    | 1971 ++++++++++++++++=
++++
 ath11k/QCA6390/hw2.0/amss.bin                      |  Bin 0 -> 3609456 byt=
es
 ath11k/QCA6390/hw2.0/board-2.bin                   |  Bin 0 -> 58016 bytes
 ath11k/QCA6390/hw2.0/m3.bin                        |  Bin 0 -> 266684 byte=
s
 45 files changed, 4971 insertions(+), 3 deletions(-)
 create mode 100644 ath10k/QCA6174/hw3.0/firmware-sdio-6.bin
 create mode 100644 ath10k/QCA6174/hw3.0/notice_ath10k_firmware-sdio-6.txt
 create mode 100644 ath11k/IPQ6018/hw1.0/Notice.txt
 create mode 100644 ath11k/IPQ6018/hw1.0/board-2.bin
 create mode 100644 ath11k/IPQ6018/hw1.0/m3_fw.b00
 create mode 100644 ath11k/IPQ6018/hw1.0/m3_fw.b01
 create mode 100644 ath11k/IPQ6018/hw1.0/m3_fw.b02
 create mode 100644 ath11k/IPQ6018/hw1.0/m3_fw.flist
 create mode 100644 ath11k/IPQ6018/hw1.0/m3_fw.mdt
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b00
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b01
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b02
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b03
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b04
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b05
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b07
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.b08
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.flist
 create mode 100644 ath11k/IPQ6018/hw1.0/q6_fw.mdt
 create mode 100644 ath11k/IPQ8074/hw2.0/Notice.txt
 create mode 100644 ath11k/IPQ8074/hw2.0/board-2.bin
 create mode 100644 ath11k/IPQ8074/hw2.0/m3_fw.b00
 create mode 100644 ath11k/IPQ8074/hw2.0/m3_fw.b01
 create mode 100644 ath11k/IPQ8074/hw2.0/m3_fw.b02
 create mode 100644 ath11k/IPQ8074/hw2.0/m3_fw.flist
 create mode 100644 ath11k/IPQ8074/hw2.0/m3_fw.mdt
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b00
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b01
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b02
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b03
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b04
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b05
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b07
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.b08
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.flist
 create mode 100644 ath11k/IPQ8074/hw2.0/q6_fw.mdt
 create mode 100644 ath11k/QCA6390/hw2.0/Notice.txt
 create mode 100644 ath11k/QCA6390/hw2.0/amss.bin
 create mode 100644 ath11k/QCA6390/hw2.0/board-2.bin
 create mode 100644 ath11k/QCA6390/hw2.0/m3.bin
