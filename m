Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20EB39D308
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jun 2021 04:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFGCnX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Jun 2021 22:43:23 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33527 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGCnX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Jun 2021 22:43:23 -0400
Received: by mail-ot1-f49.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so1580288otl.0
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jun 2021 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMYq/fUfhoTG3yARgAOvonRXPE0qKYTNauPK8taCErY=;
        b=YXmGUwYxIz/toXU6x0gRzy7PUOayh6FDoG0x3N/Fb1rDlIoGqnNx1f/TJ5BVfw7arF
         Hr+4h5duM7cIXb3C9ATDeeCA0xTXonwLl62Z9gSkDYL2F0aSwBLGhxX5F549xG5uJcY0
         X5ZpTAYsZg3zSB2lM1NXf+3ap59WDx2/jSmryjohDfznoX8GQzjy/cnVpLcIFv1PovYs
         nGHfdjEwBA0pthyl8RUbgNkUBJIOR0RsHwMSR8je9KU4tTGMnrMmZCWY1KDezqC2X5fL
         TV15QhtLw/kyS21AbnTNb23YFTJDHJS3RJRkq6y2FYvcHnJefQTN3v1AZYeHgu9O5YrU
         gDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMYq/fUfhoTG3yARgAOvonRXPE0qKYTNauPK8taCErY=;
        b=bb1UdKtMbDUMBxGSmw8ldBu4j55aFBGi7Hh66R5FJS7V404MJyMw2ZjvIrdOgdPuK7
         aZxEVIzIPRL8KHveouBOR36krkqtCfNkzwDPolDQwPT5+rRnWrh+PA6WlgA/om6s2BoR
         F6VjLiP04tTQyPGKDBpIlcitPV6LJRMzXj0Bm6JLliguj2H83kMeoej4ruFgsiswGSzj
         TtKpRL/e6xKU9CMF45WlabrbwUflx9SLFczEM8UtF8v0/BEoLvYr/9oBPPGTBlF17T7n
         HYYSvhh7EksnxGL6D07O+38xwoD5LZun4FWtaq24fqVC9YJrKoShg8oJM7bDDrrSlnYc
         Pcsw==
X-Gm-Message-State: AOAM532tz3CTw4svKT+JfKIip5gGvnWATGmybPKyCorPsM4g6bOTOyWf
        FIqXoEv1pGvkP0B6/xD+OmsznSqXh5U=
X-Google-Smtp-Source: ABdhPJxfcGw6RPwQ0+XZ4XFuGgpOMHnR/EAb4gdYYHDsNAbMfC0q8wpDkhe6EAVWVth6fySxSrsYdw==
X-Received: by 2002:a05:6830:22ec:: with SMTP id t12mr12393647otc.243.1623033623171;
        Sun, 06 Jun 2021 19:40:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id j24sm453933oou.8.2021.06.06.19.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 19:40:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
To:     rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com>
 <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net>
 <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com>
 <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com>
 <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com>
 <d65a162e-9d0c-fff9-65e3-4553a1981ad3@lwfinger.net>
 <hXlLGR-ccu9ozKXl1rsCyt7jWfmH0ufgepYDXU9dkZUYJWDmwjflabUNuxh-XWDeey4GQRjaSmtSIEqFsY5mieunEOMCTawMpyFzW9dbA0A=@protonmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <37f988a9-8966-3482-f0ad-812a8cecce00@lwfinger.net>
Date:   Sun, 6 Jun 2021 21:40:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <hXlLGR-ccu9ozKXl1rsCyt7jWfmH0ufgepYDXU9dkZUYJWDmwjflabUNuxh-XWDeey4GQRjaSmtSIEqFsY5mieunEOMCTawMpyFzW9dbA0A=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I just push a patch from Realtek with the following commit message:

8821CE with ASPM cannot work properly on Protempo Ltd L116HTN6SPW. Add a
quirk to disable the cap.

The reporter describes the symptom is that this module (driver) causes
frequent freezes, randomly but usually within a few minutes of running
(thus very soon after boot): screen display remains frozen, no response
to either keyboard or mouse input. All I can do is to hold the power
button to power off, then reboot.


Please do a 'git pull' and try the new code. If you still have the problem, the 
quirk may need to be extended for your system. Please run the command:

sudo dmidecode > dmidecode.txt

Then post that .txt file.

Larry
