Return-Path: <linux-wireless+bounces-472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9D806A0C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C35B209F8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFF182A2;
	Wed,  6 Dec 2023 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAaDj9TU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2F3A1
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852471; x=1733388471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yIS+NI8kLaoq+Xs2WsmvgFAVtRc8cS1ap3D76i0o+eU=;
  b=NAaDj9TUwp81eZ18c8gv3SNiYg17LaGcYVhklJx/9VN4BWgtbxft95Rr
   FuBmeoP6i4hkVlTeZQtWQytUkoLgT20mmasvR1dx0Z4gkTI2z/2qfJNMs
   sTg413vFP1kqLlbEDuozF86psklfpmxvjPucKiGcMpfZoCWHXqpkiRovs
   QN8KjI6AuBdy8+9fDTVbe/U4SJtGo7D0YKqbQVy5nuBFPQzE2VKR3lP4j
   QQ9L2Wdb0X/gjchNc1SbNxx17oAHuTZzY16EvGBdHNyYzu58d0yas2D1G
   CrPQz2z6UXGg2qm6BwHQSHH4sD93yIVnIBzRDalkVAuRZqkFuvgsLUmjf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396817585"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="396817585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="862042654"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="862042654"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 00:46:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 00:46:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 00:46:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 00:46:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMfdIewXpnJhOsoXaEo7DOccVjv+oMlQe5gF7UjgBYfLd2CQLHtJbAOl2BQIwFF1bY+e6UBwQgyTH7gHqKFj3KQT8ENlDgEoY37Ig3w3W6kQBwZeB8u+g9tFXgBKABKLITXXUrUqAOc6sMjMy7Qb0t3apZvE/d8FlcLFxOj+T9EQQGoNLE0z3ezUMcLrG7xurB402iGp9+RMnQuuLf2p7J00Q92PPkeMwB5kWNADdggmnX8q0wIzzwocixCsDqVWq1xJYMmt2u1poGMZXUb+90hjtAYrnNG9ROjPiKjwMefALaN0hIJ7J2GFeSKGRqG1eyUqvvBE8sd4jbI0CUzi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPw6MTu7qhu9ki7hO3NWJTbtCH2H6Af0fZtbnJh0tHE=;
 b=WWtgMVKupe/HD26llhYdLRra66UCsUZ7ksuTrdRbfZgmQ8Kc9Jmyj4lu2//759TfHbkodc3jc2qT1rtsFC4zZyilJv5eX5yWjxaxKL5DRIBGTzpXL8ozjB5KFM4i80cUMcL9WggIr9R/CZDGdzza3x1EMV/EtPBwjBtO9PYPBNLCqhdkBdPBpSXDa/0Y6ud1Jvf/j2ha0S8cshDne5PD7jXUMB97Fe/eOn/t2LgbyiPD572J+v1FOTZvCmnItcRZpX7icSJrubqJyhJE5/JQFF0vCZq+O4KY7c3/2hbAlNq0RyK3WoKiiji/hqmVIlG1TLdBWtjoZsj5+anijKGuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 08:46:43 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::94c7:eefa:414b:4757]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::94c7:eefa:414b:4757%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 08:46:42 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 00/13] wifi: iwlwifi: updates - 2023-12-06
Thread-Topic: [PATCH 00/13] wifi: iwlwifi: updates - 2023-12-06
Thread-Index: AQHaKB86sEecb6PkVkKB78eT8qDiDbCb8M2A
Date: Wed, 6 Dec 2023 08:46:42 +0000
Message-ID: <MW5PR11MB5810D76A1FE756BE967C5A84A384A@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20231207023602.968890-1-miriam.rachel.korenblit@intel.com>
In-Reply-To: <20231207023602.968890-1-miriam.rachel.korenblit@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH7PR11MB6356:EE_
x-ms-office365-filtering-correlation-id: 161c80f0-6aa0-4d79-cd49-08dbf637df19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqa6TXNuk/p81XlJ7aTev6JpvfhdzxzjGefhGVQ5lJ6mw7Xt2MRq2DyD1m3AX0GBDHRTn9gYM5cjOLSbFYjB3I6ckQ3Y+jnYL+0xf1+UhvnJX9uI57KSuam44h3GIxUWIa5qXieXdSn2nAzKtlcLoswXAyB1RhU9Q+DFZZqXvuQEgHu+KLqv3vrzaHvWjigE7O57b6zCHOd/AYL/AxAC5McU4hMlvyxu8cmudMp50Mp9OF3S90c8lbN5QenIAheopi52T+cJGIVNI6exAVykgRKtyWvLJDrXyS+lanIArnITJl+heRDgc2adfgY0PsFvw5zRzJLcvEKTbvOae40Bps7rIfGgLxhevo8YyMtsrJVYdPSmXcDEBCnDAi3+z0qFCbUILjSU702KsUH4Pr96bKvf8yubK6/U0HNHMV8uDEHMQsUg1LjVYiI/zYK3pkqBxzAUNUKDby5W//SIP23C54LYWi6n2Q4ZOYtA9qYquEUVxkfiAh883t94LJYqXuLDCSOhRWtcXehgffn+bLk0qrevhU7tNsOdUlgMcKXoQ1ISGRixWw2S2zuxZn5e2gvUnxGMkThJAV7nx7WcJ5x+fH6DGzxz9a1vFUeS8B6QTY8W/ksYCd5xZgLJiszbBJ7f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(7696005)(38070700009)(6506007)(53546011)(71200400001)(52536014)(86362001)(8676002)(8936002)(4326008)(41300700001)(33656002)(55016003)(38100700002)(82960400001)(122000001)(15650500001)(2906002)(9686003)(26005)(83380400001)(76116006)(478600001)(316002)(110136005)(66556008)(66946007)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RouhKc8sKNRHdtu14jp1BIK6aY8Q8bA/XD6V/xfKsQenkyLXNyNZLSrkWC9M?=
 =?us-ascii?Q?HMKZA/2UYC3KvR7dAJlL7KA9d8vAwqtcn7L1ruYyoczavdHyPTEhZuHLeJEJ?=
 =?us-ascii?Q?8nxRDgXfkIRgbnXHJm9MVRhnc75gHf+yaf/A3y6en+WEhQ5iIytVy0Kjmk5i?=
 =?us-ascii?Q?MOravYARafpe9Pm3Vpz6aNTEolnEslUzAh4DmvvS4MKYbbjDJHOkbetFUw6N?=
 =?us-ascii?Q?65UouSjxkaKA4k0OhOLoGfE2/yuGINiIcS8OeE5EX6TGwksJ+t6lBk7Lxe9v?=
 =?us-ascii?Q?5BEOtr1h0cWxetYCqOuM7dEZ+lgjA6Mpz9dhIdJvazM3cPX0sAlvZk+TFbiB?=
 =?us-ascii?Q?cEp4MJWD3ceSkiHctAIJF55fT36Wv5GlKplxyYvTq5sc4zil455Ha3FmB+LR?=
 =?us-ascii?Q?uaCLWtPavLBcD8u3RFCTPttw9t4MpnH665y1UWBQORi6sWao/svgpAvC7fgc?=
 =?us-ascii?Q?kS2vQDjyMyKSkh/ILKxBf3ZY45qhFJPLI5R5PmGP/SM4m4yj00toPFpKbSjQ?=
 =?us-ascii?Q?asvFalBbpQHWofYSYXRAuuERietZI47AJ02BCj+V72GKVMPFzk0yTtmB9hcX?=
 =?us-ascii?Q?6KgrMSotWKeLNcAKBnZO9lz3e/WPlxDNxGRUBfqoE9hJKvrBr7+BiixBrB6Q?=
 =?us-ascii?Q?D+9tMGSbUMO8tWPBGYz8K975eKPMPAj0skZEwH/xXXrDwpDAOqocjaiOMtFU?=
 =?us-ascii?Q?bydX737/1H7nDrl2PMN8cG6ZiQ3FvfxI3dmLgVPfaHzZ6lTiikRGqU33qjXf?=
 =?us-ascii?Q?tWv12JcOBv8GP9ZGTh8k/ccPUxfN4DBkLgERudEQJckrYkQKcaKsO9PpDrLo?=
 =?us-ascii?Q?43Yve6M5izex3/x0AqyCAzkJV5ksigumGvhFw3MznVuahutc4NXpz5OVUMg4?=
 =?us-ascii?Q?mfHgfIcsLk/dFs21u2mgztsTmz3XEKC99OjN36IqWqWMicH6/l7V8Taur+wK?=
 =?us-ascii?Q?QHdFIf6YMmWgaO944Vshvyo4IK9tlGNTYNMCnGkZBQJcsxF//bufKRHFpbzp?=
 =?us-ascii?Q?9KR6zSKQtbs8eNaFJPplqwDjrXImvgaBEmR3q6Yu152OysxNL3ukgClItrJe?=
 =?us-ascii?Q?V5M+NVnngtEajGUGgMe5vhUDPis5fxgSei77cG6Z0fAXMSqw1tSxvwjIC/Y2?=
 =?us-ascii?Q?9ej3z5i1VmE9tqaWmQqTCocBHtI2MmGz2t788tAmanF7piH7Kjyyqwq+QMQF?=
 =?us-ascii?Q?k4C5aLXKt3vG5Wq1IAzGjeGJs6cKyVs465bdmp/zFVgCSkMDJqOV8n1vPt6Y?=
 =?us-ascii?Q?18J2Q3ZEdxnGf8jyFsSVXOpdBo1J/p8KFnxF79meRnfjk3TiOX6VFKXoO9XN?=
 =?us-ascii?Q?eahea1bFcKkQJqaZoJK/t05fnMbVJ/e54iqrafE8VoUloUdnAULgv08msvJl?=
 =?us-ascii?Q?OHS/7RBA5Gg97e1GVP8kPKx+VPzI1UPjibdRrJOstq5Du1BSx6eQumXO/vpQ?=
 =?us-ascii?Q?iNOAI4CXLWjBt/ttil3n+yylEwis0yAgSP146ejzRhrcOYn45eXnAQ2HzcZ0?=
 =?us-ascii?Q?HQqeLzNNJqrdZVup3DCemzW1X2MjAERn78MVnNzJjTkuC8AaIsKHFuHU0TSH?=
 =?us-ascii?Q?A8Tue1vMh+SO5E1B5Sqd5mw/370mcYRPsVbM+YE6uzb7KpKyIta4EX6/SOqm?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161c80f0-6aa0-4d79-cd49-08dbf637df19
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 08:46:42.9584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnEJhLCQSrAG7Plpb7bpzxV4EJh2r+IwVHqWDLwAeam3HliQkS+AWFM1diWtyel2bInRSuZ4wOIDpj9tM8G5fNBA1DcJcPe8JwUO8phU7QcG/X/POkQ1ZZPT56XF/3K1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com

> From: miriam.rachel.korenblit@intel.com <miriam.rachel.korenblit@intel.co=
m>
> Sent: Thursday, December 07, 2023 04:36
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; Korenblit, Miriam Rachel
> <miriam.rachel.korenblit@intel.com>
> Subject: [PATCH 00/13] wifi: iwlwifi: updates - 2023-12-06
>=20
> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>=20
> Hi,
>=20
> This patch set includes iwlwifi patches intended for v6.8
>=20
> It contains a few bugfixes and cleanups.
>=20
> Thanks,
> Miri
>=20
>=20
> Avraham Stern (1):
>   wifi: iwlwifi: avoid a NULL pointer dereference
>=20
> Emmanuel Grumbach (2):
>   wifi: iwlwifi: mvm: add a debugfs hook to clear the monitor data
>   wifi: iwlwifi: mvm: do not send STA_DISABLE_TX_CMD for newer firmware
>=20
> Ilan Peer (2):
>   wifi: iwlwifi: mvm: Use the link ID provided in scan request
>   wifi: iwlwifi: mvm: Correctly report TSF data in scan complete
>=20
> Johannes Berg (7):
>   wifi: iwlwifi: refactor RX tracing
>   wifi: iwlwifi: pcie: clean up device removal work
>   wifi: iwlwifi: pcie: dump CSRs before removal
>   wifi: iwlwifi: pcie: get_crf_id() can be void
>   wifi: iwlwifi: fw: file: don't use [0] for variable arrays
>   wifi: iwlwifi: remove async command callback
>   iwlwifi: pcie: add another missing bh-disable for rxq->lock
>=20
> Miri Korenblit (1):
>   wifi: iwlwifi: don't support triggered EHT CQI feedback
>=20
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 10 ++++
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  1 +
>  drivers/net/wireless/intel/iwlwifi/fw/file.h  |  7 ++-
> .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  2 +-
> .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  1 +
>  .../intel/iwlwifi/iwl-devtrace-data.h         | 15 +++---
>  .../intel/iwlwifi/iwl-devtrace-iwlwifi.h      | 17 +++----
>  .../net/wireless/intel/iwlwifi/iwl-devtrace.c | 17 ++++++-
> .../net/wireless/intel/iwlwifi/iwl-devtrace.h | 21 ++++++--
>  .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  3 +-
>  .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 11 ----
>  .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 --
>  .../net/wireless/intel/iwlwifi/iwl-trans.h    | 23 +--------
>  .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 16 ++++++
> .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  3 ++
> drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 +++
> drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 13 -----
> drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 31 +++++++----
> drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 14 ++---
> drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  5 +-
> drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  5 +-
>  .../net/wireless/intel/iwlwifi/pcie/trans.c   | 51 +++++++------------
>  .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  5 +-
> drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 34 ++++++++++++-
>  24 files changed, 178 insertions(+), 138 deletions(-)
>=20
> --
> 2.34.1
>=20

Please ignore this email, sending the whole sequence in a few moments.

Thanks,
Miri

