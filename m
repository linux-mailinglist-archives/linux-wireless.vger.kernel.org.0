Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1878970A
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjHZN5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Aug 2023 09:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjHZN45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Aug 2023 09:56:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586CE1991
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 06:56:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d77f614243aso1765119276.0
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693058214; x=1693663014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UIk3Ss+Jl+QQzMUaKkMUyViIyvPKScuq86cEEqHGusE=;
        b=pF6IfdIC2LkR3KDGmGGrGxTW1+eUnx4ikbUOn77tIRl0qFZABWvzSIAIqLJjGMIwxN
         BUTpJublL9H0IFm9wgfzF4U52AfgcNtUxJmoZlXOJWiUmPafyUK2tbo67hWCV5hooi0w
         jwBRETfr0m41OiX4/BXQm48GxIiBl/HbnnSXWA8BgfNk5YIm80jQbJRGu7uFwo/RZ8MM
         e4m7Rua64LJUjX5M6y21ENxPbi0P60T99PYACJYcIf9ouKTY/9O+jtEOz5ZAsZGNGK2d
         ebU+Dz5MQU9R2k8RVvFYknOyXL1tI/XRo8IqLrm7DHp79gRwD/u3GuvPD/pZZCfWAUrq
         0P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693058214; x=1693663014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIk3Ss+Jl+QQzMUaKkMUyViIyvPKScuq86cEEqHGusE=;
        b=jwpziXrZ3vs48ktHNnh2xK8xXcJB80pdefGCJCTgt1ek920AtE4pTSE9pEJJYv7wND
         dVD36Szy+zPUFqMVECf1quUoexN20VQmQoXDIl+1LrQtBDdARU42EVRMzvvPVyawSKIb
         BHBXh4t9NErHINAik9fBaeqLbz9Fl4M1yi6wJiFNYZNYoarrJURPN70D52Uv7TA6TjE+
         dC7zEOnyo/g9as59ttzdlU/K9j2j9e8Ha/ucDMTI1znBieswcoh/4m99Hn4fIxAZuga7
         LIBAZDX7zjHkSf5/yfLc9+YGxMO+xoCFSxX7V74V6y+YakyAKFAG2uWJRJsO4dJBJRlH
         k5hw==
X-Gm-Message-State: AOJu0YxScIN+fOZdPA2ASo38boiUQLj5qPn9Z0KrYsrFcg9sf9ZD2lST
        if72Rjoz4YVrfMDZkgOHztCO7YobOkDdAi0E5C30uw==
X-Google-Smtp-Source: AGHT+IG47fSKGFN3TIP1Ic8FLulbn7bmOtvFuvS8F3UvcPCC212ktImUAKfUM5AqVL2axxJ7JyvAM+CJK5JQB7eErVc=
X-Received: by 2002:a25:c5c6:0:b0:d7a:def7:b96a with SMTP id
 v189-20020a25c5c6000000b00d7adef7b96amr493222ybe.53.1693058214578; Sat, 26
 Aug 2023 06:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230825202610.1580132-1-dmitry.baryshkov@linaro.org> <87pm3afjda.fsf@kernel.org>
In-Reply-To: <87pm3afjda.fsf@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 26 Aug 2023 16:56:43 +0300
Message-ID: <CAA8EJprZvCtCKoV4J=21=2+fDM1gTfJBOThj13J3sE0w5AqpPw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: Default to board.bin for legacy board data file
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 26 Aug 2023 at 08:44, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > Default to 'board.bin' for the legacy board data file, in case the
> > hw_params array doesn't list hw-specific board data file name (e.g. for
> > WCN3990).
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Could you provide more background _why_ this is needed. What are you
> trying to fix?

Sure. For wcn3990 we do not have the
`ath10k_hw_params_list[].fw.board' set. So if the board data is not
present in `board-2.bin', the driver will skip looking into
`board.bin' and will error out.

I had two options: either to set the `.fw.board' in
`ath10k_hw_params_list', or to provide this default. Granted that the
check for `fw.board' also prevents the `board-%s-%s.bin' lookup, I
opted for the second option.

Maybe I should just set the .fw.board to "board.bin" and
.fw.board_size to 26328 (?)

-- 
With best wishes
Dmitry
