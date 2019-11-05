Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10748F0201
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbfKEP6W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 10:58:22 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:38484 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfKEP6W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 10:58:22 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iS1Dp-0002Ob-Ak; Tue, 05 Nov 2019 16:58:21 +0100
Message-ID: <6db5847262bce0691dbe3e0c4df04a4996770e0e.camel@sipsolutions.net>
Subject: Re: [PATCH] net/fq_impl: Switch to kvmalloc() for memory allocation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 05 Nov 2019 16:58:19 +0100
In-Reply-To: <8736f2jp0o.fsf@toke.dk>
References: <20191105154951.546285-1-toke@redhat.com>
         <0690b548e233fba3758df0ce1eeca1c0803a62c4.camel@sipsolutions.net>
         <8736f2jp0o.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-11-05 at 16:56 +0100, Toke Høiland-Jørgensen wrote:
> 
> Oh, right, of course; silly me. Guess I was a bit too trigger-happy on
> the nice one-character patch ;)
> 

I guess two characters is still pretty good ;)

johannes

