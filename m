Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5D67BDF
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfGMT6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 15:58:40 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:40476 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfGMT6j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 15:58:39 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hmOAH-0004eP-Hb; Sat, 13 Jul 2019 21:58:37 +0200
Message-ID: <0112d5d6a0c83dbb800811b414ca1d5b3266e9dd.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: add IEEE80211_KEY_FLAG_PUT_MMIE_SPACE to
 ieee80211_key_flags
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Date:   Sat, 13 Jul 2019 21:58:35 +0200
In-Reply-To: <1dd6dd782121d0b9cc32dec6a01db474e568ffb2.1563030033.git.lorenzo@kernel.org>
References: <1dd6dd782121d0b9cc32dec6a01db474e568ffb2.1563030033.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-07-13 at 17:03 +0200, Lorenzo Bianconi wrote:
> Add IEEE80211_KEY_FLAG_PUT_MMIE_SPACE flag to ieee80211_key_flags in order
> to allow the driver to notify mac80211 to allocate mmie space for AES_CMAC
> hw cipher. Moreover mac80211 will set MMIE pn while MIC will be computed
> in hw.

Hmm. It probably should be called something like GENERATE_MMIE in line
with GENERATE_IV_MGMT etc.?

Purely adding the *space* wouldn't really be all that useful, we're not
really going to apply our tailroom request to this since it's a
(relatively rare) mgmt. frame, so ...

johannes

