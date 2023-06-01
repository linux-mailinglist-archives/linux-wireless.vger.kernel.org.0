Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5571927B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 07:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjFAFoj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 01:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFAFof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 01:44:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3819B
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 22:44:26 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3985f70cf1bso169268b6e.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685598266; x=1688190266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1uvgcoQcQ4Z853Ind5gxnEDVRn2AFhQFsoVwaotUlNE=;
        b=jszcBTPSZ81RGvohbVbHovQHmgIkiz9h97QThTwpJOuRZQXypCVMaRVrUjCj8TA8TA
         iaWTnQUE54CHJ3dr1j/ZbRh/OCRtQTldin0zHOLm4bXS3jT0P6lbbcixxtEAS4zfBk1D
         ii7k6g3qVDeVXtWTmek/sSV5B09lUuI3KSTth6xG/Btgx2QSPS3SMGSnv8h1Gpp49slL
         E2uWT1xWqY4fmL0j/qPSvwpt58dbDKT8WWBc1Hon4d2LKVYZMDPjqtHPAR1fP2sB2w/y
         Us1lhQnU789okQW4uVJJf9P+P+ENajLqNnmapBMjuvEoqO/AqW4u3KNYvL2CzmyYPW3b
         CBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685598266; x=1688190266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uvgcoQcQ4Z853Ind5gxnEDVRn2AFhQFsoVwaotUlNE=;
        b=fb2Cu50iJFzfQ9G8CFJkKnhF380Y5i49crAIzZvwmrludPBiknJjFi8wh09ACMm8aq
         chDv3kI6BfXPhXwWR08Ds8Sey3BOhOq/GuGQ+hPdjPODVXWe/5H5wS7bMsuZjTxvf10v
         bXRpiDltToUcQgL7cWsaNNbKUQ4Dqop2mDXXiLHt4LFNT7DpK074BwcGp62OZR411x1W
         IU0AHqP+OrqlrEXbAVsYewapuR0vbIxxqYQFVYJuU1fPgQ5/duvK0vrH9MMvoOHGU9J5
         iv5GLgDGxpf4AnqHHIJ2T/3KK/v8BUm6lILM6llv7dnbaq0F4tXFffRqrIWlWJC0O8AW
         DtoA==
X-Gm-Message-State: AC+VfDy0sXbzDd6aIb04df7l6Ow1kl3U7WxJXBvrCzicPRGP+/etOu6R
        hjqet3ugljq4bLvtsFYXclfUFE3ExYO8kSuZitw=
X-Google-Smtp-Source: ACHHUZ5kdaM0va6nLf08V7NKzVDqVOCRQsLt9+2APwYqwbkXzhB9j3We9G4YsEIqrZ36JKoLDW3HDqIB5432Kpub9GI=
X-Received: by 2002:a05:6808:10ce:b0:397:fb63:73b2 with SMTP id
 s14-20020a05680810ce00b00397fb6373b2mr5825453ois.36.1685598265929; Wed, 31
 May 2023 22:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ4cxaQiYWEOmf9sZHsvXqYc_SKSg2dm5jQvifa82+o+W41aNw@mail.gmail.com>
 <87h6rrkdv1.fsf@kernel.org>
In-Reply-To: <87h6rrkdv1.fsf@kernel.org>
From:   Neal Sidhwaney <nealsid@gmail.com>
Date:   Thu, 1 Jun 2023 01:43:49 -0400
Message-ID: <CAJ4cxaQ04_H06OCaUgt0mnVhu5YZDiQxoBiALFwj9pyBjARLoA@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: Detect corner error case earlier with log
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> From looking at patchwork the patch seems to be malformed:
>

Sorry about that! I thought I clicked the right setting to send as
text but I must have missed it. New version submitted using 'git
send-email'.  Thank you,

Neal
