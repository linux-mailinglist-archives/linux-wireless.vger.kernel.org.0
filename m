Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8240E421
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhIPQzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:55:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34642 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343976AbhIPQwm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631811081; x=1663347081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5UtSD3QAqd7fTYDBU4dSnzbVn1i7++hLYtCPF5jehNk=;
  b=xyD1HfDp9JHci3AdakfpUONlWxS11LB2R1kPxmP6YmUJR+ZNSU264PwL
   W+RwDtYMl7clbmUPdYQEwBD7dNtbcJJVAYDOZP3HqvnUi65b6drCC2siO
   Gd+L2IHaNPMX8e378CWE5AojZp5A/JtnjbmRMUjHZ/7t5jJbAuxpJCIV2
   7EBexiWajnoR2PxQ9gGta0kZKhzksUKBvWmjScz1JdyNLOBx9UfTOAobU
   D058PuIu4CEIwNZsxcbFJKSfXVnzTZ29EXNJfefmoynL4OCzq8U1fDhCu
   uvqjN/BsQJ/YcDdz2AU99Y2a84te92HdgRjaQcKEiIWl2GqeOBsfDJYK5
   g==;
IronPort-SDR: QzLtriVhQP0ELAdEbSe85xAVbiApWJx1M/07qCcxMiydRvnka9ZIq0EIrjpHFhQpRV6ismss0U
 /8BHglTyzvhFmOhUbQJhcQqnELUu+1T5y6/BHcoii58sduMopgDK2dTwS+IWkC+p6Ox3sSJw4h
 7TsDZqABWRjpfFBiLHOY7ecJC8rgUnPa5wS6wRnjkgt//CGsCULXdp3XSr0zgkulWBNgaWX5dm
 iILedT59isHpjsFtkc7ahw69TV6L1v+xODkoPclEz8ojgyO9imHZU1/jDrIPkhtUuqDZHBYuHE
 msgAum7uixchZy/Zsigs0/7E
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="144413621"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G86Gb24WLCUc8u+iyD+WjmR812oDsx5D5vMXne8NOHTglbA8Eh4uginTGJAmrdb71Xla1jpT5fZHJXO2ZwS8F/tOcBnk3XKlG2CCQVhBGrf7GJszMMZxdrpIoyk+z0mnj6Cy05EvlPPR71sOkTuNRsd+csJpab8e6GYXN3UBcO7FL29XrqfX8fkumv3YrBuOZ70y+loQGUI7C9iao9C3fDB2afEQYGSEX/74eg55aIvfyZ3HN5Wfedm/ImZpCuE1F5tUDUUEo51BELbSGPNhia8nqi19BA4zsuhnP3ZgYJ6ahdELKx1WaY76XHqmIhpBLZ5MDmU73DTCxz8ZYYl2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUYqBirkuZcPPN56mRtuHFxvMu+b+pybLYpkBJShjjM=;
 b=j18/vQSTKU7QWfid8GlfNZGHNhIIIaX1cDR6Q4LCTlg049FyBtEmDLuKXysuUiHuRx+SpcniBPBxBYnliHBGfgBHDpxhHU5dMZ/h9bcRXN9lsMZS89o2lAesyTgIWszKdSg3vJF/0rroDWWIyx919N3/3c6OfvjbiQkcscGmFpbqpLuX8eMvkVtuKCDeqrvPz3L1jcQwO/H5oaQLXlorJcgPD//sjUl/Yh4PR3AWfnXeQ35kIrpBrm8IBVBhi8xtdxFF2I2WypxpGkdDShg82GPbbKA/6KVe5T9oZ+MrFlJyn+aSTmn50S4h64Pk1yzPbSle2D3H78Jsc2JqMI6jkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUYqBirkuZcPPN56mRtuHFxvMu+b+pybLYpkBJShjjM=;
 b=k5CO7XDEljcP5DyVxyRMVWuZDcWtvjp4OCJzHmGlWlGL1RxHTSiHDBF23n20SQoWJSOfpGU7xfH7SVIIfgG+Q6w36MoKonikzQscK6D4/4YalBJDdXDTsDFV8T0UX9RlPpnl/zO6tvLtJnBZufS0wFzBDs19qs91r6yTj3eP+d8=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB3990.namprd11.prod.outlook.com (2603:10b6:a03:18d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 16 Sep
 2021 16:49:31 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 10/11] wilc1000: use correct write command sequence in
 wilc_spi_sync_ext()
Thread-Topic: [PATCH v2 10/11] wilc1000: use correct write command sequence in
 wilc_spi_sync_ext()
Thread-Index: AQHXqxrMFSlUj9OZo0avjyjHukVIrg==
Date:   Thu, 16 Sep 2021 16:49:22 +0000
Message-ID: <20210916164902.74629-11-ajay.kathat@microchip.com>
References: <20210916164902.74629-1-ajay.kathat@microchip.com>
In-Reply-To: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48e4f2e8-bc41-418b-3655-08d97931f4bd
x-ms-traffictypediagnostic: BY5PR11MB3990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3990C5DACCA7EA01D15523D2E3DC9@BY5PR11MB3990.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNYt+iqitNVE7pBX1u/ctcgpudyq1ystbKTsmZ3jK3t3BKz5JCv6Xz8rpeRN1hjw4aHhl3b+g9EqGwAAC+RfsCz1QNuwRtkoQZVPNCCaruiS1FkoPrErQZUFXMvqylFd42zXiGGmnIRfLsKRqZO9cl8UGwWNEX/VzKkmpqdjK4lHccdPyrtPJrJgjq/jqrE0KJjDOc1/uWenRF9z6CyYzrouG7tROjs+SkdNHVxXjqxMkAlEuPRiiU0/2okXQEsm44z99dVFPpkp5XmVBU+S4fDwK8t+Nbn9icCUUQesuPtgqdrV0imUUy6mvueucBIh8WWEnxhvMPdgOcRWZTw1KXRjTWkqus7HNry+QMk83PMbT5007N3S44zm3o4740gagW/XhH9F4WC2IlrQKsPUg/q8Lsb29YG1AOGzu31pZvLgv7q2wx0UGYXdIrY6QFiASSPUGQcXR6gwzTmEyTPceGXLcc0nycRT3pn3aAJouCe1XxDNbMJZvJg5jfItiR5to6MIGli6R0ov4002IzvmXmPRBjTyd7kSQp0wN2F7Ct6aB3vsbOnFUFslY+w2tdwrGnNqItyu+MTErVRuNUAYJEx5f990+jnLsjHu77Ewv6DM92iVHWZ0DpzdJifeKt16b5sJadAD46NVJu1pL4253au+O/+DsQu5Xq1srEtmVJ6cDVPC69rnoGqzx67/YYy5G9fLDBhyagyTyPrG+Uk8DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(64756008)(38070700005)(38100700002)(66476007)(6916009)(8936002)(76116006)(6506007)(71200400001)(66446008)(2906002)(4326008)(83380400001)(107886003)(6666004)(8676002)(66556008)(5660300002)(186003)(4744005)(66946007)(1076003)(122000001)(54906003)(316002)(508600001)(6486002)(6512007)(2616005)(86362001)(26005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aMpBubWmYroO9c1uhIdHnd2f2fTP+G7V/kv6a23o8kvc/aiKhv2E1ZB3Tp?=
 =?iso-8859-1?Q?2GTNWQr+JUy8/sWPiBZVHvt7BcaAAk+IHA7rdfWL4AcbuouFauJ9vy4dF7?=
 =?iso-8859-1?Q?2TEh0VU/xP2Phg6NsqRecSPi+du3Bv3IhVQc0AmCd5saiIXUq0CMaqLsr9?=
 =?iso-8859-1?Q?Ci7O/+5IT+lQ2IK34iqqdSMgFWU6RZQCqZb3UFagb1AEg9bX3eoHmc8U3s?=
 =?iso-8859-1?Q?bay4mW0HWbvj/osjmOmTfmUlbMKTeVAU6OvmNvvt/UqwQnso/Yk0bkyTZ7?=
 =?iso-8859-1?Q?B+VauiTTmqKJQ4lbjCO1kx4W9A/dVEuZ/ynH7PXbFFf+IQqJCZBfJyVoHe?=
 =?iso-8859-1?Q?USudD8+FJ5X+N8hMdVBIIBmwsXPnI/20av0oDpzRkaao3b0dgRUyLGug4l?=
 =?iso-8859-1?Q?53dJtqdaVCFt9nZBLliTKBVNEe8DChVD+iLrWM/IH/dVyI/AFd9zVoJcG3?=
 =?iso-8859-1?Q?uhX0/5KkrDzv3c6NwaEMAXNEpsdD+HldQUxfL4to39cRcC+b7JycdnrLEv?=
 =?iso-8859-1?Q?9eYgXi5e46edZKzdLzeR2dveCisx60SR5oQM2GDmH7JQFuboUTf9KbOXDj?=
 =?iso-8859-1?Q?CVCfzQwvRew4NvKmS/21j13opYIyH1RkLrF/LyWIXrpxn90UOi8H8Etx5d?=
 =?iso-8859-1?Q?U4tSv2JWjwtBKZGFsxGlhmY3j0Ef0gXHYSXMS3XDpMbCiZGh5p8hEKQsK9?=
 =?iso-8859-1?Q?MF27WCpuzUQi/rhzjZfW8DbB61v7cMPzIVgir7vh291zFbwC7oNozoJvOL?=
 =?iso-8859-1?Q?cvXftwXtrNXgXYGiD5U7VDCPiqbEkFAQXgvus0La+3oU/fDev7Nx5Hmido?=
 =?iso-8859-1?Q?Wkd/j4neTbqTg4vcDOcDO3d2FpenEwXVGbQZcdrZ0BF9OatJa+gG1j1m6y?=
 =?iso-8859-1?Q?IPh937vKApga1eU7kimDuDP+dNcGViyn4xLJtDDeKtO5BW5zZUYxPyCRss?=
 =?iso-8859-1?Q?DzFl9yyI/rDarzhrAkppWwfL15TAZl4w0udIEwzeoZ1DnNQ8SYnlaOOYQE?=
 =?iso-8859-1?Q?wksK75IlrMPPJx2NbOCBBEpG8mCx8Z8HDPxdi3ge62sWQ4s3A2v3yR+ffJ?=
 =?iso-8859-1?Q?J5SpuC7QJmo9xbU12om4kS80OnpLtVKxyr+eS9wIeL0MfvaibAV8y7cP7n?=
 =?iso-8859-1?Q?GifWdU8raR9vGhwTBnCPoUNm0ym13ZXaDRCUPSJ4293zzjaMTSZoeIlQFy?=
 =?iso-8859-1?Q?D5f7zHsyJzvgwETyDyiBcFpMmCVE7GWOXbtFwssDlhMt8FpVgoDTCzhkdC?=
 =?iso-8859-1?Q?33AjMRpHrTixTAAguMtqvD9zpBnqeohirufx4aFPhpBy7pJ8HmlbjxwSj4?=
 =?iso-8859-1?Q?xXWqsqChdOKSeBWYnlgPrd1v5iM8lKLCKV+jPcovMwkcDhiL5wUtXe+HOr?=
 =?iso-8859-1?Q?0VEEO0HLBh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e4f2e8-bc41-418b-3655-08d97931f4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:22.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nL+sGdJcfuoW1DDbC2V3T2fdej1Osr+2Xczbkrl0AU5VrEi1cBbyo9Imwr2MrIF3+KLHrRXRtBsdK+fcZR437JIgPkEbLQIy/04y+Da4Zyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3990
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Instead of using double read for the same register, use the write register
command after the read command.
The correct sequence is to use the read value in write command instead of
reading the same register again.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 4f0bc24d2a78..640850f989dd 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -1167,7 +1167,7 @@ static int wilc_spi_sync_ext(struct wilc *wilc, int n=
int)
 		for (i =3D 0; (i < 3) && (nint > 0); i++, nint--)
 			reg |=3D BIT(i);
=20
-		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+		ret =3D wilc_spi_write_reg(wilc, WILC_INTR2_ENABLE, reg);
 		if (ret) {
 			dev_err(&spi->dev, "Failed write reg (%08x)...\n",
 				WILC_INTR2_ENABLE);
--=20
2.25.1
