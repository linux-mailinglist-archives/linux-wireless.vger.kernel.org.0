Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492B52DD173
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 13:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLQMVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 07:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQMVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 07:21:13 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA155C061794
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 04:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c5SVE9vNjPb1ccgOJYbuS4CNDbGkaJ9U7nzvokb8k6I=; b=maLTxpimeLepnizAcvf002mnfD
        BFNFEzLw/GAU8l19VzS1wvrjuuAs0mYXYB4zp+RucJJsO7/DpZsrBcoQSBREQRTdXbGxowk8hSTlj
        SiNOJgll3blEVioKSLPpwDtAHK3R0Uyps3Km05TgFkxL2vjpTI3IpEaUJlY5250PYFcg=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpsGU-0000rI-F3; Thu, 17 Dec 2020 13:20:14 +0100
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name> <87czz8bqbj.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
Message-ID: <add3d1fa-c2ad-5aaf-83c7-31e919129bbf@nbd.name>
Date:   Thu, 17 Dec 2020 13:20:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87czz8bqbj.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-12-17 12:54, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> Depending on the source, a hardware calculated hash may not provide the
>> same level of collision resistance.
> 
> This seems like it would have performance implications?
> 
> Also, this can potentially discard information from tunnels that
> preserve the hash before encapsulation (we added support for this to
> Wireguard which had some nice effects on queueing of encapsulated
> traffic).
If the hash was calculated in software using the flow dissector, it will
be preserved, even if it went through a few virtual interfaces.
The only hashes discarded are hardware generated ones.

- Felix
