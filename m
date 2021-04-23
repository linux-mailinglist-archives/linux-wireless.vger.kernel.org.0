Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296173699B0
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbhDWSaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:35 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3592 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243642AbhDWSab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202595; x=1650738595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lhpmgexJoYr2rv6AZzfcPYi87Iirgl+9xiuWQ8Y4rxY=;
  b=TLv0q0r5naosbR0lfyEqneYA6vpI+KlSdwzpCtCRUSqh6c/fL48gJ3J2
   eGGaSOrMgPWoT2ohrWqL08qVqxk4QlVhRvK6gNeuqJwhbxe03zy0kq6OS
   NKOw/TggIuFl2W//7njXoACgrFg7a7qvYDPpZ7v7RL1ROXVUXCF9lqjZ5
   2zjgSnWQZle8FvNET0KQGXiASXKt8UrQzh3TxKTPzJeOGDccMkVtK+qTw
   b21rF8e8Uf5tlF8IolXRNyBzbH5YNgijrpFqiZCxgD8jXFlUr6Z2QMSoW
   ImFoims42qSUasuDWVPkV6c6ETAaJj+RvFLoIsmUfTrzWqa0xgLRew7Q4
   A==;
IronPort-SDR: vzUwRPeVlHyh0yYcSjFc+DFYTu25TvvsiE8zq4BaRWBo++0t1Psof2LTZg4oTKcStbJQa7I8wF
 59BMVeQGYCmqR01iDy6bG61JeUkkcSXBeP1I7hLZaeHHTGw5OgnkDEyNaAZMQRQP7UcrN6+wBk
 tTVH11THR+1GTGy8ChMoLeL8YYylktNGm+xfMKGcYjq0EsqRmq8m8YOxMWi8L+dekL0RZnNO4G
 A944OIlsVBCVf/Ec5t1ZtcGtKCWXEhd8z0/ROwmze2r0xQ8mc6yg0OaGX813hAecrAz3Mp2PLJ
 C7o=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="118174654"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 23 Apr 2021 11:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMPGDdeVsNGw/qE/SZ5REJF/h8GOH+DW65GzmGn48FFZdYJ+9krLi+OVFcEpVMnYswQRPELGLMcKwiztv1DdxBDGmFIdwW8YEX9fIew69TxjmFeWvIiLDL9Qn3E7fWg3CNJ5f4d811zQLXjPr8WJzJf2e7XbhVTRlxa4vI+jNzXfPAq7UYaSBGwzt/U9JK525xc26InHyMI3rXAN9FQcD7rWYMdbVhjCf27tDgSKSIquTuGmT7BxdsPAGqZUjfbsyGu4sLGiMuOqBkB9ZCd6HxEz6b+2SKxBxZu/oDBAvr1qVlm5XigjvrzxhsGGzMchSYu4LJPjqCa92QXNrymVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSeRLMci2TZMfwUcHoWkTFGhUK+ab4S77qCj1mwxtPE=;
 b=NeIAjJUty7JtjuLKT2agMa4HVRHEmBCCtkICd+s75/QEH8yDtmxfOdT+FTWce/fMFbI/GQS55PFKVTtc2au9a4dNPA+3GtMlyN20TYO6tm7ty29ilZBOSJZpdoqmyjz6/O4/Z5lL+WSkLmC7vxxSX/PZE/rceShzAzFo8SR4XVRAoupNCvNSNucDrnAHcecTfAIyReY6ZGWa6GZvrrTCmJ0qnlLi4RdFidN1SWo+V2t5JJNVbboGsTO4ypU9/FHGy24jvE9AmY4bGL3LywQnrzSAS2uVnokfPyZgQBnIchjshgZ6NZzqC3sWMddZL8PZBL07aIYNakdJ4T/NpmGOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSeRLMci2TZMfwUcHoWkTFGhUK+ab4S77qCj1mwxtPE=;
 b=OizuwQBkER0PS4X9AYmxPNceCI3J3DoRWqdjfBoXkZOodOHOqarKI44q8RZfez9dbBT5XW/GG95BG0NIqmwaln24h1X3pmAEj8WLRVPwmj6GWiGtYUkQWbIGVCPsD1+jWwqf1o9bifzTMr4VJPr2ATf5fbPJ97CY8ODtP1XbuRM=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:50 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:50 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 12/12] wilc1000: increase WILC_CFG_PKTS_TIMEOUT timeout value
Thread-Topic: [PATCH 12/12] wilc1000: increase WILC_CFG_PKTS_TIMEOUT timeout
 value
Thread-Index: AQHXOG6lkreKSwAGb0WB+JwDkyBpuQ==
Date:   Fri, 23 Apr 2021 18:29:50 +0000
Message-ID: <20210423182925.5865-13-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 7085c3dc-d0ef-4b22-a634-08d90685c81f
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3318C2BED294884E6F518EFEE3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2xgeK2i7o/aMEKmOD1axBOK3WwIj6y+4mB/0FCgVO1+7CNpibotClVakhV0pHQJyjHFDNO6O97qwywm6D2ADVcwzK28SJLw1Ny24QlIZnBu3l31ttl2HvGKPmuMyoaznIPCqdFin8XvMAFamOp5G5d7cFs50Q9DLAtl63bMb+TCNvEzHHl6DArG82SAEU1iMmdPyVbC6AquvfdHy0oB4F8hLB1pcmN3eWFXUF1z9gUAM+M5RIAQF4Um8keaF8ICUDKhGcHU4wSTEp+M+X+GM8csZm664AJPABQE5omWiGOhjUf55xy3GMsGoq/ILQ27nauZldlJywgLkFg+QDlA4+9FZPyGwhVkpmKGxym9c5jFj9xi+K609rVwMk81P2m76MzffIti713mUOaP8zXmP9Mce7QqdAfiG5vhRIsEvJ5AgtjWzChAG0d++lQH09lJgfFvXTzgGEi58YVI5nrXqF4k/riGyWJ+ryHuf6gRAAA9AeFPTZ6eHpprbnPstsR3CNgSOPyUEyNnoNY24/VjwpCTt03tpb3XdPIvjIxmjQ2a1C8qnHd7Wp4Lg4we8xjIMwDTjvjPe9KYLLhNsaI4YLMR0AoZCAKH0CZl4XzLU/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(4744005)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?YUUKfbn/Mtn9V7sJlZowcIp8b81j/hy12QV/hp2Ta5NGe8H6pyQ1j5JPER?=
 =?iso-8859-1?Q?DqXzWbx2thSaEOL4svJn2xTQq2LaOHEdWHV5fvumPWRC6P0YHUS9BPCYoX?=
 =?iso-8859-1?Q?jCIVI7R9UgR41Zjxe12RF+3rzX08d0vtqpv+k6kwBO3euF8l6QZxRXvXoE?=
 =?iso-8859-1?Q?p9hxFoN8cttXFgRMwvq7vnTwC/Ve5P1pAmZdJIUQb8UznpDqzUqv5HQf5W?=
 =?iso-8859-1?Q?VKEyYJdqz0I8Mklne2sBL/kZgsI96FRhvNNix1u0eP4kh+ktrOpAh0NfmX?=
 =?iso-8859-1?Q?YfXacJGxb6aGFvLzOeT9tdKNNT0xfE0/SITc+3Vsohta3PX+r9/XPlmH/E?=
 =?iso-8859-1?Q?jfUK9wYMDzoUjjMGA0Qit9gZds65tm42G+T4ls6qVNf8aJdbmv+ilNC84n?=
 =?iso-8859-1?Q?+ZlWhx1regI692X08RAC+3R+UydyJ+tlcqI53y/VIJ8JFlq0HRb236clX6?=
 =?iso-8859-1?Q?ESCJQhJ1LsYX6WdLkUxFAkl7jo/EQqUVaKMtyDpsEq9Swgopmbdg+un343?=
 =?iso-8859-1?Q?GObayDY6RMuGHr9MVJ05BDU+WRFzb9H3bbEieZXqXxnkZU7xMt/h5uIFWo?=
 =?iso-8859-1?Q?RMqHaD2Bk3gaXpKP6fG21gW0dH3586eTF+ullO2pHHXL+KrHLwXMH0QlbQ?=
 =?iso-8859-1?Q?vMaEuJNSib3M7qH0Z/oQHKCIsnEGy/8RJCYcgEKcs3euUcnYi367mK2VL5?=
 =?iso-8859-1?Q?UnoVHJdam/syLP7dqkYblDFEqEgsxnlD+h5rZVq5od6wPZxxWsVZdFpqcN?=
 =?iso-8859-1?Q?7hDys1LaoMb+Md/ezexWBGLazvg6Gh6l+FrqiW/ty1S9nPxgW2K4cZxobJ?=
 =?iso-8859-1?Q?KPX8mPwCn2eYgKVisry4ZYiCgsZm7YEnKWC7Q+C5vA6Kj+LTCDQwmuO5V4?=
 =?iso-8859-1?Q?thCVXqGV6reNXm59D2tyZsFqIs8j3OWrtcEmei1l5Zpr1/U/wlerxIzUaj?=
 =?iso-8859-1?Q?UPkXG3zQjv+M82dnzjILWqMRjWjaS3CxedHl8iMioATviDS53KJkO+eASh?=
 =?iso-8859-1?Q?bJTDBaZd+lyBNDWgUe9qX3BbT8dkZ/ke/xtGjhqDQG8DdCJlkbe9i0WJll?=
 =?iso-8859-1?Q?uonTm0SBGb/DZP1ILem1lp/O5CYjuf3Adyj7ZKegUCn3YC5i0Hc+ULTiw0?=
 =?iso-8859-1?Q?56zN+6WQrksAmpP2yXEeY7oPcAVlqGIVbIZifSIHxs8La7l2vhwkFa54ij?=
 =?iso-8859-1?Q?U/KDmYO3aea4dWdAiS/olGySztis9RYZV/wCAqwAkhvu4Edzy/pLwdFJge?=
 =?iso-8859-1?Q?OkBLJpN15EsWMoBa/LBJEHudmgHZI446g5FlbeZ4eGQb1WSiwZtyrDpcUN?=
 =?iso-8859-1?Q?+vsVgfqtyy44jGbyg0vPcnfpXmW7MDURXCzhPozUMxGHbKmABuzAFJB2vq?=
 =?iso-8859-1?Q?pFrB0i/h1zQSDXiQnuX6Kj3WwCkm7tFQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7085c3dc-d0ef-4b22-a634-08d90685c81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:50.6475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHr+css+gidYuFgY0fms6BBoJNyNdqekpBlHfYftV//AUDkLxVXrg1HwQpn+moVtJ0zoRG09Tc8EMb3ls7B8Hla8iDIsNJpdRSRDgJABMlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Increase duration for WID config response timeout to have enough
wait for the response message.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index 8b7c3d1034ec..cb709d3b91df 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -302,7 +302,7 @@
 #define ENABLE_RX_VMM		(SEL_VMM_TBL1 | EN_VMM)
 #define ENABLE_TX_VMM		(SEL_VMM_TBL0 | EN_VMM)
 /* time for expiring the completion of cfg packets */
-#define WILC_CFG_PKTS_TIMEOUT	msecs_to_jiffies(2000)
+#define WILC_CFG_PKTS_TIMEOUT	msecs_to_jiffies(3000)
=20
 #define IS_MANAGMEMENT		0x100
 #define IS_MANAGMEMENT_CALLBACK	0x080
--=20
2.24.0
