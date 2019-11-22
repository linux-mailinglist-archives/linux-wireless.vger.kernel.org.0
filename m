Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E88107268
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKVMrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:47:55 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44968 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKVMrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:47:55 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY8Lm-0003Ux-C3; Fri, 22 Nov 2019 13:47:50 +0100
Message-ID: <b63d3a8fe2f586872629710b79f8cf16b48b467c.camel@sipsolutions.net>
Subject: Re: [PATCHv8 1/6] nl80211: New netlink command for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 13:47:48 +0100
In-Reply-To: <8849a80626630876aa3e09ed2c9ef24b@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <1572957714-16085-2-git-send-email-tamizhr@codeaurora.org>
         <e131cd2251fc022f8bef91882c03e85b4a9f4243.camel@sipsolutions.net>
         <8849a80626630876aa3e09ed2c9ef24b@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-11-13 at 21:30 +0530, Tamizh chelvam wrote:
> I thought of resetting it through "NL80211_TX_RATE_AUTOMATIC". Are you 
> okay with that ?

"automatic" can also be a legitimate non-reset option though, right? If
all stations are fixed to 10 dBm, then setting one station to automatic
is still a difference?

I think I'd prefer this whole reset to be handled independent of the
type of value/attribute, like I described earlier with a "reset bitmap"
or so.

johannes

