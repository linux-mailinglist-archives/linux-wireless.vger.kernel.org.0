Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174A14755D1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 11:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbhLOKHW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 05:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhLOKHV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 05:07:21 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E9C06173E
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 02:07:21 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s139so30902139oie.13
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 02:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVCLk2KvUz2CBA6KxTckpPCL9kycYtlgU5ExJGHmdHA=;
        b=TdYW3wWENtco6r6aEJgLHN1Wm/Jo2LYGQoiCHPNI1ddnV4nyK6MsYoMZwMKzCoRAEE
         AYRAwNFVuQMy20wkqPLyzi97NShviqcrIvw8NJLISzgbvDuIf1HqegmK19MBqF6SUBwB
         ywNO7+FiJqUETQEz1SDLGtpl19YCmzBOAfnkz5CfuV4HlOnRBy/K1BQ70cOPw3U9oGHU
         1joLmaTlbPT94X5dBVEj32TymLNFWLI9aIrHrMJXQPMy9CzKe0X+2AJcWKMWVZTA5cLz
         HLEps0rBHoC2ENmA/2xjiObMwZhs4U1q3d6K7A/kHC2QXGEsAwpBSs/oLI55JB9jZjXp
         HBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVCLk2KvUz2CBA6KxTckpPCL9kycYtlgU5ExJGHmdHA=;
        b=u3Qwsa0qqttsPlmrNzFMO6Ms5ObVZWcZ9iClfPDPuJ6/52ijO2AP5AFVqS7XI1tJtu
         RUa//WnxvIucAN3SLfm14T7HJ5VAoXP92c6N4sZJrboiKgtMYbFCUd0bXbbhqACnrVZ3
         ADOP+amVOwP+dVnZHo+KgfGOp64Y8yIlgPstDmaDyjGbxgvN/B4tP5bwq1/M/crHPX3f
         iWLCfAbQp4WExJBuJLVo+GWJlpBB6/bvl7kiTI9lTMA6qaiJ4KdEt+Wy+mj7ZgqD5r/T
         xq2EkYkBYmpgZVZ+/1VGb1V0SI3mNLj+cQ6tb/YgvjAc7TfynCUrcpsQPTgeP9MCM54p
         5M+g==
X-Gm-Message-State: AOAM530bYBJVpbNxZrzbBi9SpUiaSaNYbGzvzeoLnxq/aLwa4tYGpRow
        UubxSBoOjx4fgaAUSJiaI2RseiFfTZruqo7ZThvv37NtMd8=
X-Google-Smtp-Source: ABdhPJyc5Ce3PPaPZ6g5pi+tezKucQgoCbBlL+XD8Rd4CkvjHOXbNz/HAE9EoQwGduqqCS2FpHN1mJYkrBHEIObNntw=
X-Received: by 2002:a05:6808:d1:: with SMTP id t17mr7875375oic.161.1639562840499;
 Wed, 15 Dec 2021 02:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20211215065508.313330-1-kai.heng.feng@canonical.com>
 <CAPpJ_eff_NC3w7QjGtYtLjOBtSFBuRkFHojnuPC7neOmd54wcg@mail.gmail.com> <1bf16614c29e47d8a57cfd6ee4ee50ae@realtek.com>
In-Reply-To: <1bf16614c29e47d8a57cfd6ee4ee50ae@realtek.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Wed, 15 Dec 2021 18:06:44 +0800
Message-ID: <CAPpJ_efxbsd=DuP6gq-YB4q195oa+wtZ9qaPdT=o20b6Ojy9Gw@mail.gmail.com>
Subject: Re: [PATCH v3] rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE
To:     Pkshih <pkshih@realtek.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
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

Pkshih <pkshih@realtek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> > -----Original Message-----
> > From: Jian-Hong Pan <jhp@endlessos.org>
> > Sent: Wednesday, December 15, 2021 3:16 PM
> >
> > Tried to apply this patch for testing.  But it seems conflicting to
> > commit c81edb8dddaa "rtw88: add quirk to disable pci caps on HP 250 G7
> > Notebook PC" in wireless-drivers-next repo.
> >
>
> I fix the conflict manually, and the ASPM setting is expected.

Yes!  Same from my side.

Jian-Hong Pan
