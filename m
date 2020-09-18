Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4026FB6A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIRLZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRLZp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 07:25:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F8C061788
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 04:25:35 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJEWD-006DmL-Mz; Fri, 18 Sep 2020 13:25:33 +0200
Message-ID: <cff3474685590bbc9663f970bb0a4a10143d3913.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: support HE rate configuration in 6 GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Sep 2020 13:25:32 +0200
In-Reply-To: <1600276451-3259-1-git-send-email-rmanohar@codeaurora.org>
References: <1600276451-3259-1-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-09-16 at 10:14 -0700, Rajkumar Manoharan wrote:
> Allow HE-MCS, HE-GI, HE-LTF in 6 GHz band as well and allow only
> MCS rates in 6 GHz.

This doesn't apply at all, please respin.

Thanks,
johannes

