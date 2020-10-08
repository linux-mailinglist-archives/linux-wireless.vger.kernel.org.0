Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF862870D3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgJHIjK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 04:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgJHIjJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 04:39:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49A5C061755
        for <linux-wireless@vger.kernel.org>; Thu,  8 Oct 2020 01:39:09 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQRS7-001UWo-U5; Thu, 08 Oct 2020 10:39:08 +0200
Message-ID: <39d5d6f1a5dad25d20a45c46dffdcd45cd28286e.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] mac80211: initialize last_rate for S1G STAs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 08 Oct 2020 10:39:02 +0200
In-Reply-To: <20201005164522.18069-2-thomas@adapt-ip.com>
References: <20201005164522.18069-1-thomas@adapt-ip.com>
         <20201005164522.18069-2-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-10-05 at 09:45 -0700, Thomas Pedersen wrote:
> last_rate is initialized to zero by sta_info_alloc(), but
> this indicates legacy bitrate for the last TX rate (and
> invalid for the last RX rate). To avoid a warning when
> decoding the last rate as legacy (before a data frame
> has been sent), initialize them as S1G MCS.

Oh, I see, this fixes the warning ...

OK, never mind, I'll just apply both.

johannes

