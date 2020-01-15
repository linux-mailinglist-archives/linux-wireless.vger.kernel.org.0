Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC613BEB7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 12:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgAOLm6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 06:42:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729900AbgAOLm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 06:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579088577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDSeqcGJEWSQHFDhX1+MNBzF3mYH/xqOWG+aFAaH7cw=;
        b=D4T2BHYw+XoGvQ6Gc5ZRthrqgZi9u5YKbNPDP4rvqTIU9kr11FQ8hX9WyX9L3rMk4+Qav4
        FgaanZDhJ67ytSqL9Ik0olHVexbC+mYKMyN0ZsU6NnQYKvGNXGiv4YjocdzfOq8+5918kN
        1uHgeQwPvJgBO2HVLtVvb8WRufY7q7M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Nbie6M1jMtyuOoyKHiLIOA-1; Wed, 15 Jan 2020 06:42:55 -0500
X-MC-Unique: Nbie6M1jMtyuOoyKHiLIOA-1
Received: by mail-lj1-f197.google.com with SMTP id o9so4044814ljc.6
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2020 03:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gDSeqcGJEWSQHFDhX1+MNBzF3mYH/xqOWG+aFAaH7cw=;
        b=s9SYhvbwHZtagsjNsRO5C7fTU98Xc+NK2HcpaBJSCLBJ5yyuM4fexfBloJw15IXCMb
         KGXqG07J7MjZpt4SZvtbHhlaw72HTI62m/9QeILxL316q4aT4j5uET/OcFUHFeqzllAP
         OM1He38hcV9DDbkIG/9j2hLH2R5lDW8DM6civl3UMdl87Q7Fy9RIcCFhhmbhztHflS3M
         hrhmzPBzOLGwamDkc1E+N5tECgUn/sb98lrJktBuOW2eeh25L1nM26ZujBMexx4BvgiK
         OpmZuwsw13fV3AzXEVnLa/2v9MGqtpXO7bbn+grfVOiGbkhnsLSHYggMZA6xvuBFgnaS
         GZOA==
X-Gm-Message-State: APjAAAV2Gwri/+bRsdGg6/J93SeXkBQq+dy/kh0yXmNk4q6pOTM77Kun
        6TcNQMm8muep/8qvbXhjYU0M6qAUap5cTI+j6+Ozjel1kanhbhu1OWNSxlCXOokYGlD+c2fgiLr
        qF5R2UjJZeOJJQjegRbEsmc22shE=
X-Received: by 2002:a05:6512:15d:: with SMTP id m29mr4422836lfo.51.1579088573997;
        Wed, 15 Jan 2020 03:42:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/52ZWsB6MwGFin2abS7Gd131/A6SwlBOe5ZD8pNcPwXyFfqvA268g9WePCw3o4ADI8zg88Q==
X-Received: by 2002:a05:6512:15d:: with SMTP id m29mr4422828lfo.51.1579088573790;
        Wed, 15 Jan 2020 03:42:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u13sm8682145lfq.19.2020.01.15.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 03:42:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 557B81804D6; Wed, 15 Jan 2020 12:42:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: use more bits for ack_frame_id
In-Reply-To: <20200115122549.b9a4ef9f4980.Ied52ed90150220b83a280009c590b65d125d087c@changeid>
References: <20200115122549.b9a4ef9f4980.Ied52ed90150220b83a280009c590b65d125d087c@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 12:42:52 +0100
Message-ID: <87blr5uern.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> It turns out that this wasn't a good idea, I hit a test failure in
> hwsim due to this. That particular failure was easily worked around,
> but it raised questions: if an AP needs to, for example, send action
> frames to each connected station, the current limit is nowhere near
> enough (especially if those stations are sleeping and the frames are
> queued for a while.)
>
> Shuffle around some bits to make more room for ack_frame_id to allow
> up to 8192 queued up frames, that's enough for queueing 4 frames to
> each connected station, even at the maximum of 2007 stations on a
> single AP.
>
> We take the bits from band (which currently only 2 but I leave 3 in
> case we add another band) and from the hw_queue, which can only need
> 4 since it has a limit of 16 queues.
>
> Fixes: 6912daed05e1 ("mac80211: Shrink the size of ack_frame_id to make r=
oom for tx_time_est")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Fair enough :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

