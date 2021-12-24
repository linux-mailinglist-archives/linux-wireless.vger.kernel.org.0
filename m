Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548647F0C2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 20:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbhLXTfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 14:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhLXTfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 14:35:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B5C061401
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 11:35:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso4973474wmk.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 11:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=q6ntTDmWcp+befEf+xGvJWBQrPxOcnsAvCYh25qGqABUdSCqeIxhd+pypuVFixp3Hw
         3iNk3/iNuEeWEwa3H3yC6r5ggYp2lEf4UlVMNLtwRGsHWs2TMl7NB41G9mDM3PuuT773
         TaM+yCWj8ufpPA55wao45yH7eEOf3LrBi+fmSbceIvod0/k57UlMBNBxizPIiLsN7zoJ
         LTwVB+Bm/1UVonjtQ5jwQozhoPizxV0wMMCfbhFfcBeIqqos7ooOsNzoBenkcncP2OEw
         ht29TeJH8GNlSHJBFov4XDnLttSjsJ6GEvUOVKlzOlkupEiNmBhDNBi3RwxrV/NBaBb7
         vbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=0u3Cnivrk7IeRNydaixD32ChXISmeAo6cTl+yTjMoPbOw5Ra9EFYhg9EaPblU5vA2K
         J7BxzcEc7/1rJ0+Nr37yvhQn3aA9rtXuZi2pkxMyDriKGxGGp+0LkR4Q7M8px7PNUGYD
         Ek86h+1mIEL5xbuwwnynKnkTXNKBfYDyErjvKjKBl2f1nvLd8keK//qvwQhOazpaBQNE
         vq7E0DG4nRgp5EUHPUQGrD8u/0BIfbUVU8WFkBrUXBag8sJaMlyVuBHib5UrlxSrUHwl
         o18Yk7u87nn8awtIYjPdonfbbPqdatdmHce/dcMmyk4XwdY3ScKMOuJAlxTHErhf+aC7
         FtmQ==
X-Gm-Message-State: AOAM532ihLJXNwKWlQhEfXhOPCpmzc848uQ9xr8qw3XmUzFhiqjTUD4R
        9V+h0M1DeuScslN034AaD3g=
X-Google-Smtp-Source: ABdhPJz/Qj2CgM0M1TNhqEfG5DrgMVQP1lQodSsUutTW2omBEkGs+0Gw8OiT+YG3BkVoNDxXzfOLww==
X-Received: by 2002:a7b:cf0a:: with SMTP id l10mr5675267wmg.36.1640374521488;
        Fri, 24 Dec 2021 11:35:21 -0800 (PST)
Received: from [192.168.9.102] ([197.211.59.108])
        by smtp.gmail.com with ESMTPSA id l25sm8254534wmh.18.2021.12.24.11.35.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 24 Dec 2021 11:35:21 -0800 (PST)
Message-ID: <61c620f9.1c69fb81.9654d.56ba@mx.google.com>
From:   Margaret Leung KO May-yee <abubakaradamishaq631@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Fri, 24 Dec 2021 20:35:10 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
