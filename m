Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AF47B1E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFQHhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 03:37:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:32833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFQHhH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 03:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560757020;
        bh=czLWLdDxP/IMub0Txv9e7JWhIs1w6fic2E1Pzt49aE8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=f8hn3w/M/bVG2G9/04SQBzmUdvOEEHopsd2F/EocvezzuUjo7tBlYnwj3kjIRkn0v
         8Gvg9olTltEqyhn4oilMgb9FNscI0mANF6t6wmUK3WPli1tDiTjfJIvb9TgBk0kY0/
         og03yovNGsquo62KgwEAeyG5A7brsT/kT/XkgnYM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mir ([87.182.146.54]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPIvU-1hhC2e1Luq-004VoX; Mon, 17
 Jun 2019 09:37:00 +0200
Date:   Mon, 17 Jun 2019 09:36:58 +0200
From:   Stefan Lippers-Hollmann <s.l-h@gmx.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
Message-ID: <20190617093658.46591254@mir>
In-Reply-To: <e13d86030df7a5222ee144d85bbeec400ed8fa07.camel@sipsolutions.net>
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
        <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
        <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
        <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
        <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
        <20190617070747.562b9388@mir>
        <e13d86030df7a5222ee144d85bbeec400ed8fa07.camel@sipsolutions.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4jGhVHpYZgLYh10k2Z20N6Pc5/7b8P8hevf/JeicvmOiZLvWMcM
 30qblKjFBklZiIigWv84ICnNYJKmETasJqkfaBsbENz1tw4RONwmh2boUAcwJeE4PgohJHV
 gsIQWSYdkHDIDzNzIBPc5M0QiyFihneE1BCyuf98RD05DVoIayo1lVeEyBcCq1nHcomWkJX
 by7kjVFQnQ01dfKhql2pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XM7Gn061CVo=:wp1tTcLaw+/XiaDuA5QCiL
 4E3NaCSiyyKxHjqjzNe2Z1uSBAZo1ijuxLyu2u+c3VSNnPtrcEnpveBis1pS7RzyVWW3ghlit
 JAmZ+V8yQJZvXuYZG1Kr7PAY3CFpdABtpsMU6+XHqTyTzE63wYiShMglofiqo/xoYhUpUu3PC
 sEbbQwY7iYH8b/DJwEiKSk2v5S+lbHu7HWsQfBban/SCTRv66q4C7L+BYZ1MGQ10bMbwlW+Wp
 Prn2IheG0gO9qsIMR59PK/ip/BE+deNsZNJsAnV7gZjeM66H0chXVX6jrr80D5WN39hB9o8/z
 lk6Yu8aN+FH7HXbchFdWzWXUT7xutBSbWDxGsUdkuJON/ENWRHGxBAf14kkfh46K1IS6BceDN
 KgP6vh/UAQHni1lwT/SvpBc2HlO7QuW0WQLRJ+fdKHTRe13/OA4/VLkjPxshQhxMgf607oQmL
 /62btLwLLVtoRDv17Cf7bZnuRz7uRMDmw5/Ke2IQluZAMLh8THnNnwu4R5ldanpgS/DkJKpxr
 lk4+EGUxM/xjXzG9LPH/abgIPL0yhn5JzzGbHyo6rQ9FioQ92tcsh0zrYpOl07beVbtvCppLN
 zDxsgGfnMQpR7xQen08Aw1nuryYCFdtnfSxMDBb0WwhWxk3Yntley1gIylp+R0H7w3rPsy8jW
 nyr+qbHlc0L3lObs1yEaDEqvwcph6Rskq/7L60MzRVbhlwU2i5X5ygdSUFcrjVp0QrSBrPdWj
 sVzHgxu1qaO/m49dlefENEkfcVdZS9OjV1pOfUprIv+tYMT2ETkksYbBj6xN1jHcJp7RPpBfD
 bbm1OyWPD/gIpqKR3w+78URHPpXcwTcWZqZVakUg3bEw7VGy5YdnRabw7KYo/NtJ6HgNbiUgH
 Vfn4idvWdCGuZa36f+0FtlMmt7s1DT37L5jsKcfNLNEUCfJSnotzhan0ZJecYgb6UHG3n3XDD
 IfcDiq8ZF8DXnkoN4b2WzRZC86avXjwg=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On 2019-06-17, Johannes Berg wrote:
> On Mon, 2019-06-17 at 07:07 +0200, Stefan Lippers-Hollmann wrote:
[...]
> > I've tested (and left it running/ monitored) for two days without
> > any problems between QCA9984 (ZyXEL nbg6817/ ipq8065, WDS-AP, affected
> > before 33d915d9e8ce811d8958915ccd18d71a66c7c495 "{nl,mac}80211: allow
> > 4addr AP operation on crypto controlled devices" went in) and AR9340
> > (TP-Link TL-WDR3600/ AR9344, WDS-Client, not affected by this issue),
> > both under current (~2 days old) OpenWrt master[1] (ipq806x/ ath79,
> > respectively). This patch is working fine and fixes the previous
> > problems with 4addr on ath10k (QCA9984).
>
> "This patch" is v3 then, presumably? I just checked, and it looks like I
> indeed applied v3.

I've tested:
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/=
?id=3D33d915d9e8ce811d8958915ccd18d71a66c7c495

And applied it to OpenWrt's (v4.19 based) backports package:
https://github.com/openwrt/openwrt/pull/2139/commits/425ab52a0d451938c87eb=
afdf247b86fa563ad36

> So basically you're saying it works as affected, since you were
> previously affected by the unavailability of 4addr interfaces on ath10k
> hardware, which are now available, right?

Yes, QCA9984/ ath10k[1] as 4addr/ WDS-AP was affected starting with
(backports-) kernel 4.18 and above. I've tested v1 and the version
you merged with
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/=
?id=3D33d915d9e8ce811d8958915ccd18d71a66c7c495
both versions of this patch fix the problem for me and survived a
slightly over 2 day stress test.

Regards
	Stefan Lippers-Hollmann

[1]	ath10k_pci 0001:01:00.0: firmware ver 10.4-3.9.0.2-00044 api 5 feature=
s no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast,no-ps crc32 c3e=
1b393
