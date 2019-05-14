Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1701C81F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 14:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfENMEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 08:04:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41750 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENMEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 08:04:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id d12so18875939wrm.8
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=l7WDIT3xdi0gOSJQozDJ4q2UDbYV5Prpi350z/iT3mg=;
        b=K0uSptrdkId+Sb6Kw/D1WArRSbnA2B6DCCEYBp97NU68hoWX4m6qESepNGcrNacyCU
         OfT5Cax7tQ1/WUdA4FPvI9mqJNZe4im2jOBKMN7VfUWfcjretcWGJ10ijkg2mHJW0g8q
         eNHcLaHC4PBy1B3o9DL7Whv3CtV17EfHC6LerqziYDcUf8SU+Sz4kEjqtbNfAJvYbCSo
         ugFH0Y5JOel9ftLLAGWFCIe3U8b/9YzYDh3gc3phDiJouJUlyFFtGwKl3O5EHxRmnmkY
         n4/k+PWpD7+6L8/CNpiJBSn3Qj+FAyypVtSjJWZqeyD/oWaa0G85/t1wSM6S1iAMiWDY
         wesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=l7WDIT3xdi0gOSJQozDJ4q2UDbYV5Prpi350z/iT3mg=;
        b=EdHb0QlKwp15CMFi18jGuwAE+/3ypm9/LC/p9nxXaoRU74Xz6sPeo+7W0DjWsK18xX
         NQUn68vlzs7BDSje/H5aKbp7E2tZDIfQ9XP9VQ1/WjbBfa2bFAdzGvppHxme/CZdgM1O
         cpEh00eN2YdjaERmApIQ4MKx6PetPWqDSjEO8cvI6+XPChjffvJnSFPZCJajBKqgK5aj
         ZYoR31O8LBXZVYuTM3AduEFXmirjC/rAwp0GgP9xRDl7hQ76zb7Acl7K4gHvP30WKsnt
         8P+FXJTk6lNN24OQ2GeASrb0i1e/xnbyyyeZhFC0zzMjtHtwBLJrs0584UUaNe793hPz
         3Bpw==
X-Gm-Message-State: APjAAAUC9hwb8giwBIJirTJBToZuOrJDt2DKRDJXJp40UPVem3g6ipdd
        4Tws9rPdJMGocuEwHGAU/ALN+zgKEI5cMOZviH4=
X-Google-Smtp-Source: APXvYqx0coIeaiX7HouucYZfPpqoG4VHiTzn75fcd8lm77jsnx6iC4l5IQ1i+ZD+bG9JpPvJyldZGxr/MpXkpL2kQ+c=
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr22090810wrj.66.1557835450452;
 Tue, 14 May 2019 05:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
 <20190513123751.GS9224@smile.fi.intel.com> <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com>
In-Reply-To: <2d39b39b-27eb-abef-747f-400433daefee@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 14:03:58 +0200
Message-ID: <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 1:45 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> On 5/14/19 11:34 AM, Sedat Dilek wrote:
>
> > Am I correct that "NPC100" is "PN547" and "NPC300" is "PN548"?
>
> Yes, NPC100 is PN547.
>
> Don=E2=80=99t know on NPC300, but a quick web search reveals it=E2=80=99s=
 PN548.
>
> Might it make sense to drop NPC... and to keep just the chip names in Kco=
nfig?
>

Thanks for the clarification.

I found NXP NPC300 windows driver from Lenovo's support website - not
on the support websites for ThinkPad T470 but for other ThinkPads like
T480.
It's the same driver and by accident I could update via Microsoft
device-manager to version 12.0.4.0.

So if you search in the Wild Wild Web for a Linux driver and have the
information "NXP NPC300", you will find it.
It's good to keep both informations - preferable put them into the
Kconfig help text?

- Sedat -
