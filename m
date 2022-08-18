Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C384597F5F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbiHRHla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiHRHl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 03:41:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33A75F9A3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660808487; x=1692344487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=p/voaWHdayp2LjTHwfo71ZCsg82xIw7plSMOOcAhMfY=;
  b=epE8KYhL2efWinBGLUcCA7SNFj/KD2t5BT0yR0pGBYKjVc+GsoJSFrkK
   i/Djgs2gkjiMpz6YvtD7ir7grmg7ZR5s0IlXPPvs7ZZqzVANfTKj+tUTk
   qs8qU5R2kFhNHvZVa5fMFOYl2T9JQfmigeuOumzHln7GLkwim6IliLan1
   hk91G2i36LT+9XakE85oRQYPfHJayImL5YGnClPpCYw3tkXzp6TeO5gE9
   o0ZpTCGTo5vp5+OPHN1WU3KiwYFbw2TTWEjnpnSQ6Hdj5LymCuGWGC0IN
   W5EgcGsKHpnXMlV83141x5XszlcYfELdojFQOkpRT5g2OPJ2HVfGMf9FH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="291444657"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="291444657"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 00:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="607730379"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2022 00:41:27 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 00:41:26 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 00:41:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 00:41:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 00:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/kanaS6CJWOwYvzVqHOoOgxitvfk3iqJTZ+nmFPs1hOCBgLd+OzeJU/14wvPJxiJ+z939/TIIX6b7Dag7AgXJ45rSRe3W6kThSGeDIdF6BUt1rfazeu3UqVMkNVac62Sdg0fIezSBp5I4w0Z4uVjrid4OT22ytmfrv9EL4EUSlooFcQ9t/VIwAiN5jKZrKXxLRfYFWii1mHe51hAi8U5loXna6lPCNcwoCrAjwUC9cBBDBdUjSiLJvS4uwlmq6wUvteoaseZSzEtDC4iYGE21AuaQWh+F1fgt9A2mMTMdyUoLC6Feqpwt2k4ERaG5ADb1lIEonSGr5RAwytHnruhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC6jurO1feo27hudEW9naBH3A9DuXrT0u6Ncv8LVMmo=;
 b=j04ut6Gvz56Qgd0KFv/17on16N0ow3OjhVIBLwKhPH03enjVySOTVg1SWx+qGoBERfVIyGYORq7asd4UrgrMXPHnu6Q/ApklLYw/l0+v3+iSL0Ekqi0+EAwEOfD16D69jZSYdYixlJmDiffk7iymPCWa9C0kXjRrGLBe2DK2QeCzEFD32yNWGBogj4T3QlozdCxjsUPhITIVxkaQWbvpYdyyKTB8OW7ds/KO435d+hfJqrlamHXyh1ZEs8yy65OTDsM72fvd/c9KWwm9o+MxI3o47b+TzzhjcgvLmHMk60Ae2zLXptFqWuCFYTe/F9zcv19ElqfWLqrehqlscHENMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2256.namprd11.prod.outlook.com
 (2603:10b6:301:57::19) by SJ0PR11MB5165.namprd11.prod.outlook.com
 (2603:10b6:a03:2ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 07:41:23 +0000
Received: from MWHPR1101MB2256.namprd11.prod.outlook.com
 ([fe80::adb5:b4b7:47c4:6b2a]) by MWHPR1101MB2256.namprd11.prod.outlook.com
 ([fe80::adb5:b4b7:47c4:6b2a%5]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 07:41:22 +0000
From:   "Stern, Avraham" <avraham.stern@intel.com>
To:     Joachim Breitner <mail@joachim-breitner.de>,
        "toke@toke.dk" <toke@toke.dk>
CC:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYrmd2pkvk32qVYUuBtO/S5JgINK20RL+A
Date:   Thu, 18 Aug 2022 07:41:22 +0000
Message-ID: <MWHPR1101MB225655474DB1C0998812A1FBFF6D9@MWHPR1101MB2256.namprd11.prod.outlook.com>
References: <87ilr4hv8k.fsf@toke.dk>
 <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
In-Reply-To: <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a226a79a-d30a-42ea-8433-08da80ed0c5c
x-ms-traffictypediagnostic: SJ0PR11MB5165:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3lMWIj1NQNWuYxVS8LkP/MsBVl5WGziG4loFYI8S0qsyZSIZ6upCXr/UcKpeh790brg9n5qV28qILcA0oVrpLXUsbOMDo2qOLK/GTdd1geM5v32Cs2eLiXXgIHdt6bQgTHIXvfy5yj9PfyE1W/XuREruZCVs8PEgmlfAfcDLA/uuYKQjS6qeiq9/JHRT4Fv6GokclQGuWyb9jBEZkj39b5yyag0VJ3yMyuqedUdKLlfsXMlbOzgqzILJwY+IQjuQYFbIvaTOe/P58EfNMMSGUJASxNHlJhRIfHlW9ecyarsfrOvyB4uq0RcrMHyQPA46jV7LRldNsXNSZvLhiuVFkWa6GD1mMsWOs38SfQ2MQi7k/vkrVObMmKKs9kCCy48H4GC+jLrlL9+KMSTB1eU2BatJdkUZJsIbLk49Q9eFZfs+1Rpq8fJePagP7QAD2UCq33VHJS0OS6bM0eQ86HdxJXAOAgb4hdkjM1r4wL491WaXBwX7axswY+kM8/u7WGpfUT1YtMI0SPHDsXpXF8PnSNAoK6uwRZNwvpYvsYAcu+Xa1AFcXuFWrCmNvnhM+dukGlFBzmNvt8/PstPB+XLd/Oqbj56PmaVgVS9TqkaC20gUzDft9j5c8HVaWZHCnfxXMdPv6r/Ek6NGD3CqsceS03Fe+E8JKARKc2V5Z4XfzgEILSWndvEttYeOTqUCL2IC+q7DWiSsaUwmOh4n0R6bh4GcQ1FrKSOgPBZi3mtFZ837zRtUmNgkUPNsp4lmo7WXGdL0gmjbNN0eEbvAkgoiDUENl5xbZG6Nq6KIgS0GAO3jjSzYQW2fgZcDR12kMAd4wQkA5h4vlic7OBWUgUgfLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(366004)(376002)(396003)(9686003)(186003)(82960400001)(6506007)(7696005)(33656002)(53546011)(86362001)(38070700005)(38100700002)(122000001)(83380400001)(71200400001)(55016003)(5660300002)(8676002)(478600001)(966005)(66946007)(4326008)(8936002)(76116006)(52536014)(66476007)(2906002)(66556008)(15650500001)(64756008)(66446008)(54906003)(41300700001)(316002)(110136005)(18886065003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYBHaAlPDu7IqKvfO675LoWMJ9AqeICVs+vzQaE2DZKZFq+o5MDm5ZnEGBPD?=
 =?us-ascii?Q?WZx703ji+m78LR4EKifo4/yzyodMJFI3SDAyTxpzRW44IggnCQ7Zf3eoFs1a?=
 =?us-ascii?Q?MaBlnI3nnCSBYzIxlKG2m6iI+siw6B+2bCmBLp9tVsEz3tO4tdmDZk/sr6GZ?=
 =?us-ascii?Q?P8w11g6Wm+BQNvNliInhHqIMVl8ji49tYMDZRwY0Ei/4e3Tbq+7L+UrNinVK?=
 =?us-ascii?Q?mDmDQOmpOzU4YhyXhaD+dILUZzBYXBKZbbkVeLsSNWi7Gr9uUp0R8Zpv4q9y?=
 =?us-ascii?Q?OiocDE7p7oHlCn5JkhJgaDKYb9CMPwH/uy+hSrnykf/Or3qAQnHhx1oSK0+h?=
 =?us-ascii?Q?SK/5zBjZQiI3KJZypcEc91RrGVMIcw4womLfHEm4CZFdM/iAfqocsB6mCcab?=
 =?us-ascii?Q?hwftbBDAwUjaEM9m7FVgTe7fBE64xV2kzPAES5617nSOW53MYBNJ7X6UQVx+?=
 =?us-ascii?Q?pxCxpdxsl+IHQMGsmiNFOm5EzOkIWrp8TCxrYaHLNm0zeN+QtECSnbCgVnjb?=
 =?us-ascii?Q?cJqZB8difOodKsobqQ2ODPo02aVyiOA+bSz7DlA8OsvsALGQF/tiE+oWloQI?=
 =?us-ascii?Q?RwTqPOgptk09ZjAPX7I/JFdskVjTVvoS8tNoO5xAtbCll46i/MfWuZBFNOeu?=
 =?us-ascii?Q?5IrI3BI/QN0WGLupV9tEr2hhaGjXf4TcbLOLgAmHSSaBeePBkaQseqX4Yz12?=
 =?us-ascii?Q?M5Qo2igU6qAcy2ZSdjtIyl+QHsbR+csri8w7U0ktIdVMq4g9jB92iDOySYZE?=
 =?us-ascii?Q?ZWkrdkKY4fAjX7hVYVbUUsKdGvb+zlTGIm5iKiUdqkvojCrm05X4G6E2d1nw?=
 =?us-ascii?Q?DEmQXildKVkYIG+s2XUIgivm9Rvqb0G4de3FIIa3A+SP3knixhEIDbtnMQdy?=
 =?us-ascii?Q?WRD5DOSvr9mClWwPxrPKMHA13yExYob1/l3jyRf6BCFteLPCcEYHd+5IEEGE?=
 =?us-ascii?Q?U74DT4wm4vnafWnK0O8aHh3K/T00YjdyyCjBcM8wvcFjLu3KgX6WXOKRUwRZ?=
 =?us-ascii?Q?leE8NbhEaJpJtrnlMnWcq8TjqoLkWJLyX6XWfU0a9kwGWEBVorL/8YgV6w9S?=
 =?us-ascii?Q?sJibmeRbCGMd8YS5i2UJNEv92Cw+O7nzd8wb5CvgcCF04Y/muOdVqCr7f84J?=
 =?us-ascii?Q?wer1iR/+lK67Zb9MqXNWg2ttM4qJDblV9Px+x2cqVj1Sc43lyxeN1zcWd+vu?=
 =?us-ascii?Q?HxYoSriSZtQwRSRE5PAZ+YhRbw+I5pwwHvwOkbqyOk9ev24Eo+85WHBMyo1a?=
 =?us-ascii?Q?GFdD1IzMLHVd51gbLtz6nUhFjG2BOFhXs8JkdvJnLCyMib1HqKHVJVXGuExF?=
 =?us-ascii?Q?5oQtqez6jWWa5zI/uEue4FdPDQOMi/y9N7zvKynxEw0Xr2OCUUU0jD4ReOu7?=
 =?us-ascii?Q?p9E+TE88V5/3GimdojHGK5cOJPIVY9e4dAMuuQNnwuwYY7v5J9vRqec+rMh8?=
 =?us-ascii?Q?e+jFgF9NAgu4EHhyYfuf/CFvfG+gGPRC166axny94yYRDwZV9ePFnROEJTNa?=
 =?us-ascii?Q?FtdV9kEiRjS9IHeJl6sGM/pHYZxPPFsYG/GPDr7iW2uFLVcm07K7MQ1A8e6S?=
 =?us-ascii?Q?Zr+Zq5sOji9JIIrpvYr57JPtVyNCtnvPRnxIxus8GjeL5TjYS5595xvNBnz6?=
 =?us-ascii?Q?BssPBReOtDypFrcg7WzPn84wGxn6hVGkqGPafXKFWFfX?=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a226a79a-d30a-42ea-8433-08da80ed0c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 07:41:22.9184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ksRbfWLA9rCGTIBx8vUV1LDKnUGA5ROydyyThjoQgpmet9Lq3knZ5G/Hl6vZD+SqZg5fLpRZNVWkOsHHiL4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Joachim,

Do you see the iwd task hang stack trace like in Toke's logs?
Can you please send full dmesg?

Thanks,
Avi.

-----Original Message-----
From: Joachim Breitner <mail@joachim-breitner.de> =

Sent: Friday, August 12, 2022 19:20
To: toke@toke.dk
Cc: Stern, Avraham <avraham.stern@intel.com>; Grumbach, Emmanuel <emmanuel.=
grumbach@intel.com>; Greenman, Gregory <gregory.greenman@intel.com>; linux-=
wireless@vger.kernel.org
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17

Hello Emmanuel,

> suspend. I get errors like these in dmesg:
> =

> [104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b8:58 by =

> local choice (Reason: 3=3DDEAUTH_LEAVING) [104393.347775] iwlmei =

> 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Couldn't get ACK =

> from CSME on HOST_GOES_DOWN message [104393.347876] iwlmei =

> 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: failed to send the =

> SAP_ME_MSG_CHECK_SHARED_AREA message -19
> =

> And when the host comes back up, there is no connectivity. Restarting =

> iwd fixes the problem.

I am hitting the same problem, on Kernel 5.19, with the same Intel Wi- Fi 6=
 AX201 device. I reported this initially to iwd, but they said it might be =
a kernel problem, so I found this thread.

Has there been a solution since?

Thanks,
Joachim


--
Joachim Breitner
  mail@joachim-breitner.de
  http://www.joachim-breitner.de/

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

