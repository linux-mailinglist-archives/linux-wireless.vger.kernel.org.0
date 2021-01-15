Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1512F7E9E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbhAOOwR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 09:52:17 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:41213 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAOOwR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 09:52:17 -0500
Received: by mail-io1-f41.google.com with SMTP id q1so18545017ion.8;
        Fri, 15 Jan 2021 06:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rEerV/vcl1qkZpTEt+4g7qD9epDZ/0Mu+8gvRFbU6/g=;
        b=FumE1ZEazBxUjr6Sua8NXWqOt/F8DGECWbNOmZgbHcYb9TX65vWjKYmTNS0bdw2y/i
         iuWAy1PlyVgD94IeGLBXwBBVgz53ezY985PyOMhmrVWbj1a+j4Ce20h4Q1B0YJAvWL5n
         jTCfspLelPVnNHn2VYwVncYIoBkE+/peXNCMqikpJimk/EILUB6ADdhsMNRxjS93YJ+7
         9nhkbiVnpyh/XL9pPqUvZsCZSehwum7rHWEEE9xnRSy2XkgKBtVBz7Ptn4tSRs/SQmbg
         kCHPmKxPYjI0xWWAv3I7fqKI8sXHmYLUkqGITMNrqHqf95YyV8Xgry9z9HItFIUJIIy+
         +fjA==
X-Gm-Message-State: AOAM533m40jl3lyJ1kvrTYYzNuPivdvsZDnVcgZ4QCs8tcS0A9PfMoYp
        ZwmybBYnbStI8ZEPQbfgFCOeJy1Tfg2Koyv5
X-Google-Smtp-Source: ABdhPJy8oIk/QSYS2fUh5RXvSBaKbkrDG4zhARlrROH85BXMh+b7rAIrz3y4E3LFc9DObVdfDvzGyQ==
X-Received: by 2002:a5d:8704:: with SMTP id u4mr8798550iom.3.1610722295848;
        Fri, 15 Jan 2021 06:51:35 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id h6sm269637iog.47.2021.01.15.06.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 06:51:35 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id x21so365445iog.10;
        Fri, 15 Jan 2021 06:51:34 -0800 (PST)
X-Received: by 2002:a02:bb99:: with SMTP id g25mr10638694jan.11.1610722294668;
 Fri, 15 Jan 2021 06:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20210114163641.2427591-1-alsi@bang-olufsen.dk> <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
In-Reply-To: <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
From:   Andrew Zaborowski <andrew.zaborowski@intel.com>
Date:   Fri, 15 Jan 2021 15:51:23 +0100
X-Gmail-Original-Message-ID: <CAOq732KGRmQ0eq46cqkF-EW-A8W6QiOb02NZEq6H7K_28YSstA@mail.gmail.com>
Message-ID: <CAOq732KGRmQ0eq46cqkF-EW-A8W6QiOb02NZEq6H7K_28YSstA@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: add support for CQM RSSI notifications
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 15 Jan 2021 at 15:12, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:>
> + Johannes
> - netdevs
>
> On 1/14/2021 5:36 PM, 'Alvin Šipraga' via BRCM80211-DEV-LIST,PDL wrote:
> > Add support for CQM RSSI measurement reporting and advertise the
> > NL80211_EXT_FEATURE_CQM_RSSI_LIST feature. This enables a userspace
> > supplicant such as iwd to be notified of changes in the RSSI for roaming
> > and signal monitoring purposes.
>
> The more I am looking into this API the less I understand it or at least
> it raises a couple of questions. Looking into nl80211_set_cqm_rssi() [1]
> two behaviors are supported: 1) driver is provisioned with a threshold
> and hysteresis, or 2) driver is provisioned with high and low threshold.

Right.

>
> The second behavior is used when the driver advertises
> NL80211_EXT_FEATURE_CQM_RSSI_LIST *and* user-space provides more than
> one RSSI threshold.

Or, when the driver doesn't implement set_cqm_rssi_config (the old
method).  So the driver can stop supporting set_cqm_rssi_config when
it implements set_cqm_rssi_range_config.

> In both cases the same driver callback is being used
> so I wonder what is expected from the driver. Seems to me the driver
> would need to be able to distinguish between the two behavioral
> scenarios. As there is no obvious way I assume the driver should behave
> the same for both cases, but again it is unclear to me what that
> expected/required behavior is.

When the driver wants to implement both methods it may be because the
hardware has a better method of handling the hysteresis than what is
implemented nl80211.c.  In that case, yes, it'd need to remember which
method was used and the parameters.  If set_cqm_rssi_range_config was
used the driver is expected to report when a momentary rssi
measurement goes out of the configured range.

>
> With behavior 2) some processing is done in cfg80211 itself by
> cfg80211_cqm_rssi_update() which is called from nl80211_set_cqm_rssi()
> upon NL80211_CMD_SET_CQM and cfg80211_cqm_rssi_notify() called by
> driver. If I look at that it matches pretty close what our firmware is
> doing. The difference is that our firmware avoids RSSI oscillation with
> a time constraint between RSSI events whereas cfg80211 uses the hysteresis.

That may be a good reason to keep supporting both methods.

>
> So before moving forward, I hope Johannes can chime in and clarify
> things. Added the commit message introducing the extended feature below.
> It mentions backward compatibility, but it only considers the extended
> feature setting when user-space provides more than one threshold.

Right, with one threshold the behaviour is unchanged.

> However, when the drivers set the extended feature is expects (low,
> high) and (threshold, hysteresis) if not. So it seems the extended
> feature should have precedence over the number of thresholds provided by
> user-space.

I guess the answer is that if the driver implements both methods it is
expected to report threshold crossings according to the method that
was called last.

Best regards
