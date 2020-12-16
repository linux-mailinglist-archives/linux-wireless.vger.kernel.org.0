Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF962DC802
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 21:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgLPUzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 15:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgLPUzg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 15:55:36 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05815C061794
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:54:56 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kpdoz-00AGh6-Fp; Wed, 16 Dec 2020 21:54:53 +0100
Message-ID: <400936f158c59a25758ca05503c271710100476f.camel@sipsolutions.net>
Subject: Re: [PATCH 1/7] net/fq_impl: bulk-free packets from a flow on
 overmemory
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Wed, 16 Dec 2020 21:54:52 +0100
In-Reply-To: <20201216204316.44498-1-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
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
> +static int fq_flow_drop(struct fq *fq, struct fq_flow *flow,
> +			fq_skb_free_t free_func)
> +{
> +	unsigned int packets = 0, bytes = 0, truesize = 0;
> +	struct fq_tin *tin = flow->tin;
> +	struct sk_buff *skb;
> +	int pending;
> +
> +	lockdep_assert_held(&fq->lock);
> +
> +	pending = min_t(int, 32, skb_queue_len(&flow->queue) / 2);
> 

Why 32?

johannes

