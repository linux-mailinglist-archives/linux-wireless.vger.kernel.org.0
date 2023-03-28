Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE46CBE20
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjC1Lv4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 07:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1Lvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 07:51:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1143049ED
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 04:51:54 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ph7rg-0000Gi-TL; Tue, 28 Mar 2023 13:51:48 +0200
Message-ID: <6a77b86c-5336-133d-a060-1310a0408de2@leemhuis.info>
Date:   Tue, 28 Mar 2023 13:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH wireless] wifi: mt76: mt7921: fix fw used for offload
 check for mt7922
Content-Language: en-US, de-DE
To:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@kernel.org
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
References: <632d8f0c9781c9902d7160e2c080aa7e9232d50d.1679997487.git.lorenzo@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <632d8f0c9781c9902d7160e2c080aa7e9232d50d.1679997487.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680004314;39cdbbbc;
X-HE-SMSGID: 1ph7rg-0000Gi-TL
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28.03.23 12:01, Lorenzo Bianconi wrote:
> Fix the firmware version used for offload capability check used by 0x0616
> devices. This path enables offload capabilities for 0x0616 devices.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217245
> Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Please add a

Cc: stable@vger.kernel.org

To ensure this is backported to the 6.2 series (a fixes tag is not
guaranteed to suffice).

Ciao, Thorsten
