Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA34799A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 07:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfFQFID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 01:08:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:45459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfFQFID (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 01:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560748073;
        bh=cQi0Zb2kL66dYJhiN8ZoTRkT7B6c4Lek5KXgpq95dPc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PNivT1iPsmxi5Ga0y0sfUaGC5VTnPUnDfy3HR+xgdqvpO/wuz8RLHHYFXlBV8f/qu
         OTb5JtZj+2SWd6sXODWF42Hm0S4p7Zl8r2SKUoJ/wR47ZiSBNJir5vA2rosWq22GYS
         hcQAsd2FkxmZTCglvrclMxFlU5wztpnZErRgoAU8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mir ([87.182.146.54]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LabZr-1iL8A213NP-00mOQq; Mon, 17
 Jun 2019 07:07:53 +0200
Date:   Mon, 17 Jun 2019 07:07:47 +0200
From:   Stefan Lippers-Hollmann <s.l-h@gmx.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
Message-ID: <20190617070747.562b9388@mir>
In-Reply-To: <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
        <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
        <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
        <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
        <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yYfQ6f96BiCUmqN6yVH4BjcjVy4j/tANJmfSsI4hEiiRJFxL49V
 GVDbSBq9QzGOi7ecY6f2XFgGc9L9HkqqiY//HE7qeRkGb6QB2vFEpFFCAbObdDuVVpkxuNn
 tQOUIssMuPeNQycG0bp9DQNR5l110XTge/i9EfC5aRXLQ6jop8PZX3Ws0pUPoRQGgzOxdlw
 49l/FR07yMzX5HcsAxZjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oJ36mp9EJI8=:jeQDJp/EER1J3OHtMlKUwy
 oWsO2hPWFbjyRvmG7D9ixCVlrg3z0RPDeVqU9q4miEloOK4XSe6DfjGQ9EpY3OUAsWca4KL+f
 LFa5YW81MPpBoALEMJ1RLke+F8fL+keNUyIl1Px559XHYFGuzqYYjozfpA3b0+r7xBLcQ/kxr
 ZSCKG3AotuIGgJoTr4ft2opSaaklo+cxo/pGxerMmntu9vPMINM7jsOsVcbDv9uEeX2RdC0R7
 HDDt0+H+BWC3ks+3qRXoTGQpidKpxs/5CQLaRvYEpfuEhUzHq3i9+eVKAtf3gl6DPmXt+ezPX
 X34uq+WR6qbp9uojOKfw0l6ON+sZONbHsOOVSNGiUcJQPj7mfztkYuCW3Dr4i6B4WOkuzP6wb
 AFLBJ+oClIYrQfKoou8Hi9OP+d86YDwh3L+vyg7DhAO8+0GL2ZoK6KwqPY0BexsPg5jpn5aNw
 NB8qsFSvQEn2JXGxsOI0ztThH5vgak7Svx60TbdEcVv+rXfffNhHBYcIdACRdHgnF3gEBZX6O
 7TV3KCrV8t3NTpRoKUJWd6DMKSjbE16OVN0vcsqikEJ02io7Mm+ogIdV6RuipJh0SIuQ6hMda
 5cqIMV0lmDnuJG40vtbxZW776I9OUIgnk2TO66e8ZV/u0mSdnxAx1s3kxHRQipbQgY7ZvnuLp
 upWtksCxhjzMQoeu4QbUxMQKt4tepsKxZItsM6lEXOeop97dohynVQtusAjG64acFse5bkLSX
 WYljZ5NOOL9QIllTY1WTidu9o4q3Xo3KSJUtF+bbkOibkH9z5fuB4bhTHDK08KICBBz+EGow8
 u/gOOIVqhdAtvm+LsbpXTlQAnpV7xxMDXyngE9J3IlRBYjL5TPgIhyVUek2Bmc2eg/B1YR2OY
 iLMGs7aQrFvhT+RYlxZ5zdA6Xy7OAnngcqg4ATzKm72nB8zO8rvRCqCUZjAF91jsa3LjaYPZ9
 e3+6UPqRRk1/24NWzRRdeFMVveX96CFQ=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On 2019-06-12, Johannes Berg wrote:
> On Thu, 2019-06-06 at 20:41 +0200, Tom Psyborg wrote:
> >
> > Applying this patch instead of v1 broke WDS operation between two
> > Litebeam AC Gen2 devices:
>
> I'm confused, and not even sure which version I applied now.
>
> Manikanta, can you please check this and which version I have and which
> changes I might need?

I've tested (and left it running/ monitored) for two days without
any problems between QCA9984 (ZyXEL nbg6817/ ipq8065, WDS-AP, affected
before 33d915d9e8ce811d8958915ccd18d71a66c7c495 "{nl,mac}80211: allow
4addr AP operation on crypto controlled devices" went in) and AR9340
(TP-Link TL-WDR3600/ AR9344, WDS-Client, not affected by this issue),
both under current (~2 days old) OpenWrt master[1] (ipq806x/ ath79,
respectively). This patch is working fine and fixes the previous
problems with 4addr on ath10k (QCA9984).

Thank you a lot for looking into this!

Regards
	Stefan Lippers-Hollmann

=2D-
[1]	Loading modules backported from Linux version v4.19.32-0-g3a2156c839c7
	Backport generated by backports.git v4.19.32-1-0-g1c4f7569
	with this version of the patch applied, instead of v1 as
	currently present in OpenWrt/ master HEAD.
