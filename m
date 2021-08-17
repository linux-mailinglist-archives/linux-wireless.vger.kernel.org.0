Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C73EEDC8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhHQNyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhHQNyt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 09:54:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B3C061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Vu1TXcfH3DvBTTcz1EmP1TUDxly89rGPQJPnroBTIB8=;
        t=1629208456; x=1630418056; b=UHI+LAZvUJW6VHosMsjWw/ZAX2n6HBWCtA0CsEan0TYbOde
        PP5w/icqC9o8RtSclPXuymWR4v3KSQwa1qR8TUlCzA6EPI/uiEB224qX2gFnkT/tgf/oTdvHpBwd3
        QPFNY74ApEXX+k9pYA735ZvibozX9wE/wV8fDbyTM3Qy/SJFzZOnHdTa/+H1E+Q4MD8tZMs6r9Ugu
        m9bYJhPYNfN7ktnOe3s+EGjh1L4PLM91ap1q0B7/RHBfBTYXcd0sPd+rUMzuGn5H5Z0tKVNdn9VtT
        NqiJjlahFght8hZgLRKYLmBQOpK49AoETvuhlghy0oA9IxFcGzwt5PrywdonSa1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFzXi-00CHfm-IS; Tue, 17 Aug 2021 15:54:14 +0200
Message-ID: <ec979481036ad198d4c42d2756caf66fd3496bbc.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: Handle driver updated MU-EDCA params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 17 Aug 2021 15:54:13 +0200
In-Reply-To: <1628660743-24413-1-git-send-email-msinada@codeaurora.org>
References: <1628660743-24413-1-git-send-email-msinada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-08-10 at 22:45 -0700, Muna Sinada wrote:
> Add necessary functions and attributes to receive updated MU-EDCA
> parameters from driver and send to user space, where management
> frame are updated to reflect latest parameters.
> 

On second thought - this really could use some more explanation?

Why are MU-EDCA parameters determined by the driver? What does this
actually do? Is it meant for AP mode, or client mode? Any spec
references?

Mac80211 parses this coming from the AP, so probably this is meant for
AP mode, but why? Why wouldn't hostapd determine the correct parameters?

etc.

johannes

