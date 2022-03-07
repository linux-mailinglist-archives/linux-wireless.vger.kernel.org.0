Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5154D0560
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbiCGRim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 12:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244473AbiCGRik (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 12:38:40 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC229CB0
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1646674663; x=1647279463;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=2hTlns7X8lHnicg77UEpb0wElJoRqxMmIEokHEiqpOM=;
  b=Bhb3QJmA6Bbha5qnNShBjqfClHu0/NjhR0KgcaXFMT6zMslyzWWxk9ni
   TJ7iFPLDp5PFv5okPPcF8fdaptvXq/TXDlFBXF7YoD3lAqFIzwMnq5X5c
   p24YhZ0wmASa9JKU3cWYft+BHN35z2uJgkwKk37h95EQFlJMm/ADx6Sm5
   E=;
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 17:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5zb0mUSMyOkzrwQp7bYzRvfadqBmmfd441lrnAMex4LHpnVHBjBOCmYwarGh2uJ9aPquhkQPN8m51ZW9d5oUcBp8g5qrWUC3hOhGJofno12VkbC8E45TZ4MMQNGoO5D72GeZ91HH3egrzc4mGNgA5gK4d3FeteOwRGScMicEs+hzv4f36hVJgmkSVfe+cs2YbHxOQvFPgKcvyJs22ynnecnGRRdJ+6xTbFx4QFW7/9UjAnGqys9guPoEdtaExwd9SFv960J0HNemWyRoREgaiR8hxtmKLvc9N8J4B+74878hjxSt65aOvRIhIz0BnuuGLl00V6/CWe3H4ES3iWSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hTlns7X8lHnicg77UEpb0wElJoRqxMmIEokHEiqpOM=;
 b=MuZvQHhJpHhKzl9FPKWDYBqlqSOGxM+dJgPmwKRaCvcVgDPD90pPUvKx6xv5SHJN5F6IYBF8z+s2nT4ttTToKyeyIu83pK3Yr5Y1TtUWMSEmOuCyp+0tYoaWYLWq3u6UyRFJ30IUtJYDhI6sFIZfX60u2oLiYJte+Smm/PskNu4GHC9174tmycRcSTCfYUDj3ysfQbSQ0UMNmAHcDpexTOV499E6LGmBD25qV3WswgC2hidIqrngSnIPSmVJNF2uOIX3wcqj9mSJoK05T7p8AeQNWmZ+xmz+Kz9PBOCW6EeXVHzC5Mku/zgobsb25ym9hN0nmNQhxSoez29z6Cc9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
Received: from BYAPR02MB4567.namprd02.prod.outlook.com (2603:10b6:a03:5f::14)
 by SA0PR02MB7164.namprd02.prod.outlook.com (2603:10b6:806:db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 17:37:39 +0000
Received: from BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::d15a:e14c:36ee:cfe8]) by BYAPR02MB4567.namprd02.prod.outlook.com
 ([fe80::d15a:e14c:36ee:cfe8%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 17:37:39 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: [PULL] ath10k & ath11k firmware 20220307
Thread-Topic: [PULL] ath10k & ath11k firmware 20220307
Thread-Index: AQHYMkjl9NVyIQt1P0GRYhWBcVZ+Tg==
Date:   Mon, 7 Mar 2022 17:37:39 +0000
Message-ID: <BYAPR02MB4567574A7FBBA13037C4283692089@BYAPR02MB4567.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 17564c50-c718-e0b8-14cc-25230030ee04
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qca.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36b2c04c-85ea-44fd-c70d-08da00612d27
x-ms-traffictypediagnostic: SA0PR02MB7164:EE_
x-microsoft-antispam-prvs: <SA0PR02MB7164B037DA21792007D7ABD292089@SA0PR02MB7164.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4ihGdmZe6fUhIuFZD8mrUDw0cChNIJ4iRWEVhhL8X5wmXCy92ghS0+1DNPNIuI3NVH1rAST9FOBpyhFGbYbA7HCfWAP4iOKmooYN8jduSUlxgbA5C4QAhV6qtFAGWrshmE1zPEa4QfySbPGBl3i7ksZVzu4HI9JKUMFdIkoHqm14ZV+aW/NZ+w6feKgCB/mi3WzPUoOwRZmm7tQ1f1IpUuRDbiIxgcMRoFZ1Jz8DMvvxkQxvT9js6fKIfZtqPCvRZ1Z8zCYHtecaqq74KtV6sP7FXmt0xWvESApZqtc1CUCxxNqMJyVbew/IOsxYLFvMadCF332IzZjKZ+ITGCKVnZ7/IKXxMZ0B6jWrHgFRVr4qf05FamPCR5oGiEZ8zyVXWFOClaf7e9/ktONwlE4CbdlOmbyvU1WJElYOM4fyhOd+qp8eTpuxe7oFEFtevWHQmUE4u+RJgqFblf3CF1BA9H0DJDOhc11U1/1z99e9oz5vi5YNFItNbCKVDZlZ3sX12nFqMaUphIUFIi+qXVUVTWlYa1riWAD1ptYlOHLwMQBfV2tbVczhf2rFywVd9nPT64tbR6uRvKYwx7vYQQGwWIwVhbYyG/5NyvAUV/w9fxBe/VSp5jR/oNCK0J4nc6l8ZgXkMdQaciBvEmHNLBYFtM/SHZEcomWnoegIUnLrmIhcRZTrsbrwWbhM9m4HUked+CBv+wZI73DK727Yr3oGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(76116006)(9686003)(52536014)(66556008)(316002)(66946007)(5660300002)(26005)(91956017)(54906003)(66446008)(508600001)(66476007)(8676002)(4326008)(64756008)(19627235002)(86362001)(122000001)(186003)(6916009)(7696005)(38100700002)(55016003)(71200400001)(6506007)(2906002)(83380400001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gbqnj7snDuy7uLJJUq5oGg75Zcp7jzK61z8eLGnXjH/mBkF3hr6UMKKBdm?=
 =?iso-8859-1?Q?wupz9AVIxsbw2U2GK3lsOqbjuWuRvcm6zizthnh5yIdHDBz3g94HeKk7YP?=
 =?iso-8859-1?Q?jM63B6GLIqe9OeOlkzx4T1WneOrnNVepTQoTTrn8z4dWbXCs0rJl9agngD?=
 =?iso-8859-1?Q?LAjVWvAhIjgIxKuGpjJoDDc5Q09Nw4cGGj+KACfas/4+VYX3/kRizZh/ek?=
 =?iso-8859-1?Q?vsgedQOkgBsUey3qwqIRJwr18mbtCS6DccGGM4vBgPbWLVjfPs4KXlCe1l?=
 =?iso-8859-1?Q?8Kjl3Dxq4DhOkBP9Gr54aM3YgEuNlvU43ybMMpds6b3ugW0TsP/T1r02uR?=
 =?iso-8859-1?Q?TY7IFaPadZr61HSES5LGqE2sUkWiyZka76AlXi4dE3jSLsC94YH5/J2Kt3?=
 =?iso-8859-1?Q?NE/6IukVfHBkzvs20uoJIPGXiygP2l2K7pypBiViilUrKs0a+x8pBg97XQ?=
 =?iso-8859-1?Q?7Jw7liEmB8xIaEHy62IlM5XkyCmcjRiT2WN8lGWnen51tPjd25BnLP1ZYw?=
 =?iso-8859-1?Q?vULTykCFMMkGUoegAQEKYNQ2ZjR0P7vhWTozq+dIrxbOxUfqht2QpKH0Vd?=
 =?iso-8859-1?Q?53JAv0l7tcEhOFXBFG29uwp2xvvyJuGS9Fiy+yc7bZBoylZlK/7bQM+zmy?=
 =?iso-8859-1?Q?xWZkwKSG0woJ7lBM3uCiaOQKB6lJdbV9HuFjLF+eM+vhtgLi1LIgoGydOl?=
 =?iso-8859-1?Q?1LxUpyqcjEaLb8B6KANkywTqIwunGyIiyHlwZTwFek1/rV+hbosw0YK+wj?=
 =?iso-8859-1?Q?cMkxUecmI9K7QuHaRZTI0C+g1DhnCW9feaNDPyDakGEB47icjqpYbpwCa8?=
 =?iso-8859-1?Q?DbavckLhpdIRIa1cmlS0qP9J4bRi32JVFggxB/s+jmxnN36mW+VgiEJ+BC?=
 =?iso-8859-1?Q?4+SEE/wQ3m4ZSJvG8XVUHjE36vdjB2ZAAUjYOu7YxLQXQm4kaG+PB0bk2I?=
 =?iso-8859-1?Q?JigfFsXTWIAbptgb+Svo3bLnHmcqyq++8dx3auJONLFB357i2NTP6E6Juq?=
 =?iso-8859-1?Q?q7GlP3zhJYfx65+8m1YbLS9GauOrIkjKYSU5UzjKwtCA1rEM2sBdpr+zXC?=
 =?iso-8859-1?Q?5nGI2yNf0lBSDXACrw++cQZRVai8mB9Iu+EmCxDqWMAAjTHFOrBSOm/ekM?=
 =?iso-8859-1?Q?1LJsMK8mx8WSdbwC931KWBVEX7PKTvtm9ufAIsIcN1d4b2wP8/EEY6o93y?=
 =?iso-8859-1?Q?hlZNZk3R1/K+GX5efshHfV/f6MKKAfFcRtRi5YKi7SZbfZzEtdRYKyietG?=
 =?iso-8859-1?Q?PThLZQL4IOHBsQstMtMHccWiOSoRpJWTVRpA4OoTrHp8PbP9HcnKSEVW/f?=
 =?iso-8859-1?Q?xXcliUGdJ3JGEIfoSSpkkX7wSYTQUlo1r0qEWGDvU6hpz3d8Vsol+I+OD9?=
 =?iso-8859-1?Q?3WjcEQBqW3J1qlwgZAU9KHEJuukeQJxnKXcgA3JcshxKMvAOT7l0w9qQ/X?=
 =?iso-8859-1?Q?0BIzooWNy2xD1PZbsN2K4WwFocAs7hMrVlh8jDGfc99ePnZlrrmyP6OnE7?=
 =?iso-8859-1?Q?FcTNjg9zG1L5wBie28nOOC7MBC3UAYb3FT3gV/MKDTGt8Jbl4lz1FFcHYL?=
 =?iso-8859-1?Q?ROcFEmx9k3ZJOr43SxBh1qsP3tOwi7LftWBAfAW/s8ysRiicj5mux64U2M?=
 =?iso-8859-1?Q?SFdH1QSKTZbe7DvM/1aRny6vVPGZiQwmBoVpTLnUUh/lfYxrIecjOS/g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qca.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4567.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b2c04c-85ea-44fd-c70d-08da00612d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 17:37:39.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91w9OgCkK2evnfGBAvpMAemtq9I1RCWTpAh4tJvqWUvpC/0uuPFI+O6AuGTyz9IJFpxbKoYF6AvYuA5J7ozc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7164
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,=0A=
=0A=
Here is a small pull request to use "File:" on all ath10k and ath11k notice=
.txt files and add support for=0A=
WCN6855 hw2.0 and hw2.1 hardware families. Please let me know if there are =
any problems.=0A=
=0A=
Kalle=0A=
=0A=
The following changes since commit f011ccb490f952ea35e9ce4d73ca9b7d0d2453c3=
:=0A=
=0A=
=A0 linux-firmware: add firmware for MT7986 (2022-03-04 08:43:26 -0500)=0A=
=0A=
are available in the Git repository at:=0A=
=0A=
=A0 git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git =
ath10k-20220307=0A=
=0A=
for you to fetch changes up to e8bc0db413b4ab7f8e540ffa17991ff61252de9c:=0A=
=0A=
=A0 ath11k: add links for WCN6855 hw2.1 (2022-03-07 19:18:22 +0200)=0A=
=0A=
----------------------------------------------------------------=0A=
Kalle Valo (4):=0A=
=A0 =A0 =A0 ath10k/ath11k: mark notice.txt as "File:"=0A=
=A0 =A0 =A0 ath11k: WCN6855 hw2.0: add board-2.bin and regdb.bin=0A=
=A0 =A0 =A0 ath11k: WCN6855 hw2.0: add WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_=
SILICONZ_LITE-3=0A=
=A0 =A0 =A0 ath11k: add links for WCN6855 hw2.1=0A=
=0A=
=A0WHENCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 46 +-=
=0A=
=A0ath11k/WCN6855/hw2.0/Notice.txt =A0| 3658 ++++++++++++++++++++++++++++++=
++++++++=0A=
=A0ath11k/WCN6855/hw2.0/amss.bin =A0 =A0| =A0Bin 0 -> 4972544 bytes=0A=
=A0ath11k/WCN6855/hw2.0/board-2.bin | =A0Bin 0 -> 1322820 bytes=0A=
=A0ath11k/WCN6855/hw2.0/m3.bin =A0 =A0 =A0| =A0Bin 0 -> 266684 bytes=0A=
=A0ath11k/WCN6855/hw2.0/regdb.bin =A0 | =A0Bin 0 -> 24310 bytes=0A=
=A06 files changed, 3686 insertions(+), 18 deletions(-)=0A=
=A0create mode 100644 ath11k/WCN6855/hw2.0/Notice.txt=0A=
=A0create mode 100644 ath11k/WCN6855/hw2.0/amss.bin=0A=
=A0create mode 100644 ath11k/WCN6855/hw2.0/board-2.bin=0A=
=A0create mode 100644 ath11k/WCN6855/hw2.0/m3.bin=0A=
=A0create mode 100644 ath11k/WCN6855/hw2.0/regdb.bin=
