Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35229ED1E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 14:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgJ2NkX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgJ2NkW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 09:40:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8638C0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 06:40:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m128so3195574oig.7
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eYqdLtfS+KCW7y8GcdPSOq70vc91X3xtwLRcejbVT/A=;
        b=AZ+eNPwQ3yqgRBOPyOZZXnsc3kwP5mkW9+oTFT7nKBNIHQQ6elUQNp/Ux+IG5ZGpua
         ACJWDtQNpbEaeKJWEKlcdk0U2xW3Bs3tyPGmvLfM/FZyhrz1x8GKG+M/SAij/1TSiwSX
         0iLPegzeZ7RebPnIvpFynA4Mogpe6d0gjMyDN3WfKyJt+0uI0NlTY0hK2NvyNPpnFXSL
         JR8INEu2YywDRvUDF5Ix6qBTgg3G8lTYfhdoZkqiPDbNDLTuE+oTQTyc00Hd5YiQYOA8
         kIWPiVceeg2dN1dObRaEyFyieGDCYJTFRPv7q0wufWNXZhp5wMptNvu/tmmdn2Fy85rF
         6FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYqdLtfS+KCW7y8GcdPSOq70vc91X3xtwLRcejbVT/A=;
        b=GPpGjd8O6YO5e1fBbObLBbarVDMZ6Vc5oiwuLSM4s13qfS/iVov238Rsu2Qti60ATQ
         GGlfuVS/sVXzqBBeLbvZs5THLeukNtqFrXyB+PKmnuDxtGVuCD+xPlKn3QTSwpUrCbtH
         uAPdnIaWLO0FSHYvp4KZPoGcYBPLVLabHTpAAr8M4vllFtn7pk8/QZIDw6iC3kgG5hFF
         fTk1hGsJ58KfTBy9zK8Ld6xTN9aDxno5nXw95tJcF19b143O9OgdG0AVVtX3fZtk2lm3
         dWUSMZCh4Jih/AwUeiZEJUaJcDl4aitAK/YyLAv05gsgsntvRs5lITUvwU/4UguT66c+
         kAFw==
X-Gm-Message-State: AOAM531QTQyTFvvJMwI+ysrbNg/PRncbJs7xwHf+zNPXHnDNnfWdoroJ
        bD4F+94KJBglSF9bDgTpeOcoCQ==
X-Google-Smtp-Source: ABdhPJyad9qvBRhmR6ZGz1FrYyJxJFCnctUcizozb/fVUxBWO1/eSZM2+nxszq5TEb9kaDCIzM/pqg==
X-Received: by 2002:a05:6808:254:: with SMTP id m20mr3043991oie.139.1603978820880;
        Thu, 29 Oct 2020 06:40:20 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 33sm590834otr.25.2020.10.29.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:40:20 -0700 (PDT)
Date:   Thu, 29 Oct 2020 08:40:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        David S Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        ath10k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Introduce a devicetree quirk to skip host cap
 QMI requests
Message-ID: <20201029134017.GA807@yoga>
References: <1601058581-19461-1-git-send-email-amit.pundir@linaro.org>
 <20200929190817.GA968845@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929190817.GA968845@bogus>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue 29 Sep 14:08 CDT 2020, Rob Herring wrote:

> On Fri, Sep 25, 2020 at 11:59:41PM +0530, Amit Pundir wrote:
> > There are firmware versions which do not support host capability
> > QMI request. We suspect either the host cap is not implemented or
> > there may be firmware specific issues, but apparently there seem
> > to be a generation of firmware that has this particular behavior.
> > 
> > For example, firmware build on Xiaomi Poco F1 (sdm845) phone:
> > "QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1"
> > 
> > If we do not skip the host cap QMI request on Poco F1, then we
> > get a QMI_ERR_MALFORMED_MSG_V01 error message in the
> > ath10k_qmi_host_cap_send_sync(). But this error message is not
> > fatal to the firmware nor to the ath10k driver and we can still
> > bring up the WiFi services successfully if we just ignore it.
> > 
> > Hence introducing this DeviceTree quirk to skip host capability
> > QMI request for the firmware versions which do not support this
> > feature.
> 
> So if you change the WiFi firmware, you may force a DT change too. Those 
> are pretty independent things otherwise.
> 

Yes and that's not good. But I looked at somehow derive this from
firmware version numbers etc and it's not working out, so I'm out of
ideas for alternatives.

> Why can't you just always ignore this error? If you can't deal with this 
> entirely in the driver, then it should be part of the WiFi firmware so 
> it's always in sync.
> 

Unfortunately the firmware versions I've hit this problem on has gone
belly up when receiving this request, that's why I asked Amit to add a
flag to skip it.

That said, in the devices I've hit this I've managed to get newer
firmware working, which doesn't have either problem.

Regards,
Bjorn
