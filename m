Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB25B9C1E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIONkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 09:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIONkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 09:40:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16532610A
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 06:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+JK8ENPRTYjX///t+HCMt4QCY2KuiZL/lk8WPMHdBoaxJz2N3JtF+D/d62vtsHVE396Haf/sgvdOL1e4VHVACoVTleknz33HxPK/eS2LSnMHk/a9hWKPT+C65Xfy6loEEHXucIljzNEWx3wcDUXr7pjw8sSKXANVBaJnkLrcP0Dkbjb+7ZU++CZQWqDEbteAbcp/138ii8glw64gBwjCOR1vC1XqX2I42mwUWIgxlxvQFvcj43modtCyLxbWMrVkzYUJIKdRKbzweD2E4qpmKcD7CMrgb5lGSu5h/3y84wNgtMDzcZeWVaUYewC+TLUXiX1jEpXb+J9dFV/MeWzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBNjA2osAzByDJa06cpJ/onE9cqiNAx3G7K3T6Xgeqo=;
 b=cKvKkVHktP7cZE1DXngtgQwnVRz2d4mlfNq0Negtj+yMEGw2XfA2xMZdaITHgfLBqeMKQkHV8m1QZ1jogQxpg2Rr5lol7B4kkyTFFw8tx+nmfW9A5bmDarfFDEE7orENsbZVCAIZeP8kBexHwN5IddAgTEsxhjqKTp6sJZ1uN2ez5sCMUqXkRppxB68+HcYZOEJVCUiShdJ+cU55MH6DXyhfCmaanJvSgVuoXBPN2GeckP3Sel3iJH57i7iCTcP4MsJw+XYRFW8ulenBOTzOTnWK+MQwVQ22U28AO18cOUD2ZBQ2rqIJTo5jVxZxe6N+LFCVaLHQIz1UCRHADUqPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBNjA2osAzByDJa06cpJ/onE9cqiNAx3G7K3T6Xgeqo=;
 b=OwP9UVS0TlKbhtbeYMecI1qd7+FeTgFekDVG7HQzbeeMbyDSZ50KKKdFzKyCirBSz9xasexa60OilXqg1BoywwIhHM1rEp8ooci/+zI8r+STNefUloLnsP7SF8QmxDLUXRl2XV/ArDCgchxC+wU01QdrptIwnzSm6N9d4TI39kU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) by
 MN2PR11MB4728.namprd11.prod.outlook.com (2603:10b6:208:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 15 Sep
 2022 13:40:02 +0000
Received: from DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::b091:dffc:2522:afcb]) by DS7PR11MB6038.namprd11.prod.outlook.com
 ([fe80::b091:dffc:2522:afcb%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:40:01 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org,
        Lech Perczak <lech.perczak@camlingroup.com>
Cc:     =?utf-8?B?UGF3ZcWC?= Lenkow <pawel.lenkow@camlingroup.com>,
        Kalle Valo <kvalo@kernel.org>,
        Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH] wifi: wfx: fix memory corruption by limiting max_rates to 4
Date:   Thu, 15 Sep 2022 15:39:56 +0200
Message-ID: <8115258.T7Z3S40VBb@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220915131445.30600-1-lech.perczak@camlingroup.com>
References: <20220915131445.30600-1-lech.perczak@camlingroup.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MR1P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::14) To DS7PR11MB6038.namprd11.prod.outlook.com
 (2603:10b6:8:75::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6038:EE_|MN2PR11MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b067a80-ed4d-43f1-eecd-08da971fca01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLyPdM6iAuGvjx5d5FHgzwdfPfsWSP8LJb1dVcaA+m1Eki/lJh6KBb4Ni1LJjwBpRtq+LHCw0hOwY6zyfm95F8ZYcUbcWAL8fQXSy1HlU+P1QPD8yH/Eo6h1gnq+lYl8zrc9iSOKTTzpfTcbiZPVGMWgED1guGzJZCyWSRNir7+7rZoLqwzBDvKskTrliKIvL/5ftO9v2BrQTeUwijI5uUBV/u781CwVs4Pk9S1CYbzoi70Y+E5Zskf8ysmVui1PRPFtuI/nDPHdW+UbFgW4DHRuLAQWPdTWA/BX0x4hJMCVMpoHPbTqnnRHsckIYU5IvZOi9051dVNTsML+EovGd0BSkCN80zk/gwPx5Joe3/lrjjSBKFJ1YBFkGlutTPVaiQG/cJxuLv5leUbWnqmaT3qIVj1V6ORgZamNat/IWIarRGP2yck+7dJTpn5hRZoqJInZPrpt3o0om1qT/ExXDX5vN0+XNZXWZ7vhb8/fWEJZ8pMPzHSD+CLg5710dm/LySaxxr1vuAJfzN7pMKZQ+eYpGbPRGSh6IyOYhNqcCT27yPHjZPXZwDlD3SFYX7z/X9EWVYeX+z5FhcaGPe/p9gTDqafWWogih9uDRGqMFsmIasDKXYcG0weu3KS+7+qJpLHy4vWC8YG8ACk6EH3RGlk9Ve9ncG7D4DW1Ou0C420cNiOU0E+0dyLpVvfWK6Luxg2REuq76Sur68Z2jm19giiU1KUBg5cUH2uGZyqi0clPVdnK3LrdeOcZwnT5dirGbAcd6lC5EelM5E+wAi49Jot04YjlqpeeAaWxhBysqaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6038.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(6486002)(6506007)(66476007)(8676002)(2906002)(33716001)(6512007)(186003)(54906003)(86362001)(52116002)(36916002)(83380400001)(38100700002)(38350700002)(6666004)(8936002)(6916009)(66556008)(5660300002)(66574015)(316002)(66946007)(26005)(478600001)(9686003)(41300700001)(966005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlBWVTlqc25aQmVKK0FwcXJ0MmdWcFlRbTBlMWhHdHZRZjVWZFhDQU0wZHgx?=
 =?utf-8?B?clZyVThPczlxTWJlTEMyd09WdkZrUkgzdHoxcUsrZW5RYTdvL3BtdzBZeXhy?=
 =?utf-8?B?Zmdqd2tkREhmZHBaekRodGRKUEpsamxNWm8rMHRxbTZEWmhxVndVeFllZ0JN?=
 =?utf-8?B?V1dsWmx6Z0pSSS9uQ0N3SWRDT0tZZkcwTy80TGNnN0puQi9ER0NiWUpFUFAx?=
 =?utf-8?B?czRTOHBQblFoQTVNME5QUEYrN3o1TExwcXE3YXN1ZWJ4M3VQc2JsaENZS21C?=
 =?utf-8?B?WHZ6S3YrbFJ5M3dlNlN4N091RHRJeGpneWd0dmFMb0phU21IY0M0TW13WHoz?=
 =?utf-8?B?eTY4ODdqeDZBNjFXZ2xidHBPalhwYk9GMnFNTUNZSk9zSHhkbmUzWS9JN0Zv?=
 =?utf-8?B?dE1QVEdhc2ZTNUptajdoanJIdTlOYW93UE5QTXhLdHVHc05OaWVtdXRSTXF3?=
 =?utf-8?B?T1RxYkp5UGxDall6VFhIWVQ5dGRISW92Zk55RDJMNzlNbHcyYVgwc1pveVlO?=
 =?utf-8?B?NEZCVXN0enhCWDBsN0w3Y2dFbWtOSHpNamIzeVJqTXg2UW1nS2xLcGM5SnZ0?=
 =?utf-8?B?M1ovKzlNZldwRzZqTXdqNXlDK3ozWmlNdk5tMk9XQ3hPU1F1allmN0MwNzVB?=
 =?utf-8?B?M1M4dDNhbjdqUHk3SE9NcGk2b2czZVVLaGJZUTZkdURpUFcyVlpGMkExeCtr?=
 =?utf-8?B?dkJqOURuSm9abEE4clpjVFZpd1A1Qnlnd1UxMTB3Vk9qTXVsVVB5VW1Fb3A2?=
 =?utf-8?B?QUFoUHVGMFFra0lRSWZUaGlndy9IWlhEN3M1ajgva1pkQVBDUjdUK1Bhck5H?=
 =?utf-8?B?TFJucFdVamFxczlEU3YrUnZlVWxBWU5yUWRTUldPVkR2cEFNQXVPdXFocGtS?=
 =?utf-8?B?SVJ2dTVkKzR2WFpIak1uNy82a2h3VUxGVEFSNy90M0JZMXNLcXNOQWlCeTZv?=
 =?utf-8?B?b0lBanlnMUdlYy94c3ZoSWZ1YlhsdTd1MU9qQUJVUE1ZbFVJQld4M1hueWVh?=
 =?utf-8?B?RklTUmlIZE8wem1MQXlsdERLZWlGMHRrM015aEMzYlRLZ0pCSm81UllyQ0tF?=
 =?utf-8?B?dU9CU3dQTUpVTWZ1Rlk1NkVOZHlNNE1laWFUOFVLVkhFY3c2cDZhaEZHai9w?=
 =?utf-8?B?Z3BlUStQcmoybHZqOTVROTc4RlBkOVVOT3JHc0F6MzczRWExRFRxL3BROHFY?=
 =?utf-8?B?M0UybEM5SkdoYzhPSksrRGNqeW4zdFNIclRKMm5hZnJ5K0hXM29La0t2YW5Q?=
 =?utf-8?B?SHhDWVZEcXBsUUVtL1g2TnFucVZvc2RSK0phNXJ0RzdrM2cxYnpFeUViK2Yr?=
 =?utf-8?B?QkNwSjlPTUhVQzJObmVTdkNqNXdpRVFDdWdJdmEzVjl2R2Zsa2NPZDFSWXBp?=
 =?utf-8?B?UFlLT1dVT2JFeWR1bXhnM0F2djNlS1lGMUFQRXNwTk1WMXRaVmFxeWRZdktS?=
 =?utf-8?B?VnRSRU5qcVFvQ0JQSU9xbW5RK1FHZmhQT0trc09SMUZsb3ZEU0trY210ckw5?=
 =?utf-8?B?VElsRk9YZTRtWE9xV2NReERFYU5vRWF4TjZZYk1PdmVON3RQU0NVQTNhYzU3?=
 =?utf-8?B?Z3pBUDY3ZFJzYzhQaDcrdkRDK1pBWlVUNlV4dFNzN2ZNNlNOYnc2c0c5eDdw?=
 =?utf-8?B?b0N5djhiWWVRRG9rRG1rdlBYa3RGRzVOQnEvUlJOMENkR0E5WHFQVTVDeW5l?=
 =?utf-8?B?d2x1WnZaZG1kZlljS245Rm0vNFFTK24xd1Boaks0UVZnZzZDNENGNTlWdVJO?=
 =?utf-8?B?aEQ2T2hDTmpxUVJpRFVEZE1ZNS9QK0VRdnNBR3hHZkVkOUg1b2pzNUdIaUQy?=
 =?utf-8?B?SzVuMEJ3VU9URUsrKzBvS21NdVFqNGhyajBKUDZzUnlSd3J2aWxxS1NOaVFs?=
 =?utf-8?B?MjQ0UG9EUFAvTUFrV3BBSVNpaWpiY0UxZm90OVZRdUlSTzBUU3k5OG5TVGov?=
 =?utf-8?B?bXZWcUhjWWNrbC8yQVN0dWl3emZMa25ndlA2b1gzRFRBaUg5cnZ1TW44MDlp?=
 =?utf-8?B?ZER3cDU1UFZzVEZBVGErcDNjSndhbWdWRVc0aXM5TFJhUlQxSWlNUDlnaC83?=
 =?utf-8?B?dWQ1dnVGMEFnQUhTOGZJamNQK3kxZ3lRNGpKa0hLaStsNm1sSEsxd2piZFc5?=
 =?utf-8?Q?hmlPrTwYqG1Gw30mWqedjhhaK?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b067a80-ed4d-43f1-eecd-08da971fca01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6038.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 13:40:01.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbkH/Bx/uSnydY+1riSuxkekkCMXTECQVrjcH1jSlMRuUpv6okzqQ1gVr9f+qBIwCKavRisCvRoYXVvvPz8uQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[Add Peter in Cc:]

On Thursday 15 September 2022 15:14:45 CEST Lech Perczak wrote:
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
>  0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
>  kfree_rcu_work+0x320/0x36c
>  process_one_work+0x3ec/0x920
>  worker_thread+0x60/0x7a4
>  kthread+0x174/0x1b4
>  ret_from_fork+0x14/0x2c
>  0x0
>=20
> kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=3D32, cache=3Dkmalloc-64
>=20
> allocated by task 297 on cpu 0 at 631.039555s:
>  minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
>  rate_control_tx_status+0xb4/0x148 [mac80211]
>  ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
>  ieee80211_tx_status+0xe0/0x118 [mac80211]
>  ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
>  tasklet_action_common.constprop.0+0x11c/0x148
>  __do_softirq+0x1a4/0x61c
>  irq_exit+0xcc/0x104
>  call_with_stack+0x18/0x20
>  __irq_svc+0x80/0xb0
>  wq_worker_sleeping+0x10/0x100
>  wq_worker_sleeping+0x10/0x100
>  schedule+0x50/0xe0
>  schedule_timeout+0x2e0/0x474
>  wait_for_completion+0xdc/0x1ec
>  mmc_wait_for_req_done+0xc4/0xf8
>  mmc_io_rw_extended+0x3b4/0x4ec
>  sdio_io_rw_ext_helper+0x290/0x384
>  sdio_memcpy_toio+0x30/0x38
>  wfx_sdio_copy_to_io+0x88/0x108 [wfx]
>  wfx_data_write+0x88/0x1f0 [wfx]
>  bh_work+0x1c8/0xcc0 [wfx]
>  process_one_work+0x3ec/0x920
>  worker_thread+0x60/0x7a4
>  kthread+0x174/0x1b4
>  ret_from_fork+0x14/0x2c 0x0
>=20
> Limit hw->max_rates to not exceed IEEE80211_TX_RATE_TABLE_SIZE (4).
>=20
> To bring back previous value, the global table size limit needs to be
> increased beforehand in mac80211.h, or by limiting the iteration count
> in minstrel_ht_update_rates against IEEE80211_TX_RATE_TABLE_SIZE as
> well.
>=20
> Fixes: e16e7f0716a6 ("staging: wfx: instantiate mac80211 data")

I think the issue has been introduced by ee0e16ab756a ("mac80211:
minstrel_ht: fill all requested rates").


> Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd-8a=
ed-f0f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95KRgr=
ZTGAw0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4Odg=
k$
>=20
> Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  drivers/net/wireless/silabs/wfx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireles=
s/silabs/wfx/main.c
> index 84d82ddded56..7463fe4b5cae 100644
> --- a/drivers/net/wireless/silabs/wfx/main.c
> +++ b/drivers/net/wireless/silabs/wfx/main.c
> @@ -273,7 +273,7 @@ struct wfx_dev *wfx_init_common(struct device *dev, c=
onst struct wfx_platform_da
>         hw->vif_data_size =3D sizeof(struct wfx_vif);
>         hw->sta_data_size =3D sizeof(struct wfx_sta_priv);
>         hw->queues =3D 4;
> -       hw->max_rates =3D 8;
> +       hw->max_rates =3D 4;
>         hw->max_rate_tries =3D 8;
>         hw->extra_tx_headroom =3D sizeof(struct wfx_hif_msg) + sizeof(str=
uct wfx_hif_req_tx) +
>                                 4 /* alignment */ + 8 /* TKIP IV */;

Do you think the fix should rather be:

------8<----------8<--------
--- i/net/mac80211/rc80211_minstrel_ht.c
+++ w/net/mac80211/rc80211_minstrel_ht.c
@@ -1559,7 +1559,7 @@ minstrel_ht_update_rates(struct minstrel_priv *mp, st=
ruct minstrel_ht_sta *mi)
        minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_tp_rate[0]);

        /* Fill up remaining, keep one entry for max_probe_rate */
-       for (; i < (mp->hw->max_rates - 1); i++)
+       for (; i < min(mp->hw->max_rates, IEEE80211_TX_RATE_TABLE_SIZE) - 1=
; i++)
                minstrel_ht_set_rate(mp, mi, rates, i, mi->max_tp_rate[i]);

        if (i < mp->hw->max_rates)
------8<----------8<--------



--=20
J=C3=A9r=C3=B4me Pouiller


