Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02DE10F348
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 00:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLBXQv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 18:16:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35378 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBXQv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 18:16:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id n4so1716919qte.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2019 15:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTm3dIVEwoz69UzoNll0eH2uELBdoJqAtHJA5yeL0is=;
        b=R5LmWfCSsJpYdgPcFvM0IRr66wtepwKsb4IrXCqi5vv5W7LWGB/m32rCox2Y99L3W5
         f+wswdRImsowi/CvCwvf3yMYUHjx6yAXZ+Cc6lvgxkIEgokOXQb5g/5+QRJndYPHP0+g
         FiO7FSDgnxOrC9K0fhx/q4qfHya/gzpHSWZqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTm3dIVEwoz69UzoNll0eH2uELBdoJqAtHJA5yeL0is=;
        b=k62wiSN6CjenXvxlp/VpuczL6DN/FXyNTvne2ULKXajitTkNdTMeN6KZyys8CBYOJC
         bHPuJC4l10lId1AhW2T63JWR51AbTfJyXm6C/im6IoMc/ODw2CtXo6ajF9E6HwXIUWof
         S3P6yy32y8+HEmmhc2YHYXbjufcxhG4d0azNvV5rrGiG5J1f8Ha7OvsXOj9vBk2M0HF3
         +uArmdF8s0TZWsbHgPGjZxap2NqGMHZr/mmS8K6c2u+izpoHTf1QwYW1jKOOCbL/t3je
         tPlmGI0wO4zQpEJN4hppphvYIsjYWH2CJFBzPVBzBfGyEkTHdCDHWEIh2tzC4ehjdj+F
         XMew==
X-Gm-Message-State: APjAAAUEOe+PAYXg191HFbzPBOcBBXtf1AvJOElWo4hNLkqWpbuLJDK5
        uA2rfHWJYvH8aeGEErSONx6LLoS1fFc=
X-Google-Smtp-Source: APXvYqycQsXMR7JrTLlMdgz/zTaFw21wTgZ0TGaUF6Q5YzVUk3yk5lHA7zgaXPIoR1a+uNlKrrdHzA==
X-Received: by 2002:ac8:60d3:: with SMTP id i19mr2126780qtm.391.1575328609343;
        Mon, 02 Dec 2019 15:16:49 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id g18sm636429qkm.112.2019.12.02.15.16.47
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:16:47 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id n4so1716753qte.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2019 15:16:47 -0800 (PST)
X-Received: by 2002:ac8:327b:: with SMTP id y56mr2125727qta.161.1575328606993;
 Mon, 02 Dec 2019 15:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20191129101054.2756-1-wangqize888888888@gmail.com>
In-Reply-To: <20191129101054.2756-1-wangqize888888888@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 2 Dec 2019 15:16:35 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOj0rz4S3BoMdF1pqOiVZ4yhVE_Qy+s6iTObCnhFfwFLw@mail.gmail.com>
Message-ID: <CA+ASDXOj0rz4S3BoMdF1pqOiVZ4yhVE_Qy+s6iTObCnhFfwFLw@mail.gmail.com>
Subject: Re: [PATCH v3] mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()
To:     qize wang <wangqize888888888@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, greg@kroah.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A bit late, but a few readability and maintainability thoughts:

On Fri, Nov 29, 2019 at 2:12 AM qize wang <wangqize888888888@gmail.com> wro=
te:
>
> mwifiex_process_tdls_action_frame() without checking
> the incoming tdls infomation element's vality before use it,
> this may cause multi heap buffer overflows.
>
> Fix them by putting vality check before use it.
>
> IE is TLV struct, but ht_cap and  ht_oper aren=E2=80=99t TLV struct.
> the origin marvell driver code is wrong:
>
> memcpy(&sta_ptr->tdls_cap.ht_oper, pos,....
> memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,...
>
> Fix the bug by changing pos(the address of IE) to
> pos+2 ( the address of IE value ).
>
> v3: change commit log
>

Would have been great to have a

Cc: <stable@vger.kernel.org>

tag here. I'm not sure if "just have GregKH on CC" is the right process...

> Signed-off-by: qize wang <wangqize888888888@gmail.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/tdls.c | 70 +++++++++++++++++++++++=
+++---
>  1 file changed, 64 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wi=
reless/marvell/mwifiex/tdls.c
> index 09313047beed..7caf1d26124a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> @@ -953,59 +953,117 @@ void mwifiex_process_tdls_action_frame(struct mwif=
iex_private *priv,
>
>                 switch (*pos) {
>                 case WLAN_EID_SUPP_RATES:
> +                       if (pos[1] > 32)

Really, you needed a magic '32' here? Would be much clearer with:

  if (pos[1] > sizeof(sta_ptr->tdls_cap.rates))

Same with many of the other cases.

> +                               return;

Is 'return' really the right answer for all of these? Just because,
e.g., the rates IE is larger than our internal struct, should we
really drop the entire frame? Should we be continuing to parse the
other IEs, if possible? Or is this overflow a sign of a totally
damaged (possibly malicious) frame, because it's required to be
smaller than this? (Sorry, I didn't read the spec here yet.)

>                         sta_ptr->tdls_cap.rates_len =3D pos[1];
>                         for (i =3D 0; i < pos[1]; i++)
>                                 sta_ptr->tdls_cap.rates[i] =3D pos[i + 2]=
;
>                         break;
>
[...]
>                 case WLAN_EID_HT_CAPABILITY:
> -                       memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,
> +                       if (pos > end - sizeof(struct ieee80211_ht_cap) -=
 2)
> +                               return;

For checks like this ("past 'end'"), it does make sense to return.

Brian
