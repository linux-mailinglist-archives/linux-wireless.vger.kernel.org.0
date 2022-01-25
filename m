Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E96149BF0A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jan 2022 23:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiAYWry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 17:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiAYWrh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:37 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7BEC06161C
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 14:47:36 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a12so11393591qkk.9
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 14:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=cPEAuoTpJyP7D1kuU7osiuKzO/w+kYEPR0Ut2B7sQ94=;
        b=VMNJ9GUYfXRcuZxjpR22OKtwPQzIbVKhrRRK452crt7C/FZqT+2YyjzmEy3KdJR22D
         4VjzBr++AIMR7K3264kI3rfdpRFsj45ltpOedMtXS6GQGU0Mqmg7C8oh1jEwcFnBmOPi
         HJ0pIhyd7CblTioPqC2RqBwpdX3sITtQwwfmf3xdXWlXLt9fJdTUu3HAoq2M8f9CfX3N
         zSEAzLWr4Zg+yOtx/QgCu+LOsU/0gKJKW0LKYa1moO5hY73hIgKSoUQmgv8s2FUmVidV
         aVzAQKvzUUHDGEa6vDUzhBY+FjV7KhDzBc6dWSIsad6dcXBQcGfzfEmZRbormaB86CI6
         SuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=cPEAuoTpJyP7D1kuU7osiuKzO/w+kYEPR0Ut2B7sQ94=;
        b=MIApLDyrsubCfXsdnFfbr6bSPh0SP6wA81q36YFfmLXC5ESW6OdpEKF8UW9YkSWb4T
         zZ69hyJfXUycspWOFFLwP4Icv3oVLLvgyPhTlLy4Wyv0wg3hIT8E5PDUdRzA81WCPA9X
         ymD5vBJZ7GlTQO16bgfoZ4YJkzvQCwgFKyUCvk6w4gTH15KHilKL+fuMl5p2yoKSC8ML
         6PcVc8KrzUZF6fd1vLZWGQGNog69KF93FvkCXhxT8cOTtw9jKZjb4cNgdBIoY2rBrv80
         8LKT4sasG6D21pvKuH66P0SuEKWyQNJpTeKH6wsMguSCGLozUqaIz9GbTUAzL1JNluK9
         BwIw==
X-Gm-Message-State: AOAM5302gf4E8zFEb7zoiWSprh3C46onykWtxxCuPPz/5mK6iyHmeLYJ
        hZFqs64DYrJztehJ+Dmntrs1I9nYpmVTxX/Y
X-Google-Smtp-Source: ABdhPJyulXthL8R9TZPlwIs3qImIsMMwTYpI0PH/g/iN7Wfqm3ktRO13nhsx5QzUuHY2xQXAN3FjLg==
X-Received: by 2002:a37:5ec5:: with SMTP id s188mr16509933qkb.228.1643150855647;
        Tue, 25 Jan 2022 14:47:35 -0800 (PST)
Received: from [10.99.0.8] ([136.144.58.108])
        by smtp.gmail.com with ESMTPSA id s4sm10342826qko.113.2022.01.25.14.47.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jan 2022 14:47:35 -0800 (PST)
From:   Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Fix fell on the floor for rcu violation in net/wireless/scan.c
Message-Id: <A7E1204B-E1CD-48AF-AA80-ECCF3E4F7049@zzywysm.com>
Date:   Tue, 25 Jan 2022 17:47:34 -0500
To:     linux-wireless@vger.kernel.org, dvyukov@google.com,
        hdanton@sina.com
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-07-30 syzbot reported the following bug in net/wireless/scan.c:

https://lore.kernel.org/all/000000000000f66d1605c8542ca8@google.com/

Hillf Danton proposed a patch, which I can=E2=80=99t find on lore but is =
available here:

https://groups.google.com/g/syzkaller-bugs/c/fhfh_VqZQkI

As you can see at the end of that thread, syzkaller has automatically =
closed this bug because it hasn=E2=80=99t seen it in a while.  However, =
the proposed patch appears to be a valid bug fix.  Can you re-evaluate =
it for consideration?

Thanks,
zzy

