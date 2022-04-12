Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5665B4FE247
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 15:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiDLNX4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355904AbiDLNWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 09:22:17 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD311E9
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 06:12:02 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23CDBrGX009519;
        Tue, 12 Apr 2022 22:11:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Tue, 12 Apr 2022 22:11:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23CDBqW1009516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Apr 2022 22:11:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
Date:   Tue, 12 Apr 2022 22:11:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 09/10] staging: wfx: ensure HIF request has been sent
 before polling
Content-Language: en-US
To:     Jerome Pouiller <jerome.pouiller@silabs.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com>
 <20220225112405.355599-10-Jerome.Pouiller@silabs.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220225112405.355599-10-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello.

I found that commit c86176d51340d5ee ("staging: wfx: ensure HIF request has
been sent before polling") started using flush_workqueue(system_highpri_wq).

But please avoid flushing system-wide workqueues, for
flushing system-wide workqueues is dangerous and will be forbidden.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp

