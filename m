Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B53109B2E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfKZJXF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 04:23:05 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:59502
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbfKZJXE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 04:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574760183;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=7JpzEUgPOKikbM97IChytjtM3nmMVXbRuF7hhQqzTtk=;
        b=YA/tyK82LHumSpEpCFWDLmOaetKqnkbnaoObQiDDyPIhPmZHbgvxVq1DMkIXnAE4
        kEO/lJfbHF38htcLXE3krmVK1if+JNbWEHnIK/X/zoiggYu3518Vls3ZlVD5sVnEZNh
        vZThe+S2zzGhqk6Pnsopfg0xZs/PEPnKvr3NOc2c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574760183;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=7JpzEUgPOKikbM97IChytjtM3nmMVXbRuF7hhQqzTtk=;
        b=BjtA1MQ71QM0IztHwb5Cbc2NPlfve8mrpRE2TuhZlda6NxqcB2M9zWxfLGuvZQqY
        GU8lLmbQ59QADwawv/S4Mh+eWq+bMkZ02Ps14wFWmb00QaDi3wVKekOMpqQCq+XhhJT
        Z0XmlUg5uaUE6uH1BEp3hP8iWoYNDWHM3P8HfzM8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D393C447BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mt76: Off by one in mt76_calc_rx_airtime()
References: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
        <87v9r7ysg0.fsf@toke.dk> <20191126091150.GA1759@kadam>
        <87h82ryp45.fsf@toke.dk>
Date:   Tue, 26 Nov 2019 09:23:03 +0000
In-Reply-To: <87h82ryp45.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Tue, 26 Nov 2019 10:16:10 +0100")
Message-ID: <0101016ea705771d-08dd7963-f8f7-447a-a0fb-4ad9093ec24d-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SES-Outgoing: 2019.11.26-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Dan Carpenter <dan.carpenter@oracle.com> writes:
>
>> On Tue, Nov 26, 2019 at 09:04:15AM +0100, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>>> Dan Carpenter <dan.carpenter@oracle.com> writes:
>>>=20
>>> > @@ -242,7 +242,7 @@ u32 mt76_calc_rx_airtime(struct mt76_dev *dev, st=
ruct mt76_rx_status *status,
>>> >  			return 0;
>>> >=20=20
>>> >  		sband =3D dev->hw->wiphy->bands[status->band];
>>> > -		if (!sband || status->rate_idx > sband->n_bitrates)
>>> > +		if (!sband || status->rate_idx >=3D sband->n_bitrates)
>>> >  			return 0;
>>> >=20=20
>>> >  		rate =3D &sband->bitrates[status->rate_idx];
>>>=20
>>> This code has recently been ported to mac80211 (net/mac80211/airtime.c).
>>> It seems that the bug is also present there; care to send a patch for
>>> that as well? :)
>>
>> Oh.  Thanks for pointing that out.  I actually saw the static checker
>> warning for that and ignored it thinking that it was the same code.
>> :P
>
> Well, it's copy-pasted from the same code ;)
>
> The plan is to get rid of the version inside mt76; was waiting for the
> trees to converge, though, so I guess after the merge window?

Yup, as I'm not taking anything to w-d-next until -rc1 is released.

--=20
Kalle Valo
