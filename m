Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE941627F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbhIWPy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbhIWPyu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 11:54:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF0C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 08:53:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bj3-20020a17090b088300b0019e6603fe89so3715679pjb.4
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IoCXZtJiPqrIdRphu48+A4MKeVc0yfaA8mFJC7w2uCs=;
        b=O5QixK7XvMp4zaj1O7N8qgI7aNiNxB8u8hzc/RtNuRMA7nO3fqJdi2xygt+PEfozGN
         iPdD6eT8hBAk1NrXq2qAkBsrgX++JmXloEV2sgn2HJu7cbuWG1ittmh0N6QVwzIHkaQE
         aJA42zCqyH52gyu9R/gq1vKOhM88GK/vVW7014q/WlF3nRLS039qRDQvfIzrh/sBfR0E
         K2JxAZEmRlWyzkdonhHw2FisWqj7usMkWGDCqtNxx5qJFJgHkougLQ1zq0BVo9SsrXYT
         efPODnVG4L0pLHYihsrlSnsgJK8sowSfoH/JtZwV/pMlw6fE7zahpRs2CBA7BmbhXTRQ
         dwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IoCXZtJiPqrIdRphu48+A4MKeVc0yfaA8mFJC7w2uCs=;
        b=4i6oTCReE3wguy0HwoJdvQ8BdA6Oy6bGv2Xmce5OpOTAYcIF6JgyHwFUzLqbISALLN
         bb4McRIQFqFOMYwXykcRzEBEC+xwh2CPr58DGcc3BTS+RcN4k7QIXSnTSVSlSozBmOrd
         YVL9XUrJj/BaFDStEo2uoeYuY1w+X7WTjARW1ggzz6ZEGpBLSbr7M1EE1Mr8ctfF3zf+
         RYdzDvZPz0ZXQU81uUOprBqlXzFlfBij4lwXFFJJ52yRoE/wkUWsyrihA2e9CU5xqJmV
         w5CJvYf9v7ziZ+TW8yrAYdgpnHB/alFJ0XXpTXc+p28bACQeJSeDkbwqb6GsHyaEJmOz
         Pr+w==
X-Gm-Message-State: AOAM531DurMyJDYZ318032gKJYDSsA8ZHYgSrzAN76FY8E4G6deYVL54
        Qzzl9jhlnIN7o6w/WfxqbXTIeH/fkak=
X-Google-Smtp-Source: ABdhPJyv0VGY7K2o/+d9GnPVoE/xKqNxkHdo0pNN61sCdBHcjVPldiPHPnhNr2BMN3c8yq9LBoUdow==
X-Received: by 2002:a17:903:2345:b0:13d:cc67:37c5 with SMTP id c5-20020a170903234500b0013dcc6737c5mr4514204plh.45.1632412398139;
        Thu, 23 Sep 2021 08:53:18 -0700 (PDT)
Received: from lattitude ([49.206.112.105])
        by smtp.gmail.com with ESMTPSA id x16sm7115401pgc.49.2021.09.23.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:53:17 -0700 (PDT)
Date:   Thu, 23 Sep 2021 21:23:08 +0530
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH iw 1/4] iw: nl80211: add NLA_F_NESTED to nla_nest_start()
 with older libnl versions
Message-ID: <20210923155308.GA3760174@lattitude>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
 <10ea557f9dfdf92083b9816d7370926e4222f333.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ea557f9dfdf92083b9816d7370926e4222f333.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 23, 2021 at 01:36:01PM +0200, Johannes Berg wrote:
> Applied 2-4, but
> 
> > 
> > +#ifndef NL_CAPABILITY_VERSION_3_5_0
> 
> I can find no evidence of that symbol ever existing anywhere?
> 
> johannes
> 

The symbol NL_CAPABILITY_VERSION_3_5_0 is part of the libnl library and
this will be defined when using the libnl library version >= 3.5.0.
From libnl 3.5.0, the library itself handles setting NLA_F_NESTED flag
when using nla_nest_start() lib function. Please refer the
commit 7de65a0 ("attr: mark nested attributes as NLA_F_NESTED") in libnl
gitub tree (https://github.com/thom311/libnl/commit/7de65a0).

With this new code changes in iw.h, it will helpful if "iw" uses older
(< 3.5.0) libnl versions. In such cases NL_CAPABILITY_VERSION_3_5_0 will
not be defined in libnl and so iw itself will set the NLA_F_NESTED flag
when invoking the lib function nla_nest_start().

And hostapd/supplicant already started following the same approach.

Gokul
