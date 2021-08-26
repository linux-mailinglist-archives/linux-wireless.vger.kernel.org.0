Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F73F90E4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhHZXTR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 19:19:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39430 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234555AbhHZXTL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 19:19:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630019903; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=td6+lKliZWnn37e5EfNvN74QchLXCgx0S8KN6MlSPAI=; b=tC86QvNimOfUZ3+3AQeHQSJKj0XrFElg4tw8O5UgLQOBRueBLhn98p7ifHmTYSL63VPmJPdo
 Ho/kkq2jUIJRAte+mdQaA4V1iNVnaOG800/QIF1X5Yo8XjwcgP0wOmYINhbSL3ClIpgenJa6
 Hv8YKWTE5xKzF8dIYBiuXAkrpyY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6128213e4d644b7d1c7b25c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 23:18:22
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64DA5C4360C; Thu, 26 Aug 2021 23:18:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from MSINADA (unknown [98.45.135.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4CD2C4338F;
        Thu, 26 Aug 2021 23:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C4CD2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   "Muna Sinada" <msinada@codeaurora.org>
To:     "'Johannes Berg'" <johannes@sipsolutions.net>
Cc:     <linux-wireless@vger.kernel.org>
References: <1628660743-24413-1-git-send-email-msinada@codeaurora.org> <ec979481036ad198d4c42d2756caf66fd3496bbc.camel@sipsolutions.net>
In-Reply-To: <ec979481036ad198d4c42d2756caf66fd3496bbc.camel@sipsolutions.net>
Subject: RE: [PATCH v2] cfg80211: Handle driver updated MU-EDCA params
Date:   Thu, 26 Aug 2021 16:18:21 -0700
Message-ID: <001801d79ad0$a9a92a70$fcfb7f50$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQKPi0h8Y3QBEVBPnfPFaPv7V44okgHUa8dSqgfksbA=
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

The firmware algorithm determines better MU-EDCA parameters based on =
channel conditions. The updated parameters are used and reported to =
Hostapd to reflect in AP beacons. These dynamic parameter updates are =
offloaded to firmware for better user experience, and this would also =
mean that there are hardly any details on specifically how these =
parameters are determined but we know that the updated parameters need =
to be reflected in future beacons. This feature is meant for AP mode, =
and it is a ath11k feature, thus no spec references.

Thank you,
Muna

-----Original Message-----
From: Johannes Berg <johannes@sipsolutions.net>=20
Sent: Tuesday, August 17, 2021 6:54 AM
To: Muna Sinada <msinada@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] cfg80211: Handle driver updated MU-EDCA params

On Tue, 2021-08-10 at 22:45 -0700, Muna Sinada wrote:
> Add necessary functions and attributes to receive updated MU-EDCA=20
> parameters from driver and send to user space, where management frame=20
> are updated to reflect latest parameters.
>=20

On second thought - this really could use some more explanation?

Why are MU-EDCA parameters determined by the driver? What does this =
actually do? Is it meant for AP mode, or client mode? Any spec =
references?

Mac80211 parses this coming from the AP, so probably this is meant for =
AP mode, but why? Why wouldn't hostapd determine the correct parameters?

etc.

johannes


