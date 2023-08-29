Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F178C852
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbjH2PLS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjH2PLS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 11:11:18 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 08:11:10 PDT
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90609B5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 08:11:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:542b:0:640:97a7:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id A88D75EC71;
        Tue, 29 Aug 2023 18:03:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id o3SX2WDDY4Y0-6J6TcNPr;
        Tue, 29 Aug 2023 18:03:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=filimonic.net; s=mail; t=1693321432;
        bh=MBf4911WHoOIemy4BRbylsaQiFKI7AASD9DHXoJdoY8=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=F/m23RXsvbogd5EMZyFLm3KDuowi3Tk5sW4leleDYuQL5iVzmSKY4BS3E3r32yIRZ
         69okdPxh6Lgoo7nM5XaFlr/LVilHvy0rgq6gAcZVRMZENUQQOa/YJvaJxsaq8E6w0Z
         WNPttdksjKxblS1AhuQam2xS6Pv6TfWrvOwYVo+8=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@filimonic.net
Message-ID: <58cbe52d-0093-eef7-fa9f-4d5b2fc904c5@filimonic.net>
Date:   Tue, 29 Aug 2023 18:03:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] wifi: mt76: add ability to explicitly forbid LED
 registration with DT
To:     Kalle Valo <kvalo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <b08ef4d7c91c54e273c61784272e5c6f70c3c137.1692896654.git.ryder.lee@mediatek.com>
 <87edjmtkr0.fsf@kernel.org>
Content-Language: en-US
From:   Alexey <alexey@filimonic.net>
In-Reply-To: <87edjmtkr0.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_CSS_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DT specification 4.0, section "2.3 Standard Properties":
 > DTSpec specifies a set of standard properties for device nodes

DT specification 4.0, paragraph "2.3.4 status":
 > The status property indicates the operational status of a device.
 > The lack of a status property should be treated as if the property 
existed with the value of "okay".

On 2023-08-29 09:39, Kalle Valo wrote:
> Ryder Lee <ryder.lee@mediatek.com> writes:
>
>> Add ability to explicitly forbid LED registration using DT led\status = "disabled".
>>
>> Tested-by: Alexey D. Filimonov <alexey@filimonic.net>
>> Signed-off-by: Alexey D. Filimonov <alexey@filimonic.net>
>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Is this a generic Device Tree feature and already documented in DT
> bindings?
>
