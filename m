Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BDC531360
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiEWOJO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiEWOJM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 10:09:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB7B43385
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653314950; x=1684850950;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=DGYy6pWqRpWJayPSAm4jMGEeasBD1ITm4BDm9LKSWG8=;
  b=WZ9i/bEyU+mYzv2ezQvIPc4t6qCXxXZdF2hO5aIqNYPpRdZPbqgEP+Do
   9eQhQu/C04rzm6rBdyVSVKo52SfcaN9MiC9E3+s5SunSGIeXzWy/ZITrB
   jr56ZiXDLFB60Xj2R3UvMELarHfp+8C7FV9OmQ4BcyWqnBkA6X4vGTxT9
   2fWbkJ6EdanlaGhzww1wKoJm2mAbsf/QtIPtCjAyNlO4rQF+B+SxBQE2q
   I+qbiTZd7cHPKz1GcnqkFKJ+U1gR0NVjT7wQ3nzoGc+rvLMKHwxwDD1bk
   D5MVO6Og/ZbzrSc5Ng15Lew74w2miUefZDixAcAUJx0uxtypkXM86T+Tf
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="160214877"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 07:09:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 07:09:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 23 May 2022 07:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlefCuPaAhxbpZSbrsK7nfXmIB+TyjcDCVjJGHfloIsARGdDpLQ+Qx/iLV1s2cUBAATHSCZv8ZdA8gtU/Hr/uY5oHxIoAMdjE4f8mqCEWyJc5Da5N8mLz4xaF8IFsSGXjDVz3iM1lbsDJfu5QodBpo7W4sv1seTfRi4BYyVLiA/prnizDEnNvZ8xA3l0W02E5U4xXNv/2cTnevXM0aLhwJSWgjeFfwyTc9X9lQJ2e36V56RQhXHaFzJVhzo2bmCtkTq5lvOifXJwhrXr1pW9wfLxb+nh7unh7b4d10tlyD3rOPquVUxlh3/fQxqrgkThkAivoCw1IuB1C4Jfm2oxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osrhlwpEFFhhR0wpe1YAkbvHKhLHXzcBTB1i7NRwLIA=;
 b=lHj9QdUoBBY9U9Y4e2EsycgONSFtiTFoj3BEtKGiNlEZucVRTWMTdlYs7x/Nry8DaQkTNp6Nc1C5CyhPczMEZnMzN/LUMHIMKFVPlrhSv+bEgJSCP+/kc7TJoVEpy3taA94KoXc2cFTJmU1eByZ8CjMfjRJP5JoIQIKkuhyNm7U4Eyy63/0NjVYi9UP3YrIHj1lOh+C4qyWRq3sSJXEAATPaoCyRFtKNUxMFagcTIUO6oE1eGaUPPKCdLbRft0inmeYk8//2hM54q+uwl1Yx1HWPl5KLpPf3xapwF/6VYWaQ3hTEAU+PHAB+nVdHc+u1nJQNqtvCZG/K8ksS+bi2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osrhlwpEFFhhR0wpe1YAkbvHKhLHXzcBTB1i7NRwLIA=;
 b=mrqzhiuisR4w8nCfZS604pB3LB/1U9LHSskmOGpqtoEk2Pw8Z0pUXZOUui/VG+Wq9+z4Zu8ECG0JAFOVCnRMQhvORaELRbov2hgGFEjKoXMJEBQ3Js02wmjhbFGi0NEtQpCnt2yq21zndEZEYGteytwly6fnV3Az8SQTwZU0pno=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 14:09:06 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 14:09:06 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Topic: [PATCH v2 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Index: AQHYbq6p2rJ8Qd5opkWdRD9tXlXgEA==
Date:   Mon, 23 May 2022 14:09:06 +0000
Message-ID: <20220523140812.164028-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34c7ce09-53c3-4b29-616c-08da3cc5cc6b
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB560041B377DEB8A46275E791E3D49@SJ0PR11MB5600.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtrdsW7aUE3yDHczgidvNLgnslADqnmAwnXKZ/J8LEW+Af87YOIQGIXxHsjfiOkpyxklfKapgLebwx0NzftmZpQQhrnGSJE3EXbsv+G/Dxi4koqrtiguOpe3c8nynPYf1PilYnfoxbfjL5VslqPdbizHWVFeISQHGiY9NyGegjVYnnebPoL1+sE51s/fucONniwjOIZUVGeo8t1dnEJTT3OPSES7pSpLDnmzUj3OZdB5qiqHZuN8Y+8gdb6R/FfA7P1x4XM0gzjlCPI/xjy2Pk7SWbS1xAkYhoxbMQbPfaz+CiEx0ztQOFfjQuZxPPdQJcqGS323RlmJvgchftpcDVhZ6m4UDUXvHXix3CtbFgOeKV9cnHCZsi1OL+AN+gs7Ck6SsvpKJJJqOL0Wuj9OKePOo1BBwswZsxBhgCp36x6kc8im1Uea+iw+xsjy0hBEi+A2DsmX6MtCNjvUB5dGt1qlgsBdc/ZShoI6vCT2bfalvttZHZhXASgd2Wlsh+zy1bmadsBYD0mINW/G6DGoAnpt+XuMTAgKSe7Twc9cZaV3hwDEDen9yHuJv/UECBlrdmvLA4ff/ggSrIiU3uNWTkenFm10cg6+pAGrz46M7WgULiUw8U6AH3hJg+WVtNcyXBWKOpV0LtcLvBqEvjs3BYy+VJnJFk7QEpZKCiEzi6SHnXKAClHVd4IbDu+9NMiQdTYKfaD9zDDppT1/fi0RbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(83380400001)(76116006)(86362001)(91956017)(5660300002)(6486002)(36756003)(8936002)(508600001)(64756008)(66446008)(66946007)(316002)(8676002)(66476007)(66556008)(186003)(6512007)(6916009)(122000001)(6506007)(54906003)(1076003)(107886003)(2616005)(2906002)(71200400001)(38070700005)(38100700002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fEDqh0K1yVF68OpH2iFX2j4FMN54Mz0AGqtXfsHvmvNUeOjalIm9+rzu1i?=
 =?iso-8859-1?Q?EvlGq7LEWMzPMWK4sPIfe+hVXJPFPCodJcZ9ZBCNVqSB7Pua+R9DbS/N5O?=
 =?iso-8859-1?Q?2QfCYwI4hZ4ST7BDaWeBJec1f8hM855PXUreM/OnT4xiDs5kP1jqtQGpDh?=
 =?iso-8859-1?Q?ceT0YP3syZTQiXRnYMpGRQ5XmB7CBfSKgg0GeXFDLA2gnS0V1iOi9XxRNs?=
 =?iso-8859-1?Q?fJWo5+gRu2+7Xp6ZLCC6+8VQ3q9LnhKTnSRhHxoELrvo1a7J0vDbbVahRD?=
 =?iso-8859-1?Q?cA3hM/QAUm+ROuLmhPXHHEnLQaHI1uddIk5ffO/aC1tm4ZkZ0kq4qbLlFV?=
 =?iso-8859-1?Q?ve7UQeXwRMzlwrR55ZOs0+mXn0JskYC2FFNnMVBJBtZeKaKDN88LHPRzuL?=
 =?iso-8859-1?Q?KH8zpkdWuEfX0i3ukrxSeqdXzOhWmH1/0rZXMX2Z4U/BS9epndtgfB6IFb?=
 =?iso-8859-1?Q?uqgM8J/IT+HvZ1u2VCuHjCe+mLtJ1/THETrfyA61krbd+qSLcUaGXRjMRA?=
 =?iso-8859-1?Q?nVdvonDL+SGXwKwpD58hwc6RfS05BhQV5EFfSu9o1njDqZSMezzsicvGay?=
 =?iso-8859-1?Q?bfqogag7ZqfVmI3idSeSv6fhfTHsr8VyS703gEZ2ssv54x23WMf9SFjWMW?=
 =?iso-8859-1?Q?4ATSJ7P7xrsRbR44CPOeaLgCvqfJAGV+uQVw/4Zb3gofEYHe2KuvdnIkPl?=
 =?iso-8859-1?Q?MV7+kVqB/nOKhNFsYAIeFGtSr4xkOePXqGq9hOBRF9z4kIJv2sTSiNGpPS?=
 =?iso-8859-1?Q?NblNHDltcw5tV9m9DRkKjgwLEViTyJzLOy6AbB1NDNkwBDDkO6JgSOrnli?=
 =?iso-8859-1?Q?5b7ZksUdE7xbUjaIkG9cj4QhVv9aOiIiWnvVWkBKFAceSPLLpuJTRyLRVo?=
 =?iso-8859-1?Q?xkjlc4E1c+Gd1rwRcjsA2iVAEiT3zZwRDigmEJmTGUUmdFZm7RqCeiZtrv?=
 =?iso-8859-1?Q?46JaYTGKzBnYNYz4Y7qA8yF3EO5fTfSaJ5QYTm4yJds0EHvyBeyDeMJQza?=
 =?iso-8859-1?Q?cfNTNgxiaYFDjCK6MCycrI/+/ZhpBHgovqz5QY7gyWSl8XRYi/+JL2ehKj?=
 =?iso-8859-1?Q?E2wdN5lgHHWHuNCKVDAedn9nGyOKJjlly/vnmsbEPA5DDO4hKNYeJD2r+B?=
 =?iso-8859-1?Q?SZE9/KWLbxlvUh8MnEL+41RZxMN2cMnIAydjCnWM3MEq1oFQDIv8RAIW3H?=
 =?iso-8859-1?Q?YluYjPFxCVmtLFzlC8okYoAh08EjBKIRXdPIpgpkbt719NatO7H9bM89E+?=
 =?iso-8859-1?Q?qS4qNLAn4TqgbOpPTZsFvc60B8IFwxzzzRuzleVFUwQRCu4oYape41OxTt?=
 =?iso-8859-1?Q?J/eQWNvGH1DvDUaMt9ttKDTxXAx+Hny4vcRNMU4YnrZ6BZvt7+HqJAPe8R?=
 =?iso-8859-1?Q?AXjRWbzVVV1gqKeyGTkfc7veZpDppLAxeR5wQInzPS19i/yvEdhSQi+6a4?=
 =?iso-8859-1?Q?74+3dz1C53z72qH1zV3zHxQI3/TVBnTJWuwcxj5jCmKw7O26qzkL34PzDK?=
 =?iso-8859-1?Q?5JcqOk0O0ccO7BpnC3dLIgxVu3cRL3pETa63bAeAsx/iAZLaD9GZJa5XwQ?=
 =?iso-8859-1?Q?CO60wMQNsRQJ7Ku81tGmsu75MP64XXj2vb5om9kBiFwSjWPPrH2Qroby75?=
 =?iso-8859-1?Q?bTYwWHDQsUiNTQnloGBLM9POVGNrc+TxddrjDLh0UVLPiVtp2dwJT5SsPb?=
 =?iso-8859-1?Q?VFT8JkY/7ONKfdiQyte9oBngsDqRvL1KCkt+LlNjEsrytfRmYCpPeu+pkZ?=
 =?iso-8859-1?Q?el7UPjJWqO1f3WsFdogXD5eTgcYl60fGCixH3qegN+e06t1nLQuIvWcfUF?=
 =?iso-8859-1?Q?J0Zop3pvWpGc2hnP+YAVg+hJLX+hqFACe8cASjTG22YE7CZuic8P?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c7ce09-53c3-4b29-616c-08da3cc5cc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 14:09:06.2003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOxJAcP0HDF2jOwo59HjFgmf4SArU9LLtsmTTY+/IHoGG5fhIgoaYAeP1/34jTlp6rT79R/kxsKHQ2P0dOYt/8/6AS7WZt1brV08Nx9wa0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

For power-up sequence, WILC expects RESET set to high 5ms after making
chip_en(enable) so corrected chip power-up sequence by making RESET high.
For Power-Down sequence, the correct sequence make RESET and CHIP_EN low
without any extra delay.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 18420e954402..2ae8dd3411ac 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -191,11 +191,11 @@ static void wilc_wlan_power(struct wilc *wilc, bool o=
n)
 		/* assert ENABLE: */
 		gpiod_set_value(gpios->enable, 1);
 		mdelay(5);
-		/* deassert RESET: */
-		gpiod_set_value(gpios->reset, 0);
-	} else {
 		/* assert RESET: */
 		gpiod_set_value(gpios->reset, 1);
+	} else {
+		/* deassert RESET: */
+		gpiod_set_value(gpios->reset, 0);
 		/* deassert ENABLE: */
 		gpiod_set_value(gpios->enable, 0);
 	}
--=20
2.25.1
