Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A1464DCE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbhLAM1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:27:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:54704 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235768AbhLAM1M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:27:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260422047"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="260422047"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="500230867"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2021 04:23:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 04:23:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 1 Dec 2021 04:23:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 1 Dec 2021 04:23:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8wQL2wIqKs68cdsLNxKBuEHtaG1ZQUiToOR5vo04u29PXKCZdyQHj+Z2LDv7ezA7U7Yvtns3fjKmGGyA3in0Fj8lOdtnl7gUngT2svTIVIJe8QxFgjKAtUsomd15O8OODd1wKzlbNxokr6WW2UjOXcHtbXGDbYIdV4uf3QLSL2bx0ot/fwBIu6LeJGvUY2OOv6yjKkKcq1R5tJc0RCuEuUanjBwDTFVpRnu7ZdxhIzkejz8BkDp+teZaHUXfHqxu0IVbu+iNiB9tYNjdRtLJ1a2d2T/WVTBuO22LW8y7+Bc1EKAZsA6PgW+F7hBuv+dXbrQcUJXlUNp7454vctobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLw0JDEkS8s7s/wMV0V3ibXcp8+saL9pFu2xdYb2dqg=;
 b=d/61dqrE4bxqS4CvHeJgYqL98XJB5O2htqTsJ9swtY5GhoCdto+jdtKv9BYl16lKA2zUnKvmnvIzEqdGo/uQ3McINr1DKbUI+iIKrT0W9p4OtuyPq/i9VMQp1ophU1/3w+JNE1uhc5d3tJrvqqBlVeW3mNJHfllHlPRCPjIouUo+N95cmVc7yafz9dk1yMxRlnNjlpeFrAlxFFtnyUUybJy5DRL+C4LPaz77lsEhrMjkFLn3hpUClE1FJPc4n7B2riQuv2Lw0HAZgrhNdn/vj3CB+sHr53UiC9esxNXJfcvTQTaSwv05sT01iJQzNTrmw4vyxXz2HYpKHBBp2EjluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLw0JDEkS8s7s/wMV0V3ibXcp8+saL9pFu2xdYb2dqg=;
 b=nOZfisQJmqtLM7Or4U2uN80TRgbX//AoVWJfFPKJucJ3Wup/fs+WeGDCN2fPR2jkMx+p4AGnyxaIQmD6Mivdf9xcxTjgqZjKuWg69n3oVJWDkP/I9gIKxtiQqO+0ZMlz2e15gqBiWUaEFwAq6Y/SgGZpR9GmID9NF5f1ZCXjm1k=
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 12:23:48 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::787a:2f03:efff:c273]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::e814:a13b:4bbf:ef2%9]) with mapi id 15.20.4669.016; Wed, 1 Dec 2021
 12:23:48 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: RE: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
Thread-Topic: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
Thread-Index: AQHX5qdoUVj/SGhgiEyc3Z7ZZtfLwawdjsAugAAAImA=
Date:   Wed, 1 Dec 2021 12:23:48 +0000
Message-ID: <SA1PR11MB5825B46CCB4DF4207F4D5B4DF2689@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
 <87fsrco6r1.fsf@codeaurora.org>
In-Reply-To: <87fsrco6r1.fsf@codeaurora.org>
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
x-ms-office365-filtering-correlation-id: b025cc39-fa32-4242-b69e-08d9b4c56d75
x-ms-traffictypediagnostic: SA2PR11MB5212:
x-microsoft-antispam-prvs: <SA2PR11MB52122052F69C53E2E4DC1B0CF2689@SA2PR11MB5212.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cz/PDd9EQ05mLIEhKzsRFNDDlPWB4JCuPAspKC2ZGDVZxYrvgtPwCTbgQNktIBEZdZyuNxv33M69pq0E+rFp5rtrzobkOqJCm+pBTWYNySZA+MUvItaay2P/Dt6vSWOmdYDLCiRJX5OWHB/b0MKJE9X0z/K//tA5sAbiMn5trfKXnMlkqDe8KJ9Eq8cQoL5ForDV0qZ8VjFfJ8XOYLpxqh8sCT0AwjZDGhSftzAw1/OTc0aZXIpUaNCtBhIGEilOVkhlQ8P0R34aGnMqcVNIQRthCu1QMRsCmVz+oV51KyTCzzklvjCevFO1hiaIUm8x25w5RUZTtzjkGO415LijWTIJOQ8C46POHegmqAi7i/f29wR54b6RjVE1/QHtS7mAPbSpDj3hlygh+4p6fXphuRw7p4DQ6Ee33pYNzUM7Y3p8LzEZkTXUav7mkHSckqnF8AhwEx6/NqxeGlmFD5k6yPGpb55QxaYIqOOM+QhQqjUR1ePpaTs8JsdtlZvC6nfUL7TEKxcqH227hWdCko/9E+zocsls79WCudNxmEdw5B8Om0J6N7Ji3Cq39I480OS9oK+w7fB1DCoCS6UeZMmg8/XfPQ/MwyZa211OoFvKkmQJEQC1tOK610w8kQzvzmw2wZhxxi1LR0t0evs8Z+zaI4mvQQwCFvQQ7ya7VgOviMVCu0fB8XwULrpBzKGQqnKpf54fRqzjI9q/O0PPdqy9cza00DxKwsd9wv6QCEvxrSIDljn0JF+7UTJMdvEJyqo4jKlKIrfVDoKqX1BiaVD5f20s3ae06XXELvq3ItXJtAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(9686003)(52536014)(6916009)(54906003)(66946007)(38100700002)(6506007)(2906002)(26005)(5660300002)(8936002)(7696005)(122000001)(8676002)(64756008)(86362001)(83380400001)(508600001)(38070700005)(4326008)(82960400001)(186003)(33656002)(66476007)(316002)(76116006)(55016003)(66446008)(66556008)(4744005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xSmJojAprmaFcgFwl4iGx2+4Q1Ly+fV2DYHO3Q2mhlXqaSF2BUvZziy0qXiu?=
 =?us-ascii?Q?xVfFI/2DrEfsM9AX8XiPEhAa3J+hteZ5GNdNXveSohqIpGOy7+jASeRIQx7Y?=
 =?us-ascii?Q?j8hYJsno6taVrmu5EPz4dYemeYO2Y4UngXjmt2oGUh9DawX4H0uLqimxS6wD?=
 =?us-ascii?Q?T7/6XW/SeTp+HxvlI5APjYisxllbxlA4xfUp/cWH6OfIGDzlHZwFlRX9HWvZ?=
 =?us-ascii?Q?86BiJiZGy6nxKdklPMNMPDHn4Qn1GWQXysAxE3fcdIjRhW9GVVh8xpN2Z1V9?=
 =?us-ascii?Q?DqmGtMsEatgt46ztZ6wyj7ssbzeltikUr9yQGd/U97SEziPKCLzqz2Q7/+0o?=
 =?us-ascii?Q?hf3hhg9gzxHOkHYTgaHl6JG1qSN410l8vxrTfQWwRq7lKqOdvMURQLPmD+p+?=
 =?us-ascii?Q?sgdh0k/elkmGBkcv1XH3apmy5Mb232Vb36GHbuM83AGOOkmVvFPQDO/kutOa?=
 =?us-ascii?Q?8poBu1UhoMuBMrEnCG6b0yAeWNlQfeNzxS0yRk9yC7y7HhBXv98kSrTZMR05?=
 =?us-ascii?Q?ZJNQMd9vJAazkFcV14Ue/6JMPHucF/pLi3FwY89Ta+YJFVtYajQcbmgsl05i?=
 =?us-ascii?Q?3vBfFIxEbz8wcLS1UGLzZi2S5omKQO9vAxjhlMD9lJ59e6s26IFD2QkqFMz6?=
 =?us-ascii?Q?/wqGtd1zvg+BtPA1qIVngzsahTJPckAjvN2n1wBwiDPbHr0TEGnnmOsb1+dM?=
 =?us-ascii?Q?evwy8nwrYTpvM4Qc2USyvFEaIhj63yrqFp5eyuVJYJdJRSzfJP6w93PIoKOw?=
 =?us-ascii?Q?aoV4Lt9HONqett8WA9Vcbbx10rZqk+hKXSu2mtx4fgOoZI1x0nwxMepoARbn?=
 =?us-ascii?Q?8nuyLRYCDqawR1eOXtmgz8B+Nsud+fAppwHUb4SWmGdYyedYiNPE9zoFcpoP?=
 =?us-ascii?Q?IY+K8k58v5lWVx2GZ2bbi+boXnJljpyO2Icgfj3hQWGJtnt9DKjUYloGpDJi?=
 =?us-ascii?Q?vh1cPlztM/ot54jYW8Zx1Ja0frNwXEeB8P/UGEw2NYk8fKF18fW37BJRBjLB?=
 =?us-ascii?Q?rnR13deNi1Km4da2mlnR6pgw7AfqacDxYtiGit0LffilYHxbEJAwzeTmMkOj?=
 =?us-ascii?Q?TYV7MvqwCB72iB5DhH5pZ4YDoHWAaoImBZt/oTXHgLxyFsarPJ+f1Ej2HZwk?=
 =?us-ascii?Q?fFRG1Ky/Py0cRzXTH5uujmIWyj6PC2qERM4a6wWDwIPCvT6D7Wk93hlMPRl9?=
 =?us-ascii?Q?vtx2gha7FjWs2fQN/ysKHGxue3xjqKM3HwMMbxXYwvdOZZlRkyqCnbd6nw/I?=
 =?us-ascii?Q?YGbRKexvR1K3EeipHdvQNjxwwGtAyjyd4tgoHDbD+etErjVrbYCUBYG4x/qp?=
 =?us-ascii?Q?XkNhFEG/RqbxI0StuNmrXRe+Z/NDkMXv2j+/lhlJvchZDos0fiAn3rfQiNOt?=
 =?us-ascii?Q?DXjfKF8Rb/yewGEjQW11sZ659rh3f42ew5FX7Vbpsw2j0GXP1rnajE+3WeYX?=
 =?us-ascii?Q?272kXWB35Gg0v4BoVOcVqPkO0yle2VVIunrnY9Wsm7/xr9DKZedObnkk+HRW?=
 =?us-ascii?Q?updttinb2QquFFNVrVl9kbFbkQVIRwh9jQB0ITGXG4uxcN515iw/4V6abqdW?=
 =?us-ascii?Q?hGqVzut3NrAS/Mb3juzA0a7TUy2HsidCs0WFJgYpWRKHA0btTVYdGXv2810M?=
 =?us-ascii?Q?7Opes8cfuiJkgCJ+ee7rXPwsrvk70VrLjRViVfI4pWnsVjsOmEDk4/4pz62Y?=
 =?us-ascii?Q?CHB9ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b025cc39-fa32-4242-b69e-08d9b4c56d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 12:23:48.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKM4HnSWY1BJdZ96hAhePhfh9OOV4Qr6n9eDxSIiLqYOZ998vpe79yL6LpGyYDlMLJuaW0gDhrfZ4fhlQgg7Pfk1/S5AbPdapldqpRSSMfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>=20
> > I forgot to add stubs in case tracing is disabled.
> >
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>=20
> Fixes tag? I can add that.

I skipped that because it's not merged in Linus's tree yet, so, no stable c=
onsideration.
I didn't know we need a Fixes tag for patches that are just in next as well=
.

>=20
> Luca, as this fixes a build problem I think I should take this directly t=
o
> wireless-drivers-next. Ack?
>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches
