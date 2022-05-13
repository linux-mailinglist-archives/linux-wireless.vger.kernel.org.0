Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A130F52681E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355540AbiEMRSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382424AbiEMRSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 13:18:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A5232062
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652462278; x=1683998278;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=DGYy6pWqRpWJayPSAm4jMGEeasBD1ITm4BDm9LKSWG8=;
  b=pj8PZfZT23d+quXvd6trnw1W4y59vFC5mJsV0RD12Lf8BNvlMHmBAkhW
   I+2tjTwTN0oHQyswOyqN28kQOa9YA+Yvlw5smM2LCeaiDK+9JIH2Ta61p
   vI2nvx8libZqdIJ4PtUz/7lsosd1yv6JGF0Bz0VeR/s19kzC0/7R0dgzg
   QOUxZaDjN6Y7ZVdKXDPd4FFsysVkG7NoDg365yPpBGL5/FoLsjjCQDVAE
   qhzQU6qANoXKccb2HbR0bLnW6tGT/bvm+Q2LFYqlmN3oZpBrQ/f+9hgtd
   LcmUZAlfKPcEUHdPLnwVhg6l6IO33kYNTpWkRdsyMQEsHL2Bqyb4ce3cl
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="155983585"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 10:17:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 10:17:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 13 May 2022 10:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW+bcZ2B1U2TTDk6ELC6I63S3/QwnZ8z0qxmn6LHEUP/D635t0W67hE+dauUJRNFGwkURRxKdxBmO25/aNFaBaArEMGcaxB8OFy9va12iNLLiI5JTEcFRTxhHgwW/b4QD/4K1NcWWnHde5EJsObQEVcLYtjLwSS/eYQCHWOFNnMJ3qKzc6yezXPa/2iu6r7/WPLgLA8su4rF6t6eNz+auhJy2X07FSECWxlUrCFNId7IBb48r0pnHPDJqilluFg40DLaj8q4vskNpX49U7YJwX59pAkkeU3pwJj1ngaaJ3SilFdCFn3Sen41eyGpgOmMUG4sq1PRmWkEpdH33SPRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osrhlwpEFFhhR0wpe1YAkbvHKhLHXzcBTB1i7NRwLIA=;
 b=exWF37/wcIQm75l0FQGh0QmgKkLSLkaMUYgr3pxXiHCHGARfvXNa4iegSjlZIum+D5q3D2xJGfRDhPd+EgN5VBt8gxrkPDcvN/uztHegtaoaBxXW3bvXpeHxzPmfl+Eg6RJo4runq/6sVGdiI/c1rW/69j9l6iLbnhbRdbM7XXKTWI88wpkXSSBv9Tb+KWGDBzNtN9+zyFI5EINiIUTjzd6YRKAWsFhIn+ixbzKRMOtxLePOlWcMZOwJhTRliq6PUME2fM04NOkA2c7sLCT/r9c0Gy2r/ZRc8Im+IRmtJAjrPqOm+OJrp7a0eheM61jOJDNZ94XnkVvbzXsO9fC05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osrhlwpEFFhhR0wpe1YAkbvHKhLHXzcBTB1i7NRwLIA=;
 b=VloMQVjmUUc29ryF21uX8Kqg7o3yL9r2PnVi8kk5/7kNzIwsxiBJMErYS+ww/H6lzDwH0gmoOONyHXWJV4KwxHsALOCmWRYqKhcMZp+VJTOVQ8/YoynJK8j1BxWmR8M1xRlOtZCHUvWTeuykl0c6cSwnXCEWngKueW0U/BMekTA=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BL0PR11MB3441.namprd11.prod.outlook.com (2603:10b6:208:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Fri, 13 May
 2022 17:17:51 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%9]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 17:17:51 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Topic: [PATCH 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Index: AQHYZu1gNkQs7R/wY0+9DcjVPDuCAw==
Date:   Fri, 13 May 2022 17:17:51 +0000
Message-ID: <20220513171741.26701-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c60fa923-f070-4ed9-db4e-08da350482c4
x-ms-traffictypediagnostic: BL0PR11MB3441:EE_
x-microsoft-antispam-prvs: <BL0PR11MB344149D9F15C8D3D751C6D44E3CA9@BL0PR11MB3441.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufC16Ui/q5ZbNuudLCV0WAlZTfI77yDp3E4I7vC3MV4sdfqlInHDuf8qA1C+NpCj/nzf2EuD3huILk/lZ0DQtQ116e3eeJdm0f8jhAOW8gg1tfhj1n6D91iOXwAjUCMEsNfeevjTOBvW6+wz6xSdcYrKyVA4uMZ7TvESPcblNGQGV97AkNc8iD613mldTYh5AYMflhS1x2fqk4KynXcVbKwtmrLhIOZXeTpw8S75tRHguezM3e/uV6jcU1S9mlyzaii7uJvt1XAm45VdnlCnZNsDeTrzZdzxG209clvAzdGCFmJO7AWNSIVbKjq4zxSDjrjxFHg3lq8/jUGvHKvrW2pFW9Ir39yHxO/JuimBF0/yHgr/tOoLNLbeJMScVy0GaMvQHVRw80lKlDs7VGw1v0o6BHLAfsVkHwTc3I9ycni4eA+sp2GqnsrAdW7h8azLj2+tdIXxmyMbRKEfdLl4ROUOS+NBBVyvSksm1sLhm6zAqt+k84FWpnXMoysYNtAmP3zBlp9W5I++7DGbHQ64CHzJhjx6r/o9ZV2R+dhC+UAYBd0sVFuN3pxM35Yf6r6IVnjpwem1tbSTbKXtZxy4tEbmUpftf5NOTyG+ua/WO2jlgMeJlCZ2QqFoTZWNkmlhhAGZerw5VjjNkqe63gHbtXfBhtn+GPgRiCBKWtX+54Wl802rr2zQv3AH5gkXwIqvhOBsvRqg54Hww6Bz5N+Nrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(38070700005)(38100700002)(1076003)(36756003)(186003)(83380400001)(107886003)(6486002)(508600001)(8936002)(2906002)(5660300002)(86362001)(6506007)(91956017)(6916009)(122000001)(4326008)(8676002)(6512007)(71200400001)(26005)(2616005)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+ISPq7feXi/1ZBILRm8KvQsf+OkMsQ8omO4yG7pv3tHK+AkvEjFHSI3O/7?=
 =?iso-8859-1?Q?qJI7VcGX/ye3OTNyJZVFWH/yxxXK7HRZBUOpMz5J1JGfsi6jTVLlzpVbJA?=
 =?iso-8859-1?Q?Z5b60EJCMyRgnOdFi9/BM4IDtOU/Zth4sNbHco9kMn3hz9EJk0sfQiadyC?=
 =?iso-8859-1?Q?c/7aeuiWexx+h8vdGbzOKlIWsfIPTSnMDukWDW8gGtWeGBH+8K9LZln6rX?=
 =?iso-8859-1?Q?lv8ej4fiS4XqFjYCFDJdQ1GqDnQSqr2QLN/uweoakm/ZQEorxpAeJAWqGq?=
 =?iso-8859-1?Q?9tWWZFSs98q7tX2GFjLxNdY7HnXKWitiTXfvgBf5E3QXoQQLruoM5u+giM?=
 =?iso-8859-1?Q?WbwkBhoqFbdfA+jbzg7Do9lwqCs6Sz75+1aQ00bPBFFR0AjYEhKNHpoxJd?=
 =?iso-8859-1?Q?WPkqY+FytmEMhommoUrax6g+186xZpoI2LNVAljX7mMlk+wWj+6NqV7Lx2?=
 =?iso-8859-1?Q?buuMhEZb6KHozCCSB4DojHvPc+OCVSHQiIrf34LhpnW1z0qoA4bZf0Qo95?=
 =?iso-8859-1?Q?0Ejmn0oCXgow1hnm+C5cC/kTnNUrSv/sx33/L0D45IV19PJtcV1sRGjkm3?=
 =?iso-8859-1?Q?7aqUkpnkiMKiLFrTXpBWRhnM6RdubjqN3rbhjKq+zgviH2jAm8IzOx8gVp?=
 =?iso-8859-1?Q?+lsDwrGq2IGdBHbLwcbwtqqZeMvQ6aXDldFb8bVisc7O1hbTnhATQf/MN6?=
 =?iso-8859-1?Q?V/hmSnZs9RJT5qGICOkd3toLsa9mb7llGf/o7eBmsHfcqsELPa82KYFXFG?=
 =?iso-8859-1?Q?qjY9xHt4PQyYXGyRfsEmKwjqarZhUU+9vETVZ/MOMl5QdA9+G5L58UaoSr?=
 =?iso-8859-1?Q?/G+bLbr36/DolSC3MO2LcEuH1nvNJwO3BT8MLjoGxGJoVm+RU1iFBOFH9S?=
 =?iso-8859-1?Q?nwLEXKloUzg+dZme8bN7QHWzAq60Pd0zFkmqnblps2TIfhYom5NOCiKIBG?=
 =?iso-8859-1?Q?Bj17W5Co5eEirMklclgJuj9MjnARUYt9FE8MMfnihEtWjXwOjMky6m0UIh?=
 =?iso-8859-1?Q?dNrtAA6X4YKwevIurxYByzbnfSmvYDaktd70izIrMzVX/hlotgF927To0y?=
 =?iso-8859-1?Q?wV0dBec+U6xjRnQaUAYcK7FZJCosjeIn7Zv4blnlyTDUhqeV1Xw0mJdX1q?=
 =?iso-8859-1?Q?D78kRnFz1m8pNEt9kMzzApProhYhPXOzqvyIz/gI9IxjF01A2sOk097pAr?=
 =?iso-8859-1?Q?qoETfyUYuOFdGtB+9UtFfaqyNBF9EUIC2h+to78WVTny9zZRER3MaNWEEi?=
 =?iso-8859-1?Q?o+Hgz4UTavg6sT9eLE4R+U0j+ryTXZF7bu7rulo4689hsXA7qG/BoYDON/?=
 =?iso-8859-1?Q?1VTjYrqNeli9XkA8tRDSj6At3w/HsC/hOoEMPpjuUYJ03x2ECPPunZyfWD?=
 =?iso-8859-1?Q?dA1A3NXA6EkLrE9HvCv6vAdAm3AmFkac33xCM3eBmyXsGJj14zqtI5QobD?=
 =?iso-8859-1?Q?Ln3eUMEh8WVjfllvmpAOKe1oOgBl2sa/CflqdyPz33JyPtNMgNOR9tX7R9?=
 =?iso-8859-1?Q?jIlGiuelJzpQUg6DQmr7OVqDcMxHumwwMpm3v28sq7e1KaKtsTjn53Rh6U?=
 =?iso-8859-1?Q?VqIXtK6kEQwyQYbimqPqPd5821/gitQ27FiF3RydHFMNkxxNSLbx+hFwth?=
 =?iso-8859-1?Q?mRbF7kqRpKhE5NN4tWiDiNQnbyg/JxJ+lts7YCRbW8+6pl9HIgEUmMYamK?=
 =?iso-8859-1?Q?vFp7ncy8YkL0eD4NOAszfF9byXwnUJEgIvfXdIEIyCK4DsKJoQk8jk17tE?=
 =?iso-8859-1?Q?l0ss6GHJjqxDHA1tFBe6CPZCkBi4ViJ/6MZg7tTt3JdwXnLAOETvq0ockm?=
 =?iso-8859-1?Q?sG2G7j07wiC7SzHXP0EKMA/jfWejnQ7EYS8nd2uabDQR6IdwCpeE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60fa923-f070-4ed9-db4e-08da350482c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:17:51.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dA7Gbk/rQBJJMUr0eOWVjqIXO86TwSWk54S2pwxjVwVpUcYUHE7cmfmviSedvogxOs0XrW5wGXta40/t0cDsbeCIFo9ap3/YWcrcJau5Dd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3441
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
