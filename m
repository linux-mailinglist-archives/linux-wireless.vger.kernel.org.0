Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF596357F7D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 11:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhDHJjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhDHJjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 05:39:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DBC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 02:39:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUR8H-008wRl-Km; Thu, 08 Apr 2021 11:39:25 +0200
Message-ID: <246a7cca8e90c947e38caa9ddf1d028d9ae10bb7.camel@sipsolutions.net>
Subject: Re: [PATCHv2] mac80211: increment rx stats according to USES_RSS
 flag
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thiraviyam Mariyappan <tmariyap@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Apr 2021 11:39:24 +0200
In-Reply-To: <1613563010-1489-1-git-send-email-tmariyap@codeaurora.org> (sfid-20210217_125904_154301_738B3086)
References: <1613563010-1489-1-git-send-email-tmariyap@codeaurora.org>
         (sfid-20210217_125904_154301_738B3086)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-02-17 at 17:26 +0530, Thiraviyam Mariyappan wrote:
> Currently, rx_stats were updated regardless of USES_RSS flag is
> enabled/disabled. So, updating the rx_stats from percpu pointers
> according to the USES_RSS flag.

I guess I'll fix it this time, but the commit log is still not saying
what it should.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_messages

Please, everyone @codeaurora, pay attention. I don't want to have this
discussion for every patch.

johannes

