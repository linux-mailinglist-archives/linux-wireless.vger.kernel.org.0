Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296C1BB2F0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfIWLmc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 07:42:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfIWLmb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 07:42:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BE766021C; Mon, 23 Sep 2019 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569238950;
        bh=lUtYUiOh943WW+54GHZhamd2qjJPMz0XuUx4GDR/87k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ioK5vtxuDUaNLRCy8cjzfGJSNqbAq4gb1MelzZVSF5bzHSmaT305wz2d8v+SFyjyB
         LdklPqawsCXURg161R5pTOIz5PjpSs6Bqm4VUEl8ftK3V6JRh36E943vI/QJVePSAP
         MgND72TFG+eLuw7V3xeSG1pnJEr5jBPj5LadCPx4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6CCA60265;
        Mon, 23 Sep 2019 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569238950;
        bh=lUtYUiOh943WW+54GHZhamd2qjJPMz0XuUx4GDR/87k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ioK5vtxuDUaNLRCy8cjzfGJSNqbAq4gb1MelzZVSF5bzHSmaT305wz2d8v+SFyjyB
         LdklPqawsCXURg161R5pTOIz5PjpSs6Bqm4VUEl8ftK3V6JRh36E943vI/QJVePSAP
         MgND72TFG+eLuw7V3xeSG1pnJEr5jBPj5LadCPx4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6CCA60265
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
        <1568639388-27291-2-git-send-email-yiboz@codeaurora.org>
        <87pnjyiq7o.fsf@toke.dk>
        <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org>
        <87sgothmpy.fsf@toke.dk>
        <8cdece5c030fd95817fb099021c38613@codeaurora.org>
        <87tv98fu6l.fsf@toke.dk>
        <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org>
        <8736gre3bm.fsf@toke.dk>
        <198124204167325252fcfcd65e3f2733@codeaurora.org>
        <87ftkp7uuz.fsf@toke.dk>
        <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org>
        <877e617qg2.fsf@toke.dk>
        <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org>
        <874l157nrt.fsf@toke.dk>
        <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org>
        <87lfuf5ly2.fsf@toke.dk>
Date:   Mon, 23 Sep 2019 14:42:26 +0300
In-Reply-To: <87lfuf5ly2.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Mon, 23 Sep 2019 12:47:01 +0200")
Message-ID: <87r2476xy5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Yibo Zhao <yiboz@codeaurora.org> writes:
>
>> On 2019-09-21 22:00, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>=20
>>>> On 2019-09-21 21:02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>=20
>>>>>> On 2019-09-21 19:27, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>=20
>>>>>>>> On 2019-09-20 17:15, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>=20
>>>>>>>>>> On 2019-09-19 18:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>=20
>>>>>>>>>>>> On 2019-09-18 19:23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> On 2019-09-18 05:10, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:

Guys, PLEASE please consider us poor maintainers drowning in email and
edit your quotes :) This style of discussion makes patchwork unusable:

https://patchwork.kernel.org/patch/11147019/

--=20
Kalle Valo
