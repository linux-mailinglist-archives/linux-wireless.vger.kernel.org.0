Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A5476EE2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhLPK2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 05:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhLPK2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 05:28:45 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A53C061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 02:28:45 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 131so63287133ybc.7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xbGmLs+CG51ud70h+gLhOyvJvni0hdnPDg+IG6Y+65M=;
        b=aH52HWb+3rQSxxYejFIUh6VCdArYXaPNifE0dO5o0JtCJPXZT29FhaxcUzJmMSJlv9
         3AISfpg7KnbpywUlaZJVNiLFz2hIw6vy63Xi4X6Pn0l4SFPhapAIzP4eeK+m+YmfyMRY
         L9bJID2ThEIH7KJ9uXun+cLoRVPOW3/yxP92ML98w5ohW8nxmwhfE4RAehCqAyLyM6lt
         ktRX67vqkMr6SeOPYVlKqGkg19/iLzG/Ba4uCUC0XZsoVpzwNc8elMTTlPEicPFWFko+
         04aCwTLc4UkbO3pShLUrmaCXROZCWTchZN6mRAICK670uoC1UVBDMPljZEPH7ZpTYU57
         19/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xbGmLs+CG51ud70h+gLhOyvJvni0hdnPDg+IG6Y+65M=;
        b=3Mcg3RjXNP1PQf3fHhyCH4IwvCfE9trKoSV2mWSn+cBniSMhdLzi/sbkwSp0C3OIHR
         WuIXRqXNmYQ8yeH8XdWWqLlEHFrQzq9tR+VmxUCH+EKdUbTLA5i0M6U9acLIy4CtFvsj
         Tc6VPzTQVdSClydzOuhCw3/0ovMrJl5PDMJmbFFZt7cw5xdo12osw8hwtOGtLtugIoM3
         Xti+lIdsID5EviX4g26alOQJfSxN21yfegtAqllzuNG2z3fPLGCCFj1ViYoPG1QaoGo/
         Xrx2hhrffzpVSB3A6n1AeMuJi44vICieg6oLmwdtkFe0kvduBqEdbh1sb/dLDcZOyvsQ
         XoOQ==
X-Gm-Message-State: AOAM533eNUlCxt3aaD7I0GHDeMygGPQnUntUG9M0VXEPjGK+wm7PAiaG
        yCTpps598N60Xybup8Tuo9PhWl1Q5ejjuZLZRW5ojijnCKdDOpnq
X-Google-Smtp-Source: ABdhPJxeD3hTJODTC9I+rNvmcQo3OWz63+j5LQKoX6FrdSAHBnSLdQNzI9pU6HpX2lIhzSkuEGLDZWd69/AFCAG5byE=
X-Received: by 2002:a25:cecd:: with SMTP id x196mr13014162ybe.63.1639650524852;
 Thu, 16 Dec 2021 02:28:44 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessos.org>
Date:   Thu, 16 Dec 2021 10:28:34 +0000
Message-ID: <CAD8Lp46BuhxA1XLWjBs4op0jzZ1k0HF=X22F29hB7nHgvnZftQ@mail.gmail.com>
Subject: rtw88 support for USB devices such as RTL8723DU
To:     Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thanks for the ongoing efforts around the upstream rtw88 driver and
for your help on the ASPM issue over the last few days! Having such
hardware support in mainline is of huge impact for individual users
and organisations like ours.

I am curious if there is a roadmap for RTL8723DU support in mainline
too? Over the last week, 2 of our partners have inquired about this.
It appears that this is a very attractive chipset for vendors and is
being deployed in a wide range of products.

I saw some community efforts for device support:
https://github.com/ulli-kroll/rtw88-usb
but we are unable to use non-mainline drivers for these projects.

Thanks,
Daniel
