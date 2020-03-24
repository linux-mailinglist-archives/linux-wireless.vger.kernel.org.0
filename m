Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF133190DBE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 13:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgCXMg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 08:36:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44728 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCXMg4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 08:36:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGind-005BCH-V8; Tue, 24 Mar 2020 13:36:54 +0100
Message-ID: <b578b872537a28762593dd4695aab2968d5b3fcc.camel@sipsolutions.net>
Subject: Re: Simulate Radio wave interference
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masashi Honma <masashi.honma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Mar 2020 13:36:52 +0100
In-Reply-To: <66d63510-7a41-a99e-14b9-0db32a4f61ce@gmail.com> (sfid-20200324_105525_696682_C09F54CC)
References: <fb4be9f4353193a789e4a6cdc4b35c096d2efd7f.camel@sipsolutions.net>
         <8f783032-8999-18aa-5980-8a87427fddd8@gmail.com>
         <1a1f5c11f51c4c2fe2a5e82e32e431986f88bddb.camel@sipsolutions.net>
         <66d63510-7a41-a99e-14b9-0db32a4f61ce@gmail.com>
         (sfid-20200324_105525_696682_C09F54CC)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

>  > I think from a timing aspect, checking if two signals are in phase will
>  > be practically impossible - we're talking about less than 1us timing
>  > differences (0.2 at 5 GHz), if I'm doing the math correctly?
> 
> I do not mean just in phase or opposite phase. Of course it could not
> be happened in real world.
> 
> I mean two or more radio waves composes a mixed wave.
> 
> Refer attached pictures.

Sure, but that's even worse? You need significantly less than
microsecond granularity to take this effect into account, and then you'd
have to probably also take distance into account for propagation time
etc.?

Anyway, I don't have a problem with the old model and don't have a need
for a different (even if perhaps better) one. Really what I'm mostly
thinking about is the MAC vs. air stuff, see my other email.

johannes

