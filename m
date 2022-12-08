Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439B2647456
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiLHQay (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 11:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLHQao (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 11:30:44 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F94271E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 08:30:42 -0800 (PST)
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MvKGv-1omCTc0Ixl-00rKna; Thu, 08 Dec 2022 17:30:21 +0100
Message-ID: <24e23388-8f3f-006e-88b5-a07dfd675e13@green-communications.fr>
Date:   Thu, 8 Dec 2022 17:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     =?UTF-8?B?SG93YXJkLVlIIEhzdSAo6Kix6IKy6LGqKQ==?= 
        <Howard-YH.Hsu@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>
Cc:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        =?UTF-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20221207052500.10855-1-howard-yh.hsu@mediatek.com>
 <20221207052500.10855-2-howard-yh.hsu@mediatek.com>
 <8e8cfe60-c040-bf02-665b-a980852864aa@green-communications.fr>
 <1813da6bd8bf9448474ee0f61c23ba4d07470c55.camel@mediatek.com>
Content-Language: en-US
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH v2 1/3] wifi: mt76: mt7915: rework
 mt7915_thermal_set_cur_throttle_state()
In-Reply-To: <1813da6bd8bf9448474ee0f61c23ba4d07470c55.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZUF3yGex/RxRRXk0yUJmkaDteCpqzNByoW4QkXzj4M4UGM66FNe
 manhBsPlaXwad0LPRzLojqKiqfWG9sWeRgpLTyB3pOMc4kOalAyUhy5xC8Sf+XGfCnsJCVw
 nG+2ZDKwO9QkRJd2UQmtbygHFCxPMmVhEmK4mrZ33xDdvQ7iuzLwPTQLN2Bg5ag3OthSjLO
 l+E5Y/k0RFehuT2iZFfnQ==
UI-OutboundReport: notjunk:1;M01:P0:xEwITUnorQg=;ZkMknX5WVX5Hb+uzlG/9AKYy0rF
 xtmPpFf4I2mE/B859oTEQ0rJJyewB9OYrAsEWL7NgdjgmLqwoBqfQEBl4QWEs5nUC4TsYB6RK
 ndyV2PAkus7TOMG5T1G7chpI6uj5+hXJfLVvw58yS5SJvqx8C6I777j6uy7YE5ZP4HpEqqKQk
 A3ofIyqdl6xyM/HniIoX8cLGMxFQ55wUMGLYljh7Dl+hlbFLzFssGqUW121OgJ/VUBaqKWnWb
 c9eFdcxWZrjDcIPPHMB/0sdOM9CnBoWXY6c8t+BM2+2zQg81XvFjHWTbMPNRhYmNzyK/xs4RV
 OwOKKHGjORq4tFkGKN8MCt+3xOXZmnA1y6fqAsDr6oAefbyLsqjBf0FTSu3nZ5ff3udQYWKcP
 PvPq2CiyJmeSF1Kz/NPOXloi3vk1YIV31AdlrbnFGZtYOKIAhtUAz9PH5WerpOkgnz+CrQhTj
 CPfXn/F8g1KT8h+sCYaemZRnCTrazerc9rXaGIs8prMB7NjZ57udbK1zOn9fLWylMk55Ioj9C
 3ZLnfCobCxLIQatfQTm1vGtf+MIE/aCVQr5VjfPOzS9oboZaC1SHZ1+DMJrhd3bBsri8SZ/Zi
 vNOPK4H7vm4IaF+63V1CwPIfWq7GzwFhQihSAsU6+Yx9t5aV1eSiSm8c0G0ypNsFCdubfdde4
 1S2qWRYjLSCiBvM6JzQC9TNejsNyMVi9bOqqopTZrg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/12/2022 13:44, Howard-YH Hsu (許育豪) wrote:
> On Wed, 2022-12-07 at 09:15 +0100, Nicolas Cavallari wrote:
>> On 07/12/2022 06:24, Howard Hsu wrote:
>> > This patch includes 3 changes:
>> > 1. The maximum throttle state can be set to 100 to fix the problem
>> > that
>> > thermal_protect_disable can never be triggered.
>> 
>> You are modifying the cooling_device part.  The cooling_device is 
>> explicitly configured to have a max state of
>> MT7915_CDEV_THROTTLE_MAX 
>> (=99), so the thermal subsystem will probably prevent 
>> mt7915_thermal_set_cur_throttle_state from being called with a
>> higher 
>> value.  It will also probably complain if get_cur_state starts
>> returning 
>> values above MT7915_CDEV_THROTTLE_MAX.
>> 
>> And, as the comment below indicates, the thermal subsystem expect
>> that a 
>> higher state provide more cooling.  So if 99 means "maximum
>> cooling", 
>> 100 cannot mean "disable cooling".
>> 
>> Also, last time I tried, thermal_protect_disable didn't work; It
>> didn't 
>> disable anything, the previous thermal throttle kept being applied. 
>> Maybe a new firmware fixed this, but the kernel cannot simply expect
>> the 
>> firmware to be up to date.
>> 
> 
> Thanks for your comments. Let me give you an example to confirm with
> you if I understand your comments correctly.
> 
> 1. The current cooling state of the cooling device is 50 (cur_state =
> 50).
> 2. The cooling state is set to 100 for "disable cooling".
> 3. The thermal subsystem decides to decrease state because the rest of
> system is cooler. And then it will adjust it downward based on
> cur_state, which is 100. For example, thermal subsytem set cur_state to
> 90. But obviously this will make the performance worse than at step 1,
> even though the system is cooler. The design for 100 mean "disable
> cooling" will mess up the thermal governor.
> 
> Let me know if there is any misunderstanding. And I will remove the
> first change of this patch.

This is pretty much my second point.

The other case is if the system is overheating a lot and the kernel bumps the 
state from e.g. 80 to 100, then the system should not disable throttling.

> 
>> > 2. Throttle state do not need to be different from the previous
>> > state.
>> > This will make it is impossible for users to just change the
>> > trigger/restore temp but not the throttle state.
>> 
>> The throttle state is mostly set by the kernel's thermal governor
>> and 
>> the user has only very little control over it.  The thermal governor 
>> runs every X seconds and will change the state if it thinks it is
>> too 
>> low or too high.
>> 
>> The default step_wise governor will aggressively set it to zero if
>> the 
>> system isn't overheating, for example.
>> 
> 
> I don't think there is any conflict between your comment and second
> change. If we keep the check that previous cooling state shall be
> different from the new cooling state, this will bother users who only
> wants to change the temp1_crit but not the cur_state. It is
> unreasonable for the user, if they wants the new temp1_crit to take
> effect in the firmware, they must set a differnt cooling state.

The point I wanted to make is that the kernel sets the throttle state a lot, and 
I assumed that it could also do it even if the state does not change, which 
would send unnecessary mcu commands. But it's apparently not the case.

Also, if the user changes temp1_crit or temp1_max, the changes should probably 
be applied immediately instead of expecting the user to change the state afterward.
