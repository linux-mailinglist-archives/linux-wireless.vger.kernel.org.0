Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4446F228
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbhLIRj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:39:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56908 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhLIRjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:39:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55FECB825D3
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8CDC004DD;
        Thu,  9 Dec 2021 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071350;
        bh=yCIcOrylHhJkQEjyCwdGDKK55E0S8HrOQym/CUh4qPI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oeWsgeHKXK8Ar9oVz6wkEycEH3fphtynsGn/KiiGHJvz9AaNLmY0J4VV1qaDz7DnO
         yyPFbDpVTrdU/hmLCYmUybZnuHa4QhnAS5Y3WrzJcDHxBZZEgpTYw7U2W07gIWBO6U
         NQdKbFkgr+UtmfHcDiRnlZgFQ4yALkW14lFOt/Yhos5zEPrOKqAmCEBOo9egmmGgji
         qZ1BODy7hFbqninrO325EGnAMOebIAKXrZHTMVnGsLpR5UN7df7Me9YNBwaghvu2VE
         BIP7mZ31XN5/QR+vEnc6CGcQsVKT3T3elmeKOY2w09SHEnlp1yOtBqelY9a5gDuCuO
         HDofRYK9ECYJg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 09/15] ath11k: add parse of transmit power envelope element
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
        <20211026111913.7346-10-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 19:35:47 +0200
In-Reply-To: <20211026111913.7346-10-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:19:07 -0400")
Message-ID: <87y24tvfyk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> The transmit power envelope element has some fields for power, ath11k
> should parse it according to IEEE Std 802.11ax=E2=84=A2=E2=80=902021.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICO=
NZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> +static u8 ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_d=
ef)
> +{
> +	u8 num_pwr_levels;
> +
> +	if (chan_def->chan->flags & IEEE80211_CHAN_PSD) {
> +		switch (chan_def->width) {
> +		case NL80211_CHAN_WIDTH_20:
> +			num_pwr_levels =3D 1;
> +			break;
> +		case NL80211_CHAN_WIDTH_40:
> +			num_pwr_levels =3D 2;
> +			break;
> +		case NL80211_CHAN_WIDTH_80:
> +			num_pwr_levels =3D 4;
> +			break;
> +		case NL80211_CHAN_WIDTH_80P80:
> +		case NL80211_CHAN_WIDTH_160:
> +			num_pwr_levels =3D 8;
> +			break;
> +		default:
> +			return 1;
> +		}
> +	} else {
> +		switch (chan_def->width) {
> +		case NL80211_CHAN_WIDTH_20:
> +			num_pwr_levels =3D 1;
> +			break;
> +		case NL80211_CHAN_WIDTH_40:
> +			num_pwr_levels =3D 2;
> +			break;
> +		case NL80211_CHAN_WIDTH_80:
> +			num_pwr_levels =3D 3;
> +			break;
> +		case NL80211_CHAN_WIDTH_80P80:
> +		case NL80211_CHAN_WIDTH_160:
> +			num_pwr_levels =3D 4;
> +			break;
> +		default:
> +			return 1;
> +		}
> +	}
> +
> +	return num_pwr_levels;
> +}

num_pwr_levels variable is not really creating any extra value, it's
clearner to directly use 'return' on every case.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
