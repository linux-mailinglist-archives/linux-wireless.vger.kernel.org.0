Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9B175F7C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCBQXo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:23:44 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:59180 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCBQXo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:23:44 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Ise5PeTMiZvZ58+aPn6vfTq3ZABJmUkevqlESA9AlXW3C3zMjHCaq6bsLjstxLT/ou6T3FOh9j
 6ZzEg0TmG7xSDgO34/w9R1IVAegxJ0lPZXYppzacVrdjHwx8PnoCVkRNH286bP+9pJlXmPE/Vq
 7fXJARk71BYd7L/QK+nctVCWI4HASHhH/QxkN0EN8nUm/2mqD52cQsoZx1SeVyCBtkOqhrFe/o
 9HI0g+j5LTF6gORmYgvLPwCq2MyIldnDNrb+E8Kwlt2psUnwnTWTgRkndEenl/IU7wJzJT2Z3m
 uMw=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="65862715"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:23:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:23:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6AmRWlWE7WOsQiAT0TCkxEbhDeTMRIslNQ6xixNmY0xBldpQ+R8kS5lnZsrR/vW7Ls4Wqd5CPEbNacGTdfwk4JnjDleEME2eBmDRrt0LfO8yGjXfM9oeMKtqer6DCvc/uZQzRYOduvhXix63/eaay/CCu03H7aCSVUSliRPhCbTQ8Te9+Nd5C8l9a3qad7pM/ImE6ZvxMOaXk4OqdzMWygJVcDmE0JUrnmZRgTw2J7duljdAvs6HBTlOIgFEk9whIZiyMLYVFdOMWQ8BOXVnYGjIOefQBXhAGcb0qMaxnJp7bn3HrFTeHGAvWoHwumZdqKALFXWkfUjv477fSxwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRw7XYG6cvVhwKTEvVcvRpe6efemkNJ3RNVD2P7nuZ0=;
 b=OoBpTTxVL08l0olb0KngUPVCaxNqlbeAfsnTiRgLM/6kvZ9w3bnD2mo0QcFdOF19aupxqLJZ8CI0c8TtsKGc6YNZqTpFAxo6fLwTx/6HKpDVCiGG9Q7KSTvzMf0VtP31BVvTnso/Q9GaAUrykMWhuQj+jFBlkaDAcgS6YAcD0X3XyO8GOX3wqHnrHxXH0wj1MbdnPIoqJ3E0xo2J4V+1mb29d2j9aOlSmZHRVbBhdURdzq7+wvNTr5Cidw83H3BNc1XtwHAVZd0aF3w78nMtXfMik3jIlP7S4cois0ImZeDgDw5mBWMaVBoDz8Wc5X45Y713NNIlVFg2ON+9OdrMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRw7XYG6cvVhwKTEvVcvRpe6efemkNJ3RNVD2P7nuZ0=;
 b=jdcZ5qPOS0qn81Kx8wRj5A8CsaieHVuZUvw31Do9YIztfdPf892N6Pc72i0v5OGHTZlpY/pn7pTAMqwTgb/jzf/Uza+ld2sfW4hz21FS/VcYCQmmkmvAb7++3aepcdpqijVd1UaXTvPyTigXZWYCJPOfTgJIUXGGN7aBwuCGrHY=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1426.namprd11.prod.outlook.com (2603:10b6:405:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 16:22:34 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:22:34 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 0/3] staging: wilc1000: correct Smatch warnings & use
 flexible-array member
Thread-Topic: [PATCH 0/3] staging: wilc1000: correct Smatch warnings & use
 flexible-array member
Thread-Index: AQHV8K7HseitwdwO5kueKU9L/NJPqQ==
Date:   Mon, 2 Mar 2020 16:22:34 +0000
Message-ID: <20200302162226.4196-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7728f427-1118-4fff-4291-08d7bec5ea86
x-ms-traffictypediagnostic: BN6PR11MB1426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB142681153FE7AAF35FBAA85FE3E70@BN6PR11MB1426.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(5660300002)(66556008)(186003)(26005)(66476007)(64756008)(66446008)(6916009)(478600001)(6486002)(6506007)(6512007)(107886003)(86362001)(66946007)(91956017)(76116006)(316002)(8936002)(71200400001)(1076003)(81166006)(81156014)(4744005)(8676002)(54906003)(2616005)(2906002)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1426;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CB/6fdQaIJigrY9r4vYp/pIs5/o9FWzKx9TvSDIH3ypxtZT8VXdNN12KmeiPFNxh3hd5SxQrvySUD0Y5uT3yUjUFdU6m3tVltv0FqySdakx7QbpQrg/i/Hlz+GZ7KU670vLcwcw5jlVwsLgH6UK0YifLSXzDfFu9H9ZXDeRl8Nw5YVPvZIThsstt5MX8PUmqxBvbS1bfvFW5QbthgRCGxR+6L+SszNZYUmBcBbHTrjVQgvHq03xu+NGCLzfZ+3F6qBY3/wh5RgrSAlkSdVByGpAfnmjNsXOf/Q8SguE/iRB5GNS+ttl5MEWvcG8H47iN8s/k4nN7RHQ7MO5yB2TEvhKPsk4Qavd2VFhPRsYTZ7yNsbajMpct9CERr8uyRcJlDD3BN6dQ5aY8o8AGrM9EktYy0B6JyXKs8QqzC3oEIm6WiFQKjBY7JqryGn6ccbVu
x-ms-exchange-antispam-messagedata: fah9gh1cxm/nyoF0O5Pv+Vmul91tnhPLsLkN2bUNugUdHRO7+RKRdmAdvEBNXMUuacyXUUB9HChN0HmP/fTBsS+keOfaPe86ALsyJxMzRQnQok2p4nQpfdWd7FpL7eGDMZLIEbs416/xpnaCRoSD+A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7728f427-1118-4fff-4291-08d7bec5ea86
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:22:34.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +By2r9arKX2PuBgzovNdyNL5yc/iJuVitXFyaHqfEpqRsiW1pn+9J9R7/LPyXNC2CqCxhlukBTvtVZcETgzXbfYJwvRLga8E4j+6M7dzSYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1426
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

This patch series contains changes to address few Smatch static checker
reported warnings. Also added one patch to make use of flexible-array
member instead of zero-length array for few cases which were missed
earlier.

Ajay Singh (3):
  staging: wilc1000: use correct data for memcpy in
    wilc_hif_pack_sta_param()
  staging: wilc1000: remove unnecessary always true 'if' conditions
  staging: wilc1000: use flexible-array member instead of zero-length
    array

 drivers/staging/wilc1000/cfg80211.c | 26 ++++++++++++--------------
 drivers/staging/wilc1000/hif.c      |  2 +-
 drivers/staging/wilc1000/spi.c      | 10 +++++-----
 drivers/staging/wilc1000/wlan.c     |  6 ++----
 4 files changed, 20 insertions(+), 24 deletions(-)

--=20
2.24.0
