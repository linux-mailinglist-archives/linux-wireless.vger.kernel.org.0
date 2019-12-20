Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA34127823
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLTJbv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:31:51 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38965 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbfLTJbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1576834311; x=1608370311;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=RGXjA4GkuWhtGpIeQCF8s2FKL45KUD5hCe1nIjwNRvs=;
  b=U8yH63uGnuYVqBbKXfkkw/KXYrQEC9n5lk+FhLFMqCYsFXSQUXUVJ0ns
   HxpA8/1+FWx4puyCoj7b/TmJ3D1Ik8/ETITJYJrxkmjnjJOMj0Hgf56sb
   83jUZUVE6lk176pBkevaLj1BSnC4stlqaK8pMGFROM4POf5vJo3rlsZgZ
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Dec 2019 01:31:50 -0800
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Dec 2019 01:31:50 -0800
Received: from APSANEXR01B.ap.qualcomm.com (10.85.0.37) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 20 Dec 2019 01:31:49 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 APSANEXR01B.ap.qualcomm.com (10.85.0.37) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 20 Dec 2019 01:31:22 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Fri, 20 Dec 2019 01:31:21 -0800
Received: from BYAPR02MB6006.namprd02.prod.outlook.com (20.179.63.144) by
 BYAPR02MB4184.namprd02.prod.outlook.com (20.176.251.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 09:31:20 +0000
Received: from BYAPR02MB6006.namprd02.prod.outlook.com
 ([fe80::fd7e:211b:8809:c956]) by BYAPR02MB6006.namprd02.prod.outlook.com
 ([fe80::fd7e:211b:8809:c956%7]) with mapi id 15.20.2559.012; Fri, 20 Dec 2019
 09:31:20 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Subject: [PULL] ath10k firmware 20191220
Thread-Topic: [PULL] ath10k firmware 20191220
Thread-Index: AQHVtxg8lXD0ns6gx0+QjZyYoWO6PA==
Date:   Fri, 20 Dec 2019 09:31:19 +0000
Message-ID: <BYAPR02MB6006CC2E199B34B8EF53D30D922D0@BYAPR02MB6006.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kvalo@qca.qualcomm.com; 
x-originating-ip: [88.114.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c040812-d4ce-4515-8828-08d7852f5f1b
x-ms-traffictypediagnostic: BYAPR02MB4184:
x-microsoft-antispam-prvs: <BYAPR02MB4184EDEEB105FD0E01012F8F922D0@BYAPR02MB4184.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(4326008)(66476007)(81156014)(2906002)(33656002)(26005)(71200400001)(4001150100001)(81166006)(8676002)(54906003)(316002)(7696005)(66556008)(6506007)(8936002)(6916009)(186003)(76116006)(52536014)(91956017)(66946007)(64756008)(66446008)(5660300002)(55016002)(86362001)(9686003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4184;H:BYAPR02MB6006.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/KjgE9HcftJ8OvL/Co7g0zbme5hTSXHShYsLbNfnj7NooWNMW17xVYpCDmQPV6YGDmiKj2Pm970SCjYrdIDVhTYU9gksAmWg4383T2v6tOVWcBudP8znSU8hgKYHkSgqIrpZSp4z/xxT4f7IOgqsansJx43I42tBa2ydUETWjwNuVcFwlTL9NstmlbSlg4HhwUJzmyeHe9Dse2ffYIzupSByzkqVE/Sh8Kx8VnV1tUYl4sixIJDf0OLcF1kzKsH2tGxEgUvOxZGUbZqMhg3mv/OUXggYAYD3lWDW8Lfe8N+7pt8VqnWkkk8VTIA4i0xsMAiySGhFSlYSOriPsoFIhef4cPIMF+4p/qkazY9Z0i55VprEOqmyKVJnA4v0hzK9LoEO4ekZ7IQUA8mg/7pO3UCNAPUJWeUIVnU0kB+xTP4CIG8H0c46XxNjUVeyPCN
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp80aXUxaUEnD35FcJgxKj5Idz1/L0quPp8TLuS1Jo1xjRwcTSU57GutieHQXyCXwgCR1aHrzYdKwoIc8lAPYREHhhI6zIDYOt2+kkH1JfWxQvzNJdZNbXLy+cdRPUqotYgUx2O+E0XGWz8h2ATSWzxKFJH9RcLBIgvQNzodLtpRtWU/OSp5Peiy31H3F+A3DuNYvPY1LNUUIk+S281LbDObUz/JdAag60QCi2AfdWW+pXVVG+FeJjH8iczHcXQ67K3OSQtkHN9gGjFNcGq6W3PxdXdehpZsT4+mFBveeHZl8hPUjCOd81P+JqDF7e7DlRIc6m/osUp771ZbQ8l7hw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tmmCO3ngWPDEdVT6mQOOYehM0vDm5nWNmIjDxdGdfk=;
 b=PB6f1pScrLFygTCKTVmjZwX9wadmRCcXje5ERebuq0/o+/6E8vuAjlKj+YwlPF9hW1/Pqbo+c4tLpNtFjgA7H4Uh9SXihHNYE/GlYokV0LjLUG3Cst8NNCyUGTrxU42PgJm6e74OIl1ImHBOXFC8eFrxsmX0EYo0K3Ecs8neGGzrq00OTXLOMiv/BN8pJSJJcOy5Xl0K/YmBqrdh7Q79nkWKXKn2H2g5P6Vp9yae/Q7PSO+krHyIiuppEJbxJzMEILT9I65kyQEaAdl9iyrPhfgGhOwb6lgaAl8TANfWUL5bcHwtpfXGmmwHXk+O+i6NkcQKwkpSSoiMsevCHX2VTQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tmmCO3ngWPDEdVT6mQOOYehM0vDm5nWNmIjDxdGdfk=;
 b=WgcOEMMQp28eQ7J80dZzyWX6Kx5SR2i8YaQLQWflTP3zzLxTw/NSotHlAd0nchFLlgAJHBnAf//lk62KeO8vbccYUYQXN8DLUYeBqk5Lk5GiKvhWv2gPTABbO3YK7z+aIEB31ObZnsYlfHaMKc8sUUK646Ii5M/QEUqR4wKGSto=
x-ms-exchange-crosstenant-network-message-id: 5c040812-d4ce-4515-8828-08d7852f5f1b
x-ms-exchange-crosstenant-originalarrivaltime: 20 Dec 2019 09:31:20.0752 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: liLB8nmSnv3bPTaxI3Z+9G1fLiS52BtGc/RwzJUHqWDuEaJj2Wlgg7s6yUyj8bOnsgPiDMCOTnj5BidWRSd8+Q==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4184
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qca.qualcomm.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

ath10k firmware updates and also new hardware WCN3990. Please let me know i=
f there are any problems.

Kalle

The following changes since commit c4586ffaac0ca0d7045e06140b6426f2e79e96e6=
:

  linux-firmware: Update AMD cpu microcode (2019-12-18 09:37:15 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git at=
h10k-20191220

for you to fetch changes up to b142c2e0229bc89b44ac527f4f3c3def063bcbc6:

  ath10k: WCN3990 hw1.0: add firmware WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1 (201=
9-12-20 11:18:46 +0200)

----------------------------------------------------------------
Kalle Valo (6):
      ath10k: QCA6174 hw3.0: update board-2.bin
      ath10k: QCA9887 hw1.0: update firmware-5.bin to 10.2.4-1.0-00047
      ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00070
      ath10k: QCA988X hw2.0: update firmware-5.bin to 10.2.4-1.0-00047
      ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00070
      ath10k: WCN3990 hw1.0: add firmware WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1

 WHENCE                                   |  12 +-
 ath10k/QCA6174/hw3.0/board-2.bin         | Bin 567608 -> 584036 bytes
 ath10k/QCA9887/hw1.0/firmware-5.bin      | Bin 238484 -> 238548 bytes
 ath10k/QCA9888/hw2.0/firmware-5.bin      | Bin 686996 -> 688140 bytes
 ath10k/QCA988X/hw2.0/firmware-5.bin      | Bin 248984 -> 249044 bytes
 ath10k/QCA9984/hw1.0/firmware-5.bin      | Bin 674940 -> 675948 bytes
 ath10k/WCN3990/hw1.0/firmware-5.bin      | Bin 0 -> 60 bytes
 ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp | 571 +++++++++++++++++++++++++++=
++++
 ath10k/WCN3990/hw1.0/wlanmdsp.mbn        | Bin 0 -> 3725044 bytes
 9 files changed, 579 insertions(+), 4 deletions(-)
 create mode 100644 ath10k/WCN3990/hw1.0/firmware-5.bin
 create mode 100644 ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp
 create mode 100644 ath10k/WCN3990/hw1.0/wlanmdsp.mbn
