Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8AF116276
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2019 15:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLHOyG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 09:54:06 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:34412 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLHOyG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 09:54:06 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1idxwh-00CujX-VQ; Sun, 08 Dec 2019 15:54:04 +0100
Message-ID: <8ab8cbc0af8b758bc0d0265d687595bf6be155c5.camel@sipsolutions.net>
Subject: Re: [[PATCH mac80211] 1/1] ieee80211: mesh: handle secured PREQ
 frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hari Nagalla <hnagalla@gmail.com>
Cc:     linux-wireless@vger.kernel.org, maitalm@ti.com
Date:   Sun, 08 Dec 2019 15:54:02 +0100
In-Reply-To: <20191208130750.5402-1-hnagalla@gmail.com> (sfid-20191208_140814_301905_A2A23493)
References: <20191208130750.5402-1-hnagalla@gmail.com>
         (sfid-20191208_140814_301905_A2A23493)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-12-08 at 07:07 -0600, Hari Nagalla wrote:
>  
> +static inline bool ieee80211_is_not_group_privacy(struct ieee80211_hdr *hdr)
> +{
> +	if (ieee80211_is_action(hdr->frame_control)) {
> +		u8 *category;
> +
> +		/*
> +		 * Action frames, excluding Public Action frames, are Robust
> +		 * Management Frames. However, if we are looking at a Protected
> +		 * frame, skip the check since the data may be encrypted and
> +		 * the frame has already been found to be a Robust Management
> +		 * Frame (by the other end).
> +		 */

I think you copy/pasted that comment a bit too blindly :)

Maybe inverting the function ("is" vs. "is not") would make sense?

johannes


