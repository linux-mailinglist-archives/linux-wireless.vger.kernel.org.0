Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599BF1E463D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbgE0OnN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388506AbgE0OnN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:43:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD5C05BD1E
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 07:43:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdxGx-004ARu-8i; Wed, 27 May 2020 16:43:11 +0200
Message-ID: <0923c23ea6157a140eee855beaff436ea69e6e1f.camel@sipsolutions.net>
Subject: Re: [PATCH v3 06/11] mac80211: handle HE 6 GHz Capability in HE STA
 processing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 27 May 2020 16:43:10 +0200
In-Reply-To: <1589399105-25472-6-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-6-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-13 at 12:45 -0700, Rajkumar Manoharan wrote:
> During association or mesh peering of HE STA in 6 GHz band, required
> HT/VHT information has to be processed from 6 GHz band capabilities
> as HT/VHT IEs are not allowed in 6 GHz.
> 
>   * @has_he: true iff HE data is valid.
> + * @has_he_6ghz: true iff HE 6 GHz data is valid.

I guess here things start compiling ;-)

But like I said before, I'm not sure why this is needed?

Surely if the STA connected on 6 GHz it has capability ...

johannes

