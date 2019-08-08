Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A22185F25
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbfHHKBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 06:01:17 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:13186 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728289AbfHHKBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 06:01:17 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Aug 2019 06:01:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1565258476; x=1596794476;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=BCR3OkIXgkhuXzRLaemvluo6ItVsDTmHFxsA58PXGr0=;
  b=kyRIg0n13jNCkKtct6gUSDA+rd4nIKhDv/Rfvl5agizC04U9xW7ETkyh
   UOhaNDDNuX+lKW6yNME+mejLAlkywJaMViDe6IkBRhyNM8Gd2Z5p8yo+9
   Kix6IhPQa3TyrxOZ2QC2oe1/8CxPPo4/NSdsMpFqX7LlZVW4ZTsY0B1Dm
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Aug 2019 02:54:53 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Aug 2019 02:54:52 -0700
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 8 Aug 2019 02:54:52 -0700
Received: from NASANEXM01C.na.qualcomm.com (10.85.0.83) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 8 Aug 2019 02:54:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Thu, 8 Aug 2019 02:54:50 -0700
Received: from BYAPR02MB6006.namprd02.prod.outlook.com (20.179.89.142) by
 BYAPR02MB4422.namprd02.prod.outlook.com (52.135.237.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Thu, 8 Aug 2019 09:54:48 +0000
Received: from BYAPR02MB6006.namprd02.prod.outlook.com
 ([fe80::a089:45c7:6f66:d277]) by BYAPR02MB6006.namprd02.prod.outlook.com
 ([fe80::a089:45c7:6f66:d277%7]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 09:54:48 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Subject: [PULL] ath10k firmware 20190808
Thread-Topic: [PULL] ath10k firmware 20190808
Thread-Index: AQHVTc7WzbbD8cH4hU+zK5eOvaC7Eg==
Date:   Thu, 8 Aug 2019 09:54:48 +0000
Message-ID: <BYAPR02MB6006478A57983F5B4067F54392D70@BYAPR02MB6006.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kvalo@qca.qualcomm.com; 
x-originating-ip: [88.114.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 533218a8-d12a-4a5b-a915-08d71be67322
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR02MB4422;
x-ms-traffictypediagnostic: BYAPR02MB4422:
x-microsoft-antispam-prvs: <BYAPR02MB4422C8234275C4FAF46481B092D70@BYAPR02MB4422.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(39850400004)(396003)(199004)(189003)(66476007)(8676002)(81156014)(186003)(102836004)(26005)(53936002)(3846002)(81166006)(74316002)(55016002)(33656002)(6506007)(5640700003)(6436002)(6916009)(8936002)(486006)(305945005)(54906003)(7736002)(2351001)(9686003)(316002)(7696005)(5660300002)(99286004)(6116002)(2501003)(476003)(14454004)(52536014)(64756008)(66556008)(71190400001)(71200400001)(4326008)(91956017)(66446008)(86362001)(66946007)(76116006)(2906002)(478600001)(66066001)(25786009)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4422;H:BYAPR02MB6006.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v6h4SCOlxvWfOM8kX12JMElpfwPRY2QjszM2ACpRrnW5NovmcjcYR6feT7JI1RKkme5q6dUAk7iwTXZ7v2fk9Nr+GDxhEUVuvD/vMKbDx7BSy5Edr5cm6+1Pm0P7ix3IQV/g9vvDkQZfc2AqDNIMA4VLpLrm4DHAlE1VDbeDAY3qvdjdvQFIIfrUmTmtUfulXC/Rv0iy6R8dPbRB885Q+g/kXvZ885+/zrr5sv6XKwpAU7BGHy22TEDPFkDcPuMODCUqNERsX53WluJJE1wWQ8NQp6a+4HLfZPbWvQ2D0G5gnyGQiFg41JGArRG7tYlFnFQ/zQe4gS+TJbNZxnpcNx5RP4gPIhBQCdwQuJENQfnUytptu0xOmt8u9+lQiaerkOaY3+IGRTiZUA97FLD3rCIE6XbvLECAz1H2h+pqyas=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS780+mM0w8jxuEx9n9YRDJf3yhNeyZR7KhEOelloebtzE6QUr+KtUpLH7c6hrElRkbi42OdKaeBv/kM8C3fingmcaTkRiogqC3fQ1JF2Nw5u/4R+8rLNx2dXIreTplTb10NRB86PrID1lzNwfbwLuqoGn1lyfMWr1y/3chdAqhSFEhP+bIj2O1sdW1w9/QFVLk5iC20/MIuWdWBPR21w3ZgHDcCRFvlVLqbspvQ7oUX1fjxRu9OuTsB2YLB1Iz0QeSqXjGGHeaMhwDmP283BqQhI1QtOhvuvv6U7AR/nBicVUJFCbBIGvTEV1DlAKbiUhMvbi6fZ8kQIvC7SbVuag==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fP5+GPKmagFNBaKvf05X9gC6ULgG4ABTbxtAXhcwvU=;
 b=oA2pk+31A8Z3S/u7qnFR+2uOr7uYM3YO779t0Bqnj2tE1Hfx/S64OEP11W0DDI96+x3ovs9P1pqlGtSjmLwfjW52pw9bNj+ZU6oHX0ezkLY0nQfGutGx0bwJixWwy+FWyLG602diVMgJSFZwgl5zo+8rtEc1KyO4IlRAE5cI0UrAFmGNwfK3+D8lsWcwqXhjRZ8KQI+GJhD1DjHWI+suU9YbV0LO6dpdZemwufBNHTCY88Zgrr5w6tL/Wfp9+n7X9OOdwZUYnDV6EnjuG4wx+bDOwH7C63u3ygMDzvhg+sW+My7eMdfnLDItzVHGp+WtlKotB9K8XkC+2lJYDIUsFQ==
arc-authentication-results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=qca.qualcomm.com;dmarc=pass action=none
 header.from=qca.qualcomm.com;dkim=pass header.d=qca.qualcomm.com;arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector2-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fP5+GPKmagFNBaKvf05X9gC6ULgG4ABTbxtAXhcwvU=;
 b=N0RAs5M36FKlXpMVyoKxC8I16fRSU52S3LKRJ1ZQOGC5xTIwq3C6+zi3JGMr6JdrmMJFLyfeCBt1Z8rjrFeQOor0iZFN6mhBeiawzAN9yNh+saLHXWXuMMzloGR8S6I09aDET9rjaLm98XmMGaEqW5gCxW5yr5kpwu7VaxpD6hQ=
x-ms-exchange-crosstenant-network-message-id: 533218a8-d12a-4a5b-a915-08d71be67322
x-ms-exchange-crosstenant-originalarrivaltime: 08 Aug 2019 09:54:48.0855 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: tmv6NAC/zMC8HWYjlxmP6hbzEZ31GJ5dLWtGMTq1p6QdcbKEkv+mRgUaitOqnh5vNDCkjPYMQ0HmKJgFyp+mOA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4422
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qca.qualcomm.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi linux-firmware maintainers,

here's a pull request to update some ath10k firmware images. Please let me =
know if there are any problems.

Kalle

The following changes since commit dff98c6c57383fe343407bcb7b6e775e0b87274f=
:

  Merge branch 'master' of git://github.com/skeggsb/linux-firmware (2019-07=
-26 07:32:37 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git at=
h10k-20190808

for you to fetch changes up to 1f0a99f6b07e24449411ccf208836b6769a5a2a4:

  ath10k: QCA9984 hw1.0: update board-2.bin (2019-08-08 12:39:06 +0300)

----------------------------------------------------------------
Kalle Valo (8):
      ath10k: QCA4019 hw1.0: update board-2.bin
      ath10k: QCA6174 hw3.0: update firmware-6.bin to WLAN.RM.4.4.1-00140-Q=
CARMSWPZ-1
      ath10k: QCA9887 hw1.0: update firmware-5.bin to 10.2.4-1.0-00045
      ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00040
      ath10k: QCA9888 hw2.0: update board-2.bin
      ath10k: QCA988X hw2.0: update firmware-5.bin to 10.2.4-1.0-00045
      ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00046
      ath10k: QCA9984 hw1.0: update board-2.bin

 WHENCE                              |  10 +++++-----
 ath10k/QCA4019/hw1.0/board-2.bin    | Bin 449316 -> 607304 bytes
 ath10k/QCA6174/hw3.0/firmware-6.bin | Bin 731276 -> 700988 bytes
 ath10k/QCA9887/hw1.0/firmware-5.bin | Bin 237660 -> 238484 bytes
 ath10k/QCA9888/hw2.0/board-2.bin    | Bin 84928 -> 84928 bytes
 ath10k/QCA9888/hw2.0/firmware-5.bin | Bin 688536 -> 686996 bytes
 ath10k/QCA988X/hw2.0/firmware-5.bin | Bin 248840 -> 248984 bytes
 ath10k/QCA9984/hw1.0/board-2.bin    | Bin 171916 -> 171916 bytes
 ath10k/QCA9984/hw1.0/firmware-5.bin | Bin 676316 -> 674940 bytes
 9 files changed, 5 insertions(+), 5 deletions(-)
