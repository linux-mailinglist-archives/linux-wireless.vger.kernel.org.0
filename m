Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A266A33
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfGLJmy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 05:42:54 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55818 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGLJmx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 05:42:53 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hls4p-00079u-VK; Fri, 12 Jul 2019 11:42:52 +0200
Message-ID: <9a1d7a6651d3bf6c4a43c5bc8659df690c009328.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/3] mac80211/ath11k: HE mesh support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        hostap@lists.infradead.org
Date:   Fri, 12 Jul 2019 11:42:51 +0200
In-Reply-To: <2019422.XptUlqRJNA@bentobox>
References: <20190612193510.29489-1-sven@narfation.org>
         <1610842.TRhm9evnVP@bentobox>
         <06c7c1a2c8d0f955cb107475d17587c156fb19de.camel@sipsolutions.net>
         <2019422.XptUlqRJNA@bentobox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-12 at 11:36 +0200, Sven Eckelmann wrote:
> 
> There is already a workaround for that in the hostap testcases:
> 
>     if all_cap_one:
>         # It looks like tshark parser was broken at some point for
>         # wlan.mesh.config.cap which is now (tshark 2.6.3) pointing to incorrect
>         # field (same as wlan.mesh.config.ps_protocol). This used to work with
>         # tshark 2.2.6.
>         #
>         # For now, assume the capability field ends up being the last octet of
>         # the frame.

> But maybe you already spotted the problem - it requires that mesh 
> configuration element is the last element. Which is not the case here - 
> similar to 5GHz tests (where you have most likely a VHT cap/oper element 
> after the meshconf_ie).
> 
> I hope that this makes more sense now.

Ah, yes, it does. So I guess we need to update/fix that workaround. And
I guess newer tshark (which you used) is fixed again, if I understand
correctly?

johannes

