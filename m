Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E392E94A2
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 13:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhADMRB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 07:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbhADMRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 07:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609762533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//6K0k9FtwE8ZOulfP3xXa44jPg3gUNt2CRGmIGM93U=;
        b=KVcE7p4ivuJoGbyoEVkXumBwMP0ey06sbyedSHj073s9BtJX64mlcdT7tV3rgB/NLHfvFd
        gbwkiYGJfrz2DLNA/I8GURKBrrPca07bgoGchoOb0PzzdsalFiJwW1geoCQL00Kymmsrdy
        P7zMlzvex9adY4ZWtrar7BqH9TCoEt0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-LbwPNaT1PISYmKeWYr3ZAA-1; Mon, 04 Jan 2021 07:15:32 -0500
X-MC-Unique: LbwPNaT1PISYmKeWYr3ZAA-1
Received: by mail-wr1-f69.google.com with SMTP id m20so12589631wrh.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Jan 2021 04:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=//6K0k9FtwE8ZOulfP3xXa44jPg3gUNt2CRGmIGM93U=;
        b=ZNsBcSWSyRGK7qUNK18gEbEXA2YQF0sS1RzyIfBt8SlzsNMklUYERNWbyHIlxkgCvo
         LH4H7/AFzBJr4zI2B3qjEmu57rXl/GfxgPDLpPTdvVSrTojpW70HgR+NDMcv6DwOTXRs
         4ab3QeIW08YgUfBVG3LZs4vVTRF3Rd7Uwn6rTM3GT4Jaozehy//2XFj7zJtqxzldwFOc
         f5VDWMpf/cFUhEfIOjrfDaOpUnAoZgcCImm92VsuvSfOnfHEm5eDxkHju5MT1hxrC2ex
         Auy2ZkG8IhPVpeXqbmjtoUZx4BEhUQcgUh/+Oj1LE4XSWU6UHmPAUJJMlr/GZNNI7a/0
         TfLw==
X-Gm-Message-State: AOAM530qivqbMroCktPSP4joQ49o0kdu9UMoFAhngjJm9B/PNVPPNUSZ
        59WF1bKIJJjnnG1prWW+xBYUl1auef0vyyT367AijQALDAGMy4X03AOpVpHfuDwq/Vxlvv1j2nV
        HNZoVagVgGBcMCqpDA3aGMQynGYs=
X-Received: by 2002:a5d:6204:: with SMTP id y4mr62584444wru.48.1609762531003;
        Mon, 04 Jan 2021 04:15:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAPFfadW8hvx1TKckHzlbrYuPfKQx+2Cw2sxMi8I1tusz5Qz4zD1Lcm+pCL1R5fPH5IPOm4w==
X-Received: by 2002:a5d:6204:: with SMTP id y4mr62584430wru.48.1609762530839;
        Mon, 04 Jan 2021 04:15:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w17sm34388047wmk.12.2021.01.04.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 04:15:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CCD64180063; Mon,  4 Jan 2021 13:15:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     kyan@google.com, johannes@sipsolutions.net,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH mac80211-next] mac80211: introduce aql_enable node in
 debugfs
In-Reply-To: <0ad278def3875fc2c60b4898daa3f0d53288c168.1608975795.git.lorenzo@kernel.org>
References: <0ad278def3875fc2c60b4898daa3f0d53288c168.1608975795.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 04 Jan 2021 13:15:29 +0100
Message-ID: <87y2h8525a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce aql_enable node in debugfs in order to enable/disable aql.
> This is useful for debugging purpose.

Don't mind having a switch, although I wonder if it would be better to
overload the existing debugfs file (e.g., a threshold of 0 could disable
everything?) so as not to clutter up debugfs too much?

-Toke

