Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFD93B69ED
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhF1U6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbhF1U6E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 16:58:04 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7CC061574
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 13:55:37 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id v3-20020a4ac9030000b029024c9d0bff49so1188884ooq.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRDyTO+vfHnO9Ab5rrYlSnfXyxhW3m/rf/oNtrBhS5I=;
        b=KeDWzxAaIV22z1BVMdMnIqdFVl4YBRm3ILhZYXdQE5dkF8ZALxe94fhs/yz7tIBDAh
         R6gRZrLguit0ZW7XDypfOPX5NSLmmPl+RSZ3ZDU4W8hsSMF7d5417uMe/pT9StXYcoPT
         oQPXDzGGOGAnAGf/O9d/FaOSH0lXG2nQ4r+YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRDyTO+vfHnO9Ab5rrYlSnfXyxhW3m/rf/oNtrBhS5I=;
        b=SX8CqwTLUuxSjblvsjxYXbM0Cc5jVcToAEbmFryDdmLXBvnmbiF7lZyZNYzK/XNCOm
         EAsrmg4sS/+gN9ZhoicvlQnpHOPiuFqUj/bmo8h5y3PbiAP5BIG+pG6ICHwVLLHbxMx5
         zjwpODlabsUCNS1aRumbVuzbmxfCMJGRetSqKUM70g2wPD448i4cvHy5veIkfbfUeSFg
         oIzaBMGZ11vSxrxqw5cZml8TogvluhTMYrMukk66Wx9Q/IBoqoChRoMe5lMJyfIUzzbC
         IcHhJuRyZXprPn02WfL4edqYOeokZcGrQVUJPlX47JAgGovSFV1zN1W2+unIQaBsHcIi
         AESg==
X-Gm-Message-State: AOAM531tBegRNk0EN4StqAMnF62kNDT2Y2vigKCSl+LLOfFZcGBDSpu2
        r9udmMSk2lIMpwMFJZpiKIa9qNqRevWkjQ==
X-Google-Smtp-Source: ABdhPJz0hLxgoqb87aDBHqJcHv2H+QMOJ8wQHiKHOkk7QHP3Uw8oLhXCmnj2BdzSIdZK9cwySspmXw==
X-Received: by 2002:a4a:b815:: with SMTP id g21mr1082971oop.70.1624913736976;
        Mon, 28 Jun 2021 13:55:36 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id h7sm3760288ots.44.2021.06.28.13.55.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 13:55:36 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id s17so23661503oij.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 13:55:36 -0700 (PDT)
X-Received: by 2002:aca:4c03:: with SMTP id z3mr8224092oia.105.1624913735796;
 Mon, 28 Jun 2021 13:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
 <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de> <92a3ff23-2763-44e2-a20e-25190d46d4bd@lwfinger.net>
 <CA+ASDXOY8HRjU6JK8a_Z9KUnXr3w_qXVU7hK56+6c2DQKiyFVg@mail.gmail.com> <75427961-7d9b-d943-f0b0-118ab8645be9@lwfinger.net>
In-Reply-To: <75427961-7d9b-d943-f0b0-118ab8645be9@lwfinger.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 28 Jun 2021 13:55:24 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOeCOw-HRKj8_3we9ng7+sou3ZRghS22Gq334YJq8qM=A@mail.gmail.com>
Message-ID: <CA+ASDXOeCOw-HRKj8_3we9ng7+sou3ZRghS22Gq334YJq8qM=A@mail.gmail.com>
Subject: Re: Memory leak in rtw88-pci
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Klaus_M=C3=BCller?= <kmueller@justmail.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jun 20, 2021 at 12:33 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
> I fixed the leaks, but forgot to submit the patch. My repo at
> https://github.com/lafingerrtw88.git has the fixes, and does have any leaks on
> my system. The patch just pushed has the same fixes.

Thanks for sending! It sounds like Realtek folks also addressed some
similar issues and more there (I bumped them privately, pointing
here), so I believe we're in good shape now.

Thanks,
Brian
