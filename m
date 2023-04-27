Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736C16F050B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 13:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbjD0Lci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbjD0Lch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 07:32:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB34EF3;
        Thu, 27 Apr 2023 04:32:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1przrT-0002AB-CO; Thu, 27 Apr 2023 13:32:31 +0200
Message-ID: <4a50726a-8a8e-b224-85e8-c97f3f0a3c87@leemhuis.info>
Date:   Thu, 27 Apr 2023 13:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: deadlock (on 6.1.21+) and lockdep warnings (in 6.2) when using a
 MT7610U chip as AP
To:     Greg KH <gregkh@linuxfoundation.org>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682595155;b5c648f0;
X-HE-SMSGID: 1przrT-0002AB-CO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi! I noticed a report about a regression (hang due to a deadlock with
mt76x02u_pre_tbtt_work when using a MT7610U chip as AP) that according
to the reporter started with 6.1.21; 6.2 and 6.3 work, but there
lockdep warnings occur.

There thus apparently is at least one bug in a stable tree that might or
might not be caused by a backported change that leads to the lockdep
warnings in later series.

But the reporter apparently doesn't care about 6.1.y anymore and plans
to move to 6.3. Hence the reporter afaics has no interest in bisecting
the problem on 6.1.y. But maybe some of you care or even have an idea
what's causing this. For details see:

https://bugzilla.kernel.org/show_bug.cgi?id=217341

Ciao, Thorsten
