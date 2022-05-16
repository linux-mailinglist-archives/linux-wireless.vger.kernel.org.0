Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A09528A34
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiEPQXa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbiEPQX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 12:23:29 -0400
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985028E3A
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 09:23:26 -0700 (PDT)
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 23E5C200FA;
        Mon, 16 May 2022 18:23:25 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 1FDD9200D9;
        Mon, 16 May 2022 18:23:25 +0200 (CEST)
Message-ID: <c4bf5262bc250afd9c9e52248f1b576a7882c8d4.camel@freebox.fr>
Subject: Re: [PATCH] ath10k: fix misreported tx bandwidth for 160Mhz
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 16 May 2022 18:23:25 +0200
In-Reply-To: <87o7zx4fue.fsf@kernel.org>
References: <cd2735a40da7f4fcc5323e3fca3775e7b5402ece.camel@freebox.fr>
         <87o7zx4fue.fsf@kernel.org>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 16 18:23:25 2022 +0200 (CEST)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Mon, 2022-05-16 at 19:11 +0300, Kalle Valo wrote:

Hello Kalle,

> On what ath10k hardware and afirmware version did you test this? I
> can add that to the commit log.
> 

QCA9984 
10.4-3.10-00047

-- 
Maxime



