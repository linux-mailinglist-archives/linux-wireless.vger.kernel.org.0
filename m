Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695BC47FC83
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Dec 2021 13:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhL0MMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Dec 2021 07:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhL0MMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Dec 2021 07:12:08 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B341C06173E
        for <linux-wireless@vger.kernel.org>; Mon, 27 Dec 2021 04:12:08 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y11so13395257iod.6
        for <linux-wireless@vger.kernel.org>; Mon, 27 Dec 2021 04:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=l7Kh5rtUsCjTkH5/Txyeuta1EOC4pl0Rqghl8KzLAZA=;
        b=lCsd5gI5qystnhuHNdT9v5LI7x51Yb33qRvOOEQn9/p6L/rIamJ9hNps1PRkoCrn28
         rSqF0eoUMM58RpTvGA4uuX5ELTxZP5YOZ8yQcKMyrkJjolpHYBOtbxKlMQKV9W3CJ3WZ
         6WgVsscV6T9dqtv9CaEjIdGECD493QqCdEBDg+DMsgIvoQWgu0L9lK4HHKv2htqEcTow
         7Bhpa8w8IrO/6THI022HUGz8Jdsl5v6p7DC4Ai8KS5u5OlwqgNQGPIAQlkFFTBDvZjal
         w0Iho1quvOdpW8g5ZHGd/JWxQWgRnupgzd+wnyaCxaU+5qtpjiZqzcESKVjqLwE7vyP5
         4vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=l7Kh5rtUsCjTkH5/Txyeuta1EOC4pl0Rqghl8KzLAZA=;
        b=jUDpuARFmY0fTxBgh1Oo1v4pfMFflj0yHS3EEsWeFqM0zpPWB+6dGalMWFdrCxBPBo
         SOkcV3L3jxcej85EExr/iSrEJdZEXIdfEDcTjJj+K4pexMMqNBadU9e303Bkqq3KOw6V
         yCjHtBbtZTqbmkkPUUcUaEDIqwKr9qTBSoVWG6HYZsmmkEeutU2dGwi2ggFTwH+dj/b8
         R+xX5kNOBqa47TZ07Ljn9wmMkdR+05ZtMIiXA6FH0yxmRfYAVD7uWRyKFoQL1k1IqIYr
         qTQSw18NnkBHc2ZyprWtd5eZroousGEy4nEX6DtIhWyg9tESO8pAxyWXaGzcEK4J/is1
         NWpQ==
X-Gm-Message-State: AOAM533IOrt5b/AqnidOHd91M35KL+Zu57GPbr184ydKBe3LXQT1NWhr
        CnXknw2oztLOvFRRfJCMJ6Q/Xkj6Xy8XMiWXP4A=
X-Google-Smtp-Source: ABdhPJyNSzDs3Ha7XE1dBsFCYhjwSd7ohrOcu8Q84/F3w437oSe+Vas1EFn9b02x/LahsGlJmaXWNHE5Rj2VJy58pI0=
X-Received: by 2002:a5d:9857:: with SMTP id p23mr7293770ios.137.1640607127123;
 Mon, 27 Dec 2021 04:12:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:dc11:0:0:0:0:0 with HTTP; Mon, 27 Dec 2021 04:12:06
 -0800 (PST)
Reply-To: tonysiruno9@gmail.com
From:   Tony Siruno <barrscottg@gmail.com>
Date:   Mon, 27 Dec 2021 12:12:06 +0000
Message-ID: <CAOhf+xwM=4QDN2_jbwC+9cQqkg=DXUKO86P7QGzwSgEdgZMC2Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Frohe Weihnachten dir und deiner Familie? Warum schweigen Sie? Ich
hoffe, es geht Ihnen gut, denn jetzt habe ich Ihnen diese Mail zweimal
gesendet, ohne von Ihnen zu h=C3=B6ren. Heute komme ich von meiner Reise
zur=C3=BCck und Sie schweigen =C3=BCber die Post, die ich Ihnen seit letzte=
r
Woche gesendet habe. Bitte lassen Sie mich Ich kenne den Grund, warum
Sie geschwiegen haben. Ich habe mir vorgestellt, warum Sie mir nicht
sehr wichtig geantwortet haben. Bitte, Liebes, ich brauche Ihr
ehrliches Vertrauen und Ihre Hilfe. Mit meiner guten Absicht kann ich
Ihnen vertrauen, dass Sie die Summe von 12.500.000,00 Millionen
US-Dollar in =C3=BCberweisen Ihr Konto in Ihrem Land, wenn m=C3=B6glich, me=
lden
Sie sich bei mir, um weitere Informationen zu erhalten. Ich warte auf
Ihre Antwort und bitte lassen Sie es mich wissen, als zu schweigen.

Herr Tony Siruno.
