Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5F9851E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 22:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfHUUEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 16:04:40 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:32916 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730101AbfHUUEk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 16:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1566417879; bh=FhEuM75JSwv2f3jUUulqO/7P8r95SVUv1s3Mlq52qjE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From;
        b=LwyMrXVYxTkDtfgPdz/9JxA90egj9V+WuItC6vMLRgf/Hq2c1QcTUHkVlpAgHQWVg
         tpF/WlRxAoSp5akzet0m9BH222fVqTBPmSVzJpEB/avdAbQF3j64TMHFQuAn2jrrDk
         UCDzZKjIYbCAQwnmw4n5WtwkSU/k9BjZFbDmh6lSLUmNvDRmWGS3kKhuspRGEWIrUL
         woyc8zjnFz/v7PAZVN8R9pNqkfbfOP8L+0NjNvGVFwPnu8qrxCCZd0cs+xvSLsozT9
         NaIKxiGQSBiVLkXf3u2NNKflU27ZjdVAENGmNvKrNnpfhfAtOg8vijFAZ6Gt20qRSC
         HaJUcc1if5Bow==
Date:   Wed, 21 Aug 2019 22:04:37 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain> <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de> <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain> <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de> <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain> <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net> <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain> <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Implementing Mikrotik IE
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
From:   Josef Miegl <josef@miegl.cz>
Message-ID: <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 19, 2019 10:21:55 PM GMT+02:00, Johannes Berg <johannes@sipsoluti=
ons=2Enet> wrote:
>I don't know, try capturing over the air?
>
>Perhaps the vendor IEs added this way are added *first* before all the
>RSN IEs, and that's tripping up your AP, and you'd have to add them
>*after* the normal elements? Not really sure where/how they're added?
>
>johannes

The vendor elements are added at the very end of the frame=2E In fact I tr=
ied moving the RSN IE to the end of the frame so that the frame is similar =
to the one ubnt airos produces=2E No luck either=2E One thing I've learned =
is that ubnt airos assoc req frames have the WMM/WME IE placed before HT Ca=
pabilities=2E But I'm not sure how to move it and also not sure if it would=
 actually work=2E

I am getting 4WAY_HANDSHAKE_TIMEOUT=2E From capturing I can see the statio=
n sends Key (msg 2 of 4) and a bunch of acknowledgements, but it never send=
s Key (msg 4 of 4) afterwards=2E

I feel like I'm stuck=2E=2E What could be the reason for this behaviour?
Josef
