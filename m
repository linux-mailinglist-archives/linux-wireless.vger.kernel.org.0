Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D340E363
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbhIPQrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:47:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48169 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242976AbhIPQp1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:45:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631810647; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=AD7/WOZbNVlUqmpqDXVRpA7Q47uAHSlcsJZ2CWxebRk=; b=rqoXL62AzQcurdDpkChZA4WqcDnzdz2ocWicYYwaffxzTIEEhLtgDE8wGApTFDQbSBGh1r2w
 5heP3YfKAmfRpnZVx8OURiguyybJQNGwTiL3iGzSJOLQGd4rdDQe57gB0XbR3YSa4GWSDakK
 liRIvL6FaJVi5j4F3LoJujTi34I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61437450648642cc1cca6fb4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 16:44:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34DA9C43165; Thu, 16 Sep 2021 16:44:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F81DC43617;
        Thu, 16 Sep 2021 16:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8F81DC43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: Re: [PATCH 1/3] ieee80211: Add new A-MPDU factor macro for HE 6 GHz peer caps
References: <20210913175510.193005-1-jouni@codeaurora.org>
        <87wnngy2ro.fsf@codeaurora.org>
        <a3df1f072600e79bac0a247b905fec8b946f0729.camel@sipsolutions.net>
Date:   Thu, 16 Sep 2021 19:43:55 +0300
In-Reply-To: <a3df1f072600e79bac0a247b905fec8b946f0729.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 16 Sep 2021 18:02:14 +0200")
Message-ID: <87fsu4xygk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2021-09-16 at 18:10 +0300, Kalle Valo wrote:
>> Jouni Malinen <jouni@codeaurora.org> writes:
>>=20
>> > From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
>> >=20
>> > Add IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR as per IEEE Std 802.11ax-2021,
>> > 9.4.2.263 to use for peer max A-MPDU factor in 6 GHz band.
>> >=20
>> > Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
>> > Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> > ---
>> > =C2=A0include/linux/ieee80211.h | 1 +
>> > =C2=A01 file changed, 1 insertion(+)
>> >=20
>> > diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
>> > index 694264503119..a1a7eda35cb5 100644
>> > --- a/include/linux/ieee80211.h
>> > +++ b/include/linux/ieee80211.h
>> > @@ -2084,6 +2084,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_v=
ht_cap *cap,
>> > =C2=A0
>> >=20
>> >=20
>> >=20
>> > =C2=A0#define IEEE80211_HE_VHT_MAX_AMPDU_FACTOR	20
>> > =C2=A0#define IEEE80211_HE_HT_MAX_AMPDU_FACTOR	16
>> > +#define IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR	13
>>=20
>> Johannes, can I take this via my ath tree? I think that's the easiest as
>> the ath11k patches depend on this.
>>=20
> Sure, looks fine.
>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Thanks! I assigned this to me on patchwork.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
