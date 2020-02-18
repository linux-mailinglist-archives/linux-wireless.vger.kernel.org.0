Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D421162175
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 08:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgBRHUi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Feb 2020 02:20:38 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36594 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgBRHUi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Feb 2020 02:20:38 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so16436513iln.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2020 23:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7jGl0wNCwOoe/f3cnv39Il46yTDC1l6xo6CwzoreJxU=;
        b=lO6B4I8WSsFjKKmxAxN5wqEqtcta6kLddINbSf9+T+lC0uBzrhQNhlKxxKK/CkmY2N
         7LTGEND2H9q+YIE3LRNpeImX2TLMY2DcQeFS7yeSRBjQgkSOMYYPGzKJxX3UOhICF4uz
         x4ZtRw3xFZXmtim7AG3xsyFPQOUsKRLQIk4z/mah/l9cBzGaX1EdKaj8BmiqXd4x9e/V
         ZYyYAftP+2SwcOsKyYdxyqxA3X5AJGVX/I6Kk1iSaA1KSc/4PFw9L7hQOV/Mu/tUeJ/4
         /yV4UCPyTCPEqIDUb1/rOE/hBSanmuUE1JmmkLuc5xHwui7u3cV6ZCirbQ3TMS44kxlR
         ClMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7jGl0wNCwOoe/f3cnv39Il46yTDC1l6xo6CwzoreJxU=;
        b=OQCXWGjzUNleMLkPgiP6ViKgCOFIaUTdhEYIemXDKuavN2X0dhJFHhxnZSkU2yXVNM
         yV6q3EP5eT/klEQGRM5yli7XPEkjA4GDCuJ966MBavucb1Cf2q739vto2o0RDaV9NWGN
         NlcgqtL2ECnj4+IzWrmSLEHemG4YLzIJ18Z14EenUYCuYF4oMQ0VxNrZRXeS0vgl4IJb
         wmRBMyt1xVdd3nclWYVFUDhNdrYWiNg2WQoCUVuGDk5yj/uXHGXMnFqC+Gbv1oeNLni3
         ofeEiS9kGoHTJtYUNHAtkN9jydHNa7wyX1vanKC25mxxFkqNIegjpk7w0cOZhQmT79Pt
         v4YQ==
X-Gm-Message-State: APjAAAVa0pttNOtyz2i+rdS93dXiVX2Akjcbo8C1426qr7Ks7QTTAbbs
        kPGNK+0Bbxm36kO7qc0MuD4aTyF0YuZQmnedsFA=
X-Google-Smtp-Source: APXvYqw6842SKZ5OauYiNhy08S/JKCohjTd+EbXULneGmKen0zPFYa1bUB2YJLmHkUlhAP43GRCFWAzjgav7zYJ2f78=
X-Received: by 2002:a92:5855:: with SMTP id m82mr17716040ilb.302.1582010437335;
 Mon, 17 Feb 2020 23:20:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Mon, 17 Feb 2020 23:20:36
 -0800 (PST)
In-Reply-To: <CAAfyv34yO7bSR9GBod1bXpD0sFnsSETsJQAzcmSgyY0orGtfcg@mail.gmail.com>
References: <CAA=hcWTDqhJEE7MXFY9rvN93nf8=nWvshLoXKF3EMXYGLmZGbA@mail.gmail.com>
 <CAAfyv34yO7bSR9GBod1bXpD0sFnsSETsJQAzcmSgyY0orGtfcg@mail.gmail.com>
From:   JH <jupiter.hce@gmail.com>
Date:   Tue, 18 Feb 2020 18:20:36 +1100
Message-ID: <CAA=hcWQFcdUJKGTOitOAx1URD7r=9PPxsdd=hQO-Yb77=QHTDg@mail.gmail.com>
Subject: Re: [yocto] Change RO rootfs failed RF Kill Switch Status and Failed
 to start Run pending postinsts
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Yocto discussion list <yocto@yoctoproject.org>,
        Patches and discussions about the oe-core layer 
        <openembedded-core@lists.openembedded.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Belisko,

Thanks for your resonse.

On 2/18/20, Belisko Marek <marek.belisko@gmail.com> wrote:
> Can you pls provide output of systemctl status systemd-rfkill
> There should be some more info what issue is.

Failed at step STATE_DIRECTORY spawning /lib/systemd/systemd-rfkill:
Read-only file system, did it try to write something in /lib/systemd?
How should I fix it?


# systemctl status systemd-rfkill -l
* systemd-rfkill.service - Load/Save RF Kill Switch Status
   Loaded: loaded
(8;;file://solar/lib/systemd/system/systemd-rfkill.service/lib/systemd/system/systemd-rfkill.service8;;;
static; vendor preset: disabled)
   Active: failed (Result: exit-code) since Tue 2020-02-18 00:47:30
UTC; 1min 59s ago
     Docs: 8;;man:systemd-rfkill.service(8)man:systemd-rfkill.service(8)8;;
  Process: 149 ExecStart=/lib/systemd/systemd-rfkill (code=exited,
status=238/STATE_DIRECTORY)
 Main PID: 149 (code=exited, status=238/STATE_DIRECTORY)

Feb 18 00:47:30 solar systemd[1]: Starting Load/Save RF Kill Switch Status...
Feb 18 00:47:30 solar systemd[149]: systemd-rfkill.service: Failed to
set up special execution directory in /var/lib: Read-only file system
Feb 18 00:47:30 solar systemd[149]: systemd-rfkill.service: Failed at
step STATE_DIRECTORY spawning /lib/systemd/systemd-rfkill: Read-only
file system
Feb 18 00:47:30 solar systemd[1]: systemd-rfkill.service: Main process
exited, code=exited, status=238/STATE_DIRECTORY
Feb 18 00:47:30 solar systemd[1]: systemd-rfkill.service: Failed with
result 'exit-code'.
Feb 18 00:47:30 solar systemd[1]: Failed to start Load/Save RF Kill
Switch Status.
Feb 18 00:47:30 solar systemd[1]: systemd-rfkill.service: Start
request repeated too quickly.
Feb 18 00:47:30 solar systemd[1]: systemd-rfkill.service: Failed with
result 'exit-code'.
Feb 18 00:47:30 solar systemd[1]: Failed to start Load/Save RF Kill
Switch Status.

>> [FAILED] Failed to start Run pending postinsts.
>> See 'systemctl status run-postinsts.service' for details.
> Pls this one also: systemctl status run-postinsts

# systemctl status run-postinsts -l
* run-postinsts.service - Run pending postinsts
   Loaded: loaded
(8;;file://solar/lib/systemd/system/run-postinsts.service/lib/systemd/system/run-postinsts.service8;;;
enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Tue 2020-02-18 00:47:37
UTC; 6min ago
  Process: 153 ExecStart=/usr/sbin/run-postinsts (code=exited, status=0/SUCCESS)
  Process: 159 ExecStartPost=/bin/systemctl --no-reload disable
run-postinsts.service (code=exited, status=1/FAILURE)
 Main PID: 153 (code=exited, status=0/SUCCESS)

Feb 18 00:47:36 solar systemd[1]: Starting Run pending postinsts...
Feb 18 00:47:36 solar run-postinsts[153]: Configuring packages on first boot....
Feb 18 00:47:36 solar run-postinsts[153]:  (This may take several
minutes. Please do not power off the machine.)
Feb 18 00:47:36 solar run-postinsts[153]: /usr/sbin/run-postinsts:
eval: line 1: can't create /var/log/postinstall.log: nonexistent
directory
Feb 18 00:47:36 solar run-postinsts[153]:  Removing any system startup
links for run-postinsts ...
Feb 18 00:47:37 solar systemctl[159]: Failed to disable unit: File
/etc/systemd/system/sysinit.target.wants/run-postinsts.service:
Read-only file system
Feb 18 00:47:37 solar systemd[1]: run-postinsts.service: Control
process exited, code=exited, status=1/FAILURE
Feb 18 00:47:37 solar systemd[1]: run-postinsts.service: Failed with
result 'exit-code'.
Feb 18 00:47:37 solar systemd[1]: Failed to start Run pending postinsts.

Was the problem to write to /var/log, the /var/volatile does not have a log?

# ls -l /var
drwxr-xr-x    2 1000     1000           160 Feb 18  2020 backups
drwxr-xr-x    5 1000     1000           100 Feb 18 00:47 cache
drwxr-xr-x    9 1000     1000           180 Feb 18 00:47 lib
drwxr-xr-x    3 1000     1000           224 Feb 18  2020 local
lrwxrwxrwx    1 1000     1000            11 Feb 18  2020 lock -> ../run/lock
lrwxrwxrwx    1 1000     1000            12 Feb 18 00:52 log -> volatile/log
lrwxrwxrwx    1 1000     1000             6 Feb 18  2020 run -> ../run
drwxr-xr-x    3 1000     1000            60 Feb 18  2020 spool
lrwxrwxrwx    1 1000     1000            12 Feb 18  2020 tmp -> volatile/tmp
drwxrwxrwt    8 root     root           160 Feb 18 00:47 volatile

# ls -l /var/volatile/
drwxr-xr-x    5 1000     1000           100 Feb 18 00:47 cache
drwxr-xr-x    9 1000     1000           180 Feb 18 00:47 lib
drwxr-xr-x    3 1000     1000            60 Feb 18  2020 spool

All system mount is the same as the original RW rootfs, did both write
to none standard RW system mount?

Here is defined system mount in fstab:

proc                 /proc                proc       defaults              0  0
devpts               /dev/pts             devpts     mode=0620,gid=5       0  0
tmpfs                /run                 tmpfs
mode=0755,nodev,nosuid,strictatime 0  0
tmpfs                /var/volatile        tmpfs      defaults              0  0


Here is the mount:

# mount
ubi0:rootfs-volume on / type ubifs (ro,relatime,assert=read-only,ubi=0,vol=2)
devtmpfs on /dev type devtmpfs
(rw,relatime,size=84564k,nr_inodes=21141,mode=755)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,relatime)
securityfs on /sys/kernel/security type securityfs
(rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)
cgroup2 on /sys/fs/cgroup/unified type cgroup2
(rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/systemd type cgroup
(rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
tmpfs on /etc/machine-id type tmpfs (ro,mode=755)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
fusectl on /sys/fs/fuse/connections type fusectl
(rw,nosuid,nodev,noexec,relatime)
tmpfs on /var/volatile type tmpfs (rw,relatime)
ubi0:data-volume on /data type ubifs (rw,noatime,assert=read-only,ubi=0,vol=3)
tmpfs on /var/spool type tmpfs (rw,relatime)
tmpfs on /var/cache type tmpfs (rw,relatime)
tmpfs on /var/lib type tmpfs (rw,relatime)
tracefs on /sys/kernel/debug/tracing type tracefs
(rw,nosuid,nodev,noexec,relatime)

How should I fix it?

Thank you.

Kind regards,

- jh
