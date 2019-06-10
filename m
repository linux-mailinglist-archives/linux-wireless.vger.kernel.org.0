Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5423AF4C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbfFJHGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 03:06:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfFJHGe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 03:06:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E03460734; Mon, 10 Jun 2019 07:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560150394;
        bh=zFMMXppuJQIvBzZR76Pbx9mhI24KZFTafp86Ids2NrM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=f1g8KDUrw2ppMMsA3drFFSbicyfKA9N/q957uhsUV7KgEDS4OSlQCQ+zDaKbqtaVX
         CjxBwa7Kqo2eguPTJIKjN34ZYVWkymyEYpxqRYs1RC6A+1Q0JgJ0VZXsZ0kFwXRy23
         iPMzIj3scSwbJKNFsslOGjELPdWnX/UBvHm4wsOY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7FCC60716;
        Mon, 10 Jun 2019 07:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560150393;
        bh=zFMMXppuJQIvBzZR76Pbx9mhI24KZFTafp86Ids2NrM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pGo1uPnvbvz5cQhYrgzAFIs2fdoRbpbMqNZ6jr3s10o0a/eY/9SrykUdcQelHih4v
         iFF9pmI7Jmec0jL5E0/uWS/bH9X62QH+4CIV+0aPehGeCBknu16+2FttF4DUSnolRX
         iwp7QBsT05G+1e7EyPV8bIQWdEtNfpblMGzGw9Fs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7FCC60716
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: fix enum compare splat
References: <20190608144947.744-1-chunkeey@gmail.com>
Date:   Mon, 10 Jun 2019 10:06:30 +0300
In-Reply-To: <20190608144947.744-1-chunkeey@gmail.com> (Christian Lamparter's
        message of "Sat, 8 Jun 2019 16:49:45 +0200")
Message-ID: <87pnnlncll.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> This patch fixes a noisy warning triggered by -Wenum-compare
>
> |main.c:1390:31: warning: comparison between =E2=80=98enum nl80211_ac=E2=
=80=99
> |	and =E2=80=98enum ar9170_txq=E2=80=99 [-Wenum-compare]
> |  BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
> |                               ^
> | [...]
>
> This is a little bit unfortunate, since the number of queues
> (hence NL80211_NUM_ACS) is a constant based on the IEEE 802.11
> (much like IEEE80211_NUM_ACS) and __AR9170_NUM_TXQ is more or
> less defined by the AR9170 hardware.

Is the warning enabled by default? TBH I'm not seeing how useful this
warning is for kernel development.

> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -1387,7 +1387,7 @@ static int carl9170_op_conf_tx(struct ieee80211_hw =
*hw,
>  	int ret;
>=20=20
>  	BUILD_BUG_ON(ARRAY_SIZE(ar9170_qmap) !=3D __AR9170_NUM_TXQ);
> -	BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
> +	BUILD_BUG_ON((size_t)NL80211_NUM_ACS > (size_t)__AR9170_NUM_TXQ);

IMHO this just makes the code worse. Does it make sense to workaround
(stupid) compiler warnings like this?

--=20
Kalle Valo
