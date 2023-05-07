Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF186F9CA7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 01:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjEGXPu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 May 2023 19:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGXPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 May 2023 19:15:49 -0400
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 May 2023 16:15:47 PDT
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [IPv6:2a00:d70:0:e::317])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429855A6
        for <linux-wireless@vger.kernel.org>; Sun,  7 May 2023 16:15:47 -0700 (PDT)
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1pvnVY-000ESo-Nt;
        Mon, 08 May 2023 01:09:36 +0200
Received: from dynamic-145-014-211-090.glattnet.ch ([145.14.211.90] helo=[192.168.33.151])
        by asmtp012.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1pvnVY-000A5f-GA;
        Mon, 08 May 2023 01:09:36 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Message-ID: <52b5b940-62ae-fd57-349f-0ebaf5f44397@reto-schneider.ch>
Date:   Mon, 8 May 2023 01:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
Content-Language: en-US, de-CH
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
From:   Reto Schneider <code@reto-schneider.ch>
In-Reply-To: <20230428150833.218605-1-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vs-State: 0
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Martin,

On 28.04.23 17:08, Martin Kaistra wrote:
 > This series intends to bring AP mode support to the rtl8xxxu driver,
 > more specifically for the 8188f, because this is the HW I have.

Awesome work, thanks a lot!

I have access to and will try getting AP mode working on the RTL8192CUS 
by filling in the gen1 implementation parts.

If someone is already working on gen1 support, please let me know. Same 
if there are know pitfalls I might encounter. :)

Kind regards,
Reto
