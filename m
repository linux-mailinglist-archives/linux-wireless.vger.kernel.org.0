Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24F3699A1
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbhDWSaW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44321 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWSaV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202585; x=1650738585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RmIWU2X9Whmv6D9wjWB1/bvpHtPm1W74MxWZmUTQbzU=;
  b=E/N78u+AnUt7r805OPeZiBcBXCL7+ECdWvnbNZgbInfCzi1g7CKAkjyl
   KSIE25xDdahRO9csTNGzcBS6sBReanSlAA9NpERzTfeYPc77jUfobrh/S
   VD/jb/v8Jh7i73mP2Z1j6ao/kpNMDDSPVijxGHeEywAh7FjIJYaEHG8HJ
   EM523bpOv/+IlfQvbKXHMfZ9Dmgd0dvXZwa5E8LigbPhblnD0uIFsmFjG
   p78b4AG6JcyptrXKQGt/kwY5LbPEYf++r4HIyPA0+K95N1hHctmInu5Uz
   HxFv4bd9F+Rcb3R7HblIjbAp527xIyu/7TtpmGkpvpfxdkvRBw9G3ggz9
   A==;
IronPort-SDR: aiqDIWRBZgQJ51LRqtDxnBATZlHjCWDdvAqymeVUZt1pbsPUKILPFC/J+qXxsbT2nebg9TAiUj
 /oBpa51+2YqwAsyiPFg1wsQK1i8ZskM+inIxRAFs52Q4zSKcGN5wfG6ClkD2JUZ4RE/yiFnZg0
 nM5LiUH8HHkSyj61v6gJ34eZu3Ggq9q7PEQ/w2I0yoSRKl+SX7GnoWI9/9qzBgW0bjFLRZGPUK
 g3+rEOjpARRLEMBrHREcc/y8XR6UwuJDFKuw7bklLuVjueUR9kxiqZC+YdcJ62wAlbBNW6BIGY
 rG8=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="111995807"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0c7YMYG5od63JzdALz5kMEL2hb6MY3W1UVGhIeHHfWPcI8JaFUqz0In1RaAJPZ4/RkQcWoH6b2yY4+SQLPPra/By1KuKcMRcZX6qr8cvoowhHur5t3WyoKTPvLh/2caQ4pEkwrWj+IscuojrQPih8LaWUYj8trNRXr1xE59ud/zbCc+N9h7JEiYdWZXmFOrrwUr98aglni0aKcAqNCPbuBo1lEafzemkygWlkVZUY7hcsFjqxo3B2SSthPl8M32ICN4a9Imm+T4ZI77YvCTRYEpFk5m4VD1oJGfbFjPm7ra2MmiqFVvFqlEkBneqMSkPfSu7T/ZHLhefGDH6i7NUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtydGo0iCW7MIr4I35vBj5An+woqggA49G96qn1Hrt4=;
 b=MY4NceISp1MghA/iAwPgCGW7ZAXcOkoB7RSktFaoK/yNEYKOpWJF7dUvzY9ZKUGUZ4pOeSzRhpmwZyjwOrWAZhJUzjiFuGZiVKF7STZz28kXd4iW6z6+sg54oy2I/H9MIx/TEZnCccZVV70n7zn2ENqSlyA3MRDIgt4a3vykVEr/WheCnnG3DYKw0yPapGdohIjz8iXgtBgmvBNQ6RWpCDE5XfXkvn7DDTTh2Zi+bwt0SVGgY1uvSmoDCHoBzEpddZ5EI2dpEP1zhtMGQNiq8YJpTx0PVMdvIds3Tshwf0wU1Go/MrLAf0yXWZ0c3JLnORxg58HYrlLZHwqgiKGzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtydGo0iCW7MIr4I35vBj5An+woqggA49G96qn1Hrt4=;
 b=tfdccl+LnihvXD7J/u0WtCWH//UKM6HEWvR4u6bCnyyH1dq+NJhGguA7H/zP8KcF6MILR3N0mSvws+NE8NMZx41+Kmy2FvR0AshtJcoFzKx/MHj6RDCVUNIKltlEiXbfNF3+ziD+0M69vCh64V9kdfYveDGZbRXBs4fB0dKzTWA=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:42 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 02/12] wilc1000: fix possible memory leak in cfg_scan_result()
Thread-Topic: [PATCH 02/12] wilc1000: fix possible memory leak in
 cfg_scan_result()
Thread-Index: AQHXOG6gXo9GfYFCakC9oss6XqjFTA==
Date:   Fri, 23 Apr 2021 18:29:41 +0000
Message-ID: <20210423182925.5865-3-ajay.kathat@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 376e3913-8271-4fa5-ebae-08d90685c2d1
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33185EC089252F64CAA0E741E3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +MfPRWrlcii26gR7zZCRlYzZw7xWJBEe3xUD3AjT6PhZms72r9PCHW2WQOmskChM3EsHzYZ8nN4FnVym95Ild/glnB2WWtEZCAQZQmRtwbj2B4w0KTbJCIKL9r+/xGyoNgl6493YgakmxKhqRNacOp6clk0B/LE1cppzBCy+CRPAZwvV9mcwQAam2LR3xFH8/kdZCYHXT5E/vSDC5rQwpbxKWuYaj8QwKtcGnIm6iB9J010xwjNsG0D50s6nN46mJIbrcyggJe21XmJM3mdoJQrUES4sbQ3AZJzd9+sLJYA5uEUqplR7G7b9jYXw2geyr8tHeymTGHSee5Jdarylo6xMeGj8zbqnNhAnQOXOdSTg7A041QVHYQ5fY1VOHfWd5tph2okMIJVqOO+BfZk7wgIlgeZkX2OTo5sBY+zVIqmMkSWhisbsQwgGFND1tX5/GHQ3RQ3Qs24xyvVdPK3hvWOV6tLV8oy86lHkFMv/8M2LzzcMfaZ9gTbW5m3NfCcd+DVF+bAO0Ii0UzchTR1DuD+ciMr0QU/U2euJha+x/3N1S0JwwJw90yIpWf/HaEX6tVz9p6a1Hb0RqNNdapyJ0Xum5mNVFgswr4io7GvlC48=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?oAApX65zCNNnjH7dX1O+skGh5xQ3N0+NX9mG4NWfSnwVEwFOPBGeckK+Aa?=
 =?iso-8859-1?Q?//Hmi2ErxDuZmB7vCnzT36lP3ARv0HqRJ3zd4oOpOEP/UXpNG3B7gCxTou?=
 =?iso-8859-1?Q?oyYiJhfh09SvCsYSzNfRzoGVl5Ce/wC77GH618ys6eldNMivwnDwSLJF64?=
 =?iso-8859-1?Q?JkbdBm1dKOM37E9JPiL4n45AfV7KGGLuuKNAyt0yKutdMueV3m584B+8Ca?=
 =?iso-8859-1?Q?75X0DPqnC8FUOpbooxnXs2c3JbVKyhPo9yFqtbVlnQC7vSB8KmnlWd5Hb5?=
 =?iso-8859-1?Q?JkUuy5nGBZlKQll7+uA1SQb3GpaxYqc+plID+7cHGRYYP2IbJG9VGoOLig?=
 =?iso-8859-1?Q?Oy+T6IMyUBIOtx7xhOZAHaLoAypsEi+j7CvkCVL92I+c73XsI2xNfFrZWP?=
 =?iso-8859-1?Q?H4L5jnCfLMytMrdC6oIfKm3gMkaBNeeld3w+YA6hHTnOw7Uk3dLcPgk11c?=
 =?iso-8859-1?Q?Z8NiU+dS6PYuMPZScknZs1Bh/VDaKtldzbKvkQsAb0+X/pVR4ti/jTS2V+?=
 =?iso-8859-1?Q?8VGFm9RxBZLL8HhG9dwgXa2kZvpjVk6Ll9rQoKwO37LPvaiLv2MlwweS7k?=
 =?iso-8859-1?Q?uTZy8v4gD/66kz7pGfPFvy7oJgeYLa6xV7JJoXBizF8o4Cs9K4pr69qt3t?=
 =?iso-8859-1?Q?h6wXqc4Ncv3gWH6iYgEKFK7xF8nWXAEa/gPrmDquglE6LjLFDlsdIjxdI6?=
 =?iso-8859-1?Q?FBKmhVZf3QUAxJu0AqsXumvLpyar6knYNvzxq/VFUbRzBUNvnwwZ00BcAS?=
 =?iso-8859-1?Q?JCBZBKd84G4JVu2E+xO78F4wL3MvwFZvokd3yUYRfBuI3Gx66QEr4FQ8tU?=
 =?iso-8859-1?Q?FZP1yJo8GeS8T3QeDVloRdMbARJuPLo10LvYNLkg4KnYWp4fyEsts50u0O?=
 =?iso-8859-1?Q?4qXKbT+rpk8xf8snlcNRX3l8TpboGDGOFfHEIx6NSjeTsvLF5GTlOg/rcK?=
 =?iso-8859-1?Q?FqV0PgIJau33fFP6g4d9OKnND/msc2v+/gHn9szlk2tY7A0BTDGSqr8oNf?=
 =?iso-8859-1?Q?xJgIhgn40eiHerh/3ktuAQ06LVZmE5XL/GXpYJEMlS10K0LS4ISTuCOkU8?=
 =?iso-8859-1?Q?qPgp4YPZ+3Wftykjcb9+v1vfJ8/nACpBhSP5hW8E8J8T6UFqzh4+q/W8A8?=
 =?iso-8859-1?Q?w1bJt4yMkMMQXNtQm0/ge980lKrf8bE+8XX43plkQAXgoTcqpduFY9csuy?=
 =?iso-8859-1?Q?NGVGVtoDAwhX8svrYEmPdghp13BDeeFcRJWe27NGNcXVP2v0zJR6QFZe0R?=
 =?iso-8859-1?Q?6s4iKcqVS2xnyOjFXdaqPRZk4GqWfpKO84Sj5Eltqzn5y3WF8g44Jn0HZ6?=
 =?iso-8859-1?Q?aWdBixQa4YCx2pL0K13aGbpr8J1E6uKXWqV0OzbaoPGw5l18hu+Q7hYy6K?=
 =?iso-8859-1?Q?1N/+glsA0n4CTw0V4cQuqhEpo+5K9sXQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376e3913-8271-4fa5-ebae-08d90685c2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:41.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bv7/gORLXdwvesBP/6nDtM1y3daom8+K5ZjfBT1s/My6XhcSt64cnnlANITS/cEeyY9z3XZHzCsWAiFU1tUaG7gI1noda/kp6fSd3Mqg54U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Free 'cg80211_bss' reference when 'bss' handler is valid.
'if' condition is incorrect because it calls 'cfg80211_put_bss' when bss
is NULL(i.e 'if (!bss) is used instead of 'if (bss)')
Remove 'if' condition because 'cfg80211_put_bss' API already takes care
of NULL check.

Fixes: 6cd4fa5ab691 ("staging: wilc1000: make use of cfg80211_inform_bss_fr=
ame()")
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 530a768547cc..36b87ed38092 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -129,8 +129,7 @@ static void cfg_scan_result(enum scan_event scan_event,
 						info->frame_len,
 						(s32)info->rssi * 100,
 						GFP_KERNEL);
-		if (!bss)
-			cfg80211_put_bss(wiphy, bss);
+		cfg80211_put_bss(wiphy, bss);
 	} else if (scan_event =3D=3D SCAN_EVENT_DONE) {
 		mutex_lock(&priv->scan_req_lock);
=20
--=20
2.24.0
