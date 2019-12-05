Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF201146D1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfLESWj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 13:22:39 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59734 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESWi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 13:22:38 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icvlt-004OBP-3x; Thu, 05 Dec 2019 19:22:37 +0100
Message-ID: <5ee08008c0cc631be52cc6986708c8437556265f.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 05 Dec 2019 19:22:36 +0100
In-Reply-To: <d8a745a7b0658c65b7e1beb12a9e2e1918cc77c7.camel@sipsolutions.net> (sfid-20191205_190901_620536_8019A905)
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <CAPB2EAong6X2_gazqJUxs968Kb9EG3Eob2TcSJwCcuMP2p9-7w@mail.gmail.com>
         <d8a745a7b0658c65b7e1beb12a9e2e1918cc77c7.camel@sipsolutions.net>
         (sfid-20191205_190901_620536_8019A905)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-12-05 at 19:08 +0100, Johannes Berg wrote:

> Hmm. Actually, I wonder why I'm not seeing TSO, something to check
> tomorrow.

No, I confused myself, of course we're seeing TSO, was looking at the
UDP log :)

Now though why don't we build A-MSDUs for UDP here? But I'm not really
looking at UDP right now :)

johannes

