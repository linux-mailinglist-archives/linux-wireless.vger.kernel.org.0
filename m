Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73342C3114
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfJAKRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 06:17:39 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58778 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJAKRj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 06:17:39 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFFDt-000558-MI; Tue, 01 Oct 2019 12:17:37 +0200
Message-ID: <f40bd542d0d13f5be701de41b8870b0bd1f34230.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with
 a better moving average
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Tue, 01 Oct 2019 12:17:36 +0200
In-Reply-To: <20190929154646.90901-2-nbd@nbd.name>
References: <20190929154646.90901-1-nbd@nbd.name>
         <20190929154646.90901-2-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> This change replaces the EWMA implementation with a moving average that's
> designed to significantly reduce lag while keeping a bigger window size
> by being better at filtering out noise.
> 
> It is only slightly more expensive than the simple EWMA and still avoids
> divisions in its calculation.
> 
> The algorithm is adapted from an implementation intended for a completely
> different field (stock market trading), where the tradeoff of lag vs
> noise filtering is equally important. It is based on the "smoothing filter"
> from http://www.stockspotter.com/files/PredictiveIndicators.pdf.
> 
> I have adapted it to fixed-point math with some constants so that it uses
> only addition, bit shifts and multiplication
> 

Would it be worth pulling that out into similar helpers to EWMA in
average.h, perhaps even in the same file?

You need to keep a bit more state, but essentially the same API should
work since EWMA already declares the "struct ewma_something" once you
use the DECLARE_EWMA().

johannes

