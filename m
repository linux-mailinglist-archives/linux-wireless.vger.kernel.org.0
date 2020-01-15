Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DA13BE10
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 12:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgAOLB5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 06:01:57 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:36754 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOLB5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 06:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=/yNqb9mNX2aa7p3BpsJ6Q0ZmpZbnWdJqonVkibVheHU=;
        b=tlyJNvpbzg1Sk6i7q3qGNuENaKfnmlb9U9lvpcOHPCRGKEacRMGn2YM0/Uu8uIRYNGkQLKe9oLpNozcSNieCNxnVtqoz/q0TZcwsf8HA4ybcGnwuN2BFOSOgM7mncu+t1HEiEVg8ycftxlfVX+dpAvQkAiTDgHDUCnsypHka0jM=;
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD
 cards
To:     Denis Kalashnikov <denis281089@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
References: <20200110132142.7737-1-denis281089@gmail.com>
 <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
 <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
 <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
 <CAKoLU8MRzBaB9AS0--vCG01hKhBrdzB8=42A+vMv9X39ZAPZLQ@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <28f78f20-b415-4046-674f-070ad6c43f44@newmedia-net.de>
Date:   Wed, 15 Jan 2020 12:01:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKoLU8MRzBaB9AS0--vCG01hKhBrdzB8=42A+vMv9X39ZAPZLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2a01:7700:8040:300:7c62:13d9:a138:3248]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1irgP4-0000f6-29; Wed, 15 Jan 2020 12:00:02 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>> read MAC OUI any apply only to mikrotik ones?

checking subvendor and subdevice id is usefull. mikrotik has special 
values here

the R11e-2HPnD card has

subvendor 0x19b6

subdevice 0xd016

