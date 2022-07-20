Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6992557BAFF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiGTQDQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTQDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517F53D35
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658332990; x=1689868990;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0SQtZ/+DuPmROF8zeUo9nzHxl+baO0qUYdbF6SCIn+Q=;
  b=NqkeW2cLj+Tl0lI0qmdnrPmp61BZGBoIoXHneZ4QeAmLU9YLKwC6hwi6
   EsalgEon3weQktz2GVlTAjSNMyd/9j7YkcjpJPYLcIz3aDxOQZe2P/AIe
   LsnAIJzJOHoPoXzhTxO7TmQqnVXMX0jlqkzC40H4LsNcnvSC2NxFUV1/6
   hZcJBkdQKFTZBtDBp3rnzqC3oKz8640XIjBcc3sAu7rF/L523Ge/3DpzJ
   mkLMIsafccUWfy7cxkVmwnTr46Dnti0nsmFx+E/0VEhc/ffncyxoaKzbF
   BsInWPJzKvbAN7PfLyo0PyjlSuDU3Axrh0OHrpgF0v7jCqbxHLBDynkaq
   g==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="172930028"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4b2o3L9rQaZZgvGq6M+PSMgN+aVfYg6nh35QHUtksEm3BP3u/+PkMm+ph3zcW3gQH4oyBMD4/zLGQTRRTPuY2hD1gzDNYfems6tCGRP8z78rS0HYgHKhLHEXMNEf/l0kJw6E1v3eVl+FNEPHLGHUOpCL9jF3g/UNw2Z5gipbzMSc0FAQrwJv+qrpc0eRobdAAsGaOT0+JKXooHm9R9taeQXzByzpO7upHsXJjhpWD4cMSDkw0ZZT2SXgP1T+p0HgbrkelmSfqUf+Lwt82m0NcWm04WvmEKe+dcdVl2j/cLEmKpp1w81gd5De+p1yiBNE82dYJWMHtt2d4JwggWJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReFynCsTL8Qa80XUpBXIAQ1XNpmQWv9ucg78oJQW9r4=;
 b=alEg0UUeboUbDQvMl4WUhSBtYjBrkG/fhnUP1g+I1l3jrodXtFO/LkBZF6jJx/ZdzYjjPaIRvyFnGFjrNTnrVVurY43CejNvjScgz/HV3LEpHK30hzOmm3uRwy10WtvaX3I96IfI6KJu9dd6myA3muJHhfOYbeIPIUxKQo8LD2hxL4amsxYsJS0ofrew9qzZQVpb3HwLsIhvRHRUfrw/7LEyO9dZpfqn+HEdEikwVtD0iMr1hQ87LeE5SBvilT0DVePivM1qCMnKoeVzQ01IB2DLY62pQcLPU7sbC+at4BRiegGDProxqjtxJQl7KOqUCika+mr5KqPnksUOhPflvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReFynCsTL8Qa80XUpBXIAQ1XNpmQWv9ucg78oJQW9r4=;
 b=nRxrdVaAHzlhnyoZ0KOP9nETIBLB/ydFU+X59ph3Yp5ma8yl5OSIWs6TUeflzrFoVz0YHvnG6IWAdfKhVbY9jrpEr0oO6KN8rItTCXSRHy981/ey/jVQqqmaTuvE8vSmPbFDNiyaswPMypEHTl+GvaANWfRdvJT6DB6odfVAVDk=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:02 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:02 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>, <lkp@intel.com>
Subject: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment sparse
 warning
Thread-Topic: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment sparse
 warning
Thread-Index: AQHYnFIwX0T9qNvnekGY6lt0TN0NsA==
Date:   Wed, 20 Jul 2022 16:03:02 +0000
Message-ID: <20220720160302.231516-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5930830-fb24-43a8-358e-08da6a695334
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SU/2Iom+Tpdff1B6SWc8U295DMf/jW5URt8oQqhKvCJgY4FjCdVNF0hoTIOQ/m6DZ6AuLutCTcEBTVc+tUoUh/u+jNc7fSB5yhlZH0xxNfWQoFlcssoD6pkdXXBuwfVEJfnNbFqLZIIkq+U0hL/jlniMIdCntaYHOQ+QpqjlQ9ZiPN2JwEYSHT39vVnvHxs1FXHBoygAkK1SdSGibTiAliEwQEhy1rdJI2WPNL3bvQmmKF2JjNXtbQQc6vguZPGdI4PR7jSV1w/m5U3Uxq1kb/tkA6FBDhA2kwEzAqov1v65XfV/8EYGjEbjApBlQmXBr89upoKw76ui+nPRDNKcdAyqLPIbuTs1hmXpyCPmHYPzymeRmIeNHUnKgmp2x9BKpHv7LO0Ms15NZ7Pyc/K9qyjiOE4J1sL1Kkb8QIQb0wU3404ENovOwM/5b1lbvcfA7dXaeaTN00t8esotXYqf9cNX8j3bYRpAw4U/CU+PodwokKQdIsiR9VV8oNc7ka3sdv7yROM14yEpGDA9+CPOUgBT571DzY5mfeCujMy3A/k4Y/W5As3fdtKyGsefA6NS/f/+jI/a7wSj5hvk4byxtIQIboJngVFYSnePfykivQ9C3AbCrNtNL0G9/+eib5dTeh2TtYpv+lKLj0V30cx6bs/M660uYks9rfdLnsdY/E09vo48jWLYGMj7qkdonxT3jCtfBQk5KAPtLHpVByTYwPBh+gfDG6OezrTlxmDkyzIaZIBtLIyaDX+skflysb/wsnMvYCs9BO3SRUowUudPXM/VEiA+CNHyfeG6zCoQ0zQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y6qCvOCOWUMWEyjy+rT4w8V1aiIkc2fked0xZHGGq16jBGJJFaw0Le9x04?=
 =?iso-8859-1?Q?fBkiKjA6BXjazw3Un90Nn7Y+vCSzGcJQSaj574/x+hZVS8AcI8vZtUs2Mo?=
 =?iso-8859-1?Q?sfxd3ZYE9hrMuJGa0cyiMYKVysq/5VRpeTQ8CsnhTUj/J8KxOhW9t38AOH?=
 =?iso-8859-1?Q?qjjt3RA1CZQARVyyhR6iWpwyimRarGNxG/7DIRd4Q+wdsZc1pOSqxqOiwF?=
 =?iso-8859-1?Q?VkRkXrPoUlakTmYkFtMPCje1o5np/QxC2J+/XI5ENAX7RkCx5B6ow4RLna?=
 =?iso-8859-1?Q?XETFIrTf7KxWZYzxMthoutyBCsh5uENKNqsFrHdsfcM6Jbwkh3kUJ5ey9g?=
 =?iso-8859-1?Q?vndgCz3Yc2TzwGW9QJJMDpXvl3wV53VhORjsE98tFkgQQla1Y2ssgiQb6F?=
 =?iso-8859-1?Q?eIB9tYXWhZXuHf6JGt+v3zoLeWoKq4ZwB7BZXyBUrJ+QvyTgyXHuYiqO/W?=
 =?iso-8859-1?Q?YXAsRWAI29gl2XzOkM/92fbDkptAtsXZg3SA3uOlqrdwiUb4QXqKiVZ04O?=
 =?iso-8859-1?Q?JCBP0PLl+y2r3nUhiFSWEgbXwp1dujBBZ9SVmjj4aLRIqJ48RnndAfnbZR?=
 =?iso-8859-1?Q?2l1jHftS46RSy9aJAkbxcnAWsVVyQ+ZrdL4hkP4qyAaNoxsmK9eYXey3IE?=
 =?iso-8859-1?Q?NsX4gup7sG4U3IcWcKBZR6VmmB7fOlt+kv/zjt+c7sBXKPbBjLYXIhIgfb?=
 =?iso-8859-1?Q?0gJj2KY0n6G6nf+G2RuyFWS0HeqBGykIdTfrrFp95LMVXioYK69jIU0tTx?=
 =?iso-8859-1?Q?Rj6zhxKvGBQoy51P+F91gBgsqpTdAVhYXH0dVrekoz6KhC+6D1JAfD2SfS?=
 =?iso-8859-1?Q?976qJyBmO99oLJNGZ+Uu/kH0NOw3FCmTjX+nmo1ud/0wLevtbt5exqpvgW?=
 =?iso-8859-1?Q?8HacBGEL8Mfc9akP+xnh7tjSFXH8j3BGG9jfA3yTy/9BTrGqKVMmVk3vPc?=
 =?iso-8859-1?Q?G0KYI6d7Ya07SCCeVWzZxDMbhU7IzpSP9+rzm1/+l+H/YZ8TVEEDijLfh+?=
 =?iso-8859-1?Q?6eE4vISeDDhvQ+fHZ54v2Id4W+dK6fm84Jg8XdgB3fq7sFrPtTaXnCwLQL?=
 =?iso-8859-1?Q?vXHTXycNL0CqI1i+ApJwZ1L1lpFMi73UWunB9uLUiGhgkUC/ErpMY12Cj7?=
 =?iso-8859-1?Q?aztuHN7z29RiaLqvaBOvTv6xWcu/fRMfaZVySnal0606fS6Hw9aj97eq05?=
 =?iso-8859-1?Q?Ccy3+w3naNG1R1y2x40fidyPGeG7nTU6njq6lmup6wfiU5fJ0cjPhL8sP7?=
 =?iso-8859-1?Q?8F2z6ker/NpDtZsac6DmJg3HMenBHh4wJKVdPexzkrideH3e9A289IQoe8?=
 =?iso-8859-1?Q?xbNMuvZYnT4aIFfA+0E7kF6vMT4zHI/2QihEafVZH4rwgxWUPPGZ4TqJ8g?=
 =?iso-8859-1?Q?bv+Fkl3A7Mkd0PkhoBldHi5CZ8tlQiufNH0BgU5DpvGT0ubGQlyB0V6FMq?=
 =?iso-8859-1?Q?dp+YzQzxUoosqb6F/qAF/fEc5sfu3WNQxbkDzSjEBjP/QztbiRpAuY0Yzy?=
 =?iso-8859-1?Q?oqrN3isNCjh5WIQ3rR4PqZzn0Nkk6iWrE7cFjpSZGDFYxdO0y9k3SWe2IT?=
 =?iso-8859-1?Q?VSoGwFNNkMVecmwkHFqX2asLzpIEyhFKhnkklwbx6nCkkJr2cuM0Kk8NQg?=
 =?iso-8859-1?Q?yNh7vp1k4Wp4mP/OyjUVemfUGmmePRbooBhQiE/mHv4wL8KwE+cAJf90d2?=
 =?iso-8859-1?Q?PgpCAl15SnqTFt2cyLY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5930830-fb24-43a8-358e-08da6a695334
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:02.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEQc5D6ViEou0oOUQyz+TMQoEuGvAr/Nl8KQwieCEwz4AqVdBLwFvJZR+BYI1ramzJVPtigHxOdXB5LuOjfVZy/1y1D2Ty0+k74E4P58m8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Sparse reported below warning
>> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: spars=
e: incorrect type in assignment (different base types) @@     expected unsi=
gned int key_mgmt_suite @@     got restricted __be32 [usertype] @@

'key_mgmt_suite' value is expected in big-endian format. After receiving
mgmt_suite value from wpa_s convert to cpu endianness because the same
value is return back using cfg80211_external_auth_request(). Use
be32_to_cpu() conversion API to avoid the sparse warning.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: c5b331d4f550fb78 ("wifi: wilc1000: add WPA3 SAE support")
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 5c2c7f1dbffd..19862d932f1f 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -359,7 +359,7 @@ static int connect(struct wiphy *wiphy, struct net_devi=
ce *dev,
 			memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
 			vif->auth.ssid.ssid_len =3D sme->ssid_len;
 		}
-		vif->auth.key_mgmt_suite =3D cpu_to_be32(sme->crypto.akm_suites[0]);
+		vif->auth.key_mgmt_suite =3D be32_to_cpu((__force __be32)sme->crypto.akm=
_suites[0]);
 		ether_addr_copy(vif->auth.bssid, sme->bssid);
 		break;
=20
--=20
2.34.1
