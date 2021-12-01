Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1967B464DE8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349322AbhLAMfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:35:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:55211 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243419AbhLAMfY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:35:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260423173"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="260423173"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="602099262"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2021 04:32:03 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 04:32:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 1 Dec 2021 04:32:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 1 Dec 2021 04:32:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn/4g2DPtmSp16+p00LRSrVH3ooPXk1xns7NhgO43ZuJR9f8uA5Ea+pi+O9E1XXeXuK6kfaHLpnwmeVOYiyLyqO8fNb7IHoHu0n/n8ANACr7Hn7vZlIzfn6c5fHY48dWz2myifO1V0PQZHzy9vf4tIwGwesEdF4fATYaz81VHU7eJBB8jJ1z2mOVkkeOKadz9YHOwY8heDOBw3JpcvOdiv3DQAEM/9MxKMZo7v0WEi9/yPS1keLdn8fK5u08xL2jcVMUY9mJFAuMwNTKirSNCVKLjfr8chulRBmjsEZYWDKQSL4d4tUZeJwEIDWlgT7wh9Xcymr2ppCwSHoDqdaUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NANHpjBtfS+Aa8h0xCW5H6krq1AxKthrEH9XBNSYso=;
 b=n5DBWNWLyoYd2OTERrEBlfaXYw7C5xJwT3hAIwaTx8kpiBTVUeL3fxsevOafDbKF6vTfQNYwMaOy07AQpzKtpWrfkiI7o5GSQQ6wUhse8KxZXgmmRwxesC0esjubEn8bgPngqq+BOtTgIQO/rN0n19mMYTJXdzf2iN5s+ndylg7lN+P9x6a6X+VjAlXtUJCIOTgGztAy6b7hrymWC1A5khoba5QMmmasE7MBaOEjXrPJgfE7oBSrB4TX/uwI7/bqEt0gduDuGlulgg/ovBTMUvzDYz0MeaDMzZR/iXZzUsW3Id9gWuhTAXyh3rKs4N3rFBsyvo7kXV8ZNgoZUfx0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NANHpjBtfS+Aa8h0xCW5H6krq1AxKthrEH9XBNSYso=;
 b=ccUIwqkhkAINwt7gyVVtbcCVpB7vZDfFm1nUu2fJcI3ioHo1dqCMNnmsxXN57Ylar+oEwhYLL9HFwl0Sycjtfx0AzbxFp10YMPILd6ad8ampjHgYrnUZag7s3hWdXsyDmBR446b2dha2KZJDYECNibY4RvNXst2yd8+P5cAIi6g=
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 12:32:02 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::787a:2f03:efff:c273]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::e814:a13b:4bbf:ef2%9]) with mapi id 15.20.4669.016; Wed, 1 Dec 2021
 12:32:02 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: RE: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
Thread-Topic: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
Thread-Index: AQHX5qdoUVj/SGhgiEyc3Z7ZZtfLwawdjsAugAAAImCAAAGtk4AAAOwA
Date:   Wed, 1 Dec 2021 12:32:02 +0000
Message-ID: <SA1PR11MB5825F998CF4A3F1D3D7E40C6F2689@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
        <87fsrco6r1.fsf@codeaurora.org>
        <SA1PR11MB5825B46CCB4DF4207F4D5B4DF2689@SA1PR11MB5825.namprd11.prod.outlook.com>
 <87bl20o6g6.fsf@codeaurora.org>
In-Reply-To: <87bl20o6g6.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a63669a0-d003-440f-e259-08d9b4c693bf
x-ms-traffictypediagnostic: SA0PR11MB4624:
x-microsoft-antispam-prvs: <SA0PR11MB4624FC387648AD8AFF2C6605F2689@SA0PR11MB4624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fl86gUZuwPyV2ZmnTqZE2uHbMWuaS3Hu507FUn/m/wXad9T+8DRV9z4qwh+lgA9c+nGTe4A7wrHPDVk2LJvyEYW/I/l4KZndNbgix73LeM95fmv8ecT5PBSkWm/JkIEcOqR25IEp30ocs5zO9/Rw7cNTq6ZdsDfK8vF3A18cX6RjD6EXqiFXzV99InwLcDpiLXruzkJJw8di0UJxNZEuaMnNZkcpMbKD/wTShcEr+Cd+S+3Wb63APpKwQBWS5OJ+V9E2hiWmpvbZx0PqlsEPHdU73UBWuEYDoXVoeZfYTtAEac7H0AxFnDD/kcNJZkl4vI+UQsMcs3kL5d0lY8lWA7V0INKhzIU76OHWKPG03uNWjRDGKqLdX4NMyINO9fV/XbzWdnPfiYKmf0Gvupz0bfxFBDAohzxGj6VFAcLYgnIMG1yXSEB5ciI3afvdJPT3DZHeYmgOmR6725Q33vqPIK7L2LH1uPKJUz8ZV14LKkmBBub3LWElwtSdmSJe8b+Yy1xJC8xQMsWtLh+FK3Dbm3/JSCKYMxLXBPzSjEeRkHqc8/Nzyw7N/ZCLgbLCp2tyx5b37ND5Go/PgIpgmAjTXW8hJ1sMACPw05A8VQKJUomP8xAkpC15baedQPlhE06sMK+++qPheotMUum+1f9/dAUwhcKS+r6DsXQe+nVpMSYbEcuJEgqzLdeEXXKSdDdDqW7f826FS/0XR3yXeV1/eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(71200400001)(54906003)(83380400001)(66446008)(26005)(6506007)(33656002)(66556008)(8676002)(66476007)(66946007)(186003)(76116006)(316002)(64756008)(8936002)(38100700002)(6916009)(122000001)(9686003)(5660300002)(7696005)(55016003)(4326008)(52536014)(38070700005)(86362001)(508600001)(4744005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MI3Lo9RY3Rp5sEaYl/lciedT+Y5M2qM3As8ikVW5E4kEBWuaSa2evv2CfZ3T?=
 =?us-ascii?Q?SjyiuPLctkjVFUcmLosrc6x8C2XxtfdoXAjWVYP2Aj92YlaOMboz3BTya+re?=
 =?us-ascii?Q?GaWm07ACmEoCeA5jLYywDsyznJxxwZX02BI+feIliKCwiMaiwWootOfuS0U3?=
 =?us-ascii?Q?3bP99cdtI7TuWYnXplemrtHMTiLuzx60Nm85nFQUbcjYVPmLQADz8vhFVF36?=
 =?us-ascii?Q?rBOtwoWyK/TvvssQJN4QYThyZZNcTwG6RtJQybGfeMThhHR9uBzYTcoblzbZ?=
 =?us-ascii?Q?Xoq8VnHObb1rzz2gYCDObCqjKuQqQvGlN441zuHXx7ACccY9QMukKqiAoBPC?=
 =?us-ascii?Q?LHMx049F83NUdb5RWEgewgVIrY7ADgjjvzT/VxBLhb2pjoI026kmNa/0SCtO?=
 =?us-ascii?Q?zxpfYOQfHhZTj7jNM2oTffMFibfGhcZUI1e4nL9BJ8GxYrInOgmzmAoDm6rX?=
 =?us-ascii?Q?nTdktkZp05/UE/EhM5y75U8zoGLFIZ3DBEsj2AHsuL88hHkqyuVOuM9X0w1q?=
 =?us-ascii?Q?K4ORhA1vCPRR7l1WMp6OJK2DXKHW5TiqL0ZnYg4jZ4Li7OPME71yZN7WKo5j?=
 =?us-ascii?Q?SiordDDLKvfoF2FiQvybhmjgKPpo0mN/n9j+prfA8gOgB6AXczUoMg+gheKm?=
 =?us-ascii?Q?2hqyT7VtOEyzLVYkw1tFMFxK6jCZYy/jig2ArdzKBOmAcv7k3vKOmnZX+iJI?=
 =?us-ascii?Q?ozshCkk1vzUAUr6bLkbZGsXMofin0Y7ub5/UZAqGhT6TZK7QbY3ccHH5ooXp?=
 =?us-ascii?Q?l+/fMnBnawvu8AUQIMZpcBPoQoGmN/EqMw9ov/UCbDrz8Gsw9v0ENUQ9yVV0?=
 =?us-ascii?Q?uQAWIrXLvMyCMAdOU1QMEiMDdx5ubx2QFzXYS+/gIqL1mOogcAzDmvncFKDb?=
 =?us-ascii?Q?g8yRY27E9rQ9JaolBHZytNS/ylS+CR7RsVq8ca+5GSxa8metb+bsCnrkxUPe?=
 =?us-ascii?Q?3SY0AO/yBqV9U2KYQNeDA3x0KA3EczNjBs0pdkIUZUbWENUVWkQfbtnlAS09?=
 =?us-ascii?Q?Sxj8E3XVOUvSFUJQNaXC8bDBQkFFgnMIOr0vDfnczmRAZ+wnSX5eTxtoJvQZ?=
 =?us-ascii?Q?clkh1X2vrT15h6jqGU3j9meRRxxzz3DQmgd0G8GjRmRK407cboNirNAYQBAO?=
 =?us-ascii?Q?uo4Xl8UC5gHK91VCr+nMVrcbp0AAjBaJMD6mBbyelWXn+iUvAnWsFD6T0LqK?=
 =?us-ascii?Q?6Tc8GmF4RjoOQYRNXYyTeSPLTi0wh3ikDyh6SAHvoiBkGQikg0jSYHLnQb3I?=
 =?us-ascii?Q?FTfX1BT6fsulKy31FU3pLegs2c8mPZb+cG1NRxx1wpWZ65z7q/47NEpLf/Xw?=
 =?us-ascii?Q?h9kxR1JNgyBw1YGSIJpfOgm1R94Sf803jGBBYCx3yGIW6jTtm1XsA29QyUXe?=
 =?us-ascii?Q?iAmDZo4l9l6/GO9Ydbfws5RAmO56BMCYz/ua6bL4d1CzfBI8LUGOSkjh579Z?=
 =?us-ascii?Q?+LG33xkuO2EL7sEtsWdezfM3ig0z+R7+Lqt9mP6pPSzjSpSw9nmJi7K/HI+A?=
 =?us-ascii?Q?MWEsR3NV3h6EvmvhTQCGr/p9o5oN1BE6Gg4qdgFyLVREQ/d0NDd8SM1cpviw?=
 =?us-ascii?Q?bxA+l8tGaZvXR0cReM5uWpX12ENfOGh8H0WPpozZ7c2nXF0kbLx7iTXr543i?=
 =?us-ascii?Q?sGOrWbiLuGuc/MfjCBilCZAvW4pgg63JYAjmu+wcisoSSHGU5dhlo50b77zr?=
 =?us-ascii?Q?Lnt2ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63669a0-d003-440f-e259-08d9b4c693bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 12:32:02.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H652dlqKr4akyE7Q6MpDjVe62G0FsoXHvX5qtM6W7g+lJZboemHJP2niQFOyYbILY1gYTCIo00jk7G2Sdjr2P9+fh17nc3NyQqqleSHmE0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> >>
> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
> >>
> >> > I forgot to add stubs in case tracing is disabled.
> >> >
> >> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> >> > Signed-off-by: Emmanuel Grumbach
> <emmanuel.grumbach@intel.com>
> >>
> >> Fixes tag? I can add that.
> >
> > I skipped that because it's not merged in Linus's tree yet, so, no
> > stable consideration.
> > I didn't know we need a Fixes tag for patches that are just in next as =
well.
>=20
> I don't rebase my trees and neither does Dave&Jakub, so the commit ids
> won't change. What commit id should I use? I can then add the fixes tag.

2da4366f9e2c44afedec4acad65a99a3c7da1a35

