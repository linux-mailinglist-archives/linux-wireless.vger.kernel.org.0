Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A511AF258
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDRQaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgDRQaZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 12:30:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D7C061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2020 09:30:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so6585198wrm.13
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2020 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5lQ44ahYpV3bCbPbeR8nUcPwQKMRs9861oUuAKoOHo=;
        b=aVXOUMaCFdR+69xrK8SZJq8Nk2tMiqJ5zWIACyBOno5lqXdKQL5Igam08BYunkhFVQ
         jG3RetHNuVjeUDzqvVjiU2jX0ADp4DE3fU52RE6+bpwws72khuMa+qvC/EaFjVuCRruP
         I2F28Jkue28HeO2O55oiQhp3GIZSBUYZn9N+mYpq6vwQAwS98yiBiBcTo3Z5d0SOQ7bG
         ElA9pzighsPtXdlPH++OmxYXFifnQzfaobsvu3nZ60N84bpAg/I5NSrsDgEkFa/q69Sz
         NVvgd3k332JHIiZ95mnEoc+aFCgE+S5zvJzAt2xh8dbbO+iM8D0Q/++PShJlLiHK5R46
         QXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5lQ44ahYpV3bCbPbeR8nUcPwQKMRs9861oUuAKoOHo=;
        b=BU79Kd2Tw4RZNhq3K3MJXd7paDPTrv+H9W9hDlCIZAEh95tjXwPA0oO+4gojQI0TTc
         df3UAjRf2k0t3FjOecoEeZlwSwsnL8aIf9Pc4inMuWr2Ym764C72bnkii7RHAvLP76Iw
         7565MebmzGlKzmNVCuanPlsbWypcS8wgPI7/vmyU2Y5zMum0G1uGF+5OdQDaA9RIZ4rx
         rI69CP74IKhuQcz9/MZqCMkCBmAfPco7NMeH3V25+4LuMbY21sv+sGj803Z7sna7JKPj
         bX76EyFoe+3ychRV42xNEeSmXtugaTHX4DsigiqckAsJcRKgtd9Bt8NhFrjVF7lweZ3k
         AwWQ==
X-Gm-Message-State: AGi0PubTj2FXJwIEiO5ny41R18xMAtguRD+S1k2Cc57IkrCE62dD5UwY
        MlmFeTUJonf2CIgjSgZw4hQgNu9t
X-Google-Smtp-Source: APiQypJIFCRrXu5V+sPGL6SFQFjS9n1hql9wi0upkeWAgiTlTcdsc6Je2/FWfNElZkiLTIH7QEgDaQ==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr9650766wrp.344.1587227422175;
        Sat, 18 Apr 2020 09:30:22 -0700 (PDT)
Received: from debian64.daheim (p4FD090F8.dip0.t-ipconnect.de. [79.208.144.248])
        by smtp.gmail.com with ESMTPSA id v131sm12538420wmb.19.2020.04.18.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 09:30:21 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.93)
        (envelope-from <chunkeey@gmail.com>)
        id 1jPqMC-0005Za-5Y; Sat, 18 Apr 2020 18:30:16 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Frank =?ISO-8859-1?Q?Sch=E4fer?= <fschaefer.oss@googlemail.com>
Cc:     chunkeey@googlemail.com, j@w1.fi, linux-wireless@vger.kernel.org
Subject: Re: [Bug] carl9170 + wpa_supplicant: P2P mode doesn't work with separate interfaces
Date:   Sat, 18 Apr 2020 18:30:13 +0200
Message-ID: <8972271.5nXPVzACVl@debian64>
In-Reply-To: <3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
References: <3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Saturday, 18 April 2020 13:20:27 CEST Frank Sch=E4fer wrote:
> I'm currently testing Miraclecast=20
> (https://github.com/albfan/miraclecast), an open source=20
> Wifi-Display/Miracast implementation.
> In one of my setups, I'm using a carl9170 device as sink, which fails=20
> with the following debugging output:
>=20
It's been a very long time. But I do remember meddling with P2P. Part of the
reason is that the carl9170 driver needed these virtual interfaces initiali=
zed
in a specific order.

So for P2P GO+CLIENT, you would have to initialize the P2P-GO interface fir=
st
and the P2P Client interface second. Which is backwards of what the wpa_sup=
plicant
does.

Same is true for STA+AP (Repeater). The AP has to start first before the STA
can be brought up (Also the STA must not interfere with channel operations,=
 as
the fast channel change feature doesn't work right on the AR9170 Hardware).

This is documented in the driver:
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/net/wireless/ath/carl9170/main.c#n625>

and was changed as part of this commit:
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
drivers/net/wireless/ath/carl9170/main.c?id=3D7f878b0d96e6b3bd27d736fb2fb7e=
3cc94b16b26>

that identifies the wpa_supplicant commit
["nl80211: Automatically use concurrent P2P if possible"] as the reason.

So since this broke, something must have changed since 2012 I guess.
But I need more details, before I can do something.

Regards,
Christian



