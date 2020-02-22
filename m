Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12150169035
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgBVQRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 11:17:47 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:34096 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBVQRr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 11:17:47 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j5XTN-0015Y5-O0; Sat, 22 Feb 2020 17:17:45 +0100
Message-ID: <8a1516685201cc25cdcb8ac0016e0b5f30401f2f.camel@sipsolutions.net>
Subject: Re: [PATCH 1/7] cfg80211: More error messages for key addition
 failures
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 22 Feb 2020 17:17:44 +0100
In-Reply-To: <20200222132548.20835-1-jouni@codeaurora.org>
References: <20200222132548.20835-1-jouni@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-02-22 at 15:25 +0200, Jouni Malinen wrote:
> 
> -	if (!err)
> +	if (err)
> +		GENL_SET_ERR_MSG(info, "key not allowed");
> +	if (!err) {
>  		err = rdev_add_key(rdev, dev, key.idx,

[...]

Had to read this twice, but I don't see any reason not to put an else
there? :)

I can fix it up later when I apply it.

Thanks, btw, BIGTK was definitely something we were also looking into
now.

johannes

