Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A90DFE10
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfJVHOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 03:14:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbfJVHOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 03:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571728490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwsp5QQ6bMYXnb9ux6HCdVcJSILSyF0BVLpabeoGiOo=;
        b=JEOG/wa5tOAUWp4lN3GH4l1/iu41zLnEB5TNtsEibo2mclOiHnb4Y9Tm9xD7Uhs6efWYQJ
        w3SpaZAE64rCL3zUje2L74l2Iu3m+coO+6yJHYgOJ9OXobQKDeTDkATNp4Wz+kc3JlrH/b
        KBqHCEw/WoYYEj2C6GuYFCCvR1xGKEA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-GoQkclVEMfCQ03an90mSUA-1; Tue, 22 Oct 2019 03:14:47 -0400
Received: by mail-lf1-f72.google.com with SMTP id n26so14997lfe.17
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 00:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YEnLndySMbqJ6YLxHTcryFiXLrxuubnh33DpZ1uyCVw=;
        b=LQPqB+ez7dOhfsBTyaw1uN4prqXpBkCpnGjqXfaEBQOhuAYhNkTzW1ZaHRvIaU7zMV
         z/WxRmhxdci/iWyGr+WSI/S0+lf3RhnuLrZlBIWED0BbBWvlbeftXXUdKUa6swKYPcwt
         QSDCWdpQ6KQaePL76oxNmz05WL6dcfjEnUgKNJR/2EGlbnl61J0lTrZ3KEsw8YQvrH3G
         EHsq65Gpc5eBeb8DjdUgrGVCLxYvp5qlFostu34a79PdEIvDM2md/CNSRL+0mZPfdnv7
         kyiJKuzTVawd2SLBRniVRKpSAsSIj0rEdln3O3SMUB7tOaSHFCrnrPu/MyuxpBJ9tzI1
         c6rQ==
X-Gm-Message-State: APjAAAVNc8uH6Pwg/01VDTefgLpDh0kQaxrGVWIVy3jGdnd4/IsT04e/
        rjU3Iq3/7Sk8Dmqoobs2j6+NoyzC9c+EooPBggH0sRJcqeJxHMuPe1SvCXhSjxt91Jy4iIcGnUn
        w4JpghdLuSPRmcO49DKDYNHClelY=
X-Received: by 2002:a19:ee15:: with SMTP id g21mr9604050lfb.27.1571728486204;
        Tue, 22 Oct 2019 00:14:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCSIOYeZTnkeEphbi//1B6x6TmIFBb5CxKOQTHtWQ/QW3TmwG4Neq6wU/IdDUdAzg548Su5Q==
X-Received: by 2002:a19:ee15:: with SMTP id g21mr9604021lfb.27.1571728485759;
        Tue, 22 Oct 2019 00:14:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id p22sm8765694ljp.69.2019.10.22.00.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 00:14:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EE22D1804B1; Tue, 22 Oct 2019 09:14:43 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v4 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk> <157148503865.2989444.7118792679603045723.stgit@toke.dk> <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 09:14:43 +0200
Message-ID: <87o8y9p7z0.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: GoQkclVEMfCQ03an90mSUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
>> +                       qc =3D ieee80211_get_qos_ctl(hdr);
>> +                       tid =3D qc[0] & 0xf;
>> +                       ac =3D ieee80211_ac_from_tid(tid);
>> +               } else {
>> +                       ac =3D IEEE80211_AC_BE;
>> +               }
>
> The tid/ac is incorrect either here or in __ieee80211_tx_status() when
> tested with ath10k. The ac is set to AC_BE with test done using BK
> class traffic, hence the pending airtime get updated for the wrong
> txq.

Huh, well that won't do, obviously :)

Any idea why it might be wrong?

> The rest of the patch seems to work as expected, after I did a quick
> hack to release the pending airtime from ath10k_txrx_tx_unref()
> instead, where the ac/tid can be directly retrieved from struck struct
> ieee80211_tx.

Awesome! Thanks for testing!

-Toke

