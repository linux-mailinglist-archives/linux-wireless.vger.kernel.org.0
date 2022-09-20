Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6DB5BE00D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiITI3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiITI2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 04:28:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2092F08
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 01:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpZvfpHA9DfKMtQ1yET7bf3l1Z2jiPo8TPU+fQAYMYew+OrJzuhbDUyTIz1yK7yCNUqcbXyoDIEzspQqau1XXlnNHX27B0vd1tTqF1KT8sjjyuXvC5kpw5OAhg67AOkdi9/DzkxRZkHQ7ES71sf0ZespFu4TYPEQfORt2hqTjHSOyI/4gp2jYxT9pzBro1BMiPyXJFcr4LdgLqa88gW4HyG2e2dGioW4CnuxIQS/rUshj8ZlwkdQ7FoC48HC9s0IAcehL0r89v6Qq5mRfK4o9SZdn3XWYy7YnB8NxSB4zuDfuoCrGcUPNTOhGSbPCfruXanabEQUyg5+0l9TsUligg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wpD8JT7mqH9yHG8Dh2DnBDTzSYxwlmLXWCFYV/g8eA=;
 b=aRyDMOduHH6/cQJaqItTEkxZwfapTGQRYSATrbiwQmyPDssy/iiMx2v8eDcfpeWzfmdtJ++KagQ6Il+cng14aB+NnTQT3mydyJna1Prw6J4c7IIeobicUQyqC4fjPX6HY9t4b/wPn4FCS5rWrE5uo+Mv55+o+eSsqwyxc8qxZzV+X/AazisleHaPeGuFwTxDBj2rDPCF0kZnY/MgX8sJ95+hbfCtlR4Tmkz2L+JY6Cv49aE5/f+F/ljH/4/5bib4TDQHvjTs9jbFJ5ZUBytVDYausLtW7A+s8lBgFpA6utKk/AZGItLNYauPV9rPMsiHiQ/1EezijaSD+jZAPil+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wpD8JT7mqH9yHG8Dh2DnBDTzSYxwlmLXWCFYV/g8eA=;
 b=gXr8+SfP5TMwvSvNdLmnehuFsTxE14Xgww08GSxVZ3kzFcK6Oy6YzcywmmSpg46UamI8X+75JvziMN4yxyhVStSKGAAn/ZnNf3z+dW3BDnUTHS+iQefcg91m6VV9S8FOVEcc7fXauEqFlksLhz1UBBIiyc6sJCXYoPVuYeopZRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) by
 DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Tue, 20 Sep 2022 08:27:47 +0000
Received: from DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::c05f:185f:6c92:8bea]) by DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::c05f:185f:6c92:8bea%5]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 08:27:47 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Lech Perczak <lech.perczak@camlingroup.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Lenkow <pawel.lenkow@camlingroup.com>,
        Peter Seiderer <ps.report@gmx.net>,
        Kalle Valo <kvalo@kernel.org>,
        Krzysztof =?utf-8?B?RHJvYmnFhHNraQ==?= 
        <krzysztof.drobinski@camlingroup.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH] mac80211: fix memory corruption in minstrel_ht_update_rates()
Date:   Tue, 20 Sep 2022 10:27:39 +0200
Message-ID: <8278507.Oi1q99DfSd@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220919150135.90785-1-lech.perczak@camlingroup.com>
References: <20220919150135.90785-1-lech.perczak@camlingroup.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MR1P264CA0007.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::12) To DS7PR11MB6038.namprd11.prod.outlook.com
 (2603:10b6:8:75::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6038:EE_|DM4PR11MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b70711-068a-4eda-13f6-08da9ae1ff3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gazAA9ZgR4AK3zrDmvhXelxuMmplwCH+YLP0QSYytx+Xbma6DOzm3orXRCfuYsvTB9yEqZ6vivrB8/RgGCYxp7sRihDz/Nq79ziYGXn79rg5M9nPBgDEuXGruN50jr+rUWLCuX0HuhHl5KNnc64+oKZ7qyr9fZu2Ou6qdOFpGxo+NjplCKf2PdGrOLeh2u3j2jFTRDoXJ2hN5lkd5W4VWVuWWTY7k2INT7GKHowDkkC/a3BA1TMUfTIjdUfhScpQZRP8VFWz+vgQ1Em7DPL7qgTZM9Oeq9+MdyfBofjJpgo8WHesu4VHdPPEO0YtXx/F4Tj++wiCjHtpOS9kZKj8KzFkFhj8RxyYMFu4W+KfbftYl7jAqyUCS4WiIUIvzewuLlrYldAjF2cxEpgGeHw9LVY0WNBMSO3Wqi1yMRP6d44w02LP3NrTEUSvTdaUzklgKQYLenVYaqj9LoBv0F44ySTNNUR6cqbXFD+bIhsB1Jap9opEuwRSDhh5XW3UMmkZsqYpmiezRLVIXnilL9BNX1DQcl2pFp7vLOts8N74n6X5xXJtvCpKPGPwKObryHEIHKlbSx8ijhgc5fBLLQf72D2CD8tc4HZkg3k/0RCoysKjcORfiMnFOJ8Nt9E4ujlR9UNAb6BVxjA7v2B1arv9qv1IUGWKZfN50wgUnvywh1ea1f0xZa8JzDQbmJOF3NrnTBhKUFVajX5iEt1oKSeeiov9mvw01wY89oRWTmbYspFwj6EzixSgPWjsB1xC9FSqm3F/PD1z6dxVbTPFrHGZ66pkxQl8fX9BZLJtDCxOXVA8ZyvMiYPK/hMiIbsCv6I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6038.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(186003)(8676002)(66946007)(38100700002)(66476007)(66556008)(38350700002)(83380400001)(4326008)(86362001)(5660300002)(2906002)(8936002)(478600001)(966005)(6666004)(6486002)(41300700001)(33716001)(54906003)(110136005)(316002)(52116002)(36916002)(66574015)(6512007)(26005)(9686003)(6506007)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dndmhWL2EvRlBPc2FRVHR6eGNvbEl5MXB0d2k3M3loaTQzQ0pBTDhhYVVB?=
 =?utf-8?B?TWZKOWNMOEtxVjVDZTJDS1J0L1FkQmFOSllsUHo3akVNd1R0ZHhxb3NvUG9N?=
 =?utf-8?B?anY0czBtN3FRY3djZ1p3a3Q4THZXdGlBMzhpVE8ySkNUVVhLR1kyVGhvRkZ3?=
 =?utf-8?B?UVJlZnFZVjN3TVRNVzRpaGpsUWxVenhmOEJQUGRIaFNCZlZMMWZsM2hoL2VX?=
 =?utf-8?B?eTJBd1lBS2h2dENUY2Y0cGhlcmxGS1FnSTdDL0M2RFFjVjI3SGN1bDc4RHdR?=
 =?utf-8?B?SWRQcXdWOS9KVS9RMWl0L0h5dmM4ZEUvOEttUmFSTG14eHhZcDRrMHZCbE9r?=
 =?utf-8?B?UDVRQnJtRUtMY3pPdDVndERDSWNQNWt5TW9CSFkxdlZTbWVRcmQ1TllMV1JU?=
 =?utf-8?B?ckdPRVYvOVQ5bVIzMU9ZV3cwaGhUWEo5VUZMRi9sSU9mT3pqdkh5cXVVTUJl?=
 =?utf-8?B?Q2QwTXExS0dwY2tUUEpNWnJKOUhtOExGclVFVUhiWHpIc1F5WEt4N2JhUTkv?=
 =?utf-8?B?WTcwVkM5aytuUStVSDJ6UG4vNlh4aWVTcnNEcHhqMFhMbFVXWkNySEpsU0hP?=
 =?utf-8?B?NFNmTW91NkdFdVpOOHJIc3VQc0JDRlRtM2VhUm5BWGpjeVZUbFdKWUcyd2Qy?=
 =?utf-8?B?L1h6TFFpbUZ2Y3pwQlJxcC9oNk9WcEsrMHV4Tm94Q0NqL29ENzFzYkNVQlZn?=
 =?utf-8?B?QlRrNkNScjNCa2JIWTluK3RWSWxJakxjVStpV1l6OFhyTUJrdS9PMmhaVENx?=
 =?utf-8?B?Qzd1YWIwbGw3Rmd5M2gzdmllVXU3NnZDWStuU1JCbzc5WDA4ZjRYZ0JlQTRZ?=
 =?utf-8?B?R1RjUGl3WmpESmxleDRadVBOd2QzV3l4Nm1QSHFOR0U4NmNlN1B1WEtJRzVG?=
 =?utf-8?B?TjcxSjlWYU40eHY3Wk03Ym9tc01tVlM0aGh5RFdpVGVsN0ZpdDlQaG9oU0wr?=
 =?utf-8?B?VUpVQnh2Si9mU3Nia1VJbkZTSnRab1ZOZnFReE9JcWt3aXJVbis0N3o3WUhX?=
 =?utf-8?B?MDM5b1p4YkVkdmxaY244a2NqNVlla0VGaGZOdm92dk9GRUdqeFpGV21wdzBJ?=
 =?utf-8?B?U002UmlJL3FYeEhJTkpOUDFVSTFXQTYwMllWYTMrcVpRWm12aG1mNGdONWpx?=
 =?utf-8?B?ZXRrWmxBeWhCY21zNmo1SDczRi9QWmdYWkFxNnk0ck1FT0RTaVYxQ2xvaHpR?=
 =?utf-8?B?cFN1TmJlTlk3Yjkwd2pMWC9Hb2Z6ck1TVllCSlphaTdLeHdoV2F4QVNHMDV2?=
 =?utf-8?B?T2lpSU80MXBaTlBNdU81Y2MwSVl2NGhCN25xR1RkVnJUTXFXSVV5djAwU0Mr?=
 =?utf-8?B?d2tJNXNwU0ZXRzFGM0ZIckE5dURKTGYyVVJIeXdVOGhCdURKMW5KN2t0c3Bo?=
 =?utf-8?B?aU5hcTQ0M3hiOVZ3YVU2RTNna1c3UWFFTWQ1c3ZwQzkzREVqMHo5MUFJa20v?=
 =?utf-8?B?RldqSVh6NnVLYnhBWEVoM2hDYkJQZ2ljdm8rbXpyV0R2RElWK0JUTGJMQXpE?=
 =?utf-8?B?bFBmVWxLWXFocU5HNDNCYXB3a0pUeEdrMjJRZ2J3bWhoYzZqNExZcGZTTUcr?=
 =?utf-8?B?TURvaEt4RFd3VTlEUmJEVGdFVTNaOXFsUFpxTXUrWWdOWisyV3I2R21wTStn?=
 =?utf-8?B?SC91d2dvZ2VwVWc5cm5YeENKcmpudmJpK3NKUmpTR2treU9MSzJ6MnVDSlJl?=
 =?utf-8?B?WndadVB1VTRLVHA0cXliSlM5eUhYaGRGbEorTFhFcndPQUFwdEVuSFRuWDgz?=
 =?utf-8?B?MWFwWlNBU05hcG5wcmMrSkhQeUpWa2tabTlJaEtsekZKR1Q2eWtMVGY4Qldm?=
 =?utf-8?B?UWRjcGxKWVE0QnV2SnFxRHJoMW1qNHJTR3JSd1c4aVVEelpycUp4YUFiUGpm?=
 =?utf-8?B?Vm5vOU44Q3FwTGtTWVVNQnN1Q0cxR3RTOHNaOEZpTVRwWXIwRGVueHNSQ0JQ?=
 =?utf-8?B?NmdGaHRCVTVxNld4V21qSGVxNVZBVzNWdnFpSC9GblJ1UjBMUTh5d3RxYkVS?=
 =?utf-8?B?QTl4bUFLN0VyYll2ZTZneDBSdDR6YUtqOTJ1dVY4TXNnMGhkamlSY3FXK3ZZ?=
 =?utf-8?B?b2t1bzgwV0hVd0dOMmZQandhTEFiK0t0N29hamJVYWtsMUtJNkNoNmxiZ0pm?=
 =?utf-8?Q?H1RyJxurOGmvlEoUk5qe3CSw8?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b70711-068a-4eda-13f6-08da9ae1ff3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6038.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 08:27:46.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOkSg/lEAHDtgHJtTOH/8lGyRVxfHDobl5uH66/WmTibgAPHMiezE3789jyuT7/RvNG71jWiypspJ9cr1qWIyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday 19 September 2022 17:01:35 CEST Lech Perczak wrote:
>
> From: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
>=20
> During our testing of WFM200 module over SDIO on i.MX6Q-based platform,
> we discovered a memory corruption on the system, tracing back to the wfx
> driver. Using kfence, it was possible to trace it back to the root
> cause, which is hw->max_rates set to 8 in wfx_init_common,
> while the maximum defined by IEEE80211_TX_TABLE_SIZE is 4.
>=20
> This causes array out-of-bounds writes during updates of the rate table,
> as seen below:
>=20
> BUG: KFENCE: memory corruption in kfree_rcu_work+0x320/0x36c
>=20
> Corrupted memory at 0xe0a4ffe0 [ 0x03 0x03 0x03 0x03 0x01 0x00 0x00
> 0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
> kfree_rcu_work+0x320/0x36c
> process_one_work+0x3ec/0x920
> worker_thread+0x60/0x7a4
> kthread+0x174/0x1b4
> ret_from_fork+0x14/0x2c
> 0x0
>=20
> kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=3D32, cache=3Dkmalloc-64
>=20
> allocated by task 297 on cpu 0 at 631.039555s:
> minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
> rate_control_tx_status+0xb4/0x148 [mac80211]
> ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
> ieee80211_tx_status+0xe0/0x118 [mac80211]
> ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
> tasklet_action_common.constprop.0+0x11c/0x148
> __do_softirq+0x1a4/0x61c
> irq_exit+0xcc/0x104
> call_with_stack+0x18/0x20
> __irq_svc+0x80/0xb0
> wq_worker_sleeping+0x10/0x100
> wq_worker_sleeping+0x10/0x100
> schedule+0x50/0xe0
> schedule_timeout+0x2e0/0x474
> wait_for_completion+0xdc/0x1ec
> mmc_wait_for_req_done+0xc4/0xf8
> mmc_io_rw_extended+0x3b4/0x4ec
> sdio_io_rw_ext_helper+0x290/0x384
> sdio_memcpy_toio+0x30/0x38
> wfx_sdio_copy_to_io+0x88/0x108 [wfx]
> wfx_data_write+0x88/0x1f0 [wfx]
> bh_work+0x1c8/0xcc0 [wfx]
> process_one_work+0x3ec/0x920
> worker_thread+0x60/0x7a4
> kthread+0x174/0x1b4
> ret_from_fork+0x14/0x2c 0x0
>=20
> After discussion on the wireless mailing list it was clarified
> that the issue has been introduced by:
> commit ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
> and fix shall be in minstrel_ht_update_rates in rc80211_minstrel_ht.c.
>=20
> Fixes: ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
> Link: https://lore.kernel.org/all/12e5adcd-8aed-f0f7-70cc-4fb7b656b829@ca=
mlingroup.com
> Link: https://lore.kernel.org/linux-wireless/20220915131445.30600-1-lech.=
perczak@camlingroup.com
> Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Peter Seiderer <ps.report@gmx.net>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Drobi=C5=84ski <krzysztof.drobinski@camlingroup.com>,
> Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>

Reviewed-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

[...]

--=20
J=C3=A9r=C3=B4me Pouiller


