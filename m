Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5953051A549
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbiEDQXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353016AbiEDQXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:23:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9F46B05
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651681172; x=1683217172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d2C90aY0w/W+UzoMzDtV2vEn7MCx1irTf5ttF97P61Q=;
  b=piCnBuiIHBf+nZcZxIKen2uivM2OHklA0KPMEdB4I8VClwf4lxIdty5W
   NfsqvsXnheJhIBagrhPSwcpApE5sjHMgXllXmahs+mJ7eGycAPbMFzhfV
   +eKVRS2Cmb4H2uXpXv3BqwzPG3UO72xlXNjyAl1qX0NenecpZW/GeXIUs
   sR4VCZBWypJJiMa3pN2YEgmZccNq3mqi0q2alWUp5BK9y51zzfOmLB/na
   liXQuV7ekuYQd1G2bIUiGF0SeXlHJHWH+hYQ/NcTly/w/w/BUHc+SuPMk
   1Xze13VisICN4AG1u4HUtwzWdNeT3FdU12B7Q+fpSqNXrP20lTso9uSOe
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="162723826"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2022 09:19:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 4 May 2022 09:19:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 4 May 2022 09:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev4u81VpZrP8hrt152tfB74RBII4l7EMdJqipFXgGOytYdldOmKSRipmv6cyr1FVfPAVaV5KzEzMpDIQuHic83eFwOBiTYspZhmGuJLlvgAiLVqH/ePdkyzK7sHd1Uk2dUVhq6I3JbtAq00hxKXOl1hKdx8DI6V+SHrmhBdWZCPNd0PaJGWdPt0deYhrrQ9/2c6X9hUlPbm3rS11qKJtLsKHYdn7CmsgewwoWyGEQqdrrmOOGToWu0VSeeLEAWOp8LBUmD8ZChYJtMwpyvVzOlHKOwONlNTEFuW9THY2Fw2l73ozWZU9o+DCJnFivcZmkOM8nBuDTdFb7dJgV1MHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNiH4NbQJfXBfuvv3NqnmKNKjMfn9gwb1CLSdDhbNxo=;
 b=LNhyQjwZMzESx7Smhu6VXLvDLiIRvZ6Nf3IN7BtaA5B2XcZ/WWS9AbpFVr+OmnI9NGejL40dUZWcq0vjbw+9RBgG9YcteXX+hYb64MSkdW8WwwyM3kWfaFAtSQp1bld9JdLGgwHmIQHCJ+63j93LCgRQR8gvDJgnxpm8vrWVnePx5CJIFoYMXpDYhKM6XgeSufYns989lb2SfrO39oedQQ6pb8KIpBHp2zLlkpTinfiX5s4dNsVhS0KVz2W21zd15m9XzYMkPrXLv2VtKvUVZxq+h4ZkSdV3w+Bh7SBaR3U0qTs9ZRV6zpUPJyn0nMnmXy9f/fSg+r/2Zs0Ceq/DpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNiH4NbQJfXBfuvv3NqnmKNKjMfn9gwb1CLSdDhbNxo=;
 b=uDr/DJKw1/iyMmGFzYloztGBE+3mcB3Ykl/NiZxlfjjYqja/cIm5JQy+mtz+uYZ+xGgiQIARhHEVPgj7WQFILrQvltTQDMwK5LkATiE3AltDP5U220myHBWfwSy8+XahHIoNSlVS207EU0DzUuHSZjsTll8oKS4XqSO0weFSnhQ=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5597.namprd11.prod.outlook.com (2603:10b6:a03:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 16:19:27 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%7]) with mapi id 15.20.5206.026; Wed, 4 May 2022
 16:19:27 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/5] wilc1000: use 'u64' datatype for cookie variable
Thread-Topic: [PATCH 4/5] wilc1000: use 'u64' datatype for cookie variable
Thread-Index: AQHYX9K54ujdhzQZz0uDjx7eRXX/jw==
Date:   Wed, 4 May 2022 16:19:26 +0000
Message-ID: <20220504161924.2146601-4-ajay.kathat@microchip.com>
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
In-Reply-To: <20220504161924.2146601-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d1f54df-177b-4ab7-4c24-08da2de9dc2b
x-ms-traffictypediagnostic: SJ0PR11MB5597:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB55979C81FDB3BF3D516615FFE3C39@SJ0PR11MB5597.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMMucw775+uhua82LUN3OB27i2blz1ZOFHXZQpAkvf96PCtC4j9GyBktNtx6A7qVrLYVrXqQYIFqMbQZEJu7OPI7PGxm9GjAnoPHGIxc7EnmfRv+vrI3f32UfNd2d7fEQ4IaQiHPTCCUuRfS0rDsxBk2Sj4lY8N07Muk6JhO60AFimFC1la9R0qvbh2d4ptVbTQSZ+S5MDHECQPE5fq1KNKHITyxKTRmKoHmGD+46s6YkugwVe7JSVDvBMFTOabMXcuCe5lptmPkhYXK8LL1zH3eonmU9yaQ3bUVVI3HPjKOw7VcXQp9JBbeLaLlPX+R3G9H9TuwJv7koC4z0MJgfdxJXqHfaQr13e173qT/1IYPEqFGfOd0EF5d+UM9PpDLw5VZly9yYrw6AgbSNXEMOv9I+uz4T7NTOXxVMAbsmjfy7v0XpiWFMYdSTVakI13HB4vB9jHaqmFT1cQ+8IjBkU/9ax0se82x9LDxHcS2C5UUXHgiLEjA+CNm2HiFQkPCQ3QCqzA5KBkjD5q2oCQ80Ha0JKgfBz1EoPyYL4kx7PAaHHZPXJUZ7UPAtbNjOITRiAFO8b/DnGylm0FYVdf1KBv6wFmmZAG9VZhW/JqcchNatN3sxn+DhbmWPxREfkRMmb7D9P/4AtxyesaDrxYdFtKcGu9BRhmsym1mKu5Y2X3W81/IHI3mUiIPlwAynrk+lbOilUUIiJm9hbfKfLeW5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(38070700005)(38100700002)(6486002)(122000001)(4744005)(2906002)(8936002)(6506007)(508600001)(1076003)(4326008)(86362001)(6916009)(186003)(6512007)(26005)(71200400001)(2616005)(54906003)(5660300002)(316002)(91956017)(107886003)(8676002)(83380400001)(64756008)(76116006)(66556008)(66476007)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B2bkmceXMc1YkMl8FIlBjyy2HEEsew0zWVgo1XI/EcG1XTe8mWbYUBdgi4?=
 =?iso-8859-1?Q?S4AArexQ6txGJhrVvzZ3QFRcK7fCrkavf6DFn6e5V/QemP07dIuZLRqJU7?=
 =?iso-8859-1?Q?XT2S2erf9Eiz/Yy9nxqS8VV1mvzvI1lhUN1XaHZSOHgWXo5vVOKLJyqIZG?=
 =?iso-8859-1?Q?cnWgrwnvP2MbJsrwE6p1wjhvNlEOReLWsrY/k4IBP6I9+2T43Q13NGqLbr?=
 =?iso-8859-1?Q?SwXreo3APU45rfOctKAYRIBGt6EYkFAoMaqP1+Md6bAtM9er6KTI3oXtGt?=
 =?iso-8859-1?Q?qo1rwiTnEc7/6ywwS1kwjyJwctZKVQpX87dtMLgOtN1EFbmVPR7CsILHvr?=
 =?iso-8859-1?Q?6AWVkZPiyFywrj6T67bcCAnQtbhYldCBQKPe30AgltzRMFJ3mH0dT0HF3x?=
 =?iso-8859-1?Q?eFUKBa488E5tZmwNhJ1IpbuHYZTtZGzoLWWda2tXb7M6MU0SicHlokIOVR?=
 =?iso-8859-1?Q?DLe8Ad/0psiqBRZ/z95o97KGAAfgEidzRBpHKLI+9isf8GHql80pfjdUID?=
 =?iso-8859-1?Q?SrDVqWbhJe3mz4w1/QMnzYYA8pnG/dh0kiTcL37ivF48B1284IPp3mzSA8?=
 =?iso-8859-1?Q?F9+apoGKVWCx9+zbqe4QaX4aMSrAU3ALBVqnGV5xTxwcArFZ3Pi4LHYiml?=
 =?iso-8859-1?Q?agKriIV/Sihq+Ne14mY8HqkX1xUUd+kXe4Qw9acZc0tbrYPGuLwZobW1fh?=
 =?iso-8859-1?Q?S0xMJtS+KSmi/luFTaTzGyHUprWL2MFy+Wkp2JIoMxqt7DPs3TtKR9G3yU?=
 =?iso-8859-1?Q?JIIWjI6Cd38X0zIRxtfnVvXJ7KCs4jgu8zIhP2TC7K8L7W4mQ5KZ2OOfp/?=
 =?iso-8859-1?Q?k/HE4jy6t3HNE2ozyP0IqiQmu0MSb0JangdzsP94h4bGeTyo1kdy9Vogv+?=
 =?iso-8859-1?Q?FzZKiP4qg9xNajDKjzORZuAuXj+dtvIBmcttPimtrZee95l1tG72MkAe//?=
 =?iso-8859-1?Q?VzvtypJWiXDqH7QpHWZQymEzVlxPFkEVW+ZlF+s+wodr8AueaZEKVXLKiM?=
 =?iso-8859-1?Q?hHpShz2Tb8B5J5qzuft7hEuHc5rn550vcU5GE8b9wuWpUeQ2A+sCGCihH3?=
 =?iso-8859-1?Q?SLontIVIYGPV9oRam0AeVr1TkFx0WOtv3wQskzJ6Rd+LIU5G++DjyqE2cN?=
 =?iso-8859-1?Q?lImY0PMDl8fwyJIgcTV5eT5UPOTe24sJS98fnpoz7MCbTH9CqFDIZvIGxB?=
 =?iso-8859-1?Q?zlasBqHnZo1mNaatHCLqnH2X/HMx4FyY4w0Y7cFBhRIVQWaDLUoZpkew8S?=
 =?iso-8859-1?Q?eJCrMvx62rvXHSdUo7lh4ZDp4wEzRfEfKclM8oyhHhx5vPilOvuUe/hkqh?=
 =?iso-8859-1?Q?j9VHQkn4e57kzUI9o9Z3vNnfcImnrrYPnCiA+UQwXP19HgntdkKY+aCWvi?=
 =?iso-8859-1?Q?r27uhtrwY1PxbdwqwhWI5G/JMhL6tnrENAW1J+J/lmjJoWyBnoSzFQgm3y?=
 =?iso-8859-1?Q?C1+KzaJpjPmY5CpqmpTklYX5jFOFyfl+Q04zLRPa8y1ht9xv/2Z4bnfd7s?=
 =?iso-8859-1?Q?RdoucvzOEIDGleSBEtYfpi/Oykk8XCPFyZiS7/K162XpYxCwrjB2fYkmEI?=
 =?iso-8859-1?Q?G51guiRfd4R0JGdImB9EdX+rS8BsXfcgg0W1gwW2LgQeGgVBkRRkDGMArU?=
 =?iso-8859-1?Q?8o7J6zrdxh1Rn5NsXBNNH5LM712gW6jhgP78Y3Y7pN9mKExKkREeN8d4MN?=
 =?iso-8859-1?Q?pHNRLh+HHaKy00Mob1cdY4h5MreB7D758bsKBehk8JmuhMCwFCAXk2xl/1?=
 =?iso-8859-1?Q?pLpv33EhqkqoG1HE7mQHDb6LHBVP+/tG56gg8d4lVJ6vnq+NYSlSUG9vR3?=
 =?iso-8859-1?Q?Gz0G0DlxGpkmPDma+SHf2F9dmiNSB04q7PJ2k8PFcn7T4677agwM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1f54df-177b-4ab7-4c24-08da2de9dc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:19:27.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6OxB02Y/Z7qoRPeaLsPcWkL6mACYw/FyCMgkPs/ii9IQfFS7A6YSYKlopQqPFBNwk+6r781rDGoSeuRTuwyttUs8VrveeKTbVsXoVPT+Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5597
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

Use 'u64' instead of 'u32' for the cookie variable as expected by cfg80211
callback function argument.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index cccd54ed0518..77616fc77575 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -123,7 +123,7 @@ struct wilc_remain_ch {
 	u32 duration;
 	void (*expired)(void *priv, u64 cookie);
 	void *arg;
-	u32 cookie;
+	u64 cookie;
 };
=20
 struct wilc;
--=20
2.25.1
