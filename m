Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA6EDFC0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 13:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfKDMLx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 07:11:53 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:36034 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfKDMLx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 07:11:53 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iRbD5-0002Bt-14; Mon, 04 Nov 2019 13:11:51 +0100
Message-ID: <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/2] add Wide Band Scan support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Mon, 04 Nov 2019 13:11:49 +0100
In-Reply-To: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-11-04 at 17:39 +0530, Sathishkumar Muruganandam wrote:
> Wide Band Scan allows to perform off-channel scan on requested channel/
> frequency along with corresponding phy mode/bandwidth (40Mhz, 80Mhz).
> 
> Below are use cases of Wide Band Scan,
> 
> 1. In case of phy running both AP and monitor vifs, wide band scan on
>    a different channel along with phymode (40Mhz, 80Mhz) captures
>    those off-channel data frames to monitor vif.
> 
> 2. Doing wide band scan instead of normal 20Mhz scan before spectral
>    dump, allows to fetch FFT reports for the complete requested
>    bandwidth (40Mhz, 80Mhz).

Neither of these are scan use cases (at least not that are covered by
nl80211 scan APIs), so that doesn't make sense.

johannes

