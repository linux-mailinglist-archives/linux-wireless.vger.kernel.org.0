Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F126202E6A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 04:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgFVCg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 22:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgFVCg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 22:36:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2398C061794;
        Sun, 21 Jun 2020 19:36:27 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g139so7887731lfd.10;
        Sun, 21 Jun 2020 19:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brsTpuDT663Ub3YFvhMHjyZRDtv4MEIUf2dZ4ezLQvI=;
        b=YQjoctLjn8JZYY80zeRdn6QirrjhP48hDICj+nm429Y+NjBOb1/eWUWC3SJ5vfSwjc
         VUiMUDsfqJqBtKKDgPAyK0URfKTYajhsyiLDKVEomRHut66XyGai5aJA2vLJozEDVlZI
         2U9o0HmssceXXc4XmU7HYQAs7dfazFA8Am6M+jm2g5VjYUJIV1RnQVRpfRTG73E2OSzD
         nHscVMNHTMCZqoUD0gowqmRhZsYYGhHDyq4QjfjnrQcRR3623t9EEgrhcrU3RuToIJeE
         0spyTTanA4wo+ZlGpnOSszQWLqu7rWOm7hP3Z/4C5BP9jhPfR2BYF/02hmQQsO8mwF6x
         7TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brsTpuDT663Ub3YFvhMHjyZRDtv4MEIUf2dZ4ezLQvI=;
        b=e98xzJV5wYHKp2f/FFCjOhTOWQ2jCAtwUOw6bEv0oGzZrBuzgiqZcFwb2vwZpGo8CI
         rEOvH7CVbInk2a2slHAHu78J681vqwBkclkbSN9MMNLoFtZPoPiLrY8gyLAIWJqERDAR
         onS3OaartliX6NKZE4V8k8+v0jxqFr5DmdzthMDD9Mg5VXxdLbUUCPU2aZVmXjQhP8Qw
         UQDxKBBuEvMk488ahQ/YLfBVO36SxH7sEfj2+YGExdLQ9f0vgtT+Da6clS0f5nqugfu1
         OfWufzxpdtwMIs9C9rO6mFFW21Kd0cnN04AVE5H2deYQgMggwILI3weKJDEngDBr2Sxu
         JZpA==
X-Gm-Message-State: AOAM530FevJg9DLzF07ujlYrSpfIP5NW0IyeDpnTb0quBMkSC7QnydKJ
        fA1uZGFb9NvFbXsUQVvWnDdNEvEWC+lP0fJLkoWHNg==
X-Google-Smtp-Source: ABdhPJy0RrrpnQqNTViywItrtiOZhkZpeD0w6Ko2o5KLmgmz9+9uviqJlsEJ+pt3tDeEIPX65WGt98/IE0GAEgdkGgM=
X-Received: by 2002:a05:6512:682:: with SMTP id t2mr8442039lfe.101.1592793385962;
 Sun, 21 Jun 2020 19:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <1592458104-2961-1-git-send-email-akolli@codeaurora.org>
 <1592458104-2961-3-git-send-email-akolli@codeaurora.org> <CAGRGNgV74fCD1gb=rXEe1BMN5+5stYeX3W6eKc4-do76TBmFqA@mail.gmail.com>
 <34ed705f28b40fab493b8c888138e6a7@codeaurora.org>
In-Reply-To: <34ed705f28b40fab493b8c888138e6a7@codeaurora.org>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 22 Jun 2020 12:36:14 +1000
Message-ID: <CAGRGNgXyxGUZQRnT_uZJ74=YTVEomTvsL_weET1WuGqA1SHWBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ath11k: copy ce service configs to hw_params
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Anilkumar,

On Sat, Jun 20, 2020 at 2:24 AM <akolli@codeaurora.org> wrote:
>
> On 2020-06-19 04:40, Julian Calaby wrote:
> > Hi Anilkumar,
> >
> > On Thu, Jun 18, 2020 at 3:31 PM Anilkumar Kolli <akolli@codeaurora.org>
> > wrote:
> >>
> >> No functional changes, added target ce service configurations
> >> to hw_params.
> >>
> >> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> >> ---
> >> V3:
> >>  - added ce svc configs in hw_params
> >>
> >>  drivers/net/wireless/ath/ath11k/ahb.c  | 20 +++++++++++++++-----
> >>  drivers/net/wireless/ath/ath11k/core.c |  8 +-------
> >>  drivers/net/wireless/ath/ath11k/core.h |  1 +
> >>  drivers/net/wireless/ath/ath11k/hw.h   |  2 ++
> >>  4 files changed, 19 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c
> >> b/drivers/net/wireless/ath/ath11k/ahb.c
> >> index 7e9bfeaaf4d2..aa74d27e5871 100644
> >> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> >> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> >> @@ -152,7 +152,7 @@ static const struct ce_pipe_config
> >> target_ce_config_wlan[] = {
> >>   * This table is derived from the CE_PCI TABLE, above.
> >>   * It is passed to the Target at startup for use by firmware.
> >>   */
> >> -static const struct service_to_pipe target_service_to_ce_map_wlan[] =
> >> {
> >> +static const struct service_to_pipe
> >> target_service_to_ce_map_wlan_ipq8074[] = {
> >>         {
> >>                 .service_id =
> >> __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
> >>                 .pipedir = __cpu_to_le32(PIPEDIR_OUT),  /* out = UL =
> >> host -> target */
> >> @@ -644,8 +644,8 @@ static void ath11k_ahb_init_qmi_ce_config(struct
> >> ath11k_base *ab)
> >>
> >>         cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
> >>         cfg->tgt_ce = target_ce_config_wlan;
> >> -       cfg->svc_to_ce_map_len =
> >> ARRAY_SIZE(target_service_to_ce_map_wlan);
> >> -       cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
> >> +       cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
> >> +       cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
> >>  }
> >>
> >>  static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
> >> @@ -853,8 +853,8 @@ static int ath11k_ahb_map_service_to_pipe(struct
> >> ath11k_base *ab, u16 service_id
> >>         bool ul_set = false, dl_set = false;
> >>         int i;
> >>
> >> -       for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan);
> >> i++) {
> >> -               entry = &target_service_to_ce_map_wlan[i];
> >> +       for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
> >> +               entry = &ab->hw_params.svc_to_ce_map[i];
> >>
> >>                 if (__le32_to_cpu(entry->service_id) != service_id)
> >>                         continue;
> >> @@ -950,6 +950,16 @@ static int ath11k_ahb_probe(struct
> >> platform_device *pdev)
> >>                 goto err_hal_srng_deinit;
> >>         }
> >>
> >> +       ret = ath11k_init_hw_params(ab);
> >> +       if (ret) {
> >> +               ath11k_err(ab, "failed to get hw params %d\n", ret);
> >> +               return ret;
> >> +       }
> >> +
> >> +       ab->hw_params.svc_to_ce_map_len =
> >> +
> >> ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
> >> +       ab->hw_params.svc_to_ce_map =
> >> target_service_to_ce_map_wlan_ipq8074;
> >
> > I think you misunderstood my point about this, the point wasn't to
> > copy the svc map to hw_params, but define it in hw_params:
> >
> > +       {
> > +               .hw_rev = ATH11K_HW_IPQ6018,
> > +               .name = "ipq6018 hw1.0",
> > +               .fw = {
> > +                       .dir = "IPQ6018/hw1.0",
> > +                       .board_size = 256 * 1024,
> > +                       .cal_size = 256 * 1024,
> > +               },
> > +               .max_radios = 2,
> > +               .bdf_addr = 0x4ABC0000,
> > +               .hw_ops = &ipq6018_ops,
> > +               .svc_to_ce_map_len =
> > ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018,
> > +               .svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018,
> > +       },
> >
> > That completely eliminates special case code based on the hardware ID
> > in the driver.
> >
> The static array of structures target_service_to_ce_map_wlan_ipq6018[]
> is defined in ahb.c and hw_params are initialised in core.c, this will
> not work. no?

My understanding, and please correct me if I'm wrong, is that the
service map is a property of the hardware. So why not define all the
hardware properties in one place?

You could either move the hardware definitions and service maps to a
new file (maybe ahb_conf.c), move those maps to ahb.c or just add them
to some header file so ahb.c can reference them.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
