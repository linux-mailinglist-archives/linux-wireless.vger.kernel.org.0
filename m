Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1D65FFF7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 13:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjAFMKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 07:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjAFMJ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 07:09:59 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692572880
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 04:09:57 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MoOty-1oPLhz2b0q-00orbA; Fri, 06 Jan 2023 13:09:47 +0100
Message-ID: <a223d9ba-2b80-6b6d-dcad-2ca2b170b393@i2se.com>
Date:   Fri, 6 Jan 2023 13:09:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        regressions@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
References: <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com>
Content-Language: en-US
In-Reply-To: <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:g3tV1p0WF14EizaFDJBnScjtGownkQ7etGXqx6UJXLikhYLx+gX
 JwecoZ68bvP4j3+cmZVDZvPhN+qVfnnul7nynz40ktAXL3oVobGqV/7UmDG/FHrDcKG8N5a
 HYDRfcctgaN6I1YSmIlqo+gsQkippqf/2RdGUFp6Pg9CaV0eru1VDXURXmCVVfJ1U0V7ewb
 gFyCNC5zqizbMe1zndtJw==
UI-OutboundReport: notjunk:1;M01:P0:1O4PS6DEEi4=;kmfbHw9TjY2L6SqaIfCb9kLb8Xk
 6zC459BVJyLaYSiRwijxD3wLD3bBKMfLotBUmuYwnc7H3JhioLj5jInIVpLD+kjzFqMnechMP
 bYtmgz9k2Q6IzIeet2fs3VpZQFcxLAKDENE/YtLUUIaHqrB6CfKGKAfnj2x5CUAUfl05IUo16
 DnqRF9kmbpmj4E28JB5xB6DlVplfEPR02rVepcZo3ow3vehKi8IpEi/xZkOxvwQVbJjJ4cAd6
 rp8wAHR9Hd1tfw+xJsmGlIA41EzzZdCaDpGh9Yo/lusv6Xo0h66FvrU9Ik2QB+W9Ie3Spndib
 y3CBFo3LFsKDHKPScn1mDugj/jnWA28JXHCoUnL0qCuNG93958V9bbA5Oa9zFUKJOCC+Ulef1
 tA2OWhGFC5TYzLOXwIUPt9ozzCf3FH5JGGZfYL8NJe3sosA6yACO8yBwIvLrTirjtFXhCJveX
 ImalPykPlvJ//ImYKSzPpDkYPJ8O0izdG/7hKbwGRd6LKOgdxGfFTKMi6OqG6J1w299UmNQyq
 K8A4+NxoZb2oOCA0oHMsqTont+7YUShU7X3LrRA8fz12hznBnkM3UOVvyMXEloX1uwk3JMO2h
 u4+SH21nu5VvRXdK37wNQY7clqr8ldKb9nRXEVPHgsCU/pioJkUehk8NAPPa8IXu0ahOsDsHj
 WcAfxf+JDc2tCwNpSWqEM20gKUEJtahSVlwU27yhcA==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Peter,

Am 31.12.22 um 12:11 schrieb Stefan Wahren:
> Hi Peter,
>
> could you please provide a "bad case" file list of all firmware files 
> for the Raspberry Pi 3 B+ which worked before Linux 6.1, so i can 
> reproduce it?
>
> Also OpenSuSE seems to be affected [1].

Ivan send out a fix, which should also work for Fedora [2].

Best regards

[2] - https://lore.kernel.org/all/20230106072746.29516-1-iivanov@suse.de/

>
> [1] - https://bugzilla.suse.com/show_bug.cgi?id=1206697
>
> Regards
> Stefan
>
