Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3319C33A2C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 23:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfFCVuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 17:50:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34468 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfFCVue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 17:50:34 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hXubv-00010O-Me
        for linux-wireless@vger.kernel.org; Mon, 03 Jun 2019 21:35:19 +0000
Received: by mail-io1-f70.google.com with SMTP id b197so14778570iof.12
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2019 14:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNep83AE8LBhsGw1w/3vxFBg+hybHJd7awIHSio4qNQ=;
        b=jlFTKmap/LUKyCC0Mvi0wfTArTINbb3aO03pw0C3wEfLJEaPZ3UkAAMOofDQm8TEnr
         XK8ab7mU/VYnJuR+3Gl/MgFyjs0vuRL88iivyDmyAngiPwn9IJGZ5AyrltJQjgBQlYo5
         n73UA2o+E27fkq6icUs5u0HjdX4SQxvWee2I0ILv9ne0Ov2IHXaKAisHOtSRNGfEF112
         zi50FXM03OD3491xOVgbdcxGzngnL9ATNFDruCRDO7s5rNM5Ig1GnQJxucevSIelh3e1
         GGGZErvHCUmvEEfgYcZEQo+YjJ4uGj8y0T2K2uV+KHp1jrqgxajWmg8kYIv4jIj4dYNd
         V6Dg==
X-Gm-Message-State: APjAAAU72UahoD0QAOpaRTwLI3wvx2M+Y+6jmQr+P1LWGxZiZeUbqLxC
        Eah3Bgs3PehNLr3Zt7X5iGfLbtY+rOLfuM6EW/jyJu9TZh4e1wBJfWWTPebWHwrcTGHhqfV94Ms
        OCeqR5i1Qyl/NfRTk7y/dCk3iJXHoF/FH9QhQZR8V2/C5
X-Received: by 2002:a24:94d0:: with SMTP id j199mr5778184ite.160.1559597718678;
        Mon, 03 Jun 2019 14:35:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwX+YTx5t6uIoHalxf6N6pxueOISV/oYKWGDJhHR74X1kVlaxM+ogcagVv0ZI80LxeQNDkfnQ==
X-Received: by 2002:a24:94d0:: with SMTP id j199mr5778171ite.160.1559597718410;
        Mon, 03 Jun 2019 14:35:18 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:9969:6580:f7d1:e724])
        by smtp.gmail.com with ESMTPSA id b64sm7059266itd.35.2019.06.03.14.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:35:17 -0700 (PDT)
Date:   Mon, 3 Jun 2019 16:35:16 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: Re: [PATCH] wireless-regdb: update source of information for CU
Message-ID: <20190603213516.GF4357@ubuntu-xps13>
References: <20190530110047.3449-1-xose.vazquez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530110047.3449-1-xose.vazquez@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 30, 2019 at 01:00:47PM +0200, Xose Vazquez Perez wrote:
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: WIRELESS ML <linux-wireless@vger.kernel.org>
> Cc: REGDB ML <wireless-regdb@lists.infradead.org>
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

Applied, thanks!
