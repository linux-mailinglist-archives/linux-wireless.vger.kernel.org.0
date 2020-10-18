Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404B02918AF
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Oct 2020 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgJRRpH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Oct 2020 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRRpG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Oct 2020 13:45:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB0C061755
        for <linux-wireless@vger.kernel.org>; Sun, 18 Oct 2020 10:45:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j30so10407512lfp.4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Oct 2020 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JJeJFRHel1iJDd+fwQkAkdIWYIMT4go0GkRWx7kaVR8=;
        b=UHJIZJK9wWoFCavW9i0Ldwmratwirp4DxObgl+wkPLJRTpuKVOYCeZ50nVf0Wyr132
         8Y7ZETr/dqL75O2lqQFkaFz7oz+fwOIgpJYrRQ45yxT3Y/LFjER2Ta5O95uinlPcwZhj
         HcEU2O83SYsOQwf1976gAba2DNeEWf8dIiI7kL37WxR/R6dB2hV9blqaKQqKqW32iQ1c
         V/dnY2kqA54puVvtuK1q4NuKtoYPECEWXb1PhaOHnXJVv+bMWm+AQuMBDXsOJxmKntAc
         EO32NNHpF+MyJMFijZCQaNEP5ggZ1seBne7ywr/NyucPz1Pz5cO2srixaQH8aQd5ajCr
         Ew6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JJeJFRHel1iJDd+fwQkAkdIWYIMT4go0GkRWx7kaVR8=;
        b=XJ1lmK1an6UYe9TlANt+ofgSqGeKzkzsMUo1I09OTnJQymSA4CCrn1YXKjUWlSheLu
         2+iwWlRBnl/bE86/xYY9DUboKhHri1xRT34iuoOaXhOD3ROKaZ2Vn8eHDDIgEZMViaLi
         4KFvix8gnI6M77KGSSohsKqO/3XolCnEue9uTsafdzvkG8haSNFnX/GFQbv6oWTZHbdm
         HXun0qvW720A5dNDy3zhdxXVPhmke3jYEx0ZTt7cvgSDvVHAJbMMlGZwCcLJYqvhe5tp
         mgW4LPcz8+6eKrnAZS5EuxsVdixmKTOmky6M1TL4zRD/sNtYHXjJRf4opxa6NhGNDuO4
         sGAQ==
X-Gm-Message-State: AOAM532jVdJxWxd+5+b0pqweU0njoyn49HbYklGAistDk9xWDL6cyJMG
        mxUbrGvlIVn1jS3Q3siKb13pAXooyo2QjenP0za5hOI8PfySXeqP
X-Google-Smtp-Source: ABdhPJys7IEiCyJ1scww4xRM8Ef0J+hPUrT67WdjLzQbvzYxTriKBAdYHamqnmsXGSCAR7CEM1iXBzwGwBEQ9vcWDPo=
X-Received: by 2002:a19:8d3:: with SMTP id 202mr4305807lfi.600.1603043103544;
 Sun, 18 Oct 2020 10:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPCMANR84rD9pLnoq1S9Oi_J9U+P85=aBu+0z96q=DpGkHxKvQ@mail.gmail.com>
In-Reply-To: <CAPCMANR84rD9pLnoq1S9Oi_J9U+P85=aBu+0z96q=DpGkHxKvQ@mail.gmail.com>
From:   Raif Atef <cpmdxe135@gmail.com>
Date:   Sun, 18 Oct 2020 19:44:37 +0200
Message-ID: <CAPCMANSrKvR1D=zXecThUwSvx_f4Hdtunb4PFQvNQ76nZe1tow@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Egypt (EG) on 5GHz
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
I am from Egypt. The current enforced wireless regdb restrictions for
my country are out of date and very severe (40 MHz max) and have been
relaxed by our NTRA (National Telecom Regulatory Authority) in 2018:
https://nuzeal.com/index.php/2018/01/07/macao-update-to-list-of-exempted-devices-2/

Kindly update the restrictions based on the official published
guidelines available on the NTRA website present at this URL:

https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx

Thank you very much.
