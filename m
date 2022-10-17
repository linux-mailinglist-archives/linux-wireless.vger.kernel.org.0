Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BF60101A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJQNWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQNWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 09:22:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5455BC1A
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 06:22:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o21so8337941ple.5
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qi/0NrY08+G+EoafYoEMOS0ZQOg8vKnNR5/zoidHAMI=;
        b=qP+a53GiC9/beNUmMAlMnH+UQrmDLVIIVrWuBVCoOAQ5YDZwhFcGI+NQdDW8McaSIM
         2aY98N8YNF0LZscMRMVjVmBroOyL2I1IvCKfgsWOmkhmLFQd8jVi+V4AI14O3bR9GHKu
         2vwjQeTR2juCl9ZTz4L8kRQnKuVixOCBl68ErKT74HXI4B2AKbnebUgis5AZCqnTMJlK
         abSFD9VamiZUgk3JFdLrPv4ELkwKo4OV5EDSNf1WfIm1EiwkKWYPZLK5YMNhs7nuN08s
         XuN+5WX+/WrpkUcYIKmQoS2bkt52NpkCoUv/12OIHzenrZMEgf1KXXgd273cqTyahGvC
         ngsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qi/0NrY08+G+EoafYoEMOS0ZQOg8vKnNR5/zoidHAMI=;
        b=hDT5E7z2C4GM3kzjNpygUlbuEieY3cMAn/Gp8WKGjWv+axucJGGiTQk6YM/YS1C7Qr
         K2qGNyRJCpTB3hBd1HIxv0z4NObAGJjCAdi9+z0cIXOjgb6KucwnrgYYSenry30RMUJa
         PzH3gJHN8bVm70SwUEPs6+C9lfF9Y7KFsXGnBM1AdqWRYGxjxZkC40g45dkRSkw/LaX3
         F1qEUhJRnT2v9iYlFV1RaNf5XJUYbvS2NlCXNRoJueXEu7qDjPLlxw3ig0lejhkVZyZY
         AtZXSsO7XK2S4ZhPsmRQIesg7jhQ5b+/f2uY4J+yZnA2a8ufqIAY39KKUtxYgsVuBX9q
         QVMQ==
X-Gm-Message-State: ACrzQf0ltpqppcqeNACPsg4mFNJJQ21BPC3YVFrwD2xCsF0HY73EiBOa
        ZRFrM2isy/mAg2MjrpXxSLCzaRY5H6DE/a4lviTXvcOYlxs=
X-Google-Smtp-Source: AMsMyM7s+dCZJw2/N27P+Ftz9U3Jro1UHU4NutIzXJLnZ9ZnNbq/c/K1nl27wJOE0IaGH2/Rw+m0yFmmwk7IidiUjXs=
X-Received: by 2002:a17:90b:4b83:b0:20c:5ac8:1e30 with SMTP id
 lr3-20020a17090b4b8300b0020c5ac81e30mr34092715pjb.71.1666012934797; Mon, 17
 Oct 2022 06:22:14 -0700 (PDT)
MIME-Version: 1.0
From:   bommy985 <turkenlurken@gmail.com>
Date:   Mon, 17 Oct 2022 13:22:03 -0500
Message-ID: <CAPwNHCEiRC=caRmCjEdivdLtCLAMm56EHZbB6em_fbFU5RcFsQ@mail.gmail.com>
Subject: 8852be no longer works, weather on the individual github or the group github
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

especially interested in these errors, as even if i force version
magic to be excluded, it gives the error at the bottom, this is doing
sudo rmmod, as making and making install claims to be a success
i did not see any compiler errors in the compiler process, although
some warnings claiming that "x is always gonna be true" and whatnot

[   44.250693] audit: type=1101 audit(1665975479.413:87): pid=2145
uid=1000 auid=1000 ses=3 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="nootskoot"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   44.251413] audit: type=1110 audit(1665975479.413:88): pid=2145
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   44.251506] audit: type=1105 audit(1665975479.413:89): pid=2145
uid=1000 auid=1000 ses=3 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   44.306013] 8852be: version magic '6.0.1-arch2-1 SMP preempt
mod_unload ' should be '6.0.2-arch1-1 SMP preempt mod_unload '
[   44.307769] audit: type=1106 audit(1665975479.469:90): pid=2145
uid=1000 auid=1000 ses=3 msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   44.307820] audit: type=1104 audit(1665975479.469:91): pid=2145
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   48.155859] audit: type=1101 audit(1665975483.319:92): pid=2191
uid=1000 auid=1000 ses=3 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="nootskoot"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   48.156372] audit: type=1110 audit(1665975483.319:93): pid=2191
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   48.156463] audit: type=1105 audit(1665975483.319:94): pid=2191
uid=1000 auid=1000 ses=3 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   48.157747] audit: type=1106 audit(1665975483.319:95): pid=2191
uid=1000 auid=1000 ses=3 msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   58.195548] kauditd_printk_skb: 1 callbacks suppressed
[   58.195551] audit: type=1101 audit(1665975493.356:97): pid=2321
uid=1000 auid=1000 ses=3 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="nootskoot"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   58.196046] audit: type=1110 audit(1665975493.359:98): pid=2321
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   58.196131] audit: type=1105 audit(1665975493.359:99): pid=2321
uid=1000 auid=1000 ses=3 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   58.197260] audit: type=1106 audit(1665975493.359:100): pid=2321
uid=1000 auid=1000 ses=3 msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   58.197283] audit: type=1104 audit(1665975493.359:101): pid=2321
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   65.051388] audit: type=1101 audit(1665975500.212:102): pid=2367
uid=1000 auid=1000 ses=3 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="nootskoot"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   65.051835] audit: type=1110 audit(1665975500.212:103): pid=2367
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   65.051925] audit: type=1105 audit(1665975500.212:104): pid=2367
uid=1000 auid=1000 ses=3 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   65.072451] audit: type=1106 audit(1665975500.232:105): pid=2367
uid=1000 auid=1000 ses=3 msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   65.072526] audit: type=1104 audit(1665975500.236:106): pid=2367
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   73.710765] audit: type=1101 audit(1665975508.872:107): pid=2455
uid=1000 auid=1000 ses=3 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="nootskoot"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   73.711208] audit: type=1110 audit(1665975508.872:108): pid=2455
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   73.711298] audit: type=1105 audit(1665975508.872:109): pid=2455
uid=1000 auid=1000 ses=3 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   73.712339] audit: type=1106 audit(1665975508.872:110): pid=2455
uid=1000 auid=1000 ses=3 msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   73.712372] audit: type=1104 audit(1665975508.872:111): pid=2455
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   92.139144] audit: type=1101 audit(1665975527.302:112): pid=2670
uid=1000 auid=1000 ses=3 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="nootskoot"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   92.139503] audit: type=1110 audit(1665975527.302:113): pid=2670
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   92.139577] audit: type=1105 audit(1665975527.302:114): pid=2670
uid=1000 auid=1000 ses=3 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   92.140550] audit: type=1106 audit(1665975527.302:115): pid=2670
uid=1000 auid=1000 ses=3 msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   92.140576] audit: type=1104 audit(1665975527.302:116): pid=2670
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   94.921630] audit: type=1101 audit(1665975530.082:117): pid=2716
uid=1000 auid=1000 ses=3 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="nootskoot"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   94.921995] audit: type=1110 audit(1665975530.082:118): pid=2716
uid=1000 auid=1000 ses=3 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   94.922051] audit: type=1105 audit(1665975530.082:119): pid=2716
uid=1000 auid=1000 ses=3 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   94.984078] 8852be: bad vermagic: kernel tainted.
[   94.984083] Disabling lock debugging due to kernel taint
[   95.159114] BPF:     type_id=1765 bits_offset=128
[   95.159116] BPF:
[   95.159117] BPF: Invalid name
[   95.159117] BPF:
[   95.159120] failed to validate module [8852be] BTF: -22
