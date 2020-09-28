Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939F827ACAB
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI1LYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1LYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:24:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3EBC061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:24:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMrGi-00CRxy-UQ; Mon, 28 Sep 2020 13:24:33 +0200
Message-ID: <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap
 power save
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 13:24:22 +0200
In-Reply-To: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org> (sfid-20200824_102705_778778_5CF18948)
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
         (sfid-20200824_102705_778778_5CF18948)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
> AP power save feature is to save power in AP mode, where AP goes
> to power save mode when no stations associate to it and comes out
> of power save when any station associate to AP.

Why do you think this requires a vendor command? I mean, that seems like
fairly reasonable - even by default - behaviour? And if not done by
default, it could possibly even be configured via the normal powersave
mode/command we already have in nl80211, or by a new normal one?

Why does it even require an nl80211 setting, seems like something you'd
really only want to turn off for debugging (e.g. via debugfs)?

johannes

