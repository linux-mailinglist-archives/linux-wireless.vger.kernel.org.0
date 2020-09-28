Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D082F27AC96
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1LVY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1LVY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:21:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1DC061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:21:23 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMrDe-00CRtc-6z; Mon, 28 Sep 2020 13:21:22 +0200
Message-ID: <6cc3e6fc2575e3ea2bcf6ac53b8d199f6c2eff21.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: notify non-transmitting BSS of color changes
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Mon, 28 Sep 2020 13:21:16 +0200
In-Reply-To: <20200822153902.4091442-1-john@phrozen.org>
References: <20200822153902.4091442-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-08-22 at 17:39 +0200, John Crispin wrote:
> When a transmitting multiple bssid BSS changes its bss color, we need to
> also notify the non transmitting BSSs of the new bss color.
> 
> This patch depends on the multiple bssid and bss coloring series.

It's probably the second or third time I've tried applying this ...
please resend it with the prerequisites.

johannes

