Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107F715D6E0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBNLwX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:23 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38153 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgBNLwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:23 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: PwYN2iCRAoS8WcmDivt8j9am18c4iz2uFQ72UqzSyFLG1Yhw7MO5WTYbAt4ZB7SnRzOq+4NO2H
 KF1XrYUJ3rsmXleo7nvgBTxpWLR3mGbeaedli3rw5MGhvfuWhRHMBE1N7Lpb6oCogELnI7CTWI
 CSqlVBonf6xSm7rTGJVxzkOciMTm6ZYEChkjUoqFAcxNHTWDaAOxmBfwAsO/IP12takSt+iX4I
 De1vxySE0iAGCQgCu6VvoZzgKSiJ71wMfe7hP63xplwcTTNXoy4WTSZc2JEeezutnWRlGoEYWl
 vJk=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="2407497"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq49Kbl9/FZIDY4o0VoWR6zI+JWh30gX7ptKI2T99uOfCLaGLZY1oDXHwF7n1UJfey+UOajOJ9cZGrXiDOJS2HhyDDbrTnNRd+JKE1gkOX+hrSLdhWd5cv/gar/QQJWl+YK3bg73C2Ei/4JH9kZF9cfI73NygYmzdz6J4EkxiUE7GCU3Jt/lvDV8c9q5e6vuy+h3tWh1lZ2ElmecO235u7uaQiJqBTwD13NFTdIWC5sxKgk4DlkwUO75QEclnhnoOPB4lh257Wkhnzti0+IkcTB1ZdSuubryB7mAeNIc0H2CmrqTYihBq9F2XON0doTNwk5ssSiS5r4H9oDGz9KVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D8/ZwHPTOiCbgCTXeOH/9nASs+HX20K2m3TsyAzuYc=;
 b=C+jx6u9TqS+VJNj4jZQ1g7Kbpuo28Uf2TJNwKbcNHZluKCSiZiv/0hPQfdkK0eICtLLQS/XINSwepHQfQXJFh2/coWCmgB+1TUZyEczyGNwMv2b+05DJtH7sppfoE746Uussj7rxXq22/Rqh3LVqB/1oX9u5WjJv0gkkg6RBIoo/4BLZutbgzc2eLTzcd6MLgG0o6sx2QMjnDlbUyD8cfL7BsRqgMw7qAFfUHuyX3oVNR5N4Y2+Q8KyicdiH69B0th3mlNOgptoY/ZGIabtEF2eGkqfDX9nVPa+Z7337JjI+oTawfhDmHVNxKSrYkLrtrcZQjAPPX2U2bsNGeTWepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D8/ZwHPTOiCbgCTXeOH/9nASs+HX20K2m3TsyAzuYc=;
 b=vv3p5RBI1mOWJouGeZ4wM59Y/tJigW2JvlHtMHJ7UKb5uqUgTzm+QRRYxqnWJxceeoEeuoLTh7zX4/R7vJmZtcqClfFsnXtlZnxdQTK2ZeLSaXNWJcZofvkVwEfnb46hEteEbJOF75aOt5FLZ5b76DnuvpA016n3R+yQTVfNLSQ=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:14 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:13 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 0/8] staging: wilc1000: remove magic values and handle review
 comments
Thread-Topic: [PATCH 0/8] staging: wilc1000: remove magic values and handle
 review comments
Thread-Index: AQHV4y0yKVY4OOxt+EW7IGf69N7eTg==
Date:   Fri, 14 Feb 2020 11:52:13 +0000
Message-ID: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35140bba-ca7b-4adf-2c74-08d7b144550a
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1652BA65DB16360ECDF78B11E3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkPQifP6R5WjOV+RIkAh1FgklO2b6n3k8220Ng3HDYqN2TLmhoQFmBZDoWrgko7BlvhVedEXK792C2oWHFGf0JmedJBBXUR6izOaQMQMLdxcyoe3n5ON5b7XPiHldxGcKAmtZgmt3VFoTXplJ3KPjBKq5mSSJWfkb4apoG9E3MBkOsE3hwiGFGVRwBHE6pP6V+0mmw6AIfdttSTStxRhQcKC6GzCIsZkk3gBC9rnR2L7zA5ie64CU9+4hpHmp45kWQvtgwYpZndTIm5Evvr4gKiYbp49PrLQRJNo+UstwvjIiAZY9XmTQ2UIDSQ8tBqU1jfRjLjziaVKg4n2kL3JjWW9Yp7B6bH51XbdND4LEiTxhrLQvzpqGyEPpSrVjjOuRYxfMq0J1EVCs07wV1oC1X8Iul5zZgxMPE5JQcczjxU4BktDXJxmTFRh4608dD6B
x-ms-exchange-antispam-messagedata: kv0VXyMSzR6J2huvNrOJF0IgE/Ybx36iyPLCiCy5sNgtNsVwIC0Bb+JSZy0lhrMIl0tjV852naQiAsOnavrozgD5/OwPxLQgDPxLRy+PbT85hP1JdrYUq6DAl6SbVx7Slh/OS2t/TS42RfvtovnV8g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35140bba-ca7b-4adf-2c74-08d7b144550a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:13.5279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssHnJhVggFi0ll7VvsUx1mlqUA7dENOsmP9vyjjsauMfbMfT+AQDRfpfPA2Oo52/1xYbyfnvtFRb53/82TiJbefLjQc/103rVUHhRl40vi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

This patch series mainly contains changes to remove the magic value for
different registers and define the macros for constant numbers.
Also, it contains few patches to make use FIELD_GET/_PUT macro
to extract the bitfield element.

Ajay Singh (8):
  staging: wilc1000: make use of FIELD_GET/_PREP macro
  staging: wilc1000: remove use of MAX_NUN_INT_THRPT_ENH2 macro
  staging: wilc1000: refactor interrupt handling for sdio
  staging: wilc1000: make use of ALIGN macro
  staging: wilc1000: use commmon function to set SDIO block size
  staging: wilc1000: define macros for different register address for
    SDIO
  staging: wilc1000: use short name for hif local variable in
    chip_wakeup()
  staging: wilc1000: define macros to replace magic number values

 drivers/staging/wilc1000/cfg80211.c |   2 +-
 drivers/staging/wilc1000/mon.c      |   2 +-
 drivers/staging/wilc1000/netdev.h   |   2 -
 drivers/staging/wilc1000/sdio.c     | 281 ++++++++++------------------
 drivers/staging/wilc1000/spi.c      |  23 ++-
 drivers/staging/wilc1000/wlan.c     | 128 +++++++------
 drivers/staging/wilc1000/wlan.h     |  96 +++++++++-
 7 files changed, 271 insertions(+), 263 deletions(-)

--=20
2.24.0
