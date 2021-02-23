Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF2323041
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 19:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhBWSHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 13:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbhBWSHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 13:07:36 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68773C061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 10:06:56 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id a7so18092975iok.12
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 10:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :user-agent:mime-version:content-transfer-encoding;
        bh=VVhkNDLn7G2H8+bg1I933kaJtXZAwOHoy7K/14p40LA=;
        b=lj1mfBWxmPYVwRhl0+oU7LotIVD+XZ7jXA4/N9LFGFmwlVN4dGWnntdBRx0Jw2pysZ
         m5ZdWMOb5GKp9WBhqWXdzJ4mEDu6jOlyP1mly2oSmWN7USsBiDVMXFIgg+MFuVrQUimq
         73GW9dMj1FIqFWltxVopNx37fTPNeCKveAi0ke3Q3O7bwWwKOgOH1pWDe4fAG7FoFSA3
         jXz/jamkVVyY2y8XgKO4wV72hN6g27AQxIE/tkC9EkQ3gDwWqWr6vt4aWanLfQ3wbEPz
         28SqdR+fvichxtMk0eWiBHobx4pqG5EcA90hiy+9zp0Z++q/C+HBfEsv89iyL3QZqbkg
         JR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=VVhkNDLn7G2H8+bg1I933kaJtXZAwOHoy7K/14p40LA=;
        b=B8iTYScFgNNrZ5U+Y7L98IRhhJ6uTvuOKTbUe7NGvfjh/3gNloJxhNH7pSqMl0uxbm
         o9zaOJ9CTnWNeLkUNLkIH3hi7leUpwIOVPixB+20lGTuujc+MB+n//KEw7ppYn98IvDJ
         ph3DUzo3P3QLNVOl6ILDYgl7fcGRQI7Aul3d9HiNihsnInWP3s5+4lIYv0kkZEivvKpl
         buwJ5dHJ4pHKleDZdN23oLs9WIE2j8qSTax7lNKHCBnAOnxjpcvWPA/Ha1jho90imcQI
         nu9dUcS17OMo72n+GxfvnEs3TDXlvF5nu8Vst40r7M4P3H+VN6Lb4MVZWD50h8/l/aNN
         mtbg==
X-Gm-Message-State: AOAM531TxQ2eyYtLdT74VX1vcPQZI9XK4NVOVgzgccfagsF0bVJ7oc1a
        RsKrx2CX2ugkw08mLNSscRa8hOC+S5kEdrM=
X-Google-Smtp-Source: ABdhPJz/GEhzpc/d30OT9+qyljrS5Wp0NMrercg7Sk877J36CPdtz3hEkXEL58yp0LiKnY6T+JSdpw==
X-Received: by 2002:a05:6638:22c5:: with SMTP id j5mr29060990jat.89.1614103615788;
        Tue, 23 Feb 2021 10:06:55 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:cc6b:9049:f16e:2f39? ([2601:281:8300:4e0:cc6b:9049:f16e:2f39])
        by smtp.gmail.com with ESMTPSA id e1sm18194452iol.31.2021.02.23.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 10:06:55 -0800 (PST)
Message-ID: <f929d047895ec8931064c0058f461a95b4b6f5dd.camel@egauge.net>
Subject: Re: wilc1000 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Date:   Tue, 23 Feb 2021 11:06:53 -0700
In-Reply-To: <b7c1b271-993b-064e-3c2a-74302744edd8@microchip.com>
References: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
         <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
         <f3e0540462ed8bcc59787f71e3b1b258945a6142.camel@egauge.net>
         <5fc9c8ad5d93e2172f03515f8275851af285a895.camel@egauge.net>
         <b7c1b271-993b-064e-3c2a-74302744edd8@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-02-23 at 17:19 +0000, Ajay.Kathat@microchip.com wrote:
> Hi David,
> 
> On 23/02/21 9:53 pm, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > OK, the problem below is caused by wilc_set_power_mgmt().  If I change
> > that function into a no-op, the driver actually works!  Does this make
> > any sense to you?  From what I saw so far, it looks like relevant code
> > is pretty much identical to the one in the linux-at91 tree and that one
> > works fine.
> > 
> 
> As I understand you are testing with default powersave mode enabled. One
> approach could be to disable the default powersave mode by compiling
> with CFG80211_DEFAULT_PS disabled. When its disabled, .set_power_mgmt cb
> is called with powersave disable.
> If the powersave mode is enabled, the chip need to be wakeup by
> following the wakeup sequence. We need to bring in chip_wake() API
> changes, to set registers specific for WILC1000. I have plans to port
> these changes to support PSM mode but it will take few weeks.

Indeed.  Sure, I'll just compile with powersave mode disabled for now
until you've had a chance to bring forward the missing pieces.

Thanks!

  --david


