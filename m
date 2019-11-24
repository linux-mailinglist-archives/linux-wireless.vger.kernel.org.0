Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316BD10855A
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2019 23:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfKXWj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Nov 2019 17:39:27 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:41612 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfKXWj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Nov 2019 17:39:27 -0500
Received: by mail-pj1-f65.google.com with SMTP id gc1so5538272pjb.8
        for <linux-wireless@vger.kernel.org>; Sun, 24 Nov 2019 14:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mJ03a7hesWJNvR2m6hfpaM5qF0D6avZONNtvx1zsFJc=;
        b=Gj7RiQOKmCUl7rlYZQVUi2mKCnOg5I0nw9OU8vIyXYd/0QJI7iGZFzb8A/gjk4E+JS
         xOJdNEEuiSMhWnxlWAyzY3TDGJab6QkRA5Q+e9FeTPuhzQ/AEYUFZFzloPjD3PGACWym
         SEtEro4s2JPqte8X2Pf+p3nxA+N3yyFlbPqGMcKI8aDGrB0AgcK8nlBEFgq8bE004dIh
         ycirnv1uJfo4XBMc96OLuvYRyUlFwaYIcnglL6w3TuhledodxCYZZRFQooR3B5aUumvb
         hEGV7k4M4T8W6jyExL6fLt9Cdlr+RPuD8Cuar7Te9Tl2EzW4Kqj/FvMFbWqiEPCIjWrv
         +rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mJ03a7hesWJNvR2m6hfpaM5qF0D6avZONNtvx1zsFJc=;
        b=c0U3MNzsb+yyahTdszJ4av5YZ1LqaA8itGCXIq0IwQzJ1312gMx3LhPIEN+8vxVHsQ
         ssvXYjqkXTc129W6jDexYnynQW4AiCHUpfHgmhbeO+j8k7pAd+25ZjM/8VEDfSTUGXZz
         DXJpOHhJHpMcSzo3cQVxrKJLydzPoDMfBe2ZWLY3GLC8RCAHOnaZ45SSVkDzm376QtoP
         4ZBe1u9Tnr12EsdoaDCmbBHhkh+BdZOjBvAnp+67Dre2mPx9p4QhfDzjxAOyKeOBs/OA
         QmnwgEH/0dvlbjz60Rrt0AQ1766m2MjeMbgHtq4dFX2Ob4ECT2e9lg7J680pMlWh8ojN
         jCcg==
X-Gm-Message-State: APjAAAVLo2OON7Qv7vtIp1aetbG4Vy5g72/48mzA2CjRgLj67vmSr9Sx
        HDb8lMnRjITCH1rPVne1+RSC6DnOrLc=
X-Google-Smtp-Source: APXvYqx50D+Wd5N5bU/VCxdp0oBYsPZSpIdT6ez+EmZyigA36yD5gxhbXBGUlO6FDAZGYYvd6plU4Q==
X-Received: by 2002:a17:902:409:: with SMTP id 9mr26724818ple.25.1574635166883;
        Sun, 24 Nov 2019 14:39:26 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id y12sm5619986pjy.0.2019.11.24.14.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 14:39:26 -0800 (PST)
Date:   Sun, 24 Nov 2019 14:39:19 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     davem@davemloft.net, keescook@chromium.org, kvalo@codeaurora.org,
        saeedm@mellanox.com, jeffrey.t.kirsher@intel.com,
        luciano.coelho@intel.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix -Wcast-function-type net drivers
Message-ID: <20191124143919.63711421@cakuba.netronome.com>
In-Reply-To: <20191124094306.21297-1-tranmanphong@gmail.com>
References: <20191124094306.21297-1-tranmanphong@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 24 Nov 2019 16:43:01 +0700, Phong Tran wrote:
> This series is for fixing the compiler warning while enable
> -Wcast-function-type.
> 
> Almost is incompatible callback prototype in using tasklet.
> The void (*func)(unsigned long) instead of void (*func)(struct foo*).
> 
> Reported by: https://github.com/KSPP/linux/issues/20

Hi Tran, thanks for the patches. Could you split the series into two -
the wireless changes and the USB changes?

Those usually go via slightly different trees.
