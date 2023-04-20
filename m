Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3146E93EF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjDTMNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjDTMNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:13:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1BE59C6
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A11A06282B
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D57C433EF;
        Thu, 20 Apr 2023 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681992794;
        bh=2BKR3UhDK1E2h5WRNrJ3jYoywm1lljSOCAo0hZC/kGQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=k2EtE19S7IlBnEXe6dnVZyq4mQPhOc3bDqKVWZBHTPWTZT/+Pbh63nQ6OMxK/Llqg
         iy4dgrfm0nIkaki+eJACT7nTIivXk84nrv4KpNj5PBEmSe3gXcBO55+EzZVKsusduF
         Z2d4GYX8AMySJia97uzBdtt9xfWjMz3rWv8A06HNAaREBq1SRaAJTodcxT/vFuIQ8t
         6/CD0m0tDJVjpks/hk7HTt5H9XlBVKfEjwIZIkqtL9ZLQ/LPp6Bk0zK00e6Gj+V6zH
         r+3qStuuYDwBooG3UnPS5bN43ZEfoKXOe/k3uNjmy3gINVIx6bqj932NXHR8OU1iIt
         6coA8UYymR03Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] ath11k: factory test mode support
References: <20230420113653.1686-1-quic_rajkbhag@quicinc.com>
        <825cf403-b833-beff-02d4-cf8fbab89eb0@quicinc.com>
Date:   Thu, 20 Apr 2023 15:13:09 +0300
In-Reply-To: <825cf403-b833-beff-02d4-cf8fbab89eb0@quicinc.com> (Raj Kumar
        Bhagat's message of "Thu, 20 Apr 2023 17:31:25 +0530")
Message-ID: <87r0sevjje.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> On 4/20/2023 5:06 PM, Raj Kumar Bhagat wrote:
>
>> Device is booted in factory test mode to calibrate the board.
>> The commands are sent from a userspace application, which is
>> sent to firmware using wmi commands. Firmware will send the
>> response back to the application which stores the calibration
>> data in caldata.bin file. This file will be loaded when the
>> device boots up normally next time.
>> 
>> Govindaraj Saminathan (3):
>>   wifi: ath11k: remove unused function ath11k_tm_event_wmi
>>   wifi: ath11k: optimize ath11k_tm_cmd_get_version
>>   wifi: ath11k: factory test mode support
>> 
>> Sowmiya Sree Elavalagan (1):
>>   wifi: ath11k: Allow ath11k to boot without caldata in ftm mode
>> 
>> ---
>> v2:
>> - added separate patch for removal of ath11k_tm_event_wmi()
>> - added separate patch for changes in ath11k_tm_cmd_get_version()
>> - removed unused cmd and updated documentation for enum ath11k_tm_cmd
>> - changed warning print to debug print
>> ---
>> 
>>  drivers/net/wireless/ath/ath11k/ahb.c        |   3 +-
>>  drivers/net/wireless/ath/ath11k/core.c       |  20 +-
>>  drivers/net/wireless/ath/ath11k/core.h       |  15 +-
>>  drivers/net/wireless/ath/ath11k/mac.c        |  13 +-
>>  drivers/net/wireless/ath/ath11k/pci.c        |   3 +-
>>  drivers/net/wireless/ath/ath11k/qmi.c        |  10 +-
>>  drivers/net/wireless/ath/ath11k/testmode.c   | 320 ++++++++++++++++---
>>  drivers/net/wireless/ath/ath11k/testmode.h   |  20 +-
>>  drivers/net/wireless/ath/ath11k/testmode_i.h |  16 +
>>  drivers/net/wireless/ath/ath11k/wmi.c        |  40 ++-
>>  drivers/net/wireless/ath/ath11k/wmi.h        |  20 ++
>>  drivers/net/wireless/ath/ath11k/wow.c        |   3 +-
>>  12 files changed, 419 insertions(+), 64 deletions(-)
>> 
>> 
>> base-commit: 12f167f02a1abe2c8817496a902de00758285b92
>
> Please ignore this patch series. Tested-on tag is missing for patches 1/4 and
> 2/4. Will send v3 with correct Tested-on tag.

Please wait, I need to first push back my changes to the pending so that
you can see them.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
