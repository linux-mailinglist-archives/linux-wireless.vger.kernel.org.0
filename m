Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC5161480
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 15:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgBQOYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 09:24:48 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:50042 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgBQOYs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 09:24:48 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j3hKI-003EM5-7G; Mon, 17 Feb 2020 15:24:46 +0100
Message-ID: <040f0fd3f209ea2fe4bbea6c754f6004808c1267.camel@sipsolutions.net>
Subject: Re: [RFC 1/2] mac80211: add receive path for ethernet frame format
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Date:   Mon, 17 Feb 2020 15:24:45 +0100
In-Reply-To: <1581942277-585-2-git-send-email-mpubbise@codeaurora.org> (sfid-20200217_132514_136661_63733C38)
References: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org>
         <1581942277-585-2-git-send-email-mpubbise@codeaurora.org>
         (sfid-20200217_132514_136661_63733C38)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-17 at 17:54 +0530, Manikanta Pubbisetty wrote:
> 
> +	/* FIXME: Since rx.seqno_idx is not available for decap offloaded frames
> +	 * rx msdu stats update at the seqno_idx in ieee80211_deliver_skb()
> +	 * will always be updated at index 0 and will not be very useful.
> +	 * Should we disable these statistics in the case of decap offload?
> +	 */
> 

I think the answer is yes.

johannes

