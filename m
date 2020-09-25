Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E12279092
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 20:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgIYSdN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgIYSdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 14:33:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E43C0613D3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Sep 2020 11:33:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so4037325wmh.4
        for <linux-wireless@vger.kernel.org>; Fri, 25 Sep 2020 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wr5b8CFYdqzzo6Xedl1l6pleUPcSYgGVWdKtDphUtU=;
        b=IHDkMpVxwv/dF8C95VxnNNlR2HFW37aiZNZWFsIwEJEURZGGBHDbEuaG5yMtGs7Sce
         ZKGVnSDDFZaRvuTicpWkk1reDSLon0PS7d+uwgJuIcfROO482TDn2DixCWyPFCHN/4PX
         munK4n6yIq0pv7+ouU4T87VyALlYwRm319Ucu3a+XT/bbXEYiG6eJaGHi5BCbHkE5eWy
         fAwZiF2ecRHcQAJopNydaYIFLByoRdZSMIvmBj1kWYofEmArWiPbhuKsmuLFwZm9GIFp
         ZGRsbSkTfS1igKgJRB9c71NM4mQ2PO/r994MgJmTUzJCJFFgIF6BHPmzvA7bdlI6jvTY
         82Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wr5b8CFYdqzzo6Xedl1l6pleUPcSYgGVWdKtDphUtU=;
        b=OKpU0/sTdwOINKDKbmC0B0UQ+jqwL0sHa/+XXRWuRdgQOhsKjtoEPd2KrBIKFPjy84
         eHl257POW3dcriuQ6ZEHg6P013k6o23G1fmOmSk3jzyfBlT9vFeYR/QQqJMFCzUM1k4x
         k2YJ4Sv/Y87ZfZ0dkaFlwibK8KRq44CxBKWagTlTLJtVKBWUZpx7Ke4j9OhUXe1HbO4x
         CPZ4vodkYYwFfpwlpiKxcrwubIejdlFCcR0XuddLf8DLDxXMQITHnvjs5ssGWGzs731d
         AscNy18ZD26wS3NvdlWWi4CnrNIBzth81+6TsmLSFBGd/CDkkv+gihEM6x2wRm1Ujw29
         JmQg==
X-Gm-Message-State: AOAM533JJ2rkUMTXdHQhseBs7oUgQ7VbVA9M7R0lEpHpk8ks32uYgqWO
        nNuTK5DEaiMqQC1ITj1LVFoJzx12J+SsJ4NfltbmxQ==
X-Google-Smtp-Source: ABdhPJw8c61BhX0/8pflJJeMDcnBp4MI+ROLCChhpS0j+CxQAmOUZ8qpXphp1hlcL62YpZDV8sWD/MxOihr2Pj6GLyw=
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr4603352wmj.16.1601058790123;
 Fri, 25 Sep 2020 11:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <1600328501-8832-1-git-send-email-amit.pundir@linaro.org>
 <87d02bnnll.fsf@codeaurora.org> <20200925152739.GE2510@yoga>
In-Reply-To: <20200925152739.GE2510@yoga>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Sat, 26 Sep 2020 00:02:33 +0530
Message-ID: <CAMi1Hd06t6xoaZME5nphSgerx7s2UwduUEmxmSe_ss=8Su977Q@mail.gmail.com>
Subject: Re: [PATCH] ath10k: qmi: Skip host capability request for Xiaomi Poco F1
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        David S Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>,
        ath10k <ath10k@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 25 Sep 2020 at 20:57, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 24 Sep 11:31 CDT 2020, Kalle Valo wrote:
>
> > Amit Pundir <amit.pundir@linaro.org> writes:
> >
> > > Workaround to get WiFi working on Xiaomi Poco F1 (sdm845)
> > > phone. We get a non-fatal QMI_ERR_MALFORMED_MSG_V01 error
> > > message in ath10k_qmi_host_cap_send_sync(), but we can still
> > > bring up WiFi services successfully on AOSP if we ignore it.
> > >
> > > We suspect either the host cap is not implemented or there
> > > may be firmware specific issues. Firmware version is
> > > QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1
> > >
> > > qcom,snoc-host-cap-8bit-quirk didn't help. If I use this
> > > quirk, then the host capability request does get accepted,
> > > but we run into fatal "msa info req rejected" error and
> > > WiFi interface doesn't come up.
> > >
> > > Attempts are being made to debug the failure reasons but no
> > > luck so far. Hence this device specific workaround instead
> > > of checking for QMI_ERR_MALFORMED_MSG_V01 error message.
> > > Tried ath10k/WCN3990/hw1.0/wlanmdsp.mbn from the upstream
> > > linux-firmware project but it didn't help and neither did
> > > building board-2.bin file from stock bdwlan* files.
> > >
> > > This workaround will be removed once we have a viable fix.
> > > Thanks to postmarketOS guys for catching this.
> > >
> > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> >
> > Bjorn, is this ok to take?
> >
>
> As I wrote in the answer to Amit I think we should introduce a generic
> quirk to skip host_cap instead.
>
> So if you pick this up (which is an ok short term workaround) I think we
> should revert it once we have a generic mechanism.

Hi Bjorn, just sent out a generic skip quirk for review.

Regards,
Amit Pundir

>
> Regards,
> Bjorn
>
> > > --- a/drivers/net/wireless/ath/ath10k/qmi.c
> > > +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> > > @@ -651,7 +651,8 @@ static int ath10k_qmi_host_cap_send_sync(struct ath10k_qmi *qmi)
> > >
> > >     /* older FW didn't support this request, which is not fatal */
> > >     if (resp.resp.result != QMI_RESULT_SUCCESS_V01 &&
> > > -       resp.resp.error != QMI_ERR_NOT_SUPPORTED_V01) {
> > > +       resp.resp.error != QMI_ERR_NOT_SUPPORTED_V01 &&
> > > +       !of_machine_is_compatible("xiaomi,beryllium")) { /* Xiaomi Poco F1 workaround */
> > >             ath10k_err(ar, "host capability request rejected: %d\n", resp.resp.error);
> >
> > ath10k-check complained about a too long line, so in the pending branch
> > I moved the comment before the if statement.
> >
> > --
> > https://patchwork.kernel.org/project/linux-wireless/list/
> >
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
