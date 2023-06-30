Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C99743231
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 03:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjF3BWk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 21:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3BWj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 21:22:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7E2952
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688088157; x=1719624157;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=yrUk6oGH8gKbwYsg7VyF2135He62MpIS79KLLvm+ecU=;
  b=mCilD9ZTQGQyFBLhybWohij1nY2PmuknaENyBk3e8O9MMELbfMxsP8au
   smJI+IZxCee79lzb9m7nmqWe4sbgHbnveH4sZ7VBRcA/9b1ziKtIUoVJl
   zrBGM/6y0lb/Mv6YJv8hLEIDTVSUN/iXqpP+BVYMsfeqeEdPwg66yWzin
   4czmPCwruVEHZoplv7TMQFFFPVXUd6RuQZcVQ77KG0fA8fp/TQxqDznJK
   OkIGjItqFw2dzb+StvvEZhoeb6eTpAtxWO1fDc3YGe/+8xXnYIWPJPOsi
   kjOlzRYskn843G5XPpvdTSfs+q/Eqn+aRUcARBKycwVknLbl0IFCqpwzT
   w==;
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="220612689"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 18:22:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 18:22:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 18:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddXVGy2an2pZUpSzg4jRZ06In0bm/9isJp13asrpykndGbKXrAEVyjdLc5/cVChf/WgHZbfbrEGwMTzZa6+OPKeVTvwiFmHf4tefM7aulbyWq8MMCzMUsxPuwcLlwT8n0IJR8hOyFJRbb/fN2EtRPsj9xBSZxRVxwp2I/invFk5zJcWd9H2MEnsSW2eB64lmngEktOmcxIouH5DzHgLBgxcRAAroXTHAocukYmfRADg4rD0dVgp704qQwTac1/+YG/RXXZlZIY6t/Y5LGM+sK4lRQC1gmLFvVc/NyDzpILDzmdnRDnwfwVmFk3PPshnqo06C4w+5XIK/3vGxP0gaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G99wq4p35JGUUY2LzkZ7LBzisOOGLi4L+lzR+LROsU=;
 b=iB/0hs4MoscX1V/v94+KJJv7LQvllgSnb1OO/70s3WYqRme34LK0VakGKzNe6lHFUCt07KZKwy+5wuRs6Ln0hPo9f3AhikOC1iMYvdlIh+0bybkNm8MwpEYJRkvEwFv6aR/5xHX4FInDwJexLZqYQv4mT877UK1tyhHRrXKQZLmwhwA7PABLVh3KBF3bLpfg7MqOK2nXX7clBqOH5DqC56hykwpMP+IvqWYcMFWUgLnXuSqx7J7cPl5ZWUJx6eBLmw/Z8+Hp+0G9dk/uykfWIZcrCgYtytOAUbw/95jg3xeoZxelqIqMpRT8F3SpriJX349jZ70XUGqUrVEgcFukFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G99wq4p35JGUUY2LzkZ7LBzisOOGLi4L+lzR+LROsU=;
 b=OEj4wwyg7W2gEoNhuBzJFMqZSodgBJf9JbpOBGHAMnecGwBIaddcaUEd942eKErbdQ8bebCDNVH7QAcq7LCfCapL9cP2SRwgrqGX8/NFY1NxS/8ANYri/CFozDdxFMwoeCeq/JrchRMcVzWgKP7CkASavbmdco23RyFHNuGQTBM=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 01:22:31 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 01:22:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Topic: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Index: AQHZqvFXCQeDDa3WmUeOqaeAVHEhOQ==
Date:   Fri, 30 Jun 2023 01:22:31 +0000
Message-ID: <20230630012136.1330784-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SJ0PR11MB6743:EE_
x-ms-office365-filtering-correlation-id: 3f3e2838-10cc-4d5d-ac96-08db790879cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6vpZoJACziiK0a456ZKJAyxUdYucJqIDzfEehyGSVRZdMSRoSlNxALi0LaU9ghJNFmqz9Nz6Er9MJMqfgsyc4dysA0sAPk/nB/D0c2KZZAk7KccIJYvHdcW6dRRt44eITLM+m699Pg1ms08rXuSeCsD34KZFuNPU7bPoRHHtfvcz5Eo8o2IDtDBUHnWKzCRyhc81Mwjr9nKw1/RsRbNNFSCVj3zJ8pfrBuvxicyRU8Skx5zFxo3ZWbLfq241yj5+OzxWueVe+dve972r/3VRfIKmnPhkeBdND8+tkvvYcv1u5wzDvH9L9lh5y7bTLlyjIPGrQMe6ulTIEcqF3C46HvKdytvyCE5gkRlINpuFGvuPo5sMK5OB2hHUPyTPFrziNXwcoDrdfDG96gk4a8GOQslz5IbXfIyh2XXS8XiPE7VKcoR+DBbGqjUqTaKCqPFzmWnkZbzSMtX62mkLbKbt5nKxMY9ckre1ygXmlhnVNRmSm3zMBC8aJjaOqSS7gHtRXWGwp2eQN0kV2qlvZB7JwPjNSd3qL1PMo/9FKASdbPJoV/ATwcnsbfjWQc2dPmOP+8VHpKA0DS+2ZJy1zP8s0U3ZibPwVgW8LOkEYKf1fQz5pul0MZUlJ8NADzsS6Uq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(54906003)(83380400001)(107886003)(2616005)(64756008)(186003)(478600001)(71200400001)(86362001)(6486002)(91956017)(41300700001)(66476007)(66556008)(316002)(4326008)(1076003)(6512007)(6916009)(66446008)(6506007)(66946007)(26005)(76116006)(36756003)(8936002)(8676002)(5660300002)(4744005)(2906002)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xWe/D9ORMVIK+eTU223fRwoO0m5z6j/HnCTJ4+jzx+DaGMlEY9B6uvAS8S?=
 =?iso-8859-1?Q?qRf299oczhRRWBkiJjFt+LF//6/nk2afJGvxMW8uubU7/af9aQT9r5E7Ay?=
 =?iso-8859-1?Q?dcHEuroyAPy6HduT6MTsPUDxIMzjzrJT/o0TG4qiJR7DnSyFGXMXy8U+KN?=
 =?iso-8859-1?Q?0Y6cbkHWSJPHsbsqRWMEZzhBL1p365vdp7jNeRr7VLN8JNLsBC+GTC/FDj?=
 =?iso-8859-1?Q?io76fkr1yBZaQ21xq4Dmwv0L/VIZjUZugQrSZngE3cyn57Pm2HmfzxczHl?=
 =?iso-8859-1?Q?4/eZ7ErLuElljftrCI3AfEYp4+YELALZ7IpDBJE5HI/wnpEjm/7Mvr7jCw?=
 =?iso-8859-1?Q?2RMZpvpClpj9jlvrPNL/mJJyqPv8RgSuOxNPelwprfqORWZ9cPoDETACb5?=
 =?iso-8859-1?Q?TbrxSkZ4yG3bbXs7FyNMKfIul5pzCcrtdIl/GcJ9a9F0UBKES4rFY+QfGi?=
 =?iso-8859-1?Q?NQqyTQLNbT6AUEq/Yyf8/RP8c8c+LBvadXspS/aUHPe5LTegoi/ebzPLyX?=
 =?iso-8859-1?Q?Voqxe4X5I1CIxC75ViwwV6IGUtYRPwTB56Kjgp6+XR5r7T4DBZY8DKU8f4?=
 =?iso-8859-1?Q?nhcQPA1qo3GZzS2E8c6ihhAU0O5ZCLDjde/oJuJj41kPJ6EYPfthdxPHsr?=
 =?iso-8859-1?Q?SS8sLkZqi8fzFNi4mzqSrbTbgDzJIL5+i8p96EYlkswszFAbQGMN3XpZtx?=
 =?iso-8859-1?Q?pX58PHSxe8f4kE4vuK58cBCd97jvN5vLdHG1SBkNFWhlj7VQED7IsOIUZn?=
 =?iso-8859-1?Q?Gl/8GbR6KUTZQCXtFY46HwOTosvYk2teoMIQfnu1ddMibJ56qkcXlCPunj?=
 =?iso-8859-1?Q?scFV7tarFRPeMvklq6BycWylBi3kDyM5Yld4C+nmstbxEqbeCNZMhRwRrm?=
 =?iso-8859-1?Q?KLDvb5oJlKTcdurzhZVVPZb5ip4TSuuLVpqpEZXZ2a+TW6g+TDDvZYRa/3?=
 =?iso-8859-1?Q?vgwMcZwqfvY4Ah9EGtCSRz6DjaMjfGOZudjDyBgBwjzYLMHPUEce5czopD?=
 =?iso-8859-1?Q?8txWJcsJJS1gKSf4fRNAlNbztuu96z9dLXTlqHwz3j+ZBe0dABMLymXHOV?=
 =?iso-8859-1?Q?aUL6fT1fdtrspAeENWht7pwqkuLW67R+eqJ/spYpKTDLiKQYzvX7Sequbq?=
 =?iso-8859-1?Q?iGNkGAERh+j6w0fN0xEE9uPrPi/0k0k3pKo609jyj+DzuqQhyjjcfvsRGh?=
 =?iso-8859-1?Q?lIw1DFlx5JeXovY7teUYAoVNUaVCPw62COqGiyiifYEO60mm7k/KXFKBcw?=
 =?iso-8859-1?Q?rDwKQZ8rVT3+i85NtLh+TI5gNqg1KXGqlzqeRDwg9DeoCT9iGn2VsdGgS9?=
 =?iso-8859-1?Q?dVSfVx4vnwqQxquXf/uQND10Rb5iHH4c2gTbt5DF4kBcL19rU9Y7iJ1J1h?=
 =?iso-8859-1?Q?xyFfLD2kG7PcRnVCNznobaZpTbAlVKeT36Vrpqw1K7VAbC6WlYOTfoS3JV?=
 =?iso-8859-1?Q?NK1mP4YBRwhn0mMOIJK4bUmV+koFeiiWSf6Ny3z8JBR+Eh/o+GoTs22MAQ?=
 =?iso-8859-1?Q?eyJVmd097QSaddxX9CswDIHMtOL17trIbJhNEK1Aw3udrcKwRH/of2Yg5B?=
 =?iso-8859-1?Q?AN+a8n80rWM5jhedq5DtxVr7BX/Tc1ZUYDov8j07GNr7jS6T4z42T+AsGG?=
 =?iso-8859-1?Q?nKNU1xWzpR9TpG5JtHLTRKX3AQ8KMyD2F6vDcg1f9MTKzrQ0rZ5OhDew?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3e2838-10cc-4d5d-ac96-08db790879cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:22:31.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+HORbdcTEspmEwtPnYI+1oFNeVN8+CB4Nhf8rezFTgt8HD2ciNyFy4gxs2AkA5spdGK7JFOAbJBgUel5WCo9mdzjfMCtt+rE6Epsbjjwvc=
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

To inline the linux-firmware path with driver, the firmware path is changed
from 'atmel' to 'microchip/wilc'. This path change will be submitted to
'linux-firmware' as well.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..4551514b4f3f 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -19,7 +19,7 @@
 /* latest API version supported */
 #define WILC1000_API_VER		1

-#define WILC1000_FW_PREFIX		"atmel/wilc1000_wifi_firmware-"
+#define WILC1000_FW_PREFIX		"microchip/wilc/wilc1000_wifi_firmware-"
 #define __WILC1000_FW(api)		WILC1000_FW_PREFIX #api ".bin"
 #define WILC1000_FW(api)		__WILC1000_FW(api)

--
2.34.1
