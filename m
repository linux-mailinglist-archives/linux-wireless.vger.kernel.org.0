Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320086BE469
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 09:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCQIzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 04:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjCQIzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 04:55:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A3028D17
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 01:54:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7mi7D017460;
        Fri, 17 Mar 2023 08:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=X8UF2n/Nc6cQc+DxTfhp8n+Fz7NSDMvT+9lrT48/ek8=;
 b=vCGJCk7YTKYh8OtgNkH9fMbWPol/5bKEHmCoruFgb2LyIczgFowfCwmCLDP2+SByVdNv
 K2WThL9lODCpAUd1xshyFk3ZbHg11nYUu/VZkecpuHHEoJ7Xe+HcMSNm57sewlJdSj4Y
 2hdqVeXLWJj6DYovgAtwKdCwVixUmLnAd2p8RLTNhtEmRefgtc3+QfllMpnxV7xdWrkl
 qtHN/6LW9Q84A4Er8zOBZtG7f7+gn9Fb6uIOKaIZX+q7rZaj5DvyDZowSgMTEyOBNIoI
 /qtie9J1OkKfWGEN4aHWnYOXKcM6b22UbIqh+irbgxmuJgVFP7obwDQLfvWOHUBUoYcT 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2akchv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 08:54:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H6V3ae004927;
        Fri, 17 Mar 2023 08:54:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq460er5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 08:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOnI4ddhmfkIxa8HsICPoFqNU5PrCiYXFppsTDQ2GgRGFuPxhOvJow5ltN4CgsZI6Zw988u4XehfzL/GoHjHYsidK8g/WZS7vNUvyvWwWdUTn1wIgkyw6suscGWMmbn6sHA74cmkRMtCLKcwjl+nft2Bhf+83ss4mzyuCunmcgFw5voYnH+pm+esbFhloDfI3Ns/jU/o17MIrjqeh1SkC/8/LCHgdIhc9f9hOrQlrO/HDyPEZfJWUJqKaqQ1QwbhLErHh9zlm3m3NlB/TI7epOKL1TIFemwkx2hNF8aaBPopq/vl7kSXKJ0iFdVhCuB+KfXVRqjGPsBoYLtAQstPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8UF2n/Nc6cQc+DxTfhp8n+Fz7NSDMvT+9lrT48/ek8=;
 b=kgcfJR8FVEqp+/YxYT6BRhtU1H5vof8qne8yEEE4L/HzIxUqkbD8PZY2V8qOAW4n9czGQSKzRoqTuSiygxl7i1Jiz51d6pZeqcTuz8hHOIaPDZMuQSzThbMgOr3SrgSmoRhie3k21Ebtw70nzodHH/XWpSOdU4SCxYuQWe5cd82GrsAgqBa8ZHziKsklinDmqe+wcxoNDX8mQu0wycn1lg8O7QM5Wa1tWXNHY+w6W9Bi4mtIEef/GsABT+D1SZ7e/t4Ae7YQhjwib4ySXelTYsD0Pzsr9rZG+Qr1qCC0pE1TZzBaDxQ3Zzhhfhg4znF3ZllROVk+9/jD9+xU9V/0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8UF2n/Nc6cQc+DxTfhp8n+Fz7NSDMvT+9lrT48/ek8=;
 b=Kn6BnpCqL9whD6k0QZ1/J9rrpR/st04xDQH8UEGETkmI0Ivs2Ot0L03MPAWt5GXJ6UVo7XkIqZqBODM8i1c74kzrvpkcdji5SyNVH8R3UCqqTA07DKkMQc4eM3lAF3p4sD/u3RhqC7AHw9LwlABY/qfcmKQlT7ncgRRnlVdscUc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 08:54:02 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43%5]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 08:54:02 +0000
Message-ID: <9d11ed29-1114-055d-5b26-0899a5fc0d7f@oracle.com>
Date:   Fri, 17 Mar 2023 09:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Vegard Nossum <vegard.nossum@oracle.com>
Subject: iwlwifi frequent drops between v6.2-rc3 and v6.3-rc1
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Thomas Mann <rauchwolke@gmx.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>, regressions@leemhuis.info,
        regressions@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::13) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0688e89e-8a48-4f04-04fe-08db26c5275f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeVIkCHTDBjUwfd2SZbuXdprDndSohHtCRv+POZ1Yap5fzNlze9f6mOydnD4sHIVSCmGPanwnHgtfNQctNdJIHfO40reReeVRe9nV7ZmxKYFMqyrrZUkKmzSqdTQwRYxGBhi5OFmUuj7KL8PXvziMPlDNu3NKmO4zb0ulVQtCCxsouWptgy8nkW9LyTXE9PoVugqb3/tS8sgbHAp36v1wFS3UoLCqp0q2eV3uJzTahMIyZf68OTyMYi8ePYUb/NlhSdo8izclJI1RUPBFEu60kDdb+Qe97u7QkKFVmztWTYYHq0fgWiRt+9IJyaFUa+XyEaZshr2jSJIuEu3kZ7e5Q6kaTwg0hd5CDHnNOtEfmvuSHnNPzwsy3XF4owxzFh+dkPsDiIe/rC01IUfPvWeXN+GpWNz5sgPD5f0y7TD+ybMXVvAd1dFR1FTpfWe7ALQ1c3DqBnQucqMPB+qXS9rQHvNNLBo/DnGdrTiuhoSjEZMYqbBpAwor/IoKFD4Ubk+clTSaZKpvgGXTb4hUNvgRn+x6OwMfh1NRf7V1f/UpMmTrh49UuDmRpSekYw2m/HEEXTgNBFSOmXa2HUy4md7FV7ge+pdYcbzwB4PF15zkC2l/fJwPSfvBCSMVMlOxhT8qYuhKlPV0hubLaZpDGBnIh8Sy8Um46rG8UCWk9wNuSQ09ni/UciHVIBmeyvRnUya5MPhikhcNlfW7sIPJpxMRul2v9Vv+2L0aPtq/TGoo5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(31686004)(2616005)(5660300002)(41300700001)(26005)(4326008)(8936002)(186003)(6506007)(6512007)(31696002)(36756003)(86362001)(83380400001)(44832011)(2906002)(8676002)(6666004)(66946007)(478600001)(110136005)(38100700002)(966005)(316002)(66556008)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWFOR0tqNDJuK3lpeEdMSnFubzMrM0FwdXhFK3JWTzZ6ekdxSnRCN2E4Z21N?=
 =?utf-8?B?UnZsSjhoV1dzamF1Rkt3UjZaamttcHM4M3lObENWb0NmUm4yaWo5UU5PanZs?=
 =?utf-8?B?dE5wWUUvMk5BeW8vazZ6VWZOOFU0bXhwRFJhZ3BtNFRVMnQvS3ByazlSaGk4?=
 =?utf-8?B?cEltWTMzdG5mMHZodkVTQVJrQ2ttbW9NRVRCMnlwVXJheHJtdVg1aE9RRTk5?=
 =?utf-8?B?aVBtNUllNmh5eklSVWI3UisyYVBqK0tVbmI2TDYwWTR5Q085cXk0RzJrTUFM?=
 =?utf-8?B?N29wZ3dVWVg3c3pnNW91WUEvMGFHQTBwbXhaZ2lseGNSdFR6bnk3Tko1M1hN?=
 =?utf-8?B?eXZuZUJ6dW9xcTduNlF5RDNIMVE1SnJEMjg0ekJ6SzUvYkgxTmxLa0M5RHFv?=
 =?utf-8?B?OEtCUDBXMGgrblpIK0dFZE1HaDRyT3Y1YlMyQkZaU05JQzBzdzhHd2h1NEhx?=
 =?utf-8?B?Y2dJU3dPT2xKRHpVR0xLTThHNHpDejhMZTBRRWNCWXNVZGh5Mm1sQXN4NDVL?=
 =?utf-8?B?WkgzWFV6clREY0U3WlVUTjYrcjR3N1ZqN05Sa1ZndHlTU2FxZEl3SUpJekFk?=
 =?utf-8?B?NDI2VlRiWWpmMTFXNTF4MGdjZkpDWU54NTlRZlM1eDgyV3N5UXBoaWh4bW4r?=
 =?utf-8?B?VUtKVnBqZUZnOGExN051Vi9sRExZdjUvLzlqRk8vRGlDVXcrM2NkOFVsOU5p?=
 =?utf-8?B?S1M2cVdaejJYRmV2R2ZhZ2g0eFY0dmpFODhXbGF5L3MxMzlNNThQZGVPUXJJ?=
 =?utf-8?B?em5VYVl5bzdXZVQweS81THl2elNSNERFK3BPdWlQNU9iYTBqNXU3RUlKaitB?=
 =?utf-8?B?MkhRK2tVNGpIRGkvNW5lMEZvc1FmMmhuc0ZoZ3hpckZFQTZqMko4N0RjbnJ1?=
 =?utf-8?B?alBUVFBHYWNZcWtQalkrSmpLRVZwMlNnbjlJbDZVcHpkeDBYb3lpbmlzaEFW?=
 =?utf-8?B?Qmhpdld1OC8zdXpIQVpBNnRMQ1kzc1NrZ2FGVmdRUUR3aVU3RFgrRmg3V0ND?=
 =?utf-8?B?cnRJb2J1NkFYdWg0NlA1a0JBN0Fjd2ZTVFBIc0Y3ekNDT0ZlVzg0bzNvQTZh?=
 =?utf-8?B?cFNYZjRGbnZQUTJia0FlNzRzUUkzdjNTUWtHdXUxNnVGa1MvSVd6S3l2d2U2?=
 =?utf-8?B?VnEwakdxN0loVmpIOUlKNjBYUlFIRml5RHo4YnFyK3R2QjU0bHYyNjFNQ01v?=
 =?utf-8?B?VmtlNjVJZm1zbWlMcUsxTm50aGhYRWFZMWxXK1dENzNRYWtuT1VSTUxoenlO?=
 =?utf-8?B?SkNLOHdVQ0ZacG84V0FJUXdvbHRaQklsK1A1dmJZQW1udUR1KzFyaFdYSWVQ?=
 =?utf-8?B?NXZKNDNzdWFPMEZQSllCQWhVUXBmbDNLQnZKeC9acGQzSU9RU3U3bFpLMHRI?=
 =?utf-8?B?ZENtVlZpdE1sRVE0K2JTbTJscTMvTU5tZ3loQmZrb1VVaTBJK0pISG9laGY1?=
 =?utf-8?B?QmtMb0dlUlBadHBQSytYWVpTc2M3Q3hBOGl5b1djT1FkN21mOTdDYUxsSlQ0?=
 =?utf-8?B?RFFOYlJZbmpkbytmWkF1SDJQc25QY0N6RDVEUk4wdDFEdHp4K1NIZXdyVmhs?=
 =?utf-8?B?K3ZQbE55d0pWNHJZY2syWnRpalFZdUVyRk5ESmI3QU1KVm40cXlaRVdqL0to?=
 =?utf-8?B?ZGtiWTVVQjNBaERVaHFzWHg0QnFMZ2R6cmhTaUZpV1lOS2FxU2hXaWhSSnN1?=
 =?utf-8?B?K2tkWXp0b21rODFiY0tmeVJVQWN2WnZjWmlqMzcwYnNleUZCa1U0bHNaOFF2?=
 =?utf-8?B?YUNUNFdFTm4xQjdMTFB4clYrNERxaFl5OGQ0dlJ0QlZKMENKNE1aQytTQjlD?=
 =?utf-8?B?dlZMblVXalhKM1h0ZGpuem8wQUxXOW1RRDBlQi8yMkhncUtIc2V4QTV3d2RK?=
 =?utf-8?B?cGoxREFyc1ozM0tOeDNmY0JYSHlHMUhHSDJZL25XR00zTVdoTWpHY3oyenR2?=
 =?utf-8?B?dTdTbEtabnlSMS8vWWk1RERZR3NVaWhrZTRzY29FaDVKaFhMVWlURmhhR1pv?=
 =?utf-8?B?aWFFclhRazBUb1R5NmJwd2p2L0Y0aFRGUVBVa1lTQnREdEpqUjY4Yi9NeUJZ?=
 =?utf-8?B?Uy9QbndHNnJrd25PM0F2Ty9HRzc4UlY4ZGV6Ym5oM0p6UkYrM1dHQ1VPcXdO?=
 =?utf-8?B?a1hNN3Z3UGdCOGNScGdWZEN6S1pIZEhmNTNJR3JrSnozdmlTc014RkxOUGEw?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bPiSRCng/xXFGqNK4Gdjc3ARaskWAUZSxtrt2Wk3eJ6TxLRtrgPS4HmawBTWDBF+XUszY7g7A6FZfB+ATo8IO5MIwYKcdaV1O7jvWpt8c1hcIyBHDXo32e5Pf4NYu0AWKHniZSjNzkBPMJO0/vyDOaL+f5g1FHG3VbPD1RblfSrldBiNpYCn5L9ryEDe5IC2US2DpLF3gXkiEcXnvWYod3ESTX06kg4Ji06tAB2g3JeD0JcsolEjlAAA3jMA7A831azZIxUZ7qCZZSXO3Vh+/U95pL45RDlQytdanGMrgcQJmBBk6rSm+1xDC2DhpfpDdNJsccU/7pNdR0GsyF21o4osDWW7On5MZYWvyF4jraeVmCpT1s7lKn07ig3s7ipgTbIl6/cPAHAn0dSxwneHUnqMTScYZZ9HvwnXb5PwOiAGUyT9TyPvgZ/ouDb7ibJ7Oi+HBYlUvcVJUmsI38kNDFyy2d0rPusvF53awWXBi3NPePdI+1YLjMH+3rr1n9QI2i2nMfzZVh/Bp4D5N94+lEALfMuA2L0KQaVKIBw2byJ/m1diACH1PW+uBc0sZNHGdT5kNK9h8zTiHwt0j6REiBmeiuCgpPRQ62KIdxs6LNfQXmPE+cTpvroaT1jCdOjymEM9vPK4pJGwKXHGYcfwmmaxdjFN5uclktzPxFZRwYgEahyLTWDHI/seTws1fZzsJXWtHtl8n93kxCS8dDq+Q9r0VABrSGADr3Hgzt8/Dr4ao1nduY/61BzzslWdNAavRtifz62p87OImDSWJ4hFIsH+TU+024lvAO9MWUDhH68w1dTxnPshqFuixWDmB65Qmet6eq8JeYiH4dt2qGLaMI63gChpdbphKnwrD1YkWCSGYDJUFepV2rcfXNrsBfe1nLQx/8RnKe+EEV6w2PY8JyfcD3aye+oYXcf4duFJFnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0688e89e-8a48-4f04-04fe-08db26c5275f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 08:54:01.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7pe2+gnI8QSeBtS8n3IoOFaQg5ksASiwHruKi9f6IjAXG8mskCYoiKF7Lccp8m2ApB15lQuo5mAlLcJ9x4NIpuGFZktUmDeUNlk2zh7+nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=576 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170060
X-Proofpoint-GUID: J6yzGKVgIUSagQDXN4tEmnchJneEkg6i
X-Proofpoint-ORIG-GUID: J6yzGKVgIUSagQDXN4tEmnchJneEkg6i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi,

Somewhere between e8f60cd7db24 (v6.2-rc3) and 2eb29d59ddf0 (v6.3-rc1) my
wifi started dropping a lot. I'm using iwlwifi and I've checked the old
logs that the firmware hasn't changed:

Feb 25 16:22:33 kernel: iwlwifi 0000:04:00.0: loaded firmware version 
36.e91976c0.0 8000C-36.ucode op_mode iwlmvm

My logs look like this:

09:01:50 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
09:01:50 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED 
bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
09:01:50 NetworkManager[8368]: <warn>  [1679040110.6548] 
sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
09:01:50 NetworkManager[8368]: <info>  [1679040110.6656] device 
(wlp4s0): supplicant interface state: completed -> disconnected
09:01:50 NetworkManager[8368]: <info>  [1679040110.7609] device 
(wlp4s0): supplicant interface state: disconnected -> scanning
09:01:53 wpa_supplicant[1279]: wlp4s0: SME: Trying to authenticate with 
[REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
09:01:53 kernel: wlp4s0: authenticate with [REDACTED]:0b:25
09:01:53 kernel: wlp4s0: send auth to [REDACTED]:0b:25 (try 1/3)
09:01:53 kernel: wlp4s0: authenticated
09:01:53 wpa_supplicant[1279]: wlp4s0: Trying to associate with 
[REDACTED]:0b:25 (SSID='[REDACTED]' freq=5500 MHz)
09:01:53 kernel: wlp4s0: associate with [REDACTED]:0b:25 (try 1/3)
09:01:53 kernel: wlp4s0: RX AssocResp from [REDACTED]:0b:25 
(capab=0x1511 status=0 aid=36)
09:01:53 NetworkManager[8368]: <info>  [1679040113.4553] device 
(wlp4s0): supplicant interface state: scanning -> authenticating
09:01:53 kernel: wlp4s0: associated
09:01:53 wpa_supplicant[1279]: wlp4s0: Associated with [REDACTED]:0b:25
09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-SUBNET-STATUS-UPDATE 
status=0
09:01:53 NetworkManager[8368]: <info>  [1679040113.4645] device 
(wlp4s0): supplicant interface state: authenticating -> associating
09:01:53 NetworkManager[8368]: <info>  [1679040113.4829] device 
(wlp4s0): supplicant interface state: associating -> associated
09:01:53 NetworkManager[8368]: <info>  [1679040113.5175] device 
(wlp4s0): supplicant interface state: associated -> 4-way handshake
09:01:53 kernel: wlp4s0: Connection to AP [REDACTED]:0b:25 lost
09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-DISCONNECTED 
bssid=[REDACTED]:0b:25 reason=4 locally_generated=1
09:01:53 wpa_supplicant[1279]: wlp4s0: WPA: 4-Way Handshake failed - 
pre-shared key may be incorrect
09:01:53 wpa_supplicant[1279]: wlp4s0: CTRL-EVENT-SSID-TEMP-DISABLED 
id=0 ssid="[REDACTED]" auth_failures=1 duration=10 reason=WRONG_KEY
09:01:53 NetworkManager[8368]: <warn>  [1679040113.5685] 
sup-iface[0x5628f2495990,wlp4s0]: connection disconnected (reason -4)
09:01:53 NetworkManager[8368]: <info>  [1679040113.5737] device 
(wlp4s0): supplicant interface state: 4-way handshake -> disconnected
09:01:53 NetworkManager[8368]: <info>  [1679040113.6759] device 
(wlp4s0): supplicant interface state: disconnected -> scanning

I did see that somebody else reported a similar regression, but I don't
know if it could be the same problem or not (I see the driver is
different, but the fix looks generic):

https://linux-regtracking.leemhuis.info/regzbot/regression/217119/

The buggy commit that was identified there does seem to be within the
range of potential culprits:

$ git log --oneline e8f60cd7db24..2eb29d59ddf0 | grep resumption
4444bc2116ae wifi: mac80211: Proper mark iTXQs for resumption

If people think it's the same, I could try the proposed fix -- otherwise
let me know what else I can do to help track this down.

I don't think bisecting this is feasible for me since there are hours
between the drops. But it's really noticeable over the stretch of
multiple days that something has changed -- looking at the logs, the
disconnect rate has basically tripled.

Thanks,


Vegard
