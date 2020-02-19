Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1018165271
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2020 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBSWXe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 17:23:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41472 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727082AbgBSWXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 17:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582151011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIAoPXkRCPiOgfUX3AfTn+TSJTybiuskDfdaCOwWKYo=;
        b=ctuS7JNsdNVTIZ/dYuB6JfD9NEOnGRTRadPWVReb96AtLu0PLSGb2GpLlDLLXhco+IrxdF
        ZNo/KP8Ng0cM9JAR+A7Ec5e/DduzGuJMClTGRWVchl3ukgCjToc20d1J09EOCsfqi5VL5a
        5nfyWEIKMxXo8H3txiwuz6Hc7EIyMII=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-NDO1wuCGN_SualEYDWBgzA-1; Wed, 19 Feb 2020 17:23:29 -0500
X-MC-Unique: NDO1wuCGN_SualEYDWBgzA-1
Received: by mail-lf1-f72.google.com with SMTP id k26so537158lfm.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2020 14:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kIAoPXkRCPiOgfUX3AfTn+TSJTybiuskDfdaCOwWKYo=;
        b=fACiwY8b22FWkjfuF/ytCKdPDnJ1maI2o6xJX1TUlyyyWInKGfiXpK3l5Oc/8ldzu/
         R9hSPP/i7BGwY/cNnnKnSH+Zn/0kqkH0BVoIkVev1SMI1v7+qzCO2Q7u78X5d08EszRf
         FbxRkpuFk6r6EBDe4HEFsc5x+fejB9KezcAczvtpbeKUPT8YOujcqIRkBM2wE0O7NY5M
         KC1HU+axaSXr63H/9crlqlUXx+EjM1/sXDWJZCOyqJVuaVyPWN5KEpBgZiBtGZKcJBz3
         ukBkWogWM20ZUH9EtjvbtIKLcneZ08xjen+CCB8IYX3TMTMVVWzvetZ33E0std/2NLc3
         fAUg==
X-Gm-Message-State: APjAAAWOa+2R4IyyP4uGUXrGGB1/8fQD3kTU9j6+TqzIlm0h+wLHHBdF
        RENRqCYUxmSiJJ5+wz2f1w8cegevZl2427LV0GViFpUCCEvePGZQq+OMLu9p/HgeTiEGvYnoZny
        tsURurqz9+CqjTnQRLPA8na+7m/4=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr16716698ljk.139.1582151007979;
        Wed, 19 Feb 2020 14:23:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAOLFdJEjlAjVG9OjxQAguXAD/8wDrlSE0mFufspixsYLt2URGP9+ABEdfFMIKcmgb+wz+DQ==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr16716687ljk.139.1582151007697;
        Wed, 19 Feb 2020 14:23:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m14sm536235lfk.7.2020.02.19.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:23:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7455A180365; Wed, 19 Feb 2020 23:23:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5/5] mt76: enable Airtime Queue Limit support
In-Reply-To: <aca37dcb-c76d-d239-0d0e-61b73afc5d8f@dd-wrt.com>
References: <20200127181754.2810-1-nbd@nbd.name> <20200127181754.2810-5-nbd@nbd.name> <875zgqfoqu.fsf@toke.dk> <aca37dcb-c76d-d239-0d0e-61b73afc5d8f@dd-wrt.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 19 Feb 2020 23:23:26 +0100
Message-ID: <87lfoyw71d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:

> nope (iperf3 with 32 parallel streams after 5 seconds of running)
>
> STA 30:24:32=F0=9F=92=BFf9:c4 AC 2 txq pending airtime underflow: 4294967=
208, 88
> Modules linked in: fast_classifier mt7615e mt76 mac80211 compat
> CPU: 3 PID: 1890 Comm: hostapd Not tainted 4.14.171 #187
> Stack : 00000000 00000001 00000040 8007e454 80490000 8048bc8c 80610000=20
> 805aee78
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8058850c 8770b864 870f289c 80=
5f07a7 80582204 00000001 8770b808=20
> 805f60a8
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000 00000000 80650000 00=
000000 81147bb8 0000011e 00000007=20
> 00000000
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000 80660000 80660000 68=
203a6d 80000000 80610000 00000000=20
> 873079ec
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 873a4654 00000775 00000000 00=
000001 00000000 80230b88 0000000c=20
> 8065000c
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> Call Trace:
> [<800153a0>] show_stack+0x58/0x100
> [<80438c54>] dump_stack+0xa4/0xe0
> [<80035050>] __warn+0xe4/0x144
> [<80034c8c>] warn_slowpath_fmt+0x30/0x3c
> [<873079ec>] _616+0x110/0x214 [mac80211]
> [<87301ce0>] _535+0x15c/0x4f8 [mac80211]
> [<804224f0>] br_handle_frame_finish+0x4e0/0x524
> [<873d5160>] _49+0x50/0xa4 [mt76]
> [<87606e30>] _61+0x1e8/0x224 [mt7615e]

Huh, why is there a bridge function name in there in the middle of the
callstack?

-Toke

