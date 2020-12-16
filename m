Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8167B2DC813
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 22:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgLPVAL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 16:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgLPVAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 16:00:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC86C061794
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:59:30 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kpdtR-00AGpM-1O; Wed, 16 Dec 2020 21:59:29 +0100
Message-ID: <3980921a9276b9d38b12651e40590118f1d65609.camel@sipsolutions.net>
Subject: Re: [PATCH 4/7] net/fq_impl: do not maintain a backlog-sorted list
 of flows
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Wed, 16 Dec 2020 21:59:27 +0100
In-Reply-To: <20201216204316.44498-4-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
         <20201216204316.44498-4-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-12-16 at 21:43 +0100, Felix Fietkau wrote:
> 
> +	u32 *flows_bitmap;

> +	fq->flows_bitmap[idx / 32] &= ~BIT(idx % 32);

> +	for (base = 0; base < fq->flows_cnt; base += 32) {
> +		u32 mask = fq->flows_bitmap[base / 32];

This all seems a little awkward, why not use unsigned long * and
<linux/bitops.h>?

The &=~ BIT() thing above is basically __clear_bit() then, the loops
later are basically for_each_set_bit() if I'm reading things right.

> +	if (!flow->backlog) {
> +		if (flow != &tin->default_flow)
> +			fq->flows_bitmap[idx / 32] |= BIT(idx % 32);

That could be __set_bit()

> +	fq->flows_bitmap = kcalloc(DIV_ROUND_UP(fq->flows_cnt, 32), sizeof(u32),
> +				   GFP_KERNEL);

And that would just use BITS_TO_BYTES()?

johannes

