Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A36FCCC1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjEIR3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjEIR3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 13:29:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427403AA6
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683653353; x=1715189353;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=iGO/Ej1zfT5QGpXiwc1KKOxocG8E8DHbcaAd9f51dnU=;
  b=ICE8lgMlJ13Zn/V3Ovs/klM1/sGgBHxBgUKuUTP3uHuH4JrC/B/q94zi
   5O/IjegEI5Nank+dfTJ8Z6ZhYL4YDxzkhogmjkOg0Y+YuvP9+H6WPMjU8
   c0QAHGMCjn56H/P8MytZYGyVCpCSPGeEc7oPjcX5owRKs0xS6A4buXIdN
   CNhM+uVCvb7Zd14u9n1YdWd6/vz6vOy+AjZ4vQp1nXb9KkstU2tcN4noo
   3wYmgCt1DHOpSLEzURup54h07C4cHPINWQkAEI5NIlYCrU8RIPvOSislW
   G8YfNispgg/FA/ARSWtvWtQG3rJax6R64O4rFLEuF20c7u+Hg5NnUedQt
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677567600"; 
   d="scan'208";a="151161360"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2023 10:29:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 9 May 2023 10:29:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 9 May 2023 10:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjAMKiZgZtb2BuyQPw2/zp4s2ktuQBoGuxsnrlUSXYA4tCJ1UeB0bx8YA1T6qso38wW5O+FANwfdzb1tJFbSn2hUCe0TmfcmITazfjdaKYczh06Jk6/Epll8Mp0iaKN/ge+1ZOGhJyArvRw5Qhvvkv0ji2Q1kKhc3Iz3D3i4obegOk0DDcmMsi2uOyjGhj5Uk0bKqwLAti1O+5RAOrRXTDiSKSWwtGks5yZyhyZANsuZz3qKWKc/DTGc9ZUgwZgDIphM/ChU3md7NqDvcf1Ak1rh4Hee47CTFR+0OtYvvJnzt0wXdQeAtMAoT6peW/+bfR73hioAr07dxfyPh3fXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg6Sk+Z9xzLSMuOCKVj8bzWOgvKPuITyU2LM1h5/OWE=;
 b=hFUkNUPvkrhV0yrc4lXYXpN0tSlWpbZf11Pqtc4+6dw62s78Wy1BcdWpbNXkdzwQSchdG0HoxbYc2TTnwGb3Ry2ZLfkyjK2Jo5UeqCc789j8htvsF6gLAQxUXwcIwf067jhIOdc8Q4o7VQJ5iowacmJMy1AHRvfCq1HM9zlWNste+Vd/2NXghba73F6KASgfG5HHhLmEFmfnu0GiyjYa1ibTh91c9NoWeFXmHiGirIuj275/Myu0eBrsRCLXvcM3uDOlu5qUEyqZdtV6vHjhsgBA+x45FDjWYSvqTdOXH6xdZHA18c44dUEa/1t62efeaj8/SwStL4U5JpKiDPf16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg6Sk+Z9xzLSMuOCKVj8bzWOgvKPuITyU2LM1h5/OWE=;
 b=Dbacm20D1Ms+tRFyfHu5fucq6PjryQHn0dQBzdI0zQVmCLQsnPxI1BoQFjLVBhffHBsZSNuPpK6D/wlSaR6s5L0sGx1qHr3azeCM6mOlhG53vacS9WFkKtw1JumuY2bfBzHWjvEQicmmZZQlc93uowywyH93nTixyqyNYDQDOvM=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by SA0PR11MB7157.namprd11.prod.outlook.com (2603:10b6:806:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 17:29:08 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 17:29:08 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH v2] wifi: wilc1000: Increase ASSOC response buffer
Thread-Topic: [PATCH v2] wifi: wilc1000: Increase ASSOC response buffer
Thread-Index: AQHZgpvD4gHNzzslwUWj3ZZSN8BEeA==
Date:   Tue, 9 May 2023 17:29:08 +0000
Message-ID: <20230509172811.4953-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|SA0PR11MB7157:EE_
x-ms-office365-filtering-correlation-id: 43807e82-fd5e-4114-b33c-08db50b2e584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nqRI2oLTEHTD4VtsrntYPt5QDFPrzFXTFfR/MyEa5JRU07ZHugBCIXdBl6Ak+2+DABeURJoytxNF++0E+oIV8SIQs9ER00ifkhL72IxmquiaKTWn+T3qJU4iSDKTPdLOlGajHbwk2TAe1HJhrYW0QQW3MfqVXFHDA/ix0oX5luRK6kwUJgZVNqpJYCvz4DIZhsHThzac4lUTx96ql3H/Pm7DCbeg55Mxo+oLZEDecqdNQMc0iWZWgs7Sk4K0xJrZK7bXRNF+OwiOVGsuQbiClgUqzOeBVZlhVwzSJQD7A2IIU1iJUwTPXXl4Qt30uiuztzdUINcFjgj7XMiN1LxUpow6klrxD5EFUIyMO6G4ZIwYje8PfNNSH01d6TLIL66Ha5Ob53umjUpSKb4kbeEbjD8qYd4kDeIebojd7KkbqnxtXEWZXo6nH7mOS0ZP0cRyIv7D5gHXvvlbwWLIps34Uu2UmQdT4fkLLqzgUHTZlJ5WO4O65nA3CPXUbbx+lNYXtrarqpp/oKDXC7TzjtuMXZ4w0pQA7u34cMu7h5Vd2sBPpd1xYEhxkXdWxUauQCwzzKldQMev5zve2u1ADp2b6zrCNqcWlkmuurPCQfOdkFYRgU1ASMooJadxR+xQVKz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(122000001)(38100700002)(38070700005)(36756003)(86362001)(6486002)(8936002)(8676002)(5660300002)(478600001)(26005)(1076003)(107886003)(2616005)(83380400001)(2906002)(316002)(66446008)(64756008)(71200400001)(66946007)(54906003)(186003)(41300700001)(76116006)(66476007)(6916009)(66556008)(6512007)(6506007)(4326008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DijIVptpely4w6l9nJLgES4CqjngEgd6nbriJqRABYSuRr3xocy35/GpsV?=
 =?iso-8859-1?Q?VGoCEhsysNFvkr8opRy6d96ZnkloTNl49IqlXxEudd7q4/+5zuQwycsDnb?=
 =?iso-8859-1?Q?j+GlmTRpI/rOHH5xgVDB6vemVjm5vXCLv+FHx0EIoa+0e+k6XdrkeeO+YO?=
 =?iso-8859-1?Q?fTZ/c3Qakk3Jwbywt7DX69pWlNNvLcBQiPhkdHSk5RKFxfJRl/gb1IVRj6?=
 =?iso-8859-1?Q?07ghrTdXoeis8ncjvu5RWuBfSJhkc9WCdRtyPvVoqjxC8uLRYnFuWgnKy4?=
 =?iso-8859-1?Q?2g64EHD//eD4FfFsxY1cRS8Lc6/df742BBVXaNSpI5uO0q6OwtCETPfj8H?=
 =?iso-8859-1?Q?NjKDAvMaXXL8UzGvRX+CZjj5SacQu1Wzcf9j2OCIFhNvQnYFwZ3IBy82BS?=
 =?iso-8859-1?Q?NI+/XDAJ3V6Lqde8u6tYCF7d+HEkakue+z13cA3xzk5CQbySDN+Pu8WMAS?=
 =?iso-8859-1?Q?QOiLXFtE7gH0szzz9WRO4sjUIeDtyg0gOXblUzF60tk/NksMGeSVz7svFI?=
 =?iso-8859-1?Q?oZLN/0bH9/7kuhwfjcUY7JZR9eEkBGgumXUAB0mNnQx0qx5uesYqNuSETQ?=
 =?iso-8859-1?Q?basPUwnOPZXYupKKQUVZf+9ukWAAQ0OZrjuJXPhwIxo5Q8L3JDPzHKCFIs?=
 =?iso-8859-1?Q?byhLNKTsLPE4iHPucZOlMVuSxho5zOxt+fvVxvDGwEPvWHYbkkKk1FR9QA?=
 =?iso-8859-1?Q?AE9ufN3ktwpNteToaXtg8ncbySrUtXr/M+5LcXdYEqzYNRA9f9CeutqBbM?=
 =?iso-8859-1?Q?3C6bNslULY2t9UEU5cxWacEMjjMpORpkVuJrngXMXz7M+e5n0/tYMk9gI2?=
 =?iso-8859-1?Q?VLGOzX69yU2Z9Ylk3+bYbzQXubCMndgb4V5Kh27K21gzJnz4JTYK/nAn2a?=
 =?iso-8859-1?Q?/nl7I6BASmOk6igVnYnuSgIlhJ0L3sw9920iKY1Byt4RHtHY/dC8nazCi1?=
 =?iso-8859-1?Q?olMo0nnRkr9e48ed7z3ZTbayBaY6GuwPL4pxxoYuxuK+tkC2yLoIuPk+ar?=
 =?iso-8859-1?Q?+KDnCNEoelowz3CrIhpbRQIDoRH5zJ06CZywXA9qyH3pf1BmzTUgJSt4vk?=
 =?iso-8859-1?Q?/Hn2uQVV0VcixfN2roYQ6nJsPxKgiCqV48vs+hh40pkgRhqgAb2OkCAp1f?=
 =?iso-8859-1?Q?5F4kjJ/RX0gWH+B+iaTmMPYLBbxff0nZu+QqxPp/0LdYW4OFJWn2CrGMy9?=
 =?iso-8859-1?Q?Y2GhizFm8xn571BVA+d74StdnombXfeJ755o5IRmI9EodA6UnS/Au7xnzX?=
 =?iso-8859-1?Q?nLSANvedX2YS3sHYji6MsNQmUbOC3mjxw3mYI3v9sXmKlY3GRu8JuTQHnm?=
 =?iso-8859-1?Q?vjrskdT7YT/Yx8ONb0vEbehVjygYCjKWtCiyMcdhbrF4ozryKNzgoy3Pzv?=
 =?iso-8859-1?Q?HvMNiYdpLxvZLoEcgpyh8JsN86xHfjjKT/WWiDfL9k2/c21FJCLjtgAc+o?=
 =?iso-8859-1?Q?yBrjo8eoX0dBD/UGAhUiZllbh7PwF+okxMo28MVYsRKbOztvhsaTc9QdbH?=
 =?iso-8859-1?Q?BWJA8lne8Vs6IBKRzvykCz26QBUkdk4URtA2M1zEFUjrkW/RSbpUN+keiJ?=
 =?iso-8859-1?Q?Q04nVzsdD9wHcu63SLCcXZzW8/rPtcjEOhOQ+m7BiHCyBDadW2TakvjMZI?=
 =?iso-8859-1?Q?677NsRUTQrvhgV3N8ahg0tUakXVXkFUHzcvja9Yxw2A6O9e34sKSDWFA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43807e82-fd5e-4114-b33c-08db50b2e584
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 17:29:08.7834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTwePcOX2RdFK4jiFFXKFrke2pD36JVte0OZ0HBWFuPGe2a77sJELGvh9k+surqKLPW1CbVYmridr8v02sAJog+kusNsz6r8uG7FtTy5kTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7157
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Amisha Patel <amisha.patel@microchip.com>

In recent access points, information element is longer as they include
additional data which exceeds 256 bytes. To accommodate longer
association response, increase the ASSOC response buffer.

Signed-off-by: Amisha Patel <amisha.patel@microchip.com>
---

v1 -> v2: Fixed From field and Signed-off by field.

---
 drivers/net/wireless/microchip/wilc1000/hif.h      | 2 --
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h | 2 +-
 drivers/net/wireless/microchip/wilc1000/wlan_if.h  | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index baa2881f4465..8e386db72e45 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -30,8 +30,6 @@ enum {
 	WILC_GET_CFG
 };
=20
-#define WILC_MAX_ASSOC_RESP_FRAME_SIZE   256
-
 struct rf_info {
 	u8 link_speed;
 	s8 rssi;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.h
index 614c5673f232..7038b74f8e8f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.h
@@ -30,7 +30,7 @@ struct wilc_cfg_str {
 struct wilc_cfg_str_vals {
 	u8 mac_address[7];
 	u8 firmware_version[129];
-	u8 assoc_rsp[256];
+	u8 assoc_rsp[WILC_MAX_ASSOC_RESP_FRAME_SIZE];
 };
=20
 struct wilc_cfg {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index df2f5a63bdf6..254a046e3b1b 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -10,6 +10,8 @@
 #include <linux/netdevice.h>
 #include "fw.h"
=20
+#define WILC_MAX_ASSOC_RESP_FRAME_SIZE 512
+
 /********************************************
  *
  *      Wlan Configuration ID
--=20
2.25.1
