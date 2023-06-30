Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D802F743235
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 03:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjF3BXy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 21:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3BXx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 21:23:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50A2952
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 18:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688088232; x=1719624232;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Gtt4Js0sbxawMZoC9hgdOjPUE4tOBY97SMh+0gZX1g0=;
  b=tz/zP3U5aRW99PziI6ZdKiI7QehAn0N4ql41nP4cN6gJa2oYZE6YSytZ
   Th0YEQ9OXyVdTkKK4N9DlLrFQK8o3GfLxptBf4S/kalwENTHC319C7lys
   mHSQ4RJLUvludxR/tZcgW0OfDyDDlf8gbmJEWlUGN8dJSw7tUWw6+IM4X
   MaV8n81YVfo81FyWdijf7d2ZpR0Eq3bG60wNKWcAWRPPpjITp1ewjTHE1
   3KfLoZkCEXVQm3Qx7g7IqHU3+W9eTQx4U4UHvlSnRIDv5Unc5JvaxH3Fc
   C3anMhXJ7VpOMCI2ybgK+ICTmW+fqsu1PHxWLUS+qBmessQLod2/tn1ZQ
   w==;
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="220612907"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 18:23:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 18:23:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 18:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M60UoVMjqn1JbvOVfPWTGQ1Vt6ZpDuhB6QyHKYkBil5iBAIMBDicIdarwYIgrKH382/4aNvYfMB++zuIcph6RthNMEJT2WfnBRfi9z06XvghX5Iu4S41LiHirLmpZaQxDRhjyby1bTndrDTRd+olJjVoe6RyAutswdPJvn4NzrTocNxQwnAn2t3iaglzYuLA6XpuJJCLG1lESBVN8bM2+hfhbK6hOeMGxJn02tpIMcwgCX/4qvtcf95DA6xe8KbDJRfVTzTjmQXOAFqNkDqYyYUezI4ilOa+McQ6Wva+KWSc1hRzp4jheQvdNpUjW4Txq8IwfPwLabwRlFXMOpjE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXCz6mSxaYV1A4ModQwFsFZeLhIKXyJp9NV4Mx0CVEM=;
 b=I5RQjHRpbQfraX0ih9bWAc29lQXq4vYO1SaDTD3XFNt9JppPa0jpp9kGaGxtVnX3R5iowv/XxfXbmVrrf3+AL+A+ZdvyhcX9xBTpnHPkTh9enCZCKOERj8PZQnfu3RLZjCxslda21rT5UOBc/vXQJ/2YcILAbvLtxUayRl+a1pl9GFNX7u4AeMzSxCaUHteLfy8ls/5+qdb8Zmhw7EQL5vmMoYDjsDN0SkZA1VjwiKqmLem0XqIIbyXRbqdvWyfHpYXyU4Zjh4TArwIGcWIt01VXrFWPrzPjkAyJE4ndS+EpRFr2dAxHzGMrHaklQZGOZ+vOY1/u981Mcu+DgrmK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXCz6mSxaYV1A4ModQwFsFZeLhIKXyJp9NV4Mx0CVEM=;
 b=hil9ZovtgYe9AHKPIevUFgeCGqThMsPCaIBtM8XtOXLSESd0B8J3mGuKgvAfuJejXWOU4TS2AXweYNY4riESL8gqIGEFb8ttLyzHvvqvZ7UqfU4uSBsXJSYwSXlPE3y/dTloK8J+tUAPKNE5pmydv7gn62w/0gb1l/fi7JW1fjU=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 01:23:50 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 01:23:49 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-firmware@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH] linux-firmware: move wilc firmware to 'microchip/wilc'
Thread-Topic: [PATCH] linux-firmware: move wilc firmware to 'microchip/wilc'
Thread-Index: AQHZqvGGefcKnm2dVE+FaXjeU6nytA==
Date:   Fri, 30 Jun 2023 01:23:49 +0000
Message-ID: <20230630012333.1331143-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SJ0PR11MB6743:EE_
x-ms-office365-filtering-correlation-id: 673f70d4-822b-4cd6-5c3c-08db7908a890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRkM1889G9ydr9Ux+ZgpmzDqFFLutqBCLGJd7u+GIyJJWAOrXqxlHSRbVoFqp6QYuI9RTzJ0LeS7lrh7q2mdWTGyn8YKazJc0LjPwcUbhjduThvGJaFl/ISXed1tMdZjJTCNEir4zE85qSMxQx4k6CXZdnqYGDO9Vh7StBaml6OPJ/RRVyAoKhnStL9sOxyQX/o26wCndOGOHM30WFcVBjJhxISJJKqbtakbJVXHxhoyULkIeMKk8bf/VOXhGZkz9G1m0meedH78EH9E0wAeFvOSi9dWrx2k8kGXMyFJfUAy3JDbqIZqF8HcwVev9PF01LjlphrwTa2T3GtopSxwglRJ0BOZAdmty6U0JyGux8qhK9YcHDGrvpXWeQ0VEps6Ec0yFaOTfTwDcdETNkXpCR2/qwNswXxusLS09OY6ehUbgoiVz853w5AuOkbOeqkLtV2XwH4mMpbxivSKYoHqZbonNMhYFck3QrnL37ZjqsbY0AdNdTIeBFE3akk7d3dtjlzDW2pW/eaMNjnk0LtvuSrtklL57o/U4nJWkdhDQYsZV3sjEHA2EWf8ba4wNX42G0pqIo4HFi3cksXgdzoS6SnlqvS7fMWun3L1ND60hG0i50PVEqjuOXE1iWYohKkT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(54906003)(83380400001)(107886003)(2616005)(64756008)(186003)(478600001)(71200400001)(86362001)(6486002)(91956017)(41300700001)(66476007)(66556008)(316002)(4326008)(1076003)(6512007)(6916009)(66446008)(6506007)(66946007)(26005)(76116006)(36756003)(8936002)(8676002)(5660300002)(2906002)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ubAXhMq+bBcoJ8Ojpq2V/H0lsPbhiHkCXfYpILrwdrtl+S1CfXxhcPMPw1?=
 =?iso-8859-1?Q?ocDilxPxsC6Umy1DWSsxXdE6EwLa4Ye8u31DFRVDC3qWK+4fmANX3rFmP0?=
 =?iso-8859-1?Q?8GyL5ps4wAzDCv+vZIR+2wnN5zduibHE7r0OlQRac56sgbFVQzXxMivCdH?=
 =?iso-8859-1?Q?ywolRBGZxRX724gDM+efJbrgjBkTnXnjPtfc5XnNuuJachzacrPl5gK3ot?=
 =?iso-8859-1?Q?ity4q1Dxotyu1F6TyjVQvDLquq6I+Sm+AP0lq6KAPTA2k+EPBwwFzFOuEc?=
 =?iso-8859-1?Q?S+Rj4bI99jfQL2n/pjFYQziKeZE7NmlHQNFdtTwgv/tp98o9C4R2WI2b6K?=
 =?iso-8859-1?Q?W6Awt53t5E15x34852z2JtpURQLBK8XX+9xAVsprRNvaU+8gDYEFzhZUdG?=
 =?iso-8859-1?Q?OGG3pT+YSQXfjRAxPxDF5GmjQzGExxDqkeQVm7ugANBrp9YxzuWQa0ZeN9?=
 =?iso-8859-1?Q?OWuFxQFGvBfIgWWlpgj/JGUpNkOvrlaH0qJW6JyjNJb+G6OCLxyGkXPY+r?=
 =?iso-8859-1?Q?C6i4XLe3bOGgB1XtZ+SWn4KRV7XqaGjv7Ee0uefSzNJKvsCNOzhxyG4pq0?=
 =?iso-8859-1?Q?cpu4bq4MwXlWmyXdIAFpuYFd+GruO2zDVJUH3MY+Xyd4T+cC+m2BdvHJyz?=
 =?iso-8859-1?Q?G9LQr+QJt+jIVndjdBT3gT/o5BDdafiF03bRD433B2c3wjB57zoqrSUQF3?=
 =?iso-8859-1?Q?edeOMlaFzuUmTEuHBeume2xGv34egfXIIFgyPFmJ+EI121XEwYjuQWymv0?=
 =?iso-8859-1?Q?9bq3PkXTEfBIDUJSdT1jHgG/nbPK7ExMjJ/psIWA6jbyauBYzOj2jNyjzG?=
 =?iso-8859-1?Q?e5ZD/ftXOwXQUf29wn9yQ+RdzV7Zlpuw8hxWRlOAXdxtEO0O7ayOVgfEeG?=
 =?iso-8859-1?Q?G8keWdsJ/p9zLb8c4ATUrspN13d/2s+euwl2LdlIEBEZJTznEI7e6Agk/r?=
 =?iso-8859-1?Q?A2Btc0m8JWbp4Ll68+MXmPmZz6SW3r7JuytpIYwRWWtXw6OZOTj4uGI6Jd?=
 =?iso-8859-1?Q?LBZzBjW7GLi6A56Pv3XkPAuLdqXRbgKmLYKlPzqS8NCQqZlDiGqy6epKNX?=
 =?iso-8859-1?Q?EeslRd4NHaNuvwszDGOOkRd9CPwPaOkCo6ssTsGjEIIwdwaMdPsGVeqHjG?=
 =?iso-8859-1?Q?LUsoYkJohXf8PthK63YLmDwS3E/hg2k57oEo/Yc7fgtkxsTfMNRh5kcqzZ?=
 =?iso-8859-1?Q?sjJsjByTBXB3y6YpnDy0wZ/CBBxMW6ADex/nQlZh5gBRCUWiGr3J6oLOL+?=
 =?iso-8859-1?Q?h+IpzFLAVtRk6dE8W2am999G5F6om0H2K5tlTl79J+F/M8UPShgq8tFJeI?=
 =?iso-8859-1?Q?zyST/+w7fG15o3ZNBgyNCKZXnWtqJVvQxaMaU2SGxEJp1CYGBD0MZs9g1F?=
 =?iso-8859-1?Q?gCve1mM4slTWzlHJkGUaiHBojTOvMY0uRqx1T0Dz2R1UqeC/biO3Wt+Ud2?=
 =?iso-8859-1?Q?1lLXx9Dcu5lsP1sdIcqgCxEUrACUd3u+Q71hd2odaNbXIhkA+mCMg44kVx?=
 =?iso-8859-1?Q?mEi/2VTC13Tm2yl4HiWKefNxo5bnYiAMs3r0TqpA4IOokPc/T/A0yQmC8B?=
 =?iso-8859-1?Q?AmPs6+jmlDGXXb6N/klY4l7tMz+xyHbWHqnI83RbWd2IrbGBlPgD59zqz5?=
 =?iso-8859-1?Q?PX2inrDa70S2n23/U7oKHHqu9cTGBXIHA13BU53QEJvOoZ/azW+PQaPw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673f70d4-822b-4cd6-5c3c-08db7908a890
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:23:49.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuZODRW6yi/5Cec79DpuvQRdXVqOVQYlS1/RH9BoPXJt7ZVeWYEclx5cMUVoL8CsPvoD7cx8RycDnuSqaP2kobdzo6Evn9d5/JCcMENn49c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6743
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Move the wilc1000 firmware from 'atmel' to 'microchip/wilc' path.
The updated path not only helps to avoid confusion for users but also be
used to keep microchip's other wifi firmware files.

To maintain backward compatabilty, the Link statement is added for existing
'atmel' path firmware.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 WHENCE                                              |  11 ++++++++++-
 .../wilc}/wilc1000_wifi_firmware-1.bin              | Bin
 2 files changed, 10 insertions(+), 1 deletion(-)
 rename {atmel =3D> microchip/wilc}/wilc1000_wifi_firmware-1.bin (100%)

diff --git a/WHENCE b/WHENCE
index e6309eba..f38bc980 100644
--- a/WHENCE
+++ b/WHENCE
@@ -5136,7 +5136,7 @@ File: atmel/wilc1000_fw.bin
 File: atmel/wilc1000_ap_fw.bin
 File: atmel/wilc1000_p2p_fw.bin
 File: atmel/wilc1000_wifi_firmware.bin
-File: atmel/wilc1000_wifi_firmware-1.bin
+Link: atmel/wilc1000_wifi_firmware-1.bin -> ../microchip/wilc/wilc1000_wif=
i_firmware-1.bin
 Version: 16.0

 License: Redistributable. See LICENSE.atmel for details
@@ -6324,3 +6324,12 @@ Version: 18.99.1.p154.40
 Licence: Redistributable. See LICENSE.nxp for details

 --------------------------------------------------------------------------
+
+Driver: wilc - Microchip wireless driver
+
+File: microchip/wilc/wilc1000_wifi_firmware-1.bin
+Version: 16.0
+
+Licence: Redistributable. See LICENCE.microchip for details
+
+--------------------------------------------------------------------------
diff --git a/atmel/wilc1000_wifi_firmware-1.bin b/microchip/wilc/wilc1000_w=
ifi_firmware-1.bin
similarity index 100%
rename from atmel/wilc1000_wifi_firmware-1.bin
rename to microchip/wilc/wilc1000_wifi_firmware-1.bin
--
2.34.1
