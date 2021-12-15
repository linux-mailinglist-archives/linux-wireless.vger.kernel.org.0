Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC8E47581A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 12:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbhLOLqE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 06:46:04 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41610
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242163AbhLOLqD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 06:46:03 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A47313F1BA
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639568755;
        bh=5tMBnwEs/vWNX4NTSLds+QqZD5aWu/S+gNf17CfK8JM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vfe3+zipvDe/4vjs8VqT9Cx6fBLLo0bppnFoWIogi8n98jlcsiY2uV8ekW3LkIkoj
         moPxNRUsVv3SZAZwTGzrFNaJGIgZB9ROderuV/iFK3c1J3A/yGBv1wWA79IYD1JV2V
         MGfUQFP9LZymBcMQfj3epM9IkcqNXdLQpls7ZcMTfNDIzINMHrFHOZ4q3nemfNrQmV
         ForqNcXBIz9a60PZB+mCdbzdQCoEyo/w6MwLDcz4VTMQdk/8HQepI1i5lwU/kYZXDw
         WwNe45W067pAA8hW1oH6FtsOpa4pHWvcJXTxVjZKwN4sAxgwseM1OrV70tQNhury9P
         VYI9X4ztFMXoA==
Received: by mail-ot1-f69.google.com with SMTP id m23-20020a05683023b700b0055c8a2dcca0so9635984ots.6
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 03:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5tMBnwEs/vWNX4NTSLds+QqZD5aWu/S+gNf17CfK8JM=;
        b=6utsGp6DJhwQMurdcX59awwxKc9ipHf3oRlkPuL+EYdZ1GpFbwPMcEQZMSWsFD6Wrp
         JPpVtVGB5SPYgCkraHSIRqacbj5iAm70aaVusMaQID6F8wIPV5qQHQK1a3d22h9K3Sgy
         DXPT8U7gCDw/MS2No91TOSlyjMnsLlkgfHcw7MktJjh0pESBIUESHCQtYw0xxi/DDg5C
         yNLk0K338YFA9rMP7sSH3wC85EmL7HSqyLWLkS8zPFXZaH6QFXQ8OzyhP48ewy4RDd5D
         81TX9eYyaxPHThIxtIP4DbKhwnIgbSPhVXM04dLZ7GJIm8oFljGR9cKhLMweqoKm1xBq
         C6tQ==
X-Gm-Message-State: AOAM531XeZhk8hRrckKAb+sOnBhpTtcGJd4pws51fYbldQC7TTMspdvP
        mQWb3dPnYaN1eIxiqxlKp0zm3DyucRFAyhlyqqgJ4lL/mFpCj4QCKDjHeMbQgHNQ96r0xd4wje2
        dVQWHiZ1HNLtYCPdxs7XFmIcDC9wVHIwF4/porU6XIqw2JXcJZ5OiAqT/oQGD
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr8276893oti.269.1639568753843;
        Wed, 15 Dec 2021 03:45:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUZs3tekHx4L7AzmeZS7ZHKZrzmVXmBqWxSo92TBMGIxeMG8WyBZlVeLYPA06s3SesslmBxwaGtWlDT9HtkMs=
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr8276881oti.269.1639568753625;
 Wed, 15 Dec 2021 03:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20211215065508.313330-1-kai.heng.feng@canonical.com>
 <CAPpJ_eff_NC3w7QjGtYtLjOBtSFBuRkFHojnuPC7neOmd54wcg@mail.gmail.com>
 <1bf16614c29e47d8a57cfd6ee4ee50ae@realtek.com> <CAPpJ_efxbsd=DuP6gq-YB4q195oa+wtZ9qaPdT=o20b6Ojy9Gw@mail.gmail.com>
In-Reply-To: <CAPpJ_efxbsd=DuP6gq-YB4q195oa+wtZ9qaPdT=o20b6Ojy9Gw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 15 Dec 2021 19:45:42 +0800
Message-ID: <CAAd53p76S7kgHerKosj3P+u2h6TBAS9H0kK_cHDQqGg1SC=83A@mail.gmail.com>
Subject: Re: [PATCH v3] rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE
To:     Jian-Hong Pan <jhp@endlessos.org>
Cc:     Pkshih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bernie Huang <phhuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 15, 2021 at 6:07 PM Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> Pkshih <pkshih@realtek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8815=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:03=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> >
> > > -----Original Message-----
> > > From: Jian-Hong Pan <jhp@endlessos.org>
> > > Sent: Wednesday, December 15, 2021 3:16 PM
> > >
> > > Tried to apply this patch for testing.  But it seems conflicting to
> > > commit c81edb8dddaa "rtw88: add quirk to disable pci caps on HP 250 G=
7
> > > Notebook PC" in wireless-drivers-next repo.
> > >
> >
> > I fix the conflict manually, and the ASPM setting is expected.
>
> Yes!  Same from my side.

Sorry for that, I used the wrong tree.
Will send a new one.

Kai-Heng

>
> Jian-Hong Pan
