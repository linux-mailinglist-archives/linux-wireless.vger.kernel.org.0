Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC52A946B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgKFKgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFKgC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:36:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245EC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 02:36:02 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kaz68-002EPA-Rp; Fri, 06 Nov 2020 11:36:00 +0100
Message-ID: <9a043fdcf1c6324688f4c92b18f31c267969f5fc.camel@sipsolutions.net>
Subject: Re: [PATCH v3 v3] mac80211: 160MHz support per IEEE802.11ax standard
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <shay.bar@celeno.com>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Date:   Fri, 06 Nov 2020 11:35:59 +0100
In-Reply-To: <20201019132616.32286-1-shay.bar@celeno.com>
References: <20201019063921.4335-1-shay.bar@celeno.com>
         <20201019132616.32286-1-shay.bar@celeno.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-10-19 at 16:26 +0300, Shay Bar wrote:
> According to the new IEEE802.11ax standard center frequency of the 160MHz
> should be published in segment2 field of HT operation IE when using EXT NSS
> (when supporting smaller number of NSS in VHT in 160MHz BW).
> This patch adds the required support to mac80211, cfg80211 to parse it properly
> according to the new style as appears in the new standard.
> 
> According to the new style, the AP should publish that its bw is 80MHz and not
> 160MHz.
> A STA should conclude that an AP is working in 160MHz if it publishes
> the center frequency of the 160MHz bandwidth in seg1 field of VHT operation IE
> or seg2 field of HT operation IE.

Is this referring to D6.2 Table 26-9 "Setting of the VHT Channel Width
and VHT NSS at an HE STA transmitting the OM Control subfield"?

If so, then what does the part of "at an HE STA transmitting the OM
Control subfield" do? Do we need to check it? That doesn't sound like we
should apply any changed logic to normal VHT STAs?

johannes

