Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3724415A70
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhIWJBE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhIWJBD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 05:01:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F34C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 01:59:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 145so5086402pfz.11
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IwZWh7TVy1EsJ4/Xl5ph0XhiwHhsFLWIFyxY44IHD6c=;
        b=EtCi7o76f+Y3DWLNDkwwIIvlAA4cVI0p3JtUo3aGd6gHqYvwHf5nl75xwRDeWi9NyX
         04vxuYbauytQ0qUNsZBilOckJOidDrCsNThS00KJPtvOjD63yUtWG+JBvtIp7OIPpQM6
         ZD/LS9uAIA1YOmyHt0b2n9l5BnOXO9wtgQpGzk3G0IAnm+IjPClViLRS0nH3h0BAb97p
         Gp+3xBRf2C66aNcS/Uy2Yz2bryZLoDolIg1QCpXz0tlDZEMdBLcJ8pANb0qejWWBxYCP
         VFIo1hlxn3CV59KkHhVS8tvGcnCMsfdmQG8h9SwRiE0sMNb3mcVfXJWUM6+MpfQigzIU
         h5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IwZWh7TVy1EsJ4/Xl5ph0XhiwHhsFLWIFyxY44IHD6c=;
        b=xRYcsTibvObUHXp4W/w70zoDgayA2wcPuJEpockvlhTIpOlcYMcZflxs5GONjg9avc
         nwFMb6vT6SrVAkP3BSIKF9PPRsirwtydm0DbeQAt7OeYbYfIN2Cx1H5ZVI1SkN2M/nH3
         h/gj/lge7oQsvsBVI1qJ86YhLi+ULAaFWmYNHhJHSnQ8oMhK7eeuiCsScPFZgLafR42N
         E8BK+GOIj2VHGpAIbcfhvpZBPmbGYcqa0bq++ntZUFQKilb3rmQeG9Gom/LLAok55iHu
         lYQjhRRe0QjEBhiqduNPceraZA4X5VVV7Nq1R6m1KUzBx8mWnj+3QtZH7TsETjNrLNTD
         vEUg==
X-Gm-Message-State: AOAM533KjLAanqRe0cWxF5oRG5jhgojkaMRBWhpJbBnrovBlIz7VmyfI
        KmH5vuXnAFzuEa+n8GLMOEZz
X-Google-Smtp-Source: ABdhPJwwaXILnaoOCOksr0wpBKXGHCF7fnZfoGHzfcogdAEo2/ZL/8T1fOEFbOYoPvUfpQ98obaaKw==
X-Received: by 2002:a63:770b:: with SMTP id s11mr3133224pgc.275.1632387572197;
        Thu, 23 Sep 2021 01:59:32 -0700 (PDT)
Received: from thinkpad ([117.193.215.78])
        by smtp.gmail.com with ESMTPSA id s2sm8830002pjs.56.2021.09.23.01.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 01:59:31 -0700 (PDT)
Date:   Thu, 23 Sep 2021 14:29:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] mhi: ath11k resume fails on some devices
Message-ID: <20210923085926.GD6083@thinkpad>
References: <871r5p0x2u.fsf@codeaurora.org>
 <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <20210916111218.GA12918@thinkpad>
 <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
 <20210916163529.GA9027@thinkpad>
 <87k0jgxyjp.fsf@codeaurora.org>
 <20210916171927.GB9027@thinkpad>
 <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 23, 2021 at 04:34:43PM +0800, Carl Huang wrote:
> On 2021-09-17 01:19, Manivannan Sadhasivam wrote:
> > On Thu, Sep 16, 2021 at 07:42:02PM +0300, Kalle Valo wrote:
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> > > 
> > > > On Thu, Sep 16, 2021 at 01:18:22PM +0200, Loic Poulain wrote:
> > > >> Le jeu. 16 sept. 2021 à 13:12, Manivannan Sadhasivam <
> > > >> manivannan.sadhasivam@linaro.org> a écrit :
> > > >>
> > > >
> > > > [...]
> > > >
> > > >> > If things seems to work fine without that patch, then it implies that
> > > >> > setting M0
> > > >> > state works during resume. I think we should just revert that patch.
> > > >> >
> > > >> > Loic, did that patch fix any issue for you or it was a cosmetic fix only?
> > > >>
> > > >>
> > > >> It fixes sdx modem resuming issue, without that we don’t know modem needs
> > > >> to be reinitialized.
> > > >>
> > > >
> > > > Okay. Then in that case, the recovery mechanism has to be added to the ath11k
> > > > MHI controller.
> > > 
> > > What does that mean in practise, do you have any pointers or
> > > examples? I
> > > have no clue what you are proposing :)
> > > 
> > 
> > Take a look at the mhi_pci_recovery_work() function below:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi/pci_generic.c#n610
> > 
> > You need to implement something similar that basically powers up the MHI
> > endpoint (QCA6390) in case pm_resume() fails. At minimum, you need to
> > call
> > below functions:
> > 
> > # Check if the device is powered on. If yes, then power it down to bring
> > it back
> > mhi_power_down()
> > mhi_unprepare_after_power_down()
> > 
> > # Power up the device
> > mhi_prepare_for_power_up()
> > mhi_sync_power_up()
> > 
> > This implies that the WLAN device has been powered off during suspend,
> > so the
> > resume fails and we are bringing the device back to working state.
> > 
> This is fine for platform which doesn't provide power supply during suspend.
> But NUC has power supply in suspend state.

If NUC retains power supply during suspend then it should work with that commit.
During resume, the device is expected to be in M3 state and that's what the
commit verifies.

If the device is in a different state, then most likely the device have power
cycled.

> QCA6390 on NUC works after just reverting this commit also proves NUC has
> power supply in
> suspend state.
> 

That's because we allowed the device to be in any state during resume and if it
responds to the M0 transition it worked.

> The reason is MHI-STATUS register can't be read somehow in M3 state on NUC.

No, that's not correct.

> Does the MHI spec state that MHI-STATUS register can be read in M3 state?
> 

Yes, all the MHI registers are accessible in all states. During M3, both MHI
host and device (if supported) will transition to D3 Cold. Then during resume,
host will switch to D0 link state and will also notify the device to enter D0.

For aid debugging, please see the state the device is in during mhi_pm_resume().
You can use below diff:

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index fb99e3727155..482d55dd209e 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -898,6 +898,9 @@ int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
        if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
                return -EIO;
 
+       dev_info(dev, "Device state: %s\n",
+                TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
+
        if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3)
                return -EINVAL;


Thanks,
Mani
