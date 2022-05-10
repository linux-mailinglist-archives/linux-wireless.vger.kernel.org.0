Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A79522480
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiEJTGu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiEJTGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 15:06:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C536CA81
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=n80jJsqtBE3iI8gk0EvrDbWSD5WPJGgQAeKXe4QIEMY=;
        t=1652209606; x=1653419206; b=ODO6tgkElJAQepcBSjpMrnTO3pxAYGZD69eWyvIK9gc0rpB
        k22RlOBlF6Y0tkoHWXczntIsVK9FPWUJsngFDgw95Ho8Aa1BekwR4vVlpYGyNVxjGCORquaooIGPi
        b5I/ecD6m7CziUKDSgIPFrEfALZpP/e3ozf+ME5Iwe8Lii7tVkhvQTN/H5kb5MY4JOEBMI1bdwQlu
        RPpQGrLH1xfTuNfHuxiGtKBck6Oc6duD5LVcKhDKHJjdocaIRVTGaOPuHwoGML98GQuepImJHACS4
        MnyAEKug73jfmReXwg30uN2gLjy9MF6ERinjv2avnMdt54tChP9zOY9gbb3rqZ1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1noVC0-007vMO-3O;
        Tue, 10 May 2022 21:06:44 +0200
Message-ID: <b900d560d5dabaea1a9faf9d8ff8a019ed813e25.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Simplify queue selection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>,
        Alexander Wetzel <alexander@wetzel-home.de>
Cc:     linux-wireless@vger.kernel.org,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Date:   Tue, 10 May 2022 21:06:43 +0200
In-Reply-To: <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
         <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-10 at 18:10 +0200, Felix Fietkau wrote:
> On 10.05.22 17:58, Alexander Wetzel wrote:
> > Let iTXQ drivers also register four queues in netdev and move queue
> > assignment to ndo_select_queue(), like it's done for other drivers.
> > 
> > This gets rid of a special case in mac80211 and also increases the
> > chance that when we call skb_get_hash() the skb is still hot in the CPU
> > buffers.
> > 
> > Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> 
> This has the disadvantage of requiring a redundant sta lookup in the tx 
> path for iTXQ drivers. I think the CPU cost of that one is probably 
> higher than any potential gain from calling skb_get_hash a bit earlier.
> 

However, that's independent - we can still calculate the hash there, and
then bail out, i.e. put it right before the "if (wake_tx_queue) return"
part, no?

OTOH we don't even need the hash in the other cases, do we?

johannes
