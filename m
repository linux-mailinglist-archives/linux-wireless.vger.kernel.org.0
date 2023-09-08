Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7135A7983DD
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 10:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjIHIRU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 04:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIHIRU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 04:17:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF81BF5
        for <linux-wireless@vger.kernel.org>; Fri,  8 Sep 2023 01:17:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AE4C433C7;
        Fri,  8 Sep 2023 08:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694161035;
        bh=GIIukkGXSJUknYtMPc52M2adeSs4PcfC3iR01K7fLLs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LvDZyAZSpYPU+uCUdaNrCl++dDO4xatgjj9wsj1lEwArZb3tQxraX1+wyg/PCuCk6
         /T0+EfBh95dgxYPDKN6lLHbmhFPsdqtJ7Jp0JIu/85lgsE8/oEK3H/EyLncciBE+R0
         5cAQ/+ynaDD4Wi3tGahnNF7arkb2m2mcO9Zc3sLYBHXJqy7A9yp4mh7Q5MqEcm/P4S
         C+nCRvGS2ipTqkNMne50XmQQt+Sbusk/2kItMHBKTbjGfRWtFcKbQxye81KyqcAwsT
         W3YZNHEASo4cCJ8Xr0hfasvEGPccSKRyE3Y6yzVjAnhBC4vFpNufTcNsUhSlAda3YA
         aAZfq+2xxxpJw==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Prasurjya.Rohansaikia@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2] wifi: wilc1000: Added back-off algorithm to balance
 tx queue packets.
References: <20230816162259.33342-1-prasurjya.rohansaikia@microchip.com>
        <871qfuvwzd.fsf@kernel.org>
        <DM4PR11MB633677755A94860F2E1B6449F4EEA@DM4PR11MB6336.namprd11.prod.outlook.com>
Date:   Fri, 08 Sep 2023 11:18:42 +0300
In-Reply-To: <DM4PR11MB633677755A94860F2E1B6449F4EEA@DM4PR11MB6336.namprd11.prod.outlook.com>
        (Prasurjya Rohansaikia's message of "Thu, 7 Sep 2023 17:01:35 +0000")
Message-ID: <87cyytm61p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Prasurjya.Rohansaikia@microchip.com> writes:

> <Prasurjya.Rohansaikia@microchip.com> writes:
>
>> From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
>>
>> Added an algorithm to backoff the Tx Task when low memory scenario is
>> triggered at firmware. During high data transfer from host, the firmware
>> runs out of VMM memory, which is used to hold the frames from the host.
>> So added flow control to delay the transmit from host side when there is
>> not enough space to accomodate frames in firmware side.
>>
>> Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
>
> [...]
>
>> -             } while (ret == WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
>> +                     if (ret != WILC_VMM_ENTRY_FULL_RETRY)
>> +                             break;
>> +                     /* Back off from sending packets for some time.
>> +                      * schedule_timeout will allow RX task to run and free
>> +                      * buffers. Setting state to TASK_INTERRUPTIBLE will
>> +                      * put the thread back to CPU running queue when it's
>> +                      * signaled even if 'timeout' isn't elapsed. This gives
>> +                      * faster chance for reserved SK buffers to be freed
>> +                      */
>> +                     set_current_state(TASK_INTERRUPTIBLE);
>> +                     schedule_timeout(msecs_to_jiffies
>> +                                      (TX_BACKOFF_WEIGHT_MS));
>> +             } while (!wl->close);
>
> Why not msleep_interruptible()?
>
> Thanks you for your suggestion. However, I decided to proceed with
> schedule_timeout_interruptible() after testing and I will resubmit the patch. 

You need to provide more information than that.

Please quote your emails properly and don't send HTML emails, our lists
automaticall drop all HTML mail.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
