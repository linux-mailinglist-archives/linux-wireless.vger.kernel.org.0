Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB9591CA6
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Aug 2022 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiHMVEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Aug 2022 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiHMVEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Aug 2022 17:04:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689711A2A
        for <linux-wireless@vger.kernel.org>; Sat, 13 Aug 2022 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660424640; x=1691960640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y4iJpBGSoOEWTaEBA2lI9MB5iH+H8R4pE3Adj+y5/G0=;
  b=js+K7a2uR6hJReRvGWBtioEZczBR4MrD1+IWXI6tTt/Dflz+qSnQqQ/b
   ulkTgrq/YPTIPH8BfRIrHV2U2VjCsfd5gRr6yJ9uhdL2UusG1GiOCBw1v
   9+zngFifE/p0OiFku/N48oRXdvy8e6zy1OBbdkDBoswxa+7NlOIZZft9/
   ITTKXbOr0azh976Tm0GwIW7U+qVPvPLhCOkdwpmw6JWYYjjvGq4reuBwp
   YROeO+VAhUPFioGxDIPbYnIH59cxIIoKSj9J4RWwPhDfvaCpTjPvYq0Nm
   tX4Pi3z+sWhQBrfOwNRDDWqY63y7igGIoBwwNcKnA/p5Jumk8e3OlQcIu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292572838"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292572838"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 14:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="851892609"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 14:03:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 13 Aug 2022 14:03:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 13 Aug 2022 14:03:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 13 Aug 2022 14:03:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 13 Aug 2022 14:03:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGxbRLD5AHHbqfk7ki844UsvpM4Ndo6zL7qQCK6xNxXmW55FlAd2AyTq2C2jjp52qvhWwa0TS07+xMLNDM5wRv12N978lLisjEJhFAiPU7OaEZDEXspyP1jerJ+1yiyH1T+HhBfC5BekB3lQPoza1diXXF1LobHWIGJrzM4CQpeZwD2YciCS5mCGz3lbs26QgCTuIGDXTr2c8F2gNDaVCvhFnQ5XC3bQTzePHeNX23G2dCpQ6kl0paiM5ozyM6uHKCW0itbg6pJlUT0DvzDyilZ++yc+rQWElLy1UAGEWpzrOy8YkcudUcDtf7u0U0k0XWo/hlNCl2wtzhODwcVAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4iJpBGSoOEWTaEBA2lI9MB5iH+H8R4pE3Adj+y5/G0=;
 b=IvblWQEY5Yk66cM08o3aYj4wxZQ4+gAWjCjDB17J3j7SOREV4NY/0Lo/VQ1uAS7MxcTyCvKm1et+sUfn6vN+OcbhsyDAOoo1UPwNL88t44q1YwhhtZbZnzlZaTW3Vv/OuhPphMlrlP/2KopgFJDxT2h0Dqp33NKKD0+iRhcPPcJn3HamcfUjiDm+Vl5IQjptGLFt47oAZNO62F5t0z9Bd2pSdvJ8AVPgNux47Y8PZVUNjaVSbvY2+GzG8x5KPf140YS7dfv0YHJEpqrqHOi5CTMmnWUEoo7DDSkuEDeQiPA3p5iDIlaRAr7niGobMisU1ax5oixn3Y+OkEU5gZhFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by DM5PR11MB2026.namprd11.prod.outlook.com (2603:10b6:3:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sat, 13 Aug
 2022 21:03:56 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::ecf1:8a36:deed:536b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::ecf1:8a36:deed:536b%9]) with mapi id 15.20.5504.025; Sat, 13 Aug 2022
 21:03:55 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Joachim Breitner <mail@joachim-breitner.de>,
        "toke@toke.dk" <toke@toke.dk>
CC:     "Stern, Avraham" <avraham.stern@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYrmd1m9mnobFl60mNdzyBf8NdY62tUz3A
Date:   Sat, 13 Aug 2022 21:03:55 +0000
Message-ID: <SA1PR11MB5825CF723F193508BC04B051F2669@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <87ilr4hv8k.fsf@toke.dk>
 <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
In-Reply-To: <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1a55ace-051b-462a-fcac-08da7d6f559c
x-ms-traffictypediagnostic: DM5PR11MB2026:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQDMWQLMMTOH32yg6KjopqsOpHeTsTVj16BlPFI//WQFQ6IgLOypa7vOfZ8ICAQuFhHZ2gtgpomkDBYehyWb8ZSXZgJ6hEv5Pd8O4Gpda0wTE2eAPk2sBMdC65/QioaS9vUaZvlLharzUPccAWRTwwfO4FClBi74oEy4mNNPJATDyTfA8cSUzmWM3lVMItMV6x3+yTgLWW/14jQcQxfeDf+zXHnCB9sjFZa74f2wGP9MMd2Db6Sl+W9l6HxvwSQIYzeFh96hVPUbXA0kPT0c81bLBU3NVC6z6XkMq8yeM44F2HGLqSuQIXCcYBcokP7JWoEFpqAUBhQ0+z1Bj8hhP4fDZMgSSsvyV4CVhghxXlavkUJD9YBswDJ+VXtu+YLgpLZ7TZSopO0SboSZwnHa7mmSCNfI32wlrUYoBTR5yvVVwkuv7EfLYSk0vt186fskfIfjY11AzBxQpWwEGlCF53M/SFqxZhfctB3XxHBTJWCFKXK0QKszei75ZqIdX4gqFlF9kOqac+wFL8HcbG4poynJPwGFJ6WnfnJBw15+H52I9WJtsUWl9vD7TsOFDrnn25gwo1JEW8hh6JRxQ/AVazsWeemjYkip42ZqKKE1MAFYS6WrVscuvIE7uvDnFrWHR1Jm38C7zB4ufXdbio/wgw8Ec3tXRNzm88/7P1Q24orwWKU66nY4zit9dF6CgA/Mas+EuoyWdKFCBoxwdRsiVS8cMeXxesXwFTqtd6oX5+Ma0MAey5VmmlA6r1BhX7U5TRZkXa7agUAifrHHpyjCUl3nhuZxarjkPWpA5pSmrGvyE7qen9qjHuvZtF8Qf18D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(346002)(136003)(82960400001)(38070700005)(38100700002)(86362001)(186003)(83380400001)(4326008)(4744005)(5660300002)(66556008)(8936002)(15650500001)(8676002)(66476007)(2906002)(122000001)(66446008)(52536014)(33656002)(55016003)(64756008)(66946007)(41300700001)(71200400001)(9686003)(6506007)(26005)(7696005)(76116006)(316002)(54906003)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Mnfa7zmHBwafcyxg/e3ECMG9uFMihRpl67LQnEpoZdSSh6jOuVgOC4HzSSB?=
 =?us-ascii?Q?27kMRjac/oex0Bc6uN5U0y6zfNJd0utO4kNGD4tCfv4KvCKD5SjWpZeZGV6G?=
 =?us-ascii?Q?8DaC3zcI1o39zAMwEGIXYnJVzvgCiUxsFem1pYDaovhFFGgONXRD4Wu7zb33?=
 =?us-ascii?Q?gsPYq+mfmuh00WGOfXbZglB6IIU2jLOVMZLeiA39Suw8e8NpZf5eXcFrkf8J?=
 =?us-ascii?Q?USg9sLMU10f8fQWgT9qeAQLc6yJXCRQpb7vyoETUAj2AOw7MemItdi354cae?=
 =?us-ascii?Q?EM7lwVc9zaKs/0DFfWZ0yK0thuQkGOguNWt7cMRKI2PPL6Va4jVoD5NV/oAf?=
 =?us-ascii?Q?O2Snfs9TmlvemQi3+DCB+ncpSOJPe6vIus7Rzu7doTf5SBywzu5avFkBCSRR?=
 =?us-ascii?Q?Rb+hAUTuiw4TtbdbBdOat2S0/sJhAuqj1FARFEn2SsJvzni5iHCYToQu2KUR?=
 =?us-ascii?Q?CayOsf3UT3TX5zPeY6EFSJ4dITgmD2ls1rMQEBNTfuLkdTgg1y0vRnww+tWq?=
 =?us-ascii?Q?pLZR/Il/EYT6IiDxe78RO/UykNaUT/+jVCdNHjUiGGMPD3i288B3HFOHQlD+?=
 =?us-ascii?Q?9odtMItZMcLWJuQG8eTyNQ6uykTmc1j2yn3SFzMD3vaSNNM1GFA5chFoWkVD?=
 =?us-ascii?Q?aRIXurEtfJE4w28MyO8HU6HoOY+nKbcRmMk4O/kelH5nJJRZIxPWvUWul6Gv?=
 =?us-ascii?Q?cQNlG6Qz4bKMfojYZlbKGY85Se9TAZY3YgbvvvS/t0SM3G+H+Em12m2V9zSx?=
 =?us-ascii?Q?D/XMJyqzhyFEr1FSCVKpmIHuAgonnVcdAgXFYV3YjEY6ZT3RaNLa2AHBMnvn?=
 =?us-ascii?Q?NwsftpSzU2xPzjZjv5B0y6fczPKDJC2IoLOAj3+FBnO9k05003Fq04qoHlHB?=
 =?us-ascii?Q?SfsCWISdlriAYw8XCCCBoCJE6cYUu4sCy5n48OQ5ZRvZjwCnIRT63lj8Iesx?=
 =?us-ascii?Q?DHmedUH+kHFRTvmdrb+E6Mwum/58j9OpZplZmquEalL1OhJZyoue1YqbilaA?=
 =?us-ascii?Q?1qyjMB2v9CWAJKsvxT97VQlAAIqMXn0sAxFWUBaiV4ek4p8W5rirKwBCALOG?=
 =?us-ascii?Q?EQi+X2heoSBS1jSScsj8cokWq3gbL8ykg2mYA3HW2sPWN+1lluTLdqAEMBmO?=
 =?us-ascii?Q?zIasMDSMNRZ/dRgzCpEOJjJNdGRmXjnTztj0CwY6sVxwiCaAQUrwGv/oAHRE?=
 =?us-ascii?Q?0T2VxK1momfhVyvptoQV0LG0CfIWdhRQmMJKBTRNSr9jhJpJYP4aQudDVGJ/?=
 =?us-ascii?Q?Gmyoyj8oq1pHJgpU4BL4cA9riLBFJmasVBFs/aGnlzxWyyr/JtpaJ+mLeB8M?=
 =?us-ascii?Q?GaLFKxOYjD/JVDRWegC5bf7mvRieF7udnpQv3OPWIeo+F+GlIjUJ6waY2hPA?=
 =?us-ascii?Q?8jkJht+6TrOCxaPvihf6bYwykOhbQ8cqrJmo9ztCWCrATgpL0+NhQcQc+mWa?=
 =?us-ascii?Q?JMM1rmVsnkjp4JPwl/iF7p3e4rCtKFwSLr+sZ6UiAKr5kPtOJxwFb5BeZy/M?=
 =?us-ascii?Q?jyqowZUMHgTxdCYR3j11E59THS9s/I9dtY78sZK0Ya6O+plHh9x67qYzuCSU?=
 =?us-ascii?Q?/DiBZJYjNUt31DpLXqhNwXQiOV6GqNE2UVPF3I+qfOG9C47/MDg649/f1jbY?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a55ace-051b-462a-fcac-08da7d6f559c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2022 21:03:55.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4z5LQ8vAaalUUri2diz0+tv0r34BVzPu75zvaNhp2P038CGzGQE96u/PsiYAjAWm3foBjHc3rbo8fOxfIt9gTIKIjyYKF1VyJ5vBurw79OQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2026
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



>=20
> Hello Emmanuel,
>=20
> > suspend. I get errors like these in dmesg:
> >
> > [104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b8:58 by
> > local choice (Reason: 3=3DDEAUTH_LEAVING) [104393.347775] iwlmei
> > 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Couldn't get ACK
> > from CSME on HOST_GOES_DOWN message [104393.347876] iwlmei
> > 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: failed to send the
> > SAP_ME_MSG_CHECK_SHARED_AREA message -19
> >
> > And when the host comes back up, there is no connectivity. Restarting
> > iwd fixes the problem.
>=20
> I am hitting the same problem, on Kernel 5.19, with the same Intel Wi- Fi=
 6
> AX201 device. I reported this initially to iwd, but they said it might be=
 a kernel
> problem, so I found this thread.
>=20
> Has there been a solution since?
>=20

I moved on to other things, so I'll let the other people reply on this.

Cheers
