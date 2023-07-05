Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642A274804C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jul 2023 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGEJBC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jul 2023 05:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGEJBB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jul 2023 05:01:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E60B11F
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1688547637; x=1689152437; i=georgmueller@gmx.net;
 bh=eE7iDryj0JhtvuinY11e+C3/eqvluh4edxR74CI8ga4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=abXcnY+BJSlvOYKb7zvYBIbexHZAZtZOreUYRtrWe8DJmVPYa7Y6pQbn7Ey0zIyxOjQXMjf
 HhcH0SgLuQ0P7gzRm1pDFdLo29VLLhI9iZ9S9O12kNkExiDxq/mZHnP/l2R1hXuqvVCfBY0Fy
 NNhRU11YtMhxqTXLjJLcPM13UQ76DfoOzISHRRCq2VZPdZdHozFCh9JkV8/Xh40Tf0UjoEeU9
 ejaQAUyjFZQPF6xVVjFN1cCvFEwJVMpQOL+w2Lhb5aN8EcNLeXHkbQwNePx/k5Ma6N6+OvVFs
 AcEvvgkH53hixclI2FfGkZ48ErXxm+BjoHeRh9DMB+dmzqgrZxQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.54.0.101] ([87.167.92.240]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1pe0ud2kbK-00nB9c; Wed, 05
 Jul 2023 11:00:37 +0200
Message-ID: <c9e6a13b-e32d-f810-741c-33598956a55e@gmx.net>
Date:   Wed, 5 Jul 2023 11:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
Content-Language: en-US
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
In-Reply-To: <20230428150833.218605-1-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LOnR4dUjEHUTCu+aiQeUOFDZzCSNY9YgjYT1LbYxNP9GsY29IBa
 p30UaGZByWehfR9jL82Sn8EmJVAVwFa+SY0mIbkiw6dnYFQbMI1o6EqtqPjFX4ZdqQ1t90u
 ORFAovMuARqf0hSqEDVWWjf2NNr4fz9920wcrY4pKTR5+6cbl1cz8LG9q6sfZvsMe3GE0ES
 MqpJ4ZTYE1zrcCpj3sHVw==
UI-OutboundReport: notjunk:1;M01:P0:Tc+P2xCtors=;guYMOlmeb0h6P7nPJTH2t4zBnWk
 qj5WOvqYtJ9Ju3feo/DA1npyO7Xc5+N8ohHhignhN04+j4wlZi+Uc7yWorUBi3TEBx+8jof5/
 emS1UzZYsm2L+nCck+Ug0AeYSfJgKBsJcuCMIpci6Jl/Lyaew7GJvgiYIF7xDT1sNyr9tIAcn
 pdOyGs149nji6s7LFaJSO5QwqDXcW4WiIdgoXlTf9U/HGczVUuK8CvV5sHmPmL8/vKe8AdZ+w
 1xase+MB0Ab9DjvpHjTqubUe1zVI+UxRyVzwcVQnGO8j7vDqMRrsI3zBdfoup734cFRdtd8yc
 VAM7FPXwbj2SP3SeIEhQqj7QHvTE4VLefD0dGAsPWNBW3ofOgVdJGrQ+2eAuODlQcl9IvJgfg
 WCH0Q0ejFibqZ6OXoLK5NApvHFBhFpbA1V/2jn/FpHbez4OJzkpomHRhJs2LZt5Nfp16/w7EC
 j4nhdwDTQzwJ0GjxRuGtBMJUuHrDS0vB6nPxSa/AAQ9JQ5Hrkl9LVjMkdkfzPtfoi9ZGK0HoQ
 zm88eD2EiXHWabwxTlWLrts9CcclaYDSShUoNFwRaqTITMUoGd7riwicFbY5rmCZWb5I1HfH5
 AUWweTJm+HZo0KyBFqFyyhJtOto2bssLvxsmi/akbZ4ixH0bUc5bZHeZQ89O9JH2L+62UrBUK
 MLdxdV6AC3a0zcDAeWSpz6HaRYHkfPZ2+uFcDq4dslh4oD8NzuqLZCX2iruPGFGIbeNQI071X
 xZABYpjE0crExT5lRGJHLcwtuf+uBqZgXwIZ9uG+n5rHSG8/+khsLIcHjcHO6s30Xnx4aziMz
 7m0GKXpbMUHzuL9vLWKFHV+J1+Tx8NO6dgC5WB5KriJAXaohkGcvvZcXotZCLEzbE2QPc3rYk
 Z6FFTP1wotV4+Hr98nPCAd68+Zvgl1+zJLIkEsp6dT8X2nsUMBDwWaRlyNNHNRSH5IwLRs0pi
 Vdz0rpu5tDOCvuUrGvxnBk5poIw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Martin,

Am 28.04.23 um 17:08 schrieb Martin Kaistra:
> This series intends to bring AP mode support to the rtl8xxxu driver,
> more specifically for the 8188f, because this is the HW I have.
> The work is based on the vendor driver as I do not have access to
> datasheets.

I tried to enable AP mode for a 8188EU device (TP-Link TL-WN725N) with
some mixed results.

I added .supports_ap = 1 and .max_macid_num = 16 to rtl8188eu_fops.

The AP was visible and I once was able to connect to it. When connected,
the link was stable, but I didn't do any benchmarks.

Most of my tries I was not able to establish a connection (looks like
timeouts) and once I got this message:

     usb 1-4: rtl8xxxu_send_beacon_frame: Failed to read beacon valid bit

The driver I am using currently is the out-of-tree driver rtl8188eu [1],
which has a stable AP mode, but has some stability issues in managed mode.

Please give me a hint if and how I may help tracking down the issue to
enable AP mode for 8188EU as well.

Best regards,
Georg

[1]
https://github.com/lwfinger/rtl8188eu/tree/v5.2.2.4
