Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4310DFC041
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 07:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfKNGij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 01:38:39 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56366 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNGii (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 01:38:38 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iV8m4-0006TJ-Le; Thu, 14 Nov 2019 07:38:36 +0100
Message-ID: <aa0257b408dc7ad6d5f457ac611e76059549737b.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v2 0/2] add Wide Band Scan support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 14 Nov 2019 07:38:34 +0100
In-Reply-To: <6ea305b2ac09c340181623a23cf4180b@codeaurora.org>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
         <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
         <00d301d593c2$bd37d8f0$37a78ad0$@codeaurora.org>
         <867302d58d3183ce7e2c7afa846027a787579b87.camel@sipsolutions.net>
         <6ea305b2ac09c340181623a23cf4180b@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-11-11 at 13:27 +0530, Sathishkumar Muruganandam wrote:
> 
> > How is this related to scanning? It sounds to me like you're just
> > (ab)using scan as a somewhat convenient "do some channel hopping" API
> > ...
> > 
> 
> Whether this can be used under "iw offchannel" with 
> NL80211_CMD_REMAIN_ON_CHANNEL?

Not sure what you're asking. Are you asking if I would accept wide
channel extensions to R-O-C? That seems more reasonable than for
scanning anyway. Still I guess I'd like to see an actual reason for it.

johannes

