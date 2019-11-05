Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11173EFAE7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 11:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfKEKW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 05:22:57 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59822 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbfKEKW4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 05:22:56 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iRvzB-0001Vo-Lb; Tue, 05 Nov 2019 11:22:53 +0100
Message-ID: <867302d58d3183ce7e2c7afa846027a787579b87.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v2 0/2] add Wide Band Scan support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Tue, 05 Nov 2019 11:22:52 +0100
In-Reply-To: <00d301d593c2$bd37d8f0$37a78ad0$@codeaurora.org>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
         <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
         <00d301d593c2$bd37d8f0$37a78ad0$@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-11-05 at 15:51 +0530, Sathishkumar Muruganandam wrote:
> > Neither of these are scan use cases (at least not that are covered by
> > nl80211 scan APIs), so that doesn't make sense.
> > 
> 
> Actually we had extended the existing 'iw scan' command to do Wide
> Band Scan using nl80211 scan APIs.

Yes ... but ... that doesn't address my question.

How is this related to scanning? It sounds to me like you're just
(ab)using scan as a somewhat convenient "do some channel hopping" API
...

johannes

