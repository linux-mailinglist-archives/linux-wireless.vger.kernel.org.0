Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4915823A1A8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHCJP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 05:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHCJP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 05:15:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD4C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 02:15:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k2WZZ-00FbMm-EY; Mon, 03 Aug 2020 11:15:57 +0200
Message-ID: <f1a40d9caf3b07bffe21f5bf33b2d15c1d3f6769.camel@sipsolutions.net>
Subject: Re: [PATCH V5 2/3] mac80211: add support for setting fixed HE
 rate/gi/ltf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>
Date:   Mon, 03 Aug 2020 11:15:41 +0200
In-Reply-To: <20200803085127.180550-2-john@phrozen.org>
References: <20200803085127.180550-1-john@phrozen.org>
         <20200803085127.180550-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-03 at 10:51 +0200, John Crispin wrote:
> From: Miles Hu <milehu@codeaurora.org>
> 
> With nl80211 now able to receive fixed HE rate/gi/ltf settings we want to
> propagate these further down the stack into the mac80211 drivers. This
> patch copies the values into the sdata struct.

I do not see any reason for this patch, copying data to a mac80211
internal structure and then not using it does ... nothing. Dropped this
patch.

johannes

