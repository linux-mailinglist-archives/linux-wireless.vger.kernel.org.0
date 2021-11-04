Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA134459E2
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Nov 2021 19:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhKDSmf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Nov 2021 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDSme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Nov 2021 14:42:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C96C061714
        for <linux-wireless@vger.kernel.org>; Thu,  4 Nov 2021 11:39:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u11so13876229lfs.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Nov 2021 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openwisp-io.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qxTFr0OwAYxyQ/D8q0akcACku+9rWPHHeE9dfhWvumY=;
        b=MhZCUCvQXWlliciIE1G6krBJlejHBeUT+e81el3q63nhn3UmDZV853zfyoPuxoWGe2
         NltOcZIEKLZ6Sn62EJhfrX76RIOb7HBgQaJmo/W3htlZy93Do0/Sr5QpIxFijXZslZzS
         6Gfrf73JwaCS+jXCulLvpMyFbZ6pkYzWd0axFXep+RN8EuZ8rydHSadvzu4wRQMKHMP2
         1l8f3nscIxMe2fAJ6dOZKFT9UuWsCWhUuDBd2Igyz+PtVNjww5aYTJ48sAMe0voBYndO
         JYGqNgzTErkSKObNHmKskGRbPR30/9vmYbA5Qf7iY88XKLGiP+0zzQ67mKq+a7OWcY6g
         Ca0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qxTFr0OwAYxyQ/D8q0akcACku+9rWPHHeE9dfhWvumY=;
        b=BD3qPKwL4EdbVTYt0Wo0RsCXNUwWjZReFch4sCx8UQIcjeK96UhoVMJxf8ni10BZCH
         ZsRy5FHQLAMWfOnzzTiwQeBsGpO96Y9LRAxgnGuoERb9DWGLWwf7Z0unJJ2F6ygGzv9I
         uhaeD4BBkF2nd8amCI44aJt/K8VLVCPUBc4ibBp3zgEyZPJY2Ca8SrQ9TvVI1ByqjptG
         JmO7M/gxOUmvfbDdbrnqrj/TWrVPTZqYuUeIn6fzrPrcUoDot3ZH9JmXEm+2K2/h8Maq
         unmHoKPenDs2jlICMJGuA7owNUMY5lqrNTDuUI9r+p9Z7DBldIS7IoMs5hmPFqCciulD
         dk1Q==
X-Gm-Message-State: AOAM5320ybZbLkKMjImz0hbvx1r93FjimrMYfWO+pW2oBp5zS1IDoR7D
        4VWMWMsojCWh1UHCYKpRU5TKSBLcyOZKQXQ68cJymHQWLVRwvQ==
X-Google-Smtp-Source: ABdhPJxUJig9lA87bHez+jJbwjwk5i9kB2/GFMaLJ2J4JJO+RyDqPLTtUwaDwbscbhunHseaa+krlUKcTPR/8V2gKLc=
X-Received: by 2002:a05:6512:2390:: with SMTP id c16mr304866lfv.55.1636051194448;
 Thu, 04 Nov 2021 11:39:54 -0700 (PDT)
MIME-Version: 1.0
From:   Federico Capoano <f.capoano@openwisp.io>
Date:   Thu, 4 Nov 2021 13:39:43 -0500
Message-ID: <CAAGgX6+okJRVP4v+a5scg1ZOTvBgRmbOAsoQhJVmBiSwiVamcw@mail.gmail.com>
Subject: Mesh 802.11s blackhole due to bogus mpath routes with nexthop 00:00:00:00:00:00
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi everyone,

I want to report an issue I am having and ask for guidance on how to
collect more technical information that can help in understanding why
this happens and how to fix it (instead of working around it with
scripts that reload the WiFi when the issue appears).

Kernel in use: 5.4.155
Linux distribution: OpenWrt
Target: confirmed on a mediatek device from Winstars using drivers
mt7603e, mt7615e, Netgear EA8500 and Netgear EX6400
The router device I am using has 2 CPUs.

Steps to reproduce: I am not sure what exactly triggers this, the bug
happens on its own periodically, if anyone has suggestions on specific
actions to do to try to replicate it, please let me know

What happens:

The connection to the root mesh node is lost, but inspecting the
status of the mesh links with =E2=80=9Ciw mesh0 station dump=E2=80=9D or =
=E2=80=9Ciw mesh1
station dump=E2=80=9D shows the links are active.

Inspecting =E2=80=9Ciw mesh0 mpath dump=E2=80=9D or =E2=80=9Ciw mesh1 mpath=
 dump=E2=80=9D show a list
of mac addresses which are from devices in the LAN, with an invalid
next hop (00:00:00:00:00:00), which for some reason end up in the mesh
routing table and fill it.

For example, when the problem starts showing up, the mesh routing
table may look as follows:

iw mesh1 mpath dump
DEST ADDR         NEXT HOP          IFACE SN METRIC QLEN EXPTIME DTIM
DRET FLAGS HOP_COUNT PATH_CHANGE
16:dd:0c:a4:ba:aa 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
fc:93:c3:3b:0b:fe 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
90:f4:c0:8f:de:80 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
bc:a1:da:cb:87:a8 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
1e:f7:95:47:4a:b3 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
3a:e2:e6:88:65:fb 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
6c:cd:48:37:af:bc 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
d8:54:0b:7c:20:46 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
ce:43:28:84:44:7e 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
26:75:58:0b:39:18 00:00:00:00:00:00 mesh1 0 0 0 0 1600 4 0x0 0 0
80:3f:5d:**:**:** 80:3f:5d:**:**:** mesh1 0 4857 0 0 0 0 0x10 1 1

After one minute, the size may have doubled or tripled.

At some point one of the mesh nodes ends up in the routing table with
a bogus route (with nexthop 00:00:00:00:00:00), which basically screws
up routing 100%, until that happens, the other rough mesh routes do
not cause issues, but once the black hole appears, removing the bogus
mesh routes does not fix it, only turning off wifi and then on again
fixes it.

I would be grateful for any suggestion on how to collect more useful
information that can help to track down and fix this bug.

Best regards
Federico Capoano
OpenWISP Project
