Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2442011E152
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLMJ6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:58:13 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:45534 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMJ6N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:58:13 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ifhi6-009eZZ-RF; Fri, 13 Dec 2019 10:58:11 +0100
Message-ID: <fd7b4cb48f3510d81d227ae8020c3b6c46f4a4b0.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] mac80211: Sync airtime weight sum with per AC
 synced sta airtime weight together
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org
Date:   Fri, 13 Dec 2019 10:58:09 +0100
In-Reply-To: <1576221593-1086-5-git-send-email-yiboz@codeaurora.org> (sfid-20191213_082437_402312_070F042E)
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
         <1576221593-1086-5-git-send-email-yiboz@codeaurora.org>
         (sfid-20191213_082437_402312_070F042E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


I'm going to assume that Toke will review all of this and there will be
changes, so you'd resend anyway ...

> - * @airtime_weight: station weight for airtime fairness calculation purposes
> + * @airtime_weight: station per-AC weight for airtime fairness calculation
> + * purposes

If you do, please replace the "*<space>purposes" by "*<tab>purposes" :-)

(otherwise I can just fix that myself too, but ...)

johannes

