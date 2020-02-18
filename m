Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4424B161E58
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 02:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgBRBA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 20:00:28 -0500
Received: from mail-il1-f173.google.com ([209.85.166.173]:36552 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgBRBA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 20:00:27 -0500
Received: by mail-il1-f173.google.com with SMTP id b15so15836981iln.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2020 17:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EW0Fnf3YXcKqFSs9Rd2Yv4JlQlGtDQ8qmQpioAEqqNQ=;
        b=o8xISoHVFvsGKN7hdqImys+64pMBHCeQ1CASu2QFHTAqtO9RLOzdvjhEH/xFa1OwT7
         zrXmmTDF+Hiks2bCzV9SEdQU3f/fn592SPj3Di3IzTNTWYr6brACj+mEyNHvncm9ikz1
         tPzlPBk5NTtX5UIpJ/dl9H1NcJyBJF9N0CgrgKToej+YJnH7bxd7QqCxQtuCy1j/XJo6
         y4t/RSSR7krC5GSDjcTpbRvZBeYWeAf2WTg9Yesbw3CEwhaYRv9XpUm4nttrQjYFDl8A
         4VC3ZPWLfnBNb7PNvgkBIRTk3UuAqt1iPkOSP4sgU3BL0xpaXJaIK+G5CPG0GRkWvFJE
         bpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EW0Fnf3YXcKqFSs9Rd2Yv4JlQlGtDQ8qmQpioAEqqNQ=;
        b=hsbeLYvYhpHNoxTvpvNo3dKhSSiREGMHaVZIq+rVeB4Jg0/Pyh9ND1Ir9kCd/FfElD
         C+/r9r31R7e3jnaJm/iC46ZYkoacT5FT14V9Oif2zNpcI+H1uWgHuI4u4g7MJuHPhvAG
         nrHfZLqqhDM4DpZW4p4AcMbGUu1j5q7OUBJ9fU1ZmEzirBZcm6BkAmsnEhKQSkOJQE3z
         DHzRW9pZlfyfgrsfJhnadDiC28mkAMG/w651NoLw2kPQBdafv/X5j+s3a6cqHXHUzxAF
         Hw8n7Re9nxH9+/ZvmUAiFSnyVpUnuM4PW45AICVV8nH7kVz8PLq22EG/c+4ZmqJz63nW
         1kZQ==
X-Gm-Message-State: APjAAAVctLbmPDnKqvQkaZJxLsvwydY5vtP+Y21Jw3MKLKI/R7WUllC6
        UfkBBUPbUV2tzvlVTEWXkLiTZr5Tp6hhWthTZpohXgG5
X-Google-Smtp-Source: APXvYqxqBP5yqr87WaOZEro0sPSkzN9aQ6pTx8HGV4BQdS10MoRw74Wew2HcyTITvRBanvaJvt+snKpR0VRYIT1T2h4=
X-Received: by 2002:a92:216:: with SMTP id 22mr16818493ilc.53.1581987626912;
 Mon, 17 Feb 2020 17:00:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Mon, 17 Feb 2020 17:00:26
 -0800 (PST)
From:   JH <jupiter.hce@gmail.com>
Date:   Tue, 18 Feb 2020 12:00:26 +1100
Message-ID: <CAA=hcWTDqhJEE7MXFY9rvN93nf8=nWvshLoXKF3EMXYGLmZGbA@mail.gmail.com>
Subject: Change RO rootfs failed RF Kill Switch Status and Failed to start Run
 pending postinsts
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Yocto discussion list <yocto@yoctoproject.org>,
        Patches and discussions about the oe-core layer 
        <openembedded-core@lists.openembedded.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Apologize for the cross posting.

I am running kernel 4.19.75 on iMX6 customized device with WiFi and 4G
LTE, it was running well in an RW rootfs. After I have just changed
rootfs to RO UBIFS partition, it failed RF Kill and postinsts I
suspect both try write to the RO and failed, any advice how to fix it?
Despite it failed RF Kill and postinsts, it was still working.

[    6.097762] UBIFS (ubi0:2): UBIFS: mounted UBI device 0, volume 2,
name "rootfs-volume", R/O mode
..............
[    6.151932] VFS: Mounted root (ubifs filesystem) readonly on device 0:13.
.................
[  OK  ] Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
         Starting Load/Save RF Kill Switch Status...
[FAILED] Failed to start Load/Save RF Kill Switch Status.
See 'systemctl status systemd-rfkill.service' for details.

[FAILED] Failed to start Run pending postinsts.
See 'systemctl status run-postinsts.service' for details.
...............
root#

Thank you.

Kind regards,

- jh
