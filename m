Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264621E42B9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 14:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgE0MxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgE0MxN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 08:53:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CED9C08C5C1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 05:53:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so11709796pgm.13
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 05:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:dmarc-filter:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=SwJVwRsf4JLRcqoa9J+40Z33dh8YZfs8m9tFvpvW4ww=;
        b=SSlFe7MA2SA33/ziboY+8MchPYL/uwc7SejhWglkwChba71v+KXGHXH3UFgk36hM3E
         fnCpSeGnQdVzpxAXp3/v+ht8y99yCNvaa/tsFX7ND54BW3G/WxRMJXGTyhSVBiCIRMbr
         LU1nPimMTio+RmfZBV/dp8PrY+e/lmkI9SZwQ4ZTFBguA/KxBjBa+2LhoIhB6FGtX/HA
         49Oa/CStWePSbtOvk1+zQSp7YvAOZRxkLbZXLyM+n/r60I7mFtpJksAzCQ4jaa6+kCOr
         bKIno0QfxlD59vDZbVeMeVbbIDNaFctIssMzSPhHxb7Gfy0z3+COCZVaCHUvHqCht+pK
         eh6Q==
X-Gm-Message-State: AOAM5328dWiCzO2DM7De1EQg3Vd1BBoc2gzg3Rg4ah68mmqJpb/NPTZ3
        XI3oQkhcY8BbyTvEMWlqAjOXrljfwaGwDg==
X-Google-Smtp-Source: ABdhPJzhuMdWwK/V4rFxw81WcnG7mxjCmAdEg/qL1cMG7cB310WCF/Ut9C69esLv5P14mVvY0Z3+Nw==
X-Received: by 2002:aa7:93d2:: with SMTP id y18mr3645053pff.181.1590583992636;
        Wed, 27 May 2020 05:53:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i10sm2095427pfa.166.2020.05.27.05.53.12
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:53:12 -0700 (PDT)
Authentication-Results: mail.kernel.org;
        dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QV6eN1wz"
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=michael.chan@broadcom.com
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 940B140605; Wed, 27 May 2020 12:53:11 +0000 (UTC)
Received: by 2002:ab0:1445:0:0:0:0:0 with SMTP id c5csp440185uae;
        Tue, 26 May 2020 11:09:53 -0700 (PDT)
X-Received: by 2002:a2e:7c19:: with SMTP id x25mr1162047ljc.385.1590516593592;
        Tue, 26 May 2020 11:09:53 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1590516593; cv=pass;
        d=google.com; s=arc-20160816;
        b=WqHqgZYsPikEOLDdLWg0vBvs4ChVS+jSR/6hgsixcGsCv2pcFHixgVouJp15RkMSXW
         eae8C+z3+ym4tEZK7BIkJTgHIL4r0qIhtHY51CiZL+t6Fd5kLcUIouJBBJcwnpXI3gcA
         sYYWEIwzkoTsBhOjs1MbisdRq8rKGFpKsRTxOJi8/OAOGQv/bnhDL4uCF/Tx9SDuzSVJ
         KVm2yOXO9ZnKLJTgvyEwZPK0MjHvJ9ECC4/hzLWtCYlIRWNPn+POy6pWdM+JaumWtdBx
         C0PVG6T+IjlMVBxU+/VSMMSzkyHHORqC0a4XpPD7l7qod9XEpZ2Z/ajWig8QWNE3b6Yo
         ySmw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:dmarc-filter:delivered-to:delivered-to;
        bh=SwJVwRsf4JLRcqoa9J+40Z33dh8YZfs8m9tFvpvW4ww=;
        b=OgcWnVMnoIlugPzH/DRSm58OAWGV9O02uZhwZiaKr8R+gSLQMpsSvzhkJkWY1ZexiH
         +S0PgKHqlFQm0NLIfPWMtDblTUtLy5QYMyjo+jo+4NV40cCI59+Et7/9PK2o3VtqBVr7
         Bs1xaN9fRJZI5ANA4PtRu3adH/ACAtzapLHJbl5atX5bWWN2h+Zkc9PNXo04OLIH7pKL
         DjMQGY1098LoSxj8E2QxvyPbb8wY/h2QIJQeQYBtcs1bbGgSIbGg7yRRyz7BK5pn87gA
         CNKJJ04o9tGL1Yyi0z++pHpmSq7DT43M7xjAvbJgxPF3KJrUj/ETlBeFfMqMzttAEJfP
         Vb6g==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=QV6eN1wz;
       arc=pass (i=1 spf=pass spfdomain=kernel.org dkim=pass dkdomain=broadcom.com dmarc=pass fromdomain=broadcom.com);
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) smtp.mailfrom="mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com";
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id o5sor257978ljj.5.2020.05.26.11.09.53
        for <mcgrof@gmail.com>
        (Google Transport Security);
        Tue, 26 May 2020 11:09:53 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) client-ip=209.85.220.41;
X-Received: by 2002:a2e:2408:: with SMTP id k8mr1215621ljk.233.1590516593239;
        Tue, 26 May 2020 11:09:53 -0700 (PDT)
X-Forwarded-To: mcgrof@gmail.com
X-Forwarded-For: mcgrof@do-not-panic.com mcgrof@gmail.com
Received: by 2002:ac2:5305:0:0:0:0:0 with SMTP id c5csp363052lfh;
        Tue, 26 May 2020 11:09:52 -0700 (PDT)
X-Received: by 2002:a17:90a:738e:: with SMTP id j14mr472933pjg.107.1590516591784;
        Tue, 26 May 2020 11:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1590516591; cv=none;
        d=google.com; s=arc-20160816;
        b=o82/q4pQQ+n6xCWzfzbW++iyR70714widyojcwgSgm4qXoiflg7a0H2XKvHGmxKH49
         hIcQsihSO7wZLDSgNbEm+AkvjQpkfve9XjPpNbS4yYNvdCTWJfHr2ht6zEwcU+So7QWK
         407J7qC+1m6OTpXdf4ruaymHsjPzvMlIHN4xki/CS9tC1yki7XWtYJd6T270JlDUAGOK
         scnl+cmVCZCF17opjPqV3iPAs4P9lJubuwWUTKfDq3c9akwG4rhFQMFRjMMKzlB1B7Xx
         gHUioCjig2CXrk/GEQ4MLVQFN61N2VAVmgEMGt6RkMy5H13XsKmsjTRolHUtmIZWo2+I
         CJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:dmarc-filter:delivered-to;
        bh=SwJVwRsf4JLRcqoa9J+40Z33dh8YZfs8m9tFvpvW4ww=;
        b=iJ+bzVrwwkrHIQJLSMn8jFK4H8KQHSvFEzdX7KJk5su4xcD/4eNEZvV+qbr11qDMU+
         h4RcOqMsGsAlFvp4GJnMRk6EsIc9Gv4r06E+vqQ/pce1E0mu1d/68zxCUZTnnqFMDPvs
         fuQKMqnda8Ja377rH/ViSJIPkngXh0k5blGazsHYaobzw4d2xYWgtrTeLfy+dqnPSXZy
         pCa3+CTNhCQaFw/6+j8TFqjz8BldzfypsmAKK7PD9VZOQFbRzBM4TFU3hAS1vc8b51ds
         wgRcdQ/Lcm+yyT+szChBWENjdq+6K3f2tEvqeg926qXtC2ytH+WUrxM9vd2Q+7e00oR9
         URGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=QV6eN1wz;
       spf=pass (google.com: domain of srs0=k2zk=7i=broadcom.com=michael.chan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom="SRS0=k2zK=7I=broadcom.com=michael.chan@kernel.org";
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by mx.google.com with ESMTPS id f72si438476pfa.6.2020.05.26.11.09.51
        for <mcgrof@do-not-panic.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 11:09:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of srs0=k2zk=7i=broadcom.com=michael.chan@kernel.org designates 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
Received: by mail.kernel.org (Postfix)
        id 5782B208B8; Tue, 26 May 2020 18:09:51 +0000 (UTC)
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPS id 331BA20888
        for <mcgrof@kernel.org>; Tue, 26 May 2020 18:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331BA20888
Received: by mail-pl1-f193.google.com with SMTP id x18so7875905pll.6
        for <mcgrof@kernel.org>; Tue, 26 May 2020 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwJVwRsf4JLRcqoa9J+40Z33dh8YZfs8m9tFvpvW4ww=;
        b=QV6eN1wz/6AFupUQIoxfvaiVQr3VOLFnMyRTzupBK2x5UnbAlfVQHIl6yfVjKSnMu5
         umzskbig4ieeQkFfLiBEUxyS/rwM3NDzxKtqi8fgYUz362ncGMXqwUf3DjNADPk94joc
         sQer+mGXxLQjq5r5/VevoRSQ49Ax1BoPA19/0=
X-Received: by 2002:a17:902:e903:: with SMTP id k3mr2106595pld.317.1590516590375;
 Tue, 26 May 2020 11:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200526145815.6415-1-mcgrof@kernel.org> <20200526145815.6415-7-mcgrof@kernel.org>
In-Reply-To: <20200526145815.6415-7-mcgrof@kernel.org>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Tue, 26 May 2020 11:09:38 -0700
Message-ID: <CACKFLikEm7r82jB=qB3YafPoHp+mK1joOtRKS67a2jyhJegtyA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] bnxt_en: use new taint_firmware_crashed()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, aelior@marvell.com,
        GR-everest-linux-l2@marvell.com, kvalo@codeaurora.org,
        johannes@sipsolutions.net, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, peterz@infradead.org,
        tglx@linutronix.de, gpiccoli@canonical.com, pmladek@suse.com,
        tiwai@suse.de, schlad@suse.de, andriy.shevchenko@linux.intel.com,
        derosier@gmail.com, keescook@chromium.org, daniel.vetter@ffwll.ch,
        will@kernel.org, mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-TUID: h1hyBfy+jWLu
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 26, 2020 at 7:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
>
> This makes use of the new module_firmware_crashed() to help
> annotate when firmware for device drivers crash. When firmware
> crashes devices can sometimes become unresponsive, and recovery
> sometimes requires a driver unload / reload and in the worst cases
> a reboot.
>
> Using a taint flag allows us to annotate when this happens clearly.
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Acked-by: Rafael Aquini <aquini@redhat.com>
> Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
