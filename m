Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717CE88A25
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 10:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfHJIuX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 04:50:23 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59536 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfHJIuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 04:50:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hwN4v-0000Tr-Ft; Sat, 10 Aug 2019 10:50:21 +0200
Date:   Sat, 10 Aug 2019 10:50:18 +0200
In-Reply-To: <CAJSNYx0k7k8RyRT6siC1xv_0xqf3ggKSwNp7sp9c7y-kOgSeAg@mail.gmail.com> (sfid-20190810_061249_170256_0906C3BF)
References: <CAJSNYx0k7k8RyRT6siC1xv_0xqf3ggKSwNp7sp9c7y-kOgSeAg@mail.gmail.com> (sfid-20190810_061249_170256_0906C3BF)
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Unaligned Memory Access on mesh_*.c files
To:     Guo Wei Lim <limguowei@gmail.com>, linux-wireless@vger.kernel.org
From:   Johannes Berg <johannes@sipsolutions.net>
Message-ID: <64EA957F-B24A-4B1C-AAC0-B51790F47E9E@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On August 10, 2019 6:07:15 AM GMT+02:00, Guo Wei Lim <limguowei@gmail.com> wrote:
>I have traced a large number of unaligned memory access on mips cpu
>due to ether_addr_equal(), is_multicast_ether_addr(),
>is_broadcast_ether_addr() being called on odd addresses.
>
>Even though the values are u8, the inlines in etherdevice.h converts
>them to u16 causing the issue.
>
>I can replace ether_addr_equal() with ether_addr_equal_unaligned() but
>it doesn't seem like a proper fix. Anyone has better ideas?

Can you say which places cause this,and which driver you're using? Also, I guess the type of frame and what address format it has would be good to know. 

If you aren't also hitting the warning in rx.c about alignment though, it might be that we do in fact need to use code not expecting alignment.

johannes
-- 
Sent from my phone. 
