Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E428649BE9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 11:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLLKTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 05:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiLLKS5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 05:18:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618866456;
        Mon, 12 Dec 2022 02:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670840334; x=1702376334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RgOMU7GVVXsGdfO8DA4QTrFsSFk+CyuDdC3Pvb9DDow=;
  b=C6fK+6Qp9xT3dc64BzlGhNTUzS5/vqQVwP7UfxJUqkE6b2+6U5yfVlxx
   Lt4SlrsvWIf5NElBI7ed6nOaPGhcWL/Uf+6YZJvgEs4XAsfzgwen8foFM
   IjJmmcNUB3ClRch8bHhXf83F6gEIHmFw9wk2HZhImMIAif3c25nU48WeJ
   6m1Y2b2vFwXMrXDGz2s2LVkxaRJY7PgivL82tYGn+r8u8XOYjx/JOvGgN
   ar6z2BeNWI8rVceZ2n98A2pl2FnDsiB/UPfLzrfPAOc3KSnbAmq4seQG9
   aYhQVbd9ae1k/KczjmihuKZLFXWzoaVskDMcV9K3Tlz7MCk1sZas94Ruf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="305461815"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="305461815"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 02:18:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="680627808"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="680627808"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2022 02:18:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 02:18:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 02:18:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 02:18:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 02:18:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcBBinjmR/9wjVEE4xN7yNJhrKY+l0g251sPURfMUXugslkFt5YU0/+GbKlQyXetaHYaIWCiLdI4lVuij2mx0CFEhFxSGOZs/lfGyQ8bm178bTCF4Wdbc35y/HPvc9vOPGJjQ3y3zc3zko2C+tQT0EiSWGIJP29jwnPCYXk/Bw9Cd/e9zgEQJHM974jqeur/FZgVKY67fkpoA5KGZMiZRYXSmeiHltVonpMT6mqsF09W1W+vyWuKgMg5ofGcg4XfaRkPBRmHVysZQx/eXfvo2GR5yCZ4EYRtU6YfAKtg4tbZIYU72yNHJPKRdcTPStTbtkDWDxWonScxBTe7C8ZbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgOMU7GVVXsGdfO8DA4QTrFsSFk+CyuDdC3Pvb9DDow=;
 b=B74SwcGcmneztXbaJeWpoJLvm2EBu6pBbg7ZPTDtUhNsXBPbKvSdwrt5cGYy9eDh/JZ05bI7U1ckhWE02nzYQuSgRTaZ0K9pILWcShqni2aeRBuTOwgyWh6/RZWxuffKOORbiA5jSYGb6ByQprEeRTrk/xYL4fEhEzHdwu4Nip/Gz43ILPc+s7iQhM4cO8J/M2JuJXhDRg9Fkz1XoXDsV4rttP8pnkxoxE4RgDr5zjrat1q5K6GkcyGU5CIEvaU6hlTmNrX7vQSd/UBmcI+e8jb9Rb2jnVplQ3OZzMMwjlZACqUu+4OThRXe4gedrlnN9RgKjjMwru4JZ87nMtqQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 10:18:47 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 10:18:47 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "ihuguet@redhat.com" <ihuguet@redhat.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jtornosm@redhat.com" <jtornosm@redhat.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "Sade, Jonathan" <jonathan.sade@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "ltrivell@redhat.com" <ltrivell@redhat.com>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
Thread-Topic: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0
 versions above 55
Thread-Index: AQHYxDje4sMW6yPJnUSGKx7TqVQeWK3/sxsAgEnMIwCAACQ5AIAAByGAgABbcwCAIJR1gIAAA0gA
Date:   Mon, 12 Dec 2022 10:18:47 +0000
Message-ID: <806520543550b16201bf54b9be29920446ee3e8c.camel@intel.com>
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
         <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
         <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
         <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
         <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
         <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
         <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com>
         <CACT4ouf8vDzhXkFAOh-LAbi1GKYp66YNMG_5VrkW0CqnxVBt0g@mail.gmail.com>
         <CACT4oufQsqHGp6bah2c4+jPn2wG1oZqY=UKa_TmPx=F6Lxng8Q@mail.gmail.com>
In-Reply-To: <CACT4oufQsqHGp6bah2c4+jPn2wG1oZqY=UKa_TmPx=F6Lxng8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CY5PR11MB6257:EE_
x-ms-office365-filtering-correlation-id: 912959e4-c376-49f8-0b37-08dadc2a41ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uxfz3yvvTNpmW30ZJS88PUs7G6R9AmTbsj/TftlZko/t3WPObLsbMfba8F9q2wfwCLgEfJWziULg+x1vWoDsxvvuXHIB+N/JvOCpBfvvgljNYNquPpG3FxRTJKLzl00GeCAc9LgeItN6jl8HXnd9hzcsZW4t+59B+F15OLF3xsslzaGdSu2Ic9IWNB20Ep8CNJiqE0bQP3jLFyn5fSKicVVFYXUNHQ08o3wXfgAbbI6VNAfqhljfwbbjHh851Td4YYpl5O+wdB8XyJVwms0YzaKkrN6ep3euV5edQYGh6MLBZLOoV6KQrVJCWdecIGINuoAs1qUfDAxD6tVNAuhlgl4zsAbCGMHRyH8tztpuX/JPAEMKmS19nTd9mb4U/ZQuwZ0dafbGoXQmMw4SgawWa8jcWvH4qJMysSiMdoHdIpIYq5zfegZidXL1q0RAZYbqxEriL8U38qdPIDOsTEEKbIABhRSPKgLMcHRp5tge5QE6xj6YRKP/0yKDAuGhe1CdIqX+2HsudiPk/XrKC8IdcxFKZmiCX2wcD9TT6urLLAS1EQo3v5JwVtOTkGd1BhIXIiiIi+KpSYawFsz8vaQqrnt0HslZfWBWplQl8dAIQiPMnqca9io7u78PpIrnV0eXEBtxpMiP5OR9bJmhfORecTWRv7n+S/iHP5w/88UW5f8srA2WBcpx57nzAY77imIcpurm+OX6tue0fYa0LVEIJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(64756008)(66946007)(76116006)(91956017)(110136005)(8676002)(66476007)(66556008)(4326008)(66446008)(82960400001)(316002)(5660300002)(4001150100001)(4744005)(8936002)(38100700002)(54906003)(2906002)(38070700005)(2616005)(122000001)(6486002)(36756003)(53546011)(41300700001)(26005)(186003)(86362001)(6506007)(6512007)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZkMm9aV25kUUdUeWtFc0dSUG5YWVBmaWkxSkFDWkIyYThTTDdZam9qcnBZ?=
 =?utf-8?B?WUUvcVZpVi9OQktINjRhSWJ1WW95alRYOWFrWU1HMWlWQWhYVXlZMGdsTDly?=
 =?utf-8?B?QzRIbGxmaXBabkJoZDMwdlBsR2hEMStHYWRENWRBM1AxTytBTWNjRlp6cDRk?=
 =?utf-8?B?QTgzclkrL0doQ0d3MURtWjBiSXBSN1U5bGliNFN2bGU3R3lhYzFlQkJIVVpj?=
 =?utf-8?B?QjBLTXNLaEJVQk1Fd2tQejdMaXo4cC92VVJFMzVMSXdlZ3crTlMvOHREcUxt?=
 =?utf-8?B?US8xb2s3dGtjRUtuT1gyUjlDNUYvT2hlZnFlbVVHRElvZ0Rna1BXeGFCUGsr?=
 =?utf-8?B?VHQ3Q3Z0c1BCMlRzckRGVW53bytUaWFGZDdGL213Vnh5N2x0TlBuTHFJMWpU?=
 =?utf-8?B?cm96ZXhkUXJ2emtFQ2N3c1N0YnhjWkNDTCtqOU8zOW5qRHluckFNUTBkcFVq?=
 =?utf-8?B?anRORlZiNjRpNy9SanJ4dUJsSGE5YVZMT1NUWHhGQzNSOVd3QWR1d1ZBTHpH?=
 =?utf-8?B?WGl5VkZoUllORktnRzRUZTFuSUJiYzZ6ZWhvbUtFQlNkQTg5ZkErWU9qdUxi?=
 =?utf-8?B?NW1VZVVnYmFJTk5PNFR3aFBUM01KWXZUTUVDbE9tVFJkMnE1d1NNR0lGRTdu?=
 =?utf-8?B?RGd0Z0tnZ2dxL1prY1h3ZUNYeENtY25FQWE4QWx3aVM2eTV3bndrekdKQ0pC?=
 =?utf-8?B?T0Z4VnNoMHY0RGxWNUFXZmgxbHlKUzRtaEZLS0hCRmFJWHM3QitwaVJ6T1hI?=
 =?utf-8?B?clZMa1pwazdvYWE4SkJYVzlFVmhMKzU2OEZBT2k4dURDVUVKV2NkZXRSV3FK?=
 =?utf-8?B?TmVCdGlwZTkyQ0NkS2pPZXZwRWYxeUIxZDNVOURDRmpiU2JXYk96c1VxN3Nq?=
 =?utf-8?B?Y0RwYVo1ZEtBR1hJc0l2L3hBeTJvQTdDY0JKVDZPZ1BPT3l6WmZKMDhuQStD?=
 =?utf-8?B?Z3cwZ1lvMVM2K1NKYnFkOGZUcmdmMjFab2VFZVFGektQazR6d3gzQXpwVmF0?=
 =?utf-8?B?SDEzWjFuYWFLWGM0VnRZcS9JQnpud2VqWEZtM2dpUTBtNmQwTTdJV1ZrclN4?=
 =?utf-8?B?WHhrdXFCTnl5eEtqY1hiTHIyc2o3MGRnTHh0c241RFhWcGpLWUhvblBPQm9L?=
 =?utf-8?B?RDh1bXZicGwrbTNDMU5JYktvMlQ3UmxnQmRYYWlBV1pGbFh5Q3VqaXMvdkIx?=
 =?utf-8?B?UGZSYWlvQkM4Z0NxWjIzeG9jMG51U3hQTjJWNWtlei9LNFp3T3RiSjhpWHlE?=
 =?utf-8?B?ZXQrTWVkSHZuVUFrOERZL25sTW5KbUIzZFZFTGErd05IbE5VQTZnZklzZlFI?=
 =?utf-8?B?eEQ3OWNSYnBSUk1Mc3ZhMTZvRHNHYkZabGFGbVd3U3lnS3BoenBPQlNIYUcz?=
 =?utf-8?B?Wko0VVhHejNPQWRhNm9jcTNNanJzL242V0poaEdick5jRUdlU2cyeWluVFQ3?=
 =?utf-8?B?NHVMQXJHeHREa1F5MmdoQlljRG5IZEdRaklaeDBBWWpQRk9qSlkyekVJWUtP?=
 =?utf-8?B?bE81NktNWVEwb3pzSlFVZ1MrelYzNUJINTRGQnphTHFtVDFUaGpueFE1bEo0?=
 =?utf-8?B?aEVTTzNLMDl0QndiajlyK2w3ZmtsMnlHKzcvUkl4NDBIZWFTcDBnY2V6YjBW?=
 =?utf-8?B?bnBYejBsMlM0UktJbTZmYUk1OEFQVjRCRXRhQ2JOQ05vUldhbnJDd0Z2ZUdV?=
 =?utf-8?B?allJOTNZN2gySXZiaVgzbDk4YmdPM01sRnJKeXpWK1BWNHRkR3EyYWN3MmFP?=
 =?utf-8?B?K1M1WTRMNnZBTXVqNmFaVStpZzhtL3dqa2ZLalpIV28vcmcyTmp3b2tCdmJ4?=
 =?utf-8?B?d09KNmJzejJMOTRPMUxTVHd4UjdmYzFOSkxWNkpPUURYTTZuV01ScUhpZUxK?=
 =?utf-8?B?c1JFdFdsYy8yTjlxQkpaU0ttSFl4ZXlJZXM5eWU1Z0t4VVhvc2JsWmNSUXpE?=
 =?utf-8?B?dC9Oa0kyYjFocThNT0o5R3g3YkNCbHZSekp2VUx6Uk9UOUYrSXBqUWE2cWJZ?=
 =?utf-8?B?dmhyclhBTUhoWExMYk13TFdXWkpFRFBoNDFTNUtHMHIwUzBpeE8wVVhYekJ4?=
 =?utf-8?B?T3JGdVFqRGEwd09KQ3d1Q1V0TGdqRUxTVlgvRVVzVGprbXdIa0htaFVVUkp5?=
 =?utf-8?B?VmdqcEdtY2oyVGYwWFJXTGtNeSt1QWpoY1BJNFpmdVJJM2FqM2RySVcvTHBv?=
 =?utf-8?Q?6/zZiEJLFdXhqD6WDTr1M1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69BDE3A12CAFBB4CA27371361C6DBCBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912959e4-c376-49f8-0b37-08dadc2a41ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 10:18:47.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJQo4J3s2B1VJxXeULC5Bbxf1DM3rFf29aGVqvVYAIWAaj8vF0fib44wfxljCrG01Ooi7SrdtAgUcjm3DRJh+O3yZS8eWI3EFJDsc5p7dLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTEyIGF0IDExOjA2ICswMTAwLCDDjcOxaWdvIEh1Z3VldCB3cm90ZToN
Cj4gT24gTW9uLCBOb3YgMjEsIDIwMjIgYXQgNTozNSBQTSDDjcOxaWdvIEh1Z3VldCA8aWh1Z3Vl
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIE5vdiAyMSwgMjAyMiBhdCAx
MjowOCBQTSDDjcOxaWdvIEh1Z3VldCA8aWh1Z3VldEByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+
ID4gdGhlIGZ3IDc0IHNlZW1zIHRvIGJlIGEgZGlmZmVyZW50IGlzc3VlIC0gY291bGQgeW91IHBv
c3QgbW9yZSBpbmZvIGFib3V0DQo+ID4gPiA+IHNlcGFyYXRlbHk/DQo+ID4gDQo+ID4gVGhpcyB3
YXMgbXkgZmF1bHQ6IEkgd2FzIGNoZWNraW5nIG1hbnkgZGlmZmVyZW50IHRoaW5ncywgYW5kIEkg
Y2hlY2tlZA0KPiA+IHRoaXMgd2l0aCBhbiBvdXRkYXRlZCBrZXJuZWwuIFdpdGggbGF0ZXN0IHdp
cmVsZXNzIHRyZWUgYW5kIGZ3LTc0IGl0DQo+ID4gd29ya3MgZmluZSwgYm90aCB3aXRoIHRoZSBw
YXRjaCBmcm9tIHRoaXMgdGhyZWFkIGFuZCB3aXRob3V0IGl0LiBTb3JyeQ0KPiA+IGZvciB0aGUg
bm9pc2UuDQo+ID4gDQo+ID4gU28gSSB3aWxsIHdhaXTCoCBmb3IgdGhpcyBwYXRjaCB0byBiZSBw
b3N0ZWQgc28gSSBjYW4gYmFja3BvcnQgaXQgdG8NCj4gPiBSSEVMLCBidXQgdXNpbmcgZnctNzQg
YWxzbyBmaXhlcyB0aGUgaXNzdWUsIGFzIHlvdSBzYWlkLg0KPiANCj4gSGkgSm9oYW5uZXMsIGZv
bGxvd2luZyB3aXRoIHRoaXM6IHdpbGwgYW55b25lIGZyb20gSW50ZWwgcG9zdCB0aGlzDQo+IHBh
dGNoPyBJIGNhbiBkbyBpdCBvbiB5b3VyIGJlaGFsZiwgYnV0IEkgdGhvdWdodCB5b3UnZCBwcmVm
ZXIgdG8gZG8gaXQNCj4geW91cnNlbGYuDQpIaSEgWWVzIHN1cmUsIEknbGwgc2VuZCB0aGlzIHBh
dGNoLg0KPiANCj4gPiANCj4gPiBUaGFua3MNCj4gPiANCj4gPiAtLQ0KPiA+IMONw7FpZ28gSHVn
dWV0DQo+IA0KPiANCj4gDQoNClJlZ2FyZHMsDQpHcmVnb3J5DQo=
