Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7FC10009A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRImH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:42:07 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:45656 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbfKRImH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:42:07 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAI8f4gY027504
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:42:05 -0700
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0a-00183b01.pphosted.com with ESMTP id 2waf9fme2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdFedJ5LLnyWBQhkJ7Uu663iHQLQTKHZ6sOUV8yNwHZMiBIBfBNkbhzA17XJC1xrY837KdqjCMFJ3zqUE8E/ZPRtD/PEuK82sH/3SHXX/60CBsxZhkCaSWS1D3ZyPUzdhF9wmb4MHrZPCaDMRIN9k2+paF7RtAXrEgBCAt15biARPeS8i0GjAPjdFX2D5OW8Gvu98m7xRplESl/bXym1kV0z7pdYN1cHPYjos0e6l1qFTBKLmskhK/RT58VMmpMiT3GcynENNssBAQuOzlNO4cWtw/bnpdPn+LmjNMK09DUIYslM+6aPF+X4HpUGaLfTYobTTWw/t04UtAEzLPM9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWN1tOwKyH8h8SzTv04+Ona0VC9601PQFlsekyPdoSI=;
 b=Et+W9ytXEJTCOXRUg4QXUONx9MZEaQg5lTjas6WOoCgfRMK3TQlJl1wb2opal6xqhxEkAuKQ44aiv7076Wc3bXCveVggV4qLjPatPTMer1pyvyMqPxx9CBpHiif2CI1J8WiqeVPmGNsfgS1S2grF166oyMPew8nyNB/U0OY8zXwTpOoMztppn9yaUAXFj28MF423iH9uj4Bcr6Z/USYE04Xw974fcO+NcAvfR+T19fBg5WzWW8pFJfj1Rcq4/J4a6lNcbvSfYkt9EuVyiExOrowSr5dIwGgPtqvsVuLpT/5FE8E65XtVymTM8I8HhsfH6rv8/1bhVCuSJkqN6LMYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWN1tOwKyH8h8SzTv04+Ona0VC9601PQFlsekyPdoSI=;
 b=Q78Z4+lATJ3Un4z85gi5baSQd1QopXcEcY9ZWb+znpANRZWRw5fom1P7qYdsrpmKv7Uhj2S2wXelKrdEafkat8TcKDAVHbt4p2BBWwofrlegox4OpQTYF6GA9vHTkrfmf8rcOUyC127kk+d9PMqhv9nyVgUx2hC3cDXgBneGzeI=
Received: from DM6PR05MB5916.namprd05.prod.outlook.com (20.178.27.29) by
 DM6PR05MB4139.namprd05.prod.outlook.com (20.176.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Mon, 18 Nov 2019 08:26:52 +0000
Received: from DM6PR05MB5916.namprd05.prod.outlook.com
 ([fe80::ac0a:cc8d:4075:b394]) by DM6PR05MB5916.namprd05.prod.outlook.com
 ([fe80::ac0a:cc8d:4075:b394%5]) with mapi id 15.20.2474.015; Mon, 18 Nov 2019
 08:26:52 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:03 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:02 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 0/7] qtnfmac: enable 11ax and bridge forwarding offload
Thread-Topic: [PATCH 0/7] qtnfmac: enable 11ax and bridge forwarding offload
Thread-Index: AQHVnell/LFPbGONxEWU7P6VW/g0sw==
Date:   Mon, 18 Nov 2019 08:23:02 +0000
Message-ID: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb25735b-46cd-4384-af44-08d76c008755
x-ms-traffictypediagnostic: SN6PR05MB6320:|DM6PR05MB4139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB632036A66CDB75C8D9AC9B5EA34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:26:50 AM
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39840400004)(396003)(376002)(199004)(189003)(478600001)(6116002)(50226002)(25786009)(71200400001)(476003)(2616005)(3846002)(436003)(102836004)(2351001)(6506007)(71190400001)(386003)(8676002)(6512007)(5640700003)(2501003)(316002)(6436002)(486006)(103116003)(6486002)(36756003)(54906003)(99286004)(1076003)(66066001)(2906002)(5660300002)(86362001)(107886003)(256004)(14444005)(8936002)(186003)(66946007)(52116002)(66446008)(64756008)(81156014)(81166006)(66476007)(4326008)(66556008)(26005)(14454004)(7736002)(6916009)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4139;H:DM6PR05MB5916.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3QLKsBdjZdfddEVWkKdzSgHZR+phNPrhNaKjAfdxV4rtDZPbZC1tgP2QXwJcgUdXL0eZJ4kDqm7IVyQGU9gaIG4ecpzqkqFVWWOevYzmy4Y0hM03C3YiiAFMGDWrz8qbPnNYzdMnyFH5WG+fKw9oYxD3Gp6eOwPJ0Jmwt4FHGHZoC6F/zS9968HkVGQMHUiXa4EE5sGK1kdb/pIj6FwhTnutAYKlYbj2cp+R/akUaHKLNdsEjEeDxgZA9qQKK6c8t/7mSd1bMUbphnFF2PZaIk1CiaY3a6U1AXFFUxJVR/0wOAyFAGEEc0hDwgwQ8OCUxquoKIMS8OlXqaEYUM7a1Og101YMSnLMnFcBQTrZLOMDP+2icIwDxwTZQYR/SVbHLKg7hqroSMJVrVEv+oJQgOuricSuSDziboMdQfx7HaFhoAm++RdusAKz3BfEF4kS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb25735b-46cd-4384-af44-08d76c008755
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NH4PvQj5RhXpxmghcaIKXlnh6a/lh53/fM+ldQz2BpFGAm3X521d6qOTPGhC7NDoVdYEwrT/5wMAOHhM5GZYZ1tc7l6xbQAQZuHELTWYBoJuHHCbYctvb7dnUwten6svJQcICJepuTpx/DLGInnuTEErT0CN/IIEiQDDS43UbZqZwK1IccEQfZK4GTz+nOKKS+VWC/g2b7zzpSM7N7IDfew54/F/5Sf0lfEMJQNmn8Q=
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:26:52.0959
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4139
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Kalle and all,

Here is a patch series that enables the following two features:

1. Enable 11ax AP support
Suggested changes pass HE options to firmware when hostapd is started
with enabled 11ax configuration.

2. Enable proper bridging support for qtnfmac wireless interfaces
Latest Quantenna wireless cards include hardware switch functionality
that is able to perform fast packet flooding between wireless interfaces
when required. If hardware and firmware support that functionality, host
networking stack should be informed that packet flooding for bridged
qtnfmac wireless interfaces is performed by hardware.
The major building blocks for this feature are as follows:
- introduce capability flag QLINK_HW_CAPAB_HW_BRIDGE to advertise its suppo=
rt
- track host network topology using broadcast domain ID
- notify host net/bridge when flooding is not needed using skb->offload_fwd=
_mark

Regards,
Sergey

Igor Mitsyanko (5):
  qtnfmac: make sure to delete VIF in firmware in case of error
  qtnfmac: track broadcast domain of each interface
  qtnfmac: add interface ID to each packet
  qtnfmac: advertise netdev port parent ID
  qtnfmac: signal that all packets coming from device are already flooded

Mikhail Karpenko (2):
  qtnfmac: add TLV for extension IEs
  qtnfmac: process HE capabilities requests

 drivers/net/wireless/quantenna/qtnfmac/bus.h       |  23 +++-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |  17 ++-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  | 127 +++++++++++++++++=
++-
 drivers/net/wireless/quantenna/qtnfmac/commands.h  |   1 +
 drivers/net/wireless/quantenna/qtnfmac/core.c      | 128 +++++++++++++++++=
+---
 drivers/net/wireless/quantenna/qtnfmac/core.h      |   2 +-
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   |  47 +++++++-
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |   5 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     |  76 ++++++++++++
 drivers/net/wireless/quantenna/qtnfmac/switchdev.h |  24 ++++
 10 files changed, 411 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/wireless/quantenna/qtnfmac/switchdev.h

--=20
2.11.0

