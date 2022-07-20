Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFC57BAFE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiGTQDP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGTQDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0D53D34
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658332988; x=1689868988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cT6DPl2Q5qJX6hK8ZD0i8MBYsoD/JuCZXpqlfcnhZlo=;
  b=jfIit/DO1cGjj0rIWMS6hogN0W/bn3wfsE5LJoL9+sH9IeJ8Exx/oDnI
   8njIKa2RFNA3mE5+jzm0HEkBaSgKtzhFPgIcEghPtI+Y6MEQmSS/RCR3B
   ljrlBpzH79CXBT9ZjqiOYJ2kydOmBHYjksLy+x/wt2QnjQvCEWTC9QQdc
   iM8qHhfq/aQ3Bya4iYwN75Rjr/mIAKGAf2AJtFdo0/2SsP+EmOMYOiJKn
   YGtjJnyTxX3oozmzdOthyfGXrkx0hXSlqEqsfFjhP1nEMFoeeHyx8BP7N
   FNBYVKLlo8NmkQKHOcYWLtquk+Oc3Q2WOKcHyIrobF3E4kLUTT5/tbpVA
   A==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="183021447"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js04f6g4fkAdz3GtVurPH+acAKFsxquzsXk2LcK++p7gybYulITVz3JhOw2mf/pLUczk8cH/RY6hB62aGyt4nelNq7YXnlbSNcJalg4/3+/z38TtF66cnaGUR6TPQ4qD+4jdUiB7v0wJc6j7MzzCqhERMp1vAXEpA2UwPDqkHvM37CQusLiAOXvR0zrt3d4auh71281siRpP7fZCjEsCeGPMx/4N7hcnwhJDldn2E/O8gSQjIQq7hQmK83qE81rWvf9Be5bC55WWUUcAVOoavC5+GazzN2gK5n0TwHsEb1JumaB8pJbyAnUFK74mUs1kiO5HBGC5SDDA8lh+Ume3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/kZ4jKZghk/+2mlGr3b/S4D4RjPQe8PI2c601yaI6U=;
 b=QMfhYLD06jZhyrT7+/gxdRLIU6iflzgX76SXyAvSt26GkmPDOWdeWq1/o+lmdwL6KeGAeWTS8bhFq14yc0adw5j2qi5IBSs3LeNQcNgeAoUds/Zmz9hWUXcr4XUJnwfPHwjsFQ2uOugJEh9ANl1K+I7Trm4NrFLqE6KW3UQx0xF2HDlbcLkxSC3HnHYy0HB9pf3NqqmgEwYJViQYgx8jN0xi6mTZEdn6D3dKjN9hDR1w8QTA9sokHQj0lYnsP4d6rl2PzjdGoUMaliQATNXxyhNWw3xkjFsiOmqyaBM8FWWl5yytvmI17/EfFO7f9xlLTJ3Zk90JuMjMSlrs5bOuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/kZ4jKZghk/+2mlGr3b/S4D4RjPQe8PI2c601yaI6U=;
 b=vXw20Hj//1YIsbS/IN5M2NfdJJWuyHqeK3154brX8ny/1CDRqS05jfxvB1bDrViQW8TarCu+Go7KwGWGPe5Glnw4FdaYmoKuCWPnH1TORpxTbswNgYI6entB/tJWo6M4F+XaTJxig7wUTZyexm0ceN+waeP9OTqp5BoMb3cPqq0=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:03 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:03 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/8] wifi: wilc1000: add WID_TX_POWER WID in g_cfg_byte array
Thread-Topic: [PATCH 2/8] wifi: wilc1000: add WID_TX_POWER WID in g_cfg_byte
 array
Thread-Index: AQHYnFIxewSe1xi6H0yRIqDwxfQI2A==
Date:   Wed, 20 Jul 2022 16:03:03 +0000
Message-ID: <20220720160302.231516-2-ajay.kathat@microchip.com>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
In-Reply-To: <20220720160302.231516-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be8cf7db-a2c9-44f9-a95e-08da6a6953be
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67q+1J6g4CiilwzZU+wVI3FR4qFHDm8unCbEkR1pnKj7Q+pKJh2GJe1zduIiTnsA/nDBRvpVDsfDo502hfu9TBqvNASgx6ANNPGiiuZrqbJTMA3GxNQQncH2cPyAZMrdlHlt5hE5Cs0EwwkyNUWIUnMrJCPHc03OoHrhww7AdurW9c9iHPfJQch5JpyS3TUcDDn1VxK+99rHdp2Ex0U0YwnhZdqFTAkstzalLKm2YvYz/huBNbeNF+stehDdee0L4aK3/MF/nFZcacHmUDFr9Yj9m2xKNRofr0a2E0PkWlGys7wuUv4X23awBhDr4t/7n0Zvwyogka7dN20vHV3+z6ALr3uaRHPb7s7ckonus7DIdf9ln4BoeQaRIB/zyL7HhTF7TmYNvjhp44iGTA/CXLJgYFUHRtiwgaYQZUaNCc7DP+vsLDLLfcyZMcaBt4R2EPrwUHQ8xO8nUho9lpqLJu9AgNiyisUpXcHOQ7ila9OMFQQBwpwdeuuEkqFMA1E7KF7DjKI34P5PUiGDJ4qqcljC0t+fVf0Fvm7UvrFnubnV8b21TnXw7ZHIDDKlnTnruDv5Ar8fxaglBZ8hKEAn/aZrezjqHMs3Sv/2XdNsdZ0Mw6ny0rMIWhwoQTMuacpO/qFdc7h/kLX4myyANfovuFQ1WkL9P1D4aTnTBJoxK7lu3fTlxZzsoi1oKlleVivFXsqMh2EflNkSv10krtqXuB21K+i8bVFppu1Fw7U/F61u4kiBMQFlxbzCpXUP4vb43DnR90+1EKSLskdCgNeGHabPci+xt4n4W4nctVrFYS1Dh2/37hspqtBiKjnKiJq+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(107886003)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(4744005)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/UmpujSMYW1C86aZrbhHt2a76Jxg3hxZrdgBs5J8XjlumPRn4BDdutGyF4?=
 =?iso-8859-1?Q?H1EJcB1iyzt6IEtRrgELtfVVD6ZW2GiQwUNhcrd+bpqtrSO9/CkvFkqyON?=
 =?iso-8859-1?Q?ljZ81JSlY11O9XMyybM2v0Y/YLgmUqDlIBAhMjgl+AklRGXIf2ClqfAgNw?=
 =?iso-8859-1?Q?XQi0naaELmGKCvIpvYOz/N3b0sxFU2qAkwFK8iIGqfP+B/bvctrs97eKQ9?=
 =?iso-8859-1?Q?MzxsfpJOVA/cWN7599pQZNXNcJRmC71M6uhSSHUP1Cll/PHjvDFQh7AGW5?=
 =?iso-8859-1?Q?6v5rkPjulixj9pwLcC8exmMdfQwZNdiQU/LFFdzmFETwZILHtvHHt6+HuK?=
 =?iso-8859-1?Q?KWL/Bq+tPJp+JtcGSbTi6XGkNju+JHhNNbagOEyVE9qohZQ0ip3P9Zdba5?=
 =?iso-8859-1?Q?bUpgqfeOdn8aa4MoQoJ8UWHxOc3VI8qXcfw5+PGLP1l2uQjU9D0xVNBVtt?=
 =?iso-8859-1?Q?8tLef5ylO5zQFRioi1/isAdFSczNjh/tOJwgh7+wSJhBYyr7K3tOu3SqOZ?=
 =?iso-8859-1?Q?8ZOmfKFoJ6I5aPGIYTzfohRPl5x1cJCWP9hbrbN2JIcQXEAJ4C1vBLVD1l?=
 =?iso-8859-1?Q?MVvNI6+qhMIbGNEozqtQ7Xw/Y/e+z+g6mseIAdQEkx0/XosyZZYQsVVsWa?=
 =?iso-8859-1?Q?4THYtVCZp5OAQYDWfFJKEWZhiwUXz2MGfVv0x05QqjvTxwnnlbWLahwL6U?=
 =?iso-8859-1?Q?apM75uoNYzOIpL80LXzBd9+Cn3dEAMhR3/G43YvgGlOtLew6JpcxfXCcCe?=
 =?iso-8859-1?Q?yfeYR/No7GylO13ypxTtqiCoqvDbKmSNf0WG+nRuOgRmXyF/MtlPXkWf87?=
 =?iso-8859-1?Q?JlS6Q2kFKA/rHrQ4RjAlpBsizIZBCueJCExiBJyRPSfnhCAbP9EmQyRXGU?=
 =?iso-8859-1?Q?XGyztJyFZCur1tofdK2LwhPvwBgvM+HSXQb4m7Htu9mNNsL+WFeJQYraA+?=
 =?iso-8859-1?Q?z9YdE9PMi0hSDKYFof3r5y4OWA3dhrnANS+oB0C5gPPBk9sjapqVUuWAJB?=
 =?iso-8859-1?Q?BNkviIV2mmNzDt+ITTkZvNZodJGr/NLIUlJofQPAZuEfb9DU5wXEnLtoya?=
 =?iso-8859-1?Q?NCunITYJBEmcaxJIayP1wVnRtv2eDxe8ITnaiMioSQBKRSw4Uhfxk9Lsw1?=
 =?iso-8859-1?Q?OyVUdIhD3CHmVu9KCn/zZ77MjjH2vZ5D1u/nRUhuHHRpQreHgx8adOjzIp?=
 =?iso-8859-1?Q?wggJH2170x3pCMGNVBQBlUQPGRMoBKZ0ScoqqPNFVnfzHgVJJjcle7j6Aq?=
 =?iso-8859-1?Q?guwldyiLpO10bBeUabATR+QfdGwOvMEp6tUHS75NRby1xehYNAKHGx6a8s?=
 =?iso-8859-1?Q?UWQK+dvOkVA/bpaNmU8adJkZmWZcl/fxetmzTUG8p+dPcj31w+DVw8U07b?=
 =?iso-8859-1?Q?/iOD53Y/2PUoZwVzYlb4x9eeGq6jozMBGMvyweA2Gn328UqlLF3Aj0h1IY?=
 =?iso-8859-1?Q?YLLyi2LvQ6PGglsiHJmQst+D4z3PD9UxAjhEX5l8SSFA8+m9PBoe0Q6J20?=
 =?iso-8859-1?Q?2Hzefknk3Q0HivyizGD50bp+8Nz6JFuK+fkILYob1YBX/C1tEoxd9RFUJk?=
 =?iso-8859-1?Q?Uj76oDiWdDTA2F9ExMeR4UM0LzPwVGJ1zrRnDSUavl4wiaWwOUJQfFO7gD?=
 =?iso-8859-1?Q?ExeuR4Wx3xDJSt3p3wAGsIrHaPWxzNu7F0ls8V7wG1fq/STVWV+O1ZbNfc?=
 =?iso-8859-1?Q?yncESoAkcQTOnv+U9yg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8cf7db-a2c9-44f9-a95e-08da6a6953be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:03.1698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvHBOKEr1YWdD5fNewRGFNMTEa7A5GXULWsiHVDOOAu393cCsYneMuxtBqEr1JyQ6c6mY27ZwsFMj7BQiTPcS6dbpqSvICd94vnMQ48MpkI=
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

WID_TX_POWER WID value is fetched from the firmware so it should be
added in'g_cfg_byte' array to store the data which is received from
firmware.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.c
index dba301378b7f..60eaf62fd164 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
@@ -22,6 +22,7 @@ static const struct wilc_cfg_byte g_cfg_byte[] =3D {
 	{WID_STATUS, 0},
 	{WID_RSSI, 0},
 	{WID_LINKSPEED, 0},
+	{WID_TX_POWER, 0},
 	{WID_WOWLAN_TRIGGER, 0},
 	{WID_NIL, 0}
 };
--=20
2.34.1
