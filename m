Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AAEA5417
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2019 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfIBKet (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 06:34:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36847 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbfIBKes (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 06:34:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id s18so1048244qkj.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HrYleHo7nrR1/Z71MdIjCfVOgQijXsHb14Ro+VSgCeM=;
        b=i3+kIeqSXoK0iOBj+wai1Vr1raogOYIbH8m1Sh9MNalWDpQCD/fdQ8piOmiIjzFlNh
         0zYcZi9MNcxKSj504INt/yvvrZluoj4wcmMG95+DL81DsMviA24irKW3qRxsfv9HDexa
         HNI4WrPSs28jdII+OubdtAV06Z/AWmQO22cJ6dGY79YPr1RIoPU22AXlxHfNK/EzVxDL
         xT0lfjnUmIUWkfEM3vOFPa7oueHNw3vygvbLIuDIrmkKxpvwlc4aBuosl6wsdA4cqcXK
         VC2lzT+1883qI22aHl0SYMdyVPcD/VN5KdqBCIswwFif6/C3+Sky4FD+/3r4n/rMcKzC
         ctkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HrYleHo7nrR1/Z71MdIjCfVOgQijXsHb14Ro+VSgCeM=;
        b=XxhGCe62SisuWMvA9kMHOZZtFnaPUrX3aMimS9Y1SAjLRArTJq7B5Gju1ZDkiGEZM3
         rOkIPnu2ULY9eRmaVnTADne31Do6a6AaFhivF95bVjlc9BxjaoS+Lrxo1UqB0B9sUEKJ
         k3Nt9c3Rmd2o7SyRqtdOmYiBWqC3pP8W51R+3+S4ZI+/D+fN5ECaGpvowtHxS5XvrsMP
         Gqgdl/G27zWbrabCpgSrN6brXwoiOvqlioyq5iAbh+d2MBRUKUSsxSVwABYsmFMvV/60
         eskAd13cQbjFGRmLowJM2iTrINPTE49r36DcPE2vUtPnmUvkjSi09xL5v2zSh9K6rhUY
         0eIw==
X-Gm-Message-State: APjAAAUWFDg1RNXZgkJp98sBdJZbhIO+CWckiAFbuB/Bb1kb8nsA2P7v
        P+6dAiEe48h7+e6+AlC6R1Zptj346y9eWDMUI/AcRg==
X-Google-Smtp-Source: APXvYqw3bxFuJ+VurIkQUsALgpnMuJH6hDV3SlUHQEk8YlXUOCBR4b5GVmXMsrsWE2xMt+e43gZ/6IIs+dZh3C9T15o=
X-Received: by 2002:ae9:c206:: with SMTP id j6mr27074925qkg.14.1567420487866;
 Mon, 02 Sep 2019 03:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <1567407757-26951-1-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1567407757-26951-1-git-send-email-yhchuang@realtek.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 2 Sep 2019 18:34:36 +0800
Message-ID: <CAD8Lp44L06OAXvoP=jU9Tt0YgfWrRmTN0v4Jq_gjxrOTYn5XwQ@mail.gmail.com>
Subject: Re: [PATCH v3] rtw88: pci: enable MSI interrupt
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        =?UTF-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Brian Norris <briannorris@chromium.org>, gojun077@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 2, 2019 at 3:02 PM <yhchuang@realtek.com> wrote:
> From: Yu-Yen Ting <steventing@realtek.com>
>
> MSI interrupt should be enabled on certain platform.
>
> Add a module parameter disable_msi to disable MSI interrupt,
> driver will then use legacy interrupt instead.
>
> One could rebind the PCI device, probe() will pick up the
> new value of the module parameter. Such as:
>
>     echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/unbind
>     echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/bind
>
> Tested-by: J=C3=A1n Vesel=C3=BD <jano.vesely@gmail.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
