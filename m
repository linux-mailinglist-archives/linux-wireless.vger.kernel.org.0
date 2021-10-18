Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC6431773
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJRLg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRLg5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:36:57 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C63C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:34:46 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id f4so5111453uad.4
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QaVoIeZZh5cCMNoUqJqqr6RYJ7KFFV/EjD/wK1Sm/4=;
        b=hlQqW/l9NWA8ub7lpG9EwhLNKTialdPA5uY/eKKyrkD0KlUE2AApFvpKsewIhjYICq
         /E2J0BosnNW00AeYDDgkyTWS/Aqym4UfMSCaCvnjI4/lArL5FrlwJ+aoNzAAgfodMlXm
         LCL1k7j/pDa8B6n3wUpSpjOSiffUWQDiTBuGEZOhcFpITFkChcZX143o0mkdOC3ZBZlb
         RijPEty7uCUPFY0HqWcrKWrllKTbe68lCxnGhy2PzjnutDm24CHA+s7Nk8/mLeh3s8lt
         wXQskGA+5l9LD49NVGPXWjMEfZbJpEnvoLGaeHaTpTeBFBSsk3gORQl1CxspeUaauqc2
         6e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QaVoIeZZh5cCMNoUqJqqr6RYJ7KFFV/EjD/wK1Sm/4=;
        b=DvpzdnEQ9To17CtNZ2zMa9wPTUbHEqZ+3XXpNLdhN/i3IOJfrxlx4HaBSw+wVrpSko
         jFVAqSG8tfIy9oXoMHSaLFn6ww4mWePbcCHP0zB58wgbZC6ivU1gcIbU9oH5wGMPJSSn
         EFYBqU9x7iC12qDzSUfXSnX9WMdk0oVfCnp76D5PG7vERrXaKIdBjtpO9F+nI4p2iMEt
         3aLmbWTPDDPOWhCmL0wvj5x1oLRFgM3ENLpfSmvCDdRVtF/Qpphvn0lqLN3tknB4+sSK
         FvU8NFBra5ERmEmhDSlJmkwDobY2UdWM+VChHXJwH+C5NECr/dCuBwdtO6J+OMpzwVUB
         76FQ==
X-Gm-Message-State: AOAM533re5HWgORlqaESQZMzV2201s5nUl44zZbum9ilbYcXpLNYP49Z
        D1NAntHGlY+f57Q1m+ZWt1h2rxVEy1DVO/PzPd8=
X-Google-Smtp-Source: ABdhPJwnD6jwKyO14L0jqZ+JTEEJYQiFcP6AqbeSz2udas+FUW8SuYx9MkJExlc1JEUZ+GXQkhW95K6yR50/PVY5BKg=
X-Received: by 2002:ab0:3b02:: with SMTP id n2mr24651139uaw.87.1634556885566;
 Mon, 18 Oct 2021 04:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-5-emmanuel.grumbach@intel.com> <87h7devb0d.fsf@codeaurora.org>
In-Reply-To: <87h7devb0d.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Mon, 18 Oct 2021 14:34:34 +0300
Message-ID: <CANUX_P0J-L4razi1R0gQYyXw+iq0hiKUbFXX1YfDCcGsJ0ou2g@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] nl80211: vendor-cmd: add Intel vendor commands for
 iwlmei usage
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > iwlmei allows to integrate with the CSME firmware. There are
> > flows that are prioprietary for this purpose:
> >
> > * Get the information of the AP the CSME firmware is connected
> >   to. This is useful when we need to speed up the connection
> >   process in case the CSME firmware has a TCP connection
> >   that must be kept alive across the ownership transition.
> > * Forbid roaming, which will happen when the CSME firmware
> >   wants to tell the user space not disrupt the connection.
> > * Request ownership, upon driver boot when the CSME firmware
> >   owns the device. This is a notification sent by the kernel.
> >
> > All those commands are expected to be used by any software
> > managing the connection (mainly NetworkManager). Those commands
> > are expected to be used only in case the CSME firmware owns
> > the device and doesn't want to release the device unless the
> > host made sure that it can keep the connectivity.
>
> [...]
>
> > --- /dev/null
> > +++ b/include/uapi/linux/nl80211-vnd-intel.h
> > @@ -0,0 +1,77 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
> > + * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
> > + * Copyright (C) 2016-2017 Intel Deutschland GmbH
> > + */
> > +#ifndef __VENDOR_CMD_INTEL_H__
> > +#define __VENDOR_CMD_INTEL_H__
> > +
> > +#define INTEL_OUI    0x001735
> > +
> > +/**
> > + * enum iwl_mvm_vendor_cmd - supported vendor commands
> > + * @IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO: reports CSME connection info.
> > + * @IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP: asks for ownership on the device.
> > + * @IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT: notifies if roaming is allowed.
> > + *   It contains a &IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN and a
> > + *   &IWL_MVM_VENDOR_ATTR_VIF_ADDR attributes.
> > + */
> > +
> > +enum iwl_mvm_vendor_cmd {
> > +     IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO                   = 0x2d,
> > +     IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP                   = 0x30,
> > +     IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT              = 0x32,
> > +};
>
> If I were trying to implement a user space application based on the
> documentation in nl80211-vnd-intel.h I would not get far. For example,
> how is IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP supposed to be used? The
> documentation just repeats what the command already implies.
>
> You had some good info in the commit log, I recommend at least copying
> the most important part to the .h file.

Ok, this patch has already been merged by Johannes, but I'll add a new
patch to add more info.
