Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8736E832
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhD2Juf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 05:50:35 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:37282
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231722AbhD2Juc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 05:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkLS18yMKlDN/Uv1Mnb8zGei5RcJ8o4kl22yroLl8TfK6pmfbMilP5n48HTvWIezhnuTR5zs0prhQ0jdhYzeIvXR0Vt4T4Vgf0gsi9oA/AQbicZF5GFYqLbChZng8RJE5GbFI19lZZZHHuV9i/TOAVwC1g0/+OL6/B7SUIGeYvY5YxMAE9xNyud0onzuOidsqyaH8ehnKZM5ijkTY41wMp/SQY1YxZl/BgvCeJypMW6yd4y6jiDsd4Eks0J1MFZXD7rlilnYxxdsbFnu/3toy7FDNl9Q4wDqqap7mePwgWH7QEZYYARkSFJ1fW9ZQ91iOgGSqZvvQ7KV4c+fb8FfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hO0QDUJxAq85PV/BQ0z3v3FNOHRHAJS2iVzSBOeFIQ=;
 b=BPpLjLDZfuTuyzVkxchC4wA52Z83kMdyJ6XIkbW7DbSwWd5XfWrBu7jFC57JqTS16bwuwiN3ccfPWQYUQxDYhK246UFOxOwbTfG0GGZnXOq60AKOEA8hko0x/SvMoPHvtT8VVkNPd0I72hvCFqBNd2gVFqQWf27HthmLhHthVdZOUDTgb6bF+aeFbhP4nU/UqLfbNF6NeQE+nSDdyRWmwsTuVzGGVWWatvdQ5H1Tka6sZbe4BzZsYGGkqC7/kGcTCAReWx6A5Y0+TS0ORMO+winEANdIZxjIwp7pC18KV9abqphtuEjmILCl51qQ1lSeJcr3FjSaYv5QBwDKRygSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nordicsemi.no; dmarc=pass action=none
 header.from=nordicsemi.no; dkim=pass header.d=nordicsemi.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nordicsemi.onmicrosoft.com; s=selector2-nordicsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hO0QDUJxAq85PV/BQ0z3v3FNOHRHAJS2iVzSBOeFIQ=;
 b=Ia78eyAb43I9NoWnkMcL2ry2Kt5DV3aAh9eYHeNeIca9wWeP5t95r/Pzyikteijjocx+mp0sXYwj/gngICnh0myvPBSAMFFA5inkbdyptXYDUJfgh0MGf6BR5AW9H2AEGK9yq0xV/ioTUIRpWp570X8SpOKNMhsGOH4eeuGR+z8=
Received: from AM6PR05MB6389.eurprd05.prod.outlook.com (2603:10a6:20b:bc::15)
 by AM6PR05MB4213.eurprd05.prod.outlook.com (2603:10a6:209:47::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 09:49:43 +0000
Received: from AM6PR05MB6389.eurprd05.prod.outlook.com
 ([fe80::f0d0:c633:e20a:8495]) by AM6PR05MB6389.eurprd05.prod.outlook.com
 ([fe80::f0d0:c633:e20a:8495%4]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 09:49:43 +0000
From:   "Nuvusetty, Sridhar" <sridhar.nuvusetty@nordicsemi.no>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RFC : HE Rate Control Algorithm 
Thread-Topic: RFC : HE Rate Control Algorithm 
Thread-Index: Adc83D2bUppCaqN6QN6GgQuuGS6O3Q==
Date:   Thu, 29 Apr 2021 09:49:43 +0000
Message-ID: <AM6PR05MB6389AF0CDF09B2587E390491F45F9@AM6PR05MB6389.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nordicsemi.no;
x-originating-ip: [106.212.252.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2ca4e4b-07f9-4e99-09a5-08d90af41dcf
x-ms-traffictypediagnostic: AM6PR05MB4213:
x-microsoft-antispam-prvs: <AM6PR05MB421325E3410F322F3E49B4F7F45F9@AM6PR05MB4213.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JW8FL9T4KEKTEUrm3GiI5KmJNyfraNhBCNU8KBDO0QbWmgW/+19W2vpIQyo9EWuC+kLXNsj+lJ9pGrWCKB6Xg9xYb7ey9UiszF7HkOmSNpA3khWggber1KuLkIRWnJau8n7XsW+NkWjv4/hHCpbusAHfMxXFAb8r8HTyHwsvay18nZnAAAqMwDfnOH5ORhZxlkgL3YK6q2w/Sn7rLvyfFpqOZS+xSsdOz4rLZ50faJdfAWJKM6sVaTElPWdpVaee2IFrl8TqY+XgyUCL/GLixvQCUDNzjJn+fStI7Jl1if3ad10N9giXJBnWqDFqJowDa6cGMkSuZ4qMRpEQwSe820LdNl3KvM2ck6jT/sc7EivA+N853ixySgNqynoxp33p13k2qeLX8y3C+ZtVMXTQ+3pVQbN74P3+s8XuwDCP5x8OmgkFePM9EoPVjvATm7EwBhoL106laxgdN//CEOSY4su32camx5AIi4q3rOYLoHVpWguMNYZVBIJE52WyX0APvqo7xSq8MdXGhwyOuqQ76jFSoYiOMHGTv1JML6XEINX0fQAVTLl0iDPNOeFOylarPvpcvp/00ZrCbufeywh+CPjNYr5QAczsEmzLIgQdlb4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6389.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(83380400001)(4743002)(186003)(9686003)(66446008)(26005)(71200400001)(33656002)(2906002)(7696005)(5660300002)(478600001)(8936002)(6506007)(38100700002)(6916009)(122000001)(52536014)(66556008)(66476007)(64756008)(55016002)(4744005)(316002)(8676002)(66946007)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KdUY1VTF5qfr0NCsGdrX4vefjl8HHeU3Hjd4GfcVXj4fFjjDTBWvNxgwEusb?=
 =?us-ascii?Q?awmel6NQr7mUkIRfXsx6Xq5vprwb408nNcxpC0qoXB2CHksuI6Gk1dUb5CX9?=
 =?us-ascii?Q?RiayZIul+rf2FAk8/06kb9ORRK9oCtHw25CSWkENVfmyAP3Y7hRzIbWrRsFB?=
 =?us-ascii?Q?wuxWgzYQ71WyCsm82wkBNdq2NZmeF5KLa84LoYaJOqZWSKzbs2vsYvNhyYu7?=
 =?us-ascii?Q?YEw6pES0AwbKqr7kziUM4kFQiM+OeuWPJtLb07tuxcYSqotiNVEVcAqYELKs?=
 =?us-ascii?Q?jkUeOWNgncLejb5nOtIkWdG/8MGJLymuCkqRvq6zQdXlsXdtKSUa4irHkT52?=
 =?us-ascii?Q?Cl3kt/xYlHR4Ef01Cw/IQDmLYzZasjVc7WdJnab/dHzefZYDvURU7UD6Moly?=
 =?us-ascii?Q?xw7bkYArE4PoLRlKeqLBSdjTeksW/HbowERl3dICa2nJsKQFxD2WEs54bs1v?=
 =?us-ascii?Q?qrrjCkZ/dVR/oRvqX27bFIiR99cr7C7bARHmD4oic60aspT8FS6Dn8K1iJXr?=
 =?us-ascii?Q?w39ebckVsIJB/9cBz2OWkeIY2dVaM85VEupEtQBmFCK6kOIQiWz9YrSCkrZU?=
 =?us-ascii?Q?y70xUzv9rMZZtrWlKCQ2nojFwmpJcuXXQPUb1F8BE2PvcQAO/b474IqEvuVP?=
 =?us-ascii?Q?JvjcHCDH/kQ+RyfKOndCbVZGPd2zmo04hpOltysI2L/ZI45r7CwpOoQ1ic8d?=
 =?us-ascii?Q?tVUrLmqNlaBC077/lc/voTMwmODDzp1ui06boI6Tqv67Vf1+u40RYJLi44mm?=
 =?us-ascii?Q?ziei1qT1jmY3HqKmZEP/OugoJMLVXclVmmFjqdpS2LPm3Q4NE/JrIDzLGa3e?=
 =?us-ascii?Q?HZsLq3mqvBH84AQf4zYOQk4PGFVXLMgP1Vgd1zDEBd13OMO8XPcmVb9dllDy?=
 =?us-ascii?Q?aaCLuFV37QXA4eEPCz+bS5V2LvN2+31NhobbJDN8uXzbh//HiQY0fwLhMrns?=
 =?us-ascii?Q?2yakIuV/Fi5+Klzy7MkGNIsyzx69+OPN381HeG/PLijx13jOCBjWZ4/ypEJ6?=
 =?us-ascii?Q?6sDHe5ehmdESbuLhbMQ95J14ATg5xZ+ogGhU/JZkEyBPEbpWf5BkLIqy9NxA?=
 =?us-ascii?Q?rBYqZ9WDfh9o2jmGcOYOuWToHJ9OwoakOuMcZSgWaXD1PuUBFu/+ko98dTIr?=
 =?us-ascii?Q?hIecPKFatDKCjrfJ1f7M87rpdh9+l1KZuvkQWrFO8GPHUQrHBkv1l7TBM+/c?=
 =?us-ascii?Q?9HC2SuKiUE3XHBkK1qYA/ARStvqARorQT+qrcKZ4QOh5pcoUEQQDZVBWu+xv?=
 =?us-ascii?Q?EPfnhrSrDOAImkC5dmSzPBB7+1VP9Lp8Ppwau9r3lrs+yGlBUOtsN1Pba0WO?=
 =?us-ascii?Q?/GZIJx9jCumpG59G+BCr8I7f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6389.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ca4e4b-07f9-4e99-09a5-08d90af41dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 09:49:43.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GHNhXO6UYkeINm02zUV+7dSiw9pQ58PfuzDK+BdbBjgYz0TGWSS0nrzoowpJTTO6E7vujtyi+yJyK1zlqXV1GuQdlkSkJa3/Xp/t74J3DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4213
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Can anyone confirm if mac80211 rate control algorithm supports HE rates ?=20

The rate control code and rate control flags (below) received in Tx command=
 only seem to handle HT and VHT ?=20

We took a look at the ath11k driver but it does not seem to be extracting a=
ny rates for the Tx command unlike ath9k.

enum mac80211_rate_control_flags {
        IEEE80211_TX_RC_USE_RTS_CTS             =3D BIT(0),
        IEEE80211_TX_RC_USE_CTS_PROTECT         =3D BIT(1),
        IEEE80211_TX_RC_USE_SHORT_PREAMBLE      =3D BIT(2),

        /* rate index is an HT/VHT MCS instead of an index */
        IEEE80211_TX_RC_MCS                     =3D BIT(3),
        IEEE80211_TX_RC_GREEN_FIELD             =3D BIT(4),
        IEEE80211_TX_RC_40_MHZ_WIDTH            =3D BIT(5),
        IEEE80211_TX_RC_DUP_DATA                =3D BIT(6),
        IEEE80211_TX_RC_SHORT_GI                =3D BIT(7),
        IEEE80211_TX_RC_VHT_MCS                 =3D BIT(8),
        IEEE80211_TX_RC_80_MHZ_WIDTH            =3D BIT(9),
        IEEE80211_TX_RC_160_MHZ_WIDTH           =3D BIT(10),
};
