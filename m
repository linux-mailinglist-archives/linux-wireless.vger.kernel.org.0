Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A327C2E95CB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 14:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhADNW0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 08:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbhADNWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 08:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609766459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nuJdpYzBEDYpnQJAkhPMUDQpka51Gd7LbSL3/8wpR4w=;
        b=dft8QpEvTC8lrhN3U0BGMHasPNL68uj2ton3GNM3hycNDbmMIBfKsHvSeNWkvEvx+LBwNK
        amwZ9/YmLsyvG4wGbkSXC7E5m5xSYZYAGmyysmf7WzUS5MSRTPb8nGyzf6fb3x2IkSdW3S
        OITUfayyHrlv5hfCUP02tCH85CbpMpo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-m_3t9KFaNIuP7qnUbmal5Q-1; Mon, 04 Jan 2021 08:20:56 -0500
X-MC-Unique: m_3t9KFaNIuP7qnUbmal5Q-1
Received: by mail-yb1-f197.google.com with SMTP id e74so51640703ybh.19
        for <linux-wireless@vger.kernel.org>; Mon, 04 Jan 2021 05:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuJdpYzBEDYpnQJAkhPMUDQpka51Gd7LbSL3/8wpR4w=;
        b=AAJydKzDqLoAABN/u0XzqwTQl8JWEND9oz+bbMaA9thwlSEGTNwaOp8u5Cxa7/VIwX
         KnaS5Hf/ZBTNcKiTWXz2tvFAQ+jIyG2VZOaIn//fOvMiIZnFO+P40VgDfTi6HAnZdQ9w
         Q4N1L2nkSXDDB7I5VH/Iaf/Hp2gr/Y1xyzQeHqhMXbYs7vpSWkEesO0VC0kLPy8qQm7W
         hZ91FAbb+xvRIZnr82+sggoGHplglhCr7fNhAXzL3pleDTYYPFsZ+K3uyeA761/jRX6a
         spgTpC+30e1FjShMfiR1JSlKKXe1xPStRyde5emve0M2XOtWMzcdLeUPabmaTQa3t9GT
         lTqA==
X-Gm-Message-State: AOAM5301qPW0Xd05o+qk4wAtUAZC90hOrBRZiC/NXIshrt0GXw2+21ta
        bg5cMEa7ztuvp8uxiUgGoIoGtmfVC9HVzKjHcDcSkWyGoYUVHwcyz80vWR1PJF6MpsFS0EbX7Dj
        yt9Q7PHVqIp5A3vrl7CYZrjuyi6g1q00+fcxLAw1Ic/E=
X-Received: by 2002:a25:76d2:: with SMTP id r201mr105863062ybc.107.1609766456270;
        Mon, 04 Jan 2021 05:20:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRPfLV+zlrfZ2kp8z6458endM/BnFNCBWcLo/LkzUhhdYN26ZO8+HoTX2U5HgGOzVV9hkbQ5mBCI190mwx4a0=
X-Received: by 2002:a25:76d2:: with SMTP id r201mr105863039ybc.107.1609766456088;
 Mon, 04 Jan 2021 05:20:56 -0800 (PST)
MIME-Version: 1.0
References: <0ad278def3875fc2c60b4898daa3f0d53288c168.1608975795.git.lorenzo@kernel.org>
 <87y2h8525a.fsf@toke.dk>
In-Reply-To: <87y2h8525a.fsf@toke.dk>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 4 Jan 2021 14:20:45 +0100
Message-ID: <CAJ0CqmVq2+poxg_V6pMCh2CFuqt3dwUW3x6eF=J0ek_uX5k6yQ@mail.gmail.com>
Subject: Re: [PATCH mac80211-next] mac80211: introduce aql_enable node in debugfs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>, kyan@google.com,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>
> > Introduce aql_enable node in debugfs in order to enable/disable aql.
> > This is useful for debugging purpose.
>
> Don't mind having a switch, although I wonder if it would be better to
> overload the existing debugfs file (e.g., a threshold of 0 could disable
> everything?) so as not to clutter up debugfs too much?
>
> -Toke
>

You mean to consider 0 as a special value to disable aql, right? I
would prefer to have a dedicated switch for it since I guess it is
clearer for users (but I can live with it :) )

Regards,
Lorenzo

