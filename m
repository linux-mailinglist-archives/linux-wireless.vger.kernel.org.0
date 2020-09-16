Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3226C653
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgIPRpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgIPRpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 13:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C4C061756
        for <linux-wireless@vger.kernel.org>; Wed, 16 Sep 2020 10:45:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kIbUI-0053uW-1k; Wed, 16 Sep 2020 19:44:58 +0200
Message-ID: <e122ae9b058e6f8c7c82d6ebef90517a604a3c64.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: allow bigger A-MSDU sizes in VHT, even if HT
 is limited
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Wed, 16 Sep 2020 19:44:57 +0200
In-Reply-To: <20200916164611.8022-1-nbd@nbd.name>
References: <20200916164611.8022-1-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-09-16 at 18:46 +0200, Felix Fietkau wrote:
> Some APs (e.g. Asus RT-AC88U) have been observed to report an HT MSDU size
> limit of 3839 and a VHT limit of 7991. These APs can handle bigger frames
> than 3839 bytes just fine, so we should remove the VHT limit based on the
> HT capabilities. This improves tx throughput.

I'm not really convinced that we can do this, since we don't track
HT/VHT limits separately.

IOW, to be behaving according to the AP you mention, we'd have to know
when building an A-MSDU whether it's going to use HT or VHT rates, but
we don't track that at all ...

johannes

