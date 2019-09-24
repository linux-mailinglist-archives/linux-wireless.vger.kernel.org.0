Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E3CBC350
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392650AbfIXHtU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 03:49:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34485 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbfIXHtU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 03:49:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id m19so667061otp.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2019 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVZDBzFnn/+6/eX2i6ZvoSlRuJ3gztniPjuOgTp9/dk=;
        b=n8OfIJ7s4YOK4wUING3b8Y7BfaOB4T6MA+Ys/5+Vbh2+YRQfEdBCIkahUSco88/RwZ
         FyOGVH6WpTZSbNxkbcHvxipsUuiWoFdjVynUY3RvmoUxW125VAzkh5gH77Dk/yTJgp1S
         Are2idhLJkDX0y4Y79HUbvOMVA7qB4PpgR0u+xvgnjyMmPUwCPMx81lBfuUjBNommOmk
         Wn1FARh9Ia/DJ5oppLkdhzaNtB9oafOWqJf6HbPbE9O1Ayz9tLc82f6+r/OYy1N5VNM5
         SaqVpDQxR+MyI1Lhcw0qCztqsSUsOyFHKxbMwcKcoiaud82Z9spuqCpcrmGtET2lU6Wk
         9H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVZDBzFnn/+6/eX2i6ZvoSlRuJ3gztniPjuOgTp9/dk=;
        b=Xxz0Mhk1CV2ftIvpcSMUeTMHrqZnbxKzyIYsTNIYbmqSh2KNw4P7vDCvpF0V6ABauT
         9wlr1LEy70cm7UzK3DxPbYR/8OkGDaGgTVP77zHZLdTPXET0D7zGyb/6fZIg9BqG7lZV
         2eXA8XFlMxKoCqy4Jg7rDCCP7jluWkugw0EERr1WtLAFW2G0zJNXeRzYv9csg2Q59WIM
         dM4QpBa12ccm5IZLzZ6bjAhB5cl6p1UqjGI00UcHzg4WWTgjcvyNb2OCOC986wCcRwy3
         0iumNOAcUULb9bA10n9a15HEATG1hPPtR7/FiOEs6Gbo1YrV/fI5QiJfejsHmFDei8JY
         bQjQ==
X-Gm-Message-State: APjAAAUJ8BTRoY7Ffihov/48aasXKwnzPvu+s/UAWw5sYb2Pv/K+BvkJ
        gnppZjovDpezaE/ujGmGEvg0PSE2RzLJ6io0Za0=
X-Google-Smtp-Source: APXvYqzegMetRoVOqRGe1NS8PMI7YmLR/6NHLj0xcPYup7lHxHXMqTMG0/TKnNGFxX9JWPFVIVGwk4qc7xTb36M2Ats=
X-Received: by 2002:a9d:5f9a:: with SMTP id g26mr768874oti.27.1569311359420;
 Tue, 24 Sep 2019 00:49:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Tue, 24 Sep 2019 00:49:18
 -0700 (PDT)
In-Reply-To: <87d0fq5kic.fsf@codeaurora.org>
References: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
 <1569268165-1639-5-git-send-email-pozega.tomislav@gmail.com> <87d0fq5kic.fsf@codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 24 Sep 2019 09:49:18 +0200
Message-ID: <CAKR_QVK=XwLtaGgoLeU5-+XQP_-jVvAdWfkGvdyV9WNK_5QUng@mail.gmail.com>
Subject: Re: [PATCH 5/5] ath10k: pull_svc_rdy code-style fix
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 24/09/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
> Tomislav Po=C5=BEega <pozega.tomislav@gmail.com> writes:
>
>> Drop unneeded lines by moving skb data in both main and 10x WMI
>> pull service ready event operations.
>>
>> Signed-off-by: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath10k/wmi.c |    6 ++----
>>  1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c
>> b/drivers/net/wireless/ath/ath10k/wmi.c
>> index 59d2d2a..8ab178c 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
>> @@ -5345,13 +5345,12 @@ static int ath10k_wmi_alloc_host_mem(struct ath1=
0k
>> *ar, u32 req_id,
>>  ath10k_wmi_main_op_pull_svc_rdy_ev(struct ath10k *ar, struct sk_buff
>> *skb,
>>  				   struct wmi_svc_rdy_ev_arg *arg)
>>  {
>> -	struct wmi_service_ready_event *ev;
>> +	struct wmi_service_ready_event *ev =3D (void *)skb->data;
>>  	size_t i, n;
>>
>>  	if (skb->len < sizeof(*ev))
>>  		return -EPROTO;
>>
>> -	ev =3D (void *)skb->data;
>
> Actually I prefer the original style, so that we first check the data in
> skb is valid and only then assign the data to ev.
>
> --
> Kalle Valo
>

It came to my mind that this might be the reason why the current
driver did not give me warning about too short service ready event,
but there was no warning about event length in either case.
I even tested this with compat wireless from 2013. and there the
situation was the opposite: in both cases there was warning about
service ready length.
