Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6005D35DC90
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhDMKka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 06:40:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:36966 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239517AbhDMKk3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 06:40:29 -0400
IronPort-SDR: KWNFjGh8hb8C4K3BSDM6yEv1Y15dzh5im6S7KwiXjPXch7RCGEkqJykdauWlclU90I10w0Fpk5
 ksCbe2hQi9BQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="181903007"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="181903007"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 03:40:09 -0700
IronPort-SDR: 9QOKryJc3yDC6qUrbqPi0vEFX/e+eVdT9b3mPQKxFIy5/9lgCdWekJxxAKRNtk9iWS5n3CWC+B
 Iaza/g6n0boQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="600306637"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2021 03:40:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 03:40:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 13 Apr 2021 03:40:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 13 Apr 2021 03:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQfuqYOW3ELj01Jmy13O8x6YgwFDOUsoqAv4Q0DDdu0Vyybt4yYITlsel4xClH8/LcCwV/pbRsYOWQL7QwUM6bpHL4vkSzMSeKyF9u0WtPmGhO55VP7PSeTZ75v0tDi1AK+AE6yUnlSMnFheFAozU9cniGdPRXXI3RE6o2Ygzt9LKRxiasE6lRjz7mrF4FiL0mrrQQGvonw6vqvuz7tYD+4Q6WQcwI52+RIPdRoUvsZaUP/CAtF5pZBjwcQ2AVapZolPdmIeK66eOvsq8wFhXnte0Tog/9xpxtUWg/PX1ED0qoDpaGHq1BhLqJaXIgoBO+zbKwYvW3lqulZiF4YbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2RiITn6plncNt7zAT0qiQqveMVu+Q8SAvQLLOJKAu4=;
 b=JrPXVLBZGrZ6PvhUzVpWqKRZ2wEiHRABcJN/tlqi6NiBmpn0cPXA8ZrB1Ji4JBX/eaMr+YGmboxSj97ou5M4rnuozhiEw+QBsG1dVl/8IYfA6m9g/HKWKzBE0P2oAHnOn10zT84S4E2Bp+7KSelAnhSZXWJIZPsVygI+2g2jMFaaCuOJgwd75pKgwu9ieL/U139Mlj3QfaPApBpJqlFRQ/gJrM2rJcGKqF1N4XpwRn86OCntln2Z30W6sDBa7qlsQyrwaLfJI7bkc4Rb5pwhg+A4TSNF5AM03ZnQtwArZ7CynO9RA2+Xj991oNRr4L1BvQTAEkswM5bUmB0f6Psmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2RiITn6plncNt7zAT0qiQqveMVu+Q8SAvQLLOJKAu4=;
 b=vDaU8v477u7NdewzPQxeFyru42FicshXirBzoJ69m9lWDvqnjrpvDSD430eCPrHYLI5kZjY/ULpYQqAw7di938XEZ7C01hinS8HC/po+9y2FwveV2CZ062WZkRFXQOqx/NRT7j7SjD7cxnrvBOBIMw4aixCVHps0YgC+Qx09jzY=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (20.181.62.88) by
 SN6PR11MB3070.namprd11.prod.outlook.com (52.135.126.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22; Tue, 13 Apr 2021 10:40:08 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 10:39:49 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: RE: linux-next: build warning after merge of the mac80211-next tree
Thread-Topic: linux-next: build warning after merge of the mac80211-next tree
Thread-Index: AQHXMFCIWtO4BSo00EqhCj9IrULIH6qyQTcw
Date:   Tue, 13 Apr 2021 10:39:49 +0000
Message-ID: <SA0PR11MB4752827232FAEB27E2EBEEB6F24F9@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210413203349.43d3451e@canb.auug.org.au>
In-Reply-To: <20210413203349.43d3451e@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=none action=none header.from=intel.com;
x-originating-ip: [77.124.181.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c305c9-3a12-44b2-f87f-08d8fe68768e
x-ms-traffictypediagnostic: SN6PR11MB3070:
x-microsoft-antispam-prvs: <SN6PR11MB30709B841C8A79C1CC2B6B8DF24F9@SN6PR11MB3070.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nl/fWHVzpuhixP8c06cGVUP09Jy46UyDKW6AbLj8qwuohzecScFqTQAdIDEa0tJl5XdFX+/tSEXod+IN0WEctrR3IeJReu/qughk6FJISIMM5whwbKqh4CwbcDabgVRNkB2ps2BbOpfZGkJaDgpbjR5arnHQTllCgfHHjP/NEAuxQXqsvClLfMUWic8fO5lm7Qgya/1uEeA2cBruqju1LMErJQHBVabFNICd/CU/u9XTmjMo3zetggx1ohUphdyn0MALyHxcmKUq+stUKDrVb9SJ3BRsQIPK0iVf6qWmJNFxFobP+uCKn5w+1X0ioEr4o7AMQJgxY9d6AUcdvNa+9F9s3G2dOGUqrpH6URAuSWad0iWhZp/k8DrJjBaJE+e6rsFgstMcIDc6ZfHwd3ImoJu/aknEHbRsAxIuFqxY0fevRvg7aY6HHiWE8u5uMKaXnX+BpNjqxdTAR/tmDKFEwgncsIpkLpL487ZzexDyHozF894w1SEXz1GqcBkbCCitLanK6o6uQdWlAe9gxqqaToJ3dxW8VmeQjY7tGd8lzOJ6XPvmShp4sQljqeO6KP3UJPblC1wb7u18H8+PE1cdbj/rNwks7MX3Wacm7JZ3WDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(376002)(396003)(6506007)(2906002)(83380400001)(64756008)(86362001)(8936002)(66556008)(52536014)(66476007)(66446008)(71200400001)(478600001)(33656002)(4744005)(26005)(7696005)(54906003)(66946007)(4326008)(110136005)(316002)(8676002)(38100700002)(5660300002)(9686003)(55016002)(76116006)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OGU99VIE7ov8IDBA1QiMfhAOv+JyVvX3aoPIBIz4JyDTGIlCmNW9OPlumP1j?=
 =?us-ascii?Q?vJI90Ogw8mD0A7f/G+PNOgeg2kMCwPvXpXHlab78FoyUlV24cFmDEW3VFZwM?=
 =?us-ascii?Q?RDh/k4aidOP/hYAccegRYJCuGu7TahLmPVtJpeEI28x+p2flPzBeM8Vjiua5?=
 =?us-ascii?Q?cwLxNs4jOjyeQa0b5Cz6CrF5jlFWIKfr5f06eMnX9XmBPvx02LpN1/Uy/9uQ?=
 =?us-ascii?Q?6Bp+wGtPMxQj82xU6GxovWxchqEhnhMxD68QpHdT3v7IZxSI6RuoafisrQr4?=
 =?us-ascii?Q?8XuVkBNMEXsKaHTFG3I6sFOBC3SaKpHROCZrOmVC5NCJE6YZXJDorOFcTRKM?=
 =?us-ascii?Q?DWSSsCI0Hu4rjXovNm9vUZiLdQHc9BFEDXM3nL7VQhbQ72dCUJHjKvUqqewD?=
 =?us-ascii?Q?3i2roT2bfF5h+/MLp0T+smtjNsu/2KwvOH7p25vGEsfe7uHCgPi1n3Q0Eoys?=
 =?us-ascii?Q?uFkP4lqQ267peC+Xf2HNyJbR6BaCWcYYM3j343KMmrgwUwZku6i7klhSB7rl?=
 =?us-ascii?Q?She042TB8n0MiFmos9UCnRrRzxlf71I8vaioq9MSwwyDnFtM33J4/RZfA4PQ?=
 =?us-ascii?Q?Kz3oA061ZYD8MzM2RpibsvxnsNsH8cJH5u/5wS31xPb/D0QD2dyU3h0gjRuJ?=
 =?us-ascii?Q?cNxIFFIaGjH4AOyNO9ntUjINwZ5evL/5wlWMFDL3I1w9Wgc6BjK8EWMJJs1o?=
 =?us-ascii?Q?YZ7XS0+SrFYVaRDVknRmaQiwqjEsynuwENZTIwrKSmwo/wHmuyFYrsEIdDkq?=
 =?us-ascii?Q?ruZxEkREG1ScCaI5b4ii0Kou6stoQ9fF3o74eEQ7sRJNNgZQ5bmesfjvGn1p?=
 =?us-ascii?Q?+1QXadXIVBOkqElBaxVl0CjLSW6WTBQHXRPMLuoeqJchVa31KpjRKSSP/sn3?=
 =?us-ascii?Q?IYQQRoyrCVbi05rAFnEHTbiJWqSCyffuLBCt2Q/3oVdSrsGaYb0P30PaK5Ad?=
 =?us-ascii?Q?EUrA565OFu6MF/sFVkN6W0apgnOPAplP6Vltm3EanwaVWR/WWmqjZNdsp4zu?=
 =?us-ascii?Q?O96Kf3yPl+jhTVan4SKf/DlUfTEfOjLijkYpGr1yK5AiOQHoOPwgW7LgX3an?=
 =?us-ascii?Q?nF/3WCREdosrzSZQt8a+Y3lGAX4pLzQ6DhMrR4XWxLzKwRtrTvUV3xEcqGue?=
 =?us-ascii?Q?l/W1XTAEYne1OArFUU4E4hFrIxuYe9hGgo14qKXQL41advPCo6yqVoxfFtj4?=
 =?us-ascii?Q?mMma7E6tagG0WZ7A4rnrgOtjWz1CZJomloZ83pptGbVnh7FfjqciKrcWIa6Y?=
 =?us-ascii?Q?1AAaO0b2Uyzvh/vV3dheGnrB25r+EbFgY/+fcwpVczC25HCA//jQrK/I6L4E?=
 =?us-ascii?Q?slKAT//EFHW6s408dHr9I7lz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c305c9-3a12-44b2-f87f-08d8fe68768e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 10:39:49.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zG6Ur6b1S+XWPS5m85yyf7mc6/NihPzwCmg7wdLAPuXPyecRLxtGJ+KE17PIxGNfq8Px/OVSJCnSROg9HPQH5EzObp3pEkx5RXZcqLI3Qh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3070
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

>=20
> Hi all,
>=20
> After merging the mac80211-next tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> include/net/cfg80211.h:6643: warning: expecting prototype for
> wiphy_rfkill_set_hw_state(). Prototype was for
> wiphy_rfkill_set_hw_state_reason() instead
> include/net/cfg80211.h:6643: warning: expecting prototype for

Ouch

Johannes, this is the fix:
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3b296f2b7a2c..c6134220dd8f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6634,7 +6634,7 @@ void cfg80211_notify_new_peer_candidate(struct net_de=
vice *dev,
  */
=20
 /**
- * wiphy_rfkill_set_hw_state - notify cfg80211 about hw block state
+ * wiphy_rfkill_set_hw_state_reason - notify cfg80211 about hw block state
  * @wiphy: the wiphy
  * @blocked: block status
  * @reason: one of reasons in &enum rfkill_hard_block_reasons

Do you want a patch or you amend the original commit?
It is not in net-next yet.
