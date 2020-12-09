Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0852D4C85
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgLIVIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387903AbgLIVIB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:08:01 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D9C0613CF;
        Wed,  9 Dec 2020 13:07:21 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id x4so1685117vsp.7;
        Wed, 09 Dec 2020 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxXmfsC48piD08BrnCt/ALLaaGzDfMADF2GaWqoLuKs=;
        b=DDd9Dw0XtEWlv2CcAAkjkbk/y38KVl8EPHV94DC5i47P9E17B184nBih06nF6nOkNs
         HmAztudi2TXU8AkQSu+ntuzWFqxN55ZUy6mEDtqsYVGbZ9l9ujq5aTwtPvrgs92A6kqe
         IH5z6+oV4t9Il6jB5yg25StPrfr7mG04ibRVHhaz3lymsKM7oytmVf8mHnCVXb4yOp11
         xOSIAp1Y4a36tuDrYju5m/vElRVdVbeZ35Zcmxf4s8L/zxOtrnNVmVcJc+IZCiU117yQ
         FeVpwFDDvkkv9mWkPTLbwsmYgmNKaJGsqNHZtIhN68iZ3JAeeO2koGgmGjndak2QV3M/
         +mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxXmfsC48piD08BrnCt/ALLaaGzDfMADF2GaWqoLuKs=;
        b=SgJrgm32IzSgoXqhmSVnY61AEJEgr3fVDoZc9uAJj4o6WRshFaH/IScPCsWsm+jix+
         RFJdCsmlOtBXr38NrkrVfTduVb3RepfghmOZO4W4raEzZvvzj0PVP6gH8qQKXLTmrBiZ
         CP+syrovBdnTg8QLOg+hFr0zgodOQqRD5EUHM1M4Zj3WJLHByrzbdGgikpwXUbiUqM0k
         6dOhapmHdmSUA6ss47tY6C0omLbKI6ljvOPIUuscGxK0sEQ9QzgCv9Jvjb4BJT7USAPm
         trWcgAyZDrZHtcwld+yS06OQvmbjnd1LmjZmzcRyMJBwDjh3Cb0N6PMuItL0rkN8w7jL
         aGZw==
X-Gm-Message-State: AOAM530KN7oy3Ikk2a2Pu2L4YG7MKFZMCX5Ig5x6sFvxnmGePYIqMd7W
        XZetQepFE+N04xoshlDaJAgXQBmpUkCOPqF8ans=
X-Google-Smtp-Source: ABdhPJyDLmYaq3PbITlL8LI4D1jfsMMZ9PSO7aS+lqAMdnYbGExYj7b4qC60sH+8w7q1o4uPN6oQdKBZ+hLfWoBeDFE=
X-Received: by 2002:a67:f519:: with SMTP id u25mr4390265vsn.39.1607548040444;
 Wed, 09 Dec 2020 13:07:20 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
 <CALjTZvYZEbgfLEzxQdafJT6CFz76prA4+YM2EGA8k5Dgn3gigw@mail.gmail.com> <CANUX_P1YWSudJfwyuFVg-qdBHwQvQJiZayZBMY8E4it0qwB5Hw@mail.gmail.com>
In-Reply-To: <CANUX_P1YWSudJfwyuFVg-qdBHwQvQJiZayZBMY8E4it0qwB5Hw@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 9 Dec 2020 23:07:09 +0200
Message-ID: <CANUX_P0sOAdRjOgg=ogAHmQdTXp5UKyW2XQQRComa4Rv3Y-toQ@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 9, 2020 at 10:47 PM Emmanuel Grumbach <egrumbach@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 10:40 PM Rui Salvaterra <rsalvaterra@gmail.com> wrote:
> >
> > Hi, Emmanuel,
> >
> > On Wed, 9 Dec 2020 at 20:32, Emmanuel Grumbach <egrumbach@gmail.com> wrote:
> > >
> > > Rui, I looked at the register dump and looks like you're using AMT on
> > > your system?
> > > Can you confirm?
> >
> > AMT? You mean Intel Active Management? Heavens, no, not that I know
> > of! This is a personal laptop (Lenovo B51-80). (And I'd personally
> > kill the ME with fire, if I could.)
>
> Yes, I mean that thing. No VPRO sticker on the laptop?
> Weird... So apparently I was wrong about the register value.

Indeed, the bit is reverse logic. So we can put that aside.
Frankly, I have no clue. You can try our backport tree to bisect,
should be easier..
What I see here is that your GP_CTRL value is 080003d8

#define CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW          (0x08000000)
which means sense since apparently, HW RF-Kill was asserted.
#define CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP         (0x00000010)
Which means that the device is going to sleep... And that's the problem:

iwl_trans_pcie_grab_nic_access:
        ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
                           CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN,
                           (CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
                            CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP), 15000);
        if (unlikely(ret < 0)) {
                u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);

                WARN_ONCE(1,
                          "Timeout waiting for hardware access
(CSR_GP_CNTRL 0x%08x)\n",
                          cntrl);

but I'd expect the splat in your log...
Or maybe you can't load the firmware?

Can you try this:
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2fffbbc8462f..748300752630 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2121,6 +2121,7 @@ static bool
iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
         * track nic_access anyway.
         */
        __release(&trans_pcie->reg_lock);
+       mdelay(1);
        return true;
 }

If that helps, then... I'd have no clue why it helps, but this
specific device caused us trouble like bad timing after
grab_nic_access..


>
> >
> > Thanks,
> > Rui
