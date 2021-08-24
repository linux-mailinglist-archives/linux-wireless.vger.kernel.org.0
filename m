Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D523F634B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhHXQvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 12:51:52 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33332 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhHXQvt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 12:51:49 -0400
Received: by mail-ot1-f53.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so47889133oti.0;
        Tue, 24 Aug 2021 09:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jpaaAFdFvuDDnX7EkhNP96v/Utc8oDKaZ4p9ikjsrsA=;
        b=RqyA03A9uGEqoEzBwmbaxOzkZbc//M0qEoJSwz2vNtVyfVZKRqN2R6MmTMJcLQfBba
         VxCxz0xU/fziLE7h8CEDxqxGLBi76rQFKfAYHd0764PzSVCfHHoTLwr8CoZShF8DrRV+
         peWe7h/l5zZywWWgxfKGT2bKkrzdtvqnNOL6rsaV2V+gicBfFOZzmzFnrl1wGni+YkXp
         XiIWehyeRnw9yrcUxhYH6Slg4i4ECYhhakVqQHK8zBQXLJ1l3fYp9u5ncKkm/tye7eRF
         +7woduC4TS27SRFjyimjGzVo3UrYNxM4qj1iyYqNgPxNunp4io3RI1mkISK1RWBNjmnZ
         Z/eA==
X-Gm-Message-State: AOAM530QrJxuYaUKxBcJAGYB+QfCaHPX1BraD4FMeo4pWxlLRYclkeMV
        bEJymwWCeXTfjth5HUn3FQ==
X-Google-Smtp-Source: ABdhPJyH1vKU5DPhdAlJinixNGD/boOUx3DYtyaqR4/Fd5bq5BjfPNbpN6RbMX9S0YO9I7q1OuXl+w==
X-Received: by 2002:a9d:3e16:: with SMTP id a22mr34204623otd.101.1629823863888;
        Tue, 24 Aug 2021 09:51:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k21sm4687777ots.53.2021.08.24.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:51:03 -0700 (PDT)
Received: (nullmailer pid 613374 invoked by uid 1000);
        Tue, 24 Aug 2021 16:51:02 -0000
Date:   Tue, 24 Aug 2021 11:51:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [RFC PATCH v1 1/3] dt-bindings:net:wireless:qca,ath9k: add
 nvmem-cells for calibration data
Message-ID: <YSUjdsS3ggmTo8c4@robh.at.kernel.org>
References: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
 <87ilzz9wzf.fsf@tynnyri.adurom.net>
 <cf25eb4a-197d-161a-5902-64830c383746@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf25eb4a-197d-161a-5902-64830c383746@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 21, 2021 at 10:02:57PM +0200, Christian Lamparter wrote:
> On 21/08/2021 07:40, Kalle Valo wrote:
> > Christian Lamparter <chunkeey@gmail.com> writes:
> > 
> > > On most embedded ath9k devices (like range extenders,
> > > routers, accesspoints, ...) the calibration data for
> > > the RF/PHY is simply stored in a MTD partition named
> > > "ART", "caldata"/"calibration", etc.
> > > 
> > > Any mtd partition is automatically registered in the
> > > nvmem subsystem. This makes is possible to fetch the
> > > necessary calibration directly from there at the low
> > > cost of adding nvmem cell information via the
> > > device-tree or via similar means.
> > > 
> > > This speeds up the driver's initialization a lot,
> > > because the driver doesn't have to wait for userspace
> > > to provide the data via helpers.
> > > 
> > > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> > 
> > The series looks good to me. But I'm curious, why you marked this as
> > RFC? Is there something controversial I missed?
> 
> yeah. Last night (it was already really late) I was tunnel-visioning
> at the thought that device-tree binding update was a must there.
> ... And ath9k's qca,ath9k.txt is still in that .txt and not .yaml
> format. So, I'm not sure if that file has to be converted first.

That would be nice, but it still falls under my bar for must convert 
first. :)

> (I couldn't get Rob's tools to work. And without them, I've no idea
> what error messages a converted .yaml of it will pop up)

What issue were you having?

Rob
