Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA4F26F9B9
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIRJ6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 05:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRJ6L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 05:58:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CBC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 02:58:10 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJD9d-006Avx-0w; Fri, 18 Sep 2020 11:58:09 +0200
Message-ID: <cf87d46f8e4c991b01e47d45be0a0f58c3de02f5.camel@sipsolutions.net>
Subject: Re: [PATCH v4 02/14] mac80211: check and refresh aggregation
 session in encap offload tx
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        John Crispin <john@phrozen.org>
Date:   Fri, 18 Sep 2020 11:58:06 +0200
In-Reply-To: <20200908123702.88454-3-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
         <20200908123702.88454-3-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

++

On Tue, 2020-09-08 at 14:36 +0200, Felix Fietkau wrote:
> Update the last_tx timestamp to avoid tearing down the aggregation session
> early. Fall back to the slow path if the session setup is still running

I'm going to apply this for now, but I suspect that the fallback here is
going to be tricky depending on the hardware - how should that be
handled?

johannes

