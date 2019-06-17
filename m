Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6ABB480B9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfFQLcT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 07:32:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42421 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQLcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 07:32:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so8903232otn.9
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2019 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bFeLNRz90DozmUEBqcuHoNO0gJ8aYft6A7ssbyU+2Ns=;
        b=crErvUYy+5U2jXXUkAPg2JiPmtCnGo5XO+8bgyT3vDmcxQrwB995MHArXO05jKc0M6
         LXnPthe9U3aN05IJkucpZoyMHpYFLo+Y2DbTojcUYYzrlmFTl45adhbst+iOodk15DXX
         bZ9PPlMaU7MNBFUctmZ7qcn67jm5rRHGcqaD4sHdvf9BgYqyzuBjxuba8H8/t0Qqlh0i
         l0AHUnAHOU9XUyOb/52pDo3+dZKNl814pTvtPJYQdVkU/EK/1NG/16QB5ROxAtN1LFcR
         /j8A4GVtCEvPsF6jjU+V/vqTRiVoyx54wPprqJKETn3xYdbMcD46PmSeKRMZiIcBpbps
         NowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bFeLNRz90DozmUEBqcuHoNO0gJ8aYft6A7ssbyU+2Ns=;
        b=uOqZybKQ5V1MUmKWoIdEAmZKGb5zmvz70X4IO3e8/31kD/ha7iuHE/8xlVrxya8JLE
         1tkklUKCVUGl3KcgG3t/dcMcIjFhoxWP82euVauSSdDnkmOzld74pEtONC7Im7uSwTsp
         LN2kmbcTxURFiqZFIp3PRIQeEHgU/kcofamkBavAccZ+AzrALotuYCSnZqV0qcoPbk0I
         79q2kmanyrRsSZiOLphoIvfVccN0DGw2EC/FziyylqEkfG+HJSDAfbN6O+htA6pSxRIg
         kID01bVePdxXALchn/g8r2WaaPuQ56TkNsgW3ckuaXh/VK/jMu1YTy4dphMqSExIEgl+
         TeLg==
X-Gm-Message-State: APjAAAVRQno3d8Hu92g/siUgmMz7JXiRhu1Pe0XsZtR8Nd+tiOO3q0fo
        wMDm+XFRhsr4DntLnXHakkavrYLn/ZSTZ01M3Hg=
X-Google-Smtp-Source: APXvYqzHJPlN6vcmLC4BhL9wSpZF6995J/G8/LQZXHvZLNccR5hVqHikEHUSWp7S1IBLn+rIvRp0pbUlAM1Egog4Jvk=
X-Received: by 2002:a05:6830:1681:: with SMTP id k1mr35982840otr.256.1560771138563;
 Mon, 17 Jun 2019 04:32:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:2015:0:0:0:0 with HTTP; Mon, 17 Jun 2019 04:32:17
 -0700 (PDT)
In-Reply-To: <20190617093658.46591254@mir>
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
 <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
 <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org> <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
 <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
 <20190617070747.562b9388@mir> <e13d86030df7a5222ee144d85bbeec400ed8fa07.camel@sipsolutions.net>
 <20190617093658.46591254@mir>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Mon, 17 Jun 2019 13:32:17 +0200
Message-ID: <CAKR_QVJ9EkhcG893SjVMgDb5S-W2=jas5JG+VQyLDx-R5MMK5w@mail.gmail.com>
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
To:     Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

Checked out r10011 from openwrt git on May, 15; built images and
flashed devices; tried to set up WDS (AP) + WDS (Client); got this in
logs: https://forum.openwrt.org/t/ath10k-wds-support-missing/30346/15?u=psyborg

Saw this patch in my inbox and checked openwrt sources, to find out
there was v1 used:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=package/kernel/mac80211/patches/subsys/390-nl-mac-80211-allow-4addr-AP-operation-on-crypto-cont.patch

Reverted v1 of the patch and patched manually to v3 (double checked),
did not help.

Found patch that fixes problem and applied;
https://github.com/openwrt/openwrt/pull/2048
Now I got this in logs:
https://forum.openwrt.org/t/wds-client-wont-stay-connected-prev-auth-not-valid-using-recent-snapshot-builds/38194/20?u=psyborg

Reverted again v3 of this patch to v1, and the connection worked as expected.

v4.19.32 is current in openwrt master, and testing against ath9k
devices may not reveal exact issue. notice in one of my posts on
forums that i was able to bridge it with archer c7 running tp-link fw
without any of these patches
