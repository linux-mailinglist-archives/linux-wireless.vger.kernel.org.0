Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD54747402B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 11:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhLNKMi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 05:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhLNKMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 05:12:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6173AC061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 02:12:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id o4so17396516pfp.13
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJQrGlgOA8dqtlV7JMau63SOZ8ZTw0fQmfKynxB6xQ8=;
        b=GYnIW2upq5GacPk614tRuRLtAlKe1wvWjWW7FrGyv/z6NW5OXHKQNlpDXQe6iA0O41
         o0uPSrMOfWXXpc9ToCfk+qiLpDWC7CiZgKhmJVmE1cdDLzg3NcnhUfma23DndRlF1mdC
         2U+lyn/h7QRMiQ8NERxETJX7S7sJcqLQxdi4F7GSwbiF6guj+srlbkBrL4Uq7krkoWqo
         5lDXBcfRihR71cwvghWZBriJirZxRayNcYIWpI19MfO7KeP5ZcueOzPmNrrj6kOXpNDA
         Zb1YgdKi5tg+cneHoVc5GqL+t09NfyflZ8wiVIlRPJZNRRXnRzDXAPnNsB53maa7reLK
         Wqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJQrGlgOA8dqtlV7JMau63SOZ8ZTw0fQmfKynxB6xQ8=;
        b=02kV4t9omnr/yhcnCFoYDGG7fE1NzaLtla9EfWpLfC1SBMRrFLdnydskGlS58C0I5H
         ctFhezO53pSklIba7ukeSSp0gXMOelCjtLoLePhUcy00RdAsZUkKXpkR/X96jD3HC23z
         qF9kSt96VOPMtlfaArpwjoIKarXN+ADa0VF+G4jTySAcL2dMPtxOQvoakmnWCZMW4AXW
         bNeLGfPTHU8qq8mptcEZqZMv4CFbamhltq8ESR+iU6/LxeSW8OJ/l4rAxZawiCzraqCk
         gSwp68DeOUGwQNLLZlRt4150fDkTZM6J0N6jLk8ILAFyS8KtuTRLSPML2C8QyTjNjoHb
         +GcQ==
X-Gm-Message-State: AOAM532CuiNi2YKbr9YWvL+CYZqzQ8dlC74egPBwpzPAgMYQFu4fCQIn
        YO3xo1g5RymUOYZaeAUbQjZtpG+TuwVuyDqehuatd5dApcUQog==
X-Google-Smtp-Source: ABdhPJxsyxh37uq/D/8gqSDSjQwyE6u6hAEvFfFQkuxG2F+KH9I6cd3fGgHSs3M5xMjVzHrgQQVnZxJ41G0xwUXVEWA=
X-Received: by 2002:aa7:8b07:0:b0:4a4:d003:92a9 with SMTP id
 f7-20020aa78b07000000b004a4d00392a9mr3271031pfd.61.1639476756794; Tue, 14 Dec
 2021 02:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20211213135127.1656258-1-bryan.odonoghue@linaro.org> <20211213135127.1656258-2-bryan.odonoghue@linaro.org>
In-Reply-To: <20211213135127.1656258-2-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 14 Dec 2021 11:24:11 +0100
Message-ID: <CAMZdPi9=JTsfUAGTZiHVmwv+x-F-diYFZq0swew8Cj3pRN1n8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] wcn36xx: Fix beacon filter structure definitions
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        benl@squareup.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 13 Dec 2021 at 14:49, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> The beacon filter structures need to be packed. Right now its fine because
> we don't yet use these structures so just pack them without marking it for
> backporting.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
