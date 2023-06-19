Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07E735EC0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjFSUz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFSUz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 16:55:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302311BE
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 13:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM8matCEcqo0X87TqQAa1UzefkH4WB+VYCPvg2ReNbu/C8lUpS/ZPR3i9qljG7FXHPZFXrJ/V0fQK2nVgN+zfWFbZsC7wKsg/4i6m48PFY+ohF+IBOGWQW7f+qhGqzNy2rNsqPwE8A0KAfH5Zp+Zl8jUl2ju47jVLZjrBfy2BNi6Nt399RMQEerjsMTsE1UOY3n855l8fKurqPhLkMg2jhGjJy/+sIxkyfEWISvyHJtpUGnW1Jc6s6qEDtzrvluWnGMVDF8hkFyDkrZxIOQZCifjCMw59Xh2n1CkX+I61jr2THhexj5CnYtJSLW6mZhAt/h+wBU7en1wJR1lZgs9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwRIRXNQ0OgjSOeeDNfIl56gt7qbnUstuWlsAvoKxqU=;
 b=AaDAQHR62L83MW4E/BtHSlGetehQ0JWFuCr9Kt+Jv/t1VsjI2d0+jd2/+aPZmHI9Dr+J4gO+15a8A20ZoZWfoIoHnH8kZIzQHhHujsmu1p+53RNLEhpJoe0Pmp+oT8kVmWBmpeHnP0vtPbEQ1VNwMOtOI10AIgEgALagSfnEtYDODZJburN/j5t3vCoZ6FWlKCUt0uLI1xjwWliorEu6flBeYQ2AJu1TvRGuc5+VCdVc8rxuUyOc9Gnr9rmGH935P+vtt7CxwLjCnMPa/iF++FNAAxqus8W37U8lL85WRUXM2r2YZguF4ZbJSh5V977prRS8uAXqe+cZQOG04c6CRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwRIRXNQ0OgjSOeeDNfIl56gt7qbnUstuWlsAvoKxqU=;
 b=sHCvGM1T2jz+ICD4r956U11QwYu9LP7UJA6UUzJ/pKn2tXt6CpKiFUwjtDNIhclFNW180k/yfK1eCxSr0zvJDMAqqnZBaomN9KaeMRi0bmLMKhyrhvtjokmLDlFKH02dKnaD0j2wfv00l/2XvV1Rl4vhuBRd6eWOPGjEMcWwXjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 20:55:22 +0000
Received: from CH2PR12MB4312.namprd12.prod.outlook.com
 ([fe80::70c5:ee54:f2f2:5b16]) by CH2PR12MB4312.namprd12.prod.outlook.com
 ([fe80::70c5:ee54:f2f2:5b16%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 20:55:21 +0000
Message-ID: <0127bc28-a089-83be-0bbc-b79a16a3d61c@amd.com>
Date:   Mon, 19 Jun 2023 15:54:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   "Martinez, Juan" <juan.martinez@amd.com>
Subject: Re: [PATCH] wifi: mt76: mt7921e: fix init command fail with enabled
 device
To:     deren.wu@mediatek.com
Cc:     Eric-SY.Chang@mediatek.com, Leon.Yen@mediatek.com,
        Soul.Huang@mediatek.com, Stella.Chang@mediatek.com,
        ch.yeh@mediatek.com, km.lin@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo@kernel.org, mingyen.hsieh@mediatek.com, nbd@nbd.name,
        posh.sun@mediatek.com, quan.zhou@mediatek.com,
        robin.chiu@mediatek.com, ryder.lee@mediatek.com,
        sean.wang@mediatek.com, shayne.chen@mediatek.com
References: <19f1aae1ab9ea867eb42742fc5b72ed4d7307b0a.1687159671.git.deren.wu@mediatek.com>
Content-Language: en-US
In-Reply-To: <19f1aae1ab9ea867eb42742fc5b72ed4d7307b0a.1687159671.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:806:130::19) To CH2PR12MB4312.namprd12.prod.outlook.com
 (2603:10b6:610:af::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4312:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba2c6da-d230-441d-3594-08db71077f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHLeoeMdGvqptykOGucCkl3/8P09lBB1D0e7OgUaZ+M3U989dfvWgIIuv0xSeKfaJVw9T4cijIVbdqt4YEUC5T1jgFs3foBD+QJd2TgaUVcQYDdaDK7HywrZyljXw5eBNK8TwB9WoDGzZrMWfyLQyGt/kNunZJJqUkzQXWROB6e678ulOl5HQgoGv5Pgjk/CBVfRizWxVCWWF1n8OmTC1BvYEg4S72BjjOhA4TbAmy5Sje+ZXQmLBf34VsE7SEAcfe83PNXM5ifFHBVsL940l4cniWxim6D67pSFfGtkszRp9I3Ohwaq4d6/0343bfi7Zzwi5JrbiSyBIkOeharFslQyRgdFJO0EAVyyOi5luRg6B5/jPyNHitaV9f1lkyY3wEkxm1t5JTDiTQUunj/ksDDAuF4d/5phBa5+GtxqxDCLoVtsoKz2iXG+247x9LHUC34stfhOwQoIC+4MYBz7AjLtJycM/rlzO0tDwEZppDOzwFOCi0dVsHgcQ/r0434I2dBAqwP7LW+nkex4x5kjOIRcBoIqVBoIvk+ws2gCQmhyqQA7nKjeFQ9s3CTNpWzOZ1Hz4YYkYJSMenvCze+4eM3EunJD/AeMtuCaeUs+fjIWnlq+1wIxFyNhIzLuk4eRDDj4iQm/Y3nrVAaFvlqiSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4312.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(8936002)(7416002)(66946007)(8676002)(66556008)(66476007)(26005)(186003)(6506007)(6512007)(36756003)(83380400001)(31686004)(41300700001)(38100700002)(5660300002)(6916009)(4326008)(316002)(558084003)(2616005)(6666004)(6486002)(31696002)(478600001)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVpMmphRnkvWFNsd0k3YXpnaDRNN2hrTnBXOFJXUE12NDlONktJQlk3L2w3?=
 =?utf-8?B?L3FGYmNqc1V5bFUwV25DWmFqKzd4b1RZakJ4bEhLNHl2SkhMeElxbG9pUGtL?=
 =?utf-8?B?V3FCemU5SnB3L1JCVGtHdGdndURielpYNytxcGU5MkI4cnZpdnVjZGdvYjdk?=
 =?utf-8?B?MUV0Tnp6SmRValp1UFNJMVQ2K3d4M2JxeUFWU21IUGNKcnNOWU9vMjdVRmJ0?=
 =?utf-8?B?R2tTdi8yWU1GYWZBOWhnbnJTUEtzR2I4Rmc2QW4xMks1Z05sNzBuaHhJdW5N?=
 =?utf-8?B?bmplQzJvRXJEUGhEVjVadGNpc3l5WHRUVHJHR2ZCYngvNUlQWVhnSnl1aHor?=
 =?utf-8?B?RG13OWtqQUdBTWliWXYvc054U0Jtek9wYVNCOUlyS0IvcFBvM2JPa1g2TXBU?=
 =?utf-8?B?YU9mc1NaV0RxblYxOEpGTHdtZG5YRlNsbkFXUnlJNDBxV1JxNmsxR2J3T0w0?=
 =?utf-8?B?bDI0RVlzcWI0QlJVb3lta2FoLzVtdWhxMlNzSDBOUlZhY1pWUlZCTE1NVTI1?=
 =?utf-8?B?cTNYLzRtVmphUzhlRXNhMFdWbjF2S1cyNGhRY29CQ0FjNUlJODR6OXMvWjd6?=
 =?utf-8?B?ZS9UZGlRMW4wTisvZXZlSGpHaithU3Z5R1JiYTBsL28rbnc1ajV3MXRqdEZT?=
 =?utf-8?B?WTl0bVNPQVd3eXFEMEZUSEc3QmdMa25iU01DdkNrdUlncnQ4MWEzWWVsZmVm?=
 =?utf-8?B?anB3WCsyamYzVmJVM1NNSVlGNmJKa1p5cUpSVGtnUVhjTmxCbWx4cWpNckFq?=
 =?utf-8?B?TGllVmxJNEk2MysvWC8wVG5DOWlqQy9rSTFhYTlRR2U5VG5lU3FMNzEweCtI?=
 =?utf-8?B?YWdHMDNYR1U3eUhhRExHQ3AzbEx1WmZxYXFSKzNDUUsyVHhCT001ZTdBclVt?=
 =?utf-8?B?UXNMNkdUR24walpyemNlMnE1N1BySlRLRE42MHlPdTJ2R1RFMWpwT216TWZt?=
 =?utf-8?B?aFJFYXlMREJqUXpGNHI3bWF2L25aQjZYNDZCYXl2K2hGdzdwUnlFWWpwWjVo?=
 =?utf-8?B?akxVdmozZWRHTmgxZ0JFWjFmaVFXMDkwcERxYzIyL2hPWHN0L0F0cGc2UzNT?=
 =?utf-8?B?bnhhZzQ3V0w2MGtzVnRLVVVXUEs3WUlTUEYza0Q1ZVgzaEdKcXRXdDIxTW9i?=
 =?utf-8?B?RTBpZGtVSEs5ci82MHd3VnJXTVFEdU9xSjMvS1VTSjNkOTZ4UG1jTXBUTWV6?=
 =?utf-8?B?ZjRTd1dCZEFnMGpaZUNWWjBSck9GT2V6TlVHb0FhdGVnZDIvV3dRenR3aytx?=
 =?utf-8?B?d2VkY2VuU24wczNhWWtEMFR2QjZPalJEam9EODhCbnAxQWFQRnFqd1Vkd2pj?=
 =?utf-8?B?VDV3U0o4aE9jdGVjNFFRK1kyQ1F0VVZRUFh4N0xZSkR5OUM1RWN1OUNwbFRC?=
 =?utf-8?B?TktVc2lKQXB5bTRUZXdWK08wTGhuQWhZakdCQ2NLRG4wcmI0RmpDRGI4WTUv?=
 =?utf-8?B?SnUxOVQrdnFTdjhENWRyblZZOHFNMllleVYxVElRckpQNWZzakp2QXh0MzVE?=
 =?utf-8?B?RUxXNWNWT3JIUHB4OTdjVUovLzFnSUVTNjhOK1MrTEk4ODVtUk1IRHQ3dFk1?=
 =?utf-8?B?UWF6NjVNb2pKMUJvU05OSVd6enhVbDJPb0M3RllqNlVlbkpVQXFzVisyNDgz?=
 =?utf-8?B?ZXM2Ym4vZzF1NTN6SW9yWmp3VHZ4WDdVd1BMWHdRNEZseldkOUtqdndnaEE5?=
 =?utf-8?B?VDJLMmJwTmE2TEFhZXE3MGRNdU53VUFCRHFTZCtWTkZmVEw2bk5WQkxqV1g3?=
 =?utf-8?B?V1VKa0dEeGN4SzNjbmNHTmxhR3hKc0pxV0kyK3AveFNKZWl2UjFJWEpWV0NX?=
 =?utf-8?B?aTZ1cGVnRDg1dUJydi9VMGUwK1hnTTIwNS9qTHdkb25mWnhjN0EwMlpjbjQ0?=
 =?utf-8?B?dzZjZ1JzbmlxQThLaTRKZWl3dWFGRGpaQmVXNTg3OWpNenMwYmRYT0UxdlNI?=
 =?utf-8?B?SndFcmRaL3UxVHR1TWtlNTdBdDdHZHlvY0lNUFI3S0x0UzBHMFNnY0s0b0E5?=
 =?utf-8?B?ZUgxUy9Jb294YWIza0RzbHc0UWZPN1d3OUs1NFVaWGlQQmJNYmRGWU9ib1Nl?=
 =?utf-8?B?Qml0NUROZHZZYnlKTldDNTk4YUFKSmtuQkk2QWFGTjFXK21KYkU1bzNlaGpv?=
 =?utf-8?Q?2zK/86rOWQUSUk3/r3KPYDcBr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba2c6da-d230-441d-3594-08db71077f3d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4312.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 20:55:21.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55JELX4S40ShzcJSeBGeG4ogZNnxz91wcnpgt1O293C3hwBLMUYWXlKwMjRQiCka8zlXYpO0Qr7B08hi5kBIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Deren,

I have tested this patch with mt7921e on AMD's PHX APU (on Mayan board) against an internal 6.1.x kernel and can confirm that it works as expected.

Tested-by: Juan Martinez <juan.martinez@amd.com>

Thanks,
Juan

