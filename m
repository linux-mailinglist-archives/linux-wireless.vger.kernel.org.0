Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0A3DDF36
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhHBSdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:33:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:2714 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSdT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:33:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="200709784"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="200709784"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="436748060"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2021 11:33:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 2 Aug 2021 11:33:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 2 Aug 2021 11:33:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 2 Aug 2021 11:33:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdgQBz8ZilLBvSkCJq0E4TEoMrOBv4Zu9CHFuGZEEb68JyPqcMYX67xK95YZtoa02pPNVUVOIfXlqcGYPqUGI+KsaR6gRqcoe0/DSra3khpH8olKOfuTPuNW6Nbo/h+/GPEa0b/vBNKL2/EiKLRUG8NP8/6tiFSWEEDKPo5EGlTbd1Ru5lOVsxawZJZFQ5SQfWpMqp52sKUqADMjrrpgje2BK3vIw/S15YxMpGGvec9TlXgTFEv+bk6gPi8r3b38zNa9H1hwFT+yC/sdoav2gT4aiGmJ44HoUCloTre13PeNqvQhogHHPS709HWbKtvyLhvALDTY6Ga1Nj8x3iI57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMXKv9WxwGYG8tHvZrXmHltTMKuWs2ThY12xDFA2AMc=;
 b=ljHRpDF0vRugZueR4+Zqz52eyo4Zm5bby4NzVpMZabyfqkFLpp1g6qz4s3ybYHFdpfrUKwty8KvZWKY87W8gB0I8dCjOY9FdZxMm+3kPcp1tesTkBsaPQq0IPP6M+bW+dR0AmbgTe2h1Nm4OEtQ3rFRjFW5gfEdkZ1+8gr08bgwPbiUd7C2du93ixpvPpPEWwYDySbPPOkFcqAoB1OwGHyqZluHhrL+/tr6nCl1OeUD1wVe25+n/OKHGIBG5UUFeBbqhkC+55inLoINdv276Tw40L4EsZBBAt4t8gSZ/TiAte5H0++LCvOzLJqb5f17iGViBXVDUDvbBDkmlez4WCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMXKv9WxwGYG8tHvZrXmHltTMKuWs2ThY12xDFA2AMc=;
 b=SSZmQPW1iD0D3wk2DfLUCxY9J98PO2rZGKqAx+0iVH2W9RfRoRGHvtZQrTPWUc6nda37MQGPygFQCBGPkKdvBHE7WLGKouCoEK14TkXsN2TRfXWpO9pEOG2F3GKoiUomZVnYaQEhrszzFo1ycXZOPuMoXqX7VdmDF4D+t2nBKdA=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB3471.namprd11.prod.outlook.com (2603:10b6:805:c1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Mon, 2 Aug
 2021 18:33:07 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::64a0:530c:db7:6dcd]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::64a0:530c:db7:6dcd%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 18:33:07 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "egrumbach@gmail.com" <egrumbach@gmail.com>
Subject: RE: [PATCH v5 1/7] mei: bus: add client dma interface
Thread-Topic: [PATCH v5 1/7] mei: bus: add client dma interface
Thread-Index: AQHXgrPhBdkegtzyzEmY1kMylKSTb6tgk2VQ
Date:   Mon, 2 Aug 2021 18:33:07 +0000
Message-ID: <SA0PR11MB47524A040AA244F77C38A86AF2EF9@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
In-Reply-To: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14c0b6a5-3143-4d65-4454-08d955e3f939
x-ms-traffictypediagnostic: SN6PR11MB3471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3471F52673B77FB26E2BD7CEF2EF9@SN6PR11MB3471.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0QSM/LMNqSjsh7LMofA3U+JhiQKw8MdVocvwX8A/HMCni0macPpp+KF6toTfgCw0G11P6R8yenv0GYdPSWOB1dQMFz0qun+W9yt8adAu+ZZr5Y6kcaWoiw5MdYrinEa41D7qeAGL0ZrLrhkPf9EKU9nv0nvHILLrdpJ1yv0mqDew8lTrqJiVJaBfy7Rt+TAEcLGMheVanEPSEwAswUbnl+axTI6eXueBL1ep7lzsE5VjDdvmbIL98nJbqhoYA40aM+sHz97ogOPHmxbw1C7Hjo2osYkJjLrm19AHQnjZvcPKyOclsuS2qK7a6vt4x6p7c0sDWmRmKrTfQyF8Lb1ht2tO0eLgo/LufudPZnBLCdIdlV2E/k1ZYekBDr1C8ZsP0SfOHw95fcp3YLASW1mybHfSxxwm8OhX2SVJxlgkE54d+OSc0X3FEdMS20dncG3jGYU6XNmfYkM1HYaQDacFKCP0iFUhV4SDT23kDB00eKInC8Cycfnw70lP9JyQ83Y5nXdOIlTlYd5srVD52iDtkAB4eYmQRGWlhS18wcKaGn4OFG56X64HLt/Z2/wh0dHlwYEhS0r4exEcaHNX5kFLOsd/7EO+R/v5bhrjG1O+VDFGmyFzXBvv3iivRghUTx9we2HVnToAOmWy1LDP0q3FOcpgU/4eEJPa2a83J8uEIc7+NVEtL37xrpXsLLQcGhVUSzfqwe0jUeBJbykBGxUYSb1pKhYIanA41K6ye40ZBJgHGEtiZ70MnirqN5g+jk4VkOZrZ9wWzLfxyLjhIz5iv/G125EY+33ytx+5gnq2Uc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(8676002)(4326008)(122000001)(5660300002)(316002)(38070700005)(4744005)(38100700002)(55016002)(52536014)(186003)(26005)(9686003)(6506007)(66446008)(66946007)(8936002)(7696005)(66476007)(966005)(478600001)(110136005)(71200400001)(66556008)(76116006)(33656002)(2906002)(86362001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EP6cv2WnaBq84pGZ4SUCAHwYfgPH88tn+3qAF0d0C8jPoFv31977r7utUIp3?=
 =?us-ascii?Q?8pqMTgFfBDg5d9KRGyfI8lOkcAG7MssHRxqZsA4W3Kb9S7runBXIt1Asvm/w?=
 =?us-ascii?Q?E+6TInNnkxMDafmZ9W7abZuNFN61HqC10+v9gnzmlw6VVysYXns3TrgWkX5a?=
 =?us-ascii?Q?ZEKZ5xoxBuC7tCqk9hvuyYZceuBU4CxX/Huv+AtdSJpEO21bREEUpRz7/hOm?=
 =?us-ascii?Q?Nc+oJh1Q4rO+bRQSHA7B6/qRqBppwB6V7CDgQ2NPAbbOIXZ35Np2qn4EI62+?=
 =?us-ascii?Q?rHsL/R8cky3CVaCEgfzNw7CfQ/e7qeGHdK/VFAu3wBdj1RqOI+kBSvmH0Rdx?=
 =?us-ascii?Q?AGZDp/3rBaOszWxq0e88LvHAskPH2SDUAJ25WV8C4FkiJWvjaiNGBOOMwrgS?=
 =?us-ascii?Q?wu96LTW46zemB6shnVTEIyDxrQzIVd/AMZ6dM5rXQc1/Wm4LbyciJia+9k8o?=
 =?us-ascii?Q?tr0jpo8MSroRnGvSNxQerMvv3apONJ29wovatNXc/csOFHteN8axwGt7Ie4d?=
 =?us-ascii?Q?he6MI2jK/kFm8w33/VjA43S8NL7DvPX3QoL86R8EbEsIe8xfrQCwZ31qi0Td?=
 =?us-ascii?Q?Jovdmkd/16GqYaSAECJdFq4JlX3O86fZlSGChmSn63/aK3l3Qte4zy9h9VnF?=
 =?us-ascii?Q?5fGprcezOlcz3Lk8OSQtSbDmU/o4UBEoUhRDJVvx+hLF9qQOX4pX/kG7X56d?=
 =?us-ascii?Q?K3+5PXbUuZrsT7hQNQ0ZlKrABR4Xaz3+TOXLmx8MRGantKiDzu+mVISAiBJq?=
 =?us-ascii?Q?+ZUm6D/E+ZO83GZ25umZMzirSi+BEP9z+M4IM7fC2bBEzerSENN7SjgyhX5X?=
 =?us-ascii?Q?+T0RWeYFLXhPFP2yu4AH7Tw9Hmtc6bfLnWdE+Tw6JcoEbhbXMmtSgdiy3wf5?=
 =?us-ascii?Q?xFa5pxHN6Q5pvIS+0vlj/6g4kvKjxfkT9qrbe8vmLmv9ggOkbJyMA4wI4nC0?=
 =?us-ascii?Q?CSRoOeusuqqZKneqm2NP0ntns5XaK+IvSbsyBJEQqfl/Vx2MUKqKf2Y3iTPQ?=
 =?us-ascii?Q?mSo2sLFM69NRkRlz7mtcqKmB3sH1aZ6V7mSuSoblrhl4IqAtTe8W+qY7EKT0?=
 =?us-ascii?Q?eV4STRkX5S7Z8KRLuFDw9PQvw6DfxBhmvR32/A1pzO9cjgfhVdRph9igX5+H?=
 =?us-ascii?Q?SpXT4cbdDtF20IEXBuhZuq92GkVvu3jbKqS2Ju+pYxVKdyMRPmpOAiuK5tA6?=
 =?us-ascii?Q?Hc7BgpMgqeZMfaequmSOlULlH95NiFcHs+yJjg+MQWSp0zg3rOUHaq1at6iC?=
 =?us-ascii?Q?0/hklWfwfwQ9R+eewr4P9SFAbo503I1I9ncCpIToT2lVW4vbelmmd/Y0dG+G?=
 =?us-ascii?Q?P9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c0b6a5-3143-4d65-4454-08d955e3f939
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 18:33:07.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFsEqRpRhYfpEPbs5VMUeYIcboQrrEi/hqtIfkk0ocTENZyXgBm6+nuD1/rIadyZ6G9blOGQf88E0X+9wiWdRA9FVm0KJJLjgl6RjsQyOEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3471
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

>=20
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>=20
> Expose the client dma mapping via mei client bus interface.
> The client dma has to be mapped before the device is enabled, therefore w=
e
> need to create device linking already during mapping and we need to unmap
> after the client is disable hence we need to postpone the unlink and flus=
h till
> unmapping or when destroying the device.
>=20
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/r/20210420172755.12178-1-
> emmanuel.grumbach@intel.com
> ---

This series is assigned to Luca on patchwork besides this patch and the one=
 with
the vendor commands which are assigned to Johannes.
I am a bit confused because you seemed to say you want to look at them, so =
maybe
they should be assigned to you?
Moreover the vendor commands patch is meant to be routed through the driver=
s'
tree.

Thank you.
