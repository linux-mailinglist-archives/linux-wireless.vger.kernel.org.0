Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADF362E68
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhDQHv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 03:51:27 -0400
Received: from mail.ovgu.de ([141.44.1.66]:57276 "EHLO mail.ovgu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235685AbhDQHv0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 03:51:26 -0400
Received: from [192.168.0.198] (wh5-67.st.uni-magdeburg.de [141.44.165.67])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.ovgu.de (Postfix) with ESMTPSA id 16964A020E;
        Sat, 17 Apr 2021 09:51:00 +0200 (CEST)
Subject: Re: Adding a fifth edca tx queue
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        linux-wireless@vger.kernel.org
References: <fae3f300-8e04-d9ec-8e22-a401aaa6f70a@st.ovgu.de>
 <CAHNKnsSrQvGwhm6q3xjw41xMx7LaYzg0eaOZ2OVaDMdpUfO9gg@mail.gmail.com>
From:   Johannes Behrens <johannes.behrens@st.ovgu.de>
Message-ID: <ef799d04-fb23-e74a-0dbf-da60f9dfb0d7@st.ovgu.de>
Date:   Sat, 17 Apr 2021 09:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHNKnsSrQvGwhm6q3xjw41xMx7LaYzg0eaOZ2OVaDMdpUfO9gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.04.21 12:34, Sergey Ryazanov wrote:
> Hello Johannes,
>
> On Thu, Apr 15, 2021 at 5:19 PM Johannes Behrens
> <johannes.behrens@st.ovgu.de> wrote:
>> currently I am planning to implement a fifth edca tx-queue in the kernel
>> for research purposes for special requirements on the tactile internet.
>>
>> Now I am facing the challenge that I cannot find any actual hardware on
>> which I can implement another queue. Do you have any tips for me there?
>>
>> I have already dug through the code of some drivers of Linux, but
>> usually it fails because of the firmware of the WIFI chipsets, which
>> does not support this.
> Did you look at the ath9k driver for Atheros AR9xxx chipsets? These
> chips support only .11a/b/g/n, but they are still a great choice for
> MAC research due to the possibility to reprogram many aspects of
> channel access.
>
Thank you for pointing this out. I have already looked at the ath9k and
ath5k drivers. Theoretically, it should be possible to freely configure
and use up to 10 (ath9k) tx queues there. However, my hope is to find
more modern chipsets (.11ac).

Regards Johannes

