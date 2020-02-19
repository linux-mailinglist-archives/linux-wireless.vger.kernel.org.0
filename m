Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA3164B89
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2020 18:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSRHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 12:07:37 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:44246 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgBSRHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 12:07:37 -0500
X-Greylist: delayed 1032 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2020 12:07:36 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=jfq8UvnZJuTZ8vevahCGDMf60ZB6TPKgjdk5IIPKZCM=;
        b=JQMzAeGVRfANsFfYYi1Nkydb7aBbbIp4kqNccEeTGs8IQhTsCeeyM8R6koLWBMmnTFHUd9BqLYapTzLV99VrfchJQsvw39vQLLOghoNjw3tNLQKR/ucoO8CVvD3RKEERd9HvVqpt7TNDExljBg9cyS/QGjkMmdv99o1QJZBOnRI=;
Subject: Re: [PATCH 5/5] mt76: enable Airtime Queue Limit support
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20200127181754.2810-1-nbd@nbd.name>
 <20200127181754.2810-5-nbd@nbd.name> <875zgqfoqu.fsf@toke.dk>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <aca37dcb-c76d-d239-0d0e-61b73afc5d8f@dd-wrt.com>
Date:   Wed, 19 Feb 2020 17:50:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zgqfoqu.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:a100:bc98:54af:e24d:41b5]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1j4SVq-00077O-6h; Wed, 19 Feb 2020 17:47:50 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

nope (iperf3 with 32 parallel streams after 5 seconds of running)

STA 30:24:32💿f9:c4 AC 2 txq pending airtime underflow: 4294967208, 88
Modules linked in: fast_classifier mt7615e mt76 mac80211 compat
CPU: 3 PID: 1890 Comm: hostapd Not tainted 4.14.171 #187
Stack : 00000000 00000001 00000040 8007e454 80490000 8048bc8c 80610000 
805aee78
         8058850c 8770b864 870f289c 805f07a7 80582204 00000001 8770b808 
805f60a8
         00000000 00000000 80650000 00000000 81147bb8 0000011e 00000007 
00000000
         00000000 80660000 80660000 68203a6d 80000000 80610000 00000000 
873079ec
         873a4654 00000775 00000000 00000001 00000000 80230b88 0000000c 
8065000c
         ...
Call Trace:
[<800153a0>] show_stack+0x58/0x100
[<80438c54>] dump_stack+0xa4/0xe0
[<80035050>] __warn+0xe4/0x144
[<80034c8c>] warn_slowpath_fmt+0x30/0x3c
[<873079ec>] _616+0x110/0x214 [mac80211]
[<87301ce0>] _535+0x15c/0x4f8 [mac80211]
[<804224f0>] br_handle_frame_finish+0x4e0/0x524
[<873d5160>] _49+0x50/0xa4 [mt76]
[<87606e30>] _61+0x1e8/0x224 [mt7615e]

Am 01.02.2020 um 13:58 schrieb Toke Høiland-Jørgensen:
> Felix Fietkau <nbd@nbd.name> writes:
>
>> It is supported by all drivers
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Nice!
>
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
>
>
