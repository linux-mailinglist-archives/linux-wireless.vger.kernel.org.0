Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DBFEDDF0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfKDLsM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 06:48:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38827 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDLsM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 06:48:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id v186so13809398oie.5
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2019 03:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dr7oAL69aankbuJ24G/tUcey4nEuOKiFOYmzHHjEyQ0=;
        b=OXTECYhtoBcNOyTAy5gxO/nqmzYXjz96+YkyvTsFIsEevPZYFi1Gg/vGmzL015xQ21
         6I7aYfI0Qz40nso9wdDZYMhIXmdjYo92JyVhI70+gZomZmTYkC7cNy+iaD0uG9qG0hoQ
         ejRYS4dhkPPS386oWRDGdzEpxCL6ojXGo3z7Pc2ldDs/4Q2FbvtQY5CjRTy54ZQcTaKd
         HyeaoZWRMJCRAlOm6ZgP0WLt65vYSH/mYEY5EaG435g57Ik+I6T8e8B05NNHpTVZ2S6o
         fYuMcL2AubwA1Zx174bXpn1mqB3mHhrrL6ggEnH5TuN13uFetM/igUbKQIVk5/lOQ83I
         /yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dr7oAL69aankbuJ24G/tUcey4nEuOKiFOYmzHHjEyQ0=;
        b=Qt0BkX0ub+8QhUs6ylDbQVlMpqweEhmAnipDgT2rr8epK1G7ogTRC27b/bqG/ZeAXD
         rX9opOa4NCIB2cjUc6lLdA2GUS37scGyjhbbF1f3X6OFuJr5gnRnN9V8/9mEjIH5tOnj
         a4D2o3vOV67oFwtdnr6UBPJ9PzZh64RzhERwzuhCQmcYXceI5Q6IVieNY65+UaXTjtgc
         IkHgVyXzmB48Ku7FqItOyWb7tSck4tSEYWT+YfZRR/jM/SxpDbeT1FW8JrwTX39iah6q
         KYhyMM7WslLPFsLpbvLI+7wcg2B7Y72jUB2OcwKN6fdh/nMQB4F/m2ZfdJcU1WHR/0U/
         G8PA==
X-Gm-Message-State: APjAAAVtgKAjtIxYKrwS9lAfxW3T0y5NQd9LsnKnGPaGwdPM9k15Ygho
        RGaZ0l+FQDTrXfYcqOTDs0PNryolTm9AxCgHjhU=
X-Google-Smtp-Source: APXvYqzMgMOxU/HtT9DxZZGB0qBsSUSFE7dBpzrhTy/1bFhaZ+l6VaOFDGEOOwJ3EYNx1u9LQ2vLbQ6Gab8KYL4WkxI=
X-Received: by 2002:a54:448b:: with SMTP id v11mr28402oiv.155.1572868090051;
 Mon, 04 Nov 2019 03:48:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Mon, 4 Nov 2019 03:48:08 -0800 (PST)
In-Reply-To: <20191104090058.GA1258@makrotopia.org>
References: <20191028212244.GA2590@makrotopia.org> <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org> <20191102154639.GA4589@redhat.com>
 <20191102174227.GA1250@makrotopia.org> <20191103144749.GA8889@redhat.com>
 <CAKR_QV+LkUU2+G7z8um7RpSbi0ANfRGe_TeoGky+U9ff=8sOZA@mail.gmail.com>
 <20191104084823.GA2306@redhat.com> <20191104090058.GA1258@makrotopia.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Mon, 4 Nov 2019 12:48:08 +0100
Message-ID: <CAKR_QV+8+E78UXkmL7+ZwitBXPww5aje2u+vVXpnVFxFJb7ydA@mail.gmail.com>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04/11/2019, Daniel Golle <daniel@makrotopia.org> wrote:
>
> ePA/eLNA is available mostly in markets which allow higher TX power.
> ePA/iLNA haven't seen it yet, but theoretically possible.
>

ePA/eLNA design can be done in different ways:
1. using separate chips for TX path (PA), RX path (LNA) and switch
2. using combo chip for all functions. in this case you can configure
chip's LNA setting to bypass mode, effectively switching it to
ePA/iLNA mode
