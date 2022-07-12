Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E77A571268
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 08:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiGLGpq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 02:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiGLGpp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 02:45:45 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33433DF1D;
        Mon, 11 Jul 2022 23:45:42 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb71.dynamic.kabel-deutschland.de [95.90.235.113])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6ACB261EA192D;
        Tue, 12 Jul 2022 08:45:39 +0200 (CEST)
Message-ID: <a0de2973-4666-e8eb-019b-2ea6c9c98a0a@molgen.mpg.de>
Date:   Tue, 12 Jul 2022 08:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [REGRESSION] hci0 hci_power_on [bluetooth] blocks for more than 2
 min preventing suspend and shutdown
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <db3b4f30-cd32-fa24-5ed0-038d4925860f@molgen.mpg.de>
 <CABBYNZKibt14eHLFMUre9CZ+XNmUvsh_BNaDz+LzDtHB0NMBDQ@mail.gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        regressions@lists.linux.dev
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZKibt14eHLFMUre9CZ+XNmUvsh_BNaDz+LzDtHB0NMBDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

#regzbot introduced: ff7f2926114d3a50f5ffe461a9bce8d761748da5
#regzbot fixed-by: e36bea6e78ab2b6c9c7396972fee231eae551cfc


Dear Luiz,


Am 12.07.22 um 05:05 schrieb Luiz Augusto von Dentz:

> On Mon, Jul 11, 2022 at 12:14 PM Paul Menzel wrote:

>> On a Dell Latitude E7250 with
>>
>>        Bus 001 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless interface
>>
>> with Debian sid/unstable upgrading from Linux 5.18.5 to 5.19-rc4 results
>> in a regression, where the system does not suspend or does not power
>> off. Linux logs earlier:
>>
>> ```
>> [  242.677813] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  242.677818] task:kworker/u9:1    state:D stack:    0 pid:  379 ppid:      2 flags:0x00004000
>> [  242.677831] Workqueue: hci0 hci_power_on [bluetooth]

[…]

> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/commit/?id=e36bea6e78ab2b6c9c7396972fee231eae551cfc

Ah, thank you. Sorry for the noise then.


Kind regards,

Paul
