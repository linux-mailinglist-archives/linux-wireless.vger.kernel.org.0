Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0862DFCCB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgLUO01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 09:26:27 -0500
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:33825
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726949AbgLUO00 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 09:26:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRdEoFKXU++IIyy+FdBDdYJkrQE+ai/cViFvzDQw8jaC0tKwk5f9FzTglEC6C6mqAam67xzd47MA9Pkv5Y6xz/wjRLZKL8DXOKNK7w0hM/0XgvCi4rq6lHU/wJTNWLh42P7KCacSYj5Bh2u4O9YdKu0thOyHhR0Z1NpSc2vOZJaWKL1FaLmwxgaH3mdCiaY2Ntvnj5wN9e8jdNrjR+IfNG6vmQEfmLYpy/qWC2QiOSn5nIipQ6pR+lVE+wi+bN8YpAAoZ81WQs0DV5P02fAmuKJszRjaMlT9SB1bR3qwRAFRKXbG9a1Y1Xu42iTrYnVko8bJ9BC59xzD6EmkslYFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCTEYr0Ts7Mou2BZ1MyZxI7ChpO90Uzesx8t7u2Z4MY=;
 b=gZvApgcF4l8RfpyPzgdHuyLK8gJtyb8zjwPNXGtlD/2pnQsvcWjGhBS1ZcH1HxtqMBSHJwVMlif10yLPDA4jyECzKkXucw1Qpi8cz4xjcr6FkYinlcU6AGL8NMoMzrRzA3DPLROHzsXu/nIQEoOzP5PLnQaKJnH8VpOCZLPMiNqGukZYyCfZ6sSZhJQmdjQ9sjrAQjue7Jd3yCeKyj4ypAfegyzvH5KtCKiSbH/nt9rHUqadpOlW6NZL54AwesF6DpbLjnKLPGGfX4RCXcED1rT1jjwkWOMzMSEpdn3ozifbC7CkgwQSS7oAyHbQQ5Th+HrMFNAscvK5xl0zCVFx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCTEYr0Ts7Mou2BZ1MyZxI7ChpO90Uzesx8t7u2Z4MY=;
 b=BWwkbb6ZVYxXOSpaPlen3haLkUd2hc3+XVKNkKE/ZIMYc+LpIo8Tibd1Kj5BHlsnJWxGtOOEkerUlOBS2uXp+OoNnPebFolzgQTVjSpTxOhtYw5A20NGf97RII4C6Af7H6v+1v3CZ4KUzGHlicUg58NOvNoXpu4V9LRcDvFA7bo=
Authentication-Results: celeno.com; dkim=none (message not signed)
 header.d=none;celeno.com; dmarc=none action=none header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0292.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.31; Mon, 21 Dec
 2020 14:25:39 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::11ec:bf60:fa41:1ff5]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::11ec:bf60:fa41:1ff5%6]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 14:25:39 +0000
Subject: Re: [PATCH v3 v3] mac80211: 160MHz support per IEEE802.11ax standard
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
References: <20201019063921.4335-1-shay.bar@celeno.com>
 <20201019132616.32286-1-shay.bar@celeno.com>
 <9a043fdcf1c6324688f4c92b18f31c267969f5fc.camel@sipsolutions.net>
 <4f38e1cf-fc8c-c9fd-e064-e433a8b82186@celeno.com>
 <84e63d2b334b8dbfb2de23f604030c7ea355444d.camel@sipsolutions.net>
 <4e7d4c76-93a5-0863-bffa-897183bfb4fb@celeno.com>
 <7a770c592cb2d3ae5ed9dab19c515b139818b05d.camel@sipsolutions.net>
From:   Shay Bar <shay.bar@celeno.com>
Message-ID: <9a45f448-b2bc-a34b-2b0b-70284fb652f4@celeno.com>
Date:   Mon, 21 Dec 2020 16:25:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <7a770c592cb2d3ae5ed9dab19c515b139818b05d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [87.70.6.186]
X-ClientProxiedBy: LO2P265CA0331.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::31) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (87.70.6.186) by LO2P265CA0331.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend Transport; Mon, 21 Dec 2020 14:25:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e52cea6e-84be-4815-1090-08d8a5bc4a90
X-MS-TrafficTypeDiagnostic: AM0P192MB0292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB029246BFDA0E75F554E4D639E7C00@AM0P192MB0292.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QC9t64IB/AQHvtHdxC6Ei0wLq2+UMDPuJTXGDjuMYR0YiOhMKXMyZ4t/kwgixYDXmy6C61kXYEU/lpSJjS6I0qJhQhDhwQAdF2xkCqMdKQnaavOxFCnuZV3kqUZ6trPVQTuZZqMDS7v1cSZKXQw0CWZlkTOZ/cCQJ4xNohcMRrebjDaYZAQO2sz2D72xR5z4cQ0rqGwtvRO+Iz0Ju1mBJpXC+vAzneIq2kfUersmDNi92hdpBLnVCzCx8OqbNaFYfRLb4BfvIdJ6FrrPofGjN9h5XqyHHik5SWfrpDN/E7KQQNkczZZk8DqislcF+IlzRwTw3a2urmuFQWh3PM9TmHCnsKA4JYvjptdEGvDky4f9Q8cXNcAIr97jfm350qd/YT9YWinP6+9HDxOg4f2VP33OQzdyr0sss2vFbnC6dU/ZJqApw/6OVAn0O32xQZ2UGHR/LPushn8IlP17DkYuyVJimcuhl/iuGdnkeSKA39o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(39830400003)(136003)(8936002)(86362001)(6916009)(186003)(4001150100001)(31696002)(316002)(2906002)(44832011)(8676002)(4744005)(16576012)(4326008)(53546011)(31686004)(107886003)(2616005)(83380400001)(52116002)(5660300002)(36756003)(66556008)(66946007)(6486002)(16526019)(478600001)(66476007)(956004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OFFZbldiMzhBdEgvS3RvQ3IvQ0FsWmVXZGFHaUpBcHAzNDk4RFlPVEMxWi9p?=
 =?utf-8?B?bXYwV0JvWkY5alV4Z2dDMGpXYmhNVVpPbmZsNkNxRExVVWpHYzlUT3BBY1BW?=
 =?utf-8?B?VDRqQkJaeHR5emRGeXlobjBubFFOMEtYWjVrL2I3MmFRcDE4a211ZjlKTUVi?=
 =?utf-8?B?SGxWYmUyQTMyTGdSK1E4K3Fqc3FZbkhwNFlSaU16NEVFc1BFY0VJVE9EMHVt?=
 =?utf-8?B?Mnl2YlRzRyt0cnd1bnphOU1qSDJSbm5pRXdPVGtYdjM5U0NCeTZ6NjNoZnlJ?=
 =?utf-8?B?c3NJb3JFL1hzV3dhaTNFaWxzbmNlVHV5WWRWelFqUks5RU5nc2gwRDVUZGE5?=
 =?utf-8?B?bjBDYXptQmpCMisyVHlicFN6dEZZMVZoU0I2M2hLKytiT3IwUi9PcitVdEc4?=
 =?utf-8?B?RnBrNVd1Z09UR25ZUnhVSGZFYzJ5WWgrZTN5a0ZlWFp4UXNuNFBSdW1QTm5O?=
 =?utf-8?B?UUgraVF6MVI0Mkw1ekNFL25jdlZySjlQVGhUaXg2d3JTenVNQjV1bUtpWnll?=
 =?utf-8?B?Vy9zTFBPaEs1eGlQTjRpWVhPZXlzODJCK3BIM1c3VlNudlFaVGlVL01IdkVQ?=
 =?utf-8?B?K0pucFVCOTEzSm1JWFdFR0gzZTFPOVg0eFpvMmU2QmlkUmJuQUxRZVBtQzdo?=
 =?utf-8?B?MVdmZk5jSkxlZHJ2T2h3UTliRzVkQkZlT1E2QllUZXI4QWRtK2NNQVlwWmNX?=
 =?utf-8?B?VlhLdS9GcEU5N0orWno1Rk5hMkVNVDFmbVRVeEdlV1BteU96ZnUvOVkrdG1B?=
 =?utf-8?B?YkdNWmVpajgvblhvWmp5UGpPbnBhVzNGb2pmV2NzRjl6amRnaGplVFVWZmJo?=
 =?utf-8?B?TnZEckdxSlFrd29icUlkT2FxY0Y1aEprUWV2L1FBRnBNbmdPazlSa0Y1QzA2?=
 =?utf-8?B?Sk4vcDRIZEJsVEdMV2lpUnBQSXgyK2tCbzJIcEQ5M0dnTWt1bHZpUlJnTHdq?=
 =?utf-8?B?UmpDTW52RmFXaUkzLzI0cDFDS1BSb25hVEtMaDFQbXl1MmNJdy8rRFRTOUpK?=
 =?utf-8?B?cktTTkw4QzNaTnBiTU9sY25UNWx0QUE2dEY3akZvYmdteWlpMFR4WUpRZWdO?=
 =?utf-8?B?NzR0NVNlaXNUQy9mYW1iNVRsSllQSCtGUkMxeXNId3Ezc014ank1S3hJV21Q?=
 =?utf-8?B?ZHMyaGVFa1p3aFhnNjJGQ2FJdHBheDA5K1VOOW14MEZoSE9Id1pyRkQ4S2Vi?=
 =?utf-8?B?RTkzOTZ0Y2hIV0ROeXFXOWpyd0hrQXgzWm5RVkxHaDhwSTNiWkRHcFRoVlJZ?=
 =?utf-8?B?ZnJ3UXpGa0VHT0dVSnBLOGhhejVKazZmeTZwUjVMT3lmS0ZncUIvSlpkMHVj?=
 =?utf-8?Q?a2j19gWipTJv7XTgnubJz5ZVuCLjbfGvtM?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 14:25:39.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-Network-Message-Id: e52cea6e-84be-4815-1090-08d8a5bc4a90
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uhrybg7Rd7gFCJ+P9JwUZG0KyoZ4pmyvJqeyO0xhWXe/Ldw6Mzcw1lIVvK7/9Aql1l8NV6cM0We8msuOLfPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0292
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

I published a new (short) patch for 160Mhz with extended NSS BW in CSA

Message-Id: <20201221141441.17613-1-shay.bar@celeno.com>

I will discard the previous patches.

Thanks,

Shay Bar.

On 11/12/2020 14:22, Johannes Berg wrote:
> On Sun, 2020-11-15 at 10:57 +0200, Shay Bar wrote:
>> This is the source of confusion, sorry :)
> Actually, the confusion is that you said "160 MHz support" ... and you
> really only meant "160 MHz in extended channel switch" :-)
>
> I'll respond to the patch also again.
>
