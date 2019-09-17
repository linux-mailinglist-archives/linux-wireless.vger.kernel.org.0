Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDDB47BF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404394AbfIQGzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 02:55:36 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:38092 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbfIQGzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 02:55:35 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iA7OA-0004kY-3e; Tue, 17 Sep 2019 08:55:02 +0200
Message-ID: <dd8ee4a2e5cffa1bb6ab4176a57c2b66d495d3ac.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] mac80211: fix low throughput in push pull mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        linux-wireless-owner@vger.kernel.org
Date:   Tue, 17 Sep 2019 08:55:01 +0200
In-Reply-To: <8e4cd872d082c6bce598c87411a2125f@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
         <1568639388-27291-3-git-send-email-yiboz@codeaurora.org>
         (sfid-20190916_151039_049848_BE125514) <6684ceecde399edeb31c594f889a403440c78142.camel@sipsolutions.net>
         <8e4cd872d082c6bce598c87411a2125f@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-09-17 at 14:36 +0800, Yibo Zhao wrote:
> 
> Do you mean it should be something like:
> 
> Co-developed-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>

Yes, I think you mean the right thing. For the record, it seems to me it
should be

From: A <...>

[...]

Co-developed-by: B <...>
Signed-off-by: B <...>
Signed-off-by: A <...>

or so.

IOW, I think having the same "From:" (which gets preserved in git as
"Author") and "Co-developed-by" makes no sense?

Your "From" line was implied, but I suppose you did mean that From would
be yourself (as it was in the patch) and then the above seems right.

Or you can add a "From: Toke ..." to your patch message and leave the
"Co-developed-by: yourself" I suppose, the difference is in how git will
record it.

johannes

