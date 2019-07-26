Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8EC7641C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGZLGo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 07:06:44 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47286 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZLGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 07:06:44 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqy3f-0001Xs-Km; Fri, 26 Jul 2019 13:06:43 +0200
Message-ID: <0cc7d0c578b60730e77ecd03e2df240dd1b393a0.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: reject zero MAC address in add station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Jul 2019 13:06:42 +0200
In-Reply-To: <1563959770-21570-1-git-send-email-periyasa@codeaurora.org>
References: <1563959770-21570-1-git-send-email-periyasa@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-24 at 14:46 +0530, Karthikeyan Periyasamy wrote:
> Don't allow using a zero MAC address as the station
> MAC address. so validated the MAC address using
> is_valid_ether_addr.

Theoretically, all zeroes might have been a valid address at some point.
I see no reason not to reject it, but I'd like to know why you ended up
with this now??

johannes

