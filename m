Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9A57A02B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jul 2022 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiGSNze (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jul 2022 09:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiGSNzQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jul 2022 09:55:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DC129
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 06:07:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g126so13485522pfb.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7OeyhKy33tjaQjUvxDWPrUFGdB2XFzU6lajnqJi6xk=;
        b=CMUudVKyLmEeRR1g0fwUj0mviEc/DIgU7vno9MKbpIyvk3OEzozlmEenkXoqbjML8B
         BduU/dcfleC1Bl0cwanVmxhd0XlkOP/+1xVVfEb3G1jMaJDyqsVL22qDYN6ygDKh/eGr
         1NYhuYvnntnW/uOOwPMHWTt9oUeBqeLQuTjMqtlvjE6u+9CV2ZSiSMbvuCswE9I3nZtv
         VMTeqS8LhHitlk+t4LK6O/DUDXCGu97bPyYb59wjhl78vQfEY5x1yVmOpph7t0M688zt
         6v0tLKRqXyFdH96JFujGTo7plvw8QFJTG4hutR3/wlqOLJh2o72/2Pp2RHHQiXzLzHKE
         BzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7OeyhKy33tjaQjUvxDWPrUFGdB2XFzU6lajnqJi6xk=;
        b=oIY1rXwnZnPzbbELzZgFojmUVbOeoi1jJpJNma8u+66SnOce/J7csZtuu6cg3kj0MY
         Go/PxrrV/5AOLmVtX3appd2Rf1wjXopmdu3gFuqaPJemcV7z+WGfBIQTf+eKJGh93PqS
         XmuMISCSvTxtEltNWxbaVsrVGwaIrTR40WgRTzGL/zv+TmHpDJj4/nBwfH+4BQw0fjjz
         5XWD6vqG/GNAEHKoMWlty9SaOKxUsSuN5tzY1gmthtRD78nk0Hwu55I2sc6S2WXbmQX1
         dGl+I/IVR0UAhHs+BO5ujrGJdkblk+Ou7wqZB8D1Ze4fRuD8EF0oMEilq7G+ltBOwhO0
         HMiQ==
X-Gm-Message-State: AJIora8JjQ8lC6i/VQWGJKgr5CC1neYglJmYHNswuHuYwfEjiYIb4HXU
        aZ+jH/svoT6BhZF524AioT81TGKKtpj/bjCAdGJcEA==
X-Google-Smtp-Source: AGRyM1tNdcc7kvbuniu51mt7jC4y1M85Cy5fR54aLpXr3/darOHYg2KksIbENKLcQL1/x1IOFT9zRBGVj6XAwf0phI8=
X-Received: by 2002:a63:494a:0:b0:41a:56e8:62e2 with SMTP id
 y10-20020a63494a000000b0041a56e862e2mr692074pgk.586.1658236041667; Tue, 19
 Jul 2022 06:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220719121600.1847440-1-bryan.odonoghue@linaro.org>
In-Reply-To: <20220719121600.1847440-1-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 19 Jul 2022 15:06:45 +0200
Message-ID: <CAMZdPi-TUafosjJ_pwQ4F-N3WnnM5_0P7snB1qmgmzBeqkZu3A@mail.gmail.com>
Subject: Re: [PATCH 0/4] wcn36xx: Add in debugfs export of firmware feature bits
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 19 Jul 2022 at 14:16, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> This series tidies up the code to get/set/clear discovered firmware feature
> bits and adds a new debugfs entry to read the feature bits as strings.
>
> cat /sys/kernel/debug/ieee80211/phy0/wcn36xx/firmware_feat_caps
>
> wcn3680b:
> FW Cap = MCC

Nice, but why prepending with 'FW Cap = ' string, we already know it's
a list of firmware features.


> FW Cap = P2P
> FW Cap = DOT11AC
> FW Cap = SLM_SESSIONIZATION
> FW Cap = DOT11AC_OPMODE
> FW Cap = SAP32STA
> FW Cap = TDLS
