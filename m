Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA8492234
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiARJJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 04:09:01 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:44317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiARJJA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 04:09:00 -0500
Received: from [192.168.0.175] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MVrXh-1midF80UGD-00RnjA; Tue, 18 Jan 2022 10:08:51 +0100
Message-ID: <d7ce90d8-552a-2cab-6310-3a84584172a1@green-communications.fr>
Date:   Tue, 18 Jan 2022 10:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Subject: Issues with mt7915 thermal throttling
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Qr5CwiNn/XjY3kQ9nCKIu+ml7fqRy3rj4T8SQ0M4Mdfm8tHput4
 PLaGaLwI0HWSQm5niKwc4yiQd6BjsXEf53sVCVOyzgj3v/86TeSW6MGQa5MIFvZb+gYGyWR
 yh/bmEyCV1gb8xQQXXCmCCo2ch80un++nXa7KrJaX3ilK9p+loDnNzRVgGY+JRSMOXJMJTc
 uHkOApSIT9Q9qU2/RFksQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+nAOt+982VI=:xS+utZDcbKcdqfzPOdpLHZ
 kJZUx1YcaT0t8ECnVCBhn7jsWwfBkmgHEtXfOY1D9LfKRPEt3Qp7ZCA29E5JBnWKse9BQkkCi
 Hii5LZgiuMyOXBzu1Fb2Ni8nVELxZ9h7d6GRwakYsFhiVQ2Nd4XsKAHaei5CpcH4AYVELG5xr
 3p9OxN357xlpjBwGVxjxBjnGa2h+JvewbMg3uQI6tFGSPbP1TG9igL3JouVhQ9JR2cwW2ZhF2
 zuXO/c3jmA3F75e72mslzeAV5Dxk0auACSK29D1G0KWQZxM/FN2HvcQY+keEuU3I/VyRLJgHR
 z6WDzYmocpwqgv2hfP2Pyv3mgcdGgBpJt9ep8+nQS5mBZ8Da0xk5yD5YquR9di4adbJCMV3jH
 XHPh4/O2Bg5+JXE+IpixP4OeBVK8ShmgEBJjoGcPA8wv/XNYnFXeQZ3QPymITRtR4Up8jRTOY
 K/J8hKd9v37R599LBBF9ynRx+eL3dKnbQG2ud1ViWlP+Z7R4zRJOS+DhdUQZCdRrj0C7XbOsZ
 TTL/lO5MX/+lLffudQFRIUp3Hb/YgmsORp4Hp2ybzGg19hu5TiCgWk4YKJypWhVJtAFLyVFJW
 pAKdCyAQq+OlXniwL9rgXRdg46caG+ncgOqdmMeQiry6OJ6zO10au1qnKGkhaNnYBtK0Z1Nc5
 lNsrm6gGADtKXpZbv+bGJD7QLncgj/zM70/zQ8d2/Ly5cFPcnv/4oK/O37WbOY93jOyJj388T
 Fuwo3kyXHAKf1dqWCo0WbumpbwS3UlV1zindsg==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I noticed some strange issues with mt7915's thermal throttling, 
particularly the cooling_device.

First, it seems that the thermal subsystem expect that higher 
cooling_device states provide more cooling, but mt7915e apparently does 
the opposite and use it as a duty cycle, where state=1 does severe 
throttling/max cooling (iperf throughput basically go down to near zero) 
and state=100 is full power.

Also, state=0, from the comments, apparently disable thermal management, 
except that in practice, it does not change the throttle state, since 
throughput stays low when switching from state=1 to state=0, and stays 
high when switching from 100 to 0.

As a result, as soon as the default thermal zone runs a little hot, the 
performance of mt7915e is destroyed and does not recover much when the 
temperature drops down.

I can come up with a patch to fix the first issue, but not the state=0 
one, and i would like some pointers/confirmation.
