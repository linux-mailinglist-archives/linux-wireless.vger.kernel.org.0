Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA621678105
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 17:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjAWQLw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 11:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWQLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 11:11:51 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A3726856
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 08:11:38 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id d188so10785165oia.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 08:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hY16O/uIZ5tCbu+2dbDDahgkSGbx7vhM0HiuDlzs4jg=;
        b=dAtpetOpa16Rcj+P0BsuTeZXX5ZWVMe2VjbQzvAcVpxr4kuM7oQWYQikhMPv/W2kNS
         K+NYKerK0djFurX8/hzMzsNeHoCA6fpCChoT9kzR3Jn3vJ22eM4j+LzG0GUQP1RSVO9X
         Cs9+ZthhfQyrHEYMvkwENLLWl2mRlxEA6KGIV6VFGzKk3HFFuFaLRGyRVaPvOwWDIu9q
         v/gnBuTKk4BsxyjbGvyTp4OhtKfAXUELJLy8P0C1cfaWWax25BUX1zIMZTeIV8gt2o8h
         UshZBYk1iOtgFpr4VqFmgFBvarmGaQYtjdXRlXbd3+TXFGwZhCC+Dr4DiWP3l4SX1iZs
         AHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY16O/uIZ5tCbu+2dbDDahgkSGbx7vhM0HiuDlzs4jg=;
        b=ukKtI9W/kCkJCaX2bmg8hzDM8+Fa0D8EFQQhkQikOHKEhvllhSE3JfoK1zIe9wYIae
         sBp4X/A+3i1G2cmD2T2GkJnAv+0i4p5g5Fq0LyL/9bTr4EdZMQClZIGiDkSbNmoeDS5V
         yn3HOnrC4rYbGCRCZsRmFHKC1tBm8QyvE4sYcKyrA7nPFEZOrCfPLNQkZ7vYXEZgl+Jn
         ZU+Meu1jI09bY8keJBuziXgiagodeQ1/NceAWAQqM8G1NzSTveERTo2sJmgSqpSDixkJ
         EVNxJmgE9nWi0kS8jKBReGb/RT6qYosmdqkrY5zi4E7VpxyXvEoMREyviBoDYx1pHdur
         UJDA==
X-Gm-Message-State: AFqh2koqh28W7/WkRw4eOml2aXnOFjroWkaoGjc/yf1rLCT8Nlu2RK6v
        l5TYm2e9LeJ0VyXDa61MG/HFLdiOzooz42kkt7c=
X-Google-Smtp-Source: AMrXdXuxh2/sfSqeNEAfINh8FkR3AwnRQI9ywWnqvkFui3smYJ9zypCE8d0aLYHVSocjTqW84WUhhmt8p37EGy7Shxo=
X-Received: by 2002:a05:6808:6247:b0:364:db8b:3945 with SMTP id
 dt7-20020a056808624700b00364db8b3945mr1212624oib.259.1674490297326; Mon, 23
 Jan 2023 08:11:37 -0800 (PST)
MIME-Version: 1.0
References: <CABPxzY+_Mjercvvh5XHmtHdNCKXDupVbL4PKXgzZPiUesRsRMA@mail.gmail.com>
 <714df952bf0b0f53a2f7a6714083e93e39632f49.camel@intel.com>
In-Reply-To: <714df952bf0b0f53a2f7a6714083e93e39632f49.camel@intel.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 23 Jan 2023 21:41:25 +0530
Message-ID: <CABPxzYKc58mqCjyy+rzbrhZm5wCRKUm1Vs=HiP9OVsVSO3DiKA@mail.gmail.com>
Subject: Re: iwlwifi: Monitor mode broken with 6.1.0
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "egrumbach@gmail.com" <egrumbach@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 23, 2023 at 6:29 PM Greenman, Gregory
<gregory.greenman@intel.com> wrote:
>
> Hi!
>
> On Mon, 2023-01-23 at 14:07 +0530, Krishna Chaitanya wrote:
> > Hi,
> >
> > I am using the ath.git (ea726a8d305a : was testing external Atheros
> > cards) + linux-firmware (bb2d42d) and the monitor mode stopped working
> > with iwlwifi. There is a warning from UBSAN: "UBSAN:
> > shift-out-of-bounds in
> > drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c:657:22".
> >
> > The root cause was this c6ce1c74ef292 which defaults the assignment to
> > 0xFFFF and then that was being used for the shift.
> >
> > I have tried to fix the warning with the below patch (just for an
> > experiment, not a proper one), the warning is gone, but no frames are
> > seen in Wireshark.
> >
> > Below is the version information, any help is appreciated, monitor
> > mode is important for me.
> >
> > lspci: Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)
> >
> > [  +0.003790] iwlwifi 0000:00:14.3: api flags index 2 larger than
> > supported by driver
> > [  +0.000046] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version:
> > 89.3.35.37
> > [  +0.001519] iwlwifi 0000:00:14.3: loaded firmware version
> > 72.daa05125.0 QuZ-a0-hr-b0-72.ucode op_mode iwlmvm
> > [  +0.034887] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201
> > 160MHz, REV=0x351
> > [  +0.000083] thermal thermal_zone7: failed to read out thermal zone (-61)
> > [  +0.122144] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
> > [  +0.065701] iwlwifi 0000:00:14.3: base HW address: 4c:79:6e:90:94:71
> > [  +0.019826] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
> > [ +14.210987] device mon0 entered promiscuous mode
> > [Jan24 18:20] device mon0 left promiscuous mode
> >
> > ---
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > index 83abfe996138..591f9fdd0ec4 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > @@ -654,9 +654,13 @@ static int iwl_mvm_mac_ctxt_cmd_listener(struct
> > iwl_mvm *mvm,
> >                                          u32 action)
> >  {
> >         struct iwl_mac_ctx_cmd cmd = {};
> > -       u32 tfd_queue_msk = BIT(mvm->snif_queue);
> > +       u32 tfd_queue_msk = 0;
> >         int ret;
> >
> > +       if (mvm->snif_queue != IWL_MVM_INVALID_QUEUE) {
> > +               tfd_queue_msk = BIT(mvm->snif_queue);
> > +       }
> > +
> >         WARN_ON(vif->type != NL80211_IFTYPE_MONITOR);
> >
> >         iwl_mvm_mac_ctxt_cmd_common(mvm, vif, &cmd, NULL, action);
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > index 515dd3e0730d..784a7f72b819 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > @@ -2084,6 +2084,7 @@ static int iwl_mvm_add_int_sta_with_queue(struct
> > iwl_mvm *mvm, int macidx,
> >                 }
> >
> >                 *queue = txq;
> > +               sta->tfd_queue_msk = BIT(*queue);
> >         }
> >
> >         return 0;
> > @@ -2092,11 +2093,15 @@ static int
> > iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
> >  int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
> >  {
> >         int ret;
> > +       u32 tfd_queue_msk = 0;
> >
> >         lockdep_assert_held(&mvm->mutex);
> > +       if (mvm->aux_queue != IWL_MVM_INVALID_QUEUE) {
> > +               tfd_queue_msk = BIT(mvm->aux_queue);
> > +       }
> >
> >         /* Allocate aux station and assign to it the aux queue */
> > -       ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, BIT(mvm->aux_queue),
> > +       ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, tfd_queue_msk,
> >                                        NL80211_IFTYPE_UNSPECIFIED,
> >                                        IWL_STA_AUX_ACTIVITY);
> >         if (ret)
>
> This bug was already fixed in our internal repository. You can use the driver from [1]
> until this fix will make it's way to the upstream (please use master branch).
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git
Excellent, thanks for the reply.

The driver in [1] was not building due to 20b0b53aca436 but it was simple
to fix, after installation (and reboot) the warning is gone, but still
unable to sniff.

FW is now updated to:
loaded firmware version 77.2dda880d.0 QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
