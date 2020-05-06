Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571A1C7540
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgEFPoy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEFPoy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 11:44:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0514C061A0F
        for <linux-wireless@vger.kernel.org>; Wed,  6 May 2020 08:44:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p16so2312583edm.10
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2020 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QJ1Dj7q218JqOirGJ81kibJBjYCQpL6+WgxDDpXtvNU=;
        b=jn0tcVy14ike41jellt0WEslQzD9KZJWJaGUspyerG+ohDD4ciN5kGZ+YjsI0ftB07
         dkTReUElxeOtdI3jmzR+VS0F+2sQ5bX8+jpfcmK9aB55b1i7TiX7JVqxURZji7ZqlHtX
         8kueNPQqkmx0Nfiq83prOhK5A09A8EDzbkbsuTqlGPpmr64WVlr756gn5doTy3V98EoF
         R7uRrVem6/MAwe7Cb7a97zWM4G8O09M7zqNaB+HiWh+H/ygA6Ev67kL6Cewt1vjN6hQt
         RjjNVSMPk6lr0eBVivy5VWXhWYXMOsXU+8PpXHfUPW8vSUKyaAemo6fv/t7cDfN+EzjJ
         cKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QJ1Dj7q218JqOirGJ81kibJBjYCQpL6+WgxDDpXtvNU=;
        b=h6SxaxNKUIcmOkZ2iUJQPBc5Xgcl4hycvF2//e7YoeYHcwvLVc37XZsIMS8h4wcuQa
         75F0i40+MoJ2Mg8ItRemWBH3woNQbi5Cjmnl3JVfEW7jiA1mKwM5/EHje22vhqAdNJJc
         BagcfodoIy5AJfReNUuEotn1lDjINcj/pOjkKkolDxKmrQE0o5mFJllUnUZnkF7Fdp+j
         UlMRtQa9U+sDKaoa/gVoif2930a1vAyE05XnyxkA2eTe6efIX8+Iz7G0Nslfe0y7xdar
         +l7XtfcGDky8sVbDvcOQKoez4M9ncpn2i0kvzt6mgBR9qUT3pKZpN7vruYVEuHiDHeyK
         3lmg==
X-Gm-Message-State: AGi0PuaT9QyITdrK4yiTUSlZIcifsGoxtB2EZ1JBDahdDrPplBKpQgQK
        kxFplcI4gxzVDG1Q/giG0kccYCbIqS7yj/LJZjpxYhxT
X-Google-Smtp-Source: APiQypKlhHI5BL+LlNiegGYPgciqRaR3NYUqs6QDCGYmeXiuiMo/mAx0yGQk2J9OBhF1gjDCNRwSU+a9yYdIENqpVZU=
X-Received: by 2002:aa7:c312:: with SMTP id l18mr7873543edq.161.1588779892065;
 Wed, 06 May 2020 08:44:52 -0700 (PDT)
MIME-Version: 1.0
From:   James Prestwood <prestwoj@gmail.com>
Date:   Wed, 6 May 2020 08:44:41 -0700
Message-ID: <CAPv5Ue5DY07E3=JDwjJkuad6Z3cuYtJg=dypUjy0KyBhn=JL9A@mail.gmail.com>
Subject: Potential IBSS race
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

It appears that when two IBSS networks are started at the same time
they sometimes don't pick each other up and two separate IBSS networks
are created. I have turned on IBSS logging and see beacons coming in
from both networks AFTER each interface creates its own IBSS, but they
dont come soon enough for either interface to realize there is already
an IBSS. Is there any mitigation in the kernel or anything outlined in
802.11 that handles this case of two IBSS networks being created
simultaneously (or close to it)? Even delaying the second network by a
full second sometimes results in this behavior.

[    3.915143] wlan1: sta_find_ibss (active_ibss=0)
[    3.916022] wlan1: sta_find_ibss: did not try to join ibss
[    3.960484] wlan0: sta_find_ibss (active_ibss=0)
[    3.961643] wlan0: sta_find_ibss: did not try to join ibss
[    5.798696] wlan1: sta_find_ibss (active_ibss=0)
[    5.800526] wlan1: sta_find_ibss: did not try to join ibss
[    5.802579] wlan0: sta_find_ibss (active_ibss=0)
[    5.804300] wlan0: sta_find_ibss: did not try to join ibss
[    7.782708] wlan0: sta_find_ibss (active_ibss=0)
[    7.784529] wlan0: sta_find_ibss: did not try to join ibss
[    7.786557] wlan0: Trigger new scan to find an IBSS to join
[    7.788525] wlan1: sta_find_ibss (active_ibss=0)
[    7.789132] wlan1: sta_find_ibss: did not try to join ibss
[    7.789779] wlan1: Trigger new scan to find an IBSS to join
[    8.471675] wlan1: sta_find_ibss (active_ibss=0)
[    8.473610] wlan1: sta_find_ibss: did not try to join ibss
[    8.475957] wlan0: sta_find_ibss (active_ibss=0)
[    8.477434] wlan0: sta_find_ibss: did not try to join ibss
[   10.790703] wlan0: sta_find_ibss (active_ibss=0)
[   10.792698] wlan0: sta_find_ibss: did not try to join ibss
[   10.795035] wlan0: Trigger new scan to find an IBSS to join
[   10.796543] wlan1: sta_find_ibss (active_ibss=0)
[   10.797125] wlan1: sta_find_ibss: did not try to join ibss
[   10.797988] wlan1: Trigger new scan to find an IBSS to join
[   11.480676] wlan1: sta_find_ibss (active_ibss=0)
[   11.482586] wlan1: sta_find_ibss: did not try to join ibss
[   11.484822] wlan1: Creating new IBSS network, BSSID 62:f3:4f:db:22:e8
[   11.486643] wlan0: sta_find_ibss (active_ibss=0)
[   11.487302] wlan0: sta_find_ibss: did not try to join ibss
[   11.487995] wlan0: Creating new IBSS network, BSSID da:4d:66:a0:ca:52
[   11.590664] wlan1: RX beacon SA=02:00:00:00:00:00
BSSID=da:4d:66:a0:ca:52 TSF=0x5a4fc850a65c2
[   11.592753] wlan1: BCN=0x5a4fc850a6133 diff=1167 @4294678818
[   11.594002] wlan0: RX beacon SA=02:00:00:00:01:00
BSSID=62:f3:4f:db:22:e8 TSF=0x5a4fc850a72cd
[   11.595688] wlan0: BCN=0x5a4fc850a614a diff=4483 @4294678821

(beacons continue for a while until the test fails)

Thanks,
James
