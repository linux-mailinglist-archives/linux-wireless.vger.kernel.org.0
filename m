Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36139745260
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jul 2023 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGBUlU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jul 2023 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGBUlT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jul 2023 16:41:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEFE9D
        for <linux-wireless@vger.kernel.org>; Sun,  2 Jul 2023 13:41:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b890e2b9b7so3271445ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jul 2023 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688330478; x=1690922478;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctKzqdg7AgwS1BKS1j1WCRwbSc6flyH2Zmh4cTRtQZw=;
        b=ggB02ip/8F9Yv8HpEMfsunIXYIiNonqwtbWQ8kuRGFo0I0eVpUZB/N/RBelrgD+UmA
         AWynkbxWSzj+27b5AU9/M+CenBU4OHjSQSDOh8t+IepoiSQg04elgX1yimBmgZs9HzBQ
         gvNIW45/8xlLRN7ixI6vqMtUIswuIazy/LUMwQg8eAj94L9tuwl6jg96sam1P95WhJYX
         bAf1LKhfprDagSlcvOh4uWUHxjTYOSFSJqVzxHGcYh7RFbt+iuO7Gxs3JlwrzMy0SeyU
         Mhp89IyPPA7uGoOoBNqErBgFDZka27FoB691l49r+/Arn2Hlez20FGMc1lbUZerWymcV
         7SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688330478; x=1690922478;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctKzqdg7AgwS1BKS1j1WCRwbSc6flyH2Zmh4cTRtQZw=;
        b=NYhHO1u6lp8wIW5jRLmIWb+XujHT2tgMXhkf0Y05fFmJPy4uB0Qm/RuI8DNsfmBsQZ
         lNnlNCciahv1glJWLmD8jKdJRBkNN7mHxVJUo9s5TXfh2+oGwc7UaGp0G4xnZx/T6uVZ
         WC/oBV7O2XOsvYnjeRwf24gEaEZKHpcV5vJYF6SqZoi4Fx07XGFtJ3TFh/uk7PbpdnZW
         ES0bdEA9uqfe2h7HKO1HRoj1N429MZDDYetrHxLVlAyHbRparXTBBICgbONQ11YbRfZw
         kvbJkNl29TJAaOK5Uwe/8O9tyuE6PoBpiQSYQ4dI71GYlBMsu3mvkU0fxFcw6cVHVJlL
         JE8A==
X-Gm-Message-State: ABy/qLa75FzRkdPUkhsLs/+3pfzvtqMnANvZi7yEenqxm7blPS1/V04o
        eej0HDRzdMD9EQ+/d3iOE14=
X-Google-Smtp-Source: APBJJlFS69ecDLZ+ZVmiMyoboo+qv56losIiPaSWdWfWTP5u+7frLcnenVuvbYIE24TLa4GPIN/Y4A==
X-Received: by 2002:a17:902:ab98:b0:1b8:839c:12ea with SMTP id f24-20020a170902ab9800b001b8839c12eamr3885818plr.48.1688330477565;
        Sun, 02 Jul 2023 13:41:17 -0700 (PDT)
Received: from athena (104-52-52-190.lightspeed.frsnca.sbcglobal.net. [104.52.52.190])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001a52c38350fsm13997604plo.169.2023.07.02.13.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:41:17 -0700 (PDT)
From:   Rob Glossop <robgssp@gmail.com>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [iwlwifi] wifi fails on resume from suspend
References: <87r0pq7oos.fsf@gmail.com>
Date:   Sun, 02 Jul 2023 13:41:15 -0700
In-Reply-To: <87r0pq7oos.fsf@gmail.com> (Rob Glossop's message of "Sun, 02 Jul
        2023 00:33:23 -0700")
Message-ID: <87v8f23v2s.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On further poking, it looks like this problem was induced by the tlp
daemon, so probably not a kernel issue. Sorry for the noise.

--

Rob
