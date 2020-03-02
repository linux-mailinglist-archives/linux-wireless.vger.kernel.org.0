Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB91E175F7F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCBQXq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:23:46 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:46612 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCBQXp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:23:45 -0500
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
IronPort-SDR: v5lr9xtu25vVRLLWg/AvLkuSS0SIpOalp4y/krk9bltdPRe5kQut2Dxbt+dRzibuwGFWgzbU5n
 yw2ClOSUmkaEIOXMlFMsKYXbr9foToOSJZdxWJlaHt5HIjIgYi5pbUhU73+h5NhJlCV3a5VTEz
 IBB+p3YRMZ9lMrlpuvWGUlYbuHK7LDEofag1mazuMR5glq0avuxU6xYooExAXPpomdBgNResyH
 bLRHG17e5rfSf+EREvbvD+Mbv3WXdF/YcFDtlhYAXCx3SZA76+vVcLtkCFoqaL2vAl6y5Qvsrr
 MNI=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4185725"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:23:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:23:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAaa2nxuAuBGVdp6LafEXCfrAuTCNtBbsR9wwlGJJzcT+iB5w4R/ZNd9bY2I5FVSvNZSp/2V+Iyd4PIZhd8IsNIqWO8i8PKdUdE+vVAKn+hzC635vv6aTfNqqMFC2XbKgjz9ZirYPEHF3erutwl/JgSCCEPCkTBaY7XYilwXwUGnmGB/W+vyJC9gh9dHxj81DAhVAsxL6mdavUCIVm3oayMRdq00aFrk/mNTgx+zDxq7EYPepqcEyN5vxqNTMesEWUSZhZMq+fjqthk339AbaQmqPJARk2mBaCfJfOd2t7BE7FCtjaUoinK1q8PaZpb6whbip4Cqc7a2PRMoXZP5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxmJSIOVMZZhvvGK8yX8a3H4S3q9aUKGumnmcy8MXbU=;
 b=db1msw87NV3c7wI4IQ5hdKTJ6ifsj0t2+1clmTAJMWZulAqoiW7qdgX+yo7XiU8sCvejOKtOKVYASy39wccIEKUZGfIzxKqqrItC/HTO3ZvjdAvNh4Y5ltDzOUtoKSMeLClCB/dRl2kxuA9cgAOZhu6fw4BKXHIcwt71a+qgqGUrgsAMKXS07shYYUunkB80bHQKJr0jgLkSpN8af2CFWMk1Zkmq/o6eCZJEIq0ln1EM6DwzBzYIvGFUc62HpFQR5X/oKx+U5IYLR42dD4r4qtmNW5mOlo3id6fYrXShT9/zYcWHqyZRIzVH4Ly0qmB67t9vneIUkdRUWlyz83dPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxmJSIOVMZZhvvGK8yX8a3H4S3q9aUKGumnmcy8MXbU=;
 b=qvagVzF1rNlyevkr1h+fJTenl30JaEdNUxSd7HRboySDGDWPtvLzq9RpASn0OIbgRvBgYX0npmRzSupYVRt5go66J8xVklgXvQB8WGpmy2aGrj5SFLDq3ZkxGMAf0udDC7Red1AW08nTxbjIw2HAuqmHqDpRuX4EyWSmUV3xjOA=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1426.namprd11.prod.outlook.com (2603:10b6:405:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 16:22:35 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:22:35 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/3] staging: wilc1000: use correct data for memcpy in
 wilc_hif_pack_sta_param()
Thread-Topic: [PATCH 1/3] staging: wilc1000: use correct data for memcpy in
 wilc_hif_pack_sta_param()
Thread-Index: AQHV8K7ITTVQLLkPjkS6GqGFdSMyEQ==
Date:   Mon, 2 Mar 2020 16:22:35 +0000
Message-ID: <20200302162226.4196-2-ajay.kathat@microchip.com>
References: <20200302162226.4196-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302162226.4196-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5316479-2b30-451e-a90c-08d7bec5eadb
x-ms-traffictypediagnostic: BN6PR11MB1426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB142602005BE92CA3D1444A9FE3E70@BN6PR11MB1426.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(966005)(5660300002)(66556008)(186003)(26005)(66476007)(64756008)(66446008)(6916009)(478600001)(6486002)(6506007)(6512007)(107886003)(86362001)(66946007)(91956017)(76116006)(316002)(8936002)(71200400001)(1076003)(81166006)(81156014)(4744005)(8676002)(54906003)(2616005)(2906002)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1426;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXHBRh+XKUFu/TCJ+Qed4UG4z0/SBrCKmwkARqeId8rtaENc51JijHAiBTsx6xpKhSjwm+L5c+HHbsAqxaVWI3G78POvunh4U0gCt7nCeshdvpgTNsAQRXnOQyBbJTWnwFLYVyCoRWRR/vLxKpWxA1Gu4mN9211Y8NWEDv1A7iPfYm0ybjE3FCQPoDtZ+Hs3uv816QwsUBuRlk4iMpHD2eZuHq+ch6CjjW4ZKTaCJZkYNVA+FYBMrpcMz2TIoWXNiX9R2z1os9+n7KTcow6xYukz0esZotIxhqYSc/sGHc8O0qGnB66yAhwuuXHVpn3hlvOit1/89SduOpafR8YGY2wfBypHyaT3zgDUTpYuiO+Lca90v8D/HqfqX6SIpi9pOsXnLQUGvYJb+ZpAbHG3B7wO12B/Ud/xTuyRvoe7J+iztLCvYiEbWSP2XXKz9YJpN3XHLFBKlCqM7Jb4LLE8viyxJNF/wWAVwkxJaFFZ7x1OrPePVvGSC+SZJ0AlnRU0PO2r7C8te1PhfxlLbzQhnw==
x-ms-exchange-antispam-messagedata: tE2ESaqgb+pj7D1X/wqPj7++umPtWw9farP4twoEggW7FLSF7RnZ+6nXBbO6UVp+XljBqPTlf8gF5z1RZv0CCV6s3pvMI5pvfhJykp30GvjW/b2e7GHamkZ9ArEz/QoRtGhUYow+apGgv+7q5Je+ew==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f5316479-2b30-451e-a90c-08d7bec5eadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:22:35.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tTTdfc+nOoR1b5qQrgD0MDepEQHd/RKRSIb8w/AxMfRyJohWYa/owyhXVQQcHWECAGWpGwpIowxZRsQRPdis88Ro5TzcMyGSId+CK4qJS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1426
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use correct data for memcpy in wilc_hif_pack_sta_param(). Its
reported by Smatch static code analyser tool as discussed in [1].

[1]. https://lore.kernel.org/linux-wireless/20200302092346.GA24308@kadam/

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/hif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif.=
c
index c8c41c2df4ec..6c7de2f8d3f2 100644
--- a/drivers/staging/wilc1000/hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -801,7 +801,7 @@ static void wilc_hif_pack_sta_param(u8 *cur_byte, const=
 u8 *mac,
=20
 	if (params->ht_capa) {
 		*cur_byte++ =3D true;
-		memcpy(cur_byte, &params->ht_capa,
+		memcpy(cur_byte, params->ht_capa,
 		       sizeof(struct ieee80211_ht_cap));
 	} else {
 		*cur_byte++ =3D false;
--=20
2.24.0
