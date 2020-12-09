Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC32D4CAB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgLIVRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgLIVRh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:17:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D0C0613CF;
        Wed,  9 Dec 2020 13:16:57 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id s21so1931900pfu.13;
        Wed, 09 Dec 2020 13:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kde5qioibKFTqTbk8Z1S5mJRQCZZsheqyuONyQlU+mM=;
        b=NavI8S8HeiEzZ7/x1B3Hvj28veiDLwqcUfiG/BQJ/mnHp7AF5+4fF+8b0Oc60tZXQo
         XteJGO5fVhfE8TVfZ6EjB+noAShoAflt5JSccAkzPuhhznVp6+7zYz8PpQHjKoPTpa0K
         2KQ7i3+My0sKbPdJ4s2/oD8CMkOwInpRXdWK7g9dj+HRoU0GInqkJQLoc9xhevkh7yZZ
         kFAmBAU9o6P04sAz6IQnC75FbF6JF+ln9A6liI2YHdeYwDtrFsKsByOaAwYoYns4Brg8
         7cY/jZjRbXWbWjKC9cg3i7IYAsbffQVXavNFq/v3GaI3ilf/9/YuqqYyynTecxm6jBST
         RStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kde5qioibKFTqTbk8Z1S5mJRQCZZsheqyuONyQlU+mM=;
        b=L8E3NmpEJKwYt9FTvlpxowt/kJPV/GKohZD4IRyxBvptf2/EfFGxjEDc8B+Gdq4X5i
         LHCZZGNoZsI1zIwNZy5fc7AUOYIBhLPr81wOfwsrcYGVqDtIXt0J+pUbxwF5xbSdFrMq
         42J2Qm/izcIObLmnhFhXp2r0fJwvGl41iGmfuCcgoztNQ0dcTV8n1njexCQ0+RgG4AqZ
         R3+dzpOrzl7B6PQDRqcGEhVecxtewqzopKv7Lr/IsfhLA3fXsqMxZ0dMnS9maPblwGqC
         HVx1x61MD7Vu82MuRTOY3NkqGuw4nbeDiGKdwDQPkR7WOW6u/6GsOEP/Wck5d+7U/rlc
         fmaw==
X-Gm-Message-State: AOAM530uOBdxYul8g9YpGASfxHQXM+mg8+uuTLF9dyP6Gy1FVMidOM1D
        O388Y1QwiD8869mAkGgu6HlXUvvtfKuZgS7XjQ==
X-Google-Smtp-Source: ABdhPJy4pfGvQB2Kq/WKK3w+RgvNCa1tQEKOHNTNej4Ix2zGetKCzZpOGGMwlCc07q4zDTK3QS35eHXJswYLS8y+aVw=
X-Received: by 2002:a17:90a:f0c1:: with SMTP id fa1mr3867972pjb.148.1607548616356;
 Wed, 09 Dec 2020 13:16:56 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
 <CALjTZvYZEbgfLEzxQdafJT6CFz76prA4+YM2EGA8k5Dgn3gigw@mail.gmail.com>
 <CANUX_P1YWSudJfwyuFVg-qdBHwQvQJiZayZBMY8E4it0qwB5Hw@mail.gmail.com> <CANUX_P0sOAdRjOgg=ogAHmQdTXp5UKyW2XQQRComa4Rv3Y-toQ@mail.gmail.com>
In-Reply-To: <CANUX_P0sOAdRjOgg=ogAHmQdTXp5UKyW2XQQRComa4Rv3Y-toQ@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 9 Dec 2020 21:16:45 +0000
Message-ID: <CALjTZvYfJVjxRO4Avc3rV+W+HO-vBABxwF=UUETzDeNv_QBbhg@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Emmanuel Grumbach <egrumbach@gmail.com>
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

Hi again, Emmanuel,

On Wed, 9 Dec 2020 at 21:07, Emmanuel Grumbach <egrumbach@gmail.com> wrote:
>
> Indeed, the bit is reverse logic. So we can put that aside.
> Frankly, I have no clue. You can try our backport tree to bisect,
> should be easier..
> What I see here is that your GP_CTRL value is 080003d8
>
> #define CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW          (0x08000000)
> which means sense since apparently, HW RF-Kill was asserted.
> #define CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP         (0x00000010)
> Which means that the device is going to sleep... And that's the problem:
>
> iwl_trans_pcie_grab_nic_access:
>         ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
>                            CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN,
>                            (CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
>                             CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP), 15000);
>         if (unlikely(ret < 0)) {
>                 u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
>
>                 WARN_ONCE(1,
>                           "Timeout waiting for hardware access
> (CSR_GP_CNTRL 0x%08x)\n",
>                           cntrl);
>
> but I'd expect the splat in your log...
> Or maybe you can't load the firmware?

Well, my kernel doesn't have any modules, it's all built-in. The
firmware is obviously loading fine, otherwise the card wouldn't work,
but yeah, that WARN_ONCE hasn't triggered at all.

> Can you try this:
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index 2fffbbc8462f..748300752630 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -2121,6 +2121,7 @@ static bool
> iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
>          * track nic_access anyway.
>          */
>         __release(&trans_pcie->reg_lock);
> +       mdelay(1);
>         return true;
>  }
>
> If that helps, then... I'd have no clue why it helps, but this
> specific device caused us trouble like bad timing after
> grab_nic_access..

I'll give it a spin. Nasty hack, but if it works, it works. :)

Thanks,
Rui
