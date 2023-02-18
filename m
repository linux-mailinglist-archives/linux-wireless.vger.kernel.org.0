Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C269B9CA
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Feb 2023 12:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBRL3P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Feb 2023 06:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjBRL3O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Feb 2023 06:29:14 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642616AC6
        for <linux-wireless@vger.kernel.org>; Sat, 18 Feb 2023 03:28:44 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bd2so722189oib.1
        for <linux-wireless@vger.kernel.org>; Sat, 18 Feb 2023 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr1qEtYI74VeKd9/erN88VQgaqW4D/kMWZOLeLTd4IY=;
        b=gp+sw8WVslRU1zZhvrczOkjmEalPKN+B1Byf5GY8EltRo7oeYs4YtjRO+G0/OICMHw
         Le/mOWvt3BXrEnqhKODstF02I2CZRzfMg7VGCf/kM6ySAEr5UFfyVMDyU2l48d/7sYK8
         fCiDex7Nk1OMZDxRbicg9xy88Ja/wO9+jbTvigP1VFtpOeHFgBAqGTovURST0KRaS+cX
         ri+Cu2gH3388rq8l31JLNvzXMiP9DLjVSoNa8Ia9xRuckfvhmYOjRxBcIOgVqHt85e1h
         SuIEKeXgvCLcsulkmMJiQuSuBVDGEKLuQyWEzpojmkbWcVU+jD5Mg7A5jGMv7x/f37uX
         cbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lr1qEtYI74VeKd9/erN88VQgaqW4D/kMWZOLeLTd4IY=;
        b=Mb+i0gbw2KOeqqTbduBdj4I8oxwqhcImjp8LFrCCu2Z97mLufTDgeIcZtYlw+463gS
         tkakTYo7cW2dzhtPJI5ngHxsS9IMZtB614rqzFniLgRIORq0YSD3Z/m3G3jO4WeKZN6z
         LdwS68iPKUh2eJljeiFmCRtMSWMBLKHR7K4qY9N1J59tH32j4dA9BATmLPS11hJ86YoP
         4fsGWlp6fGAYTRQpZLlduNlksP9Evupjnqa1yn/Dt7n2v2/i7MI7/0yCNoFhOSgBCzUj
         nMn6fhAhJAuY2J9oKVij2Op74jVHEmXCo/7Sc7hpToov0kr4CFF5DrGqqU9xiYBRhH8/
         +7ZQ==
X-Gm-Message-State: AO0yUKXStYXZ8HwjJLiV7aUXEdE6UBxBiDxg6BWdZIVFTfGVeXVrrm+y
        O9O5KBVQX2ZZa4FslB3n2/+RD0t490PjnScWhZ4=
X-Google-Smtp-Source: AK7set8nZsg6k7pW/S3+hkcnKlvDofQteH140ka2iDWAKhPKNw3oD0BuLfNFWFA6cQ2zzUUDeCKZY1ok9BpRuIcUvNo=
X-Received: by 2002:a05:6808:120b:b0:354:7fd4:f17b with SMTP id
 a11-20020a056808120b00b003547fd4f17bmr621608oil.221.1676719722796; Sat, 18
 Feb 2023 03:28:42 -0800 (PST)
MIME-Version: 1.0
References: <CABPxzY+_Mjercvvh5XHmtHdNCKXDupVbL4PKXgzZPiUesRsRMA@mail.gmail.com>
 <714df952bf0b0f53a2f7a6714083e93e39632f49.camel@intel.com>
 <CABPxzYKc58mqCjyy+rzbrhZm5wCRKUm1Vs=HiP9OVsVSO3DiKA@mail.gmail.com>
 <CABPxzYLhzNgM3pRZT1LuPMA_SWwOss12KZzF5+QEkKuOnazQ3A@mail.gmail.com> <8648ceb22dace0ac7098fd4c8d11927c4df9f284.camel@intel.com>
In-Reply-To: <8648ceb22dace0ac7098fd4c8d11927c4df9f284.camel@intel.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Sat, 18 Feb 2023 16:58:30 +0530
Message-ID: <CABPxzY+JcejXJLkZwAtt0mrJ_NZOH8+jbrQKenqHLJrYS0MQSg@mail.gmail.com>
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

On Sun, Feb 12, 2023 at 3:35 PM Greenman, Gregory
<gregory.greenman@intel.com> wrote:
>
> On Thu, 2023-02-09 at 20:21 +0530, Krishna Chaitanya wrote:
> > On Mon, Jan 23, 2023 at 9:41 PM Krishna Chaitanya
> > <chaitanya.mgit@gmail.com> wrote:
> > >
> > > On Mon, Jan 23, 2023 at 6:29 PM Greenman, Gregory
> > > <gregory.greenman@intel.com> wrote:
> > > >
> > > > Hi!
> > > >
> > > > On Mon, 2023-01-23 at 14:07 +0530, Krishna Chaitanya wrote:
> > > > > Hi,
> > > > >
> > > > > I am using the ath.git (ea726a8d305a : was testing external Atheros
> > > > > cards) + linux-firmware (bb2d42d) and the monitor mode stopped working
> > > > > with iwlwifi. There is a warning from UBSAN: "UBSAN:
> > > > > shift-out-of-bounds in
> > > > > drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c:657:22".
> > > > >
> > > > > The root cause was this c6ce1c74ef292 which defaults the assignment to
> > > > > 0xFFFF and then that was being used for the shift.
> > > > >
> > > > > I have tried to fix the warning with the below patch (just for an
> > > > > experiment, not a proper one), the warning is gone, but no frames are
> > > > > seen in Wireshark.
> > > > >
> > > > > Below is the version information, any help is appreciated, monitor
> > > > > mode is important for me.
> > > > >
> > > > > lspci: Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)
> > > > >
> > > > > [  +0.003790] iwlwifi 0000:00:14.3: api flags index 2 larger than
> > > > > supported by driver
> > > > > [  +0.000046] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version:
> > > > > 89.3.35.37
> > > > > [  +0.001519] iwlwifi 0000:00:14.3: loaded firmware version
> > > > > 72.daa05125.0 QuZ-a0-hr-b0-72.ucode op_mode iwlmvm
> > > > > [  +0.034887] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201
> > > > > 160MHz, REV=0x351
> > > > > [  +0.000083] thermal thermal_zone7: failed to read out thermal zone (-61)
> > > > > [  +0.122144] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
> > > > > [  +0.065701] iwlwifi 0000:00:14.3: base HW address: 4c:79:6e:90:94:71
> > > > > [  +0.019826] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
> > > > > [ +14.210987] device mon0 entered promiscuous mode
> > > > > [Jan24 18:20] device mon0 left promiscuous mode
> > > > >
> > > > > ---
> > > > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > > > > b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > > > > index 83abfe996138..591f9fdd0ec4 100644
> > > > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > > > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> > > > > @@ -654,9 +654,13 @@ static int iwl_mvm_mac_ctxt_cmd_listener(struct
> > > > > iwl_mvm *mvm,
> > > > >                                          u32 action)
> > > > >  {
> > > > >         struct iwl_mac_ctx_cmd cmd = {};
> > > > > -       u32 tfd_queue_msk = BIT(mvm->snif_queue);
> > > > > +       u32 tfd_queue_msk = 0;
> > > > >         int ret;
> > > > >
> > > > > +       if (mvm->snif_queue != IWL_MVM_INVALID_QUEUE) {
> > > > > +               tfd_queue_msk = BIT(mvm->snif_queue);
> > > > > +       }
> > > > > +
> > > > >         WARN_ON(vif->type != NL80211_IFTYPE_MONITOR);
> > > > >
> > > > >         iwl_mvm_mac_ctxt_cmd_common(mvm, vif, &cmd, NULL, action);
> > > > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > > > > b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > > > > index 515dd3e0730d..784a7f72b819 100644
> > > > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > > > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
> > > > > @@ -2084,6 +2084,7 @@ static int iwl_mvm_add_int_sta_with_queue(struct
> > > > > iwl_mvm *mvm, int macidx,
> > > > >                 }
> > > > >
> > > > >                 *queue = txq;
> > > > > +               sta->tfd_queue_msk = BIT(*queue);
> > > > >         }
> > > > >
> > > > >         return 0;
> > > > > @@ -2092,11 +2093,15 @@ static int
> > > > > iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
> > > > >  int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
> > > > >  {
> > > > >         int ret;
> > > > > +       u32 tfd_queue_msk = 0;
> > > > >
> > > > >         lockdep_assert_held(&mvm->mutex);
> > > > > +       if (mvm->aux_queue != IWL_MVM_INVALID_QUEUE) {
> > > > > +               tfd_queue_msk = BIT(mvm->aux_queue);
> > > > > +       }
> > > > >
> > > > >         /* Allocate aux station and assign to it the aux queue */
> > > > > -       ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, BIT(mvm->aux_queue),
> > > > > +       ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, tfd_queue_msk,
> > > > >                                        NL80211_IFTYPE_UNSPECIFIED,
> > > > >                                        IWL_STA_AUX_ACTIVITY);
> > > > >         if (ret)
> > > >
> > > > This bug was already fixed in our internal repository. You can use the driver from [1]
> > > > until this fix will make it's way to the upstream (please use master branch).
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git
> > > Excellent, thanks for the reply.
> > >
> > > The driver in [1] was not building due to 20b0b53aca436 but it was simple
> > > to fix, after installation (and reboot) the warning is gone, but still
> > > unable to sniff.
> > >
> > > FW is now updated to:
> > > loaded firmware version 77.2dda880d.0 QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
> > Any ideas why it still doesn't work? Should I try something else,
> > please suggest.
>
> We'll try to reproduce it internally, if it'll work for us, I'll ask for some debug data.
> Can you please open a new ticket in bugzilla, so it'll be easier for us to track?
> Here is the wiki page regarding bugzilla for iwlwifi:
> https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging
FYI, https://bugzilla.kernel.org/show_bug.cgi?id=217051
