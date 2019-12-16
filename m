Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F91201BD
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfLPJ5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 04:57:13 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:42546 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfLPJ5N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 04:57:13 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ign7n-001CrT-Rz; Mon, 16 Dec 2019 10:57:11 +0100
Message-ID: <1a8b7f092969b673c85b21c298f4465b2cce389c.camel@sipsolutions.net>
Subject: Re: [PATCH v2 5/7] mac80211: drop now unused bss_color element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Mon, 16 Dec 2019 10:57:10 +0100
In-Reply-To: <20191213155802.25491-5-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
         <20191213155802.25491-5-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-12-13 at 16:58 +0100, John Crispin wrote:
> With all users of bss_color converted we can drop the old element. Driver
> code should now use the new he_bss_color struct.

I think it'd be OK to squash patches 3-5 together, minimal driver
updates for changing mac80211 API are totally fine and will need to go
via my tree anyway.

johannes

