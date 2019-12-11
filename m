Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B722211AE68
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 15:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKOx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 09:53:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727457AbfLKOx2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 09:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576076006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5y9NzPesAlF6OSlAPB9hrPEsFGVvaSeX+KGxvKA75gc=;
        b=V8+BinsbhR5/PB48VIEN2kFhpHCHjV2/21gSQhaI5Z0LceXVJAxX+OG0Pv3S0YQGw/B6Ak
        uiUcvIh1oQXJFGxNggkQG0GrlwjhPMzlFRQRiQbZmuhh2wfAimReI5khWt761GgYWEDRs2
        p5yqwrYqm7ei+SUcdwzG1ggZipyBrms=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-TNqcLWM-NRyZj_j2CHEcqg-1; Wed, 11 Dec 2019 09:53:25 -0500
Received: by mail-lj1-f198.google.com with SMTP id s8so4458101ljo.10
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 06:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5y9NzPesAlF6OSlAPB9hrPEsFGVvaSeX+KGxvKA75gc=;
        b=O5mOSZ73k/jrhKaVSoG5F8iD6JgU6JgX/tkpLfEU5lzbporLHiTCVTfgCGB/r8+MAX
         Lmsxd5LjXkopHaJeBHNUIiwW2QJ5FnexiJ5my8ozqw7YnTvMvs3L20wL+Y7J/6XFIL5s
         dPjuoxYXhcDlM9OCzbZGduwhYd/drhutDW+nfN+1nixe7t8yXyW/+i1wpVJbsZwq+1Sq
         VcBS/23W4x23pBF1n6wpxoysB/Sw2nysMbYmMqWn2CGgJCvoutj/Bxg+hyFWM3Ro38rL
         JJtsY0iOfvtPCOVCfHqv8LRKf4c6l08wOyBf+H6Rprgn6VpGjCO75CZPIMXQ8Iqt03pz
         ybVw==
X-Gm-Message-State: APjAAAXfDYVrEUQzMLAet+eUHRiyrxjspPCbqGYt/8mnAJUVC+wC7wJ5
        XkzoSwRaGCJO/thVZORXMg3IrHTnWrw0mU3Zgy5A4w2jpm3fnUbXXhzEoVfzQWpAShRkvsM0zfi
        rZUJ3vp1HOxHtsYbkb5XDqQDfWxA=
X-Received: by 2002:a2e:b017:: with SMTP id y23mr2440356ljk.229.1576076002759;
        Wed, 11 Dec 2019 06:53:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxN/b8k1boSA7s2+0S4yZBzAFAzz0jCvr2bnGKwXT0o5IffmkER9eZqCcvM0n8CSOvguS2AkA==
X-Received: by 2002:a2e:b017:: with SMTP id y23mr2440349ljk.229.1576076002607;
        Wed, 11 Dec 2019 06:53:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l8sm1295488ljj.96.2019.12.11.06.53.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:53:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5AE0718033F; Wed, 11 Dec 2019 15:53:21 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: Always show airtime debugfs file when TXQs are enabled
In-Reply-To: <20191210143417.142964-1-toke@redhat.com>
References: <20191210143417.142964-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Dec 2019 15:53:21 +0100
Message-ID: <87fthqgbha.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: TNqcLWM-NRyZj_j2CHEcqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> The AQL statistics are displayed in the 'airtime' station debugfs file, b=
ut
> that file was only shown if a driver has enabled the airtime fairness
> feature flag. Since AQL can be enabled without airtime fairness, let's
> expose the airtime file whenever TXQs are enabled, so the AQL data can be
> read.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

With the change to an NL80211_EXT_FEATURE for AQL, this is no longer
needed, so please drop this patch.

-Toke

