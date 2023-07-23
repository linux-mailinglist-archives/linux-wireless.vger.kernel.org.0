Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0E75E1B2
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jul 2023 14:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGWMI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jul 2023 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGWMI1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jul 2023 08:08:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4D410C0
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jul 2023 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690114096; x=1721650096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DfyeSNi3pOjrwMrbuk6gJeVylIRDfYU4EmdmN1uYZtw=;
  b=cThjiIaOKzxq+ROV3wUqJ3qFJh1MWjlUw5JGPB2L/5j4qfbaCK0dvabd
   67k7dwO1kPLGvU8z/0ezF8YufFVp0UWBgxQ0U7P9YPEJ90JH26br7W4Br
   uuQ1K5OZ4g/p+ZnooBzYB2b0bB+IXFcdxcN05bMAtS/RsZT964Iz2xRGs
   Y24vtK0mJI1sb5kTjRdxUTMwm2sfosqftkYVNrCbvk63G+esNf7hgQ1Ny
   FzM37n1b/TjpTRTWDxzwgYP3XP8b1Spkn8v5Xd6kYAJPZn3LWhMIUhe0O
   vxqfeNjYF7YErjWCgo7o6xC9GvA2tiJ8KldLRqCOwA6IrMCoUzH2vuLds
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="433509152"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="433509152"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 05:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="760485498"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="760485498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2023 05:08:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 05:08:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 05:08:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 23 Jul 2023 05:08:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 23 Jul 2023 05:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+PYSx4sbUiA3NsEKuliO20UL+uEUDaA2JIqF53jFqJYGFo0yyD6IZ0sEL+G1oPtHsfv79YNYwivb1Bqg83bhmz7JudJlcRHS0jD9sSj+ZygBBegxpPOZW13MYQVWr/tAEhTBM4eQQwVuO0Zy96V4fCcsA9DEj6ONh4k3KAMuyvPrgFWlz5cR5ac6gaOI0/bD6fjiC9vqBTb8uYTr7GWnv1+04ZngGw6OpqmxsAaHaMrXVffK0ZZHugwVislqEOT5+mArHRB6pP+pYX16gHDxZ0jsgSKnx3Dolfph2b3GYiqZlgtiWGe7idmbGqVQt+MyXD7aX5vkcDBAjXiKPyo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfyeSNi3pOjrwMrbuk6gJeVylIRDfYU4EmdmN1uYZtw=;
 b=G3AoSsCBGhiCILz/wdeT+x701MoJgK02+qA0auKWIHQs3irzhvQ7tuwQ7iILAUxCR5LYC43jbjLfGzTSzyaBEFVdy+D05oKN73KWnr0M9pw9tgFMNTiIutXUftyZvoCwqKDtN6STIaOfIGDW43iak3k88ja0QZWPjXsCNCDkLYtP0LE8+dqAM1HkvJko1h6sIapFPQZHfGPAvjaW4rv6fIuZLCuUj1hRrBXptQYTGh9PefgzrYldG1Ibtfv2E3JEcL24rWlVTHYE+W3ELaj+0aNMYsiE3lcCS/I86NqJwuuJecFw4JQQZpVcIWtOA/s3aED9FUZlyF1q9nOB+5CmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Sun, 23 Jul 2023 12:08:11 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::af6:9121:9916:2627]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::af6:9121:9916:2627%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 12:08:10 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: cfg80211: Fix return value in scan logic
Thread-Topic: [PATCH] wifi: cfg80211: Fix return value in scan logic
Thread-Index: AQHZug0EhWzKKdeyik2DrG9Zj+LHs6/BYaYAgAABP4CABeWekA==
Date:   Sun, 23 Jul 2023 12:08:10 +0000
Message-ID: <DM4PR11MB604395E28BDB039042D5E756E93DA@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20230719145120.739521-1-ilan.peer@intel.com>
        <20230719110018.565eff67@kernel.org> <20230719110445.45c2b30b@kernel.org>
In-Reply-To: <20230719110445.45c2b30b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|DM8PR11MB5702:EE_
x-ms-office365-filtering-correlation-id: 7d9c9a09-9aa7-4752-6b57-08db8b757bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJWgZsl41D/116LFnuB9ZiVFsXaaB5tELsqXeHibc5TaUBEKrnkjv81GHdboTdA+8/rQaHIDBBt5+1d2p+kd1zvOmHnQOxLRt7IfxIk1X1/vt3CbfocAcIScPi3eBaFDO/y8sI6vPGDa9Cz+QnDaRRdKPsNvTnjGZVjJmuLZu1eKr3idMJuqWU0mGfdE9TkH+5hpPCg8mciCSXEDb+SMmUvirdZLq0LJKIYuLatTwu2JorO9CyzSl2CAFd9is1Ivyc3LIdTJx2HW3dTzrbz/b/h+zwhK5BulbSIKFLsbdQUL+ax2iGmpJwIb4RL+R9NFtfiL7bsnCftgNCh7bdGEKuflVIPi1V7+fFKGZOsEtQcw1JvHSDRzffxYr6D6ONoGvEMhH9RpfHEimbYOuWR6vNli0MMse1b0pC1RV+GsmE7qW5DDtGPlywaHIElftUimz5tSXiFbkmwg1HVv4Y7ut74YXM8eeBY8dH7dSVZqQkME/MR05Ynd4OWD8jSahMbTq90rBlKFtic6Cc7QMIxJnukr1NS0gOtnYBPY9NEHLKaPWDvCQ7RLlayzgpmFjNrLZfO3NVcqFy710xCq5hLRFvrMis3gxkbVWkKVI3RmuiGqN79PFqd3pPm9/kdV9QFe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(33656002)(86362001)(82960400001)(38070700005)(38100700002)(66556008)(66476007)(66446008)(64756008)(478600001)(6916009)(316002)(41300700001)(66946007)(76116006)(4326008)(5660300002)(52536014)(8936002)(8676002)(9686003)(7696005)(4744005)(2906002)(71200400001)(186003)(6506007)(122000001)(55016003)(83380400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kGIz1ALn/MJu9kirmN9q6OFMvcqo8iEcBg8ZSCkV0JnnswIHfxrQ5bJOudwi?=
 =?us-ascii?Q?3aqHbjbOqHZilSiGQ50QjdCnP98ghzic3oz382fO4RSMFXZk+Ok5ituHg/p+?=
 =?us-ascii?Q?bLsUkxyzPVb+V/GIXC/WUY5STr4CZL7F/4T/QaN2J82vQKM0xEVAXXVvnl/b?=
 =?us-ascii?Q?aIQHsM/XO4o7ykHCkMylXG19VA7ZmF19N2pC+JWiVBnp1SY4EeaFb5l6e7B2?=
 =?us-ascii?Q?9FDBUlMlSMwe3cof/92BYymCVoCWMeSKIoJNwIetvti9SJmyh/vyG+T0V7lP?=
 =?us-ascii?Q?BtNhMHlIWhPB/P29I7MKJz+7F5FMl9nI2uEV4Ht0xUU+lnNwehWtLiMsCNZ5?=
 =?us-ascii?Q?+IVDvkUgwVbGmWE+9gfhs7W45b27iSNd2h6wBWSQUjUwxpsZnqL3JVHhNA0X?=
 =?us-ascii?Q?edr4/cbsHAvuNnNEokQcV0yEldTVxcXXp77XiR0iyOBmHfTh0FSUwdqq7DXP?=
 =?us-ascii?Q?ZGCLnBkWNM4i0WiS8HX4xHALEzyB3zd0hDGqBohDHblJzFYtC93xjt26UDXx?=
 =?us-ascii?Q?oJEcHJk/aambA0tvbJW0pGml0lZQgPoYSX/PUbhOP3locFesYT15IcRg59L4?=
 =?us-ascii?Q?JlajsOgn9Aa2YNPkZ5UGw9t/vG622YWRjF+e4Aum3MpJOM6q6P3j87HPIXPy?=
 =?us-ascii?Q?yJFxY4Hqti6kgbLZNmyjeQtflGbbCRpvxLZiU/yhPjEyEpw7DZXdemHehZeZ?=
 =?us-ascii?Q?1TED7jTKw5tKFCjpR53ntSHXlG/SjEp2cqMHu+XAbTlCFUwwHuo1WCwiB6xT?=
 =?us-ascii?Q?hwK3txS5Rby61mRN8QytKBR8wNyvhpJ3Mg7gDUaDKrd3CE5/n8HWn4Z3LgUF?=
 =?us-ascii?Q?yLhqv+v4SoxVr37X+ZHmS1uCOjcLcnvPNt6YFmLn+A9BnaW5H3qgdaQqwmRA?=
 =?us-ascii?Q?rDWWz+zxKceH6ogepRA4HOeN6tcYR+PdToYjQQieX0GnVFqQY1bHk68qLRzE?=
 =?us-ascii?Q?OX4OjKb/K20qNYeyzKCIX5piBpwMjA1uM9ljNMdpRGbv3E70gyHHVVaA3KWg?=
 =?us-ascii?Q?83pGeNpkCaVimZb5MmS5SEXn+xmbLdH3i6HazQdLMAJH/W0n60fAQaOOguYg?=
 =?us-ascii?Q?qPBShkpCp34ek0lYWhl2HXWabU8Brn1m+jVq9ll/PWasuGdZg/iY2oohlwdo?=
 =?us-ascii?Q?C6fS4I7856o5s/I4eEDXrsdOwluIHfqSaYM00XkxjLuFYcqjbLOvnMyFAB6Q?=
 =?us-ascii?Q?+pnLijnxru7KO1WDjHDppFt2mES63OCd1n5Xr+wZmYVx0d9WPJDlxn+/D0JQ?=
 =?us-ascii?Q?MrrYsrec6voAyUtQ5Bd5F+j3eujMMw/6YTuixbqC8PacdPRigFP9QhiZp/le?=
 =?us-ascii?Q?GSWlgCKZgJRd2buFNAm68akzRwsJjNvVSlh+Fppo3vPUOcjHJrCZS7t4TFha?=
 =?us-ascii?Q?sZ22gFCmm52KuRUG8mvV2B2nym6YT1CjOvcFQk6o9nWcHQDi6v71ZQVyFpEz?=
 =?us-ascii?Q?4q9eLP6qULsNOrknxBhUjy7e/s1vX2PEuRkizVVicaxTtjVosCYZoQu+Vonb?=
 =?us-ascii?Q?3cM0Mu4qSMYcNz9Mf562owwyCoOQGLxq8dckJ2cGHYz016QV7PQFtnr4yA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9c9a09-9aa7-4752-6b57-08db8b757bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 12:08:10.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANy8aLAPRHlR2vdpG8j3dd0nNphdgnruJinHzJAvC390vCxl3Nf20E8sWSh4Btyln4wSiQFbGVn/bA2w4IFZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5702
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, July 19, 2023 21:05
> To: Peer, Ilan <ilan.peer@intel.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: [PATCH] wifi: cfg80211: Fix return value in scan logic
>=20
> On Wed, 19 Jul 2023 11:00:18 -0700 Jakub Kicinski wrote:
> > > This bug was introduced in commit c8cb5b854b40f
> > > ('nl80211/cfg80211: support 6 GHz scanning').
> >
> > And if it does indeed have user-visible impact please use the formal
> > Fixes tag format.
>=20
> Oh yeah, it's from a user report on the list. You should definitely add a=
 Fixes
> tag, and Link: (possibly multiple if there were multiple) to the report.

Done. Thanks!

Ilan.
