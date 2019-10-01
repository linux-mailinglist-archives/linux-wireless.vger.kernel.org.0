Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04801C31FC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfJALGV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:06:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59826 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJALGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:06:20 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFFz1-0006CO-1x; Tue, 01 Oct 2019 13:06:19 +0200
Message-ID: <8017042b74a05df72a7ebfb5ec21fc7cc088ed4e.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with
 a better moving average
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Tue, 01 Oct 2019 13:06:18 +0200
In-Reply-To: <017c1a59-edf2-0a1a-aa8c-3c32e57d6cd0@nbd.name>
References: <20190929154646.90901-1-nbd@nbd.name>
         <20190929154646.90901-2-nbd@nbd.name>
         <f40bd542d0d13f5be701de41b8870b0bd1f34230.camel@sipsolutions.net>
         <017c1a59-edf2-0a1a-aa8c-3c32e57d6cd0@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-01 at 12:52 +0200, Felix Fietkau wrote:
> 
> Might be useful, yes. The main issue here is that the period / window
> size has to be hardcoded through the coefficient values, unless we find
> a way to do floating point math, including exp() and cos() at compile
> time, including conversion to fixed point.

Works fine for me?

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#define E(x) ((int)(exp(x) * (1<<20)))
#define C(x) ((int)(cos(x) * (1<<20)))

int main()
{
        int e2 = E(2);
        int c2 = C(2);

        printf("e2: %d\n", e2);
        printf("whole: %d frac: %d\n", e2 >> 20, e2 & ((1 << 20) - 1));
        printf("c2: %d\n", c2);
        printf("sign: %s whole: %d frac: %d\n", c2 < 0 ? "-" : "", abs(c2) >> 20, abs(c2) & ((1 << 20) - 1));
}

objdump -dr test:
[...]
0000000000401040 <main>:
  401040:	48 83 ec 08          	sub    $0x8,%rsp
  401044:	be 92 39 76 00       	mov    $0x763992,%esi		// exp(2) * (1<<20)
  401049:	bf 10 20 40 00       	mov    $0x402010,%edi
  40104e:	31 c0                	xor    %eax,%eax
  401050:	e8 db ff ff ff       	callq  401030 <printf@plt>
  401055:	ba 92 39 06 00       	mov    $0x63992,%edx
  40105a:	be 07 00 00 00       	mov    $0x7,%esi
  40105f:	31 c0                	xor    %eax,%eax
  401061:	bf 2b 20 40 00       	mov    $0x40202b,%edi
  401066:	e8 c5 ff ff ff       	callq  401030 <printf@plt>
  40106b:	be 77 57 f9 ff       	mov    $0xfff95777,%esi
  401070:	bf 18 20 40 00       	mov    $0x402018,%edi
  401075:	31 c0                	xor    %eax,%eax
  401077:	e8 b4 ff ff ff       	callq  401030 <printf@plt>
  40107c:	b9 89 a8 06 00       	mov    $0x6a889,%ecx		// cos(2) * (1<<20)
  401081:	31 d2                	xor    %edx,%edx
  401083:	31 c0                	xor    %eax,%eax
  401085:	be 20 20 40 00       	mov    $0x402020,%esi
  40108a:	bf 22 20 40 00       	mov    $0x402022,%edi
  40108f:	e8 9c ff ff ff       	callq  401030 <printf@plt>
[...]

johannes

