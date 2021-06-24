Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270F43B2F4C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFXMsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXMsB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 08:48:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B37DC061574
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 05:45:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lwOjg-00AyxL-5V; Thu, 24 Jun 2021 14:45:36 +0200
Message-ID: <45f7ca548cb62180f90b9960c63c0a1658047da7.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands
 for iwlmei usage
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     Ayala Beker <ayala.beker@intel.com>
Date:   Thu, 24 Jun 2021 14:45:35 +0200
In-Reply-To: <20210623141033.27475-3-emmanuel.grumbach@intel.com> (sfid-20210623_161048_529009_02FD6561)
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
         <20210623141033.27475-3-emmanuel.grumbach@intel.com>
         (sfid-20210623_161048_529009_02FD6561)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-06-23 at 17:10 +0300, Emmanuel Grumbach wrote:
> iwlmei allows to integrate with the CSME firmware. There are
> flows that are prioprietary for this purpose:
> 
> * Get the information the AP, the CSME firmware is connected
>   to. This is useful when we need to speed up the connection
>   process in case the CSME firmware has an TCP connection
>   that must be kept alive across the ownership transition.
> * Forbid roaming, which will happen when the CSME firmware
>   wants to tell the user space not disrupt the connection.
> * Request ownership, upon driver boot when the CSME firmware
>   owns the device.
> 
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
>  include/uapi/linux/nl80211-vnd-intel.h | 80 ++++++++++++++++++++++++++

This was supposed to be submitted separately [1] so people see it more
easily, so *bump* - everyone take a look please.

johannes

[1] https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

   Patches introducing such commands shall be submitted separately, not
   “buried” in big driver patchsets. Give them a “nl80211: vendor-cmd: ”
   prefix to make them easily identifiable.

Though I guess we can debate if this is a "big" patchset :)

