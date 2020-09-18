Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4326F9FB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIRKLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRKLF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:11:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB7C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:11:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDM7-006BQO-Gq; Fri, 18 Sep 2020 12:11:03 +0200
Message-ID: <5f03909aa3ac34700c08aa87077b2ddc1d2e3be7.camel@sipsolutions.net>
Subject: Re: [PATCH v4 05/14] mac80211: rework tx encapsulation offload API
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Fri, 18 Sep 2020 12:10:58 +0200
In-Reply-To: <20200908123702.88454-6-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
         <20200908123702.88454-6-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-08 at 14:36 +0200, Felix Fietkau wrote:
> The current API (which lets the driver turn on/off per vif directly) has a
> number of limitations:
> - it does not deal with AP_VLAN
> - conditions for enabling (no tkip, no monitor) are only checked at
>   add_interface time
> - no way to indicate 4-addr support
> 
> In order to address this, store offload flags in struct ieee80211_vif
> (easy to extend for decap offload later). mac80211 initially sets the enable
> flag, but gives the driver a chance to modify it before its settings are
> applied. In addition to the .add_interface op, a .update_vif_offload op is
> introduced, which can be used for runtime changes.
> 
> If a driver can't disable encap offload at runtime, or if it has some extra
> limitations, it can simply override the flags within those ops.
> 
> Support for encap offload with 4-address mode interfaces can be enabled
> by setting a flag from .add_interface or .update_vif_offload.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c |  57 +++++----

There were some conflicts here with commit commit aa2092a9bab3 ("ath11k:
add raw mode and software crypto support"), I hope I've fixed that up
appropriately.

johannes

