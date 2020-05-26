Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9751E636A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390851AbgE1OLe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390727AbgE1OLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:11:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9EFC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:11:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so13607335pfd.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:dkim-signature:date:from:to:cc:subject:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+ux/O8sdPOla7zQn+ZvQMsLjonRmIJxHydxeTR+/dVI=;
        b=clKRvCjf6e0igoB3xGKScehYxXMsvTfWW/I9p+SVA67Nt4AGnD9vGHhI9d3QnNwvrc
         9urwYciI+uqRljvr1cJYQ70Arkdg0RRbP+Ze8zdRbRdoNvDlEaa1qt5thFjtqGR8Qv5L
         2j2Y075X2zYN1ju9/0ngobOCx6C3M8M2JoxCJAhyEY9IMzv2MTdADxGmYR1Qeph1HiuO
         u8+g4jXD9/yTXH6OW4v+pElgWixsQvmA7IGAVMKXEvbLCAgf3Oe0yf3blyvir+r0IZBR
         c98EYcpEw7pblS0sQYACVoP844x2W0yEu9gDs8Yln0PrBD818m0aPS2YM/g7HEhvg0Ax
         8tvA==
X-Gm-Message-State: AOAM53288/hAxp/mXMpluiDYDfg2HUYp4tDPRO77VzMnhB8/vvuhvEZz
        T/Aj3F4ZhuC5wLgSqDc+L3QOSPicwRI=
X-Google-Smtp-Source: ABdhPJygJZCNRt4uEfhX4N4c+8dPxe0Mc2JNpJD98djs53Y0zEh4hSl39+KCEu0C6K+N4x+Bgyzmqw==
X-Received: by 2002:a62:4e91:: with SMTP id c139mr3273664pfb.285.1590675090872;
        Thu, 28 May 2020 07:11:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 62sm5004181pfc.204.2020.05.28.07.11.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:11:30 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5B05640605; Thu, 28 May 2020 14:11:29 +0000 (UTC)
Received: by 2002:ab0:1445:0:0:0:0:0 with SMTP id c5csp618602uae;
        Tue, 26 May 2020 15:46:11 -0700 (PDT)
X-Received: by 2002:a2e:9d90:: with SMTP id c16mr1567660ljj.137.1590533171668;
        Tue, 26 May 2020 15:46:11 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1590533171; cv=pass;
        d=google.com; s=arc-20160816;
        b=o5oxcHqDUdTBSpgGzMvS68yh25CUjaO6cIRs+qUtkm38AOMvaMTE5GV/hJ2nDieIX/
         5ImDbBbJ5i1K42Q/twZpDr87qy+UjCxcofsvbzhK6xfGvVARQESdh0fjy05RDcV5I58f
         d9qV9coMWusctHv+EMRDVABBzKPEmz3itj7tmPufIrCFsr3HI3hDoC+UvxmzD8uNWZJb
         A6+btAQRMcVrnSaAPZOr64t+LWmeyM/e2S1ud7LbcXB/RMy/ZiTVJEV1jppEQWARLw5q
         xSnRJ242ZNMUHbWXHQM7PQCr3/L2C/7UPCdfwswRkG9zJdQMOmyQah9B2tsN33w1yJJw
         yumQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to;
        bh=+ux/O8sdPOla7zQn+ZvQMsLjonRmIJxHydxeTR+/dVI=;
        b=FFRkW35VxNu3TDrapRcBpCvF2tDEclWd78OZGHGAegTEv/T2nW+21XzdRayw55ghPX
         xaHmNyVvUfErGU2Wq20QjOuAXJXgKWn251/qPJ71aAdHOIwLeBDrWfKbgFM/KqPqZeMT
         AdMjaB6GEHOmPxunN4Dy2yvCa/wb+VC38zl9/mnrEvqfMR26qt6VM3113o+ox7ceHxeR
         Ad8NzQx/HaaDfFgSnJ+2h3+tW0lrn1cAHPHCYrseXO4Rn5Tpl6n8ERPCRCoB580aEwTv
         7B3gBBebQ8Jy3aCE1LdI3RGdoAd5doh8pXl+/2omuaD8Lg1mj1Ad18B3MdDRuxdkgYc+
         9hnA==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cb0Eibk5;
       arc=pass (i=1 spf=pass spfdomain=kernel.org dkim=pass dkdomain=kernel.org dmarc=pass fromdomain=kernel.org);
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) smtp.mailfrom="mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com";
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id n1sor619885ljj.25.2020.05.26.15.46.11
        for <mcgrof@gmail.com>
        (Google Transport Security);
        Tue, 26 May 2020 15:46:11 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) client-ip=209.85.220.41;
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr1542215ljk.144.1590533171326;
        Tue, 26 May 2020 15:46:11 -0700 (PDT)
X-Forwarded-To: mcgrof@gmail.com
X-Forwarded-For: mcgrof@do-not-panic.com mcgrof@gmail.com
Received: by 2002:ac2:5305:0:0:0:0:0 with SMTP id c5csp545448lfh;
        Tue, 26 May 2020 15:46:10 -0700 (PDT)
X-Received: by 2002:a17:902:59d2:: with SMTP id d18mr3126212plj.199.1590533169795;
        Tue, 26 May 2020 15:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1590533169; cv=none;
        d=google.com; s=arc-20160816;
        b=UVK8vmFAJjxfDqok8gCnLeGi45aNrI6S19bow4qUzp0H3Zq8ysjfPwXHWjKnz0XS17
         qdiDP+XRdtX2zfda256q7d4fztXTeN1ssvfBPDJ71bopgwHv8GMMelzV3iMnDXkp2Alu
         5ANclVTFO72bj0wZD3CPf9AjqBblzqwlPj8iCyRAwJ3a1LaUW/TlwUUqpdYsdIRntL4E
         edEJhiIX0udKwiBjNETSBY/MBPpJUIczAAGKVkmOUlpU0qH1PB89QyUSPd6AwB6Pdhy/
         jIFPZ2LlAZ85kiIbagsOG1TbvUbEL+DN6bACoP2NW/ZkrMYVeXvmaceJFqMXuUc/DxHk
         5DIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to;
        bh=+ux/O8sdPOla7zQn+ZvQMsLjonRmIJxHydxeTR+/dVI=;
        b=gMKR0aFPUFIbKohdN9mEajsYmc/LdFlJeK/+uQdWEqTghLM8RFuIL19/qit1OcGNPC
         mivfBIWYq9a1ZsbKmXopgujlWDmJl7Dbew8t+ISzS644S2iJsi+rK6c4SRetVvd6hM2j
         bvj+h26It7E+G2rVrzKs34fmEECpJyCaeF1KTpv3OrkJMrcrtbyZucMvjkrHTncLRBUm
         HgOGbujt9W4436S9eNz6UJuSEUwcBlSFZpH5S64+nE7lQppmwAmg7Yfq+nvhci2hIieM
         Sg8m4qH0sDVLm0XlqR9K8ZovF+dqWP7Qum+Pa/sIIOZugBCLzkf4Q+hFXZmInMtRZs87
         ALqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cb0Eibk5;
       spf=pass (google.com: domain of kuba@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=kuba@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by mx.google.com with ESMTPS id i3si737442pgd.427.2020.05.26.15.46.09
        for <mcgrof@do-not-panic.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 15:46:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of kuba@kernel.org designates 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
Received: by mail.kernel.org (Postfix)
        id 5B725208C3; Tue, 26 May 2020 22:46:09 +0000 (UTC)
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDBB206D5;
        Tue, 26 May 2020 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590533169;
        bh=4VoXxRVTE3aUe4DriyuaiIDULO39iyZazGY56WATyv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cb0Eibk505H8ZxcbbJZVkrpORxeYQZmf0ZrrYrbipHCaqg7YlUb/TTqp3zb7BDBWx
         Vi3vWmeo/d8/1jYP09Qb9Qnrw7t31w6GKTFZQHx5ws1SHsoWDVhXP6qbMItUDJmsKI
         RQx1zpkIVOc62sRLCh+zvSjnS0HpLl+lGyK1HzSg=
Date:   Tue, 26 May 2020 15:46:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, davem@davemloft.net, michael.chan@broadcom.com,
        dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        kvalo@codeaurora.org, johannes@sipsolutions.net,
        akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        derosier@gmail.com, keescook@chromium.org, daniel.vetter@ffwll.ch,
        will@kernel.org, mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/8] kernel: taint when the driver firmware crashes
Message-ID: <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20200526145815.6415-1-mcgrof@kernel.org>
References: <20200526145815.6415-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TUID: 7ZVwTbmkgmO3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 26 May 2020 14:58:07 +0000 Luis Chamberlain wrote:
> To those new on CC -- this is intended to be a simple generic interface
> to the kernel to annotate when the firwmare has crashed leaving the
> driver or system in a questionable state, in the worst case requiring
> full system reboot. This series is first addressing only a few
> networking patches, however, I already have an idea of where such
> firmware crashes happen across the tree. The goal with this series then
> is to first introduce the simple framework, and only if that moves
> forward will I continue to chug on with the rest of the drivers /
> subsystems.
> 
> This is *not* a networking specific problem only.
> 
> This v3 augments the last series by introducing the uevent for panic
> events, one of them is during tainting. The uvent mechanism is
> independent from any of this firmware taint mechanism. I've also
> addressed Jessica Yu's feedback. Given I've extended the patches a bit
> with other minor cleanup which checkpatch.pl complains over, and since
> this infrastructure is still being discussed, I've trimmed the patch
> series size to only cover drivers for which I've received an Acked-by
> from the respective driver maintainer, or where we have bug reports to
> support such dire situations on the driver such as ath10k.
> 
> During the last v2 it was discussed that we should instead use devlink
> for this work, however the initial RFC patches produced by Jakub
> Kicinski [0] shows how devlink is networking specific, and the intent
> behind this series is to produce simple helpers which can be used by *any*
> device driver, for any subsystem, not just networking. Subsystem
> specific infrastructure to help address firwmare crashes may still make
> sense, however that does not mean we *don't* need something even more
> generic regardless of the subsystem the issue happens on. Since uevents
> for taints are exposed, we now expose these through uapi as well, and
> that was something which eventually had to happen given that the current
> scheme of relying on sensible character representations for each taint
> will not scale beyond the alphabet.

Nacked-by: Jakub Kicinski <kuba@kernel.org>
