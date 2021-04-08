Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11892357DD9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhDHIOP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 04:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHIOO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 04:14:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34897C061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 01:14:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUPnb-008ukb-IB; Thu, 08 Apr 2021 10:13:59 +0200
Message-ID: <4f625f7cf6b8a325b128a71bf1805dd7e334cc6b.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] iw: fix ftm_request missing arguments segfault
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Apr 2021 10:13:58 +0200
In-Reply-To: <CAASiZWagFdx+5Nfq383zgJkMcL_T_hqVeWTgPx2ej8J6U=DfLQ@mail.gmail.com> (sfid-20210322_155533_226282_3A77C432)
References: <CAASiZWagFdx+5Nfq383zgJkMcL_T_hqVeWTgPx2ej8J6U=DfLQ@mail.gmail.com>
         (sfid-20210322_155533_226282_3A77C432)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-03-22 at 15:55 +0100, Benjamin Aschenbrenner wrote:
> 
> @@ -282,6 +282,9 @@ static int handle_ftm_req_send(struct
> nl80211_state *state, struct nl_msg *msg,
>      const char *file;
>      int err;
> 
> +    if (argc < 1)
> +        return HANDLER_RET_USAGE;

Something along the line replaced tabs by 4 spaces, so the patches don't
apply. Please resend.

Thanks,
johannes

