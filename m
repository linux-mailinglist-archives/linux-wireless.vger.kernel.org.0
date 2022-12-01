Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D302F63E6F7
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 02:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLABOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 20:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLABON (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 20:14:13 -0500
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080797039
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 17:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zzy040330.moe;
        s=sig1; t=1669857252;
        bh=ddco1yL+GOCapgXyoZJ4g0ChgCBqZLcavbU4MaqvpFA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=bVJxCWV+lLep14ZumIPnEqp88zJkv9a0ExvUFafhwRLKX8SZdTPiAMv3VJD1hZ792
         KPaIA40wqw68WJeCjVO5sgtBKjTAo132ucgzf9+KIhgZzj04DRlCxDvzxaHjY4xQKt
         5o5vrSaQPUxQxz8Z0Qd42ZEAYRwP7Izf/SSt2JlIHisAoUXE1ncKYDUkh8L6fyG47X
         INhId1FA22w7HlnR/lWFuSkZZiQoiWTTpMYDR2NQFYqjVpaZpJfjLeFybBWWgboibz
         WJRocyyvqHGNN1iW5UzkxzSR4i/FtoWoqlC6mP+0vAiqLzyCB3RGqjGkV4Omf3C1ao
         65XIO8XYGWK/Q==
Received: from [10.8.0.2] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id D0AAF1609B1;
        Thu,  1 Dec 2022 01:14:10 +0000 (UTC)
Message-ID: <568e7f12-e8f5-7e4c-9389-0869332b6c0a@zzy040330.moe>
Date:   Thu, 1 Dec 2022 09:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 3/3] wifi: rtl8xxxu: Introduce
 rtl8xxxu_update_ra_report
Content-Language: en-GB
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     Jes.Sorensen@gmail.com, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
References: <6321862a-3362-95b9-bbd1-be0d5fb97f7f@gmail.com>
 <20221130134721.116982-1-JunASAKA@zzy040330.moe>
 <f932f4c4-c846-fca2-b1c0-807efcee370c@gmail.com>
From:   Jun ASAKA <JunASAKA@zzy040330.moe>
In-Reply-To: <f932f4c4-c846-fca2-b1c0-807efcee370c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YSg9L55Q4MvQcLg3hfcdYSr3jKZ074mc
X-Proofpoint-GUID: YSg9L55Q4MvQcLg3hfcdYSr3jKZ074mc
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 phishscore=0 spamscore=1 mlxscore=1
 clxscore=1030 adultscore=0 malwarescore=0 mlxlogscore=211 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212010006
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 30/11/2022 11:39 pm, Bitterblue Smith wrote:
> On 30/11/2022 15:47, JunASAKA wrote:
>> Hi,
>> I am trying to merge this patch into the linux source tree (Mr. Torvalds' updated source tree) and find a confliection in patch 3/3.
>> I think you should move the rcu_read_unlock() that originally located in line 4657 to line 4682(right after the if-else section)
>> to make this patch work normally.
>>
>> Jun ASAKA.
> This patch set is meant to be applied on top of the wireless-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
> That tree contains a commit which is not yet found in other trees:
> 7927afb5e27b ("wifi: rtl8xxxu: Fix use after rcu_read_unlock in rtl8xxxu_bss_info_changed")

Oh I see, sorry for my ignorant.


Jun ASAKA.

