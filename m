Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84136F376
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Apr 2021 03:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3BXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 21:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3BXH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 21:23:07 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7AC06138B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 18:22:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j7so38962966pgi.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mU8mcMHSkBljrLuCOwVuqVbQczPW1e39YEUZ3JEDCwg=;
        b=FVHX1dKtslt3O9x8RQHMKEucmyF4YLuDvAhBKB9UmzasVVuJjLtMQbwwYVI+XMM5z2
         mxfPTf7f6ebm1aeJdt39nCvDY7ZDxZE8O8PuwO1XC/HpboNjp3eOEhvEp2SNYoaVGS6m
         NVt2AwuMdd077oPIKn6T5MReX5Rc2GynkXnnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mU8mcMHSkBljrLuCOwVuqVbQczPW1e39YEUZ3JEDCwg=;
        b=CDYPhXqsJbJ78soBje0lCXxJogTFHbidUIUP81NytrVxh6UTGx2i2QOHJ+zxWW1zMc
         fnuVL5IkDkp8eyyMWa6ha43aboBDiFcq9c5q+bxe2Sk96li528MNSqnoUFnMAeQT8yIB
         7AYmzKk63JfYtqFS0FRmJExfbGOIqv8vr+o2Ibyrf/XLklD0bqTk/jBzwGMsoLghSLGA
         gFim4sF/snEHbOsVw3OTXfWZt7nu0j52g29yanS5cXyPUkkRBQGHZwUDjYb//ExZC8hZ
         I/QuJV8tomdLcqpsaNo++LNXaIuY57yFX8+18NoqRkDTm/Zdbt6BuQ+0e33WIGEgaexP
         JPsw==
X-Gm-Message-State: AOAM5301Ye0GNr77GnyQDGFozVSM64F5ue9OzHR2pnFezI/VsYoDut8x
        vZLus6ap4mi/tU+P4cuoy8gytA==
X-Google-Smtp-Source: ABdhPJyysZBsinrCCVfHwTTBW1wf09u//YWFCU7zofyqKz/AfKvHhSL0fTzp0kRtPGqiu9JEUF4DSg==
X-Received: by 2002:a62:2ac3:0:b029:27f:b98b:9efd with SMTP id q186-20020a622ac30000b029027fb98b9efdmr2527739pfq.43.1619745739237;
        Thu, 29 Apr 2021 18:22:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4f7:2f75:b0c0:5f85])
        by smtp.gmail.com with ESMTPSA id d21sm234364pfo.200.2021.04.29.18.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 18:22:18 -0700 (PDT)
Date:   Thu, 29 Apr 2021 18:22:16 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH v4 13/19] rtw89: 8852a: add 8852a specific files
Message-ID: <YItbyGGlZN4q9iOh@google.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
 <20210429080149.7068-14-pkshih@realtek.com>
 <YIsg3iv6d4L6n9Uk@google.com>
 <1619739791.1874.18.camel@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1619739791.1874.18.camel@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 29, 2021 at 11:43:12PM +0000, Pkshih wrote:
> On Thu, 2021-04-29 at 21:10 +0000, Brian Norris wrote:
> > rtw89_write_rf() is holding a mutex (rf_mutex). Judging by its trivial
> > usage (it's only protecting register reads/writes), it probably could be
> > a spinlock instead -- although I do note some magic udelay()s in there.
> > 
> 
> The udelay() is needed to ensure the indirect-write correct.

OK. Maybe deserves a comment for the future. Is this a
hardware-specified timing (measured in number of cycles or similar, on
the WiFi chip side), or something you're just guessing at?

> > Alternatively, it looks like you'd be safe moving to the non-atomic
> > ieee80211_iterate_active_interfaces() in rtw89_leave_lps().
> > 
> 
> For most cases of rtw89_leave_lps(), we can use ieee80211_iterate_active_interfaces(),
> which hold iflist_mtx lock, except to 
> 
> 	ieee80211_recalc_ps(local);	// held iflist_mtx lock
> 		...
> 		ieee80211_hw_config
> 			...
> 			rtw89_leave_lps()
> 				...
> 				ieee80211_iterate_active_interfaces()
> 
> That will leads deadlock.

Good point.

> Another variant ieee80211_iterate_active_interfaces_mtx() that doesn't
> hold a lock may be a solution. The the comment says "This version can
> only be used while holding the RTNL.", and the code within the function
> says "lockdep_assert_wiphy(hw->wiphy);". I'm not sure if I can use it
> to prevent locking iflist_mtx twice.

This doesn't quite feel like the right thing. You're in the midst of
many other callback layers, and I don't think this is the right place to
be grabbing those locks. But I haven't researched this very closely yet.

> If I can use it, I can add a argument 'mtx', like rtw89_leave_lps(rtwdev, bool mtx),
> to judge using ieee80211_iterate_active_interfaces() or ieee80211_iterate_active_interfaces_mtx().
> 
> I'm also thinking that we can still use ieee80211_iterate_active_interfaces_atomic()
> to merely collect rtwvif->mac_id list, and use a loop to do leave_lps
> out of the atomic iterate.

That's probably safe, because we're already holding rtwdev->mutex, so
there's no chance of our mac_id going away. If that solution isn't too
complex, it makes sense to me.

Brian
