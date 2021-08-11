Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C470D3E882C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 04:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhHKCsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 22:48:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28121 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhHKCsm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 22:48:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628650099; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=+Kv6LgcPVLZtB5+1QzvOr+dTmw7NVWtByFUNgUXIMe4=; b=coSvAy2Sfm2aoekubU0nA7M0/8nIyj5+StOy9AN5rszaFvZPRRVUPOt9OAULjHi6zBJAniJR
 M7ymAKFpb+AXE0vPpWor3K8jyvclQ3Sm4MSqLbEtsDPvOmqfngg0XCJ6Yop6/TGadOrb6k8S
 sPkHZ2IgqybjwH3F7BoeCgyKEZw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61133a717ee604097730b972 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Aug 2021 02:48:17
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38CAFC43217; Wed, 11 Aug 2021 02:48:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from MSINADA (unknown [98.45.135.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26B78C4338A;
        Wed, 11 Aug 2021 02:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26B78C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   "Muna Sinada" <msinada@codeaurora.org>
To:     "'Johannes Berg'" <johannes@sipsolutions.net>
Cc:     <linux-wireless@vger.kernel.org>
References: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>   <1607468044-31789-2-git-send-email-msinada@codeaurora.org> <0f45b43c5a2dd4d0d2839487540611994ec10feb.camel@sipsolutions.net>
In-Reply-To: <0f45b43c5a2dd4d0d2839487540611994ec10feb.camel@sipsolutions.net>
Subject: RE: [PATCH 2/2] mac80211: Handling driver updated MU-EDCA params
Date:   Tue, 10 Aug 2021 19:48:15 -0700
Message-ID: <000801d78e5b$55d46530$017d2f90$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEnZdCLZBNC6EG9F8ZPYUSPl+pHHAHggUnZAb6IkuCssPBL0A==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

I saw on your review comment that this wrapper is not needed. I wanted =
to confirm with you if it would be ok to call a cfg80211 API from a =
mac80211 based driver, since that is what would be done if this wrapper =
is removed. Additionally, another reason I have this wrapper is so I can =
place a tracepoint. What are your thoughts about this?

Thank you,
Muna =20

-----Original Message-----
From: Johannes Berg <johannes@sipsolutions.net>=20
Sent: Friday, February 12, 2021 12:49 AM
To: Muna Sinada <msinada@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] mac80211: Handling driver updated MU-EDCA =
params


> +void ieee80211_update_muedca_params(struct ieee80211_hw *hw,
> +				    struct ieee80211_mu_edca_param_set
> +				    *params, gfp_t gfp)
> +{
> +	struct ieee80211_local *local =3D hw_to_local(hw);
> +
> +	trace_api_update_muedca_params(local, params);
> +
> +	cfg80211_update_muedca_params_event(local->hw.wiphy, params, gfp); } =

> +EXPORT_SYMBOL(ieee80211_update_muedca_params);
>=20

I see no reason to have this trivial wrapper.

johannes


