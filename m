Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7D297300
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464535AbgJWP5a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 11:57:30 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38217 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S373408AbgJWP5a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1603468648; x=1635004648;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Q0bbfuHT1arSQhIcxzhtAXnxr5jKlJ3kXBAbDIkjlU0=;
  b=nxJZjr6YNFWO/OP6MVNweIy+Vb/0Tru4xye/F8m8xnj0mnG49RMAr2fn
   bAS8jJUeqIBAloAyrRDFg4tpIdmuSGPn1OpnhHMlQtVvnNcAEIzXrw7j9
   8zuMv29ofTEzZdPsx/uERbHFOcENLaBDFS21Nh5bR/L2nVRE6qunEFdVu
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Oct 2020 08:57:28 -0700
X-QCInternal: smtphost
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Oct 2020 08:57:28 -0700
Received: from nasanexm03h.na.qualcomm.com (10.85.0.50) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 08:57:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 23 Oct 2020 08:57:27 -0700
Received: from BYAPR02MB4567.namprd02.prod.outlook.com (2603:10b6:a03:5f::14)
 by BYAPR02MB4055.namprd02.prod.outlook.com (2603:10b6:a02:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 23 Oct
 2020 15:57:26 +0000
Received: from BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::e85b:1ca9:6539:4b48]) by BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::e85b:1ca9:6539:4b48%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:57:26 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: [PULL] ath10k & ath11k firmware 20201023
Thread-Topic: [PULL] ath10k & ath11k firmware 20201023
Thread-Index: AQHWqVSGffus+VPlVUOBClTsKoSKlw==
Date:   Fri, 23 Oct 2020 15:57:26 +0000
Message-ID: <BYAPR02MB4567172F4913F68EE61C7EAC921A0@BYAPR02MB4567.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=qca.qualcomm.com;
x-originating-ip: [88.114.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3266859d-ecd2-4956-b4f8-08d8776c5686
x-ms-traffictypediagnostic: BYAPR02MB4055:
x-microsoft-antispam-prvs: <BYAPR02MB40555E155CFC76468F2DF4E9921A0@BYAPR02MB4055.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTTMCuCPcXjt8dXoTRQvdvDK13fAN5wPHIPEIv5M/1kzxJEydNrkHMrYW8beXASddJ8KN7uE/p9RtMVRPvSNN6PeCm/EBJlQPhsULeJ0WesJq4XNubz4PaOkQ4Rt8D37zDgZxQcow/2NXxgInLGDl1H/lGHNZ7pyUYUsutg/wsAV8sJeMo+FQiTDfgPu3dSRaSU5lOAhHyuCZTOG0JDSvhO46kIk6MfaPuBjvZgjwx041+evHbOaKz5IIRUNkQA++haRn1ubhuZwfV7HCYittRkFqn/zK/aYqFzsd5ektbK8wanSI9SxkiDpyOc2/AH61I8H9M7WfR/v1lbrq3rTmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(396003)(39860400002)(4001150100001)(478600001)(6506007)(4326008)(2906002)(7696005)(316002)(8936002)(71200400001)(19627235002)(54906003)(8676002)(9686003)(6916009)(83380400001)(55016002)(5660300002)(52536014)(76116006)(66446008)(66556008)(66476007)(66946007)(64756008)(86362001)(91956017)(33656002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OV5GVMFLDriiphuT0kz7bYukbgy6wfdMF6oAle+JtOJN7FOIFl3jrniifiseF5ljxdm98IOj0y4ONYtzXgYL1oDqU4eIryQewL3gcJVjLtV3Bd/99zIdp4mSz+xdZ6OPHzmVnRutRsA8IY/n45cPHv6MlcatQRVI+lHzstZpKGLKCTKmMxSfN6qBWulIua0b0hQQCcsltVkiTm4dLYCJovl4G7QNZiDXycKUHirhKodbQjLKzYqaCQFCmauTjEe2abgrcbUPdPFoyt4xO1+3L7wvWLKC7Dh7AmYzJY7a3LKdvcXiUlO6XO3jjXNy2lFIXEg8nYdV9TGwWBkX3QWvbY94CVE65kL7VbKzwlHRSYxQoKhsLhKddRtAl3EcJln4H34e1KVMuXIO4q5+OIUp0RD4aVQe2dkdCPDBjKbKgxd3T0Zstv6D5IrrqgUfP8if3UJYhr7tFPuo314TZv9iKk032vdGLC/Sd86x5TgWCLJr52pzbCEzFrn0F8dgW0E3t7q4uAdQsHA0CAClEU6PJvGg+v8o0E+30O4hRMKZ2eJ0899Ng1VlaZnkJbiAjwSnT0NVMeB5jS/EP5VdHoh4Me/Z9UfdHaaKUWde9mXjUGtyr+bPbuuR2zGxFkv1L4v9vdubki6AaB893kWrqkCXFQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORE5Mly7CsaAeWmXCbpwnW/l4D4qS7PR5rcTtD69Q5p6xXvBlu5bDw191AgUMESrQK6Sasvda+z12nhsZkENo4wZjThuLtuMU1bRHV6aVJNmi8kc+0f4AmLmtX3GgR9bF5qOBcNuq0RcztcMcgUlrZSycZLDJMRuOaEI1KhGbL8U1Z/mXAMTGqKppOzhUdw9wzKgZXbYhUbyFlt5Ow10dcqi90PpytwWOourbkpvb2VsMjx99wOwgSH3DSW7MAsdKbZj9wyQweyQC7mPNq8GiR5ai9IEtaU0OQA/bd9KgoD4DiCEfdxCAejVH8744MX1VZC6Kj2iF22sGTwPFLzaQg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/QR2gxDO4qbiFbaBlb89iH6cnOBRu0GtSxr4zfvha4=;
 b=eG4ZcCndB57mtr0dFp/rEZsc+PWBtGpgwwiWzoz+h8Q48J70FiQ6jjUAGjLG2+fUiKiWtrdLqtGu0hfYeBV1FjFUCQDe0WLD2ptEG4d/6sc++ao6GryIzDYLQu2YKdDw/AX19VEn1z5F7kyaczrMmeAbRp578uSzstj/NLlE1kQonCI2nnwJs/pizmVUcvsLtvdg3XU2QolBs8UEPFdKwq1LKK6W7BmpLZGFdsChPBAn5TY2P1lAt8+zSlW+gw6fdH3t5/04imKhjLZFMIRgAyfsSVGHrrIXwKsZlPhvb84TvfUsLxZUSssFS7Bau5wWcu4OrRQq4TCrP7X4TnUfoQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/QR2gxDO4qbiFbaBlb89iH6cnOBRu0GtSxr4zfvha4=;
 b=UHmekl39jsjxdtPoHVtgsgXOEp1Z2C8mZoubDz7W/FuHz5ooId6q58IvoYGSJkwXA2F7ToXcvBb2bc4pnVWXgIr0JlpfmFYsaSFqSXPHeqvO+YffG+NulNZCkN11HJiqju1hkZun7vONV727HqMgj2wIaiagljTzQoYykzmGDME=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4567.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 3266859d-ecd2-4956-b4f8-08d8776c5686
x-ms-exchange-crosstenant-originalarrivaltime: 23 Oct 2020 15:57:26.3507 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: zFJeTW3qpEVKPfD5qu+rS5513RN4e3RamUza8b/POKf8L3Q93vJQ/WYXtYtP5w+wgXM7a7Q4ZhyoO0k3hMrCBw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4055
x-originatororg: qca.qualcomm.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi linux-firmware maintainers,

here's a pull request for ath10k and ath11k drivers. For ath10k there is a
firmware for new hardware QCA6174 hw3.0 SDIO. For ath11k there are
firmwares for new hardware IPQ8074 hw2.0, IPQ6018 hw1.0 and QCA6390
hw2.0. And also few updates for existing hardware.

From previous pull request ath10k-20201022 I fixed the notice files to be
valid utf-8 and changed CRLF line endings to LF.

Please let me know if there are any problems.

Kalle

The following changes since commit 58d41d0facca2478d3e45f6321224361519aee96=
:

  ice: Add comms package file for Intel E800 series driver (2020-10-05 08:0=
9:03 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git at=
h10k-20201023

for you to fetch changes up to d842d8c5892ea1570eacd01cc274436d1c6e676b:

  ath11k: QCA6390 hw2.0: add to WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-=
1 (2020-10-23 18:42:08 +0300)

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

