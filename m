Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2E55369A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 17:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353143AbiFUPsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 11:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353162AbiFUPsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 11:48:20 -0400
Received: from 9.mo576.mail-out.ovh.net (9.mo576.mail-out.ovh.net [46.105.56.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16646BC85
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 08:48:18 -0700 (PDT)
Received: from player746.ha.ovh.net (unknown [10.110.103.180])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 5342D23575
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 15:28:58 +0000 (UTC)
Received: from galgus.net (86-127-225-236.digimobil.es [86.127.225.236])
        (Authenticated sender: jesus.manzano@galgus.net)
        by player746.ha.ovh.net (Postfix) with ESMTPSA id 69F041E73F8C4;
        Tue, 21 Jun 2022 15:28:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G0011089bdc4-1693-4846-8e01-d25de9a4e602,
                    14DB0BF606E187386CEFFBBE484AA2084A70D6C3) smtp.auth=jesus.manzano@galgus.net
X-OVh-ClientIp: 86.127.225.236
Message-ID: <212d978d-3b70-1382-4c97-bbe79905aba6@galgus.net>
Date:   Tue, 21 Jun 2022 17:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ath11k: fix number of VHT beamformee spatial streams
Content-Language: en-US
To:     Sipos Csaba <dchardware@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20220616173947.21901-1-jesus.manzano@galgus.net>
 <CALQr=E8S6gt_UjaP7GS3M0Tn-MGg7-Xs03Q3suuV7=OP4XmiEQ@mail.gmail.com>
 <fd68f826-8e38-cbfd-87cc-720a2a3b1530@galgus.net>
 <CALQr=E8BNQB0vG2AXqfuUmbOKKCXZR7MFBxAc72db00QTiVPTw@mail.gmail.com>
From:   =?UTF-8?Q?Jes=c3=bas_Fern=c3=a1ndez_Manzano?= 
        <jesus.manzano@galgus.net>
In-Reply-To: <CALQr=E8BNQB0vG2AXqfuUmbOKKCXZR7MFBxAc72db00QTiVPTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16409428195330355519
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeffedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfgvshprshgphfgvrhhnjohnuggviigpofgrnhiirghnohcuoehjvghsuhhsrdhmrghniigrnhhosehgrghlghhushdrnhgvtheqnecuggftrfgrthhtvghrnhepfeeiueeltdfghfegfffgkedtfeefgfduuddvkeekleevieehieelveevfeeghffgnecukfhppedtrddtrddtrddtpdekiedruddvjedrvddvhedrvdefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeegiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjvghsuhhsrdhmrghniigrnhhosehgrghlghhushdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejie
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

El 21/6/22 a las 14:06, Sipos Csaba escribió:
> I am not sure if you noticed, that when you do uplink heavy tests on
> AX, in the current state uplink power is grossly fluctuating reported
> by the driver, while the RF environment is static. I am not sure if
> this issue with BF will fix it, but sure it sounds plausible. It is
> also unknown how the driver calculates RX power per client: does it
> uses some sort of reference signal, or the calculated power depends on
> traffic volume?

Hi Csaba,

Yes I noticed the same issue in heavy iperf3 uplink tests. But that was 
happening to me with firmware 2.4, now with 2.5 and the latest 
board-2.bin it works like a charm. Maybe you need some more patches in 
ath11k? I am using a combination of upstream patches from recent kernels 
and some qca patches. If you want, we can discuss the topic outside the 
mailing list to not spam other people.

Regards,
Jesus.

