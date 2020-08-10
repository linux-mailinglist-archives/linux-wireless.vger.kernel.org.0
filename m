Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B73240BC9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Aug 2020 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHJRSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Aug 2020 13:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgHJRSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Aug 2020 13:18:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E1C061756
        for <linux-wireless@vger.kernel.org>; Mon, 10 Aug 2020 10:18:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f193so5839552pfa.12
        for <linux-wireless@vger.kernel.org>; Mon, 10 Aug 2020 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ZfiSo/jR3N4STQphSoESnfgc2kvTu9hOFjYWtU62Gys=;
        b=mfYgUQmeS1apG1xzklxRkyRtc/i4/MrZj62qgnxL6aXaXj4IsJHW2154Oq42GjfRGI
         h95VBwrreL451G1UJ9lbUCLtA90Hbd8oqd2dLGgHTrVoN7yKufXMfr65x2ycblN6Cqjz
         /wd8j0WC6LVIIi3/lG07OqZ6eQM007kSGgpOldqc2ugozvew7eQnU2hzwFpDN2IecfAY
         /2YVhlbc52ADweswe0qvEfiJLYY2IA9MB05oo5XeQUpOuy3xhl3YWYyGaDAtYxBSu9SA
         YZj1BzT4yFSboXe550RvBPXRlhpndoV78pc1t1OhlcYyazqlxsVItj90Qj942TOfZFpp
         Nomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZfiSo/jR3N4STQphSoESnfgc2kvTu9hOFjYWtU62Gys=;
        b=X4NMxCj2iSSSSXdjjwcDCg3kpVU28qfdiCqX5qm7Lb4dhicWSMJYKSr4OST0C7VIDY
         jhLG9EuDorTM+WgoEQM2Hj7B26MADwET+DyEpAIxw0LdfNLl6kCRNoC5pgO1TOnW0T8U
         Aa4zwBJ5jc/rMYaS2pX7yQdddCNv2QgwhHOGdVUkkMA0GpkHQ8MoWd48CO+78jPa+aaD
         zsEcD4jIJ3EH20nikzsheLzn7vp11UHFnreKDl0UV7e13bPBO5YSVwgrP3Jg3dvzwuoR
         jaNq0xo8tTquuX3KQz1SQ4Ea7P348FHAAr3fg7moWBNCYvA8oRhduD6iCm9FIampggMg
         XJ9Q==
X-Gm-Message-State: AOAM532QqWtz6mfTsFuaZfxKijh4JVZe06sw1liZr3J6sRbDtuy51VYU
        HL/8LFRzycvnoO8Qik1yxgFqsQD8
X-Google-Smtp-Source: ABdhPJz/Lgby04mcxfqg9vcuQRdONkJkwYAwAsVadzB1LiLh5Uv48234OvHAxB56og9s4lhJmf2PTQ==
X-Received: by 2002:a65:60cb:: with SMTP id r11mr23171500pgv.131.1597079892968;
        Mon, 10 Aug 2020 10:18:12 -0700 (PDT)
Received: from host-29.home (50-126-102-83.drr01.csby.or.frontiernet.net. [50.126.102.83])
        by smtp.gmail.com with ESMTPSA id t19sm24089002pfc.5.2020.08.10.10.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 10:18:02 -0700 (PDT)
Message-ID: <28f1ab73ad2697578078e05cc40e9b29643d3470.camel@gmail.com>
Subject: Re: Lost beacon behavior changed as of 01afc6fed (hwsim)
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 10 Aug 2020 10:17:58 -0700
In-Reply-To: <65bbc2f69fe966d471eff3287a191919311ac641.camel@sipsolutions.net>
References: <ada14dfad76b93d654606c3b397de059d968096b.camel@gmail.com>
         (sfid-20200702_001244_354404_5FEC9FBA) <65bbc2f69fe966d471eff3287a191919311ac641.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> 
> But I suspect that it could be that you're testing this in the wrong
> way? From your description, it almost seems like you turn off the AP
> interface, and roam after that? I'm not sure that's really realistic.

Yes, your right. I guess we just got away with this since the behavior
was different previously.

> If
> you wanted to test the "a few beacons were lost" behaviour, then
> you'd
> really have to lose a few beacons only (perhaps by adding something
> to
> wmediumd?), and not drop the AP off the air entirely.

Yeah, I think this is what we will have to do. Target beacons
specifically to block (and just a few) vs everything. 

> 
> If the AP is in fact completely unreachable, then I'm pretty sure
> real
> hardware will behave just like hwsim here, albeit perhaps a bit
> slower,
> though not by much. And then you'd have the same issue there.
> 
> The fact that hwsim behaved differently would likely have been just a
> timing thing - it didn't advertise REPORTS_TX_ACK_STATUS, so we'd
> wait a
> bit longer until deciding that the AP really was truly gone. If the
> ACK
> status is reported we just send a (few?) quick nullfunc(s) and decide
> that very quickly. But that's independent on hwsim or real hardware.
> 
> 
> johannes
> 

Thanks,
James

