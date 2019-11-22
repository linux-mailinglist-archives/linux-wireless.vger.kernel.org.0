Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67657107647
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfKVRPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:15:33 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48258 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:15:33 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iYCWq-0001EC-0J; Fri, 22 Nov 2019 18:15:32 +0100
Message-ID: <ac6a65a46747b76a73b53a5807e9633601c7d473.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] mac80211_hwsim: set rx_status mactime/flag for
 wmediumd path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 18:15:28 +0100
In-Reply-To: <20191122170612.8123-2-prestwoj@gmail.com> (sfid-20191122_180916_945714_8FE84206)
References: <20191122170612.8123-1-prestwoj@gmail.com>
         <20191122170612.8123-2-prestwoj@gmail.com>
         (sfid-20191122_180916_945714_8FE84206)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 09:06 -0800, James Prestwood wrote:
> This patch sets the required rx_status mactime and flags in order for
> the parent TSF value to be calculated and sent to userspace. This is
> already done elsewhere, but this patch allows this to work for the
> wmediumd code path.
> 

:)

Now you just need a s-o-b.

johannes

