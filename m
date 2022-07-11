Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A5570E2D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiGKXVH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiGKXVG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:21:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C98509E8
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoB+YYK3kjXISNX8Dr+JJcvu+PdhCekIQMv2wA82RP/Z4Yc1QnU4jbHCP5TRjp7vJLPnUuwEpMlTlefRTkPh5XPGwEljG1thM2VAaH8yHtXjMKeNL2Iu9+DqRRLILAoReltAEfV5knR1bQdOCMWnw9XOWrvI5JfsOBHFiGD0CRrNEWcA8D4GVgkmHYTzkP1YgOQ5ntVh38Jrubb1cNEMKXFsAl+WZnOMSkYXtXh6cK4pwW9KvyJBYmRVZ1OY24X8lOVfSSo7OWPK4aLYEQfdnpCkEl1i79olnZZOJ2p2u9PcExHKzCP33yZjPzUDTfQFxWya5sRg6RwpMXfEF0Gwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs9t7AwgiGLnhaS0UjBkGTP1rd3xogyukuefrJYuZZ8=;
 b=SCcezS6MU1jrAE8xX6fUV0brc+9ZdYVVbebI2fxCpBuer8mJWEBzGOlWgUEB5T5oE7GAPYIDUSQwQ7NawYoFuKzR3N6Av/+IAe6IxBM3vCjUzu7w1Qopijh3aTCfvb+z7ytnNi9kjwxuJ4WPs5tq9Pmn2aV1wHwO/q4uBJwnkefjvMbKRssTqKm6zg5TC2fzBqu5uLOmIpDrOnzwmj75bfLd0/6sXTrhZzxSKKjLsoS95Cl6mXRCAQrzNtrW800M+l07Jbv/eSdO22PAQGj/FuCEHvOGMp5/AI0LJB1lRRwBTZBPQYDN9FKLW7VeeDo21c3oOs3a/FazISk2NPpYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs9t7AwgiGLnhaS0UjBkGTP1rd3xogyukuefrJYuZZ8=;
 b=Wt6gpYFgmyTSUgaKAwYfkNHlNmYEOg1YjLPK9oGZMrmQZq65ys+0MvcsWtPHNGk0HvyLWPEJch2mXZ7MySQlZ3jd85CzImvKnBv3d5BTlkAW5INkPYzaKQ2gkgIhk2x24yK4o0cCnLRm5w5Le8XYE17psj3j9INRL8ylMD6scp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0388.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 23:20:57 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:20:56 +0000
From:   Viktor Barna <viktor.barna@celeno.com>
To:     quic_jjohnson@quicinc.com
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com,
        viktor.barna@celeno.com
Subject: Re: [RFC v2 76/96] cl8k: add stats.c
Date:   Tue, 12 Jul 2022 02:20:00 +0300
Message-Id: <20220711232000.2957124-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <6fe32a06-a960-3a77-37fd-bc51af1b4c4f@quicinc.com>
References: <6fe32a06-a960-3a77-37fd-bc51af1b4c4f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::12) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2efc95-8f57-4824-d21f-08da6394020c
X-MS-TrafficTypeDiagnostic: AM0P192MB0388:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHjf8+ItUmCmdXXe/DzSJe7UuoYMx7ekrFSRrpv5X++5GijDdqqdQYqj7Xwa8ZCI1e3VlusQOiQd4zofHz2kuVL20Jq5T45HgAvmUxO/2kj/8pVQJZtn1QJwSaHA/9IYU6mWp3CE8WLZgORPBMBPY0MZTCNcX74wUeR+zkVRdPwbzYm0n9BkP5SK8w3xcTrG/gb4cmMeaardM4lfZniPUPhccRjgtU9purQ+eIigl4/Euu/G7c1hB6mnkzTR/6GCRm+7gofm3Br155JIBR8xvbzYbdCmeF28ci0n1EhlcE+BPIr8YZB3qf7vn7nd6L5TGb+23bfEge45zuZAsbbYhZvy648LBHzX+COlV71KWhPSzT7MptSvvmeNRyq8GoxlrZzudrDS0hVdOncAxbaHpKoDc7SXerwFZ+uuVmgALMRVh2zg4rs6tdtmkrUmEIPwPfWvlwEe5itN/IZt/ZLlqwrC2vlWnmm4OTifhU6+WJVHCX1vzUDvNdqFFeFsp0wL6O2Cc6opaF6Wd/6cD4A+KjtXpGlkYju7YFsiquHCV+u4x/W6er7r/n38DLNRHUitm/X3Th1+XIHSaVABxT2+SZA6strRIlFcvjErHUobJB7CUHemU45b/Net9DS0RycJJyXmQeJo8SVnz+Y+ochCo2xEeCmOdJ1bnFiaHllULpsxHM/smo9L/Z3r+Z6GhzjNl10fzlOLKa8miCWQ/7gAdTEbBsEmrpNAqIYLWNXhKzlT3QgSHI9PjNNdHOuSxFMzLXlu2wVNoEMKf4uGtl4zpCkZb/OlY/Pj6NUQ05KND5X16rkPxoZax8tAUl8BrenFl+teUu8abogERRFUZguYLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(346002)(396003)(366004)(376002)(66946007)(66556008)(66476007)(38350700002)(38100700002)(44832011)(2906002)(4744005)(8936002)(4326008)(8676002)(26005)(6506007)(52116002)(55236004)(41300700001)(6916009)(6512007)(478600001)(316002)(6666004)(83380400001)(6486002)(186003)(5660300002)(86362001)(36756003)(2616005)(107886003)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmtNV1QzeHFmRlIvMHJkaWdabGFFMFJ2ZFpBZGkvdkI4djViZ1psYVJBUWgy?=
 =?utf-8?B?WlY3RmU3Qm5mSjdROEJuT2M4RjRYSDBaM01ZSGFVYUo2VWMxR3EvN3RoZmtI?=
 =?utf-8?B?UkZKbXVZSExhSkRXWFVna1gzeUZGMVFRTktybmVtNjVpN3o2LzNUQUxxUDlV?=
 =?utf-8?B?Y3FNUW1nM08zeWRxL1ZEN0ZwWmV2bkt3V3F6SUlNeitoc0tMallzQ3NjRytI?=
 =?utf-8?B?aTJDQllGUGx2UVlRaWZ2cE4wa1pRd3ZrT3lTMUx2ZVNzNEpCNnVpVjU1b0U1?=
 =?utf-8?B?czhhOXlCVzlJN01qcVY1Vnk3dXkzZitwYzdjM0F5RlN0TVZkNnl4WC9ZbExt?=
 =?utf-8?B?b0lzS1c5RTNMYTNKZnRuMkRZMExURWJIWVZ1U3FTTEJBMkRVckZtSlNGdk4v?=
 =?utf-8?B?SjdFYWllUDl3SjAvMFY3ZWNJUjA3cnpqY2ovb3VycGZuNWkvcE5JM3djcXN3?=
 =?utf-8?B?QWxwK3lhU2pQUVRUN1RPejBwYkg1MGFEbVRDNXVmWCs2RVZBcXZTR010dmx5?=
 =?utf-8?B?a2l1N2ZGWDBYSjdSdzByd09vdjF0aWVVcnVMOFduZHlJd3JqdmRyVCtnYURx?=
 =?utf-8?B?bHprMW5WUU4yUWdHeFE2Q01aOGEvNFFWK2hBOVgralNwRkpXY21Xay9xRUF6?=
 =?utf-8?B?dG1jVjQ0QlgzNFFWMXRiWiswYXowS1ZCblZMTzU0ck90c2tuY0N2cFpFSzdr?=
 =?utf-8?B?eWVNMkdYdlBqSTdLem5MMlpydFl2NE9yaURQSEpYT3NQVzNKSUpHMHFUOXI2?=
 =?utf-8?B?dG4zOFNmc1FNQ3J4bnZPdUJhRUMrTkRUSHNJem04WEhoZHpwa1lWd0REWUtN?=
 =?utf-8?B?MVFvVHk3d3VxR1Fra2taV083QWR1OFNCVFMyTFZkMi9ZYmNjbjBhODFZdzNz?=
 =?utf-8?B?TTViTDBUNkg0QVpQOWZ1ajBLSGd2ZlpGUFJnL0V5Z3dzZ1RnTjZMUEZjYWd4?=
 =?utf-8?B?bnhyTDBlNWJJeWNGUFZPNUxVcFJGY2lzSG9tenlOdnU2RlNlYnNMSzYzK0pq?=
 =?utf-8?B?bjdTNEhTNnZYT1ZxWGR3c3kraCtrRy9aMkUyM0MxSnJkOW15Kzl4eWlXTkJu?=
 =?utf-8?B?RlFjeWxPMk1kMnlKUXNaSzJZeTRLY1RJeHBReXhQZGtNdzhSNjh1eUFlOStm?=
 =?utf-8?B?bXl0eDkzTk54cTdRUWlrK2dXeGtUellUTnhhSm9DZ0Z4UnpKWWdxcUoyY0l5?=
 =?utf-8?B?N1VPajUwczV5ckZWb2ViTituRTkzMFVyOHdyZGdhSitzUTJ4MzNhOFUxUy8v?=
 =?utf-8?B?T0gyZnVHdHg1UDN0U25EN1p6MjlMOGRoOHZteVBRNE0wN1lmVFVVK3VlRkFR?=
 =?utf-8?B?cVBxOE42NnUrQXZQMU55TFB6bzZzYjB2cDc2VTh6ZkVTbVA5bGVMT0xERWlE?=
 =?utf-8?B?aXpEb1ZEcU1xRU5lZEFGUmxSa1RqNk5SbC9NdTMzTHJzVkxlM2NUanNtSFF0?=
 =?utf-8?B?TlUvNzhTb24xdERlckhydHlvNytjY1V6QUVuSE9IOHNHaDZUSEZzUXZuNTdL?=
 =?utf-8?B?K0NBNXBOWjM3OVBRd25GYkNIcXZ6bEJONkdNN3hDcm5BMFY3YzRHWG5ZMm93?=
 =?utf-8?B?RUt4blFLMUNzUmtrWTB3L1JjRHRJaVd5N2l5MWZZQU1tYkNobk1wUU5vMzBh?=
 =?utf-8?B?T012M1B4dDBSZHRvYkxpcitUS21qNkV5N1pQeGY3NG5lbXBGcDIvUEFjUmxB?=
 =?utf-8?B?TFFCUFBTNGhROEcwTm85ZUNlVkIvWGlpbzM5VnArTUQ1elVESE9GaG5lbU45?=
 =?utf-8?B?SXVRSm10cnQzZjIxWUwzM3BBR011eE5HYmgxb2MzaVJBbnZCcVJvelRTa0g2?=
 =?utf-8?B?OGdjRGxMeHRTSTVXbEZkUmhWdmI1bnlZUWhlLzRDVXJQSyt5eVlRSGxyUDc2?=
 =?utf-8?B?MW5FT0tKcGxhYno5MmhyTnBVNDAyUkFCN2J6dDZQOWI5dzRoUWtFdzFRTzds?=
 =?utf-8?B?K3BUbUxaSS9yM1NTN0RZTDVtQzVJcWZMVThtSUNmN3V1QXFHaEhVNlc3MEFQ?=
 =?utf-8?B?U1lKaS9TV0dPMlBwQ1BwUEk4YXB1T2xyK1VENzljajVvUGhYMkhtTGVMN3lW?=
 =?utf-8?B?dmxERFNUKzRVRG41NlZtWmNqK3h2YUlYWnh4VFRIdkpsSUM0UDFiNGpMVVhh?=
 =?utf-8?B?TGFlb2lnSmJlR2Z3QnFhTUJMd1RJSGh1WkFXbHBFVDU2eXJrNXg4MVJQYzJp?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2efc95-8f57-4824-d21f-08da6394020c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:20:56.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /h+waOWhWImF3QqudrG5wAlNDIB0A4DIZgyuXUJv75PyqRSXIMnuigxklo0Svtzo2ZVAxgUNhH+5g77jz/pw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2 Jun 2022 13:59:38 -0700, quic_jjohnson@quicinc.com wrote:
> why an embedded block? seems to serve no purpose
>
>> +			bw = rate_ctrl_info.field.bw;
>> +			bf = agg_report->bf;
>> +
>> +				cntrs = &stats->tx.he[bw][nss][mcs][gi][bf];
>
> bad indentation
>
>> +		}
>> +		break;
>> +	case WRS_MODE_VHT:
>> +		bw = rate_ctrl_info.field.bw;
>> +		nss = (rate_ctrl_info.field.mcs_index >> 4);
>> +		mcs = (rate_ctrl_info.field.mcs_index & 0xF);
>> +		gi = rate_ctrl_info.field.gi;
>> +		bf = agg_report->bf;
>> +
>> +			cntrs = &stats->tx.vht[bw][nss][mcs][gi][bf];
>
> bad indentation

Correct – that is an artifact from old version of code. Will fix that!

Best regards,
Viktor Barna
