Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E79278CA3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 17:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgIYP1n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgIYP1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 11:27:42 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B68C0613D4
        for <linux-wireless@vger.kernel.org>; Fri, 25 Sep 2020 08:27:42 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 185so3137227oie.11
        for <linux-wireless@vger.kernel.org>; Fri, 25 Sep 2020 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+6Gvod8Bmcfdc8dmCT/NbNCi24OBdt2HEY33KRNsSb0=;
        b=LtsiSvd40J24vUdcrdY9gBNxAHpcZ6Zb9yoKXmnIQUoMF4WFdLxs8QsBRS6u6KtiFc
         fzpoKREQyPnB8h7hwbATU0WdVwl3mwJAaDfn7iWB6VRU1ab1n0KNRgFxIvsQqRnAc1ES
         fi7gxOZ5X4HZAJd0wVSZGewSySpGnwMukduIdm3f3m6LODh1uSkPWiPknp+mCbnHXsxs
         S27PzgFBAn0WAkNdIF//5YWEsUDkMqY4Tu+aTB3YieZrI1dUuuRdIqfRm6uj3n4TPhf8
         wbLk8SYKo4dio2aIcPcE6sAYRFnVYTqzAOGvnrjnikJ4FhiGP0MnyDRZp2uToWLABKF2
         dlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+6Gvod8Bmcfdc8dmCT/NbNCi24OBdt2HEY33KRNsSb0=;
        b=TORzZhKYtJLmHehXD257WXDYOf42bBgtVXF65oxP0ncph/XNDjAFHB5tyo5hmPL6vN
         lPYUiC8QqW03u3NdG+W+jBOFf7cfQ9oIYf7Qvz6PVpzgjVZkubqFYSl5djtQZ6aUbdr6
         Gh0FKrx/7TrAJJoQwJAsAn1+e6Joi0W56ecbDAFfNJbGROOZXwp5WYW8omoIjhoNeh0M
         EgceyD8lFwRSxq0onj6T5ggQBu/nO4ZZd6R6pR3MNu53UNffWA5cPmUkdgWQqEDzVPIF
         0G37X/AamlHcirj5CFtYXVoXSNCOfHgpd+w1b58Ba8Fz5FrRDQ4qAq2a3ZEKAm+NO7yX
         YHPw==
X-Gm-Message-State: AOAM533dbC+njmKZ7ukyEyKj2ECqMlpbFvKuGuMwXJNVCtI7saDigjMO
        GjvzI6YA6vZkAm+/F/q9vagCBQ==
X-Google-Smtp-Source: ABdhPJxPC5MyC8S4bjpg1guvEbH+1/PR/di2bgdC6u6i0LcfpuOGCns4aOm9QrUXbpQfAG0lPAd0mw==
X-Received: by 2002:aca:dd42:: with SMTP id u63mr531139oig.135.1601047661927;
        Fri, 25 Sep 2020 08:27:41 -0700 (PDT)
Received: from yoga (99-135-181-32.lightspeed.austtx.sbcglobal.net. [99.135.181.32])
        by smtp.gmail.com with ESMTPSA id y24sm764388ooq.38.2020.09.25.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 08:27:41 -0700 (PDT)
Date:   Fri, 25 Sep 2020 10:27:39 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        David S Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>,
        ath10k@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] ath10k: qmi: Skip host capability request for Xiaomi
 Poco F1
Message-ID: <20200925152739.GE2510@yoga>
References: <1600328501-8832-1-git-send-email-amit.pundir@linaro.org>
 <87d02bnnll.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d02bnnll.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu 24 Sep 11:31 CDT 2020, Kalle Valo wrote:

> Amit Pundir <amit.pundir@linaro.org> writes:
> 
> > Workaround to get WiFi working on Xiaomi Poco F1 (sdm845)
> > phone. We get a non-fatal QMI_ERR_MALFORMED_MSG_V01 error
> > message in ath10k_qmi_host_cap_send_sync(), but we can still
> > bring up WiFi services successfully on AOSP if we ignore it.
> >
> > We suspect either the host cap is not implemented or there
> > may be firmware specific issues. Firmware version is
> > QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1
> >
> > qcom,snoc-host-cap-8bit-quirk didn't help. If I use this
> > quirk, then the host capability request does get accepted,
> > but we run into fatal "msa info req rejected" error and
> > WiFi interface doesn't come up.
> >
> > Attempts are being made to debug the failure reasons but no
> > luck so far. Hence this device specific workaround instead
> > of checking for QMI_ERR_MALFORMED_MSG_V01 error message.
> > Tried ath10k/WCN3990/hw1.0/wlanmdsp.mbn from the upstream
> > linux-firmware project but it didn't help and neither did
> > building board-2.bin file from stock bdwlan* files.
> >
> > This workaround will be removed once we have a viable fix.
> > Thanks to postmarketOS guys for catching this.
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> 
> Bjorn, is this ok to take?
> 

As I wrote in the answer to Amit I think we should introduce a generic
quirk to skip host_cap instead.

So if you pick this up (which is an ok short term workaround) I think we
should revert it once we have a generic mechanism.

Regards,
Bjorn

> > --- a/drivers/net/wireless/ath/ath10k/qmi.c
> > +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> > @@ -651,7 +651,8 @@ static int ath10k_qmi_host_cap_send_sync(struct ath10k_qmi *qmi)
> >  
> >  	/* older FW didn't support this request, which is not fatal */
> >  	if (resp.resp.result != QMI_RESULT_SUCCESS_V01 &&
> > -	    resp.resp.error != QMI_ERR_NOT_SUPPORTED_V01) {
> > +	    resp.resp.error != QMI_ERR_NOT_SUPPORTED_V01 &&
> > +	    !of_machine_is_compatible("xiaomi,beryllium")) { /* Xiaomi Poco F1 workaround */
> >  		ath10k_err(ar, "host capability request rejected: %d\n", resp.resp.error);
> 
> ath10k-check complained about a too long line, so in the pending branch
> I moved the comment before the if statement.
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
