Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE1303067
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 00:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbhAYV2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 16:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbhAYV2K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 16:28:10 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64ABC0613D6
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IiIgcihf+vDeEYvFbcFaAjZl1H6cIZ6l85tufId8xY4=; b=jYRnTlsZfsF+s7oepmwWq7Da+x
        ZXhJUGRK3xlvOtRfiA35846iDcP6aa2XeFqWNEEEGLWw8EjijiFTejGCbCN53qRSskEoksTBbd+OT
        y/+Y9T3UvzrXIfHnLd4MCjTljBIPCfyYHEJ1tFqA9DIOKXO3kPM3fSW8GNr7UWsbY9Ic=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l49OD-0007EG-B2; Mon, 25 Jan 2021 22:27:13 +0100
Subject: Re: [PATCH 4/6] mac80211: minstrel_ht: significantly redesign the
 rate probing strategy
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20210124122812.49929-1-nbd@nbd.name>
 <20210124122812.49929-4-nbd@nbd.name> <87o8hdmdqs.fsf@toke.dk>
 <3ac94bcf-4c76-9c1e-c903-0810d2067b3a@nbd.name> <87eei8d86d.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <76519c4a-9653-1c53-2b25-09b3c500c999@nbd.name>
Date:   Mon, 25 Jan 2021 22:27:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <87eei8d86d.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-01-25 22:21, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> On 2021-01-25 12:56, Toke Høiland-Jørgensen wrote:
>>> Felix Fietkau <nbd@nbd.name> writes:
>>>> With this approach, we finally get a very small delta in throughput when
>>>> comparing setting the optimal data rate as a fixed rate vs normal rate
>>>> control operation.
>>> 
>>> Can you quantify this "very small delta"? Would love to see some
>>> benchmark data :)
>> Based on a quick test it seems to be around 5% (sometimes less) at VHT80
>> MCS6 nss=4 with ~350 mbit/s TCP throughput. I guess I might be able to
>> bring that down even further, once I optimize it some more.
> 
> Cool! And pre-patch?
Some users reported more than 30%

- Felix
