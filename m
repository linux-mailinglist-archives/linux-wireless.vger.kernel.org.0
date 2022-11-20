Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1D63169E
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 22:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKTVqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 16:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTVqK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 16:46:10 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3B2CCB5
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 13:46:08 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so6334405otg.6
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uTg8lvBhlqUkunnKT7KJQbKvoyl5MpWrhjltO22hFss=;
        b=dnO86ZODl9farZ3BIQUE+ZfjX9sBNteWhsjhSXzUQCK0h+IBQva/kXmsRoxivar1+f
         vjeNz9G9Xo/t0xbwp1sISq74GLo1iAtFWv+6Wg6rXfdxPiIN2aVhBjdCS5KeN+dA9pdb
         aQym096l92hMPguoistX2YmKlN743xJBcI8O/1lFaKk294ovyOdsEdqREhmBmmSdQ5YS
         jv3xHrjWPcq5hzLytCCoXO17eU+dgzXgfS6SO0QuXaTg1aXlVSTJwfl6I+2GQTuqwF7m
         FCryOlUhJ7eJ0YS5sf1AoyyXHiJliReGtw3XzWp8Il3PI9pPvnbiBIiY+4Fq8Xza8pmu
         Ukcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTg8lvBhlqUkunnKT7KJQbKvoyl5MpWrhjltO22hFss=;
        b=CwvPnJ4ULhI4FPa8YrLKTgEHsycIXu5HkKDqk4E5VdFKHeSEPcnvoOupSU+gvxGRQs
         /NDk0V54BO6mjmaFZs8WRDjD2t60VqTQYpkOGtCxlg8ZByEGdR17Ys4Pb3yXOOFwcQPf
         bLoWJsI9hVKhEOXk6g5UwDjGRtaRAGrnGzaIdUhGPXfFZCpcg/zSSSnqPGlbNw2od3wO
         O6BZk9JH/uz5UntmrTJBhWSL8+IhEtjyAffeVUOznwwoZw7a+pJUtB28Nji7pg8pqGh8
         81z5N1+dKxE1I0+iQObJUFzyZefRe3cwzIpR82QdW2NvV206MrSY3NooNbI0DbK9fY2K
         ds4g==
X-Gm-Message-State: ANoB5pk9V8nFHhE2hnDZwZuzQwNXA9u8HZbgacYeqpYCJod/qRUK205q
        emVzcemijlbCN99ZFyRIIaI=
X-Google-Smtp-Source: AA0mqf7S2/ArDZ4v/jjpQGyg1wFA4Pork1r6ildJqmzwfYYldhB9dovRx2M0TZ1CJ036kFWruwiKnA==
X-Received: by 2002:a9d:86c:0:b0:66c:81be:66e5 with SMTP id 99-20020a9d086c000000b0066c81be66e5mr8151790oty.352.1668980768231;
        Sun, 20 Nov 2022 13:46:08 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l10-20020a056871068a00b0013d7fffbc3csm5092112oao.58.2022.11.20.13.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 13:46:07 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <bc873bd8-7163-65ca-6979-2b2c40edfe1a@lwfinger.net>
Date:   Sun, 20 Nov 2022 15:46:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Missing commit - Sent again with Kalle's correct address
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <bea5e5c1-77e0-f210-e8bf-922492e50213@lwfinger.net>
 <87pmdhpbyv.fsf@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87pmdhpbyv.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/22 15:12, Kalle Valo wrote:
> That commit is in wireless-next and the first release having it should
> be v6.2-rc1, if all goes well. So the patch is not lost.
> 
> We need to get -next patches ready before the merge window opens, so it
> takes quite some time before patches go to an actual release. For
> example, the estimation for the v6.2 merge window to start is on
> 2022-12-11. This means that wireless patches should be submitted by
> latest 2022-12-05 to make the deadline, and even that's risky. The
> estimation for the final v6.2 release is 2023-02-19:

Kalle,

Thanks for the explanation. Things always take longer than expected.

Larry

