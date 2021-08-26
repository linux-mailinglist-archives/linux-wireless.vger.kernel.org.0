Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC633F90DB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 01:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbhHZXKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 19:10:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56263 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhHZXKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 19:10:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630019356; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=I41eCj0sLM63u1kyZlw2m9s5ALmqDiCr95i9ng5iwmY=; b=cUy11YSLmlSgAOhc8tESGJtXEQFDjoIoHO+T09VPSUSkSNUopTU0zJcgXoOkYZdLRWe0eKbk
 mGME53n3sc5RIoI5T+9XOnMs3hXYFtUlDpK/7rYkfAIJ6nNs9AVU5eqMbtwuOwbkRE0+AsCr
 5uDuYCEi06TbmLWia7LjoCmxghc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61281ef4fc1f4cb692176131 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 23:08:35
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60DF8C4360C; Thu, 26 Aug 2021 23:08:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from MSINADA (unknown [98.45.135.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7BC1C43460;
        Thu, 26 Aug 2021 23:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A7BC1C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   "Muna Sinada" <msinada@codeaurora.org>
To:     "'Johannes Berg'" <johannes@sipsolutions.net>
Cc:     <linux-wireless@vger.kernel.org>
References: <1627587701-13134-1-git-send-email-msinada@codeaurora.org> <6d85542f47955cdac0137c72b0de04e5c0fe0799.camel@sipsolutions.net>
In-Reply-To: <6d85542f47955cdac0137c72b0de04e5c0fe0799.camel@sipsolutions.net>
Subject: RE: [PATCH v2] nl80211: Add HE UL MU fixed rate setting
Date:   Thu, 26 Aug 2021 16:08:34 -0700
Message-ID: <001601d79acf$4bb85b80$e3291280$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIuihlKfyOVzPIK6v2sETi2yH8wDgHs4TVrqskX2AA=
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

I agree that it is odd to combine this new attribute with the existing =
parameters. I will be removing "he_ul_mcs" out of cfg80211_bitrate_mask =
and passing it as a separate attribute in next version.

Thank you,
Muna=20

-----Original Message-----
From: Johannes Berg <johannes@sipsolutions.net>=20
Sent: Tuesday, August 17, 2021 6:49 AM
To: Muna Sinada <msinada@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] nl80211: Add HE UL MU fixed rate setting

Hi,

On Thu, 2021-07-29 at 12:41 -0700, Muna Sinada wrote:
> This patch adds nl80211 definitions, policies and parsing code=20
> required to pass HE UL MU fixed rate settings.
>=20

I don't understand how this is sufficient?

>  		enum nl80211_txrate_gi gi;
>  		enum nl80211_he_gi he_gi;
>  		enum nl80211_he_ltf he_ltf;

Previously, for HE rates, we had configurations for:
 * HE MCS
 * HE guard interval
 * HE LTF

I guess I can sort of follow that uplink traffic is a bit different and =
not already configured by the setting for rate control we have today, =
but why does it not need all these parameters?

Also, why is this not a per-station parameter? OK, maybe we don't really =
want it to be a per-station parameter, or maybe the firmware/algorithm =
that's selecting things there can't deal with that, but it feels odd to =
combine it with the "rate control fixed rate" parameters you have here, =
and do that without even any explanation of how this is supposed to =
work.

This is going to need some work.

johannes


